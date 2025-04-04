
function generateProductCode() {
    let counter = parseInt(localStorage.getItem('productCounter') || '0');
    counter++;
    
    const formattedCounter = String(counter).padStart(4, '0');
    const productCode = `${formattedCounter}`;
    
    localStorage.setItem('productCounter', counter);
    document.getElementById('product-code').value = productCode;
}

function initializeModal() {
    const addBtn = document.getElementById('add-btn');
    const modal = document.getElementById('modal');
    const cancelBtn = document.getElementById('cancel-btn');
    const saveBtn = document.getElementById('save-btn');

    saveBtn.classList.add('card-button', 'primary');
    cancelBtn.classList.add('button-secondary');

    addBtn.addEventListener('click', () => {
        modal.style.display = 'flex';
        if(typeof onModalOpen === 'function') {
            onModalOpen();
        }
    });

    cancelBtn.addEventListener('click', closeModal);
    modal.addEventListener('click', (e) => {
        if (e.target === modal) closeModal();
    });
}

function closeModal() {
    const modal = document.getElementById('modal');
    modal.style.display = 'none';
    clearForm();
}

function clearForm() {
    const form = document.getElementById('modal-form');
    const inputs = form.querySelectorAll('input, select');
    inputs.forEach(input => {
        if(!input.hasAttribute('readonly')) {
            input.value = '';
        }
    });
}

document.addEventListener('DOMContentLoaded', () => {
    const userRole = sessionStorage.getItem('userRole');
    const welcomeMessage = document.getElementById('welcomeMessage');
    if (userRole && welcomeMessage) {
        welcomeMessage.innerHTML = `<span class="material-icons">person</span>Bienvenido, ${userRole}`;
    }
    
    initializeModal();
});

function calculateSalePrice() {
    const basePrice = document.getElementById('product-base-price').value;
    if (basePrice) {
        const priceWithIVA = basePrice * 1.19;
        const salePrice = priceWithIVA * 1.30;
        document.getElementById('product-sale-price').value = Math.round(salePrice);
    }
}