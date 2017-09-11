<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.util.Arrays"%>
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
<%@page import="database.DbClass"%>

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
	
    <!-- Custom CSS -->
    <link href="css/heroic-features.css" rel="stylesheet">
	<link href="css/monitoring.css" rel="stylesheet">
	<link href="css/daterangepicker.css" rel="stylesheet">
  	

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
<style>
.tree {
    min-height:20px;
    padding:19px;
    margin-bottom:20px;
    background-color:#375a7f;
    
    -webkit-border-radius:4px;
    -moz-border-radius:4px;
    border-radius:4px;
    -webkit-box-shadow:inset 0 1px 1px rgba(0, 0, 0, 0.05);
    -moz-box-shadow:inset 0 1px 1px rgba(0, 0, 0, 0.05);
    box-shadow:inset 0 1px 1px rgba(0, 0, 0, 0.05)
}
.tree li {
    list-style-type:none;
    margin:0;
    padding:10px 5px 0 5px;
    position:relative
}
.tree li::before, .tree li::after {
    content:'';
    left:-20px;
    position:absolute;
    right:auto
}
.tree li::before {
    border-left:1px solid black;
    bottom:50px;
    height:100%;
    top:0;
    width:1px
}
.tree li::after {
    border-top:1px solid black;
    height:20px;
    top:25px;
    width:25px
}
.tree li span {
    -moz-border-radius:5px;
    -webkit-border-radius:5px;
    border:1px solid black;
    border-radius:5px;
    display:inline-block;
    padding:3px 8px;
    text-decoration:none
}
.tree li.parent_li>span {
    cursor:pointer
}
.tree>ul>li::before, .tree>ul>li::after {
    border:0
}
.tree li:last-child::before {
    height:26px
}
.tree li.parent_li>span:hover, .tree li.parent_li>span:hover+ul li span {
    background:#eee;
    border:1px solid #94a0b4;
    color:#000
}


#wrapper {
    padding-left: 0;
    -webkit-transition: all 0.5s ease;
    -moz-transition: all 0.5s ease;
    -o-transition: all 0.5s ease;
    transition: all 0.5s ease;
}

#wrapper.toggled {
    padding-left: 250px;
}

#sidebar-wrapper {
    z-index: 1000;
    position: fixed;
    left: 250px;
    width: 0;
    height: 100%;
    margin-left: -250px;
    overflow-y: auto;
    background: #375a7f;
    -webkit-transition: all 0.5s ease;
    -moz-transition: all 0.5s ease;
    -o-transition: all 0.5s ease;
    transition: all 0.5s ease;
}

#wrapper.toggled #sidebar-wrapper {
    width: 250px;
}

#page-content-wrapper {
    width: 100%;
    position: absolute;
    padding: 15px;
}

#wrapper.toggled #page-content-wrapper {
    position: absolute;
    
}

/* Sidebar Styles */

.sidebar-nav {
    position: absolute;
    top: 0;
    width: 250px;
    margin: 0;
    padding: 0;
    list-style: none;
}

.sidebar-nav li {
    text-indent: 20px;
    line-height: 40px;
}

.sidebar-nav li a {
    display: block;
    text-decoration: none;
    color: #999999;
}

.sidebar-nav li a:hover {
    text-decoration: none;
    color: #fff;
    background: rgba(255,255,255,0.2);
}

.sidebar-nav li a:active,
.sidebar-nav li a:focus {
    text-decoration: none;
}

.sidebar-nav > .sidebar-brand {
    height: 65px;
    font-size: 18px;
    line-height: 60px;
}

.sidebar-nav > .sidebar-brand a {
    color: #375a7f;
}

.sidebar-nav > .sidebar-brand a:hover {
    color: #fff;
    background: none;
}

@media(min-width:768px) {
    #wrapper {
        padding-left: 250px;
    }

    #wrapper.toggled {
        padding-left: 0;
    }

    #sidebar-wrapper {
        width: 300px;
    }

    #wrapper.toggled #sidebar-wrapper {
        width: 0;
    }

    #page-content-wrapper {
        padding: 20px;
        position: relative;
    }

    #wrapper.toggled #page-content-wrapper {
        position: relative;
        margin-right: 0;
    }
}
</style>


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


<div id="wrapper">
        <!-- Sidebar -->
        <div id="sidebar-wrapper">
        <label>Location</label>
        <select style="background-color:#303030; color: white;" id="location" class="form-control" >
			     <option id="tl">Top-Left</option>
				 <option id="tr">Top-Right</option>
				 <option id="ml">Middle-Left</option>
				 <option id="mr">Middle-Right</option>
				 <option id="bl">Bottom-Left</option>
				 <option id="br">Bottom-Right</option>
		</select>
		<div style="margin-top: 3%; margin-left:3%">
				<div>
				<label>From</label>
				<input style="margin-bottom: 6%;margin-left: 2%;" id="dateTo" type="Date">
				</div>
				<div>
				<label style="float: left; ">To</label>
				<input  style="margin-left: 10%;"id="dateFrom" type="Date">
				</div>
			</div>
			
			
			<button style="margin-top: 10%; margin-left: 18%;" class="btn btn-info" onClick="stop()">Stop/Delete</button>
		<hr>
		
		
		
<div class="tree well">
    <ul>
        <li>
            <span style="color: black;"><i  class="glyphicon glyphicon-folder-open"></i> Cloud A</span> 
            <ul>
                <li>
                	<span><i class="icon-minus-sign"></i> VM</span> 
                    <ul>
                        <li>
	                        <span><i class="icon-leaf"></i><button class="btn btn-info" onclick='start("1432397156", "CPU-IDLE")'> CPU</button></span> 
                        </li>
                    </ul>
                </li>
                
                <li>
                	<span><i class="icon-minus-sign"></i> VM2</span> 
                    <ul>
                        <li>
	                        <span><i class="icon-leaf"></i><button class="btn btn-info" onclick='start("1432397156", "MEM")'> MEM</button></span> 
                        </li>
                    </ul>
                </li>
               
            </ul>
        </li>
       
    </ul>
</div>
<div class="tree well">
        <ul>
		        <li>
		            <span style="color: black;"><i  class="glyphicon glyphicon-folder-open"></i>  Services</span> 
		            <ul>
        
    <%
          		     //present all service monitors on side bar
    				 ServiceMonitoringService service = new ServiceMonitoringService();
          			 int serviceNum = 0;
          			 String space = "  ";
                     List<ServiceMonitoring> list = service.getListOfServices();
                     for (ServiceMonitoring servicemonitoring : list) {
                    	 serviceNum++;
                    	 if(user.getUserId() == servicemonitoring.getUserId()){
                 %>

		                <li>
		                 
		                	<span><i class="icon-leaf"></i><button class="btn btn-info" onclick='start("1432397156", "<%=servicemonitoring.getServiceName()%>")'> <%=servicemonitoring.getServiceName()%></button></span> 
		                    
		                </li>

		    <%}} %>
		      </ul>
		        </li>
		        <li>
		           
		        </li>
		    </ul>
		    <hr>
		    <%

		    ResourceMonitoringService resource = new ResourceMonitoringService();
            List<ResourceMonitoring> resourceList = resource.getListOfServices();
            int resourceNum = 0; 
            for (ResourceMonitoring resourcemonitoring : resourceList) {
           	 resourceNum++;
           	 if(user.getUserId() == resourcemonitoring.getUserId()){
                 %>
                 
        
		    <ul>
		        <li>
		            <span style="color: black;"><i  class="glyphicon glyphicon-folder-open"></i>  <%=resourcemonitoring.getHost()%></span> 
		            <ul>
		            
		             <%
   					//present all resource monitors in side bar
          		     ResourceAgentService resourceAgent = new ResourceAgentService();
                     List<ResourceAgent> resourceAgentList = resourceAgent.getListOfServices();
                     int agentNum = 0;
                     for (ResourceAgent resourceagent : resourceAgentList) {
                    	 agentNum++;
                    	 if(resourcemonitoring.getGroup() == resourceagent.getGroupID()){
                 	%>
		                <li>
		                 
		                	<span><i class="icon-leaf"></i><button class="btn btn-info" onclick='start("1432397156", "<%=resourceagent.getHostname()%>")'> <%=resourceagent.getHostname()%></button></span> 
		                    
		                </li>
		               <%}} %>
		            </ul>
		        </li>
		        <li>
		           
		        </li>
		    </ul>
		    <%}} %>
		    
		    
		</div>
		
        </div>
        <!-- /#sidebar-wrapper -->

        <!-- Page Content -->
        <div style="margin-left:2%" id="page-content-wrapper">
                <a href="#menu-toggle" class="btn btn-default" id="menu-toggle"><span class="glyphicon glyphicon-chevron-left"></span></a>
        </div>
                
    
        <!-- /#page-content-wrapper -->

    
  

    <!-- Page Content -->
    <div id="container" class="container">

        <!-- Jumbotron Header -->
	        <header style="width: 120%;!important"class="jumbotron hero-spacer">
	

		
			<div class="row">
	        	<div id="Top-Left" style="width:47.5%;height:300px;border: 1px solid black; border-radius: 2px; float:left;"></div>
	        	<div  style="width:5%;height:300px; float:left;"></div>
		        <div id="Top-Right" style="width:47.5%;height:300px; border: 1px solid black; border-radius: 2px; float:left;"></div>
		      </div>
		      
		      <div class="row" style="margin-top: 5%;">  
		        <div id="Middle-Left" style="width:47.5%;height:300px;border: 1px solid black; border-radius: 2px;float:left;"></div>
	        	<div  style="width:5%;height:300px; float:left;"></div>
		        <div id="Middle-Right" style="width:47.5%;height:300px;border: 1px solid black; border-radius: 2px; float:left;"></div>
		    </div>
		    
		    <div class="row" style="margin-top: 5%;">  
		        <div id="Bottom-Left" style="width:47.5%;height:300px;border: 1px solid black; border-radius: 2px;float:left;"></div>
	        	<div style="width:5%;height:300px; float:left;"></div>
		        <div id="Bottom-Right" style="width:47.5%;height:300px;border: 1px solid black; border-radius: 2px; float:left;"></div>
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
        <!-- /.row -->

        <hr>

        <!-- Footer -->
        <footer>
            <div class="row">
                <div class="col-lg-12">
                    <p>Copyright &copy; Michael Mullarkey 2016</p>
                </div>
            </div>
        </footer>

    <%}%>
	</div>
	</div>
    <!-- /.container -->
	
    <!-- jQuery -->
    <script src="js/bootstrap.min.js"></script>
    <script src="js/jquery-migrate-1.2.1.js"></script>
    <script src="js/jquery-ui-1.10.3-custom.min.js"></script>
    <script src="js/jquery.flot.js" type="text/javascript" charset="UTF-8"></script>
	<script src="js/flotjf.tooltip.js" type="text/javascript" charset="UTF-8"></script>
    <script src="js/monitoring.js"></script>

    <script src="js/sugar.min.js"></script>
    <script src="js/moment.js"></script>
    <!--  <script src="js/Chart.js"></script>
    <script  src="js/visualization-chart-script.js"></script> --> 
      
     
    <script src="js/jquery.canvasjs.min.js"></script>
    <script src="js/canvasjs.min.js"></script>
	<script src="js/highcharts.js"></script>
	<script src="js/highcharts-more.js"></script>
	<script src="js/exporting.js"></script>
	<script src="js/daterangepicker.js"></script>
	<!-- Custom JS -->
	 <script>
    $("#menu-toggle").click(function(e) {
        e.preventDefault();
        $("#wrapper").toggleClass("toggled");
    });
    
   
    </script>


       

  

    <!-- Bootstrap Core JavaScript -->
   

</body>

</html>