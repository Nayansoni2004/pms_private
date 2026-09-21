package models;

public class Feature {
    private Integer featureId;
    private String title;

    // to string 
    @Override
    public String toString() {
        return "Feature [featureId=" + featureId + ", title=" + title + "]";
    }

    public Feature() {
        super();
    }

    public Feature(Integer featureId, String title) {
        this.featureId = featureId;
        this.title = title;
    }

    public void setFeatureId(Integer featureId) {
        this.featureId = featureId;
    }

    public Integer getFeatureId() {
        return featureId;
    }

    public void setTitle(String title) {
        this.title = title;
    } 

    public String getTitle() {
        return title;
    }
}
