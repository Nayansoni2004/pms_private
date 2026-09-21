package listeners;

import java.util.TreeSet;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

import models.City;
import utils.DBConnect;

@WebListener
public class AppListener implements ServletContextListener {
    public void contextInitialized(ServletContextEvent event) {
        ServletContext context = event.getServletContext();

        //----------------- setup for db connection------------------
        DBConnect.dbURL = context.getInitParameter("dburl");
        DBConnect.dbUser = context.getInitParameter("dbuser");
        DBConnect.dbPassword = context.getInitParameter("dbpassword");

        //-----------------collect all cities from database------------------------
        TreeSet<City> cities = City.collectAllCities();
        context.setAttribute("cities", cities);
    }

    public void contextDestroyed(ServletContextEvent ev) {
        
    }
}
