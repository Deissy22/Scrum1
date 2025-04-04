function showHistory(clientId) {
    const historyModal = document.getElementById('historyModal');
    const clientName = document.getElementById('clientName');
    const clientContact = document.getElementById('clientContact');

    // Obtener datos del cliente
    const client = clients.find(c => c.id === clientId);
    if (client) {
        clientName.textContent = client.name;
        clientContact.textContent = `Tel: ${client.phone} | Email: ${client.email}`;
        historyModal.style.display = 'block';
        loadHistoryData(clientId);
    }
}

function loadHistoryData(clientId) {
    // Cargar datos de compras
    const purchasesTable = document.querySelector('#purchasesHistory tbody');
    // Aquí cargarías los datos reales de tu base de datos
    purchasesTable.innerHTML = `
        <tr>
            <td>2023-11-20</td>
            <td>Polarizado Completo</td>
            <td>1</td>
            <td>$150,000</td>
        </tr>
    `;

    // Cargar datos de servicios
    const servicesTable = document.querySelector('#servicesHistory tbody');
    servicesTable.innerHTML = `
        <tr>
            <td>2023-11-15</td>
            <td>Mantenimiento</td>
            <td>Completado</td>
            <td>$80,000</td>
        </tr>
    `;
}

// Manejador de pestañas
document.querySelectorAll('.tab-btn').forEach(button => {
    button.addEventListener('click', () => {
        document.querySelectorAll('.tab-btn').forEach(btn => btn.classList.remove('active'));
        button.classList.add('active');

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