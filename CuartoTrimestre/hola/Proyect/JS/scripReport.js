document.addEventListener('DOMContentLoaded', () => {
    try {
        const userCtx = document.getElementById('userPerformanceChart');
        if (!userCtx) {
            console.error('No se encontró el elemento userPerformanceChart');
            return;
        }

        const salesCtx = document.getElementById('monthlySalesChart');
        if (!salesCtx) {
            console.error('No se encontró el elemento monthlySalesChart');
            return;
        }

        // User Performance Chart
        new Chart(userCtx, {
            type: 'bar',
            data: {
                labels: ['Ayudante', 'Tecnico'],
                datasets: [{
                    label: 'Servicios / Ventas Completados',
                    data: [12, 19, 8, 15, 10],
                    backgroundColor: '#83292a',
                    borderRadius: 5
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        display: false
                    }
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        grid: {
                            color: '83292a'
                        },
                        ticks: {
                            color: '#9ca3af'
                        }
                    },
                    x: {
                        grid: {
                            display: false
                        },
                        ticks: {
                            color: '#9ca3af'
                        }
                    }
                }
            }
        });

        // Monthly Sales Chart
        new Chart(salesCtx, {
            type: 'line',
            data: {
                labels: ['Ene', 'Feb', 'Mar'],
                datasets: [{
                    label: 'Ventas',
                    data: [35000, 42000, 38000, 45000, 43000, 45000],
                    borderColor: '#83292a',
                    tension: 0.5,
                    fill: false
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false, 
                height: 300, 
                plugins: {
                    legend: {
                        display: false
                    }
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        grid: {
                            color: '#83292a'
                        },
                        ticks: {
                            color: '#9ca3af',
                            callback: value => `$${value.toLocaleString()}`
                        }
                    },
                    x: {
                        grid: {
                            display: false
                        },
                        ticks: {
                            color: '#9ca3af'
                        }
                    }
                }
            }
        });
    } catch (error) {
        console.error('Error al inicializar los gráficos:', error);
    }
});