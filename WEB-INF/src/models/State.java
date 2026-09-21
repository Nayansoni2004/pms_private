package models;

public class State {
    //-----------------field summary------------------------
    private Integer stateId;
    private String state;

    //-----------------constructor summary----------------------------
    public State() {
        super();
    }

    public State(Integer stateId, String state) {
        super();
        this.stateId = stateId;
        this.state = state;
    }

    //--------------------getter & setter methods------------------------------
    public void setStateId(Integer stateId) {
        this.stateId = stateId;
    }

    public Integer getStateId() {
        return stateId;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getState() {
        return state;
    }
}
