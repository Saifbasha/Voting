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
<style>
	  *{
		    margin: 0%;
		    padding: 0%;
		    box-sizing: border-box;
	    }
    body{
        height: 100vh;
        width: 100%;
        display: flex;
        justify-content: center;
        align-items: center;
        background-color:rgb(135, 206, 235);
    }
    main{
    	width: 70%;
    	height: 30vh;
    	border: none;
    	border-radius: 20px;
    	box-shadow: 5px 5px 5px #000;
    	background-color:rgb(173, 255, 47) ;
    	display: flex;
        flex-direction: column;
        justify-content:space-evenly;
        align-items: center;
    }
    button{
    	padding: 15px 100px;
        cursor: pointer;
        font-size: 17px;
        border-radius: 10px;
        border: none;
       margin-right: 20px;
       box-shadow: 2px 2px 2px #000;
    }
</style>
</head>
<body>
	<%
		String fname=request.getParameter("fname");
		String lname=request.getParameter("lname");
		String email=request.getParameter("email");
		String password=request.getParameter("pwd");
		int age=Integer.parseInt(request.getParameter("age"));
		long number=Long.parseLong(request.getParameter("num"));
		
		Connection con=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		
		try{
			Class.forName("com.mysql.cj.jdbc.Driver");
			con=DriverManager.getConnection("jdbc:mysql://localhost:3306/votedata?user=root && password=root");
			ps=con.prepareStatement("select * from user where email=? and password=?");
			ps.setString(1, email);
			ps.setString(2,password);
			rs=ps.executeQuery();
			
			if(!rs.isBeforeFirst()){
				ps=con.prepareStatement("insert into user values(?,?,?,?,?,?)");
				ps.setString(1, fname);
				ps.setString(2, lname);
				ps.setString(3, email);
				ps.setString(4, password);
				ps.setInt(5, age);
				ps.setLong(6, number);
				ps.executeUpdate();
			}else{
				rs.next();
				if(email.equals(rs.getString("email")) && password.equals(rs.getString("password"))){
					out.println("<h1>Details are already existed</h1>");
					RequestDispatcher rd=request.getRequestDispatcher("signup.html");
					rd.include(request, response);
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			if (rs != null) try { rs.close(); } catch (Exception e) { e.printStackTrace(); }
			if (ps != null) try { ps.close(); } catch (Exception e) { e.printStackTrace(); }
			if (con != null) try { con.close(); } catch (Exception e) { e.printStackTrace(); }
		}
		
	%>
	<main>
		<h1>Details are successfully submitted</h1>
		<a href="signin.html"><button>Login</button></a>
	</main>
</body>
</html>