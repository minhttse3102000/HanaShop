<%-- 
    Document   : shopping
    Created on : Jan 5, 2021, 8:19:34 PM
    Author     : minhv
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Shopping Page</title>       
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
        <link href="CSS/shoppingg.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <c:if test="${sessionScope.LOGIN_USER!=null && sessionScope.LOGIN_USER.roleID =='US' || sessionScope.LOGIN_USER!=null && sessionScope.LOGIN_USER.roleID =='EMAIL'}">          
            <a href="MainController?btnAction=Search History">History</a>
            <a href="MainController?btnAction=Logout">Logout</a>
            <h1>Welcome ${sessionScope.LOGIN_USER.fullName} to Hana Shop</h1><br><br><br><br><br>
        </c:if>
        <c:if test="${sessionScope.LOGIN_USER==null}">          
            <a href="MainController?btnAction=Logout">Login</a>
            <h1>Welcome to Hana Shop</h1><br><br><br><br><br>
        </c:if>




        <form action="MainController" method="POST" class="main-layout">
            Search food: <br>     
            Name 
            <input type="text"  name="txtNameSearch" class="name" value="${param.txtNameSearch==null ?"":param.txtNameSearch}"><br>
            Price: 
            <input type="text" name="txtPriceSearch" class="price" value="${param.txtPriceSearch==null ?"":param.txtPriceSearch}">                  
            <br>
            Category:  
            <input type="text" name="txtCategorySearch"  class="category" value="${param.txtCategorySearch==null ?"":param.txtCategorySearch}">
            <br>                      

            <input type="submit" name="btnAction" value="Search Food"/>
            <c:if test="${sessionScope.LOGIN_USER!=null && sessionScope.LOGIN_USER.roleID =='US' || sessionScope.LOGIN_USER!=null && sessionScope.LOGIN_USER.roleID =='EMAIL'}">
                <input type="submit" name="btnAction" value="View"/>
            </c:if>


            <br><br>
        </form>
        <c:if test="${requestScope.TOTAL_PAGE!=null && requestScope.TOTAL_PAGE > 1}">
            <nav>
                <ul class="pagination justify-content-center">                       
                    <c:forEach var="count" begin="1" end="${requestScope.TOTAL_PAGE}">
                        <li class="page-item">
                            <a class="page-link" href="MainController?btnAction=Search Food&txtCurrentPage=${count}&txtNameSearch=${param.txtNameSearch}&txtPriceSearch=${param.txtPriceSearch}&txtCategorySearch=${param.txtCategorySearch}">${count}</a>
                        </li>
                    </c:forEach>                        
                </ul>
            </nav><br>
        </c:if>

        <c:if test="${requestScope.MESSAGE !=null}">
            <h3>${requestScope.MESSAGE}</h3>
        </c:if>

        <c:if test="${requestScope.LIST_FOOD !=null}">
            <c:forEach var="fooddto" varStatus="counter" items="${requestScope.LIST_FOOD}">
                <form action="MainController" method="POST" class="food-layout">
                    <div>
                        <image src="${fooddto.linkImg}" width="280" height="180">
                        <h5>${fooddto.foodName}</h5>
                        <h5>Price: ${fooddto.foodPrice} VND</h5>
                        <h5>Quantity: ${fooddto.quantity} </h5>
                        <h5>Create Date: ${fooddto.createDate}</h5>
                        <h5>Expiration Date: ${fooddto.expirationDate}</h5>
                        <h5>Description: ${fooddto.description}</h5>

                        <input type="hidden" name="txtFoodID"  value=${fooddto.foodID}>
                        <input type="hidden" name="txtFoodName"  value=${fooddto.foodName}>
                        <input type="hidden" name="txtFoodPrice"  value=${fooddto.foodPrice}>
                        <input type="hidden" name="txtCreateDate"  value=${fooddto.createDate}>
                        <input type="hidden" name="txtExpirationDate"  value=${fooddto.expirationDate}>                       
                        <input type="hidden" name="txtDescription"  value=${fooddto.description}>
                        <input type="hidden" name="txtQuantity"  value=${fooddto.quantity}>
                        <input type="hidden" name="txtlinkImg"  value=${fooddto.linkImg}>
                        <input type="hidden" name="txtCategoryID"  value=${fooddto.categoryID}>

                        <input type="hidden" name="txtNameSearch"  value=${param.txtNameSearch==null ?"":param.txtNameSearch}>
                        <input type="hidden" name="txtPriceSearch" value=${param.txtPriceSearch==null ?"":param.txtPriceSearch}>
                        <input type="hidden" name="txtCategorySearch"  value=${param.txtCategorySearch==null ?"":param.txtCategorySearch}>

                        <c:if test="${sessionScope.LOGIN_USER!=null && sessionScope.LOGIN_USER.roleID =='US' || sessionScope.LOGIN_USER!=null && sessionScope.LOGIN_USER.roleID =='EMAIL'}">          
                            <input type="submit" name="btnAction" value="Add" class="add"/>
                        </c:if>

                    </div>
                </form>
            </c:forEach>
        </c:if>




    </body>
</html>
