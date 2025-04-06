// Sample data
let distributors = JSON.parse(localStorage.getItem('distributors')) || [
    {
        id: 1,
        companyName: "Vidrios Express",
        contactName: "Juan Pérez",
        email: "juan@vidriosexpress.com",
        phone: "3101234567",
        address: "Calle 123",
        products: ["polarizado", "vidrios"],
        lastPurchase: "2023-11-25",
        notes: "Distribuidor principal de vidrios"
    }
];

// Save initial data if none exists
if (!localStorage.getItem('distributors')) {
    localStorage.setItem('distributors', JSON.stringify(distributors));
}

function createActionButtons(id) {
    return `
        <button class="action-btn edit" onclick="editItem(${id})">
            <span class="material-icons">edit</span>
        </button>
        <button class="action-btn products" onclick="manageProducts(${id})">
            <span class="material-icons">inventory_2</span>
        </button>
        <button class="action-btn delete" onclick="deleteItem(${id})">
            <span class="material-icons">delete</span>
        </button>
    `;
}

function updateTable() {
    const tbody = document.querySelector('#main-table tbody');
    tbody.innerHTML = '';
    
    distributors.forEach(dist => {
        const row = document.createElement('tr');
        row.innerHTML = `
            <td>${dist.id}</td>
            <td>${dist.companyName}</td>
            <td>${dist.contactName}</td>
            <td>${dist.email}</td>
            <td>${dist.phone}</td>
            <td>${dist.products.join(', ')}</td>
            <td>${dist.lastPurchase || '-'}</td>
            <td>${createActionButtons(dist.id)}</td>
        `;
        tbody.appendChild(row);
    });
}

function saveDistributor() {
    const distributor = {
        id: Date.now(),
        companyName: document.getElementById('company-name').value,
        contactName: document.getElementById('contact-name').value,
        email: document.getElementById('email').value,
        phone: document.getElementById('phone').value,
        address: document.getElementById('address').value,
        products: Array.from(document.getElementById('products').selectedOptions).map(option => option.value),
        notes: document.getElementById('notes').value
    };

    if (!distributor.companyName || !distributor.contactName || !distributor.email) {
        Swal.fire('Error', 'Por favor complete los campos requeridos', 'error');
        return;
    }

    distributors.push(distributor);
    localStorage.setItem('distributors', JSON.stringify(distributors));
    updateTable();
    closeModal();
    Swal.fire('¡Éxito!', 'Distribuidor guardado correctamente', 'success');
}

// Event Listeners
document.getElementById('save-btn').addEventListener('click', saveDistributor);
document.addEventListener('DOMContentLoaded', updateTable);