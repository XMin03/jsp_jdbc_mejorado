<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%--
  Created by IntelliJ IDEA.
  User: mattialu
  Date: 23/11/23
  Time: 10:58
  To change this template use File | Settings | File Templates.
--%>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="../estilos.css" />
    <title>Listado Entrenamiento</title>
</head>
<body>
<h1>Listado de Entrenamiento</h1>
<%
    Connection conexion=null;
    Statement s=null;
    ResultSet listado=null;
    try{
        Class.forName("com.mysql.cj.jdbc.Driver");
        conexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/baloncesto","mattialu", "");
        s = conexion.createStatement();
        listado = s.executeQuery ("SELECT entrenamientos.*, nombre FROM entrenamientos NATURAL JOIN socio");
%>
<table>
    <tr><th>Codigo</th><th>Socio</th><th>Tipo</th><th>Ubicacion</th><th>Fecha</th><th><a href="formularioEntrenamiento.jsp">+</a></th></tr>
    <%
        while (listado.next()) {
          out.println("<tr><td>"+listado.getString("entrenamientoID") + "</td>");
          out.println("<td>" + listado.getString("nombre") + "</td>");
          out.println("<td>" + listado.getString("tipo_entrenamiento") + "</td>");
          out.println("<td>" + listado.getString("ubicacion") + "</td>");
          out.println("<td>" + listado.getString("fecha_realizacion") + "</td>");
    %>
    <td>
        <form method="get" action="borrarEntrenamiento.jsp">
            <input type="hidden" name="codigo" value="<%=listado.getString("entrenamientoID") %>"/>
            <input type="submit" value="borrar">
        </form>
    </td></tr>
    <%
        }

        conexion.close();
        s.close();
        listado.close();
    }catch (Exception e){
        out.println("Error");
    }  finally {
        try {
            conexion.close();
        } catch (Exception e) { /* Ignored */ }
        try {
            s.close();
        } catch (Exception e) { /* Ignored */ }
        try {
            listado.close();
        } catch (Exception e) { /* Ignored */ }
    }
    %>
</table>
<a href="../index.jsp">Volver</a>
</body>
</html>
