package controller;

import dao.MenuDAO;
import model.Menu;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.List;

@WebServlet("/products")
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 1024 * 1024 * 5, maxRequestSize = 1024 * 1024 * 10)
public class AdminProductsController extends HttpServlet {

	private final MenuDAO menuDAO = new MenuDAO();

	// ======================
	// GET: show products page
	// ======================
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		List<Menu> products = menuDAO.getAllProductsForAdmin();

		request.setAttribute("products", products);
		request.getRequestDispatcher("/admin-products.jsp").forward(request, response);
	}

	// ======================
	// POST: add new product
	// ======================
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {

	    String op = request.getParameter("op");
	    if (op == null) {
	        response.sendRedirect("products");
	        return;
	    }

	    // ============ ADD (with image upload) ============
	    if ("add".equals(op)) {

	        String name = request.getParameter("name");
	        String description = request.getParameter("description");
	        String category = request.getParameter("category");
	        String status = request.getParameter("status");

	        double price;
	        try {
	            price = Double.parseDouble(request.getParameter("price"));
	        } catch (Exception e) {
	            response.sendRedirect("products");
	            return;
	        }

	        Part imagePart = request.getPart("image"); // add form is multipart
	        String imageUrl = saveImage(imagePart);

	        Menu product = new Menu();
	        product.setName(name);
	        product.setDescription(description);
	        product.setCategory(category);
	        product.setStatus(status);
	        product.setPrice(price);
	        product.setImageUrl(imageUrl);

	        menuDAO.addProduct(product);

	        response.sendRedirect("products");
	        return;
	    }

	    // ============ UPDATE (text-only, keep image_url) ============
	    if ("update".equals(op)) {

	        int id;
	        try {
	            id = Integer.parseInt(request.getParameter("id"));
	        } catch (Exception e) {
	            response.sendRedirect("products");
	            return;
	        }

	        String name = request.getParameter("name");
	        String description = request.getParameter("description");
	        String category = request.getParameter("category");
	        String status = request.getParameter("status");

	        double price;
	        try {
	            price = Double.parseDouble(request.getParameter("price"));
	        } catch (Exception e) {
	            response.sendRedirect("products");
	            return;
	        }

	        Menu product = new Menu();
	        product.setId(id);
	        product.setName(name);
	        product.setDescription(description);
	        product.setCategory(category);
	        product.setStatus(status);
	        product.setPrice(price);

	        menuDAO.updateProductTextOnly(product);

	        response.sendRedirect("products");
	        return;
	    }

	    response.sendRedirect("products");
	}


	private String getUploadDir() {
		String dir = getServletContext().getInitParameter("uploadDir");
		if (dir == null || dir.isBlank()) {
			// fallback (portable), puts it inside Tomcat temp folder
			dir = System.getProperty("java.io.tmpdir") + File.separator + "coffee_uploads";
		}
		return dir;
	}

	private String saveImage(Part imagePart) throws IOException {

		String baseUploadDir = getUploadDir();
		System.out.println("[UPLOAD DIR] = " + baseUploadDir);

		if (imagePart == null || imagePart.getSize() == 0) {
			return "default.jpg";
		}

		String originalName = Paths.get(imagePart.getSubmittedFileName()).getFileName().toString();

		String safeOriginal = originalName.replaceAll("[^a-zA-Z0-9._-]", "_");
		String fileName = System.currentTimeMillis() + "_" + safeOriginal;

		File dir = new File(baseUploadDir, "menu");
		if (!dir.exists())
			dir.mkdirs();

		File dest = new File(dir, fileName);
		imagePart.write(dest.getAbsolutePath());

		System.out.println("[UPLOAD FILE] = " + dest.getAbsolutePath());

		return fileName;
	}

}
