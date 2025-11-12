<%--
  Created by IntelliJ IDEA.
  User: Jainish K
  Date: 08-11-2025
  Time: 05:51 pm
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" %>
<%
    session.invalidate();
    response.sendRedirect("login.jsp?msg=You have been logged out successfully.");
%>

