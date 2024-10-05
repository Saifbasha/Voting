<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	String vote = request.getParameter("vote");
	if (vote == null) {
		RequestDispatcher rd=request.getRequestDispatcher("vote.html");
		rd.include(request, response);
	} else {
		String email = (String) session.getAttribute("email");
		String password = (String) session.getAttribute("pwd");

		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/votedata?user=root && password=root");
			ps = con.prepareStatement("select * from leaders where name=?");
			ps.setString(1, vote);
			rs = ps.executeQuery();

			rs.next();
			int count = rs.getInt("count");
			count += 1;

			ps = con.prepareStatement("update leaders set count=? where name=?");
			ps.setInt(1, count);
			ps.setString(2, vote);
			ps.executeUpdate();

			ps = con.prepareStatement("select * from user where email=? and password=?");
			ps.setString(1, email);
			ps.setString(2, password);
			rs = ps.executeQuery();

			rs.next();
			String u_fname = rs.getString("fname");
			String u_lname = rs.getString("lname");
			String u_email = rs.getString("email");
			String u_pwd = rs.getString("password");
			int u_age = rs.getInt("age");
			long u_number = rs.getLong("number");

			ps = con.prepareStatement("insert into voted values(?,?,?,?,?,?)");
			ps.setString(1, u_fname);
			ps.setString(2, u_lname);
			ps.setString(3, u_email);
			ps.setString(4, u_pwd);
			ps.setInt(5, u_age);
			ps.setLong(6, u_number);
			ps.executeUpdate();

			session.setAttribute("vote",vote);
			RequestDispatcher rd = request.getRequestDispatcher("display.jsp");
			rd.forward(request, response);

		} catch (Exception e) {
			e.printStackTrace();
		} finally {

		}
	}
	%>
</body>
</html>