<%-- 
    Document   : history
    Created on : Jan 10, 2021, 2:39:58 PM
    Author     : minhv
--%>

<%@page import="java.util.Set"%>
<%@page import="minhtt.dtos.OrderDetailDTO"%>
<%@page import="java.util.Map"%>
<%@page import="minhtt.dtos.OrderDTO"%>
<%@page import="java.util.List"%>
<%@page import="minhtt.dtos.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>History Page</title>
        <script type="text/javascript" src="https://code.jquery.com/jquery-1.11.3.min.js"></script>
        <link rel="stylesheet" href="https://formden.com/static/cdn/bootstrap-iso.css" />
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.4.1/js/bootstrap-datepicker.min.js"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.4.1/css/bootstrap-datepicker3.css"/>
        <link href="CSS/history.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <% Map<String,List<String>> listOrder = (Map<String,List<String>>) request.getAttribute("LIST_ORDER");
           UserDTO user = (UserDTO) session.getAttribute("LOGIN_USER");
           if (session.getAttribute("LOGIN_USER") == null || user.getRoleID().equals("AD")) {
        %>
                <h3>Please <a href="MainController?btnAction=Logout">Login</a> with customer account</h3>
        <%
            }else{     
        %>   
                <a href="MainController?btnAction=Show FoodPage" class="shopping">Back to shopping</a> 
                <a href="MainController?btnAction=Logout" class="logout">Logout</a>
                <br><br><br><h1>History : </h1><br><br>
                <div class="bootstrap-iso">
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-md-6 col-sm-6 col-xs-12">
                                <form action="MainController" class="main-layout">
                                    Search history: <br>
                                    Date 
                                    <input type="text"  name="txtDateSearch"  
                                           value="<%= request.getParameter("txtDateSearch") == null ? "" : request.getParameter("txtDateSearch")%>">
                                    Food Name: 
                                    <input type="text" name="txtFoodNameSearch" 
                                           value="<%= request.getParameter("txtFoodNameSearch") == null ? "" : request.getParameter("txtFoodNameSearch")%>" class="price">

                                    <input type="submit" name="btnAction" value="Search History" class="search"/>
                                </form>
                            </div>
                        </div>    
                    </div>
                </div>
                                               
                <%if (listOrder != null) {           
                      int no = 1; 
                %>
                    <table border="1">
                        <thead>
                            <tr>
                                <th>No</th>
                                <th>Order Date</th>
                                <th>Order Address</th>
                                <th>Food</th>
                                <th>TotalPrice</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%  Set<String> key = listOrder.keySet();
                                for (String order : key) {
                                    String[] arr = order.split("_");
                                    String orderDate = arr[0];
                                    String orderAddress = arr[1];
                                    String totalPrice = arr[2];
                            %>
                                    <tr>
                                        <td><%= no++%></td>
                                        <td><%= orderDate%></td>
                                        <td><%= orderAddress%></td>
                                        <td><%= listOrder.get(order)%></td>       
                                        <td><%= totalPrice%></td>  
                                    </tr>
                            <%
                                }
                            %>
                        </tbody>
                    </table>                           
        <%
                }
            }
        %>
        
        <script>
            $(document).ready(function () {
                var dateSearch = $('input[name="txtDateSearch"]');           
                var container = $('.bootstrap-iso form').length > 0 ? $('.bootstrap-iso form').parent() : "body";
                dateSearch.datepicker({
                    format: 'mm/dd/yyyy',
                    container: container,
                    todayHighlight: true,
                    autoclose: true,
//                    
                })
            })
        </script>
    </body>
</html>
