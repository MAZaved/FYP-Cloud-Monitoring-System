<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.util.List"%>
<%@page import="service.LoginService"%>
<%@page import="model.User"%>
<%@page import="model.Alert"%>
<%@page import="service.AlertService"%>
<%@page import="database.DbClass"%>
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

<style>
.error{
	color: red;
}

</style>

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
    <%
    				//TEST FOR CALLING ALERTS
	   			  //DbClass db = new DbClass();
				  //AlertService alertService = new AlertService();
					 
			      //List<Alert> list = alertService.getListOfServices();
                     //for (Alert alert : list) {
                    	 
                    	// if(user.getUserId() == alert.getUserId()){
                    	
                    		// db.checkAlerts(user.getEmail(), alert.getMetricName(), alert.getThreshold()); 
                    	 //}
                    //}
                 //%>
    <%if(null!=request.getAttribute("successMessage"))
		    {
		    	%>
		    	<div class="alert alert-success" role="alert">
		    		<button type="button" class="close" data-dismiss="alert">X</button>
		    	  <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
		    	 
		    	  Monitor Added Successfully
		    	</div><%
		    }
		    if(null!=request.getAttribute("errorMessage"))
		    {
		    	%>
		    	<div class="alert alert-danger" role="alert">
		    		<button type="button" class="close" data-dismiss="alert">X</button>
		    	  <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
		    	 
		    	  Error
		    	</div><%
		    }%>

    <!-- Page Content -->
    <div class="container">

        <!-- Jumbotron Header -->
        <header class="jumbotron hero-spacer">
            <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
  <div class="panel panel-default">
    <div class="panel-heading" role="tab" id="headingOne">
      <h4 class="panel-title">
        <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
          Service Monitoring
        </a>
      </h4>
    </div>
    <div id="collapseOne" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne">
      <div class="panel-body">
	  <form data-toggle="validator" id="serviceForm" action='ServiceMonitoringServlet' method='POST'>
	  
	  <input class="form-control input-sm"  name="userId" id="focusedInput" type="hidden" value="<%=user.getUserId()%>">
		<div class="row" style="margin-top: 2%;">
			<div class="form-group col-md-3">
			  <label class="control-label" for="focusedInput">Host</label>
			  <input id="serviceHost" class="form-control input-sm" name="host" id="focusedInput" type="text" value="" required>
			  <div class="help-block with-errors"></div>
			</div>
			
			<div class="form-group col-md-3">
			  <label class="control-label" for="focusedInput">Port</label>
			  <input id ="servicePort" class="form-control input-sm" name="port" id="focusedInput" type="number" value="" required>
			  <div class="help-block with-errors"></div>
			</div>
			
			<div class="form-group col-md-3">
			  <label class="control-label" for="focusedInput">User Name</label>
			  <input id="serviceUsername" class="form-control input-sm" name="username" id="focusedInput" type="text" value="" required>
			  <div class="help-block with-errors"></div>
			</div>
			
			<div class="form-group col-md-3">
			  <label class="control-label" for="focusedInput">Password</label>
			  <input id="servicePassword" class="form-control input-sm" name="password" id="focusedInput" type="password" value="" required>
			  <div class="help-block with-errors"></div>
			</div>
		</div> 
		<hr>
		
		<div class="row" style="margin-top: 6%;">
			<div class="form-group col-md-3">
			  <label class="control-label" for="focusedInput">Service Name</label>
			  <input id="serviceName" class="form-control input-sm" name="serviceName" id="focusedInput" type="text" value="" required>
			  <div class="help-block with-errors"></div>
			</div>
			
			<div class="form-group col-md-3">
			  <label class="control-label" for="focusedInput">Select Tool</label>
			  <input id="selectTool" class="form-control input-sm" name="selectTool" id="focusedInput" type="text" value="" required>
			  <div class="help-block with-errors"></div>
			</div>
			
			<div class="form-group col-md-3">
			  <label class="control-label" for="focusedInput">Url/IP</label>
			  <input id="serviceUrl" name="url" class="form-control input-sm" id="focusedInput" type="text" value="" required>
			  <div class="help-block with-errors"></div>
			</div>
			
			<div class="form-group col-md-3">
			  <label class="control-label" for="focusedInput">Interval</label>
			  <input id="serviceInterval" class="form-control input-sm" name="interval" id="focusedInput" type="number" value="" required>
			  <div class="help-block with-errors"></div>
			</div>
		</div> 
		
		<div class="row" style="margin-top: 6%;">
			<div class="form-group col-md-3">
			  <label class="control-label" for="focusedInput">Duration</label>
			  <input id="serviceDuration" class="form-control input-sm" name="duration" id="focusedInput" type="number" value="" required>
			  <div class="help-block with-errors"></div>
			</div>
			
			<div class="form-group col-md-3">
			  <label class="control-label" for="focusedInput">Web Url</label>
			  <input id="serviceWebUrl" class="form-control input-sm" type="url" name="webUrl" id="focusedInput" type="text" value="" required>
			  <div class="help-block with-errors"></div>
			</div>
			
			
		</div> 
		
		 <div class="col-lg-offset-10" style="margin-top: 3%; margin-right: 0%;">
       <button class="btn btn-default" type="reset">Reset</button>
        <button class="btn btn-primary" type="submit">Save</button>
      </div>

	
	</form>
        </div>
    </div>
  </div>
  <div class="panel panel-default">
    <div class="panel-heading" role="tab" id="headingTwo">
      <h4 class="panel-title">
        <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
          Resource Monitoring
        </a>
      </h4>
    </div>
    <div id="collapseTwo" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingTwo">
      <div class="panel-body">
	  
        
					<ul class="nav nav-tabs">
			  <li class="active"><a href="#server" data-toggle="tab">Server</a></li>
			  <li><a href="#agent" data-toggle="tab">Agent</a></li>
			  
			</ul>
		<div id="myTabContent" class="tab-content">	
		<div class="tab-pane fade active in" id="server">
		<form data-toggle="validator" id="resourceForm" action='ResourceMonitoringServlet' method='POST'>
		<div class="row" style="margin-top: 2%;">
		<input class="form-control input-sm"  name="userId" id="focusedInput" type="hidden" value="<%=user.getUserId()%>">
			<div class="form-group col-md-3">
			  <label class="control-label" for="focusedInput">Host</label>
			  <input name="host" id="" class="form-control input-sm" id="focusedInput" type="text" value="" required>
			  <div class="help-block with-errors"></div>
			</div>
			
			<div class="form-group col-md-3">
			  <label class="control-label" for="focusedInput">Port</label>
			  <input name="port" id="port" class="form-control input-sm" id="focusedInput" type="number" value="" required>
			  <div class="help-block with-errors"></div>
			</div>
			
			<div class="form-group col-md-3">
			  <label class="control-label" for="focusedInput">User Name</label>
			  <input name="username" id="username" class="form-control input-sm" id="focusedInput" type="text" value=""required>
			  <div class="help-block with-errors"></div>
			</div>
			
			<div class="form-group col-md-3">
			  <label class="control-label" for="focusedInput">Password</label>
			  <input name="password" id="password" class="form-control input-sm" id="focusedInput" type="password" value=""required>
			  <div class="help-block with-errors"></div>
			</div>
		</div> 
		
		<div class="row" style="margin-top: 6%;">
			<div class="form-group col-md-3">
			  <label class="control-label" for="focusedInput">Group</label>
			  <input name="group" id="groupID" class="form-control input-sm" id="focusedInput" type="number" value=""required>
			  <div class="help-block with-errors"></div>
			</div>
			
			<div class="form-group col-md-3">
			  <label class="control-label" for="focusedInput">Time Interval</label>
			  <input name="interval" id="interval" class="form-control input-sm" id="focusedInput" type="number" value=""required>
				<div class="help-block with-errors"></div>
			</div>
			
			
			<div class="form-group col-md-3">
			  <label class="control-label" for="focusedInput">Duration</label>
			  <input name="duration" id=duration class="form-control input-sm" id="focusedInput" type="number" value=""required>
			  <div class="help-block with-errors"></div>
			</div>
		</div> 
		<div class="col-lg-offset-10" style="margin-top: 3%; margin-right: 0%;">
       <button class="btn btn-default" type="reset">Reset</button>
        <button class="btn btn-primary" type="submit">Save</button>
      </div>
      </form>
		</div>
	
		<div class="tab-pane fade" id="agent">
		<form data-toggle="validator" id="agentForm" action='ResourceAgentServlet' method='POST'>
		<div class="row" style="margin-top: 0%;">
		<input class="form-control input-sm"  name="userId" id="focusedInput" type="hidden" value="<%=user.getUserId()%>">
			<div class="form-group col-md-3">
			  <label class="control-label" for="focusedInput">Hostname</label>
			  <input name="hostname" id="agentHost" class="form-control input-sm" id="focusedInput" type="text" value=""required>
			<div class="help-block with-errors"></div>
			</div>
			
			<div class="form-group col-md-3">
			  <label class="control-label" for="focusedInput">Port</label>
			  <input name="port" id="agentPort" class="form-control input-sm" id="focusedInput" type="number" value="" required>
			  <div class="help-block with-errors"></div>
			</div>
			
			<div class="form-group col-md-3">
			  <label class="control-label" for="focusedInput">Group ID</label>
			  <input name="groupID" id="agentGroup" class="form-control input-sm" id="focusedInput" type="number" value=""required>
			  <div class="help-block with-errors"></div>
			</div>
			
		</div> 
			<div class="col-lg-offset-10" style="margin-top: 3%; margin-right: 0%;">
       <button class="btn btn-default" type="reset">Reset</button>
        <button class="btn btn-primary" type="submit">Save</button>
      </div>
      </form>
		</div>
		</div>

	</div>
	</div>
    
  </div>
  
  <div class="panel panel-default">
    <div class="panel-heading" role="tab" id="headingThree">
      <h4 class="panel-title">
        <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
           Proxy Settings
        </a>
      </h4>
    </div>
    <div id="collapseThree" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingThree">
      <div class="panel-body">
	  
       			<ul class="nav nav-tabs">
			  <li class="active"><a href=#http data-toggle="tab">http</a></li>
			  <li><a href="#https" data-toggle="tab">https</a></li>
			  <li><a href="#ftp" data-toggle="tab">ftp</a></li>
			  
			</ul>
		<div id="myTabContent" class="tab-content">	
		<div class="tab-pane fade active in" id="http">
		<form data-toggle="validator" id="httpForm" action='ProxySettingsServlet' method='POST'>
			<div class="row" style="margin-top: 2%;"> 
			<input class="form-control input-sm"  name="userId" id="focusedInput" type="hidden" value="<%=user.getUserId()%>">
			<input class="form-control input-sm"  name="proxyType" id="focusedInput" type="hidden" value="http">
			<div class="form-group col-md-3">
			  <label class="control-label" for="focusedInput">Url/ip</label>
			  <input name="url" id="httpUrl" type="url" class="form-control input-sm" id="focusedInput" type="text" value="" required>
			  <div class="help-block with-errors"></div>
			</div>
			
			<div class="form-group col-md-3">
			  <label class="control-label" for="focusedInput">Port</label>
			  <input name="port" id="httpPort" class="form-control input-sm" id="focusedInput" type="number" value=""required>
			  <div class="help-block with-errors"></div>
			</div>
			
			<div class="form-group col-md-2">
			  <label class="control-label" for="focusedInput">User Name</label>
			  <input name="username" id="httpUsername" class="form-control input-sm" id="focusedInput" type="text" value="" required>
			  <div class="help-block with-errors"></div>
			</div>
			
			<div class="form-group col-md-2">
			  <label class="control-label" for="focusedInput">Password</label>
			  <input name="password" id="httpPassword" class="form-control input-sm" id="focusedInput" type="password" value="" required>
			  <div class="help-block with-errors"></div>
			</div>
		</div> 
			<div class="col-lg-offset-10" style="margin-top: 3%; margin-right: 0%;">
		       <button class="btn btn-default" type="reset">Reset</button>
		        <button class="btn btn-primary" type="submit">Save</button>
		      </div>
		      </form>
		</div>
		
		<div class="tab-pane fade" id="https">
		<form data-toggle="validator" id="httpsForm" action='ProxySettingsServlet' method='POST'>
			<div class="row" style="margin-top: 6%;">
			<input class="form-control input-sm"  name="userId" id="focusedInput" type="hidden" value="<%=user.getUserId()%>">
			<input class="form-control input-sm"  name="proxyType" id="focusedInput" type="hidden" value="https">
			<input class="form-control input-sm"  name="username" id="focusedInput" type="hidden" value="n/a">
			<input class="form-control input-sm"  name="password" id="focusedInput" type="hidden" value="n/a">
		
			<div class="form-group col-md-3">
			  <label class="control-label" for="focusedInput">Url/ip</label>
			  <input name="url" id="httpsUrl" type="url" class="form-control input-sm" id="focusedInput" type="text" value="" required>
			  <div class="help-block with-errors"></div>
			</div>
			
			<div class="form-group col-md-3">
			  <label class="control-label" for="focusedInput">Port</label>
			  <input name="port" id="httpsPort" class="form-control input-sm" id="focusedInput" type="number" value="" required>
			  <div class="help-block with-errors"></div>
			</div>
		</div>
			<div class="col-lg-offset-10" style="margin-top: 3%; margin-right: 0%;">
		       <button class="btn btn-default" type="reset">Reset</button>
		        <button class="btn btn-primary" type="submit">Save</button>
		      </div>
		      </form>
		</div>
		
		
		
		<div class="tab-pane fade" id="ftp">
		<form data-toggle="validator" id="ftpForm" action='ProxySettingsServlet' method='POST'>
		<div class="row" style="margin-top: 6%;">	
		<input class="form-control input-sm"  name="userId" id="focusedInput" type="hidden" value="<%=user.getUserId()%>">
		<input class="form-control input-sm"  name="proxyType" id="focusedInput" type="hidden" value="ftp">
		<input class="form-control input-sm"  name="username" id="focusedInput" type="hidden" value="n/a">
			<input class="form-control input-sm"  name="password" id="focusedInput" type="hidden" value="n/a">
		
			<div class="form-group col-md-3">
			  <label class="control-label" for="focusedInput">Url/ip</label>
			  <input name="url" id="ftpUrl" type="url" class="form-control input-sm" id="focusedInput" type="text" value="" required>
			  <div class="help-block with-errors"></div>
			</div>
			
			<div class="form-group col-md-3">
			  <label class="control-label" for="focusedInput">Port</label>
			  <input name="port" id="ftpPort" class="form-control input-sm" id="focusedInput" type="number" value=""required>
			  <div class="help-block with-errors"></div>
			</div>
		</div>  
			<div class="col-lg-offset-10" style="margin-top: 3%; margin-right: 0%;">
		       <button class="btn btn-default" type="reset">Reset</button>
		        <button class="btn btn-primary" type="submit">Save</button>
		      </div>
		      </form>
		</div>
		
		
		</div>
		
	</div>

	</div>
    </div>

</div>
<%} %>

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

    <!-- jQuery -->
    <script src="js/jquery.js"></script>
    <script src="js/validator.js"></script>
    <!-- Bootstrap Core JavaScript -->
    
  
    <script src="js/bootstrap.min.js"></script>
  
    

</body>

</html>
