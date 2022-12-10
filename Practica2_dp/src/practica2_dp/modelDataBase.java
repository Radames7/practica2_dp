
package practica2_dp;


import java.sql.*;
import javax.swing.JOptionPane;
/**
 *
 * @author Radames
 */
public class modelDataBase {
    Connection cn;
    public static final String ConsLogin="com.mysql.jdbc.driver";
    public Connection conectar(){
        try{
            cn=DriverManager.getConnection("jdbc:mysql://localhost/practica_dp","root","");
            System.out.println("CONECTADO");
        }catch(Exception e){
            System.out.println("Error: "+e);
        }
        return cn;
    }
    
    public ResultSet  AltaRegistro(String id, String nombre, String paterno, String materno,String calle, String numero, String colonia){
        ResultSet rs = null;
        try{
            CallableStatement insert = cn.prepareCall("call GUARDAR_DISTRIBUIDOR(1,?,?,?,?,?,?,?)");
                insert.setString(1, id);
                insert.setString(2, nombre);
                insert.setString(3, paterno);
                insert.setString(4, materno);
                insert.setString(5, calle);
                insert.setString(6, numero);
                insert.setString(7, colonia);
                insert.execute();
                rs = insert.executeQuery();
        }catch(Exception e){
           JOptionPane.showMessageDialog(null, "Ha ocurrido un error: " +e);
        }
         return rs;
    }
    
    
    public ResultSet consultaRegistro(String id_consulta){
        ResultSet rs = null;
        try{
            CallableStatement select = cn.prepareCall("call OBTENER_DISTRIBUIDOR(?)");
                select.setString(1, id_consulta);
                 rs = select.executeQuery();
        }catch(Exception e){
           JOptionPane.showMessageDialog(null, "Ha ocurrido un error: " +e);
        }
         return rs;
    }
    
}
