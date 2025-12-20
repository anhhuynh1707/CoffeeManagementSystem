package util;

import java.sql.*;

public class DBConnection {

    private static final String URL = "jdbc:mysql://localhost:3306/coffee_management";
    private static final String USER = "root";
    private static final String PASSWORD = "1234";
    
    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); // Load MySQL driver	
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    // Get a connection
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
    public static void closeConnection(Connection con) {
        try {
        	if(con != null && !con.isClosed())
        		con.close();
        } catch (SQLException e) {
                e.printStackTrace();
        }
  }

    public static void closeConnection(ResultSet rs) {
            try {
            	if(rs != null && !rs.isClosed())
            		rs.close();
            } catch (SQLException e) {
	                e.printStackTrace();
            }
      }
	public static void closeConnection(PreparedStatement ps) {
	    try {
	    	if(ps != null && !ps.isClosed())
	    		ps.close();
	    } catch (SQLException e) {
	            e.printStackTrace();
	    }
	}
	
	//Test connection
	
	public static void main(String[] args) {
	    try (Connection con = getConnection()) {
	        System.out.println("✅ Database connected successfully!");
	    } catch (Exception e) {
	        System.out.println("❌ Database connection failed!");
	        e.printStackTrace();
	    }
	}

}