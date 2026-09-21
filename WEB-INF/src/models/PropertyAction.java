package models;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
public class PropertyAction {
    private Integer propertyActionId;
    private Property property;
    private Timestamp postDate;
    private Timestamp actionDate;
    private Boolean actionType;
    private Integer amount;
    private Integer initialPayment;
    private Status status;
    private User user;

    // #################### collectAllPropertyActions method #####################
    public static PropertyAction getPropertyAction(Connection con, Property property) throws SQLException {
        PropertyAction propertyAction = null;

        if (con != null && property != null) {
            String query = "SELECT pa.*, s.status FROM property_actions pa " +
                           "INNER JOIN status s ON pa.status_id = s.status_id " +
                           "WHERE pa.property_id = ? LIMIT 1";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, property.getPropertyId());

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                propertyAction = new PropertyAction();
                propertyAction.setPropertyActionId(rs.getInt("property_action_id"));
                // propertyAction.setProperty(property);
                propertyAction.setPostDate(rs.getTimestamp("post_date"));
                propertyAction.setActionDate(rs.getTimestamp("action_date"));
                propertyAction.setActionType(rs.getBoolean("action_type"));
                propertyAction.setAmount(rs.getInt("amount"));
                propertyAction.setInitialPayment(rs.getInt("initial_payment"));

                Status status = new Status();
                status.setStatusId(rs.getInt("status_id"));
                status.setStatus(rs.getString("status"));
                propertyAction.setStatus(status);

                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                propertyAction.setUser(user);
            }
        }

        return propertyAction;
    }

    // public static List<PropertyAction> collectPropertyActions(Connection con, Property property) throws SQLException {
    //     List<PropertyAction> propertyActions = new ArrayList<>();

    //     if (con != null && property != null) {
    //         String query = "SELECT pa.*, s.status FROM property_actions pa " +
    //                        "INNER JOIN status s ON pa.status_id = s.status_id " +
    //                        "WHERE pa.property_id = ?";
    //         PreparedStatement ps = con.prepareStatement(query);
    //         ps.setInt(1, property.getPropertyId());

    //         ResultSet rs = ps.executeQuery();

    //         while (rs.next()) {
    //             PropertyAction propertyAction = new PropertyAction();
    //             propertyAction.setPropertyActionId(rs.getInt("property_action_id"));
    //             propertyAction.setProperty(property);
    //             propertyAction.setPostDate(rs.getTimestamp("post_date"));
    //             propertyAction.setActionDate(rs.getTimestamp("action_date"));
    //             propertyAction.setActionType(rs.getBoolean("action_type"));
    //             propertyAction.setAmount(rs.getInt("amount"));
    //             propertyAction.setInitialPayment(rs.getInt("initial_payment"));

    //             Status status = new Status();
    //             status.setStatusId(rs.getInt("status_id"));
    //             status.setStatus(rs.getString("status"));
    //             propertyAction.setStatus(status);

    //             User user = new User();
    //             user.setUserId(rs.getInt("user_id"));
    //             propertyAction.setUser(user);

    //             propertyActions.add(propertyAction);
    //         }
    //     }

    //     return propertyActions;
    // }

    public void printDetails() {
        System.out.println("############ Property Action Details ###########");
        System.out.println("Property: " + (property != null ? property.getPropertyId() : "N/A"));
        System.out.println("Post Date: " + (postDate != null ? postDate : "N/A"));
        System.out.println("Action Date: " + (actionDate != null ? actionDate : "N/A"));
        System.out.println("Action Type: " + (actionType != null ? (actionType ? "Sale" : "Rent") : "N/A"));
        System.out.println("Amount: " + amount);
        System.out.println("Initial Payment: " + initialPayment);
        System.out.println("Status: " + (status != null ? status.getStatusId() : "N/A"));
        System.out.println("User: " + (user != null ? user.getName() + ", id : " + user.getUserId() : "N/A"));
        System.out.println("############ End of Details ###########");
    }

    //#############save property action method ####################
    public boolean save(Connection con) throws SQLException {
        boolean flag = false;

        if(con != null) {
            String query = "insert into property_actions (property_id,action_type,amount,status_id) values (?,?,?,?)";

            PreparedStatement ps = con.prepareStatement(query);

            ps.setInt(1, property.getPropertyId());
            ps.setBoolean(2, actionType);
            ps.setInt(3, amount);
            ps.setInt(4, status.getStatusId());

            int res = ps.executeUpdate();

            if(res == 1) {
                flag = true;
            }
            // con.close();
        }
        return flag;
    }

    // *********************constructors***************************************
    public PropertyAction() {
        super();
    }
     
    public PropertyAction(Integer propertyActionId, Property property, Timestamp postDate, Timestamp actionDate, Boolean actionType, Integer amount, Integer initialPayment, Status status, User user) {
        this.propertyActionId = propertyActionId;
        this.property = property;
        this.postDate = postDate;
        this.actionDate = actionDate;
        this.actionType = actionType;
        this.amount = amount;
        this.initialPayment = initialPayment;
        this.status = status;
        this.user = user;
    }

    // ****************************getter and setter*******************************
    public Integer getPropertyActionId() {
        return propertyActionId;
    }

    public void setPropertyActionId(Integer propertyActionId) {
        this.propertyActionId = propertyActionId;
    }

    public Property getProperty() {
        return property;
    }

    public void setProperty(Property property) {
        this.property = property;
    }

    public Timestamp getPostDate() {
        return postDate;
    }

    public void setPostDate(Timestamp postDate) {
        this.postDate = postDate;
    }

    public Timestamp getActionDate() {
        return actionDate;
    }

    public void setActionDate(Timestamp actionDate) {
        this.actionDate = actionDate;
    }

    public Boolean getActionType() {
        return actionType;
    }

    public void setActionType(Boolean actionType) {
        this.actionType = actionType;
    }

    public Integer getAmount() {
        return amount;
    }

    public void setAmount(Integer amount) {
        this.amount = amount;
    }

    public Integer getInitialPayment() {
        return initialPayment;
    }

    public void setInitialPayment(Integer initialPayment) {
        this.initialPayment = initialPayment;
    }

    public Status getStatus() {
        return status;
    }

    public void setStatus(Status status) {
        this.status = status;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

}
