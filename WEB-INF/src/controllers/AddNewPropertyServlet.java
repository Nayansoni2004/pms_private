package controllers;

import java.io.File;
import java.io.IOException;
import java.lang.reflect.Type;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import models.User;
import models.ViewType;
import utils.DBConnect;
import models.Property;
import models.PropertyAction;
import models.PropertyArea;
import models.PropertyFeature;
import models.PropertyMedia;
import models.PropertyType;
import models.Status;
import models.AreaType;
import models.City;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;

@WebServlet("/addNewProperty.do")
public class AddNewPropertyServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        // user session check: expired or not...
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("loggedUser") != null) {
            request.getRequestDispatcher("pages/addnewproperty.jsp").forward(request, response);
        } else {
            response.sendRedirect("index.do");
        }
    }

    public void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // ek baar session verify ker lena
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("loggedUser");
        String nextPage = "error";

        // multipart component ke liye kuchh bhi likh ke bheja dena
        if (user != null) {
            if (ServletFileUpload.isMultipartContent(req)) {

                Property property = new Property();
                City city = new City();
                PropertyType propertyType = new PropertyType();
                PropertyAction propertyAction = new PropertyAction();

                List<PropertyFeature> propertyFeatures = null;
                String featuresJsonString = null;

                // property area list (where all property areas are listed)
                List<PropertyArea> propertyAreas = new ArrayList<>();
                List<PropertyMedia> propertymedias = new ArrayList<>();
                List<FileItem> medias = new ArrayList<>(); // iska use baad me use karenge..../....

                String society = null;
                String address = null;

                try {
                    ServletFileUpload upload = new ServletFileUpload(new DiskFileItemFactory());
                    List<FileItem> fileItems = upload.parseRequest(req);

                    // AreaTypeId List

                    for (FileItem item : fileItems) {
                        String fieldName = item.getFieldName();

                        if (item.isFormField()) {
                            switch (fieldName) {
                                // ----------------property object start-------------------------
                                case "propertyName":
                                    property.setTitle(item.getString());
                                    break;
                                // db -> society + address -> address column -> socity , address
                                case "society":
                                    society = item.getString();
                                    break;
                                case "address":
                                    address = item.getString();
                                    break;
                                case "city_id":
                                    city.setCityId(Integer.parseInt(item.getString()));
                                    break;
                                case "propertyTypeId":
                                    propertyType.setPropertyTypeId(Integer.parseInt(item.getString()));
                                    break;
                                case "propertyDescription":
                                    property.setDescription(item.getString());
                                    break;
                                case "totalArea":
                                    property.setTotalArea(Integer.parseInt(item.getString()));
                                    break;
                                case "floors":
                                    property.setFloors(Integer.parseInt(item.getString()));
                                    break;
                                case "bhk":
                                    property.setBhk(Integer.parseInt(item.getString()));
                                    break;
                                // ----------------property object end-------------------------

                                // ----------------propertyArea object start-------------------------
                                case "areaTypeIds":
                                    PropertyArea propertyArea = new PropertyArea(property, // property_id
                                    new AreaType(Integer.parseInt(item.getString())));

                                    propertyArea.setArea(property.getTotalArea());
                                    propertyAreas.add(propertyArea);
                                    break;

                                // ----------------propertyArea object end-------------------------

                                // ----------------propertyMedia object start-------------------------

                                // work done....

                                // ----------------propertyMedia object end-------------------------

                                // ----------------PropertyFeature object start-------------------------
                                case "features_json":
                                    featuresJsonString = item.getString();
                                    // System.out.println(featuresJsonString);
                                    break;
                                // ----------------PropertyFeature object end-------------------------------

                                // ------------------------propertyAction object start---------------------------
                                case "action_Type":
                                    propertyAction.setActionType(item.getString().equalsIgnoreCase("sell"));
                                    break;

                                case "amount":
                                    propertyAction.setAmount(Integer.parseInt(item.getString()));
                                    break;
                                // ------------------------propertyAction object end---------------------------

                                default:
                                    break;
                            }
                            
                        } else {
                            String fileName = new File(item.getName()).getName(); // extract only filename
                            
                            if (fieldName.equals("propertyMedia[]")) {
                                medias.add(item);
                                PropertyMedia propertyMedia = new PropertyMedia();
                                propertyMedia.setMediaPath(fileName);// property_id_folder/file_name -> midea nam
                                propertyMedia.setProperty(property);
                                propertyMedia.setMediaType(fileName.toLowerCase().matches(".*\\.(mp4|avi|mov|wmv|flv|mkv)$"));
                                // propertyMedia.setMediaType(fileName.toLowerCase().matches(".*\\.(mp4)$"));
                                propertymedias.add(propertyMedia);
                            }
                        }
                    }

                    // set society + address
                    if (society != null && address != null)
                        property.setAddress(society + ", " + address);
                    else if (society != null)
                        property.setAddress(society);
                    else if (address != null)
                        property.setAddress(address);

                    // object link
                    property.setStatus(new Status(5));
                    property.setUser(user);
                    property.setCity(city);
                    property.setPropertyType(propertyType);
                    propertyAction.setProperty(property);
                    propertyAction.setStatus(new Status(9));

                    // ek loop chlana padega item ke uper usme area dhhondne ke liye
                    for (FileItem nextItem : fileItems) {
                        for (PropertyArea nextArea : propertyAreas) {
                            if (nextItem.getFieldName().equals("areaValue_" + nextArea.getAreaType().getAreaTypeId())) {
                                nextArea.setArea(Integer.parseInt(nextItem.getString()));
                            }
                        }

                        for (PropertyMedia nextMedia : propertymedias) {
                            if (nextItem.getFieldName().equals("view_type_id_" + nextMedia.getMediaPath())) {
                                ViewType viewType = new ViewType();
                                viewType.setViewTypeId(Integer.parseInt(nextItem.getString()));
                                nextMedia.setViewType(viewType);
                            }
                        }
                    }

                    // propety Features set
                    if (featuresJsonString != null) {
                        Gson gson = new Gson();

                        Type listType = new TypeToken<List<PropertyFeature>>() {
                        }.getType();

                        // jsonString -> array of PropertyFeature ,
                        propertyFeatures = gson.fromJson(featuresJsonString, listType); // listType -> <PropertyFeatue>

                        // System.out.println("###########################################################");
                        // System.out.println(propertyFeatures);
                        // Debug Print
                        for (PropertyFeature next : propertyFeatures) {
                            next.setProperty(property);
                        }

                        // You can now save this list to DB or use it as needed
                    }


                    // *****************checking server console is reciving everything or not!*********************
                    // property.printDetails();
                    // System.out.println("------------------------------------------");
                    // for(PropertyArea propertyarea : propertyAreas) propertyarea.printDetails();
                    // System.out.println("------------------------------------------");
                    // for(PropertyMedia propertymedia : propertymedias) propertymedia.printDetails();
                    // System.out.println("------------------------------------------");
                    // for(PropertyFeature propertyfeature : propertyFeatures) propertyfeature.printDetails();
                    // System.out.println("------------------------------------------");
                    // propertyAction.printDetails();
                    // *********************checking end*******************


                    Connection con = null;
                    try {
                        con = DBConnect.getConnection();
                        con.setAutoCommit(false);

                        if (!property.save(con))
                            throw new Exception("Property save failed");

                        for (PropertyArea nextPropertyArea : propertyAreas) {
                            if (!nextPropertyArea.save(con))
                                throw new Exception("Area save failed");
                        }

                        for (PropertyMedia nextPropertyMedia : propertymedias) {
                            if (!nextPropertyMedia.save(con))
                                throw new Exception("Media save failed");
                        }

                        for (PropertyFeature nextFeature : propertyFeatures) {
                            if (!nextFeature.save(con))
                                throw new Exception("Features save failed");
                        }

                        if (!propertyAction.save(con))
                            throw new Exception("Actions save failed");

                        // Sab sahi hai to commit
                        con.commit();

                        //  Folder structure bana lo

                        // if (!property.makeFolder())
                        //     System.out.println("Folder not Created.../...");

                        String folder = getServletContext().getRealPath("/" + user.getUserFolder() + "/my_properties/property_" + property.getPropertyId());
                        File folderFile = new File(folder);
                        if(!folderFile.exists()) 
                            folderFile.mkdirs();
                        else System.out.println("Folder is Already exists...");
                        

                        // yaha chahiye save kerna hai me folder path la leta hun
                        String folderPath = getServletContext().getRealPath("/" + property.getFolderPath());
                        for (FileItem media : medias) {
                            // media.write(new File(folderPath + "/" + new
                            // File(media.getName()).getName()));
                            String clientSideFileNameExt = media.getName();
                            File file = new File(folderPath, clientSideFileNameExt);

                            media.write(file);
                        }
                        //  Images/videos bhi move karo folder me

                        nextPage = "success";

                    } catch (Exception e) {
                        if (con != null) {
                            try {
                                con.rollback(); // fail hua to undo everything
                            } catch (SQLException rollbackEx) {
                                rollbackEx.printStackTrace();
                            }
                        }
                        resp.getWriter().println("Error occurred: " + e.getMessage());
                    } finally {
                        if (con != null)
                            try {
                                con.close();
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                    }

                } catch (FileUploadException e) {
                    System.err.println("File upload failed: " + e.getMessage());
                    e.printStackTrace();
                } catch (Exception e) {
                    System.err.println("Unexpected error: " + e.getMessage());
                    e.printStackTrace();
                }

            } else {
                nextPage = "it is not multipart component";
            }
        } else {
            // write code for user not login
            nextPage = "expired";
        }

        resp.sendRedirect("property_submit.do?next=" + nextPage);
    }

}

// || -> WEB-INF -> uploads -> (user folder) -> user ka data
// (user folder) -> profilepic.png, myproperties
// myproperties -> (specific property folder)
// WEB-INF -> uploads -> user.getMyPropertyFolderPath() -> (user folder) ->
// property path

// "property-" + propertyId

// kai sarri media ho images videos
// list -> media(images, vides) <-> ProperyMidea
// fileItem -> propertyMedia[] <- fieldname
// turant ek PropertyMidea obj , obj -> list me append(p)

// propertyAreas (list) -> propertyArea <- (property) 0


// not applicable k liye area set krna h total area
// folder path ka issue thik krna h ->