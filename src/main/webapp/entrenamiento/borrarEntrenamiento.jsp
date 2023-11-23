<%--
  Created by IntelliJ IDEA.
  User: mattialu
  Date: 23/11/23
  Time: 11:49
  To change this template use File | Settings | File Templates.
--%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<%
    boolean valida = true;
    int codigo = -1;
    try {
        codigo = Integer.parseInt(request.getParameter("codigo"));
    } catch (NumberFormatException nfe) {
        nfe.printStackTrace();
        valida = false;
    }

    if (valida) {
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/baloncesto","mattialu", "");
            String sql = "DELETE FROM entrenamientos WHERE entrenamientoID = ?";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, codigo);
            int filasAfectadas = ps.executeUpdate();
            System.out.println("SOCIOS BORRADOS:  " + filasAfectadas);
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            try { ps.close(); } catch (Exception e) { /* Ignored */ }
            try { conn.close(); } catch (Exception e) { /* Ignored */ }
        }
    }
%>
<!-- REDIRECCIÓN POR JavaScript EN EL CLIENTE  -->
<script>document.location = "listadoEntrenamiento.jsp"</script>
</body>
</html>