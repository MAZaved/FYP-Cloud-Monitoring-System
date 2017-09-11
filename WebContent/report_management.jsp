<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="model.User"%>
<%@page import="model.Logger"%>
<%@page import="service.LoginService"%>
<%@page import="java.util.List"%>
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

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

</head>

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
                <a href="index.jsp" class="navbar-brand" href="#">Cloud</a>
            </div>
            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav">
                     <li class="dropdown">
					  <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Dashboard <span class="caret"></span></a>
					  <ul class="dropdown-menu">
						<li><a href="dashboard.jsp">My Dashboard</a></li>
						
					  </ul>
					</li>
					
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
					if(user == null){
						
						response.sendRedirect("index.jsp");
					}	
					else
					{
						if(user.getUserType().equals("Admin")){	

						%>
					
					
					<li class="dropdown">
					  <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Reports <span class="caret"></span></a>
					  <ul class="dropdown-menu">
						<li><a href="report_management.jsp">Report Management</a></li>
						
					  </ul>
					</li>
					<%} %>
					
					<li class="dropdown">
					  <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Help <span class="caret"></span></a>
					  <ul class="dropdown-menu">
						<li><a href="#">FAQ</a></li>
						
					  </ul>
					</li>
                </ul>
				
				<ul class="nav navbar-nav navbar-right">
					  
					
											
										<li class="dropdown">
											<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><%out.println(user.getUsername() + " " + user.getUserId());%><span class="caret"></span></a>
											<ul class="dropdown-menu">
											<%if(user.getUserType().equals("Admin")){%>
											<li><a href="admin_index.html">Admin</a></li>
											<%} %>
											<li><a href="#" data-toggle="modal" data-target="#logOutModal">Log Out</a></li>
												
											</ul>
										</li>
										
				</ul>
            </div>
            <!-- /.navbar-collapse -->
        </div>
        <!-- /.container -->
    </nav>

    <!-- Page Content -->
    <div class="container">

        <!-- Jumbotron Header -->
        <header class="jumbotron hero-spacer">
        	
        <ul class="nav nav-tabs">
         
                
           <%
        	 LoginService login = new LoginService();
			 int reportNum = 0;
             List<User> list = login.getListOfUsers();
             for (User log : list) {
            	 reportNum++;
            	 %>    
		
		
		  <li ><a href="#repotTab<%=reportNum%>" data-toggle="tab" aria-expanded="true"><%=log.getUsername()%></a></li>
		  <%} %>
		</ul>
		<div id="myTabContent" class="tab-content">
		 <%
        	 LoginService login1 = new LoginService();
			 reportNum = 0;
             List<User> list1 = login.getListOfUsers();
             //Get list of users
             for (User log : list1) {
            	 reportNum++;
            	 %>  
            <%if(reportNum==1){
            	%><div class="tab-pane fade active in" id="repotTab<%=reportNum%>"><% 
            }
            else
            {
            	%><div class="tab-pane fade in" id="repotTab<%=reportNum%>"><%
            }
            %>
		  
		    <div class="panel-group" id="accordion">
			<div class='panel panel-default'>
			<div class='panel-heading'>
	        <h4 class='panel-title'>
	        <a data-toggle='collapse' data-parent='#accordion' href='#collapseLogged<%=reportNum%>'>Logged</a>
	        </h4>
	        </div>
	        <div id='collapseLogged<%=reportNum%>' class='panel-collapse collapse'>
	        <div class='panel-body'>
				        <% 
							Logger log2 = new Logger();
							String userName = log.getUsername();  
							//present all logged actions
							out.println(log2.read(userName, "logged"));
							
						%>
			</div>
			</div>
			</div>
			
			<div class="panel-group" id="accordion">
			<div class='panel panel-default'>
			<div class='panel-heading'>
	        <h4 class='panel-title'>
	        <a data-toggle='collapse' data-parent='#accordion' href='#collapseCreate<%=reportNum%>'>Created</a>
	        </h4>
	        </div>
	        <div id='collapseCreate<%=reportNum%>' class='panel-collapse collapse'>
	        <div class='panel-body'>
				        <% 
				      		//present all created actions  
							out.println(log2.read(userName, "create"));
							
						%>
			</div>
			</div>
			</div>
			
			
			<div class="panel-group" id="accordion">
			<div class='panel panel-default'>
			<div class='panel-heading'>
	        <h4 class='panel-title'>
	        <a data-toggle='collapse' data-parent='#accordion' href='#collapseUpdate<%=reportNum%>'>Updated</a>
	        </h4>
	        </div>
	        <div id='collapseUpdate<%=reportNum%>' class='panel-collapse collapse'>
	        <div class='panel-body'>
				        <% 
				      		//present all updated actions
							out.println(log2.read(userName, "update"));
							
						%>
			</div>
			</div>
			</div>
			
			
			<div class="panel-group" id="accordion">
			<div class='panel panel-default'>
			<div class='panel-heading'>
	        <h4 class='panel-title'>
	        <a data-toggle='collapse' data-parent='#accordion' href='#collapseRemove<%=reportNum%>'>Removed</a>
	        </h4>
	        </div>
	        <div id='collapseRemove<%=reportNum%>' class='panel-collapse collapse'>
	        <div class='panel-body'>
				        <% 
				      		//present all removed actions
							out.println(log2.read(userName, "remove"));
							
						%>
			</div>
			</div>
			</div>
			       
				    </div>
		  </div>
	</div>
	</div>
	</div>
	<%}}%>
	
	
  
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
		
        </header>
	
        <hr>
		
		<!-- Modal -->
    <!-- /.container -->

    <!-- jQuery -->
    <script src="js/jquery.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="js/bootstrap.min.js"></script>

        <!-- Footer -->
        <footer>
            <div class="row">
                <div class="col-lg-12">
                    <p>Copyright &copy; Michael Mullarkey 2016</p>
                </div>
            </div>
        </footer>

   </div>
</body>

</html>
