<%@page import="java.sql.*" %>
<%@page import="java.util.Objects" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.util.ArrayList" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<%
    //CÓDIGO DE VALIDACIÓN
    int numero = -1;
    String nombre = null;
    int estatura = -1;
    int edad = -1;
    String localidad = null;
    ArrayList<String> errores=new ArrayList<>();
    try{
        numero = Integer.parseInt(request.getParameter("numero"));
    }catch (NumberFormatException e){
        errores.add("Nª de socio no es un número");
    }
    try{
        Objects.requireNonNull(request.getParameter("nombre"));
        if (request.getParameter("nombre").isBlank()) throw new RuntimeException("Parámetro vacío o todo espacios blancos.");
        nombre = request.getParameter("nombre");
    }catch (NullPointerException e){
        errores.add("Nombre no puede ser nulo");
    }catch (RuntimeException e){
        errores.add("Nombre no puede estar vacío");
    }
    try{
        estatura = Integer.parseInt(request.getParameter("estatura"));
    }catch (NumberFormatException e){
        errores.add("Estatura no es un número");
    }
    try{
        edad = Integer.parseInt(request.getParameter("edad"));
    }catch (NumberFormatException e){
        errores.add("Edad no es un número");
    }
    try{
        Objects.requireNonNull(request.getParameter("localidad"));
        if (request.getParameter("localidad").isBlank()) throw new RuntimeException("Parámetro vacío o todo espacios blancos.");
        localidad = request.getParameter("localidad");
    }catch (NullPointerException e){
        errores.add("Localidad no puede ser nulo");
    }catch (RuntimeException e){
        errores.add("Localidad no puede estar vacío");
    }
    //FIN CÓDIGO DE VALIDACIÓN

    if (errores.isEmpty()) {
        Connection conn = null;
        PreparedStatement ps = null;
// 	ResultSet rs = null;

        try {

            //CARGA DEL DRIVER Y PREPARACIÓN DE LA CONEXIÓN CON LA BBDD
            //						v---------UTILIZAMOS LA VERSIÓN MODERNA DE LLAMADA AL DRIVER, no deprecado
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/baloncesto", "mattialu", "");


//>>>>>>NO UTILIZAR STATEMENT EN QUERIES PARAMETRIZADAS
//       Statement s = conexion.createStatement();
//       String insercion = "INSERT INTO socio VALUES (" + Integer.valueOf(request.getParameter("numero"))
//                          + ", '" + request.getParameter("nombre")
//                          + "', " + Integer.valueOf(request.getParameter("estatura"))
//                          + ", " + Integer.valueOf(request.getParameter("edad"))
//                          + ", '" + request.getParameter("localidad") + "')";
//       s.execute(insercion);
//<<<<<<

            String sql = "INSERT INTO socio VALUES ( " +
                    "?, " + //socioID
                    "?, " + //nombre
                    "?, " + //estatura
                    "?, " + //edad
                    "?)"; //localidad

            ps = conn.prepareStatement(sql);
            int idx = 1;
            ps.setInt(idx++, numero);
            ps.setString(idx++, nombre);
            ps.setInt(idx++, estatura);
            ps.setInt(idx++, edad);
            ps.setString(idx++, localidad);

            int filasAfectadas = ps.executeUpdate();
            System.out.println("SOCIOS GRABADOS:  " + filasAfectadas);


        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            //BLOQUE FINALLY PARA CERRAR LA CONEXIÓN CON PROTECCIÓN DE try-catch
            //SIEMPRE HAY QUE CERRAR LOS ELEMENTOS DE LA  CONEXIÓN DESPUÉS DE UTILIZARLOS
            //try { rs.close(); } catch (Exception e) { /* Ignored */ }
            try {
                ps.close();
            } catch (Exception e) { /* Ignored */ }
            try {
                conn.close();
            } catch (Exception e) { /* Ignored */ }
        }

        out.println("Socio dado de alta.");
} else {
        session.setAttribute("error", errores);
        response.sendRedirect("formularioSocio.jsp");
}
%>

</body>
</html>
