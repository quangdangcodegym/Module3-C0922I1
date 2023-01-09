<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <title>Basic Tables | Zircos - Responsive Bootstrap 4 Admin Dashboard</title>
        <jsp:include page="/WEB-INF/dashboard/layout/css_head.jsp"></jsp:include>

    </head>

    <body data-layout="horizontal">

        <!-- Begin page -->
        <div id="wrapper">

            <!-- Navigation Bar-->
            <jsp:include page="/WEB-INF/dashboard/layout/topnav.jsp"></jsp:include>
                <!-- End Navigation Bar-->

            <!-- ============================================================== -->
            <!-- Start Page Content here -->
            <!-- ============================================================== -->

            <div class="content-page">
                <div class="content">

                    <!-- Start Content-->
                    <div class="container-fluid">

                        <!-- start page title -->
                        <div class="row">
                            <div class="col-12">
                                <div class="page-title-box">
                                    <div class="page-title-right">
                                        <ol class="breadcrumb m-0">
                                            <li class="breadcrumb-item"><a href="javascript: void(0);">Zircos</a></li>
                                            <li class="breadcrumb-item"><a href="javascript: void(0);">Tables</a></li>
                                            <li class="breadcrumb-item active">Basic Tables</li>
                                        </ol>
                                    </div>
                                    <h4 class="page-title">Basic Tables</h4>
                                </div>
                            </div>
                        </div>
                        <!-- end page title -->

                        <div class="row">
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
                                    <tr>
                                    <td>${customer.getId()}</td>
                                    <td>${customer.getName()}</td>
                                    <td>${customer.getAddress()}</td>
                                    <td><img width="100px" height="100px" src="${customer.getImage()}" /></td>
                                    <td>${customer.getIdType()}</td>
                                    <td><fmt:formatDate pattern = "yyyy-MM-dd"
                                                        value = "${customer.getDateOfBirth()}" /></td>

                                    <td>
                                        <a href="/customers?action=edit&id=${customer.getId()}"><i class="fa-solid fa-user-plus"></i></a>
                                        <a id="deleteId${customer.getId()}" data-id="${customer.getId()}" data-name="${customer.getName()}"><i class="fa-solid fa-trash"></i></a>
                                    </td>
                                    </tr>
                                </c:forEach>
                            </table>
                            <!-- end col -->
                        </div>
                        <!-- end row -->

                    </div>
                    <!-- end container-fluid -->

                </div>
                <!-- end content -->

                

                <!-- Footer Start -->
                <jsp:include page="/WEB-INF/dashboard/layout/footer.jsp"></jsp:include>
                <!-- end Footer -->

            </div>

            <!-- ============================================================== -->
            <!-- End Page content -->
            <!-- ============================================================== -->

        </div>
        <!-- END wrapper -->

        <jsp:include page="/WEB-INF/dashboard/layout/rightbar.jsp"></jsp:include>

        <jsp:include page="/WEB-INF/dashboard/layout/js_footer.jsp">
            <jsp:param name="page" value="customers"/>
        </jsp:include>

    </body>

</html>