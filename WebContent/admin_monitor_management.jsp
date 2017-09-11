<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="model.User"%>
<%@page import="model.ServiceMonitoring"%>
<%@page import="model.ResourceMonitoring"%>
<%@page import="model.ResourceAgent"%>
<%@page import="model.ProxySettings"%>
<%@page import="service.ServiceMonitoringService"%>
<%@page import="service.ResourceMonitoringService"%>
<%@page import="service.ResourceAgentService"%>
<%@page import="service.ProxySettingsService"%>
<%@page import="java.util.List"%>
<!-- @author Michael Mullarkey (112457292) -->
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Prototype</title>
	 <script src="js/jquery.js"></script>
    <!-- Bootstrap Core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    
    <link href="css/heroic-features.css" rel="stylesheet">

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

    <!-- Page Content -->
    <div class="container">

        <!-- Jumbotron Header -->
        <header  class="jumbotron hero-spacer">
        		<% 
        		ServiceMonitoringService service = new ServiceMonitoringService();
     			 int serviceNum = 0;
                List<ServiceMonitoring> list = service.getListOfServices();
        			
        			if(!list.isEmpty())
                    {
                    %>
	               <label style="margin-bottom: 3%;font-size:150%; color: rgb(55, 90, 127)">Service(s):</label>
	                
                    
          			<%
                    }
          		     //present all service monitors
                     for (ServiceMonitoring servicemonitoring : list) {
                    	 serviceNum++;
                    	
                 %>
                 		<div id="serviceModal<%=serviceNum%>" class="modal fade" role="dialog">
					  <div class="modal-dialog">
			
						<!-- Modal content-->
						<form data-toggle="validator" action='ServiceMonitoringServlet' method='POST'>
						
	                 	<input  name="userId" id="focusedInput" type="hidden" value="<%=servicemonitoring.getUserId()%>">
	                 	<input  name="page" id="focusedInput" type="hidden" value="admin_monitor_management.jsp">
						<div class="modal-content">
						  <div class="modal-header">
							<button type="button" class="close" data-dismiss="modal">&times;</button>
							<h4 class="modal-title">Service Monitoring</h4>
						  </div>
						  <div class="modal-body">
						  <input name="serviceMonitorId" type="hidden" id="focusedInput" value="<%=servicemonitoring.getServiceMonitorId()%>">
						  <div class="row" style="margin-top: 2%;">
						<div class="form-group col-md-3">
						  <label class="control-label" for="focusedInput">Host</label>
						  <input name="host" class="form-control input-sm" id="focusedInput" type="text"  value="<%=servicemonitoring.getHost()%>" required>
						  <div class="help-block with-errors"></div>
						</div>
						
						<div class="form-group col-md-3">
						  <label class="control-label" for="focusedInput">Port</label>
						  <input name="port" class="form-control input-sm" id="focusedInput" type="number" value="<%=servicemonitoring.getPort()%>"required>
						  <div class="help-block with-errors"></div>
						</div>
						
						<div class="form-group col-md-3">
						  <label class="control-label" for="focusedInput">User Name</label>
						  <input name="username" class="form-control input-sm" id="focusedInput" type="text" value="<%=servicemonitoring.getUsername()%>"required>
						  <div class="help-block with-errors"></div>
						</div>
						
						<div class="form-group col-md-3">
						  <label class="control-label" for="focusedInput">Password</label>
						  <input name="password" class="form-control input-sm" id="focusedInput" type="password" value="<%=servicemonitoring.getPassword()%>"required>
						  <div class="help-block with-errors"></div>
						</div>
					</div> 
					
					<hr>
					
					<div class="row" style="margin-top: 6%;">
						<div class="form-group col-md-3">
						  <label class="control-label" for="focusedInput">Monitor Name</label>
						  <input name="serviceName" class="form-control input-sm" id="focusedInput" type="text"  value="<%=servicemonitoring.getServiceName()%>" required>
						  <div class="help-block with-errors"></div>
						</div>
						
						<div class="form-group col-md-3">
						  <label class="control-label" for="focusedInput">Select Tool</label>
						  <input name="selectTool" class="form-control input-sm" id="focusedInput" type="text" value="<%=servicemonitoring.getSelectTool()%>" required>
						  <div class="help-block with-errors"></div>
						</div>
						
						<div class="form-group col-md-3">
						  <label class="control-label" for="focusedInput">Url/IP</label>
						  <input name="url" class="form-control input-sm" id="focusedInput" type="text"  value="<%=servicemonitoring.getUrl()%>" required>
						  <div class="help-block with-errors"></div>
						</div>
						
						<div class="form-group col-md-3">
						  <label class="control-label" for="focusedInput">Interval</label>
						  <input name="interval" class="form-control input-sm" id="focusedInput" type="number" value="<%=servicemonitoring.getInterval()%>" required>
						  <div class="help-block with-errors"></div>
						</div>
					</div> 
					
					<div class="row" style="margin-top: 6%;">
						<div class="form-group col-md-3">
						  <label class="control-label" for="focusedInput">Duration</label>
						  <input name="duration" class="form-control input-sm" id="focusedInput" type="number" value="<%=servicemonitoring.getDuration()%>"required>
						  <div class="help-block with-errors"></div>
						</div>
						
						<div class="form-group col-md-3">
						  <label class="control-label" for="focusedInput">Web Url</label>
						  <input name="webUrl" class="form-control input-sm" id="focusedInput" type="text" value="<%=servicemonitoring.getWebUrl()%>" required>
						  <div class="help-block with-errors"></div>
						</div>
					</div> 
							
							<button name="removeService" style="margin-top: 5%" class="btn btn-info">Remove Monitor</button>
						  </div>
						  <div class="modal-footer">
							<button class="btn btn-default" data-dismiss="modal" type="reset">Close</button>
							<button name="updateService" class="btn btn-primary" type="submit">Save</button>
						  </div>
						</div>
	                 </form>
					  </div>
					</div>
					<!-- END OF MODAL ServiceModal-->
					
	                 <form  name='form' action='StartStopServlet' method='POST'>
	                 <input  name="page" id="focusedInput" type="hidden" value="admin_monitor_management.jsp">
	                 <input  name="serviceMonitorId" id="focusedInput" type="hidden" value="<%=servicemonitoring.getServiceMonitorId()%>">
	                 <input  name="userId" id="focusedInput" type="hidden" value="<%=servicemonitoring.getUserId()%>">
	                 <input  name="host" id="focusedInput" type="hidden" value="<%=servicemonitoring.getHost()%>">
	                 <input  name="port" id="focusedInput" type="hidden" value="<%=servicemonitoring.getPort()%>">
	                 <input  name="username" id="focusedInput" type="hidden" value="<%=servicemonitoring.getUsername()%>">
	                 <input  name="password" id="focusedInput" type="hidden" value="<%=servicemonitoring.getPassword()%>">
	                 <input  name="serviceName" id="focusedInput" type="hidden" value="<%=servicemonitoring.getServiceName()%>">
	                 <input  name="selectTool" id="focusedInput" type="hidden" value="<%=servicemonitoring.getSelectTool()%>">
	                 <input  name="url" id="focusedInput" type="hidden" value="<%=servicemonitoring.getUrl()%>">
	                 <input  name="interval" id="focusedInput" type="hidden" value="<%=servicemonitoring.getInterval()%>">
	                 <input  name="duration" id="focusedInput" type="hidden" value="<%=servicemonitoring.getDuration()%>">
	                 <input  name="webUrl" id="focusedInputk" type="hidden" value="<%=servicemonitoring.getWebUrl()%>">
	                 
	                 <input class="form-control input-sm"  name="userId" id="focusedInput" type="hidden" value="<%=user.getUserId()%>">
	                 
	                 <div id="monitor-toggle" class="row">
	                
						<div class="col-md-2">
						  <label class="control-label" for="focusedInput">Monitor Name</label>
						  <p style="font-size:120%"><%=servicemonitoring.getServiceName()%></p>
						</div>
						
						<div  class="col-md-2">
						  <label class="control-label" for="focusedInput">Enabled/Disabled</label>
						  <div id="progressServiceType<%=serviceNum%>"class="progress progress-striped">
						  <div id="progressService<%=serviceNum%>" class="prog progress-bar progress-bar-danger" style="width: 100%"></div>
						</div>
			
						</div>
						
						<div class="col-md-2 col-md-offset-1">
						  <label class="control-label" for="focusedInput">Owner</label>
						  <p style="font-size:120%"><%=servicemonitoring.getUsername()%></p>
						</div>
						
						<div class="col-md-1">
						 <button name="StartService" id="startBtn<%=serviceNum%>" type="submit" class="btn btn-success btn-md"><span class="glyphicon glyphicon-play"></span></button>
						</div>
						<div class="col-md-1">
						 <button name="StopService" id="stopBtn<%=serviceNum%>" type="submit" class="btn btn-success btn-md"><span class="glyphicon glyphicon-stop"></span></button>
						</div>
						
						<div class="col-md-1">
						 <button type="button" class="btn btn-info btn-md" data-toggle="modal" data-target="#serviceModal<%=serviceNum%>">Edit</button>
						</div>
					</div>
					<script>
					$('#startBtn'+<%=serviceNum%>).click(function () {
					
					     $("#progressService"+<%=serviceNum%>).removeClass('progress-bar-danger');
					    $("#progressService"+<%=serviceNum%>).addClass('progress-bar-success');
					    $("#progressServiceType"+<%=serviceNum%>).addClass('active');
					});
					
					$('#stopBtn'+<%=serviceNum%>).click(function () {
					    
					     $("#progressServiceType"+<%=serviceNum%>).removeClass('progress-bar-success');
					    $("#progressService"+<%=serviceNum%>).addClass('progress-bar-danger');
					   
					    $("#progressServiceType"+<%=serviceNum%>).removeClass('active');
					});
					</script>
					</form>
	              <hr>
	                <%}%>
	                
	                
	                <%
	                ResourceMonitoringService resource = new ResourceMonitoringService();
                    List<ResourceMonitoring> resourceList = resource.getListOfServices();
                  
                    int resourceNum = 0; 
                    
                    if(!resourceList.isEmpty())
                    {
                    %>
	               <label style="margin-bottom: 3%;font-size:150%; color: rgb(55, 90, 127)">Resource(s):</label>
	                <%
                    }
          		     //present all resource monitors
                     for (ResourceMonitoring resourcemonitoring : resourceList) {
                    	 resourceNum++;
                    	 
                 %>
                 
                 
                 <div>
		<div id="addAgent<%=resourceNum%>" class="modal fade" role="dialog">
		  <div class="modal-dialog">

			<!-- Modal content-->
			<form data-toggle="validator" action='ResourceAgentServlet' method='POST'>
			<div class="modal-content">
			  <div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title">Add Agent</h4>
			  </div>
			   <div class="modal-body">
			   <input class="form-control input-sm"  name="userId" id="focusedInput" type="hidden" value="<%=user.getUserId()%>">
				<input  name="page" id="focusedInput" type="hidden" value="admin_monitor_management.jsp">
			  <input name="groupID" class="form-control input-sm" id="focusedInput" type="hidden" value="<%=resourcemonitoring.getGroup()%>">
			 
		<div class="row" style="margin-top: 2%;">
			<div class="form-group col-md-3">
			  <label  class="control-label" for="focusedInput">Host Name</label>
			  <input name="hostname" class="form-control input-sm" id="focusedInput" type="text" value="" required>
			  <div class="help-block with-errors"></div>
			</div>
			
			<div class="form-group col-md-3">
			  <label class="control-label" for="focusedInput">Port</label>
			  <input name="port" class="form-control input-sm" id="focusedInput" type="number" value="" required>
			  <div class="help-block with-errors"></div>
			</div>
			
		</div> 
			  </div>
			  <div class="modal-footer">
				<button class="btn btn-default" data-dismiss="modal" type="reset">Close</button>
        <button class="btn btn-primary" name="addAgent" type="submit">Save</button>
			  </div>
			</div>
			</form>
		  </div>
		</div>
                 
                 		<div id="resourceModal<%=resourceNum%>" class="modal fade" role="dialog">
				  <div class="modal-dialog">
		<input  name="page" id="focusedInput" type="hidden" value="admin_monitor_management.jsp">
					<!-- Modal content-->
					<form data-toggle="validator"action='ResourceMonitoringServlet' method='POST'>
					<div class="modal-content">
					  <div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title">Resource Monitoring</h4>
					  </div>
					  
					   <div class="modal-body">
				<div class="row" style="margin-top: 2%;">
				<input name="resourceMonitorId" class="form-control input-sm" id="focusedInput" type="hidden" value="<%=resourcemonitoring.getResourceMonitorId()%>">
				<input class="form-control input-sm"  name="userId" id="focusedInput" type="hidden" value="<%=user.getUserId()%>">
					<div class="form-group col-md-3">
					  <label class="control-label" for="focusedInput">Host</label>
					  <input name="host" class="form-control input-sm" id="focusedInput" type="text" value="<%=resourcemonitoring.getHost()%>" required>
					  <div class="help-block with-errors"></div>
					</div>
					
					<div class="form-group col-md-3">
					  <label class="control-label" for="focusedInput">Port</label>
					  <input name="port" class="form-control input-sm" id="focusedInput" type="number" value="<%=resourcemonitoring.getPort()%>" required>
					  <div class="help-block with-errors"></div>
					</div>
					
					<div class="form-group col-md-3">
					  <label class="control-label" for="focusedInput">User Name</label>
					  <input name="username" class="form-control input-sm" id="focusedInput" type="text" value="<%=resourcemonitoring.getUsername()%>" required>
					  <div class="help-block with-errors"></div>
					</div>
					
					<div class="form-group col-md-3">
					  <label class="control-label" for="focusedInput">Password</label>
					  <input name="password" class="form-control input-sm" id="focusedInput" type="password" value="<%=resourcemonitoring.getPassword()%>" required>
					  <div class="help-block with-errors"></div>
					</div>
				</div> 
				
				<div class="row" style="margin-top: 6%;">
					<div class="form-group col-md-3">
					  <label class="control-label" for="focusedInput">Group</label>
					  <input name="group" class="form-control input-sm" id="focusedInput" type="number" value="<%=resourcemonitoring.getGroup()%>" required>
					  <div class="help-block with-errors"></div>
					</div>
					
					<div class="form-group col-md-3">
					  <label class="control-label" for="focusedInput">Time Interval</label>
					  <input name="interval" class="form-control input-sm" id="focusedInput" type="number" value="<%=resourcemonitoring.getInterval()%>" required>
					  <div class="help-block with-errors"></div>
					</div>
					
					<div class="form-group col-md-3">
					  <label class="control-label" for="focusedInput">Duration</label>
					  <input name="duration" class="form-control input-sm" id="focusedInput" type="number" value="<%=resourcemonitoring.getDuration()%>" required>
					  <div class="help-block with-errors"></div>
					</div>
				</div> 
						<button name="removeResource" style="margin-top: 5%;" class="btn btn-info">Remove Monitor</button>
					  </div>
					  <div class="modal-footer">
						<button class="btn btn-default" data-dismiss="modal" type="reset">Close</button>
		        <button class="btn btn-primary" name="updateResource" type="submit">Save</button>
					  </div>
					  </div>
		      </form>
						
					
					</div>
		
				  </div>
				</div>
                 	<!-- END OF Resource Modal -->	
                 	
	                 <form name='form' action='StartStopServlet' method='POST'>
	                 <input  name="page" id="focusedInput" type="hidden" value="admin_monitor_management.jsp">
	                 <input  name="resourceMonitorId" id="focusedInput" type="hidden" value="<%=resourcemonitoring.getResourceMonitorId()%>">
	                 <input  name="userId" id="focusedInput" type="hidden" value="<%=resourcemonitoring.getUserId()%>">
	                 <input  name="host" id="focusedInput" type="hidden" value="<%=resourcemonitoring.getHost()%>">
	                 <input  name="port" id="focusedInput" type="hidden" value="<%=resourcemonitoring.getPort()%>">
	                 <input  name="group" id="focusedInput" type="hidden" value="<%=resourcemonitoring.getGroup()%>">
	                 <input  name="username" id="focusedInput" type="hidden" value="<%=resourcemonitoring.getUsername()%>">
	                 <input  name="password" id="focusedInput" type="hidden" value="<%=resourcemonitoring.getPassword()%>">
	                 <input  name="interval" id="focusedInput" type="hidden" value="<%=resourcemonitoring.getInterval()%>">
	                 <input  name="duration" id="focusedInput" type="hidden" value="<%=resourcemonitoring.getDuration()%>">
	                 
	                 <div id="monitor-toggle" class="row">
	                
						<div class="col-md-2">
						  <label class="control-label" for="focusedInput">Monitor Host</label>
						  <p style="font-size:120%"><%=resourcemonitoring.getHost()%></p>
						</div>
						
						<div  class="col-md-2">
						  <label class="control-label" for="focusedInput">Enabled/Disabled</label>
						  <div id="progressTypeResource<%=resourceNum%>"class="progress progress-striped">
						  <div id="progressResource<%=resourceNum%>" class="prog progress-bar progress-bar-danger" style="width: 100%"></div>
						</div>
					
						</div>
						
						<div class="col-md-2 col-md-offset-1">
						  <label class="control-label" for="focusedInput">Owner</label>
						  <p style="font-size:120%"><%=user.getUsername()%></p>
						</div>
						
						<div class="col-md-1">
						 <button name="StartResource" id="startResourceBtn<%=resourceNum%>" type="submit" class="btn btn-success btn-md"><span class="glyphicon glyphicon-play"></span></button>
						</div>
						<div class="col-md-1">
						 <button name="StopResource" id="stopResourceBtn<%=resourceNum%>" type="submit" class="btn btn-success btn-md"><span class="glyphicon glyphicon-stop"></span></button>
						</div>
						
						<div class="col-md-1">
						 <button type="button" class="btn btn-info btn-md" data-toggle="modal" data-target="#resourceModal<%=resourceNum%>">Edit</button>
						</div>
						
						<div class="col-md-1">
						 <button type="button" class="btn btn-warning btn-md" data-toggle="modal" data-target="#addAgent<%=resourceNum%>">Add Agent</button>
						</div>
					</div>
					<script>
					$('#startResourceBtn'+<%=resourceNum%>).click(function () {
					
					    $("#progressResource"+<%=resourceNum%>).removeClass('progress-bar-danger');
					    $("#progressResource"+<%=resourceNum%>).addClass('progress-bar-success');
					    $("#progressTypeResource"+<%=resourceNum%>).addClass('active');
					});
					
					$('#stopResourceBtn'+<%=resourceNum%>).click(function () {
					    
					    $("#progressTypeResource"+<%=resourceNum%>).removeClass('progress-bar-success');
					    $("#progressResource"+<%=resourceNum%>).addClass('progress-bar-danger');
					    $("#progressTypeResource"+<%=resourceNum%>).removeClass('active');
					});
					</script>
						</form>
						
						<% 
						 ResourceAgentService resourceAgent = new ResourceAgentService();
	                     List<ResourceAgent> resourceAgentList = resourceAgent.getListOfServices();
	                     int agentNum = 0;
        			
	        			if(!resourceAgentList.isEmpty())
	                    {
	                    %>
		               <label style="margin-bottom: 3%;font-size:120%; color: rgb(55, 90, 127)">Agents:</label>
		                
	                    
	          			<%
	                    }
						//present resource agent for each resource monitor
	                     for (ResourceAgent resourceagent : resourceAgentList) {
	                    	 agentNum++;
	                    	 if(resourcemonitoring.getGroup() == resourceagent.getGroupID()){
	                 %>
                 
                 	    <div id="agentModal<%=agentNum%>" class="modal fade" role="dialog">
				  <div class="modal-dialog">
		
					<!-- Modal content-->
					<form data-toggle="validator" action='ResourceAgentServlet' method='POST'>
					<div class="modal-content">
					  <div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title">Edit Agent</h4>
					  </div>
					   <div class="modal-body">
				<input  name="page" id="focusedInput" type="hidden" value="admin_monitor_management.jsp">
				<div class="row" style="margin-top: 2%;">
				<input class="form-control input-sm"  name="userId" id="focusedInput" type="hidden" value="<%=user.getUserId()%>">
				<input name="agentID" class="form-control input-sm" id="focusedInput" type="hidden" value="<%=resourceagent.getAgentID()%>">
					<div class="form-group col-md-3">
					  <label class="control-label" for="focusedInput">Host Name</label>
					  <input name="hostname" class="form-control input-sm" id="focusedInput" type="text" value="<%=resourceagent.getHostname()%>" required>
					  <div class="help-block with-errors"></div>
					</div>
					
					<div class="form-group col-md-3">
					  <label class="control-label" for="focusedInput">Port</label>
					  <input name="port" class="form-control input-sm" id="focusedInput" type="number" value="<%=resourceagent.getPort()%>" required>
					  <div class="help-block with-errors"></div>
					</div>
					
					<div class="form-group col-md-3">
					  <label class="control-label" for="focusedInput">Group ID</label>
					  <input name="groupID" class="form-control input-sm" id="focusedInput" type="number" value="<%=resourceagent.getGroupID()%>" required>
					  <div class="help-block with-errors"></div>
					</div>
				</div> 
				
						<button name="removeAgent" style="margin-top: 5%" class="btn btn-info">Remove Monitor</button>
					  </div>
					  <div class="modal-footer">
						<button class="btn btn-default" data-dismiss="modal" type="reset">Close</button>
		        <button class="btn btn-primary" name="updateAgent" type="submit">Save</button>
					  </div>
					</div>
					</form>
				  </div>
		</div>
                 		
                 		
                 		
					<div id="monitor-toggle" class="row">
						<div class="col-md-2">
						  <label class="control-label" for="focusedInput">Agent Hostname</label>
						  <p style="font-size:120%"><%=resourceagent.getHostname()%></p>
						</div>
						
						<div class="col-md-2">
						  <label class="control-label" for="focusedInput">Owner</label>
						  <p style="font-size:120%"><%=user.getUsername()%></p>
						</div>
						
						<div class="col-md-1">
						 <button type="button" class="btn btn-warning btn-md" data-toggle="modal" data-target="#agentModal<%=agentNum%>">Edit Agent</button>
						</div>
						
					</div>
					<hr>
					<%} %>
					
	              
	                <%}}%>
	                
	                
	                <% 
	                ProxySettingsService proxySettings = new ProxySettingsService();
                    List<ProxySettings> proxyList = proxySettings.getListOfServices();
                   
                    int proxyNum = 0;
        			
        			if(!proxyList.isEmpty())
                    {
                    %>
	               <label style="margin-bottom: 3%;font-size:150%; color: rgb(55, 90, 127)">Proxy Settings:</label>
	                
                    
          			<%
                    }
               
   
          		    //present all proxy settings
                     for (ProxySettings proxysettings : proxyList) {
                    	 proxyNum++;
                    	           		 
                 %>
                 
                 	
		
	                 <div>
		<div id="proxyModal<%=proxyNum%>" class="modal fade" role="dialog">
		  <div class="modal-dialog">
			<form data-toggle="validator"  action='ProxySettingsServlet' method='POST'>
			<!-- Modal content-->
			<div class="modal-content">
			  <div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title">Proxy Settings</h4>
			  </div>
			   <div class="modal-body">
			  
		<div class="row" style="margin-top: 2%;">
		<input  name="page" id="focusedInput" type="hidden" value="admin_monitor_management.jsp">
		<input  name="userId" id="focusedInput" type="hidden" value="<%=user.getUserId()%>">
		<input  name="proxyId" id="focusedInput" type="hidden" value="<%=proxysettings.getProxyId()%>">
		<div class="form-group col-md-2">
			  <label class="control-label" for="focusedInput">Type</label>
			  <input name="proxyType" class="form-control input-sm" id="focusedInput" type="text" value="<%=proxysettings.getProxyType()%>" required>
			  <div class="help-block with-errors"></div>
			</div>
			<div class="form-group col-md-2">
			  <label class="control-label" for="focusedInput">Url</label>
			  <input name="url" class="form-control input-sm" id="focusedInput" type="urk" value="<%=proxysettings.getUrl()%>" required>
			  <div class="help-block with-errors"></div>
			</div>
			
			<div class="form-group col-md-2">
			  <label class="control-label" for="focusedInput">Port</label>
			  <input name="port" class="form-control input-sm" id="focusedInput" type="number" value="<%=proxysettings.getPort()%>" required>
			  <div class="help-block with-errors"></div>
			</div>
			
			<div class="form-group col-md-2">
			  <label class="control-label" for="focusedInput">Username</label>
			  <input name="username" class="form-control input-sm" id="focusedInput" type="text" value="<%=proxysettings.getUsername()%>" required>
			  <div class="help-block with-errors"></div>
			</div>
			
			<div class="form-group col-md-2">
			  <label class="control-label" for="focusedInput">Password</label>
			  <input name="password" class="form-control input-sm" id="focusedInput" type="password" value="<%=proxysettings.getPassword()%>" required>
			  <div class="help-block with-errors"></div>
			</div>
			
		</div> 
				<button name="removeProxy" style="margin-top: 5%" class="btn btn-info">Remove Monitor</button>
			  </div>
			  <div class="modal-footer">
				<button class="btn btn-default" data-dismiss="modal" type="reset">Close</button>
        <button name="updateProxy" class="btn btn-primary" type="submit">Save</button>
			  </div>
			</div>
			</form>
		  </div>
		</div>
        

    </div>
	                 
	                 <input  name="userId" id="focusedInput" type="hidden" value="<%=proxysettings.getUserId()%>">
	                 <input  name="port" id="focusedInput" type="hidden" value="<%=proxysettings.getPort()%>">
	                 <input  name="username" id="focusedInput" type="hidden" value="<%=proxysettings.getUsername()%>">
	                 <input  name="password" id="focusedInput" type="hidden" value="<%=proxysettings.getPassword()%>">
	                <input  name="page" id="focusedInput" type="hidden" value="admin_monitor_management.jsp">
	                 <input  name="url" id="focusedInput" type="hidden" value="<%=proxysettings.getUrl()%>">
	           
	                 
	                 <div id="monitor-toggle" class="row">
	                	
						<div class="col-md-2">
						  <label class="control-label" for="focusedInput">Proxy Url</label>
						  <p style="font-size:120%"><%=proxysettings.getUrl()%></p>
						</div>
						
						<div class="col-md-2">
						  <label class="control-label" for="focusedInput">Proxy Type</label>
						  <p style="font-size:120%"><%=proxysettings.getProxyType()%></p>
						</div>
						
						
						<div class="col-md-2 col-md-offset-1">
						  <label class="control-label" for="focusedInput">Owner</label>
						  <p style="font-size:120%"><%=user.getUsername()%></p>
						</div>
						
						
						<div class="col-md-1">
						 <button type="button" class="btn btn-info btn-md" data-toggle="modal" data-target="#proxyModal<%=proxyNum%>">Edit</button>
						</div>
					</div>
					
	              <hr>
	                <%}}%>
                 
            
		
		
        </header>
      
</div>
        <hr>
		
		<!-- Modal -->

	   <!-- Footer -->
      <footer>
            <div class="row">
                <div class="col-lg-12">
                    <p>Copyright &copy; Michael Mullarkey 2016</p>
                </div>
            </div>
        </footer>	
		
       

    
        


    
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
						  <input name="password" class="form-control input-sm" id="focusedInput" type="password" value="" required>
						  <div class="help-block with-errors"></div>
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
 <!-- Footer -->
        
    <!-- jQuery -->
   
   <script src="js/validator.js"></script>
    <script src="js/monitoring.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="js/bootstrap.min.js"></script>
</body>

</html>
