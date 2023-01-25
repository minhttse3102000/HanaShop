<%-- 
    Document   : update
    Created on : Jan 14, 2021, 2:53:11 PM
    Author     : minhv
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Page</title>
        <link href="CSS/update.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <c:if test="${sessionScope.LOGIN_USER==null  || sessionScope.LOGIN_USER.roleID =='US' || sessionScope.LOGIN_USER.roleID =='EMAIL'}">          
            <h3>You must be a Admin to update food, please <a href="MainController?btnAction=Logout">Login</a> with admin account</h3>
        </c:if>

        <c:if test="${sessionScope.LOGIN_USER!=null && sessionScope.LOGIN_USER.roleID =='AD'}">
            <a href="MainController?btnAction=Logout" class="logout">Logout</a><br>
            <h2>Admin: ${sessionScope.LOGIN_USER.fullName}</h2>
            <div>     
                <h1>Update food </h1>

                <c:if test="${sessionScope.LIST_CATEGORY!=null}">
                    <form action="MainController" method="POST" class="main-layout">
                        <img src="${sessionScope.FOOD_UPDATE.linkImg}" width="250" height="200"/><br>
                        <input type="file" name="txtFile" id="file" class="img" accept="image/*" onchange="previewImage()"></br>
                        Food ID : ${sessionScope.FOOD_UPDATE.foodID}<br>
                        Create date : ${sessionScope.FOOD_UPDATE.createDate}<br>
                        Expiration date : ${sessionScope.FOOD_UPDATE.expirationDate}
                        <input type="hidden" name="txtFoodID" value="${sessionScope.FOOD_UPDATE.foodID}" class="id">
                        </br>

                        Food Name  <input type="text" name="txtFoodName" value="${sessionScope.FOOD_UPDATE.foodName}" class="name">
                        </br>

                        Food price <input type="text" name="txtFoodPrice" value="${sessionScope.FOOD_UPDATE.foodPrice}" class="price">
                        </br>

                        Quantity <input type="text" name="txtQuantity" value="${sessionScope.FOOD_UPDATE.quantity}" class="quantity">
                        </br>

                        Description <input type="text" name="txtDescription" value="${sessionScope.FOOD_UPDATE.description}" class="description">
                        </br>

                        Category <select name="cmbCategory" class="typeFood">

                            <c:forEach var="categoryDto" varStatus="counter" items="${sessionScope.LIST_CATEGORY}">
                                <c:if test="${sessionScope.FOOD_UPDATE.categoryID==categoryDto.categoryID}">
                                    ${categoryDto.categoryName}
                                    <option value="${categoryDto.categoryID}" selected="true">${categoryDto.categoryName}</option>
                                </c:if>  
                                <c:if test="${sessionScope.FOOD_UPDATE.categoryID!=categoryDto.categoryID}">
                                    ${categoryDto.categoryName}
                                    <option value="${categoryDto.categoryID}">${categoryDto.categoryName}</option>
                                </c:if> 
                            </c:forEach>

                        </select></br>


                        Status<select name="cmbStatus" class="status">

                            <c:if test="${sessionScope.FOOD_UPDATE.status==true}">
                                <option value="false">Inactive</option>
                                <option value="true" selected="true">Active</option>
                            </c:if>  
                            <c:if test="${sessionScope.FOOD_UPDATE.status==false}">
                                <option value="false" selected="true">Inactive</option>
                                <option value="true">Active</option>
                            </c:if>  


                        </select>         
                        </br>

                        <input type="submit" name="btnAction" value="Update Food" class="update">

                    </form>
                </c:if>  



            </div>

        </c:if>


        <script>
            function previewImage() {
                var file = document.getElementById("file").files;
                if (file.length > 0) {
                    var fileReader = new FileReader();
                    fileReader.onload = function (event) {
                        document.getElementById("preview").setAttribute("src", event.target.result);
                    };
                    fileReader.readAsDataURL(file[0]);
                }
            }

        </script>
    </body>
</html>
