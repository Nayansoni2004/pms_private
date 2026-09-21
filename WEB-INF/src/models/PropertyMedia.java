package models;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class PropertyMedia {
    private Integer propertyMediaId;
    private Property property;
    private String mediaPath;
    private ViewType viewType;
    private Boolean mediaType;

    //#################### fetch propertyMedias method ########################
    public static List<PropertyMedia> collectAllPropertyMedias(Connection con, Property property) throws SQLException {
        List<PropertyMedia> propertyMedias = new ArrayList<>();

        if (con != null && property != null) {
            String query = "SELECT pm.*, vt.view_type FROM property_media pm " +
                           "INNER JOIN view_types vt ON pm.view_type_id = vt.view_type_id " +
                           "WHERE pm.property_id = ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, property.getPropertyId());

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                PropertyMedia propertyMedia = new PropertyMedia();
                propertyMedia.setPropertyMediaId(rs.getInt("property_media_id"));
                // propertyMedia.setProperty(property);
                propertyMedia.setMediaPath(rs.getString("media_path"));

                ViewType viewType = new ViewType();
                viewType.setViewTypeId(rs.getInt("view_type_id"));
                viewType.setViewType(rs.getString("view_type"));
                propertyMedia.setViewType(viewType);

                propertyMedia.setMediaType(rs.getBoolean("media_type"));

                propertyMedias.add(propertyMedia);
            }
        }

        return propertyMedias;
    }


    public void printDetails() {
        System.out.println("############ Property Media Details ###########");
        System.out.println("Property ID: " + (property != null ? property.getPropertyId() : "N/A"));
        System.out.println("Media Path: " + (mediaPath != null ? mediaPath : "N/A"));
        System.out.println("View Type ID: " + (viewType != null ? viewType.getViewTypeId() : "N/A"));
        System.out.println("Media Type: " + (mediaType != null ? mediaType : "N/A"));
        System.out.println("############ End of Details ###########");
    }

    //##################save property media##################################
    public boolean save(Connection con) throws SQLException {
        boolean flag = false;

        if(con != null) {
            String query = "insert into property_media (property_id,media_path,view_type_id,media_type) values (?,?,?,?)";

            PreparedStatement ps = con.prepareStatement(query);

            ps.setInt(1, property.getPropertyId());
            ps.setString(2, mediaPath); //nayan se puchna h ye...
            ps.setInt(3, viewType.getViewTypeId());
            ps.setBoolean(4, mediaType);

            int res = ps.executeUpdate();

            if(res == 1) {
                flag = true;
            }
            // con.close();
        }
        return flag;
    }

    //toString...
    @Override
    public String toString() {
        return "PropertyMedia [propertyMediaId=" + propertyMediaId + ", property=" + property + ", mediaPath="
                + mediaPath + ", viewType=" + viewType + ", mediaType=" + mediaType + "]";
    }

    public PropertyMedia() {
        super();
    }

    public PropertyMedia(Integer propertyMediaId, Property property, String mediaPath, ViewType viewType, Boolean mediaType) {
        this.propertyMediaId = propertyMediaId;
        this.property = property;
        this.mediaPath = mediaPath;
        this.viewType = viewType;
        this.mediaType = mediaType;
    }

    public void setPropertyMediaId(Integer propertyMediaId) {
        this.propertyMediaId = propertyMediaId;
    }

    public Integer getPropertyMediaId() {
        return propertyMediaId;
    }

    public void setProperty(Property property) {
        this.property = property;
    }

    public Property getProperty() {
        return property;
    }

    public void setMediaPath(String mediaPath) {
        this.mediaPath = mediaPath;
    }

    public String getMediaPath() {
        return mediaPath;
    }

    public void setViewType(ViewType viewType) {
        this.viewType = viewType;
    }

    public ViewType getViewType() {
        return viewType;
    }

    public void setMediaType(Boolean mediaType) {
        this.mediaType = mediaType;
    }

    public Boolean getMediaType() {
        return mediaType;
    }
}
