<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="model.User"%>  
<!DOCTYPE html>
<html lang="en">
<!-- @author Michael Mullarkey (112457292) -->
<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Prototype</title>

    <!-- Bootstrap Core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="css/heroic-features.css" rel="stylesheet">
	<link href="css/monitoring.css" rel="stylesheet">
	<link href="css/multi-select.css" rel="stylesheet">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

</head>

<body>
					<%
					//if user is not valid, then redirect them to index.jsp
					User user = (User) session.getAttribute("user");
					if(user == null || !user.getUserType().equals("Admin")){
						
						response.sendRedirect("index.jsp");
					}	
				
					else
					{
						%>
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
                <a class="navbar-brand" href="admin_index.html">Admin</a>
            </div>
            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav">
					
                    <li class="dropdown">
					  <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">User <span class="caret"></span></a>
					  <ul class="dropdown-menu">
						<li><a href="user_config.jsp">Create User</a></li>
						<li><a href="user_management.jsp">User Management</a></li>
						
					  </ul>
					</li>
					
					<li class="dropdown">
					  <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Monitor <span class="caret"></span></a>
					  <ul class="dropdown-menu">
						<li><a href="admin_monitor_management.jsp">Monitor Management</a></li>
					  </ul>
					</li>
				</ul>	
            </div>
            <!-- /.navbar-collapse -->
        </div>
        <!-- /.container -->
    </nav> 
    
    <h2><%
		    if(null!=request.getAttribute("successMessage"))
		    {
		    	%>
		    	<div class="alert alert-success" role="alert">
		    		<button type="button" class="close" data-dismiss="alert">X</button>
		    	  <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
		    	 
		    	  User Added Successfully
		    	</div><%
		    }
		    if(null!=request.getAttribute("errorMessage"))
		    {
		    	%>
		    	<div class="alert alert-danger" role="alert">
		    		<button type="button" class="close" data-dismiss="alert">X</button>
		    	  <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
		    	 
		    	  Username already exists
		    	</div><%
		    }
		%></h2>
 <!-- Page Content -->
    <div class="container">

        <!-- Jumbotron Header -->
        <header class="jumbotron hero-spacer">
        <!-- Form for registering user -->
			<form data-toggle="validator" action="RegisterServlet" method="POST">
				
					<div class="row" style="margin-top: 6%;">
						<div class="form-group col-md-3">
						  <label class="control-label" for="focusedInput">User Name</label>
						  <input name="username" class="form-control input-sm" id="focusedInput" type="text" value="" required>
						  <div class="help-block with-errors"></div>
						</div>
						
						<div class="form-group col-md-3">
						  <label class="control-label" for="focusedInput">Password</label>
						  <input name="password" data-minlength="6" class="form-control input-sm" id="password" type="password" value="" required>
						  <div class="help-block with-errors"></div>
						</div>
						
						<div class="form-group col-md-3">
						  <label class="control-label" for="focusedInput">Password Confirmation</label>
						  <input name="password" class="form-control input-sm" data-match="#password" data-match-error="Passwords Don't Match" id="focusedInput" type="password" value="" required>
						  <div class="help-block with-errors"></div>
						</div>
						
						
						<div class="form-group col-md-3">
						  <label class="control-label" for="focusedInput">Email</label>
						  <input name="email" class="form-control input-sm" type="email" id="focusedInput" value="" required>
						  <div class="help-block with-errors"></div>
						</div>
						
						
					</div>
					
					<div class="row  col-md-3">
					
						<label for="sel1">User Type:</label>
						
					      <select name="userType" class="form-control" id="sel1">
					        <option>Normal</option>
					        <option>Admin</option>
					       
					      </select>
					       
					</div>
					<hr>
		
			
					
					
					 <div class="col-lg-offset-10" style="margin-top: 3%; margin-right: 0%;">
					    <button class="btn btn-default" type="reset">Reset</button>
						<button class="btn btn-primary" type="submit">Save</button>
					</div>
				
			
			</form>	
        </header>
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
        <hr>

        <!-- Footer -->
        <footer>
            <div class="row">
                <div class="col-lg-12">
                    <p>Copyright &copy; Michael Mullarkey 2016</p>
                </div>
            </div>
        </footer>

    </div>
    <!-- /.container -->
<%} %>
    <!-- jQuery -->
    <script src="js/jquery.js"></script>
	<script src="js/jquery.multi-select.js"></script>
	<script src="js/validator.js"></script>
	<script src="js/monitoring.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="js/bootstrap.min.js"></script>

</body>

</html>
