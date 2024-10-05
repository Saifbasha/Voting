<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
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
    	width: 50%;
    	height: 70vh;
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
        font-size: 20px;
        border-radius: 10px;
        border: none;
       margin-right: 20px;
       box-shadow: 2px 2px 2px #000;
       background-color: green;
       color:#fff;
       
    }
    th{
    	font-size: 30px;
    }
    td{
    	font-size: 20px;
    	text-align: center;
    }
    em{
    	color:red;
    	font-size: 25px;
    }
    
</style>
</head>
<body>
	<main>
		<table cellspacing="30">
			<tr>
				<th>Name</th>
				<th>Party</th>
				<th>Count</th>
			</tr>
		<%
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		String name = null;
		String party = null;
		int count = 0;

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/votedata?user=root && password=root");
			ps = con.prepareStatement("select * from leaders order by count desc");
			rs = ps.executeQuery();
			int i=1;
			while (rs.next()) {
				name = rs.getString("name");
				party = rs.getString("party");
				count = rs.getInt("count");
				
				if(i==1){
		%>
			<tr>
				<td><em><%=name%></em></td>
				<td><em><%=party%></em></td>
				<td><em><%=count%></em></td>
			</tr>

		<%
				}else{
					%>
					<tr>
						<td><%=name%></td>
						<td><%=party%></td>
						<td><%=count%></td>
					</tr>
					<%
				}
				i++;
		}
		} catch (Exception e) {
		e.printStackTrace();
		} finally {
		if (rs != null)
		try {
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		if (ps != null)
		try {
			ps.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		if (con != null)
		try {
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		}
		%>
		</table>
		<a href="index.html"><button>Sign Out</button></a>
	</main>
</body>
</html>