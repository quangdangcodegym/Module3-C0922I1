package com.codegym;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.logging.SimpleFormatter;

@WebServlet(name = "CustomerServlet", urlPatterns = "/customers")
public class CustomerServlet extends HttpServlet {

    private CustomerService customerService;

    @Override
    public void init() throws ServletException {
        customerService = new CustomerService();
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
        RequestDispatcher requestDispatcher = req.getRequestDispatcher("/edit.jsp");
        requestDispatcher.forward(req, resp);

    }

    private void showCustomers(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        List<Customer> customers = customerService.getAllCustomers();
        req.setAttribute("listCustomers", customers);
        RequestDispatcher requestDispatcher = req.getRequestDispatcher("/customers.jsp");
        requestDispatcher.forward(req, resp);
    }

    private void showCreateCustomer(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        RequestDispatcher requestDispatcher = req.getRequestDispatcher("/create.jsp");
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
            default:

        }
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
        RequestDispatcher requestDispatcher = req.getRequestDispatcher("/edit.jsp");
        requestDispatcher.forward(req, resp);

    }

    private void insertCustomer(HttpServletRequest req, HttpServletResponse resp) throws  ServletException, IOException {
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

        Customer customer = new Customer();
        customer.setImage(image);
        customer.setName(fullName);
        customer.setAddress(address);
        customer.setDateOfBirth(dateOfBirth);
        customer.setIdType(idType);

        customerService.addCustomer(customer);

        req.setAttribute("message", "Insert customer success");
        RequestDispatcher requestDispatcher = req.getRequestDispatcher("/create.jsp");
        requestDispatcher.forward(req, resp);
    }
}
