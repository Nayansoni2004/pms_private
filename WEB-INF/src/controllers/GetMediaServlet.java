package controllers;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import models.Property;
import models.User;

@WebServlet("/getMedia.do")
public class GetMediaServlet extends HttpServlet {
    public void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = (User)req.getSession().getAttribute("loggedUser");
         
        if (user != null) {
            String fileName = req.getParameter("media");
            Integer propertyId = Integer.parseInt(req.getParameter("propertyId"));

            Property property = new Property();
            property.setPropertyId(propertyId);
            property.setUser(user);

            String folderPath = property.getFolderPath();
            String temp = getServletContext().getRealPath("/" + folderPath);
            File file = new File(temp);

            if (file.exists()) {
                OutputStream os = resp.getOutputStream();

                ServletContext context = getServletContext();

                InputStream is = context.getResourceAsStream("/" + folderPath + "/" + fileName);

                if (is == null) {
                    resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Media file not found");
                    return;
                }

                byte[] arr = new byte[256];
                int count = 0;
                while ((count = is.read(arr)) != -1) {
                    os.write(arr, 0, count);
                }

                os.flush();
                os.close();
                is.close();
            }
        }
    }
}