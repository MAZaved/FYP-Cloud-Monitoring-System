<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="service.LoginService"%>
<%@page import="model.User"%>
<%@page import="model.Logger"%>
<%@page import="model.Alert"%>
<%@page import="service.AlertService"%>
<%@page import="database.DbClass"%>
<%@page import="java.util.List"%>

<!-- @author Michael Mullarkey (112457292) -->
<!DOCTYPE html>
<html class="full" lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Prototype</title>

    <!-- Bootstrap Core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/the-big-picture.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="css/heroic-features.css" rel="stylesheet">
	<link href="css/monitoring.css" rel="stylesheet">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

</head>

<body>

    <!-- Navigation -->
    <nav class="navbar navbar-default navbar-fixed-top" role="navigation">
		
        <div class="container">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="#">Cloud</a>
            </div>
            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav">
					<li><a href="dashboard.jsp">My Dashboard</a></li>
					
                    <li class="dropdown">
					  <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Monitor <span class="caret"></span></a>
					  <ul class="dropdown-menu">
						<li><a href="monitor_config.jsp">Monitor Config</a></li>
						<li><a href="monitor_management.jsp">Monitor Management</a></li>
						
					  </ul>
					</li>
                    <li class="dropdown">
					  <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Alerts <span class="caret"></span></a>
					  <ul class="dropdown-menu">
						<li><a href="alert_config.jsp">Alert Config</a></li>
						<li><a href="alert_management.jsp">Alert Management</a></li>
						
					  </ul>
					</li>
					
					<%User user = (User) session.getAttribute("user");
					if(user != null){
						if(user.getUserType().equals("Admin")){
						
						%>
					
					
					<li class="dropdown">
					  <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Reports <span class="caret"></span></a>
					  <ul class="dropdown-menu">
						<li><a href="report_management.jsp">Report Management</a></li>
						
					  </ul>
					</li>
					<%} }%>
					<li class="dropdown">
					  <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Help <span class="caret"></span></a>
					  <ul class="dropdown-menu">
						<li><a href="#">FAQ</a></li>
						
					  </ul>
					</li>
                </ul>
				<div class="col-sm-3 col-md-3">
					
				</div>
				<ul class="nav navbar-nav navbar-right">
					<%
                 		
             		%>  
					
										<% if(user != null)
				             				{ 
											%>
											
										<li class="dropdown">
												<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><%out.println(user.getUsername() + " " + user.getUserId());%><span class="caret"></span></a>
												<ul class="dropdown-menu">
											<%if(user.getUserType().equals("Admin")){%>
											<li><a href="admin_index.html">Admin</a></li>
											<%} %>
											<li><a href="#" data-toggle="modal" data-target="#logOutModal">Log Out</a></li>
												
											</ul>
										</li>
																	
										<%
				            	 			}
				            	 			else
				            	 			{
				            	 				%><li><a href="#" data-toggle="modal" data-target="#logInModal">Log In</a></li><%
				            	 			}%>
				</ul>
            </div>
            <!-- /.navbar-collapse -->
        </div>
        <!-- /.container -->
    </nav>
    
     <h2><%
		    if(null!=request.getAttribute("errorMessage"))
		    {
		    	%>
		    	<div class="alert alert-danger" role="alert">
		    		<button type="button" class="close" data-dismiss="alert">X</button>
		    	  <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
		    	  <span class="sr-only">Error:</span>
		    	  Invalid Username and/or Password
		    	</div><%
		    }
		%></h2>
	
    <!-- Page Content -->
    <div class="container">
        <div class="row">
            <div class="col-md-6 col-sm-12">
                <h1>Cloud Monitoring</h1>
                <p>A Web-based User Interface Design for a Cloud Monitoring System</p>
            </div>
        </div>
        <!-- /.row -->
    </div>
    <!-- /.container -->
	   
		<div id="logInModal" class="modal fade" role="dialog">
		  <div class="modal-dialog">

			<!-- Modal content-->
			<div class="modal-content">
			  <div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title">Log In</h4>
			  </div>
			   <div class="modal-body">
			  	<form data-toggle="validator" name='form' action='LoginServlet' method='POST'>
					<div class="row" style="margin-top: 2%;">
						<div class="form-group">
						  <label class="control-label" for="focusedInput">Username</label>
						  <input name="username" class="form-control input-sm" id="focusedInput" type="text" value="" required>
						  <div class="help-block with-errors"></div>
						</div>
					</div>
					<div class="row">
						<div class="form-group">
						  <label class="control-label" for="focusedInput" >Password</label>
						  <input name="password" class="form-control input-sm" id="focusedInput"  type="password" value="" required>
    					<span class="help-block with-errors"></span>
						</div>
						
					</div> 
				
			  <div class="modal-footer">
				<button class="btn btn-default" data-dismiss="modal" type="reset">Close</button>
				<button class="btn btn-primary" name="submit" type="submit">Log In</button>
			  </div>
			  </form>	
			</div>

		  </div>
		</div>
	</div>
	
	
	
		<div id="logOutModal" class="modal fade" role="dialog">
		  <div class="modal-dialog">

			<!-- Modal content-->
			<div class="modal-content">
			  <div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title">Log Out</h4>
			  </div>
			   <div class="modal-body">
			  	<form name='form' action='LogOutServlet' method='POST'>
					<div class="row" style="margin-top: 4%;">
						<div>
						  <label class="control-label" for="focusedInput">Are you sure you want to log out?</label>
						  
						</div>
					</div>
					
				
			  <div class="modal-footer">
				<button class="btn btn-default" data-dismiss="modal" type="reset">Close</button>
				<button class="btn btn-primary" name="logout" type="submit">Log Out</button>
			  </div>
			  </form>	
			</div>

		  </div>
		</div>
	</div>
	
	
      

        

    
    <!-- /.container -->
	
    <!-- jQuery -->
    <script src="js/jquery.js"></script>
	<script src="js/validator.js"></script>
	<!-- Custom JS -->
	<script src="js/monitoring.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="js/bootstrap.min.js"></script>

</body>

</html>