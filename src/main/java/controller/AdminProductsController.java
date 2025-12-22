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

	    // 1) Handle toggle (Enable/Disable)
	    String op = request.getParameter("op");
	    if ("toggle".equals(op)) {
	        int id = Integer.parseInt(request.getParameter("id"));
	        menuDAO.toggleProductStatus(id);

	        // redirect back to same list (keep filters/sort/page)
	        response.sendRedirect(buildReturnUrl(request));
	        return;
	    }
	    
	    if ("remove".equals(op)) {
	        int id = Integer.parseInt(request.getParameter("id"));
	        menuDAO.removeProduct(id);

	        // go back to same list state (page/filter/sort)
	        response.sendRedirect(buildReturnUrl(request));
	        return;
	    }

	    // 2) Read filters
	    String q = request.getParameter("q");                // keyword
	    String category = request.getParameter("category");  // coffee/tea/...
	    String status = request.getParameter("status");      // available/unavailable

	    // 3) Sorting
	    String sortBy = request.getParameter("sortBy");
	    String sortDir = request.getParameter("sortDir");
	    if (sortBy == null || sortBy.isBlank()) sortBy = "id";
	    if (sortDir == null || sortDir.isBlank()) sortDir = "asc";

	    // 4) Pagination (fixed page size = 15)
	    int page = 1;
	    final int PAGE_SIZE = 15;
	    String pageParam = request.getParameter("page");
	    if (pageParam != null) {
	        try { page = Math.max(1, Integer.parseInt(pageParam)); }
	        catch (Exception ignored) {}
	    }

	    int totalItems = menuDAO.countProductsForAdmin(q, category, status);
	    int totalPages = (int) Math.ceil((double) totalItems / PAGE_SIZE);
	    if (totalPages == 0) totalPages = 1;
	    if (page > totalPages) page = totalPages;

	    int offset = (page - 1) * PAGE_SIZE;

	    List<Menu> products = menuDAO.getProductsForAdminPaged(
	            q, category, status, offset, PAGE_SIZE, sortBy, sortDir
	    );

	    request.setAttribute("products", products);
	    request.setAttribute("page", page);
	    request.setAttribute("totalPages", totalPages);
	    request.setAttribute("totalItems", totalItems);
	    request.setAttribute("sortBy", sortBy);
	    request.setAttribute("sortDir", sortDir);

	    request.getRequestDispatcher("/admin-products.jsp").forward(request, response);
	}

	private String buildReturnUrl(HttpServletRequest request) {
	    // keep current params when returning after toggle
	    String q = request.getParameter("q");
	    String category = request.getParameter("category");
	    String status = request.getParameter("status");
	    String sortBy = request.getParameter("sortBy");
	    String sortDir = request.getParameter("sortDir");
	    String page = request.getParameter("page");

	    StringBuilder url = new StringBuilder("products?");

	    if (q != null && !q.isBlank()) url.append("q=").append(encode(q)).append("&");
	    if (category != null && !category.isBlank()) url.append("category=").append(encode(category)).append("&");
	    if (status != null && !status.isBlank()) url.append("status=").append(encode(status)).append("&");
	    if (sortBy != null && !sortBy.isBlank()) url.append("sortBy=").append(encode(sortBy)).append("&");
	    if (sortDir != null && !sortDir.isBlank()) url.append("sortDir=").append(encode(sortDir)).append("&");
	    if (page != null && !page.isBlank()) url.append("page=").append(encode(page)).append("&");

	    // remove trailing &
	    if (url.charAt(url.length()-1) == '&' || url.charAt(url.length()-1) == '?') {
	        url.deleteCharAt(url.length()-1);
	    }
	    return url.toString();
	}

	private String encode(String s) {
	    try {
	        return java.net.URLEncoder.encode(s, java.nio.charset.StandardCharsets.UTF_8);
	    } catch (Exception e) {
	        return s;
	    }
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
	    
	    switch(op) {
	    case "add": {
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
	    case "update":{
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
	    default:
		    response.sendRedirect("products");	
	    	
	    }
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
