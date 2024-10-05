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
<style >
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
	<main>
	<%
		
		String email=(String)session.getAttribute("email");
		String password=(String)session.getAttribute("pwd");
		
		Connection con=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		
		try{
			Class.forName("com.mysql.cj.jdbc.Driver");
			con=DriverManager.getConnection("jdbc:mysql://localhost:3306/votedata?user=root && password=root");
			ps=con.prepareStatement("select * from voted where email=? and password=?");
			ps.setString(1, email);
			ps.setString(2,password);
			rs=ps.executeQuery();
			
			if(!rs.isBeforeFirst()){
				RequestDispatcher rd=request.getRequestDispatcher("vote.html");
				rd.forward(request, response);
			}else{
				out.println("<h1>You already voted.....</h1><h1>So you can't vote again</h1>");
				out.println("<a href='index.html'><button>Sign Out</button></a>");
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			if (rs != null) try { rs.close(); } catch (Exception e) { e.printStackTrace(); }
			if (ps != null) try { ps.close(); } catch (Exception e) { e.printStackTrace(); }
			if (con != null) try { con.close(); } catch (Exception e) { e.printStackTrace(); }
		}
		
	%>
	</main>
</body>
</html>