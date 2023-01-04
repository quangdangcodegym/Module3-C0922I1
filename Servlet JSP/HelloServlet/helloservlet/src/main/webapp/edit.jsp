<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Document</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.1/dist/jquery.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
  <style>
    .menu ul{
      list-style: none;
      padding: 0;
      margin: 0;
      display: flex;

    }
    .menu{
      background-color: #f8f9fa;
    }
    .menu ul li{
      padding: 10px;
    }
    #menulogin a{
      float: right;
      padding-top: 10px;
    }
    .main{
      background-color: gainsboro;
      min-height: 550px;
    }
    .main-center{
      background-color: white;
    }
    .footer{
      background-color: darkgrey;
    }

  </style>
</head>
<body>
<div class="container-md">
  <div class="row menu">
    <div class="col-sm-9 p-0">
      <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <a class="navbar-brand" href="#">Navbar</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarSupportedContent">
          <ul class="navbar-nav mr-auto">
            <li class="nav-item active">
              <a class="nav-link" href="#">Home <span class="sr-only">(current)</span></a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#">Link</a>
            </li>
            <li class="nav-item dropdown">
              <a class="nav-link dropdown-toggle" href="#" role="button" data-toggle="dropdown" aria-expanded="false">
                Dropdown
              </a>
              <div class="dropdown-menu">
                <a class="dropdown-item" href="#">Action</a>
                <a class="dropdown-item" href="#">Another action</a>
                <div class="dropdown-divider"></div>
                <a class="dropdown-item" href="#">Something else here</a>
              </div>
            </li>
            <li class="nav-item">
              <a class="nav-link disabled">Disabled</a>
            </li>
          </ul>
          <form class="form-inline my-2 my-lg-0">
            <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
            <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
          </form>
        </div>
      </nav>
    </div>
    <div class="col-sm-3" id="menulogin">
      <a href="">Login</a>
    </div>
  </div>
  <div class="row main">
    <div class="col-sm-2 p-0">
      <ul class="list-group">
        <li class="list-group-item d-flex justify-content-between align-items-center">
          A list item
          <span class="badge badge-primary badge-pill">14</span>
        </li>
        <li class="list-group-item d-flex justify-content-between align-items-center">
          A second list item
          <span class="badge badge-primary badge-pill">2</span>
        </li>
        <li class="list-group-item d-flex justify-content-between align-items-center">
          A third list item
          <span class="badge badge-primary badge-pill">1</span>
        </li>
      </ul>
    </div>
    <div class="col-sm-8 main-center row justify-content-center">
      <div class="login col-8">
        <h1>Edit Customer</h1>
        <div class="toast" data-autohide="false" style="position: fixed; top: 10px; right: 10px;">
          <div class="toast-header">
            <strong class="mr-auto text-primary">Edit customer</strong>
            <small class="text-muted">5 mins ago</small>
            <button type="button" class="ml-2 mb-1 close" data-dismiss="toast">&times;</button>
          </div>
          <div class="toast-body">
            Edit success....ahii
          </div>
        </div>
        <form method="post" >
          <div class="row mb-2">
            <div class="col-3">
              <label for="idTxtFullName">FullName</label>
            </div>
            <div class="col-9">
              <input type="text" id="idTxtFullName" value="${requestScope.customer.getName()}" name="txtFullName" class="form-control" placeholder="full name">
            </div>
          </div>
          <div class="row mb-2">
            <div class="col-3">
              <label for="idDateOfBirth">Date of birth</label>
            </div>
            <div class="col-9">
              <input type="date" id="idDateOfBirth" value="<fmt:formatDate pattern = "yyyy-MM-dd"
         value = "${requestScope.customer.getDateOfBirth()}" />" name="txtDateOfBirth"  class="form-control" >
            </div>
          </div>
          <div class="row mb-2">
            <div class="col-3">
              <label for="idAddress">Address</label>
            </div>
            <div class="col-9">
              <input type="text" id="idAddress" value="${requestScope.customer.getAddress()}" name="txtAddress"  class="form-control" >
            </div>
          </div>
          <div class="row mb-2">
            <div class="col-3">
              <label for="idImage">Image</label>
            </div>
            <div class="col-9">
              <input type="text" id="idImage" name="txtImage" value="${requestScope.customer.getImage()}"  class="form-control" >
            </div>
          </div>
          <div class="row mb-2">
            <div class="col-3">
              <label for="idType">Type Customer</label>
            </div>
            <div class="col-9">
              <input type="number" id="idType" value="${requestScope.customer.getIdType()}" name="txtIdType"  class="form-control" >
            </div>
          </div>
          <div class="row">
            <div class="col-9 offset-3">
              <button class="btn btn-primary">Edit</button>
              <a class="btn btn-primary" href="/customers">Back</a>

            </div>
          </div>
        </form>
      </div>
    </div>
    <div class="col-sm-2">
      <div>ADS</div>
      <div>ADS</div>
    </div>
  </div>
  <div class="row footer">
    <div class="col-12 row justify-content-center">
      <a href="">Footer</a>
    </div>
  </div>
</div>
<c:if test="${requestScope.message!=null}">
    <script>
      window.onload = ()=>{
          let message = '<%= request.getAttribute("message")%>';
          document.querySelector(".toast-body").innerText = message;

        $('.toast').toast({delay: 5000});
        $('.toast').toast('show');
      }
    </script>
</c:if>
<script>
  /**
    window.onload = ()=>{
      $('.toast').toast('show');
    }
    $(document).ready(function(){
      $('.toast').toast('show');
    });
   **/
</script>
</body>
</html>