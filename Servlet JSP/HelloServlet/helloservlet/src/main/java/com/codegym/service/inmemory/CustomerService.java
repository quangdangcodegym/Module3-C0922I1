package com.codegym.service.inmemory;

import com.codegym.model.Customer;
import com.codegym.service.ICustomerService;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class CustomerService implements ICustomerService {
    private List<Customer> customers;
    public CustomerService() {
        customers = new ArrayList<>();
        //(Long id, String name, Date dateOfBirth, String address, String image, int idType) {
        customers.add(new Customer(1L, "Quang Dang", new Date(), "28 NTP", "https://genk.mediacdn.vn/thumb_w/640/2018/2/7/1-1517994021909941711696.png", 1));
        customers.add(new Customer(2L, "Luu Diec Phi", new Date(), "28 NTP", "https://genk.mediacdn.vn/thumb_w/640/2018/2/7/4-15179940772361907329219.png", 1));
    }
    public List<Customer> getAllCustomers() {
        return customers;
    }

    public Customer findById(long id) {
        for (Customer c : customers) {
            if (c.getId() == id) {
                return c;
            }
        }
        return null;
    }

    public void updateCustomer(long id, Customer customer) {
        for (Customer c : customers) {
            if (c.getId() == id) {
                c.setAddress(customer.getAddress());
                c.setDateOfBirth(customer.getDateOfBirth());
                c.setIdType(customer.getIdType());
                c.setName(customer.getName());
                c.setImage(customer.getImage());
            }
        }
    }

    public void deleteCustomerById(long id) {
        for (int i = 0; i < customers.size(); i++) {
            if (customers.get(i).getId() == id) {
                customers.remove(i);
            }
        }
    }

    public void addCustomer(Customer customer) {
        customer.setId((long) customers.size());

        customers.add(customer);
    }
}
