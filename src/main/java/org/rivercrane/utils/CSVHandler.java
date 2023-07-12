package org.rivercrane.utils;

import com.opencsv.CSVReader;
import com.opencsv.CSVWriter;
import com.opencsv.exceptions.CsvException;
import org.rivercrane.models.MstCustomer;

import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class CSVHandler {
    private static CSVHandler instance = new CSVHandler();
    private CSVHandler(){}
    public static CSVHandler getInstance(){
        return instance;
    }

    public List<MstCustomer> readCustomersFromCSV(String fileName){
        List<MstCustomer> customers = new ArrayList<>();
        try (CSVReader reader = new CSVReader(new FileReader("/"))) {
            List<String[]> r = reader.readAll();
            r.forEach(x -> System.out.println(Arrays.toString(x)));
        } catch (IOException e) {
            throw new RuntimeException(e);
        } catch (CsvException e) {
            throw new RuntimeException(e);
        }
        return customers;
    }

    public void exportCustomersToCSV(List<MstCustomer> customers) throws IOException {

        List<String[]> csvData = customersToCsvData(customers);

        // default all fields are enclosed in double quotes
        // default separator is a comma
        try (CSVWriter writer = new CSVWriter(new FileWriter("C:\\OneDrive-HCMUS\\OneDrive - VNU-HCMUS\\Desktop\\Internship Rivercrane\\app\\src\\main\\resources\\csv\\test.csv"))) {
            writer.writeAll(csvData);
        }
    }

    private static List<String[]> customersToCsvData(List<MstCustomer> customers) {
        List<String[]> data = new ArrayList<>();

        String[] header = {"id", "name", "email", "tel number","address", "is active?", "created at", "updated at"};
        data.add(header);

        for(MstCustomer i : customers){
            String[] row = {i.getCustomerId().toString(),
                            i.getCustomerName(),
                            i.getEmail(),
                            i.getTelNum(),
                            i.getAddress(),
                            i.getIsActive() == null ? "null" :  i.getIsActive().toString(),
                            i.getCreatedAt() == null ? "null" :  i.getCreatedAt().toString(),
                            i.getUpdatedAt() == null ? "null" :  i.getUpdatedAt().toString()};
            data.add(row);
        }

        return data;
    }
}
