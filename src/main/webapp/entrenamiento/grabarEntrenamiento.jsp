<%--
  Created by IntelliJ IDEA.
  User: mattialu
  Date: 23/11/23
  Time: 11:54
  To change this template use File | Settings | File Templates.
--%>
<%@page import="java.sql.*" %>
<%@page import="java.util.Objects" %>
<%@ page import="java.io.IOException" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<%
    //CÓDIGO DE VALIDACIÓN
    boolean valida = true;
    int idEnt = -1;
    int idSocio = -1;
    String tipo = null;
    String ubicacion = null;
    String fecha = null;
    try {
        idEnt = Integer.parseInt(request.getParameter("idEntrenamiento"));
        idSocio = Integer.parseInt(request.getParameter("idSocio"));
        Objects.requireNonNull(request.getParameter("tipo"));
        if (request.getParameter("tipo").isBlank()) throw new RuntimeException("Parámetro vacío o todo espacios blancos.");
        tipo = request.getParameter("tipo");
        Objects.requireNonNull(request.getParameter("ubicacion"));
        if (request.getParameter("ubicacion").isBlank()) throw new RuntimeException("Parámetro vacío o todo espacios blancos.");
        ubicacion = request.getParameter("ubicacion");
        Objects.requireNonNull(request.getParameter("fecha"));
        if (request.getParameter("fecha").isBlank()) throw new RuntimeException("Parámetro vacío o todo espacios blancos.");
        fecha = request.getParameter("fecha");
    } catch (Exception ex) {
        ex.printStackTrace();
        valida = false;
    }
    //FIN CÓDIGO DE VALIDACIÓN

    if (valida) {
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/baloncesto", "mattialu", "");
            String sql = "INSERT INTO entrenamientos VALUES ( " +
                    "?, " + //entrenamientoID
                    "?, " + //socioID
                    "?, " + //tipo_entrenamiento
                    "?, " + //ubicacion
                    "?)"; //fecha_realizacion

            ps = conn.prepareStatement(sql);
            int idx = 1;
            ps.setInt(idx++, idEnt);
            ps.setInt(idx++, idSocio);
            ps.setString(idx++, tipo);
            ps.setString(idx++, ubicacion);
            ps.setString(idx++, fecha);

            int filasAfectadas = ps.executeUpdate();
            System.out.println("SOCIOS GRABADOS:  " + filasAfectadas);


        } catch (Exception ex) {
            ex.printStackTrace();
            valida=false;
        } finally {
            try {
                ps.close();
            } catch (Exception e) { /* Ignored */ }
            try {
                conn.close();
            } catch (Exception e) { /* Ignored */ }
        }
    }
    if (valida){
        response.sendRedirect("listadoEntrenamiento.jsp");
    }else{
        session.setAttribute("error", "Error de validación");
        response.sendRedirect("formularioEntrenamiento.jsp");
    }
%>

</body>
</html>

