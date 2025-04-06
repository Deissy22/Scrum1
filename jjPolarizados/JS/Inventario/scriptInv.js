// Add this at the beginning of your script
let products = JSON.parse(localStorage.getItem('products')) || [
    {
        id: 1,
        name: "Polarizado Premium",
        reference: "POL-001",
        category: "Vidrios",
        basePrice: 50000,
        salePrice: 75000,
        quantity: 20,
        entryDate: "2023-11-25"
    }
];

// Save initial products if none exist
if (!localStorage.getItem('products')) {
    localStorage.setItem('products', JSON.stringify(products));
}

// Add this function to create action buttons
function createActionButtons(id) {
    return `
        <button class="action-btn edit" onclick="editItem(${id})">
            <span class="material-icons">edit</span>
        </button>
        <button class="action-btn review" onclick="reviewInventory(${id})">
            <span class="material-icons">fact_check</span>
        </button>
        <button class="action-btn delete" onclick="deleteItem(${id})">
            <span class="material-icons">delete</span>
        </button>
    `;
}

// Add the review function
function reviewInventory(id) {
    const product = products.find(p => p.id === id);
    if (!product) return;

    document.getElementById('product-review-name').value = product.name;
    document.getElementById('expected-quantity').value = product.quantity;
    document.getElementById('review-date').valueAsDate = new Date();
    
    const reviewModal = document.getElementById('reviewModal');
    reviewModal.style.display = 'flex';

    // Calculate discrepancy on input change
    document.getElementById('actual-quantity').addEventListener('input', (e) => {
        const actualQty = parseInt(e.target.value) || 0;
        const expectedQty = parseInt(product.quantity) || 0;
        const discrepancy = actualQty - expectedQty;
        document.getElementById('quantity-discrepancy').value = discrepancy;
    });
}

// Add event listeners for the review modal
document.getElementById('review-save-btn').addEventListener('click', () => {
    const productName = document.getElementById('product-review-name').value;
    const product = products.find(p => p.name === productName);
    
    if (!product) return;

    const reviewData = {
        productId: product.id,
        actualQuantity: parseInt(document.getElementById('actual-quantity').value),
        expectedQuantity: parseInt(document.getElementById('expected-quantity').value),
        discrepancy: parseInt(document.getElementById('quantity-discrepancy').value),
        notes: document.getElementById('review-notes').value,
        date: document.getElementById('review-date').value
    };

    // Update product quantity
    product.quantity = reviewData.actualQuantity;
    localStorage.setItem('products', JSON.stringify(products));
    
    // Save review history
    const reviews = JSON.parse(localStorage.getItem('inventoryReviews') || '[]');
    reviews.push(reviewData);
    localStorage.setItem('inventoryReviews', JSON.stringify(reviews));

    updateTable();
    document.getElementById('reviewModal').style.display = 'none';
    Swal.fire('¡Éxito!', 'Revisión guardada correctamente', 'success');
});

document.getElementById('review-cancel-btn').addEventListener('click', () => {
    document.getElementById('reviewModal').style.display = 'none';
});

// Add this function to get the stock color
function getStockColor(quantity) {
    if (quantity <= 5) {
        return 'stock-critical';
    } else if (quantity <= 10) {
        return 'stock-warning';
    } else {
        return 'stock-good';
    }
}

// Update the table function to include stock colors
function updateTable() {
    const tbody = document.querySelector('#main-table tbody');
    tbody.innerHTML = '';
    
    products.forEach(product => {
        const row = document.createElement('tr');
        const stockClass = getStockColor(product.quantity);
        row.innerHTML = `
            <td>${product.id}</td>
            <td>${product.name}</td>
            <td>${product.reference}</td>
            <td>${product.category}</td>
            <td>$${product.basePrice.toLocaleString()}</td>
            <td>$${product.salePrice.toLocaleString()}</td>
            <td class="${stockClass}">${product.quantity}</td>
            <td>${createActionButtons(product.id)}</td>
        `;
        tbody.appendChild(row);
    });
}

// Call updateTable when the page loads
document.addEventListener('DOMContentLoaded', updateTable);