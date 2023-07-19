package org.rivercrane.utils;

import com.opencsv.CSVReader;
import com.opencsv.CSVWriter;
import com.opencsv.exceptions.CsvException;
import com.opencsv.exceptions.CsvValidationException;
import org.rivercrane.models.MstCustomer;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.net.URL;
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

    public List<MstCustomer>  importCustomersFromCSV(String path) throws IOException, CsvException {
        List<MstCustomer> customers = new ArrayList<>();
        try (CSVReader reader = new CSVReader(new FileReader(path))) {
            String[] lineInArray;
            while ((lineInArray = reader.readNext()) != null) {
                MstCustomer customer = MstCustomer.builder()
                        .customerName(lineInArray[0])
                        .email(lineInArray[1])
                        .telNum(lineInArray[2])
                        .address(lineInArray[3])
                        .build();
                customers.add(customer);
            }
        }
        return customers;
    }

    public void exportCustomersToCSV(List<MstCustomer> customers) throws IOException {

        List<String[]> csvData = customersToCsvData(customers);

        // default all fields are enclosed in double quotes
        // default separator is a comma
        try (CSVWriter writer = new CSVWriter(new FileWriter("./src/main/resources/csv/datacustomer.csv"))) {
            writer.writeAll(csvData);
        }
    }

    private static List<String[]> customersToCsvData(List<MstCustomer> customers) {
        List<String[]> data = new ArrayList<>();

        String[] header = {"name", "email", "tel number","address"};
        data.add(header);

        for(MstCustomer i : customers){
            String[] row = {i.getCustomerName(),
                            i.getEmail(),
                            i.getTelNum(),
                            i.getAddress()};
            data.add(row);
        }

        return data;
    }
}
