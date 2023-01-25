<%-- 
    Document   : createFood
    Created on : Jan 7, 2021, 12:54:12 PM
    Author     : minhv
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create Page</title>
        <link href="CSS/createFood.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <c:if test="${requestScope.FOOD_ERROR ==null}">
            <c:set var="requestScope.FOOD_ERROR.foodIDError" value=""/>
            <c:set var="requestScope.FOOD_ERROR.foodNameError" value=""/>
            <c:set var="requestScope.FOOD_ERROR.foodPriceError" value=""/>
            <c:set var="requestScope.FOOD_ERROR.quantityError" value=""/>
            <c:set var="requestScope.FOOD_ERROR.descriptionError" value=""/>
            <c:set var="requestScope.FOOD_ERROR.createDateError" value=""/>
            
            <c:set var="requestScope.FOOD_ERROR.expirationDateError" value=""/>
            <c:set var="requestScope.FOOD_ERROR.linkImgError" value=""/>
            <c:set var="requestScope.FOOD_ERROR.categoryIDError" value=""/>
            <c:set var="requestScope.FOOD_ERROR.statusError" value=""/>
        </c:if>
        <c:if test="${sessionScope.LOGIN_USER==null  || sessionScope.LOGIN_USER.roleID =='US' || sessionScope.LOGIN_USER.roleID =='EMAIL'}">          
            <h3>You must be a Admin to create food, please <a href="MainController?btnAction=Logout">Login</a> with admin account</h3>
        </c:if>

        <c:if test="${sessionScope.LOGIN_USER!=null && sessionScope.LOGIN_USER.roleID =='AD'}">
            <a href="MainController?btnAction=Logout" class="logout">Logout</a><br>
               <h2>Admin: ${sessionScope.LOGIN_USER.fullName}</h2>
               <div>     
                    <h1>Create food </h1>
                    <c:if test="${sessionScope.LIST_CATEGORY!=null}">          
                        <form action="MainController" method="POST" class="main-layout">
                            Food ID<input type="text" name="txtFoodID" class="id">
                            ${requestScope.FOOD_ERROR.foodIDError}</br>
                            
                            Food Name<input type="text" name="txtFoodName" class="name">
                            ${requestScope.FOOD_ERROR.foodNameError}</br>
                            
                            Food price<input type="text" name="txtPrice" class="price">
                            ${requestScope.FOOD_ERROR.foodPriceError}</br>

                            Quantity<input type="text" name="txtQuantity" class="quantity">
                            ${requestScope.FOOD_ERROR.quantityError}</br>

                            Description<input type="text" name="txtDescription" class="description">
                            ${requestScope.FOOD_ERROR.descriptionError}</br>
                            
                            Expiration date<input type="date" name="txtExpirationDate" class="expirationdate">
                            ${requestScope.FOOD_ERROR.expirationDateError}</br>
                            
                            Category <select name="cmbCategory" class="typeFood">
                                <c:forEach var="categoryDto" varStatus="counter" items="${sessionScope.LIST_CATEGORY}">
                                    <option value="${categoryDto.categoryID}">${categoryDto.categoryName}</option>
                                </c:forEach>
                                 
                            </select></br>

                            Img<input type="file" name="txtFile" id="file" class="img" accept="image/*" onchange="previewImage()">
                                      
                            ${requestScope.FOOD_ERROR.linkImgError}</br>

                            <input type="submit" name="btnAction" value="Create Food" class="create">
                            <input type="reset"  value="Reset" class="reset">
                        </form>
                    </c:if>
                    
                        
                    
               </div>
        
            <script>
            function previewImage(){
                var file=document.getElementById("file").files;
                if(file.length >0){
                    var fileReader=new FileReader();
                    fileReader.onload =function (event){
                        document.getElementById("preview").setAttribute("src",event.target.result);
                    };
                    fileReader.readAsDataURL(file[0]);
                }
            }
            
            </script>    
        </c:if>
            
            
            
   
    </body>
</html>
