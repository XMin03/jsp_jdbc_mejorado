<%--
  Created by IntelliJ IDEA.
  User: mattialu
  Date: 23/11/23
  Time: 11:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
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
<div style="color: red;">
    <p>
        <%=
        session.getAttribute("error") == null ?
                "" : session.getAttribute("error")
        %>
        <% session.removeAttribute("error"); %>
    </p>
</div>
</body>
</html>
