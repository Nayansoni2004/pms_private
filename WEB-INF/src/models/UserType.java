package models;

public class UserType {
    private Integer userTypeId;
    private String type;

    public UserType() {
        super();
    }

    public UserType(Integer userTypeId, String type) {
        this.userTypeId = userTypeId;
        this.type = type;
    }

    public void setUserTypeId(Integer userTypeId) {
        this.userTypeId = userTypeId;
    }

    public Integer getUserTypeId() {
        return userTypeId;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getType() {
        return type;
    }
}
