package controllers;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/dashboard.do")
public class DashboardServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        //user session check: expired or not...
        if (request.getSession(false) != null && request.getSession(false).getAttribute("loggedUser") != null) {
            request.getRequestDispatcher("pages/dashboard.jsp").forward(request, response);
        } else {
            response.sendRedirect("index.do");
        }
    }
}