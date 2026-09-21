package models;

// import java.util.Locale.Category;

// isko sudharna hai sql se saam: sudhar gyi h
public class PropertyType {
    private Integer propertyTypeId;
    private String type; // eg. Flat/Apartment, Office, ....
    private Category category;

    public enum Category {
        Residential, Commercial
    }

    // Constructor
    public PropertyType(Integer propertyTypeId, String type, Category category) {
        this.propertyTypeId = propertyTypeId;
        this.type = type;
        this.category = category;
    }

    // Default Constructor
    public PropertyType() {
        super();
    }

    // Getters and Setters
    public int getPropertyTypeId() {
        return propertyTypeId;
    }

    public void setPropertyTypeId(int propertyTypeId) {
        this.propertyTypeId = propertyTypeId;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    @Override
    public String toString() {
        return "PropertyType{" +
                "propertyTypeId=" + propertyTypeId +
                ", type='" + type + '\'' +
                ", category=" + category +
                '}';
    }
}