package utils;

import java.util.List;

import models.Property;
import models.PropertyAction;
import models.PropertyArea;
import models.PropertyFeature;
import models.PropertyMedia;

public class MyProperty {
    private Property property;
    private PropertyAction propertyAction;
    private List<PropertyFeature> propertyFeatures;
    private List<PropertyArea> propertyAreas;
    private List<PropertyMedia> propertyMedias;


    public Property getProperty() {
        return property;
    }

    public void setProperty(Property property) {
        this.property = property;
    }

    public PropertyAction getPropertyAction() {
        return propertyAction;
    }

    public void setPropertyAction(PropertyAction propertyAction) {
        this.propertyAction = propertyAction;
    }

    public List<PropertyFeature> getPropertyFeatures() {
        return propertyFeatures;
    }

    public void setPropertyFeatures(List<PropertyFeature> propertyFeatures) {
        this.propertyFeatures = propertyFeatures;
    }

    public List<PropertyArea> getPropertyAreas() {
        return propertyAreas;
    }

    public void setPropertyAreas(List<PropertyArea> propertyAreas) {
        this.propertyAreas = propertyAreas;
    }

    public List<PropertyMedia> getPropertyMedias() {
        return propertyMedias;
    }

    public void setPropertyMedias(List<PropertyMedia> propertyMedias) {
        this.propertyMedias = propertyMedias;
    }

    
    
}

// [
//     {y
//         property : {
//             property1
//             property1
//             property1
//             property1
//             property1
//             property1
//         },
//         {
//             property1
//             property1
//             property1
//             property1
//         },

//         propertyFeatures : [
//             {

//             },
//             {
                
//             },
//             {

//             }
//         ],
//         propertyMedia : [
//             {

//             },
//             {
                
//             },
//             {

//             }
//         ],
//         PropertyArea : [
//             {

//             },
//             {
                
//             },
//             {

//             }
//         ],
        
//     },
//     {

//     }
// ]
