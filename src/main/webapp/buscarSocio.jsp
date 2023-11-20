<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %><%--
  Created by IntelliJ IDEA.
  User: mattialu
  Date: 20/11/23
  Time: 14:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<%
      try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/baloncesto","mattialu", "");
            Statement s = conexion.createStatement();
            ResultSet listado = s.executeQuery ("SELECT * FROM socio where socioID="+Integer.parseInt(request.getParameter("codigo")));

            listado.next();
            out.println(listado.getString("socioID") + ", ");
            out.println(listado.getString("nombre") + ", ");
            out.println(listado.getString("estatura") + ", ");
            out.println(listado.getString("edad") + ", ");
            out.println(listado.getString("localidad"));
            listado.close();
            s.close();
            conexion.close();
        }catch (Exception e){
            out.println(e);
        }
        out.println("<br>");
%>
<a href="index.jsp">Volver</a>
</body>
</html>
