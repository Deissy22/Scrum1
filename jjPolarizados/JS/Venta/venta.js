// Sample sales data
let sales = JSON.parse(localStorage.getItem('sales')) || [
    {
        id: 1,
        clientName: "Carlos Rodríguez",
        product: "Polarizado Premium",
        reference: "POL-001",
        quantity: 2,
        unitPrice: 75000,
        total: 150000,
        date: "2023-11-25"
    },
    {
        id: 2,
        clientName: "María López",
        product: "Vidrio Templado",
        reference: "VID-003",
        quantity: 1,
        unitPrice: 120000,
        total: 120000,
        date: "2023-11-26"
    }
];

// Save initial sales if none exist
if (!localStorage.getItem('sales')) {
    localStorage.setItem('sales', JSON.stringify(sales));
}

function createActionButtons(id) {
    return `
        <button class="action-btn edit" onclick="editSale(${id})">
            <span class="material-icons">edit</span>
        </button>
        <button class="action-btn print" onclick="printInvoice(${id})">
            <span class="material-icons">receipt</span>
        </button>
        <button class="action-btn delete" onclick="deleteSale(${id})">
            <span class="material-icons">delete</span>
        </button>
    `;
}

function updateTable() {
    const tbody = document.querySelector('#main-table tbody');
    tbody.innerHTML = '';
    
    sales.forEach(sale => {
        const row = document.createElement('tr');
        row.innerHTML = `
            <td>${sale.id}</td>
            <td>${sale.clientName}</td>
            <td>${sale.product}</td>
            <td>${sale.reference}</td>
            <td>${sale.quantity}</td>
            <td>$${sale.total.toLocaleString()}</td>
            <td>${sale.date}</td>
            <td>${createActionButtons(sale.id)}</td>
        `;
        tbody.appendChild(row);
    });
}

function saveSale() {
    const sale = {
        id: Date.now(),
        clientName: document.getElementById('client-input').value,
        product: document.getElementById('product-select').value,
        reference: document.getElementById('reference').value,
        quantity: parseInt(document.getElementById('quantity').value),
        unitPrice: 75000, // This would normally come from the product data
        total: parseInt(document.getElementById('quantity').value) * 75000,
        date: document.getElementById('date').value || new Date().toISOString().split('T')[0]
    };

    if (!sale.clientName || !sale.product || !sale.quantity) {
        Swal.fire('Error', 'Por favor complete todos los campos requeridos', 'error');
        return;
    }

    sales.push(sale);
    localStorage.setItem('sales', JSON.stringify(sales));
    updateTable();
    closeModal();
    Swal.fire('¡Éxito!', 'Venta registrada correctamente', 'success');
}

function editSale(id) {
    const sale = sales.find(s => s.id === id);
    if (!sale) return;

    document.getElementById('client-input').value = sale.clientName;
    document.getElementById('product-select').value = sale.product;
    document.getElementById('reference').value = sale.reference;
    document.getElementById('quantity').value = sale.quantity;
    document.getElementById('date').value = sale.date;

    document.getElementById('modal-title').textContent = 'Editar Venta';
    document.getElementById('modal').style.display = 'flex';
}

function deleteSale(id) {
    Swal.fire({
        title: '¿Está seguro?',
        text: "Esta acción no se puede deshacer",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#83292a',
        cancelButtonColor: '#6c757d',
        confirmButtonText: 'Sí, eliminar',
        cancelButtonText: 'Cancelar'
    }).then((result) => {
        if (result.isConfirmed) {
            sales = sales.filter(sale => sale.id !== id);
            localStorage.setItem('sales', JSON.stringify(sales));
            updateTable();
            Swal.fire('Eliminado', 'La venta ha sido eliminada', 'success');
        }
    });
}

// Event Listeners
document.getElementById('save-btn').addEventListener('click', saveSale);
document.addEventListener('DOMContentLoaded', () => {
    updateTable();
    // Populate product select with sample data
    const productSelect = document.getElementById('product-select');
    const products = ['Polarizado Premium', 'Vidrio Templado', 'Polarizado Básico'];
    products.forEach(product => {
        const option = document.createElement('option');
        option.value = product;
        option.textContent = product;
        productSelect.appendChild(option);
    });
});