package controllers;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import models.City;
import models.User;

@WebServlet("/signup.do")
public class SignupServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        request.getRequestDispatcher("pages/signup.jsp").forward(request, response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        Integer cityId = Integer.parseInt(request.getParameter("city_id"));
        String contact = request.getParameter("contact");

        String nextPage = "index.do?signup=false";

        User user = new User(name, email, password, new City(cityId), contact);

        if (user.signUpUser()) {
            // Create a folder for the user
            String parent = getServletContext().getRealPath("/WEB-INF/uploads");
            String child = "user_" + user.getUserId();

            File file = new File(parent, child);
            if (!file.exists()) {
                file.mkdir();
            }else{
                throw new RuntimeException("On Creating folder : " + "folder not created for user : " + user.getUserId() + "-" + user.getEmail());
            }

            nextPage = "index.do?signup=true";
        }

        response.sendRedirect(nextPage);
    }
}