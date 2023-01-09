package com.codegym.repository;

import com.codegym.model.Product;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class ProductRepository extends DatabaseContext<Product> {
    public ProductRepository() {
        modelMapper = new ModelMapper<Product>() {
            @Override
            public Product mapperToModel(ResultSet rs) throws SQLException {
                return null;
            }
        };
    }


    @Override
    public List<Product> getAll() {
        return null;
    }

    @Override
    public List<Product> getAllPagging(int offset, int numberOfPage) {
        return null;
    }

    @Override
    public Product findById(long id) {
        return null;
    }

    @Override
    public void add(Product obj) {

    }

    @Override
    public void update(long id, Product obj) {

    }

    @Override
    public void delete(long id) {

    }
}
