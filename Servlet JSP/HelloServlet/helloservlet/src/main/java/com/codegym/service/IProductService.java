package com.codegym.service;

import com.codegym.model.Product;

import java.util.List;

public interface IProductService {
    List<Product> getAllProducts();
    Product findById(long id);
    void updateProduct(long id, Product product);
    void deleteProductById(long id);
    void addProduct(Product product);
}
