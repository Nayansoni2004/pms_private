package models;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class PropertyArea {
    private Integer propertyAreaId;
    private Property property;
    private AreaType areaType;
    private Integer area;

    //#################### fetch propertyAreas method ########################
    public static List<PropertyArea> collectAllPropertyAreas(Connection con, Property property) throws SQLException {
        List<PropertyArea> propertyAreas = new ArrayList<>();

        if (con != null && property != null) {
            String query = "SELECT pa.property_area_id, pa.area, at.area_type_id, at.type " +
                           "FROM property_area pa " +
                           "JOIN area_type at ON pa.area_type_id = at.area_type_id " +
                           "WHERE pa.property_id = ?";

            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, property.getPropertyId());

            var rs = ps.executeQuery();

            while (rs.next()) {
                Integer propertyAreaId = rs.getInt("property_area_id");
                Integer area = rs.getInt("area");
                Integer areaTypeId = rs.getInt("area_type_id");
                String areaTypeName = rs.getString("type");

                AreaType areaType = new AreaType(areaTypeId, areaTypeName);
                PropertyArea propertyArea = new PropertyArea(propertyAreaId, null, areaType, area);

                propertyAreas.add(propertyArea);
            }
        }

        return propertyAreas;
    }

    public void printDetails() {
        System.out.println("############ Property Area Details ###########");
        System.out.println("Property ID: " + (property != null ? property.getPropertyId() : "N/A"));
        System.out.println("Area Type ID: " + (areaType != null ? areaType.getAreaTypeId() : "N/A"));
        System.out.println("Area: " + (area != null ? area : "N/A"));
        System.out.println("############ End of Details ###########");
    }

    //##############save property_area#######################
    public boolean save(Connection con) throws SQLException {
        boolean flag = false;

        if(con != null) {
            String query = "insert into property_area (property_id,area_type_id,area) values (?,?,?)";

            PreparedStatement ps = con.prepareStatement(query);

            ps.setInt(1, property.getPropertyId());
            ps.setInt(2, areaType.getAreaTypeId());
            ps.setInt(3, area);

            int res = ps.executeUpdate();

            if(res == 1) {
                flag = true;
            }
            // con.close();
        }
        return flag;
    }

    //toString....
    @Override
    public String toString() {
        return "PropertyArea [property=" + property + ", areaType=" + areaType + ", area=" + area + "]";
    }

    //###########################constructors#############################
    public PropertyArea() {
        super();
    }

    public PropertyArea(Property property, AreaType areaType, Integer area) {
        this.property = property;
        this.areaType = areaType;
        this.area = area;
    }

    public PropertyArea(Property property, AreaType areaType) {
        this.property = property;
        this.areaType = areaType;
    }

    public PropertyArea(Integer propertyAreaId, Property property, AreaType areaType, Integer area) {
        super();
        this.propertyAreaId = propertyAreaId;
        this.property = property;
        this.areaType = areaType;
        this.area = area;
    }

    //###########################getter & Setters#############################
    public void setPropertyAreaId(Integer propertyAreaId) {
        this.propertyAreaId = propertyAreaId;
    }

    public Integer getPropertAreaId() {
        return propertyAreaId;
    }

    public void setProperty(Property property) {
        this.property = property;
    }

    public Property getProperty() {
        return property;
    }

    public void setAreaType(AreaType areaType) {
        this.areaType = areaType;
    }

    public AreaType getAreaType() {
        return areaType;
    }

    public void setArea(Integer area) {
        this.area = area;
    }

    public Integer getArea() {
        return area;
    }
}
