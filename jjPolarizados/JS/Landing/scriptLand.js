// Configuración de usuarios y rutas
const usuarios = [
    { document: "1140915684", password: "Admin123@", role: "Administrador", email: "admin@email.com", name: "Administrador" },
    { document: "1234567890", password: "Tecnico123!", role: "Técnico", email: "tecnico@email.com", name: "Técnico" },
    { document: "9876543210", password: "Ventas123?", role: "Ayudante", email: "ventas@email.com", name: "Ayudante" }
];

const rolRutas = {
    "Administrador": "../HTML/Reportes/Reportes.html",
    "Técnico": "../HTML/Servicios/Serv.html",
    "Ayudante": "../HTML/Reportes/Reportes.html"
};

// Funciones de validación
const validacion = {
    document: (doc) => {
        if (!doc) return "El documento es requerido";
        if (!/^\d{5,10}$/.test(doc)) return "El documento debe tener entre 5 y 10 dígitos";
        return "";
    },
    password: (pass) => {
        if (!pass) return "La contraseña es requerida";
        if (pass.length < 8) return "La contraseña debe tener al menos 8 caracteres";
        if (!/[A-Z]/.test(pass)) return "Debe incluir al menos una mayúscula";
        if (!/[a-z]/.test(pass)) return "Debe incluir al menos una minúscula";
        if (!/[0-9]/.test(pass)) return "Debe incluir al menos un número";
        if (!/[!@#$%^&*?¿]/.test(pass)) return "Debe incluir al menos un carácter especial (!@#$%^&*)";
        return "";
    },
    email: (email) => {
        if (!email) return "El email es requerido";
        if (!/^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/.test(email)) return "Email inválido";
        return "";
    },
    name: (name) => {
        if (!name) return "El nombre es requerido";
        if (name.length < 3) return "El nombre debe tener al menos 3 caracteres";
        if (!/^[a-zA-ZáéíóúÁÉÍÓÚñÑ\s]+$/.test(name)) return "El nombre solo puede contener letras";
        return "";
    }
};

// Funciones de manejo de errores
function showError(input, message) {
    if (!input) return;
    const inputBox = input.closest('.input-box');
    if (!inputBox) return;
    
    let errorDiv = inputBox.querySelector('.error-message');
    if (!errorDiv) {
        errorDiv = document.createElement('div');
        errorDiv.className = 'error-message';
        inputBox.appendChild(errorDiv);
    }
    
    errorDiv.textContent = message;
    errorDiv.style.display = 'block';
    input.classList.add('error');
}

function clearErrors(input) {
    const inputBox = input.closest('.input-box');
    if (!inputBox) return;
    inputBox.classList.remove('error');
    const errorDiv = inputBox.querySelector('.error-message');
    if (errorDiv) errorDiv.style.display = 'none';
}

// Control de modales
const modales = {
    login: document.getElementById('loginModal'),
    register: document.getElementById('registerModal'),
    forgot: document.getElementById('forgotModal')
};

const botones = {
    login: document.getElementById('openLoginModal'),
    register: document.getElementById('registerLink'),
    forgot: document.getElementById('forgotPassword'),
    backToLogin: document.getElementById('backToLogin'),
    backFromForgot: document.getElementById('backToLoginFromForgot'),
    close: document.querySelectorAll('.close')
};

function mostrarModal(modalToShow) {
    Object.values(modales).forEach(modal => {
        if (modal) modal.style.display = modal === modalToShow ? 'block' : 'none';
    });
}

// Event Listeners para modales
if (botones.login) botones.login.addEventListener('click', () => mostrarModal(modales.login));
if (botones.register) botones.register.addEventListener('click', (e) => {
    e.preventDefault();
    mostrarModal(modales.register);
});
if (botones.forgot) botones.forgot.addEventListener('click', (e) => {
    e.preventDefault();
    mostrarModal(modales.forgot);
});
if (botones.backToLogin) botones.backToLogin.addEventListener('click', (e) => {
    e.preventDefault();
    mostrarModal(modales.login);
});
if (botones.backFromForgot) botones.backFromForgot.addEventListener('click', (e) => {
    e.preventDefault();
    mostrarModal(modales.login);
});
if (botones.close) {
    botones.close.forEach(button => button.addEventListener('click', () => mostrarModal(null)));
}

// Cierre de modal al hacer clic fuera
window.addEventListener('click', (e) => {
    if (e.target.classList.contains('modal')) mostrarModal(null);
});

// Formularios
document.querySelector('.login-form').addEventListener('submit', (e) => {
    e.preventDefault();
    const inputs = {
        document: e.target.querySelector('input[type="number"]'),
        password: e.target.querySelector('input[type="password"]')
    };

    Object.values(inputs).forEach(input => clearErrors(input));

    const docError = validacion.document(inputs.document.value);
    if (docError) {
        showError(inputs.document, docError);
        return;
    }

    const passError = validacion.password(inputs.password.value);
    if (passError) {
        showError(inputs.password, passError);
        return;
    }

    const usuario = usuarios.find(u => 
        u.document === inputs.document.value && 
        u.password === inputs.password.value
    );

    if (usuario) {
        sessionStorage.setItem('userRole', usuario.role);
        window.location.href = rolRutas[usuario.role];
    } else {
        showError(inputs.password, "Credenciales incorrectas");
    }
});

document.getElementById('logout-btn').addEventListener('click', (e) => {
    e.preventDefault();
    sessionStorage.clear();
    window.location.href = '../../Landing.html';
});

document.querySelector('.register-form').addEventListener('submit', (e) => {
    e.preventDefault();
    const inputs = {
        name: e.target.querySelector('input[placeholder="Nombre Completo"]'),
        document: e.target.querySelector('input[placeholder="Número de Documento"]'),
        email: e.target.querySelector('input[type="email"]'),
        password: e.target.querySelector('input[placeholder="Contraseña"]'),
        confirmPass: e.target.querySelector('input[placeholder="Confirmar Contraseña"]')
    };

    let hasErrors = false;

    Object.entries({
        name: validacion.name(inputs.name.value),
        document: validacion.document(inputs.document.value),
        email: validacion.email(inputs.email.value),
        password: validacion.password(inputs.password.value)
    }).forEach(([field, error]) => {
        if (error) {
            showError(inputs[field], error);
            hasErrors = true;
        }
    });

    if (inputs.password.value !== inputs.confirmPass.value) {
        showError(inputs.confirmPass, "Las contraseñas no coinciden");
        hasErrors = true;
    }

    if (hasErrors) return;

    mostrarModal(null);
    Swal.fire({
        title: '¡Registro Exitoso!',
        text: 'Tu cuenta ha sido creada correctamente',
        icon: 'success',
        confirmButtonText: 'Aceptar'
    }).then(() => window.location.reload());
});

// Control de sesión
document.addEventListener('DOMContentLoaded', () => {
    const userRole = sessionStorage.getItem('userRole');
    const currentPage = window.location.pathname;
    const currentFile = currentPage.split('/').pop();

    if (!userRole && !currentPage.includes('Landing.html')) {
        window.location.href = '../../Landing.html';
        return;
    }

    if (userRole && roleRoutes[userRole]) {
        const allowedPages = roleRoutes[userRole].allowed;
        if (!allowedPages.some(page => currentFile.includes(page))) {
            window.location.href = roleRoutes[userRole].default;
        }
    }
});

// Validaciones en tiempo real
document.querySelectorAll('.input-box input').forEach(input => {
    input.addEventListener('input', () => clearErrors(input));
});

// Toggle de visibilidad de contraseña
document.querySelectorAll('#togglePassword').forEach(icon => {
    icon.addEventListener('click', function() {
        const input = this.previousElementSibling;
        const type = input.getAttribute('type') === 'password' ? 'text' : 'password';
        input.setAttribute('type', type);
        this.classList.toggle('fa-eye');
        this.classList.toggle('fa-eye-slash');
    });
});

// Eliminar rolRutas y mantener solo roleRoutes al inicio del archivo
const roleRoutes = {
    "Administrador": {
        default: "../HTML/Reportes/Reportes.html",
        allowed: ["Inventario.html", "Reportes.html", "Clientes.html", "Serv.html", "Usuarios.html", "Venta.html"]
    },
    "Técnico": {
        default: "../HTML/Servicios/Serv.html",
        allowed: ["Serv.html"]
    },
    "Ayudante": {
        default: "../HTML/Reportes/Reportes.html",
        allowed: ["Venta.html", "Reportes.html", "Clientes.html"]
    }
};

// Remove the duplicate rolRutas and use roleRoutes instead
const usuario = usuarios.find(u => 
    u.document === inputs.document.value && 
    u.password === inputs.password.value
);

if (usuario) {
    sessionStorage.setItem('userRole', usuario.role);
    window.location.href = roleRoutes[usuario.role].default;
} else {
    showError(inputs.password, "Credenciales incorrectas");
}