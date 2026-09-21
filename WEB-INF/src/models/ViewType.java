package models;

public class ViewType {
    private Integer viewTypeId;
    private String viewType;

    @Override
    public String toString() {
        return "ViewType [viewTypeId=" + viewTypeId + ", viewType=" + viewType + "]";
    }

    public ViewType() {
        super();
    }

    public ViewType(Integer viewTypeId, String viewType) {
        this.viewTypeId = viewTypeId;
        this.viewType = viewType;
    }

    public void setViewTypeId(Integer viewTypeId) {
        this.viewTypeId = viewTypeId;
    }

    public Integer getViewTypeId() {
        return viewTypeId;
    }

    public void setViewType(String viewType) {
        this.viewType = viewType;
    }

    public String getViewType() {
        return viewType;
    }
}
