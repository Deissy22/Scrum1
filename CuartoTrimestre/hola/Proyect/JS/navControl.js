document.addEventListener('DOMContentLoaded', () => {
    const userRole = sessionStorage.getItem('userRole');
    const navLinks = {
        "Administrador": [
            { url: '../Reportes/Reportes.html', text: 'Reportes', icon: 'analytics' },
            { url: '../Inventario/Inventario.html', text: 'Inventario', icon: 'inventory' },
            { url: '../Clientes/Clientes.html', text: 'Clientes', icon: 'people' },
            { url: '../Servicios/Serv.html', text: 'Servicios', icon: 'build' },
            { url: '../Ventas/Venta.html', text: 'Ventas', icon: 'point_of_sale' },
            { url: '../Usuarios/Usuarios.html', text: 'Usuarios', icon: 'manage_accounts' },
            { url: '../../Landing.html', text: 'Cerrar Sesión', icon:'logout' }
        ],
        "Técnico": [
            { url: '../Servicios/Serv.html', text: 'Servicios', icon: 'build' },
            { url: '../../Landing.html', text: 'Cerrar Sesión', icon:'logout' }
        ],
        "Ayudante": [
            { url: '../Reportes/Reportes.html', text: 'Reportes', icon: 'analytics' },
            { url: '../Ventas/Venta.html', text: 'Ventas', icon: 'point_of_sale' },
            { url: '../Clientes/Clientes.html', text: 'Clientes', icon: 'people' },
            { url: '../../Landing.html', text: 'Cerrar Sesión', icon:'logout' }
        ]
    };

    const mainNav = document.getElementById('mainNav');
    if (mainNav && navLinks[userRole]) {
        mainNav.innerHTML = navLinks[userRole]
            .map(link => `
                <a href="${link.url}" class="nav-btn">
                    <span class="material-icons">${link.icon}</span>
                    ${link.text}
                </a>
            `).join('');
    }
});