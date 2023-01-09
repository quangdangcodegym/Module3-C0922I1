package com.codegym.repository;

import com.codegym.model.Customer;

import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class CustomerRepository extends DatabaseContext<Customer> {
        public CustomerRepository() {
            modelMapper = new ModelMapper<Customer>() {
                @Override
                public Customer mapperToModel(ResultSet rs) throws SQLException {
                    long idCustomer = rs.getLong("id");
                    String name = rs.getString("name");
                    Date dateOfBirth = rs.getDate("dateofbirth");
                    String address = rs.getString("address");
                    int idType = rs.getInt("id_type");
                    String image = rs.getString("image");

                    Customer customer = new Customer();
                    customer.setId(idCustomer);
                    customer.setName(name);
                    customer.setImage(image);
                    customer.setAddress(address);
                    customer.setDateOfBirth(dateOfBirth);
                    customer.setIdType(idType);
                    return customer;
                }
            };
        }

    @Override
    public List<Customer> getAll() {
        return queryAll("select * from Customer", modelMapper);
    }

    @Override
    public List<Customer> getAllPagging(int offset, int numberOfPage) {
        return null;
    }

    @Override
    public Customer findById(long id) {
        return queryFindById("select * from Customer where id = ?", modelMapper, Long.valueOf(id));
    }

    @Override
    public void add(Customer obj) {
        queryDDL( "INSERT INTO `customer` (`name`, `dateofbirth`, `address`, `id_type`, `image`) VALUES (?, ?, ?, ?, ?);",
                obj.getName(), new java.sql.Date(obj.getDateOfBirth().getTime()), obj.getAddress(), obj.getIdType(), obj.getImage());

    }

    @Override
    public void update(long id, Customer obj) {
        queryDDL("update customer set name = ?,dateofbirth = ?, address = ?, image = ? , id_type = ? where id =?",
                obj.getName(), new java.sql.Date(obj.getDateOfBirth().getTime()), obj.getAddress(), obj.getImage(), obj.getIdType(), id);
    }

    @Override
    public void delete(long id) {
        queryDDL("DELETE FROM `customer` WHERE (`id` = ?);", Long.valueOf(id));
    }
}
