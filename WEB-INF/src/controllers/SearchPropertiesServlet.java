package controllers;

import java.io.IOException;
import java.util.HashSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import models.Property;

@WebServlet("/searchProperties.do")
public class SearchPropertiesServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        Integer cityId = Integer.parseInt(request.getParameter("city_id"));

        String actTp = request.getParameter("action_type");
        Boolean actionType = Boolean.valueOf(actTp.equalsIgnoreCase("sell"));

        String ctgr = request.getParameter("property_category");
        if(ctgr.equalsIgnoreCase("residential")){
            ctgr = "Residential";
        }else if(ctgr.equalsIgnoreCase("commercial")){
            ctgr = "Commercial";
        }

        String respText = "[]";

        try {
            HashSet<Property> properties = Property.searchProperties(cityId, actionType, ctgr); 
            Gson gson = new Gson();
            respText = gson.toJson(properties);
        } catch (java.sql.SQLException e) {
            e.printStackTrace();
        }

        System.out.println(cityId);
        System.out.println(actionType);
        System.out.println(ctgr);

        response.getWriter().write(respText);
    }
}