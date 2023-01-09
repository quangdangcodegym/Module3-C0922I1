package com.codegym.service;


import com.codegym.model.CustomerType;

import java.util.List;

public interface ICustomerTypeService {

    List<CustomerType> getAllCustomerType();
    CustomerType findById(long id);
    void updateCustomerType(long id, CustomerType customer);
    void deleteCustomerTypeById(long id);
    void addCustomerType(CustomerType customer);
}
