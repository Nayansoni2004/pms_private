package controllers;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javax.servlet.http.HttpSession;

import models.Status;
import models.User;

@WebServlet("/signin.do")
public class SigninServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        request.getRequestDispatcher("pages/signin.jsp").forward(request, response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        HttpSession session = request.getSession();

        String nextPage = "signin.do?signin_status=";

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        User user = new User(email, password);
        user.loginUser();
        // int status = user.getStatus().getStatusId();
        Status userStatus = user.getStatus();
        int status = userStatus.getStatusId();

        switch(status) {
            case 1:
                session.setAttribute("loggedUser", user);
                nextPage = "index.do"; //user is direct forward to home page
                break;
            default:
                nextPage = nextPage + status + "&email=" + user.getEmail();
        }
        response.sendRedirect(nextPage);
    }
}
