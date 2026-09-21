package controllers;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import models.Property;
import models.User;
import utils.DBConnect;
import utils.MyProperty;

@WebServlet("/getMyProperties.do")
public class GetMyPropertyServlet extends HttpServlet {
    public void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = (User)req.getSession().getAttribute("loggedUser");
        String respText = "[]";
        
        List<MyProperty> myProperties;
        if(user != null){
            Connection con = DBConnect.getConnection();
            try{
                myProperties = Property.collectMyProperties(con, user);
                Gson gson = new Gson();
                respText = gson.toJson(myProperties);
            }catch(SQLException e){
                e.printStackTrace();
            }
        }

        resp.getWriter().write(respText);
    }
}
