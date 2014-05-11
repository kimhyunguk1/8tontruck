
<%@page import="java.util.Calendar"%>
<%@page import="kr.re.etri.lifeinfomatics.promes.data.ScheduleInfo"%>
<%@page contentType="text/html; charset=euc-kr"%>
<%@page import="java.util.ArrayList"%>
<%@page import="kr.re.etri.lifeinfomatics.promes.data.PrescriptionInfo"%>
<%@page import="java.util.Hashtable"%>


<%String userId = (String)request.getAttribute("userId");%>
<%String searchDate = (String)request.getAttribute("searchDate");%>
<%String userType = (String)request.getAttribute("type");%>
<%String pageIdx = (String)request.getAttribute("pageIdx");%>
<%String maxPageIdx = (String)request.getAttribute("maxPageIdx");%>
<%String sortType = (String)request.getAttribute("sortType");%>
<%String sortCourse = (String)request.getAttribute("sortCourse");%>
<%String maxalarm = (String)request.getAttribute("maxalarm");%>
<%String minalarm = (String)request.getAttribute("minalarm");%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">



<%@page import="java.util.Collections"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<STYLE>
.ttip {border:1px solid black;font-size:12px;layer-background-color:lightyellow;background-color:lightgreen}
.state_inactive {
        background-color:##FF9999 !important;
        border:1px solid ##A6C9E2;
        color:##222222;
    }
</STYLE>

<title>e-PROMMS 2.0 Prescription Info List</title>
<link href="/PromesService/css/style.css" rel="stylesheet" type="text/css" />

<link rel="stylesheet" type="text/css" media="screen" href="/PromesService/css/jquery-ui-1.8.16.custom.css" />
<link rel="stylesheet" type="text/css" media="screen" href="/PromesService/js/themes/redmond/jquery-ui.custom.css"/>	
<link rel="stylesheet" type="text/css" media="screen" href="/PromesService/css/ui.jqgrid.css" />


<script src="/PromesService/js/json2.js" type="text/javascript"></script>

<script src="http://code.jquery.com/jquery-latest.min.js" type="text/javascript"></script>
<script src="/PromesService/js/i18n/grid.locale-en.js" type="text/javascript"></script>
<script src="/PromesService/js/jquery.jqGrid.min.js" type="text/javascript"></script>
<script src="/PromesService/js/jquery.tablednd.js" type="text/javascript"></script>
<script src="/PromesService/js/jquery.contextmenu.js" type="text/javascript"></script>
<script type="text/javascript">
<!--

$(document).ready(function(){
	
	$.ajax({
		 type:'GET',
		 url:'/PromesService/PromesServerServlet?cmd=loadTotalListJQGrid',
		 datatype: "json",
		 error:function(){
			 alert('error');
		 },
		 success:function(obj){	
			
			var str = eval("("+obj+")");			
			var colnames = str.colnames;
			var colmodels = str.colmodels;				
			
			$("#gridList").jqGrid({   
		    	url:'/PromesService/PromesServerServlet?cmd=loadTotalListJQGrid',     
		        datatype: "json",  
		        jsonReader : {  
							page: "page", 
							total: "total", 
							root: "takenRows", 
							records: function(obj){return obj.length;},
							repeatitems: false					
						}, 		       
		        colNames:colnames,
		        colModel:colmodels,		      

			 	rowNum:20, // 한 화면에 보여줄 갯수
			   	rowList:[20,25,30],  
			   	pager: '#pager2', 			   	
			    sortorder:"desc",   
			    gridview:true,
			    viewrecords: true,
			    rownumbers:true,
				loadonce: true,
				shrinkToFit: false,
				height: "auto",
				ondblClickRow:function(ids){
					
				},
				loadComplete:function(data) {				
					
			    },
			    gridComplete:function() {
					
					var rowcnt = str.takenRows.length;
					var colcnt = str.colnames.length;
					for(var i=1; i<=rowcnt; i++){
						for(var j=1; j<=colcnt; j++){
							var cellValue=$("#gridList").getCell(i,j);
							if(cellValue == 'FINISHTAKEN' || cellValue == 'PRETAKEN' || cellValue == 'PREOUTTAKEN'){
								$("#gridList").setCell(i,j,'',{backgroundColor:'#0078FF'});
								$("#gridList").setCell(i,j,'',{color:'#0078FF'});
							}else if(cellValue == 'FINISHUNTAKEN' || cellValue == 'PREUNTAKEN'){
								$("#gridList").setCell(i,j,'',{backgroundColor:'#FF3232'});
								$("#gridList").setCell(i,j,'',{color:'#FF3232'});
							}
						}
					}
					
			    },
		
			    caption:"전체복약현황"
			}); 
		    
		    $("#gridList").setGridWidth(750,false);
		    $("#gridList").jqGrid('setFrozenColumns');
		   
		 }
	});
}); 

function initsize() {	

}

//-->
</script>
</head>
<body onload="javascript:initsize();">
<form name="form" method="post" action="/PromesService/PromesServerServlet">
<input name="cmd" type="hidden" value=""/>
<input name="_prescriptionId" type="hidden" value=""/>
<input name="_hospital" type="hidden" value=""/>
<input name="_userId" type="hidden" value=""/>
<input name="_type" type="hidden" value=""/>
<input name="_date" type="hidden" value=""/>
<table id="Totalview" height=600>
<tr>
<td valign="top">
   <table id="gridList"></table>
   <div id="pager2"></div>    
</td>
</tr>
</table>
</form>
</body>
</html>