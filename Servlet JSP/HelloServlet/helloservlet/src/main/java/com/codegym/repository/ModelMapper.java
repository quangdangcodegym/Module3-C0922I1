package com.codegym.repository;

import java.sql.ResultSet;
import java.sql.SQLException;

public interface ModelMapper<T> {
    T mapperToModel(ResultSet rs) throws SQLException;
}