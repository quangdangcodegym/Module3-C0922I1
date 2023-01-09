package com.codegym.repository;

import com.codegym.model.CustomerType;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class CustomerTypeRepository extends DatabaseContext<CustomerType> {

    public CustomerTypeRepository(){
        modelMapper = new ModelMapper<CustomerType>() {
            @Override
            public CustomerType mapperToModel(ResultSet rs) throws SQLException {
                long id = rs.getLong("id");
                String name = rs.getString("name");
                CustomerType customerType = new CustomerType(id, name);
                return customerType;
            }
        };
    }
    @Override
    public List<CustomerType> getAll() {
        return queryAll("select * from customer_type", modelMapper);
    }

    @Override
    public List<CustomerType> getAllPagging(int offset, int numberOfPage) {
        return null;
    }

    @Override
    public CustomerType findById(long id) {
        return queryFindById("select * from customer_type where id = ?", modelMapper, Long.valueOf(id));
    }

    @Override
    public void add(CustomerType obj) {
        queryDDL( "INSERT INTO `customer_type` (`name`) VALUES (?);",
                obj.getName());
    }

    @Override
    public void update(long id, CustomerType obj) {

    }

    @Override
    public void delete(long id) {

    }
}
