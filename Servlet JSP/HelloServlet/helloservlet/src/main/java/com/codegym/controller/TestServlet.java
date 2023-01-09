package com.codegym.controller;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "TestServlet", urlPatterns = "/test")
public class TestServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession httpSession = req.getSession();
        System.out.println(httpSession.getId());
        if (httpSession.getAttribute("testSession") != null) {
            System.out.println(httpSession.getAttribute("testSession"));
        }
        RequestDispatcher requestDispatcher = req.getRequestDispatcher("/WEB-INF/dashboard/customer/create.jsp");
        requestDispatcher.forward(req, resp);
    }
}
