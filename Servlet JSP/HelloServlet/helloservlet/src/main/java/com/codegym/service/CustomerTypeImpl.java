package com.codegym.service;

import com.codegym.model.CustomerType;
import com.codegym.repository.CustomerTypeRepository;

import java.util.List;

public class CustomerTypeImpl implements ICustomerTypeService {
    private CustomerTypeRepository customerTypeRepository;
    public CustomerTypeImpl() {
        customerTypeRepository = new CustomerTypeRepository();
    }
    @Override
    public List<CustomerType> getAllCustomerType() {
        return customerTypeRepository.getAll();
    }

    @Override
    public CustomerType findById(long id) {
        return customerTypeRepository.findById(id);
    }

    @Override
    public void updateCustomerType(long id, CustomerType customer) {

    }

    @Override
    public void deleteCustomerTypeById(long id) {

    }

    @Override
    public void addCustomerType(CustomerType customer) {

    }
}
