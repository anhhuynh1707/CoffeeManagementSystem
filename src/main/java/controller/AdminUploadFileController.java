package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.*;
import java.nio.file.Files;
@WebServlet("/uploads/*")
public class AdminUploadFileController extends HttpServlet {

    private String getUploadDir() {
        String dir = getServletContext().getInitParameter("uploadDir");
        if (dir == null || dir.isBlank()) {
            dir = System.getProperty("java.io.tmpdir") + File.separator + "coffee_uploads";
        }
        return dir;
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        // Example: /menu/americano.jpg
        String pathInfo = req.getPathInfo(); // "/menu/americano.jpg"
        if (pathInfo == null || pathInfo.equals("/")) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        // ---- 1) Try external folder first ----
        File externalFile = new File(getUploadDir(), pathInfo.substring(1)); 
        // substring(1) removes leading "/"

        if (externalFile.exists() && externalFile.isFile()) {
            streamFile(resp, externalFile);
            return;
        }

        // ---- 2) Fallback: try built-in webapp image (/img + pathInfo) ----
        String resourcePath = "/img" + pathInfo;  // "/img/menu/americano.jpg"

        try (InputStream in = getServletContext().getResourceAsStream(resourcePath)) {
            if (in == null) {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND);
                return;
            }

            String contentType = getServletContext().getMimeType(resourcePath);
            if (contentType == null) contentType = "application/octet-stream";
            resp.setContentType(contentType);

            try (OutputStream out = resp.getOutputStream()) {
                in.transferTo(out);
            }
        }
    }

    private void streamFile(HttpServletResponse resp, File file) throws IOException {
        String contentType = Files.probeContentType(file.toPath());
        if (contentType == null) contentType = "application/octet-stream";

        resp.setContentType(contentType);
        resp.setContentLengthLong(file.length());

        try (InputStream in = new FileInputStream(file);
             OutputStream out = resp.getOutputStream()) {
            in.transferTo(out);
        }
    }
}

