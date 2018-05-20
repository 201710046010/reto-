/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.sql.*;
import java.util.Calendar;

/**
 *
 * @author ASUS1
 */
public class Consultas {
    
   public static Connection conectar() {
       try{
           // crea la conexion
           Connection miConexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/sakila","root", "THEelement115");
           return miConexion;
       }catch(Exception e){
           System.out.println(e);
           System.exit(1);
       }
       return null;
   }
   
   public static void agregarTienda (Connection miConexion,int Codigo,String Nombre,int ManagerId,int direccion,String descripcion){
       String insertTable = ("INSERT INTO store"+"(store_id,manager_staff_id,address_id,last_update,nombre,descripcion) VALUES" + "(?,?,?,?,?,?)");
       Calendar calendar = Calendar.getInstance();
       java.util.Date now = calendar.getTime();
       Timestamp currentTime = new Timestamp(now.getTime());
       try{
           PreparedStatement stmt = miConexion.prepareStatement(insertTable);
           stmt.setInt(1, Codigo);
           stmt.setInt(2, ManagerId);
           stmt.setInt(3, direccion );
           stmt.setTimestamp(4, currentTime);
           stmt.setString(5,Nombre);
           stmt.setString(6, descripcion);
           stmt.executeUpdate();
       }catch(Exception e){
           System.exit(1);
       }
   }
           
   
}
