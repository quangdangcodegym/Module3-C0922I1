<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <title>Danh sách</title>
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
                                    <h4 class="page-title">Dánh sách customer</h4>
                                </div>
                            </div>
                        </div>
                        <!-- end page title -->

                        <div class="row justify-content-end">
                            <div>
                                <div id="frmDeleteConfirm" class="modal fade" role="dialog">
                                    <div class="modal-dialog">

                                        <!-- Modal content-->
                                        <div class="modal-content">
                                            <form action="/customers?action=delete" method="post" id="frmDelete">
                                                <div class="modal-header">
                                                    <h4 class="modal-title">Confirm Delete</h4>
                                                </div>
                                                <div class="modal-body">
                                                    <input type="hidden" id="idFrmDeleteConfirm" name="idFrmDeleteConfirm"  />
                                                    <input type="hidden" name="kw" value="${requestScope.kw}">
                                                    <input type="hidden" name="currentPage" value="${requestScope.currentPage}">
                                                    <input type="hidden" name="customerType" value="${requestScope.idSlCustomerType}">
                                                    <input type="hidden" name="noOfPages" value="${requestScope.noOfPages}">

                                                    <p id="nameFrmDeleteConfirm">Name....?</p>
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-primary" data-dismiss="modal">Close</button>
                                                    <button type="submit" class="btn btn-primary" data-dismiss="modal" onclick="handleDeleteCustomer()">Delete</button>
                                                </div>
                                            </form>
                                        </div>

                                    </div>
                                </div>
                                <form method="get" action="/customers">
                                    <div class="input-group rounded">
                                        <input value="${requestScope.kw}" name="kw" type="search" class="form-control rounded" placeholder="Search" aria-label="Search" aria-describedby="search-addon" />

                                        <select name="idSlCustomerType">
                                            <option value="-1">All</option>
                                            <c:forEach items="${applicationScope.listCustomerType}" var="cType">
                                                <option value="${cType.getId()}"
                                                        <c:if test="${requestScope.idSlCustomerType == cType.getId()}">selected</c:if>
                                                >${cType.getName()}</option>
                                            </c:forEach>
                                        </select>
                                        <input type="submit" class="btn btn-primary" value="Search">
                                    </div>
                                </form>
                            </div>
                            <table class="table table-striped ">
                                <thead class="thead-dark">
                                <tr>
                                    <th>ID</th>
                                    <th>FullName</th>
                                    <th>Address</th>
                                    <th>Image</th>
                                    <th>Type customer</th>
                                    <th>Date of birth</th>
                                    <th>Action</th>
                                </tr>
                                </thead>
                                <c:forEach items="${requestScope.listCustomers}" var="customer">
                                    <tr>
                                    <td>${customer.getId()}</td>
                                    <td>${customer.getName()}</td>
                                    <td>${customer.getAddress()}</td>
                                    <td><img width="100px" height="100px" src="${customer.getImage()}" /></td>
                                    <td>
                                            <c:forEach items="${applicationScope.listCustomerType}" var="cType">
                                                <c:if test="${cType.getId() == customer.getIdType()}">
                                                    ${cType.getName()}
                                                </c:if>
                                            </c:forEach>

                                    </td>
                                    <td><fmt:formatDate pattern = "yyyy-MM-dd"
                                                        value = "${customer.getDateOfBirth()}" /></td>

                                    <td>
                                        <a href="/customers?action=edit&id=${customer.getId()}"><i class="fa-solid fa-user-plus"></i></a>
                                        <a id="deleteId${customer.getId()}" data-id="${customer.getId()}" data-name="${customer.getName()}"><i class="fa-solid fa-trash"></i></a>
                                    </td>
                                    </tr>
                                </c:forEach>
                            </table>

                            <ul class="pagination pagination-split float-right mb-0">
                                <c:if test="${currentPage != 1}">
                                    <li class="page-item">
                                        <a href="/customers?kw=${requestScope.kw}&idSlCustomerType=${requestScope.idSlCustomerType}&page=${currentPage-1}" class="page-link"><i class="fa fa-angle-left"></i></a>
                                    </li>
                                </c:if>
                                <c:forEach begin="1" end="${noOfPages}" var="i">
                                    <c:choose>
                                        <c:when test="${currentPage eq i}">
                                            <li class="page-item active">
                                                <a href="/customers?kw=${requestScope.kw}&idSlCustomerType=${requestScope.idSlCustomerType}&page=${i}" class="page-link">${i}</a>
                                            </li>
                                        </c:when>
                                        <c:otherwise>
                                            <li class="page-item">
                                                <a href="/customers?kw=${requestScope.kw}&idSlCustomerType=${requestScope.idSlCustomerType}&page=${i}" class="page-link">${i}</a>
                                            </li>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                                <c:if test="${currentPage lt noOfPages}">
                                    <li class="page-item">
                                        <a href="/customers?kw=${requestScope.kw}&idSlCustomerType=${requestScope.idSlCustomerType}&page=${currentPage+1}" class="page-link"><i class="fa fa-angle-right"></i></a>
                                    </li>
                                </c:if>
                            </ul>
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
    <script>
        window.onload = ()=>{
            let items = document.querySelectorAll("[id*=deleteId]");
            console.log(items);
            items.forEach((item)=>{
                item.addEventListener("click", (event)=>{
                    let id = event.target.parentElement.getAttribute('data-id');
                    let name = event.target.parentElement.getAttribute('data-name');
                    // let strId = event.target.parentElement.id;
                    document.getElementById("idFrmDeleteConfirm").value = id;
                    document.getElementById("nameFrmDeleteConfirm").innerText = name;

                    $("#frmDeleteConfirm").modal();

                });
            })
        }

        function handleDeleteCustomer(){
            document.getElementById("frmDelete").submit();
        }
    </script>
</html>