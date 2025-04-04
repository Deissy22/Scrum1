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

// Add this function to handle inventory reviews
function reviewInventory(id) {
    const product = products.find(p => p.id === id);
    if (!product) return;

    document.getElementById('product-review-name').value = product.name;
    document.getElementById('actual-quantity').value = product.quantity;
    document.getElementById('review-date').valueAsDate = new Date();
    
    const reviewModal = document.getElementById('reviewModal');
    reviewModal.style.display = 'block';

    // Calculate discrepancy
    document.getElementById('actual-quantity').addEventListener('input', (e) => {
        const actualQty = parseInt(e.target.value) || 0;
        const expectedQty = parseInt(product.quantity) || 0;
        const discrepancy = actualQty - expectedQty;
        document.getElementById('quantity-discrepancy').value = discrepancy;
    });
}

// Save review
document.getElementById('review-save-btn').addEventListener('click', () => {
    const reviewData = {
        productId: currentProductId,
        actualQuantity: document.getElementById('actual-quantity').value,
        discrepancy: document.getElementById('quantity-discrepancy').value,
        notes: document.getElementById('review-notes').value,
        date: document.getElementById('review-date').value,
        reviewer: currentUser // Assuming you have this variable from your auth system
    };

    // Save to localStorage
    const reviews = JSON.parse(localStorage.getItem('inventoryReviews') || '[]');
    reviews.push(reviewData);
    localStorage.setItem('inventoryReviews', JSON.stringify(reviews));

    // Update product quantity if there's a discrepancy
    if (reviewData.discrepancy !== 0) {
        const products = JSON.parse(localStorage.getItem('products') || '[]');
        const product = products.find(p => p.id === reviewData.productId);
        if (product) {
            product.quantity = reviewData.actualQuantity;
            localStorage.setItem('products', JSON.stringify(products));
            updateTable(); // Refresh the table
        }
    }

    Swal.fire('¡Éxito!', 'Revisión guardada correctamente', 'success');
    document.getElementById('reviewModal').style.display = 'none';
});

// Cancel review
document.getElementById('review-cancel-btn').addEventListener('click', () => {
    document.getElementById('reviewModal').style.display = 'none';
});