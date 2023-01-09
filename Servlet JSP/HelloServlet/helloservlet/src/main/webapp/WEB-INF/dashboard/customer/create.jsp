<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <title>Form Elements | Zircos - Responsive Bootstrap 4 Admin Dashboard</title>
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
                                            <li class="breadcrumb-item"><a href="javascript: void(0);">Forms</a></li>
                                            <li class="breadcrumb-item active">Form elements</li>
                                        </ol>
                                    </div>
                                    <h4 class="page-title">Form elements</h4>
                                </div>
                            </div>
                        </div>
                        <!-- end page title -->

                        <div class="row">

                            <form class="form-horizontal container row" action="/customers?action=create" method="post">
                                <div class="col-6 offset-3">
                                    <c:if test="${requestScope.errors.isEmpty() == false}">
                                        <div class="alert alert-danger">
                                            <ul>
                                                <c:forEach items="${requestScope.errors}" var="error">
                                                    <li>${error}</li>
                                                </c:forEach>
                                            </ul>
                                        </div>
                                    </c:if>
                                    <div class="form-group row">
                                        <label class="col-2">Fullname</label>
                                        <div class="col-10">
                                            <input type="text" value="${requestScope.customer.getName()}" class="form-control" name="txtFullName">
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-2">Address</label>
                                        <div class="col-10">
                                            <input type="text" value="${requestScope.customer.getAddress()}" class="form-control" name="txtAddress">
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-2">Image</label>
                                        <div class="col-10">
                                            <input type="text" value="${requestScope.customer.getImage()}" name="txtImage"  class="form-control">
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-2">Date of birth</label>
                                        <div class="col-10">
                                            <input type="date" value="<fmt:formatDate pattern = "yyyy-MM-dd"
         value = "${requestScope.customer.getDateOfBirth()}" />" name="txtDateOfBirth" class="form-control">
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-2">Type customer</label>
                                        <div class="col-10">
                                            <select class="form-control"  name="txtIdType">
                                                <c:forEach items="${applicationScope.listCustomerType}" var="customerType">
                                                    <option value="${customerType.getId()}">${customerType.getName()}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group row">

                                        <div class="col-10 offset-2">
                                            <input type="submit" value="Create" />
                                            <input type="submit" value="Back" />
                                        </div>
                                    </div>
                                </div>
                            </form>
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

        <!-- Right Sidebar -->
        <jsp:include page="/WEB-INF/dashboard/layout/rightbar.jsp"></jsp:include>

        <jsp:include page="/WEB-INF/dashboard/layout/js_footer.jsp">
            <jsp:param name="page" value="create"/>
        </jsp:include>


    </body>

</html>