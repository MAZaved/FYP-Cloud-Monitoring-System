<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="model.User"%>
<%@page import="model.Alert"%>
<%@page import="service.AlertService"%>
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
					
					<%
					//if user is not valid, then redirect them to index.jsp
					User user = (User) session.getAttribute("user");
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
        
        <%
        			//present all alerts
        			AlertService alert = new AlertService();
          			 int alertNum = 0;
                     List<Alert> list = alert.getListOfServices();
                     for (Alert alert1 : list) {
                    	 alertNum++;
                    	 if(user.getUserId() == alert1.getUserId()){
                 %>
                 
                 <div id="alertModal<%=alertNum%>" class="modal fade" role="dialog">
		  <div class="modal-dialog">
			<form data-toggle="validator" action='AlertServlet' method='POST'>
			<!-- Modal content-->
			<div class="modal-content">
			  <div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title">Alert</h4>
			  </div>
			  <div class="modal-body">
		<input  name="userId" id="focusedInput" type="hidden" value="<%=user.getUserId()%>">
		<input  name="alertId" id="focusedInput" type="hidden" value="<%=alert1.getAlertId()%>">
		<div class="row" style="margin-top: 6%;">
						<div class="form-group col-md-3">
						  <label class="control-label" for="focusedInput">Alert Name</label>
						  <input name=alertName class="form-control input-sm" id="focusedInput" type="text" value="<%=alert1.getAlertName()%>" required>
						  <div class="help-block with-errors"></div>
						</div>
						
						<div class="form-group col-md-3">
						  <label class="control-label" for="focusedInput">Metric Name</label>
						  <input name="metricName" class="form-control input-sm" id="focusedInput" type="text" value="<%=alert1.getMetricName()%>" required>
						  <div class="help-block with-errors"></div>
						</div>
						
						<div class="form-group col-md-3">
						  <label class="control-label" for="focusedInput">Threshold</label>
						  <input name="threshold" class="form-control input-sm" id="focusedInput" type="text" value="<%=alert1.getThreshold()%>" required>
						  <div class="help-block with-errors"></div>
						</div>
						
						<div class="form-group col-md-3">
						  <label class="control-label" for="focusedInput">Interval</label>
						  <input name="interval" class="form-control input-sm" id="focusedInput" type="text" value="<%=alert1.getTimeInterval()%>" required>
						  <div class="help-block with-errors"></div>
						</div>
					</div>
					
					
					
					
						
					<div class="row" >
						<div class="form-group col-md-4">
						  <label class="control-label" for="focusedInput">Extra Email Recipient</label>
						  <input name="extraRecipient" class="form-control input-sm" id="focusedInput" type="text" value="<%=alert1.getExtraRecipient()%>" required>
							<div class="help-block with-errors"></div>
						</div>
					</div>
					<hr>
				
				<button name="removeAlert" class="btn btn-info">Remove Monitor</button>
			  </div>
			  <div class="modal-footer">
				<button class="btn btn-default" data-dismiss="modal" type="reset">Close</button>
				<button name="updateAlert" class="btn btn-primary" type="submit">Save</button>
			  </div>
			</div>		
			</form>
		  </div>
		</div>
		
			<div class="row">
				<div class="col-md-2">
				  <label class="control-label" for="focusedInput">Alert Name</label>
				  <p style="font-size:120%"><%=alert1.getAlertName()%></p>
				</div>
				
				<div class="col-md-2 ">
				  <label class="control-label" for="focusedInput">Enabled/Disabled</label>
				  <p style="font-size:120%">Enabled</p>
				</div>
				
				<div class="col-md-2">
				  <label class="control-label" for="focusedInput">Owner</label>
				  <p style="font-size:120%"><%=user.getUsername()%></p>
				</div>
				
				
				<div class="col-md-2">
				 <button type="button" class="btn btn-info btn-md" data-toggle="modal" data-target="#alertModal<%=alertNum%>">Edit</button>
				</div>
			</div>
			
			<hr>
			
			<%}}}%>
			
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
    <!-- /.container -->

    <!-- jQuery -->
    <script src="js/jquery.js"></script>
	   <script src="js/validator.js"></script>
    <!-- Bootstrap Core JavaScript -->
    <script src="js/bootstrap.min.js"></script>

</body>

</html>
