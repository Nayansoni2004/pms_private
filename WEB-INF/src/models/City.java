package models;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.TreeSet;

import utils.DBConnect;

public class City implements Comparable<City> {
    // -----------------field summary------------------------
    private Integer cityId;
    private String city;
    private State state;

    // --------------------constructor----------------------------
    public City() {

    }

    public City(Integer cityId) {
        this.cityId = cityId;
    }

    public City(Integer cityId, String city, State state) {
        this.cityId = cityId;
        this.city = city;
        this.state = state;
    }

    // -------------------other methods------------------------------
    public int compareTo(City ct) {
        return this.city.compareTo(ct.city);
    }

    public static TreeSet<City> collectAllCities() {
        TreeSet<City> cities = new TreeSet<>();

        try {
            Connection con = DBConnect.getConnection();
            String query = "select city_id,city,s.state_id,state from cities as c inner join states as s where c.state_id=s.state_id";

            PreparedStatement ps = con.prepareStatement(query);

            // System.out.println(ps);

            ResultSet rs = ps.executeQuery();

            // System.out.println(rs);

            while (rs.next()) {
                cities.add(new City(rs.getInt("city_id"), rs.getString("city"),
                        new State(rs.getInt("state_id"), rs.getString("state"))));
            }

            con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return cities;
    }

    // --------------------getter & setter methods------------------------------
    public void setCityId(Integer cityId) {
        this.cityId = cityId;
    }

    public Integer getCityId() {
        return cityId;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getCity() {
        return city;
    }

    public void setState(State state) {
        this.state = state;
    }

    public State getState() {
        return state;
    }
}