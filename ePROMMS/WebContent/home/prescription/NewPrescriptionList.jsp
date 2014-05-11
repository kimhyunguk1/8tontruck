<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>ePROMMS 3.0</title>

    <!-- Core CSS - Include with every page -->
    <link href="/PromesService/css/bootstrap.min.css" rel="stylesheet">
    <link href="/PromesService/font-awesome/css/font-awesome.css" rel="stylesheet">
    <link href="/PromesService/css/sb-admin.css" rel="stylesheet">
</head>

<body>
	<form name="form" method="post" action="/PromesService/PromesServerServlet">
		<input type="hidden" name="sortName" id="sortName" value="${sortName }">
		<input type="hidden" name="sortType" id="sortType" value="${sortType }">
		<input type="hidden" name="page" id="page" value="">
		<input type="hidden" name="cmd" id="cmd" value="">
	</form>
	
	<div id="wrapper">
		<nav class="navbar navbar-default navbar-fixed-top" role="navigation">
			<div class="navbar-header">
    			<a class="navbar-brand" href="#">ePROMMS</a>
  			</div>
		    <ul class="nav navbar-nav navbar-right">
<!-- 		    <form class="navbar-form navbar-left" role="search"> -->
<!-- 		      <div class="form-group"> -->
<!-- 		        <input type="text" class="form-control" placeholder="Search"> -->
<!-- 		      </div> -->
<!-- 		      <button type="submit" class="btn btn-default">Submit</button> -->
<!-- 		    </form> -->
		      <li class="dropdown">
		        <a href="#" class="dropdown-toggle" data-toggle="dropdown">ADMIN <b class="caret"></b></a>
		        <ul class="dropdown-menu">
		          <li><a href="#"><i class="fa fa-gear fa-fw"  ></i> User Profile</a></li>
                  <li class="divider"></li>
                  <li><a href="login.html"><i class="fa fa-sign-out fa-fw"></i> Logout</a></li>
		        </ul>
		      </li>
		    </ul>
		     <div class="navbar-default navbar-static-side" role="navigation">
                <div class="sidebar-collapse">
                    <ul class="nav" id="side-menu">
                        <li>
                            <a id = "LIST" href="#"><i class="fa fa-list fa-fw fa-lg"></i> LIST</a>
                        </li>
                        <li>
                            <a id = "MEMBER" href="#"><i class="fa fa-user fa-fw fa-lg"></i> MEMBER</a>
                        </li>
                        <li>
                            <a id="TODAY_TAKEN" href="#"><i class="fa fa-plus-square fa-fw fa-lg"></i> TODAY TAKEN</a>
                        </li>
                    </ul>
                 </div>
              </div>
                        
		</nav>
		<div id="page-wrapper">
			<div class="row">
				 
                <div class="col-lg-12">
                    <h1 class="page-header">LIST</h1>
                    
                </div>
				
			</div>
			
			<div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            TakenSchedule List Tables
                        </div>
                        <div class="row" style="padding-top: 15px; padding-right: 15px;">
	                        <div class="col-sm-8"></div>
                        	<div class="col-sm-4">
                        		<div class="input-group">
	                                <input type="text" class="form-control" placeholder="Search...">
	                                <span class="input-group-btn">
		                                <button class="btn btn-default" type="button">
		                                    <i class="fa fa-search"></i>
		                                </button>
	                            	</span>
                            	</div>
                        	</div>
                        </div>
                        <div class="panel-body">
                            <div class="table-responsive">
                            	<table class="table table-striped table-bordered table-hover" id="listTable">
                            		<thead>
                            			<tr>
                            				<th class="sorting">org</th>
                            				<th class="sorting">id</th>
                            				<th class="sorting">name</th>
                            				<th class="sorting">age</th>
                            				<th class="sorting">gender</th>
                            				<th class="sorting">start</th>
                            				<th class="sorting">end</th>
                            				<th class="sorting">status</th>
                            				<th class="sorting">Progress</th>
                            			</tr>
                            		</thead>
                            		<tbody>
                            			<c:forEach var="prescriptionInfo" items="${prescriptionList}">
                            				<tr>
                            					<td class="hospital">${ prescriptionInfo.hospital}</td>
                            					<td>${ prescriptionInfo.member_id}</td>
                            					<td>${ prescriptionInfo.name}</td>
                            					<td>${ prescriptionInfo.age}</td>
                            					<td>${ prescriptionInfo.gender}</td>
                            					<td>${ prescriptionInfo.startDate}</td>
                            					<td>${ prescriptionInfo.endDate}</td>
                            					<td>${ prescriptionInfo.status}</td>
                            					<td>
	                            					<div class="progress" data-container="body" data-toggle="popover" data-placement="left" 
	                            						data-content="FINISHTAKEN : ${prescriptionInfo.finishTakenCnt} <br /> DELAYTAKEN : ${prescriptionInfo.delayTakenCnt}<br /> UNTAKEN : ${prescriptionInfo.unTakenCnt}">
													  <div class="progress-bar" style="width: ${prescriptionInfo.finishTakenPer}%" >
													  </div>
													  <div class="progress-bar progress-bar-success" style="width: ${prescriptionInfo.delayTakenPer}%">
													  </div>
													  <div class="progress-bar progress-bar-danger" style="width: ${prescriptionInfo.unTakenPer}%">
													  </div>
													</div>
												</td>
                            			</c:forEach>
                            		</tbody>
                            	</table>
                            	<div class=" text-center ">
                            		<ul id="paginator"class="pagination"></ul>
                            	</div>
                            </div>
                         </div>
                    </div>
                </div>
             </div>       	
		</div>
		
	</div>
<!-- Core Scripts - Include with every page -->
    <script src="/PromesService/js/jquery-2.1.0.min.js"></script>
    <script src="/PromesService/js/bootstrap.min.js"></script>
    <script src="/PromesService/js/jquery.twbsPagination.js"></script>
    <script type="text/javascript">
    
    $(function (){
    	$('#paginator').twbsPagination({
            totalPages: '${pageTotalCnt}',
            visiblePages: 10,
            startPage: '${page}',
            onPageClick: function (event, page) {
                if('${page}' != page){
                	$('#page-wrapper').css("background","yellow");
                	$('#page').val(page);
                    $('#cmd').val('LoadPrescriptionList');
            		$('form').submit();
                }
            }
        });
    	$('thead tr th').each(function(){
    		var element = $(this);
    		if($(element).text() =='${sortName}'){
    			$(element).removeClass('sorting sorting_asc sorting_desc').addClass('sorting_'+'${sortType}');
    		}else{
    			$(element).removeClass('sorting sorting_asc sorting_desc').addClass('sorting');
    		}
    	});
    	$('#LIST').click( function() { 
        	
    	} );
        $('#MEMBER').click( function() { 
        	alert('MEMBER');
    	} );
        $('#TODAY_TAKEN').click( function() { 
        	alert('TODAY TAKEN');
    	} );
    	$('.progress').hover(
    			function(){
    				$(this).popover({
    		            html: true
    		        }).popover('show');
    			},
    			function(){
    				$(this).popover('hide');
    			}
    	);
    	$('thead tr th').click(function(){
    		
    		var element = $(this);
    		var sortName = $(element).text();
    		var sortType = "";
    		var tmp = $(element).attr('class').split(' ');
    		var className = $(tmp)[0];
    		switch(className){
	    		case "sorting":
	    			sortType = "asc";
	    			break;
	    		case "sorting_asc":
	    			sortType = "desc";
	    			break;
	    		case "sorting_desc":
	    			sortType = "asc";
	    			break;
    		}

    		$('#sortName').val(sortName);
    		$('#sortType').val(sortType);
    		$('#cmd').val('LoadPrescriptionList');
    		$('form').submit();
    	});
    	$('tbody > tr').click(function() {
    	    var tableData = $(this).children("td").map(function() {
    	        return $(this).text();
    	    }).get();
    	    alert(tableData);
    	    alert("Your data is: " + $.trim(tableData[0]) + " , " + $.trim(tableData[1]) + " , " + $.trim(tableData[2]));
    	});
    });
    </script>
</body>

</html>