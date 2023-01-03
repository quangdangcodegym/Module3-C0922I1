<%@ page import="com.codegym.Customer" %>
<%@ page import="java.util.List" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" >
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css" integrity="sha512-MV7K8+y+gLIBoVD59lQIYicR65iaqukzvf/nwasF0nqhPay5w/9lJmVM2hMDcnK1OnMGCdVK+iQrJ7lzPJQd1w==" crossorigin="anonymous" referrerpolicy="no-referrer" />
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
        .customers table i:first-child{
            color: brown;
        }
        .customers table i:last-child{
            color: rgb(153, 153, 153);
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
                <div class="customers table-responsive">
                    <h2>List Customer</h2>
                    <div class="alert alert-success">Insert success......</div>
                    <table class="table table-striped ">
                        <thead class="thead-dark">
                            <tr>
                                <th>ID</th>
                                <th>FullName</th>
                                <th>Date of birth</th>
                                <th>Address</th>
                                <th>Image</th>
                                <th>Type Customer</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <c:forEach items="${requestScope.listCustomers}" var="customer">
                            <<tr>
                            <td>${customer.getId()}</td>
                            <td>${customer.getName()}</td>
                            <td>${customer.getAddress()}</td>
                            <td>${customer.getImage()}</td>
                            <td>${customer.getIdType()}</td>
                            <td>${customer.getDateOfBirth()}</td>

                            <td><i class="fa-solid fa-user-plus"></i><i class="fa-solid fa-trash"></i></td>
                            </tr>
                        </c:forEach>
                        <!--
                        List<Customer> customers = (List<Customer>) request.getAttribute("listCustomer");
                            String str = "";
                            for (int i = 0; i < customers.size(); i++) {
                                Customer c = customers.get(i);
                                String temp = String.format("<tr>\n" +
                                        "                            <td>%s</td>\n" +
                                        "                            <td>%s</td>\n" +
                                        "                            <td>%s</td>\n" +
                                        "                            <td>%s</td>\n" +
                                        "                            <td>%s</td>\n" +
                                        "                            <td>%s</td>\n" +
                                        "                            <td><i class=\"fa-solid fa-user-plus\"></i><i class=\"fa-solid fa-trash\"></i></td>\n" +
                                        "                        </tr>", c.getId(), c.getName(), c.getDateOfBirth(), c.getImage(), c.getAddress(), c.getIdType());
                                str += temp;
                            }

                            out.println(str);
                        -->


                    </table>
                    <nav aria-label="Page navigation example" class="row justify-content-end mr-1">
                        <ul class="pagination">
                          <li class="page-item"><a class="page-link" href="#">Previous</a></li>
                          <li class="page-item"><a class="page-link" href="#">1</a></li>
                          <li class="page-item"><a class="page-link" href="#">2</a></li>
                          <li class="page-item"><a class="page-link" href="#">3</a></li>
                          <li class="page-item"><a class="page-link" href="#">Next</a></li>
                        </ul>
                      </nav>
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
</body>
</html>