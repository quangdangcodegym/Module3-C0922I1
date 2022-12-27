package com.codegym;

import java.util.*;

public class IndexMain {
    public List<Product> products;

    public Map<Long, Product> primaryKey;
    public TreeMap<Long, Long> indexPrimaryKey;
    public IndexMain() {
        products = new ArrayList<>();
        products.add(new Product(1L, "Quang Dang", "quang.dang@codegym.vn", "28 NTP" ));
        products.add(new Product(2L, "Tran Cu", "cu.tran@codegym.vn", "28 NTP" ));
        products.add(new Product(7L, "Minh Bui", "minh.bui@codegym.vn", "28 NTP" ));
        products.add(new Product(8L, "Khoa Nguyen", "khoa.nguyen@codegym.vn", "28 NTP" ));
        products.add(new Product(3L, "Thu Le", "thu.le@codegym.vn", "28 NTP" ));
    }

    public void createPrimaryKey() {
        // Sap xep lai
        primaryKey = new TreeMap<>();
        for (Product p : products) {
            primaryKey.put(p.getId(), p);
        }
        System.out.println(primaryKey);

        indexPrimaryKey = new TreeMap<>();
        for (Product p : products) {
            indexPrimaryKey.put(p.getId(), p.getId());
        }
    }

    public void showTable(List<Product> list) {
        for (Product p : list) {
            System.out.println(p);
        }
    }

    public static void main(String[] args) {
        IndexMain indexMain = new IndexMain();
        indexMain.showTable(indexMain.products);

        indexMain.createPrimaryKey();
    }
}
