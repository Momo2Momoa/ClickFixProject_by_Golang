//scripts.js
function fetchMaterial(type) {
    let url = '';

    switch(type) {
        case 'case':
            url = '/case_keyboard';
            break;
        case 'pcb':
            url = '/pcb';
            break;
        case 'plate':
            url = '/plate';
            break;
        case 'switches':
            url = '/switches';
            break;
        case 'stabilizers':
            url = '/stabilizers';
            break;
        case 'keycap':
            url = '/keycap'
            break;
        default:
            console.error('Invalid type:', type);
            return;
    }

    fetch(url)
        .then(response => response.json())
        .then(data => {
            const groupMaterial = document.getElementById('groupMaterial');
            groupMaterial.innerHTML = '';

            data.forEach(material => {
                const materialDiv = document.createElement('div');
                
                if (type === 'case') {
                    materialDiv.textContent = `${material.case_material}`;
                } else if (type === 'pcb') {
                    materialDiv.textContent = `${material.percent_layout}% ${material.layout}`;
                } else if (type === 'plate') {
                    materialDiv.textContent = `${material.plate_material}`;
                } else if (type === 'switches') {
                    materialDiv.textContent = `${material.switch_type}`;
                } else if (type === 'stabilizers') {
                    materialDiv.textContent = `${material.stab_type}`;
                } else if (type === 'keycap') {
                    materialDiv.textContent = `${material.profile}`;
                }
                materialDiv.classList.add('material-item');
                groupMaterial.appendChild(materialDiv);
            });
        })
        .catch(error => {
            console.error('Error fetching materials:', error);
            alert('Unable to fetch materials. Please try again later.');
        });
}
