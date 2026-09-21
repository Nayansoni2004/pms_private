package models;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class PropertyFeature {
    private Integer propertyFeatureId;
    private Property property;
    private Feature feature; // [{pfi : null,ppt : null, feature : {feattueId : 2, title : "abc"}, description : "aljbl"},{pfi : null,ppt : null, feature : {feattueId : 2, title : "abc"}, description : "aljbl"}]
    private String description;

    // ####################### collectAllPropertyFeatures ################
    public static List<PropertyFeature> collectAllPropertyFeatures(Connection con, Property property) throws SQLException {
        List<PropertyFeature> propertyFeatures = new ArrayList<>();

        if (con != null && property != null) {
            String query = "SELECT * FROM property_features pf " +
                           "INNER JOIN features f ON pf.feature_id = f.feature_id " +
                           "WHERE pf.property_id = ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, property.getPropertyId());

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                PropertyFeature propertyFeature = new PropertyFeature();
                propertyFeature.setPropertyFeatureId(rs.getInt("property_feature_id"));
                // propertyFeature.setProperty(property);

                Feature feature = new Feature();
                feature.setFeatureId(rs.getInt("feature_id"));
                feature.setTitle(rs.getString("title"));
                propertyFeature.setFeature(feature);

                propertyFeature.setDescription(rs.getString("description"));
                propertyFeatures.add(propertyFeature);
            }
        }

        return propertyFeatures;
    }
    


    public void printDetails() {
        System.out.println("############ Property Feature Details ###########");
        System.out.println("Property ID: " + (property != null ? property.getPropertyId() : "N/A"));
        System.out.println("Feature ID: " + (feature != null ? feature.getFeatureId() : "N/A"));
        System.out.println("Feature Title: " + (feature != null ? feature.getTitle() : "N/A"));
        System.out.println("Description: " + (description != null ? description : "N/A"));
        System.out.println("############ End of Details ###########");
    }

    //############# save feature ####################################33
    public boolean save(Connection con) throws SQLException {
        boolean flag = false;

        if(con != null) {
            String query = "insert into property_features (property_id,feature_id,description) values (?,?,?)";

            PreparedStatement ps = con.prepareStatement(query);

            ps.setInt(1, property.getPropertyId());
            ps.setInt(2, feature.getFeatureId());
            ps.setString(3, description);

            int res = ps.executeUpdate();

            if(res == 1) {
                flag = true;
            }
            // con.close();
        }
        return flag;
    }


    //tostring
    @Override
    public String toString() {
        return "PropertyFeature [propertyFeatureId=" + propertyFeatureId + ", property=" + property + ", feature="
                + feature + ", description=" + description + "]";
    }

    public PropertyFeature() {
        super();
    }

    public PropertyFeature(Integer propertyFeatureId, Property property, Feature feature, String description) {
        this.propertyFeatureId = propertyFeatureId;
        this.property = property;
        this.feature = feature;
        this.description = description;
    }

    public void setPropertyFeatureId(Integer propertyFeatureId) {
        this.propertyFeatureId = propertyFeatureId;
    }

    public Integer getPropertyFeatureId() {
        return propertyFeatureId;
    }

    public void setProperty(Property property) {
        this.property = property;
    }

    public Property getProperty() {
        return property;
    }

    public void setFeature(Feature feature) {
        this.feature = feature;
    }

    public Feature getFeature() {
        return feature;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getDescription() {
        return description;
    }
}
