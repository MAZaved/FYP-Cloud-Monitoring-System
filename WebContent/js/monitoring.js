
/**
 * 
 * @author Michael Mullarkey (112457292)
 *
 */

$(".nav a").on("click", function(){
   $(".nav").find(".active").removeClass("active");
   $(this).parent().addClass("active");
});

$('#menu-toggle').click(function () {
	    
	$(this).find('span.glyphicon').toggleClass('glyphicon-chevron-right glyphicon-chevron-left');
});

$('.startBtn').click(function () {
    alert("In here")
    $(".prog").toggleClass('progress-bar-danger progress-bar-warning');
});


$(function () {
    $('.tree li:has(ul)').addClass('parent_li').find(' > span').attr('title', 'Collapse this branch');
    $('.tree li.parent_li > span').on('click', function (e) {
    	$('.tree li:has(ul)').addClass('glyphicon glyphicon-folder-close').removeClass('glyphicon glyphicon-folder-open');
        var children = $(this).parent('li.parent_li').find(' > ul > li');
        if (children.is(":visible")) {
            children.hide('fast');
            $(this).attr('title', 'Expand this branch').find(' > i').addClass('icon-plus-sign').removeClass('icon-minus-sign');
        } else {
            children.show('fast');
            $(this).attr('title', 'Collapse this branch').find(' > i').addClass('icon-minus-sign').removeClass('icon-plus-sign');
        }
        e.stopPropagation();
    });
});

/**
 * GRAPHING Static and Real time
 */

//var for defining each section on the page
var dataTL = [];
var dataTR = [];
var dataML = [];
var dataMR = [];
var dataBL = [];
var dataBR = [];
var array =[];
var i;
var intervalID = 1;
var previousPoint = null;

//functions for calling the servlet to get data for each section
 function getGraphTL(vmid, metricName) {
	console.log("getGraph   " + vmid);

  $.post('GetGraph',{vmName: vmid, metricName: metricName},

    function(response) {
	 
	  dataTL = response
     } )

  return dataTL;
	
 }
 
 function getGraphTR(vmid, metricName) {
 	console.log("getGraph   " + vmid);
 
   $.post('GetGraph',{vmName: vmid, metricName: metricName},
 
     function(response) {
 	 
 	  dataTR = response
      } )

   return dataTR;
 	
  }
 
 function getGraphML(vmid, metricName) {
 	console.log("getGraph   " + vmid);
 
   $.post('GetGraph',{vmName: vmid, metricName: metricName},
 
     function(response) {
 	 
 	  dataML = response
      } )
  
   return dataML;
 	
  }
  
  function getGraphMR(vmid, metricName) {
  	console.log("getGraph   " + vmid);
  
    $.post('GetGraph',{vmName: vmid, metricName: metricName},
  
      function(response) {
  	 
    	dataMR = response
       } )

    return dataMR;
  	
   }
  
  function getGraphBL(vmid, metricName) {
   	console.log("getGraph   " + vmid);
   
     $.post('GetGraph',{vmName: vmid, metricName: metricName},
   
       function(response) {
   	 
   	  dataBL = response
        } )
    
     return dataBL;
   	
    }
    
    function getGraphBR(vmid, metricName) {
    	console.log("getGraph   " + vmid);
    
      $.post('GetGraph',{vmName: vmid, metricName: metricName},
    
        function(response) {
    	 
    	  dataBR = response
         } )

      return dataBR;
    	
     }
 
// setup plot
 var options = [];
 var updateInterval = 5000;

 $.ajaxSetup({async:false});
 $.post('GetGraphOptions',
function(response) {
    options = response
 } )
 
 
 var stopped = false;
 
 //function to update graph after each set interval
 function update() 
 {
		 var number = 0;
		 for(var i = 0; i < array.length; i++) {
		   
				number++
		        console.log("array[" + i + "] = " + "NUMBER: " + number);
				
				//check if it's a real time graph
		        if(array[i][2]=="real")
		        {
		        	//check position of real time graph
					if(array[i][0]=="Top-Left")
					{
						//plot data of graph by passing through the id of the graph(array[i][1]) and the metric name (array[i][3])
				         var plot = $.plot($("#" + array[i][0]),getGraphTL(array[i][1], array[i][3]), options);
			    		 plot.setData(getGraphTL(array[i][1], array[i][3]));
			             plot.setupGrid();
			             plot.draw();
					}
					
					if(array[i][0]=="Top-Right")
					{
				         var plot = $.plot($("#" + array[i][0]),getGraphTR(array[i][1], array[i][3]), options);
				         console.log("in Loop" + array[i][1], array[i][0]);
			    		 plot.setData(getGraphTR(array[i][1], array[i][3]));
			             plot.setupGrid();
			             plot.draw();
					}
					
					if(array[i][0]=="Middle-Left"){
					         var plot = $.plot($("#" + array[i][0]),getGraphML(array[i][1], array[i][3]), options);
					         console.log("in Loop" + array[i][1], array[i][0]);
				    		 plot.setData(getGraphML(array[i][1], array[i][3]));
				             plot.setupGrid();
				             plot.draw();
						}
						
					if(array[i][0]=="Middle-Right"){
					        var plot = $.plot($("#" + array[i][0]),getGraphMR(array[i][1], array[i][3]), options);
					        console.log("in Loop" + array[i][1], array[i][0]);
				    		plot.setData(getGraphMR(array[i][1], array[i][3]));
				            plot.setupGrid();
				            plot.draw();
					}
					if(array[i][0]=="Bottom-Left"){
				         var plot = $.plot($("#" + array[i][0]),getGraphML(array[i][1], array[i][3]), options);
				         console.log("in Loop" + array[i][1], array[i][0]);
			    		 plot.setData(getGraphBL(array[i][1], array[i][3]));
			             plot.setupGrid();
			             plot.draw();
					}
					
				if(array[i][0]=="Bottom-Right"){
				        var plot = $.plot($("#" + array[i][0]),getGraphMR(array[i][1], array[i][3]), options);
				        console.log("in Loop" + array[i][1], array[i][0]);
			    		plot.setData(getGraphBR(array[i][1], array[i][3]));
			            plot.setupGrid();
			            plot.draw();
				}
			 }
		        
		}
		clearTimeout(intervalID);
		//update every "updateInterval"
		intervalID = setTimeout(update, updateInterval); 
     
}

 //function to stop/delete graph
 function stop() 
 {
	 //get choosen location
	 var locations = document.getElementById("location");
	 var loc = locations.options[locations.selectedIndex].value;
	
	 //go through array of already set up graphs
	 for(var i = 0; i < array.length; i++) 
	 {
		 	//check graph position
			if(array[i][0]==loc)
			{
				//then delete it
		         delete array[i];
		         array = array.filter(function(n){ return n != undefined }); 
		         $("#" + loc).empty();
	        	 plot.destroy();
	        	 
			}
	}
 }
 
 //function for starting graph
 function start(id, metricName) 
 {
	 var numLines = 0
	//value for dates
	 var dateTo = document.getElementById("dateTo").value;
     var dateFrom = document.getElementById("dateFrom").value;
	 
     //location for graph
     var locations = document.getElementById("location");
	 var loc = locations.options[locations.selectedIndex].value;
	 
	 //if their is no date, then graph is a real time graph
	 if(dateFrom == "" || dateTo == "")
	 {
		 //go through array of existing graphs
    	 for(var i = 0; i < array.length; i++) 
    	 {
				
    		//if graph already exists with that location
			if(array[i][0]==loc)
    		{
				// then delete that graph
    			  delete array[i];
    			  array = array.filter(function(n){ return n != undefined }); 
    			         
    		}
		}
    	 //and create the newly configured graph
    	 array.push([loc, id, "real", metricName]);
         update(); 
	 }
	 //it there is date, then graph is static
	 else
	 {
		 
		 for(var i = 0; i < array.length; i++) 
    	 {
				if(array[i][0]==loc)
				{
			         delete array[i];
			         array = array.filter(function(n){ return n != undefined }); 
				}
		}
		 
		 array.push([loc, id, "static", metricName]);
		 
		 //turn dates into timestamps
         var finalDateFrom = new Date(dateFrom).getTime() /1000;
         var finalDateTo = new Date(dateTo).getTime() / 1000;
         
         //calling highcharts
         $.post('http://localhost:8080/CloudMointoring/HighChartServlet', {dateTo: finalDateTo, dateFrom: finalDateFrom
        	 //highcharts api
         }, function(data) {
                 $('#'+loc).highcharts({
                     chart : {
                         type : 'line',
                         zoomType : 'x'
                     },
  
                     title : {
                         text : metricName
                     },
  
                     xAxis : {
                         type : 'datetime'
                     },
  
                     yAxis : {
                         title : {
                             text : null
                         }
                     },
  
                     tooltip : {
                         crosshairs : true,
                         shared : true,
                         
                     },
  
                     legend : {
                         enabled : false
                     },
  
                     series : [ {
                         name : metricName,
                         data : data
                     } ]
                 });
             }, 'json');
	}
 }
 //funtion for showing tooltips on real time graph
 function showTooltip(x, y, contents) {
		$('<div id="tooltip">' + contents + '</div>').css({
			position : 'absolute',
			display : 'none',
			top : y + 5,
			left : x + 5,
			border : '1px solid #fdd',
			padding : '2px',
			'background-color' : '#fee',
			opacity : 0.80
		}).appendTo("body").fadeIn(200);
	}

	var previousPoint = null;
	function useTooltip() {
		$("#Top-Left").bind(
				"plothover",
				function(event, pos, item) {
					$("#x").text(pos.x.toFixed(2));
					$("#y").text(pos.y.toFixed(2));
		
					if (item) {
						if (previousPoint != item.dataIndex) {
							previousPoint = item.dataIndex;
		
							$("#tooltip").remove();
							var x = item.datapoint[0].toFixed(2), y = item.datapoint[1]
									.toFixed(2);
		
							showTooltip(item.pageX, item.pageY, item.series.label
									+ " of " + x + " = " + y);
						}
					} else {
						$("#tooltip").remove();
						previousPoint = null;
					}
			});
	}

$('#public-methods').multiSelect();
$('#select-all').click(function(){
  $('#public-methods').multiSelect('select_all');
  return false;
});
$('#deselect-all').click(function(){
  $('#public-methods').multiSelect('deselect_all');
  return false;
});



