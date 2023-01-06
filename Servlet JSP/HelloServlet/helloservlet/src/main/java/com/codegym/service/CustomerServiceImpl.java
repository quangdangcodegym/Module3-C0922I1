package com.codegym.service;

import com.codegym.model.Customer;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CustomerServiceImpl implements ICustomerService {
    private static final String SELECT_ALL_CUSTOMER = "SELECT * FROM customer";
    private static final String SELECT_CUSTOMER_BY_ID = "SELECT * FROM customer where id = ?;";
    private static final String UPDATE_CUSTOMER_BY_ID = "update customer set name = ?,dateofbirth = ?, address = ?, image = ? , id_type = ? where id =?";
    private static final String ADD_CUSTOMER = "INSERT INTO `customer` (`name`, `dateofbirth`, `address`, `id_type`, `image`) VALUES (?, ?, ?, ?, ?);";
    protected String jdbcURL = "jdbc:mysql://localhost:3306/c9_customermanager";
    protected String jdbcUsername = "root";
    protected String jdbcPassword = "St180729!!";


    public Connection getConnection() {
        Connection connection = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return connection;
    }

    @Override
    public List<Customer> getAllCustomers() {
        List<Customer> customers = new ArrayList<>();

        Connection connection = getConnection();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_CUSTOMER);
            ResultSet  rs = preparedStatement.executeQuery();

            while (rs.next()) {
                Customer customer = getCustomerFromRs(rs);
                customers.add(customer);
            }
            System.out.println("getAllCustomers: " + preparedStatement);

        } catch (SQLException e) {
            printSQLException(e);
        }
        return customers;
    }
    private Customer getCustomerFromRs(ResultSet rs) throws SQLException {
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

    public void printSQLException(SQLException ex) {
        for (Throwable e : ex) {
            if (e instanceof SQLException) {
                e.printStackTrace(System.err);
                System.err.println("SQLState: " + ((SQLException) e).getSQLState());
                System.err.println("Error Code: " + ((SQLException) e).getErrorCode());
                System.err.println("Message: " + e.getMessage());
                Throwable t = ex.getCause();
                while (t != null) {
                    System.out.println("Cause: " + t);
                    t = t.getCause();
                }
            }
        }
    }
    @Override
    public Customer findById(long id) {
        Connection connection = getConnection();
        // Statentment, CallableStatement
        // String.fortmat("%s  ")
        try {
            // SELECT * FROM customer where id = ? and name like ?;
            PreparedStatement preparedStatement = connection.prepareStatement(SELECT_CUSTOMER_BY_ID);
            preparedStatement.setLong(1, id);
//            preparedStatement.setString(2, "Quang");

            System.out.println("findById: " + preparedStatement);
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                Customer c = getCustomerFromRs(rs);
                return c;
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return null;
    }

    @Override
    public void updateCustomer(long id, Customer customer) {
        Connection connection = getConnection();
        //update customer set name = ?,dateofbirth = ?, address = ?, image = ? , id_type = ? where id =?
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_CUSTOMER_BY_ID);
            preparedStatement.setString(1, customer.getName());
            preparedStatement.setDate(2, new java.sql.Date(customer.getDateOfBirth().getTime()));
            preparedStatement.setString(3, customer.getAddress());
            preparedStatement.setString(4, customer.getImage());
            preparedStatement.setInt(5, customer.getIdType());
            preparedStatement.setLong(6, customer.getId());


            System.out.println("updateCustomer: " + preparedStatement);
            preparedStatement.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public void deleteCustomerById(long id)  {
        try {
            //DELETE FROM `customer` WHERE (`id` = ?);
            String deleteCustomerQuery = String.format("DELETE FROM `customer` WHERE (`id` = %s);", id);
            // deleteCustomer = DELETE FROM `customer` WHERE (`id` = 1);

            Connection connection = getConnection();
            Statement statement = connection.createStatement();
            statement.executeUpdate(deleteCustomerQuery);
        } catch (SQLException e) {
            printSQLException(e);
        }
    }

    @Override
    public void addCustomer(Customer customer) {

        // "INSERT INTO `customer` (`name`, `dateofbirth`, `address`, `id_type`, `image`)
        // VALUES ( ?, ?, ?, ?, ?);";
        try {
            Connection connection = getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement(ADD_CUSTOMER);
            preparedStatement.setString(1, customer.getName());
            preparedStatement.setDate(2, new java.sql.Date(customer.getDateOfBirth().getTime()));
            preparedStatement.setString(3, customer.getAddress());
            preparedStatement.setInt(4, customer.getIdType());
            preparedStatement.setString(5, customer.getImage());

            System.out.println("addCustomer: " + preparedStatement);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            printSQLException(e);
        }
    }
}
