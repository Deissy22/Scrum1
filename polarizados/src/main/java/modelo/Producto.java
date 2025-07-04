package modelo;


public class Producto {
    private int idProducto;
    private String nombre, descripcion;
    
    public Producto(){
        
    }

    public Producto(int idProducto, String nombre, String descripcion) {
        this.idProducto = idProducto;
        this.nombre = nombre;
        this.descripcion = descripcion;
    }

    public int getIdProducto() {
        return idProducto;
    }

    public void setIdProducto(int idProducto) {
        this.idProducto = idProducto;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }
    
    
    
}
