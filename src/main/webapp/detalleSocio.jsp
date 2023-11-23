<%@ page import="java.sql.*" %><%--
  Created by IntelliJ IDEA.
  User: mattialu
  Date: 20/11/23
  Time: 14:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="estilos.css" />
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<table>
    <tr><th>Código</th><th>Nombre</th><th>Estatura</th><th>Edad</th><th>Localidad</th></tr>
    <tr><td>
<%
    PreparedStatement ps=null;
    Connection conexion=null;
    ResultSet listado=null;
      try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            conexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/baloncesto","mattialu", "");
            String sql = "SELECT * FROM socio where socioID=?";
            ps = conexion.prepareStatement(sql);
            ps.setInt(1, Integer.parseInt(request.getParameter("codigo")));
            listado = ps.executeQuery();
            listado.next();
            out.println(listado.getString("socioID") + "</td>");
            out.println("<td>" + listado.getString("nombre") + "</td>");
            out.println("<td>" + listado.getString("estatura") + "</td>");
            out.println("<td>" + listado.getString("edad") + "</td>");
            out.println("<td>" + listado.getString("localidad") + "</td>");
        }catch (Exception e){
            out.println(e);
        }finally {
          try {
              listado.close();
          } catch (Exception e) { /* Ignored */ }
          try {
              ps.close();
          } catch (Exception e) { /* Ignored */ }
          try {
              conexion.close();
          } catch (Exception e) { /* Ignored */ }
      }
        out.println("<br>");
%>
</td></tr>
</table>
<a href="index.jsp">Volver</a>
</body>
</html>
