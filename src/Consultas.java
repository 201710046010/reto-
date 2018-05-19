/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.sql.*;

/**
 *
 * @author ASUS1
 */
public class Consultas {
    
   public static Connection conectar() {
       try{
           // crea la conexion
           Connection miConexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/sakila","root", "3202027562e");
           return miConexion;
       }catch(Exception e){
           System.out.println(e);
           System.exit(1);
       }
       return null;
   }
   
}
