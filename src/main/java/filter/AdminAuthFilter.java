package filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebFilter(urlPatterns = {
        "/admin-dashboard.jsp",
        "/dashboard"
})
public class AdminAuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;

        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Object roleObj = session.getAttribute("role");
        if (roleObj == null || !"admin".equalsIgnoreCase(roleObj.toString())) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }

        chain.doFilter(req, res);
    }
}
