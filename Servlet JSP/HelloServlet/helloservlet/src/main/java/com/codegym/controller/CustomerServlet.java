package com.codegym.controller;

import com.codegym.model.Customer;
import com.codegym.model.CustomerType;
import com.codegym.service.*;
import com.codegym.utils.ValidateUtils;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@WebServlet(name = "CustomerServlet", urlPatterns = "/customers")
public class CustomerServlet extends HttpServlet {

    private ICustomerService customerService;
    private ICustomerTypeService customerTypeService;

    @Override
    public void init() throws ServletException {
        customerService = new CustomerServiceAdvanced();
        customerTypeService = new CustomerTypeImpl();

        List<CustomerType> customerTypes = customerTypeService.getAllCustomerType();
        if (getServletContext().getAttribute("listCustomerType") == null) {
            getServletContext().setAttribute("listCustomerType", customerTypes);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) {
            action = "";
        }
        switch (action) {
            case "create":
                showCreateCustomer(req, resp);
                break;
            case "edit":
                showEditCustomer(req, resp);
                break;

            default:
                showCustomers(req, resp);
        }

    }

    private void showEditCustomer(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        long id = Long.parseLong(req.getParameter("id"));
        Customer customer = customerService.findById(id);

        req.setAttribute("customer", customer);
        RequestDispatcher requestDispatcher = req.getRequestDispatcher("/WEB-INF/dashboard/customer/edit.jsp");
        requestDispatcher.forward(req, resp);

    }

    private void showCustomers(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        List<Customer> customers = customerService.getAllCustomers();
        req.setAttribute("listCustomers", customers);
        RequestDispatcher requestDispatcher = req.getRequestDispatcher("/WEB-INF/dashboard/customer//customers.jsp");
        requestDispatcher.forward(req, resp);
    }

    private void showCreateCustomer(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession httpSession = req.getSession();
        System.out.println(httpSession.getId());
        httpSession.setAttribute("testSession", "testSession.....");



        RequestDispatcher requestDispatcher = req.getRequestDispatcher("/WEB-INF/dashboard/customer/create.jsp");
        requestDispatcher.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) {
            action = "";
        }
        switch (action) {
            case "create":
                insertCustomer(req, resp);
                break;
            case "edit":
                editCustomer(req, resp);
                break;
            case "delete":
                deleteCustomer(req, resp);
                break;
            default:

        }
    }

    private void deleteCustomer(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        long id = Long.parseLong(req.getParameter("idFrmDeleteConfirm"));
        Customer customer = customerService.findById(id);
        if (customer != null) {
            // Xóa
            customerService.deleteCustomerById(id);
            req.setAttribute("message", "Delete success!");
        }else{
            req.setAttribute("message", "Customer not exists");
        }

        showCustomers(req, resp);

    }

    private void editCustomer(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String fullName = req.getParameter("txtFullName");
        String pattern = "yyyy-MM-dd";
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);


        Date dateOfBirth = null;
        try {
            dateOfBirth = simpleDateFormat.parse(req.getParameter("txtDateOfBirth"));
        } catch (ParseException e) {
            throw new RuntimeException(e);
        }
        String address = req.getParameter("txtAddress");
        String image = req.getParameter("txtImage");
        int idType = Integer.parseInt(req.getParameter("txtIdType"));

        long id = Long.parseLong(req.getParameter("id"));
        Customer customer = customerService.findById(id);
        customer.setImage(image);
        customer.setName(fullName);
        customer.setDateOfBirth(dateOfBirth);
        customer.setAddress(address);
        customer.setIdType(idType);

        customerService.updateCustomer(id, customer);

        req.setAttribute("message", "Edit success.......");
        RequestDispatcher requestDispatcher = req.getRequestDispatcher("/WEB-INF/dashboard/customer/edit.jsp");
        requestDispatcher.forward(req, resp);

    }

    private void insertCustomer(HttpServletRequest req, HttpServletResponse resp) throws  ServletException, IOException {
        List<String> errors = new ArrayList<>();
        Customer customer = new Customer();




        validateFullName(req, errors, customer);
        validateImage(req, errors, customer);
        validateTypeCustomer(req, errors, customer);
        validateDateOfBirth(req, errors, customer);

        String address = req.getParameter("txtAddress");
        customer.setAddress(address);



        if (errors.size() != 0) {
            req.setAttribute("errors", errors);
            req.setAttribute("customer", customer);
        }else{
            customerService.addCustomer(customer);
            req.setAttribute("message", "Insert customer success");
        }
        RequestDispatcher requestDispatcher = req.getRequestDispatcher("/WEB-INF/dashboard/customer/create.jsp");
        requestDispatcher.forward(req, resp);
    }

    private void validateDateOfBirth(HttpServletRequest req, List<String> errors, Customer customer) {
        String pattern = "yyyy-MM-dd";
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);
        Date dateOfBirth = null;
        try {
            dateOfBirth = simpleDateFormat.parse(req.getParameter("txtDateOfBirth"));
            customer.setDateOfBirth(dateOfBirth);
        } catch (ParseException e) {
            errors.add("Ngày sinh không hợp lệ");
            customer.setDateOfBirth(new Date());
        }
    }

    private void validateTypeCustomer(HttpServletRequest req, List<String> errors, Customer customer) {
        try {
            int idType = Integer.parseInt(req.getParameter("txtIdType"));
            //
            if (idType > 2) {
                errors.add("Kiểu khách hàng không hợp lệ");
            }else{
                customer.setIdType(idType);
            }

        } catch (NumberFormatException ex) {
            errors.add("Kiểu khách hàng không hợp lệ");
        }
    }

    private void validateImage(HttpServletRequest req, List<String> errors, Customer customer) {
        String image = req.getParameter("txtImage");
        if (image.equals("")) {
            errors.add("Hình ảnh được rỗng");
        }
        customer.setImage(image);
    }

    private void validateFullName(HttpServletRequest req, List<String> errors, Customer customer) {
        String fullName = req.getParameter("txtFullName");
        if (!ValidateUtils.isFulllNameValid(fullName)) {
            errors.add("FullName phải là kí tự và có từ 8-20 kí tự");
        }
        customer.setName(fullName);
    }

}
