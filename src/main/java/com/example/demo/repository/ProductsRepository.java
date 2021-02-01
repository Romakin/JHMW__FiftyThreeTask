package com.example.demo.repository;

import org.springframework.core.io.ClassPathResource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Repository;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Repository
public class ProductsRepository {

    private static final String QUERY_SCRIPT_NAME = "productNameWithCustomerName.sql";
    private static final String QUERY_COLUMN_NAME = "name";

    private final NamedParameterJdbcTemplate npjt;

    public ProductsRepository(NamedParameterJdbcTemplate npjt) {
        this.npjt = npjt;
    }

    public List<String> getProductName(String customer) {
        String sqlQuery = read(QUERY_SCRIPT_NAME);
        Map<String, String> pars = new HashMap<>();
        pars.put(QUERY_COLUMN_NAME, customer);
        List<String> result = npjt.queryForList(sqlQuery, pars, String.class);
        System.out.println(result);
        return result;
    }

    public static String read(String scriptName) {
        try(InputStream is = new ClassPathResource(scriptName).getInputStream()) {
            return String.join("\n", readLines(is));
        } catch (IOException ex) {
            throw new RuntimeException(ex);
        }
    }

    private static List<String> readLines(InputStream is) {
        return new BufferedReader(new InputStreamReader(is)).lines().collect(Collectors.toList());
    }

}
