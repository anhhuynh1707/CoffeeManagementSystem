package filter;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;

@WebFilter("/*")
public class AuthFilter implements Filter {

    // 🔓 URLs that do NOT require authentication
    private static final List<String> PUBLIC_PATHS = Arrays.asList(
            "/index.jsp",
            "/login",
            "/login.jsp",
            "/register",
            "/register.jsp",
            "/forgot-password",
            "/forgot-password.jsp"
    );

    @Override
    public void init(FilterConfig filterConfig) {
        System.out.println("AuthFilter initialized");
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        String contextPath = req.getContextPath();
        String uri = req.getRequestURI();

        // Remove context path for easier matching
        String path = uri.substring(contextPath.length());

        // 🔓 Allow static resources
        if (path.startsWith("/css/")
                || path.startsWith("/js/")
                || path.startsWith("/img/")
                || path.startsWith("/fonts/")
                || path.endsWith(".png")
                || path.endsWith(".jpg")
                || path.endsWith(".jpeg")
                || path.endsWith(".gif")
                || path.startsWith("/uploads")){

            chain.doFilter(request, response);
            return;
        }

        // 🔓 Allow public URLs
        if (PUBLIC_PATHS.contains(path)) {
            chain.doFilter(request, response);
            return;
        }

        // 🔒 Check authentication
        HttpSession session = req.getSession(false);
        Integer userId = (session != null)
                ? (Integer) session.getAttribute("userId")
                : null;

        if (userId == null) {
            // Not logged in → redirect to login
            resp.sendRedirect(contextPath + "/login.jsp");
            return;
        }

        // ✅ Authenticated → allow access
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        // cleanup if needed
    }
}