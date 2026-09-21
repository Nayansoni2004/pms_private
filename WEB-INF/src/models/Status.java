package models;

public class Status {
    //-----------------field summary------------------------
    private Integer statusId;
    private String status;

    //-----------------constructor summary----------------------------
    public Status() {
        super();
    }

    public Status(Integer statusId) {
        this.statusId = statusId;
    }

    public Status(Integer statusId, String status) {
        super();
        this.statusId = statusId;
        this.status = status;
    }

    //******************getter & setter methods start***************************
    public void setStatusId(Integer statusId) {
        this.statusId = statusId;
    }

    public Integer getStatusId() {
        return statusId;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getStatus() {
        return status;
    }
    //******************getter & setter methods end***************************
}