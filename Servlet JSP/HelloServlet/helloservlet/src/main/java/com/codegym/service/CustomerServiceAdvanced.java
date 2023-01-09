package com.codegym.service;

import com.codegym.model.Customer;
import com.codegym.repository.CustomerRepository;

import java.util.List;

public class CustomerServiceAdvanced implements ICustomerService{
    private CustomerRepository customerRepository;
    public CustomerServiceAdvanced() {
        customerRepository = new CustomerRepository();
    }
    @Override
    public List<Customer> getAllCustomers() {
        return customerRepository.getAll();
    }

    @Override
    public Customer findById(long id) {
        return customerRepository.findById(id);
    }

    @Override
    public void updateCustomer(long id, Customer customer) {
        customerRepository.update(id, customer);
    }

    @Override
    public void deleteCustomerById(long id) {
        customerRepository.delete(id);
    }

    @Override
    public void addCustomer(Customer customer) {
        customerRepository.add(customer);
    }
}
