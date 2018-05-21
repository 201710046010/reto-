/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.sql.*;
import java.util.Calendar;
import java.util.ArrayList;

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
           System.out.println(e);
           System.exit(1);
       }
   }
           
   public static void agregarClientes(Connection miConexion,int CodigoUsuario,int StoreId,String nombre,String apellido,String email,int adress){
       Calendar calendar = Calendar.getInstance();
       java.util.Date now = calendar.getTime();
       Timestamp currentTime = new Timestamp(now.getTime());
       int a = 0;
       String insertTable = ("INSERT INTO customer"+ "(customer_id,store_id,first_name,last_name,email,address_id,active,create_date,last_update) VALUES " + "(?,?,?,?,?,?,?,?,?)");
       try{
        Statement conexion = miConexion.createStatement();
        ResultSet st = conexion.executeQuery("select count(customer_id) from customer where store_id = 2");
        if(st.next()){
            a = st.getInt(1);
        }
        if(a >= StoreId ){
            StoreId = 1;
        }
        else{
          StoreId = 2; 
       }
           PreparedStatement stmt = miConexion.prepareStatement(insertTable);
           stmt.setInt(1, CodigoUsuario);
           stmt.setInt(2, StoreId);
           stmt.setString(3, nombre);
           stmt.setString(4, apellido);
           stmt.setString(5, email);
           stmt.setInt(6, adress);
           stmt.setInt(7, 1);
           stmt.setTimestamp(8, currentTime);
           stmt.setTimestamp(9, currentTime);
           stmt.executeUpdate();
       }catch(Exception e){
           System.out.print(e);
           System.exit(1);
       }
   }
   
   public static ArrayList<String> recomendaciones (Connection miConexion,String tiempo ){
       ArrayList <String> a = new ArrayList<>();
       try{
           Statement conexion = miConexion.createStatement();
           ResultSet st = conexion.executeQuery("call w_pelis(recomend(1," +tiempo +"))");
           int i =1;
           while(st.next()){
              a.add(st.getString(i));
           }
       }catch(Exception e){
           System.out.println(e);
       }
    return a;
   }
}
