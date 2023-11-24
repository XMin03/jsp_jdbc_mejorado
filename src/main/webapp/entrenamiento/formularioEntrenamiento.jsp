<%@ page import="java.util.ArrayList" %><%--
  Created by IntelliJ IDEA.
  User: mattialu
  Date: 23/11/23
  Time: 11:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="../estilos.css" />
</head>
<body>
<h2>Introduzca los datos del nuevo entrenamiento:</h2>
<form method="get" action="grabarEntrenamiento.jsp">
    Nº entrenamiento <input type="text" name="idEntrenamiento"/></br>
    Nº socio <input type="text" name="idSocio"/></br>
    tipo <select name="tipo">
            <option>físico</option>
            <option>técnico</option>
        </select>
    </br>
    ubicacion <input type="text" name="ubicacion"/></br>
    fecha <input type="date" name="fecha"/></br>
    <input type="submit" value="Aceptar">
</form>
<table>
    <tr>
        <%
            ArrayList<String> errores = (ArrayList<String>) session.getAttribute("error");
            if(errores==null){
                out.println("");
            }else{
                for (String errore : errores) {
                    out.println("<td>" + errore + "</td>");
                }
            }
        %>
        <% session.removeAttribute("error"); %>
    </tr>
</table>
</body>
</html>
