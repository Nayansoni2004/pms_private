package models;

public class UserRole {
    private Integer userRoleId;
    private User userId;
    private UserType userTypeId;

    public UserRole() {
        super();
    }

    public UserRole(Integer userRoleId, User userId, UserType userTypeId) {
        this.userRoleId = userRoleId;
        this.userId = userId;
        this.userTypeId = userTypeId;
    }

    public void setUserRoleId(Integer userRoleId) {
        this.userRoleId = userRoleId;
    }

    public Integer getUserRoleId() {
        return userRoleId;
    }

    public void setUserId(User userId) {
        this.userId = userId;
    }

    public User getUserId() {
        return userId;
    }

    public void setUserTypeId(UserType userTypeId) {
        this.userTypeId = userTypeId;
    }

    public UserType getUserTypeId() {
        return userTypeId;
    }
}