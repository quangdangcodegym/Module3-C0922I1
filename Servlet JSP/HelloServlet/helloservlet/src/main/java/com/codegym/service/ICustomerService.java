package com.codegym.service;

import com.codegym.model.Customer;

import java.sql.SQLException;
import java.util.List;

public interface ICustomerService {
    List<Customer> getAllCustomers();
    Customer findById(long id);
    void updateCustomer(long id, Customer customer);
    void deleteCustomerById(long id);
    void addCustomer(Customer customer);

}
