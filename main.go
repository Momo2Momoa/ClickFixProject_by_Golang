// maing.go
package main

import (
	"database/sql"
	"encoding/json"
	"fmt"
	"html/template"
	"log"
	"net/http"

	_ "github.com/go-sql-driver/mysql"
	"github.com/gorilla/sessions"
	"golang.org/x/crypto/bcrypt"
)

var (
	// key must be 16, 24 or 32 bytes long (AES-128, AES-192 or AES-256)
	key   = []byte("super-secret-key")
	store = sessions.NewCookieStore(key)
)

type Case_Keyboard struct {
	ID      int    `json:"id"`
	Profile string `json:"case_material"`
}

type PCB struct {
	ID      int    `json:"id"`
	Percent string `json:"percent_layout"`
	Layout  string `json:"layout"`
}

type Plate struct {
	ID             int    `json:"id"`
	Plate_Material string `json:"plate_material"`
}

type Switches struct {
	ID          int    `json:"id"`
	Switch_Type string `json:"switch_type"`
}

type Stabilizers struct {
	ID               int    `json:"id"`
	Stabilizers_type string `json:"stab_type"`
}

type Keycap struct {
	ID      int    `json:"id"`
	Profile string `json:"profile"`
}

func main() {

	db, err := sql.Open("mysql", "root:@tcp(127.0.0.1:3306)/clickfix")
	if err != nil {
		log.Fatal(err)
	}
	defer db.Close()

	http.HandleFunc("/", indexHandler)
	http.HandleFunc("/logout", logoutHandler)
	http.HandleFunc("/index", indexHandler)
	http.HandleFunc("/settings", settingsHandler)

	http.HandleFunc("/signup", signUpHandler(db))
	http.HandleFunc("/update", updateHandler(db))
	http.HandleFunc("/delete", deleteHandler(db))
	http.HandleFunc("/login", loginHandler(db))

	http.HandleFunc("/case_keyboard", getCase(db))
	http.HandleFunc("/pcb", getPCB(db))
	http.HandleFunc("/plate", getPlate(db))
	http.HandleFunc("/switches", getSwitch(db))
	http.HandleFunc("/stabilizers", getStabilizers(db))
	http.HandleFunc("/keycap", getKeycap(db))

	http.Handle("/static/", http.StripPrefix("/static/", http.FileServer(http.Dir("static"))))

	fmt.Println("Server started on http://localhost:8080...")
	http.ListenAndServe(":8080", nil)
}

func indexHandler(w http.ResponseWriter, r *http.Request) {
	session, _ := store.Get(r, "session-name")
	authenticated := session.Values["authenticated"]

	var btnText string
	var btnLink string
	var memberName string
	var showSettings bool

	if authenticated == true {
		btnText = "Logout"
		btnLink = "/logout"

		memberName = session.Values["username"].(string)
		//authenticated = false
		showSettings = true
	} else {
		btnText = "Login"
		btnLink = "/login"
		memberName = "Guest"
		showSettings = false
	}

	data := map[string]interface{}{
		"ButtonText":   btnText,
		"ButtonLink":   btnLink,
		"MemberName":   memberName,
		"ShowSettings": showSettings,
	}

	tmpl, err := template.ParseFiles("templates/index.html")
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	tmpl.Execute(w, data)
}

func signUpHandler(db *sql.DB) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {

		if r.Method == http.MethodGet {
			tmpl, err := template.ParseFiles("templates/signup.html")
			if err != nil {
				http.Error(w, err.Error(), http.StatusInternalServerError)
				return
			}
			tmpl.Execute(w, nil)
			return
		}

		if r.Method == http.MethodPost {
			name := r.FormValue("name")
			username := r.FormValue("username")
			password := r.FormValue("password")
			email := r.FormValue("email")

			if name == "" || username == "" || password == "" || email == "" {
				http.Error(w, "Please fill out all fields", http.StatusBadRequest)
				return
			}

			hashedPassword, err := bcrypt.GenerateFromPassword([]byte(password), bcrypt.DefaultCost)
			if err != nil {
				http.Error(w, "Error hashing password", http.StatusInternalServerError)
				return
			}

			_, err = db.Exec("INSERT INTO users (name, username, password, email) VALUES (?, ?, ?, ?)", name, username, hashedPassword, email)
			if err != nil {
				log.Printf("Error executing query: %v", err)
				http.Error(w, "Error creating user", http.StatusInternalServerError)
				return
			}

			http.Redirect(w, r, "/login", http.StatusSeeOther)
		} else {
			http.Error(w, "Method not allowed", http.StatusMethodNotAllowed)
		}
	}
}

func loginHandler(db *sql.DB) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		if r.Method == http.MethodGet {
			tmpl, err := template.ParseFiles("templates/login.html")
			if err != nil {
				http.Error(w, err.Error(), http.StatusInternalServerError)
				return
			}
			tmpl.Execute(w, nil)
			return
		}

		if r.Method == http.MethodPost {
			username := r.FormValue("username")
			password := r.FormValue("password")

			var hashedPassword string
			var role string
			err := db.QueryRow("SELECT password ,role FROM users WHERE username = ?", username).Scan(&hashedPassword, &role)
			if err != nil {
				http.Error(w, "Invalid username or password", http.StatusUnauthorized)
				fmt.Fprintln(w, "Invalid username or password")
				return
			}

			err = bcrypt.CompareHashAndPassword([]byte(hashedPassword), []byte(password))
			if err != nil {
				http.Error(w, "Invalid username or password", http.StatusUnauthorized)
				fmt.Fprintln(w, "Invalid username or password")
				return
			}

			session, _ := store.Get(r, "session-name")
			session.Values["authenticated"] = true
			session.Values["username"] = username
			session.Values["role"] = role
			session.Save(r, w)

			w.Header().Set("Content-Type", "text/plain")
			fmt.Fprintln(w, "Welcome to ClickFix & Custom Lab")
		}
	}
}

func settingsHandler(w http.ResponseWriter, r *http.Request) {
	session, _ := store.Get(r, "session-name")
	authenticated := session.Values["authenticated"]

	var memberName string

	if authenticated == true {
		memberName = session.Values["username"].(string)
	} else {
		memberName = "Guest"
	}

	data := map[string]interface{}{
		"MemberName": memberName,
	}

	tmpl, err := template.ParseFiles("templates/settings.html")
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	tmpl.Execute(w, data)
}

func updateHandler(db *sql.DB) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {

		session, _ := store.Get(r, "session-name")
		memberName := session.Values["username"].(string)

		if r.Method != http.MethodPost {
			http.Error(w, "Method not allowed", http.StatusMethodNotAllowed)
			return
		}

		username := memberName
		name := r.FormValue("name")
		password := r.FormValue("password")

		if username == "" || name == "" || password == "" {
			http.Error(w, "Please fill out all fields", http.StatusBadRequest)
			return
		}

		hashedPassword, err := bcrypt.GenerateFromPassword([]byte(password), bcrypt.DefaultCost)
		if err != nil {
			http.Error(w, "Error hashing password", http.StatusInternalServerError)
			return
		}

		_, err = db.Exec("UPDATE users SET name = ?, password = ? WHERE username = ?", name, hashedPassword, username)
		if err != nil {
			log.Printf("Error executing query: %v", err)
			http.Error(w, "Error updating user", http.StatusInternalServerError)
			return
		}

		w.WriteHeader(http.StatusOK)
		fmt.Fprintln(w, "User updated successfully")
	}
}

func deleteHandler(db *sql.DB) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {

		session, _ := store.Get(r, "session-name")
		memberName := session.Values["username"].(string)

		if r.Method != http.MethodPost {
			http.Error(w, "Method not allowed", http.StatusMethodNotAllowed)
			return
		}

		username := memberName

		_, err := db.Query("DELETE FROM users WHERE username = ?", username)
		if err != nil {
			log.Printf("Error executing query: %v", err)
			http.Error(w, "Error deleting user", http.StatusInternalServerError)
			return
		}

		// w.WriteHeader(http.StatusOK)
		// fmt.Fprintln(w, "User delete successfully")
		logoutHandler(w, r)
	}
}

func logoutHandler(w http.ResponseWriter, r *http.Request) {
	session, _ := store.Get(r, "session-name")
	session.Values["authenticated"] = false
	session.Values["username"] = ""
	session.Values["role"] = ""
	session.Save(r, w)

	http.Redirect(w, r, "/index", http.StatusSeeOther)
}

func WelcomePage(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "Welcome, you have successfully logged in!")
}

func getCase(db *sql.DB) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {

		rows, err := db.Query("SELECT case_id, case_material FROM case_custom")
		if err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}
		defer rows.Close()

		var materials []Case_Keyboard

		for rows.Next() {
			var material Case_Keyboard
			if err := rows.Scan(&material.ID, &material.Profile); err != nil {
				http.Error(w, err.Error(), http.StatusInternalServerError)
				return
			}
			materials = append(materials, material)
		}

		if err := rows.Err(); err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}
		w.Header().Set("Content-Type", "application/json")
		json.NewEncoder(w).Encode(materials)
	}
}

func getPCB(db *sql.DB) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {

		rows, err := db.Query("SELECT pcb_id, pcb_percent_layout, pcb_layout FROM pcb")
		if err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}
		defer rows.Close()

		var materials []PCB

		for rows.Next() {
			var material PCB
			if err := rows.Scan(&material.ID, &material.Percent, &material.Layout); err != nil {
				http.Error(w, err.Error(), http.StatusInternalServerError)
				return
			}
			materials = append(materials, material)
		}

		if err := rows.Err(); err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}
		w.Header().Set("Content-Type", "application/json")
		json.NewEncoder(w).Encode(materials)
	}
}

func getPlate(db *sql.DB) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {

		rows, err := db.Query("SELECT plate_id, plate_material FROM plate")
		if err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}
		defer rows.Close()

		var materials []Plate

		for rows.Next() {
			var material Plate
			if err := rows.Scan(&material.ID, &material.Plate_Material); err != nil {
				http.Error(w, err.Error(), http.StatusInternalServerError)
				return
			}
			materials = append(materials, material)
		}

		if err := rows.Err(); err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}
		w.Header().Set("Content-Type", "application/json")
		json.NewEncoder(w).Encode(materials)
	}
}

func getSwitch(db *sql.DB) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {

		rows, err := db.Query("SELECT switch_id, switch_type FROM switch")
		if err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}
		defer rows.Close()

		var materials []Switches

		for rows.Next() {
			var material Switches
			if err := rows.Scan(&material.ID, &material.Switch_Type); err != nil {
				http.Error(w, err.Error(), http.StatusInternalServerError)
				return
			}
			materials = append(materials, material)
		}

		if err := rows.Err(); err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}
		w.Header().Set("Content-Type", "application/json")
		json.NewEncoder(w).Encode(materials)
	}
}

func getStabilizers(db *sql.DB) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {

		rows, err := db.Query("SELECT stab_id, stab_type FROM stabilizers")
		if err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}
		defer rows.Close()

		var materials []Stabilizers

		for rows.Next() {
			var material Stabilizers
			if err := rows.Scan(&material.ID, &material.Stabilizers_type); err != nil {
				http.Error(w, err.Error(), http.StatusInternalServerError)
				return
			}
			materials = append(materials, material)
		}

		if err := rows.Err(); err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}
		w.Header().Set("Content-Type", "application/json")
		json.NewEncoder(w).Encode(materials)
	}
}

func getKeycap(db *sql.DB) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {

		rows, err := db.Query("SELECT keycap_id, keycap_profile FROM keycap")
		if err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}
		defer rows.Close()

		var materials []Keycap

		for rows.Next() {
			var material Keycap
			if err := rows.Scan(&material.ID, &material.Profile); err != nil {
				http.Error(w, err.Error(), http.StatusInternalServerError)
				return
			}
			materials = append(materials, material)
		}

		if err := rows.Err(); err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}
		w.Header().Set("Content-Type", "application/json")
		json.NewEncoder(w).Encode(materials)
	}
}
