<%-- 
    Document   : admin
    Created on : Jan 6, 2021, 8:06:38 PM
    Author     : minhv
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Page</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
        <link href="CSS/adminn.css" rel="stylesheet" type="text/css"/>

    </head>
    <body>

        <c:if test="${sessionScope.LOGIN_USER==null  || sessionScope.LOGIN_USER.roleID =='US' || sessionScope.LOGIN_USER.roleID =='EMAIL'}">          
            <h3>You must be a Admin to manage food, please <a href="MainController?btnAction=Logout">Login</a> with admin account</h3>
        </c:if>

        <c:if test="${sessionScope.LOGIN_USER!=null && sessionScope.LOGIN_USER.roleID =='AD'}">          
            <a href="MainController?btnAction=Logout" class="logout">Logout</a>
            <a href="MainController?btnAction=Show CreatePage" class="create">Create Food</a>
            <h1>Welcome admin:${sessionScope.LOGIN_USER.fullName}</h1>      
            <form action="MainController" class="main-layout">
                Search food: <br>     
                Name 
                <input type="text"  name="adminTxtNameSearch" value="${param.adminTxtNameSearch==null ?"":param.adminTxtNameSearch}"><br>
                Price: 
                <input type="text" name="adminTxtPriceSearch" value="${param.adminTxtPriceSearch==null ?"":param.adminTxtPriceSearch}">
                <br>
                Category:  
                <input type="text" name="adminTxtCategorySearch"  value="${param.adminTxtCategorySearch==null ?"":param.adminTxtCategorySearch}">
                <br>                      

                <input type="submit" name="btnAction" value="Search"/>
            </form>

            <form action="MainController" class="delete">
                <c:if test="${requestScope.LIST !=null}">
                    <input type="submit" name="btnAction" value="Delete Food" onclick="return confirm('Do you want to delete?')" class="input"/><br><br>
                    <input type="hidden" name="adminTxtNameSearch"  value=<%= request.getParameter("adminTxtNameSearch") == null ? "" : request.getParameter("adminTxtNameSearch")%>>
                    <input type="hidden" name="adminTxtPriceSearch" value=<%= request.getParameter("adminTxtPriceSearch") == null ? "" : request.getParameter("adminTxtPriceSearch")%>>
                    <input type="hidden" name="adminTxtCategorySearch"  value=<%= request.getParameter("adminTxtCategorySearch") == null ? "" : request.getParameter("adminTxtCategorySearch")%>>
                    <table border="1">
                        <thead>
                            <tr>
                                <th>NO</th>
                                <th>FoodID</th>
                                <th>Name</th>
                                <th>Img</th>
                                <th>Price</th>
                                <th>Quantity</th>
                                <th>Description</th>
                                <th>Create date</th>
                                <th>Expiration date</th>
                                <th>Category</th>
                                <th>Status</th>
                                <th>Update</th>
                                <th>Delete</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:set var="count" value="0"/>  
                            <c:forEach var="fooddto" varStatus="counter" items="${requestScope.LIST}">
                                <c:set var="count" value="${count + 1}"/> 
                                <tr>
                            <form action="MainController">
                                <td>${counter.count}</td>
                                <td>
                                    ${fooddto.foodID}
                                    <input type="hidden" name="txtFoodID" value="${fooddto.foodID}"/>
                                </td>
                                <td>
                                    ${fooddto.foodName}
                                    <input type="hidden" name="txtFoodName" value="${fooddto.foodName}"/>
                                </td>
                                <td>
                                    <img src="${fooddto.linkImg}" width="250" height="200"/><br>
                                    <input type="hidden" name="txtImg" value="${fooddto.linkImg}"/>

                                </td>
                                <td>
                                    ${fooddto.foodPrice}
                                    <input type="hidden" name="txtFoodPrice"  value="${fooddto.foodPrice}">
                                </td>
                                <td>
                                    ${fooddto.quantity}
                                    <input type="hidden" name="txtQuantity"  value="${fooddto.quantity}" >
                                </td>
                                <td>
                                    ${fooddto.description}
                                    <input type="hidden" name="txtDescription"  value="${fooddto.description}">
                                </td>
                                <td>
                                    ${fooddto.createDate}
                                    <input type="hidden" name="txtCreateDate"  value=${fooddto.createDate}>
                                </td>
                                <td>
                                    ${fooddto.expirationDate}
                                    <input type="hidden" name="txtExpirationDate"  value="${fooddto.expirationDate}">
                                </td>
                                <td>
                                    <c:forEach var="categoryDto" varStatus="counter" items="${requestScope.LIST_CATEGORY}">
                                        <c:if test="${fooddto.categoryID==categoryDto.categoryID}">
                                            ${categoryDto.categoryName}
                                            <input type="hidden" name="txtCategoryID"  value="${categoryDto.categoryID}">
                                        </c:if>    
                                    </c:forEach>

                                </td>
                                <td>
                                    <c:if test="${fooddto.status==true}">
                                        Active
                                        <input type="hidden" name="txtStatus"  value="${fooddto.status}">
                                    </c:if>  
                                    <c:if test="${fooddto.status==false}">
                                        Inactive
                                        <input type="hidden" name="txtStatus"  value="${fooddto.status}">
                                    </c:if>  


                                </td>
                                <td>                                           

                                    <input type="submit" name="btnAction" value="Show Update Page" />
                                </td>
                            </form>
                            <td>
                                <c:if test="${fooddto.status==true}">
                                    <input type="checkbox" name="foodID${count}" value="${fooddto.foodID}">   
                                </c:if>  

                            </td>             
                            </tr>
                        </c:forEach>
                            


                        </tbody>
                    </table>
                    <input type="hidden" name="count" value="${count}">
                </form>   



                <nav>
                    <ul class="pagination justify-content-center">
                        <%
                            int totalPage = (int) request.getAttribute("TOTAL_PAGE");
                            if (request.getAttribute("TOTAL_PAGE") != null) {

                                for (int i = 1; i <= totalPage; i++) {
                        %>
                        <li class="page-item">
                            <a class="page-link" href="MainController?btnAction=Search&txtCurrentPage=<%=i%>&adminTxtNameSearch=<%=request.getParameter("adminTxtNameSearch")%>&adminTxtPriceSearch=<%=request.getParameter("adminTxtPriceSearch")%>&adminTxtCategorySearch=<%=request.getParameter("adminTxtCategorySearch")%>"><%=i%></a>
                        </li>
                        <%      }
                            }
                        %>
                    </ul>
                </nav>
            </c:if>



        </c:if>





    </body>
</html>
