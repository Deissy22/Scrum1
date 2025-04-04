// Función para mostrar el historial
function showHistory(clientId) {
    const historyModal = document.getElementById('historyModal');
    // Aquí irá la lógica para cargar el historial del cliente
    historyModal.style.display = 'block';
}

// Manejador de pestañas
document.querySelectorAll('.tab-btn').forEach(button => {
    button.addEventListener('click', () => {
        // Remover active de todos los botones
        document.querySelectorAll('.tab-btn').forEach(btn => btn.classList.remove('active'));
        button.classList.add('active');

        // Mostrar el contenido correspondiente
        const tabId = button.dataset.tab;
        document.querySelectorAll('.history-table').forEach(table => {
            table.style.display = 'none';
        });
        document.getElementById(`${tabId}History`).style.display = 'block';
    });
});

// Cerrar historial
document.getElementById('closeHistory').addEventListener('click', () => {
    document.getElementById('historyModal').style.display = 'none';
});

function createActionButtons(id) {
    return `
        <button class="action-btn edit" onclick="editItem(${id})">
            <span class="material-icons">edit</span>
        </button>
        <button class="action-btn history" onclick="showHistory(${id})">
            <span class="material-icons">history</span>
        </button>
        <button class="action-btn delete" onclick="deleteItem(${id})">
            <span class="material-icons">delete</span>
        </button>
    `;
}

// Array para almacenar clientes
let clients = JSON.parse(localStorage.getItem('clients')) || [
    {
        id: 1,
        name: "Juan Pérez",
        phone: "3101234567",
        email: "juan@email.com",
        address: "Calle 123",
        totalPurchases: 2,
        lastVisit: "2023-11-20"
    },
    {
        id: 2,
        name: "María López",
        phone: "3157894561",
        email: "maria@email.com",
        address: "Carrera 45",
        totalPurchases: 1,
        lastVisit: "2023-11-15"
    }
];

// Guardar clientes iniciales si no existen
if (!localStorage.getItem('clients')) {
    localStorage.setItem('clients', JSON.stringify(clients));
}

// Función para guardar cliente
function saveClient() {
    const form = document.getElementById('modal-form');
    const client = {
        id: Date.now(),
        name: document.getElementById('name').value,
        phone: document.getElementById('phone').value,
        email: document.getElementById('email').value,
        address: document.getElementById('address').value,
        dob: document.getElementById('dob').value,
        notes: document.getElementById('notes').value,
        totalPurchases: 0,
        lastVisit: new Date().toISOString().split('T')[0]
    };

    if (!client.name || !client.phone || !client.email) {
        Swal.fire('Error', 'Por favor complete los campos requeridos', 'error');
        return;
    }

    clients.push(client);
    localStorage.setItem('clients', JSON.stringify(clients));
    updateTable();
    closeModal();
    Swal.fire('¡Éxito!', 'Cliente guardado correctamente', 'success');
}

// Función para actualizar la tabla
function updateTable() {
    const tbody = document.querySelector('#main-table tbody');
    tbody.innerHTML = '';
    
    clients.forEach(client => {
        const row = document.createElement('tr');
        row.innerHTML = `
            <td>${client.id}</td>
            <td>${client.name}</td>
            <td>${client.phone}</td>
            <td>${client.email}</td>
            <td>${client.address || '-'}</td>
            <td>${client.totalPurchases}</td>
            <td>${client.lastVisit}</td>
            <td>${createActionButtons(client.id)}</td>
        `;
        tbody.appendChild(row);
    });
}

// Agregar event listener al botón de guardar
document.getElementById('save-btn').addEventListener('click', (e) => {
    e.preventDefault();
    saveClient();
});

// Cargar la tabla al iniciar
document.addEventListener('DOMContentLoaded', () => {
    updateTable();
});