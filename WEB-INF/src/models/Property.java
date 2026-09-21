package models;

// import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;

import models.PropertyType.Category;
import utils.DBConnect;
import utils.MyProperty;

public class Property {
    private Integer propertyId;
    private String title;
    private String address;
    private City city;
    private PropertyType propertyType;
    private User user;
    private String description;
    private Status status;
    private Integer totalArea;
    private Integer floors;
    private Integer bhk;

    // #################### listings tab fetch property method ########################
    public static HashSet<Property> searchProperties(Integer cityId, Boolean actionType, String ctgr) throws SQLException {
        HashSet<Property> properties = new HashSet<>();

        Connection con = DBConnect.getConnection();

        if (con != null) {
            String query = "select p.property_id, p.title, p.bhk, p.floors, p.total_area, CONCAT(p.address, ', ' , c.city, '(', s.state, ')') AS address, pa.property_action_id, pa.Post_date, pa.Action_type, pa.amount, pt.type, pt.category, p.user_id, u.name, pm.property_media_id, pm.media_type, pm.media_path from properties as p left join property_actions as pa on p.property_id = pa.property_id left join property_types as pt on p.Property_type_id = pt.Property_type_id left join cities as c on p.city_id = c.city_id left join states as s on c.state_id = s.state_id left join users as u on p.user_id = u.user_id left join property_media as pm on p.property_id = pm.property_id where p.city_id = ? and pa.action_type = ? and pt.category = ? and pm.view_type_id = 5 and media_type = 0"; //media_type = 0 is for exta safety bec, during form submission only image can have view_type_id 5(i.e. main card img).
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, cityId);
            ps.setBoolean(2, actionType);
            ps.setString(3, ctgr);

            ResultSet rs = ps.executeQuery();

            while(rs.next()) {
                Property property = new Property();
                property.setPropertyId(rs.getInt("property_id"));
                property.setTitle(rs.getString("title"));
                property.setBhk(rs.getInt("bhk"));
                property.setFloors(rs.getInt("floors"));
                property.setTotalArea(rs.getInt("total_area"));
                property.setAddress(rs.getString("address"));

                PropertyAction propertyAction = new PropertyAction();
                propertyAction.setPropertyActionId(rs.getInt("property_action_id"));
                propertyAction.setPostDate(rs.getTimestamp("post_date"));
                propertyAction.setActionType(rs.getBoolean("action_type"));
                propertyAction.setAmount(rs.getInt("amount"));

                PropertyType propertyType = new PropertyType();
                propertyType.setType(rs.getString("type"));
                propertyType.setCategory(Category.valueOf(rs.getString("category")));
                
                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setName(rs.getString("name"));

                PropertyMedia propertyMedia = new PropertyMedia();
                propertyMedia.setPropertyMediaId(rs.getInt("property_media_id"));
                propertyMedia.setMediaType(rs.getBoolean("media_type"));
                propertyMedia.setMediaPath(rs.getString("media_path"));
            }

        }
        return properties;
    }

    // #################### dashboard fetch property method ########################
    public static List<MyProperty> collectMyProperties(Connection con, User user) throws SQLException {
        List<MyProperty> myProperties = new ArrayList<>();

        if (con != null) {
            String query = "SELECT p.*, c.city_id, c.city AS city_name, s.state_id, s.state AS state_name, " +
                    "pt.type AS property_type, pt.category AS property_category, st.status AS status_name " +
                    "FROM properties p " +
                    "INNER JOIN cities c ON p.city_id = c.city_id " +
                    "INNER JOIN states s ON c.state_id = s.state_id " +
                    "INNER JOIN property_types pt ON p.property_type_id = pt.property_type_id " +
                    "INNER JOIN status st ON p.status_id = st.status_id " +
                    "WHERE p.user_id = ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, user.getUserId());

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Property property = new Property();
                property.setPropertyId(rs.getInt("property_id"));
                property.setTitle(rs.getString("title"));
                property.setAddress(rs.getString("address"));

                City city = new City();
                city.setCityId(rs.getInt("city_id"));
                city.setCity(rs.getString("city_name"));

                State state = new State();
                state.setStateId(rs.getInt("state_id"));
                state.setState(rs.getString("state_name"));

                city.setState(state);
                property.setCity(city);

                PropertyType propertyType = new PropertyType();
                propertyType.setPropertyTypeId(rs.getInt("property_type_id"));
                propertyType.setType(rs.getString("property_type"));
                propertyType.setCategory(Category.valueOf(rs.getString("property_category")));
                property.setPropertyType(propertyType);

                // property.setUser(user);

                property.setDescription(rs.getString("description"));

                Status status = new Status();
                status.setStatusId(rs.getInt("status_id"));
                status.setStatus(rs.getString("status_name"));
                property.setStatus(status);

                property.setTotalArea(rs.getInt("total_area"));
                property.setFloors(rs.getInt("floors"));
                property.setBhk(rs.getInt("bhk"));

                // myproperty ka sab kuchh yadi set kar diya taki bapas iterate na kerna pade
                // time complexity little bit improve
                MyProperty myProperty = new MyProperty();
                myProperty.setProperty(property);
                myProperty.setPropertyAction(PropertyAction.getPropertyAction(con, property));
                myProperty.setPropertyAreas(PropertyArea.collectAllPropertyAreas(con, property));
                myProperty.setPropertyFeatures(PropertyFeature.collectAllPropertyFeatures(con, property));
                myProperty.setPropertyMedias(PropertyMedia.collectAllPropertyMedias(con, property));
                myProperties.add(myProperty);
            }
        }

        return myProperties;
    }

    // public static List<Property> collectAllProperty(Connection con, User user)
    // throws SQLException {
    // List<Property> properties = new ArrayList<>();

    // if (con != null) {
    // String query = "SELECT p.*, c.city_id, c.city AS city_name, s.state_id,
    // s.state AS state_name, " +
    // "pt.type AS property_type, pt.category AS property_category, st.status AS
    // status_name " +
    // "FROM properties p " +
    // "INNER JOIN cities c ON p.city_id = c.city_id " +
    // "INNER JOIN states s ON c.state_id = s.state_id " +
    // "INNER JOIN property_types pt ON p.property_type_id = pt.property_type_id " +
    // "INNER JOIN status st ON p.status_id = st.status_id " +
    // "WHERE p.user_id = ?";
    // PreparedStatement ps = con.prepareStatement(query);
    // ps.setInt(1, user.getUserId());

    // ResultSet rs = ps.executeQuery();

    // while (rs.next()) {
    // Property property = new Property();
    // property.setPropertyId(rs.getInt("property_id"));
    // property.setTitle(rs.getString("title"));
    // property.setAddress(rs.getString("address"));

    // City city = new City();
    // city.setCityId(rs.getInt("city_id"));
    // city.setCity(rs.getString("city_name"));

    // State state = new State();
    // state.setStateId(rs.getInt("state_id"));
    // state.setState(rs.getString("state_name"));

    // city.setState(state);
    // property.setCity(city);

    // PropertyType propertyType = new PropertyType();
    // propertyType.setPropertyTypeId(rs.getInt("property_type_id"));
    // propertyType.setType(rs.getString("property_type"));
    // propertyType.setCategory(Category.valueOf(rs.getString("property_category")));
    // property.setPropertyType(propertyType);

    // // property.setUser(user);

    // property.setDescription(rs.getString("description"));

    // Status status = new Status();
    // status.setStatusId(rs.getInt("status_id"));
    // status.setStatus(rs.getString("status_name"));
    // property.setStatus(status);

    // property.setTotalArea(rs.getInt("total_area"));
    // property.setFloors(rs.getInt("floors"));
    // property.setBhk(rs.getInt("bhk"));

    // properties.add(property);
    // }
    // }

    // return properties;
    // }

    public void printDetails() {
        System.out.println("############ Property Details ###########");
        System.out.println("Title: " + title);
        System.out.println("Address: " + address);
        System.out.println("City: " + (city != null ? city.getCityId() : "N/A"));
        System.out.println("Property Type: " + (propertyType != null ? propertyType.getPropertyTypeId() : "N/A"));
        System.out.println("User: " + (user != null ? user.getName() + ", id : " + user.getUserId() : "N/A"));
        System.out.println("Description: " + description);
        System.out.println("Status: " + (status != null ? status.getStatusId() : "N/A"));
        System.out.println("Total Area: " + totalArea);
        System.out.println("Floors: " + floors);
        System.out.println("BHK: " + bhk);
        System.out.println("############ End of Details ###########");
    }

    public String getFolderPath() {
        // String path = "WEB-INF/uploads/user" + user.getUserId() + "/my_properties/"
        String path = user.getUserFolder() + "/my_properties/property_" + this.propertyId;

        return path;
    }

    // public boolean makeFolder(){
    // if(propertyId == null)throw new RuntimeException("Property Folder not created
    // : property Id is null");
    // if(user == null)throw new RuntimeException("user not Found : Parent folder
    // not accessible");
    // boolean flag = false;
    // // ki perent folder le aate hai
    // String userFolder = user.getUserFolder();
    // String path = userFolder + "/my_properties/property_" + this.propertyId;
    // File folder = new File(path);

    // if(folder.exists()){
    // flag = true;
    // System.out.println("Folder is Already Exist...");
    // }else {
    // folder.mkdirs();
    // flag = true;
    // }

    // return flag;
    // } //my_properties -> property_ + id

    // ################### save PRoperty ###################
    public boolean save(Connection con) throws SQLException {
        boolean flag = false;

        if (con != null) {
            String query = "insert into properties (title,address,city_id,property_type_id,user_id,description,status_id,total_area,floors,bhk) values (?,?,?,?,?,?,?,?,?,?)";

            PreparedStatement ps = con.prepareStatement(query, PreparedStatement.RETURN_GENERATED_KEYS);

            ps.setString(1, title);
            ps.setString(2, address);
            ps.setInt(3, city.getCityId());
            ps.setInt(4, propertyType.getPropertyTypeId());
            ps.setInt(5, user.getUserId());
            ps.setString(6, description);
            ps.setInt(7, status.getStatusId());
            ps.setInt(8, totalArea);
            ps.setInt(9, floors);
            ps.setInt(10, bhk);

            int res = ps.executeUpdate();

            if (res == 1) {
                ResultSet generatedKeys = ps.getGeneratedKeys();
                if (generatedKeys.next()) {
                    this.propertyId = generatedKeys.getInt(1); // set the auto generated propertyid
                }
                flag = true;
            }
            // con.close();
        }
        return flag;
    }

    @Override
    public String toString() {
        return "Property [propertyId=" + propertyId + ", title=" + title + ", address=" + address + ", city=" + city
                + ", propertyType=" + propertyType + ", user=" + user + ", description=" + description + ", status="
                + status + ", totalArea=" + totalArea + ", floors=" + floors + ", bhk=" + bhk + "]";
    }

    // ################### constructors ###################
    public Property() {
        super();
    }

    public Property(Integer propertyId, String title, String address, City city, PropertyType propertyType, User user,
            String description, Status status, Integer totalArea, Integer floors, Integer bhk) {
        this.propertyId = propertyId;
        this.title = title;
        this.address = address;
        this.city = city;
        this.propertyType = propertyType;
        this.user = user;
        this.description = description;
        this.status = status;
        this.totalArea = totalArea;
        this.floors = floors;
        this.bhk = bhk;
    }

    // ################## getter setters ############################
    public Integer getPropertyId() {
        return propertyId;
    }

    public void setPropertyId(Integer propertyId) {
        this.propertyId = propertyId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public City getCity() {
        return city;
    }

    public void setCity(City city) {
        this.city = city;
    }

    public PropertyType getPropertyType() {
        return propertyType;
    }

    public void setPropertyType(PropertyType propertyType) {
        this.propertyType = propertyType;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Status getStatus() {
        return status;
    }

    public void setStatus(Status status) {
        this.status = status;
    }

    public Integer getTotalArea() {
        return totalArea;
    }

    public void setTotalArea(Integer totalArea) {
        this.totalArea = totalArea;
    }

    public Integer getFloors() {
        return floors;
    }

    public void setFloors(Integer floors) {
        this.floors = floors;
    }

    public Integer getBhk() {
        return bhk;
    }

    public void setBhk(Integer bhk) {
        this.bhk = bhk;
    }
}
