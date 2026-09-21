package models;

public class AreaType {
    private Integer areaTypeId;
    private String type;

    //tostring...
    @Override
    public String toString() {
        return "AreaType [areaTypeId=" + areaTypeId + ", type=" + type + "]";
    }

    public AreaType() {
        super();
    }

    public AreaType(Integer areaTypeId){
        this.areaTypeId = areaTypeId;
    }

    public AreaType(Integer areaTypeId, String type) {
        super();
        this.areaTypeId = areaTypeId;
        this.type = type;
    }

    public void setAreaTypeId(Integer areaTypeId) {
        this.areaTypeId = areaTypeId;
    }

    public Integer getAreaTypeId() {
        return areaTypeId;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getType() {
        return type;
    }
}