
package modelo;

public class ProductoServicio {
    private int idProdServ, idServicio, idProducto, cantidad;
    
    public ProductoServicio(){
        
    }

    public ProductoServicio(int idProdServ, int idServicio, int idProducto, int cantidad) {
        this.idProdServ = idProdServ;
        this.idServicio = idServicio;
        this.idProducto = idProducto;
        this.cantidad = cantidad;
    }

    public int getIdProdServ() {
        return idProdServ;
    }

    public void setIdProdServ(int idProdServ) {
        this.idProdServ = idProdServ;
    }

    public int getIdServicio() {
        return idServicio;
    }

    public void setIdServicio(int idServicio) {
        this.idServicio = idServicio;
    }

    public int getIdProducto() {
        return idProducto;
    }

    public void setIdProducto(int idProducto) {
        this.idProducto = idProducto;
    }

    public int getCantidad() {
        return cantidad;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }
    
    
    
    
}
