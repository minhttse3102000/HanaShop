<%-- 
    Document   : viewBillPage
    Created on : Jan 7, 2021, 8:03:05 PM
    Author     : minhv
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Bill Page</title>
        <link rel="stylesheet" href="CSS/viewBillPage.css">
    </head>
    <body>
        <c:if test="${sessionScope.LOGIN_USER==null  || sessionScope.LOGIN_USER.roleID =='AD'}">          
            <h3>Please <a href="MainController?btnAction=Logout">Login</a> with customer account</h3>
        </c:if>
        
        <c:if test="${sessionScope.LOGIN_USER!=null && sessionScope.LOGIN_USER.roleID =='US' || sessionScope.LOGIN_USER!=null && sessionScope.LOGIN_USER.roleID =='EMAIL'}">          
            <a href="MainController?btnAction=Logout" class="logout">Logout</a>
            <h1>Your bill: </h1>
            <c:if test="${sessionScope.CART!=null}">
                <c:set var="totalPrice" value="0"/>    
                <h3>Name : ${sessionScope.CART.customerName}</h3>
                <h3>Date : ${sessionScope.CART.orderDate}</h3>
                <form action="MainController" class="update">
                    Delivery address
                    <input type="text" name="txtOrderAddress" value="${sessionScope.CART.orderAddress==null ?"":sessionScope.CART.orderAddress}"> 
                    <input type="submit" name="btnAction" value="Update Address"/><br>

                    <c:if test="${requestScope.ERROR_UPDATE_MESSAGE !=null}">
                        ${requestScope.ERROR_UPDATE_MESSAGE}
                    </c:if>
                    
                </form>
                <br>
                <table border="1">
                        <thead>
                            <tr>
                                <th>No</th>
                                <th>Food Name</th>
                                <th>Amount</th>
                                <th>Price</th>
                                <th>Total</th>
                                <th>Update</th>
                                <th>Delete</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="foodDto" varStatus="counter" items="${sessionScope.CART.cart}">
                                 <c:set var="totalPrice" value="${totalPrice + (foodDto.value.foodPrice * foodDto.value.quantity)}"/> 
                                <form action="MainController">
                                        <tr>
                                            <td>${counter.count}</td>
                                            <td>${foodDto.value.foodName}
                                                <input type="hidden" name="txtFoodID" value="${foodDto.value.foodID}"/>
                                            </td>
                                            <td>
                                                <input type="text" name="txtAmount" value="${foodDto.value.quantity}"/>
                                            </td>
                                            <td>${foodDto.value.foodPrice}</td>
                                            <td>${foodDto.value.foodPrice * foodDto.value.quantity}</td>
                                            <td>                       
                                                <input type="submit" name="btnAction" value="Update Amount"/>
                                            </td>
                                            <td>                                                                   
                                                <input type="submit" name="btnAction" value="Delete Food Cart" onclick="return confirm('Do you want to delete?')"/>
                                            </td>
                                        </tr>
                                    </form>
                            </c:forEach>
                                                      

                        </tbody>
                    </table>
                
                <h2>Total: ${totalPrice}</h2>
                <c:if test="${requestScope.MESSAGE_BUY_ERROR !=null}">
                    <h3>${requestScope.MESSAGE_BUY_ERROR}</h3>
                </c:if>
                    
                    <form action="MainController" class="buyFood">
                        <input type="submit" name="btnAction" value="Buy Food"/>
                        <input type="hidden" name="userID" value="${sessionScope.LOGIN_USER.userID}"/>    
                        <input type="hidden" name="orderAddress" value="${sessionScope.CART.orderAddress}"/>   
                        <input type="hidden" name="totalMoney" value="${totalPrice}"/> 
                    </form>
                
            </c:if>
                    
            <c:if test="${requestScope.MESSAGE_BUY !=null}">
                <h3>${requestScope.MESSAGE_BUY}</h3>
            </c:if>
            
                <a href="MainController?btnAction=Show FoodPage" class="add">Add more food !</a> 
        </c:if>
                
        
    </body>
</html>
