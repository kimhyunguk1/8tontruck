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
	<input type="hidden" name = "cmd" id="cmd" value="demo_join"/>
	<div id="page-wrapper">
	
	<div class="input-group col-md-8" style="margin: 5px;">
  		<span class="input-group-addon"><i class="fa fa-plus-square"></i></span>
  		<input type="text" class="form-control" placeholder="Name" name="_name">
	</div>
	<div class="input-group col-md-8"style="margin: 5px">
  		<span class="input-group-addon"><i class="fa fa-plus-square"></i></span>
  		<input type="text" class="form-control" placeholder="Birth" name="_birth">
	</div>
	<div class="input-group col-md-8"style="margin: 5px">
		<div class="btn-group" data-toggle="buttons">
			<label class="btn btn-default">
		    	<input type="radio" name="gender" id="gender" value="_man"> Man
			</label>
			<label class="btn btn-default">
				<input type="radio" name="gender" id="gender" value="_woman"> Woman
			</label>
		</div>
		<span style="margin-left: 5px;">Gender </span>
		
	</div>
	<div class="input-group col-md-8"style="margin: 5px">
  		<span class="input-group-addon"><i class="fa fa-plus-square"></i></span>
  		<input type="text" class="form-control" placeholder="Address" name="_addr">
	</div>
	<div class="input-group col-md-8"style="margin: 5px">
  		<span class="input-group-addon"><i class="fa fa-plus-square"></i></span>
  		<input type="text" class="form-control" placeholder="Tel" name="_tel">
	</div>
	<div class="input-group col-md-8"style="margin: 5px">
  		<span class="input-group-addon"><i class="fa fa-plus-square"></i></span>
  		<input type="text" class="form-control" placeholder="Weight">
	</div>
	<div class="input-group col-md-8"style="margin: 5px">
		
		<div class="btn-group" data-toggle="buttons">
			<label class="btn btn-default">
		    	<input type="radio" name="smoke" id="smoke" value="y"> Yes
			</label>
			<label class="btn btn-default">
				<input type="radio" name="smoke" id="smoke" value="n"> No
			</label>
		</div>
		<span style="margin-left: 5px;">Smoke </span>
	</div>
	<div class="input-group col-md-8"style="margin: 5px">
  		<span class="input-group-addon"><i class="fa fa-plus-square"></i></span>
  		<input type="text" class="form-control" placeholder="Roommate">
	</div>
	<div class="input-group col-md-8"style="margin: 5px">
		
		<div class="btn-group" data-toggle="buttons">
			<label class="btn btn-default">
		    	<input type="radio" name="oldnew" id="oldnew"> New
			</label>
			<label class="btn btn-default">
				<input type="radio" name="oldnew" id="oldnew"> Old1
			</label>
			<label class="btn btn-default">
				<input type="radio" name="oldnew" id="oldnew"> Old2
			</label>
			<label class="btn btn-default">
				<input type="radio" name="oldnew" id="oldnew"> Old3
			</label>
		</div>
		<span style="margin-left: 5px;">Old & New </span>
	</div>
	<div class="input-group col-md-8"style="margin: 5px">
  		<span class="input-group-addon"><i class="fa fa-plus-square"></i></span>
  		<input type="text" class="form-control" placeholder="CS">
  		<span class="input-group-btn">
			<button class="btn btn-default" type="button">
			    <i class="fa fa-search"></i>
			</button>
	    </span>
	</div>
	<div class="input-group col-md-8"style="margin: 5px">
  		<span class="input-group-addon"><i class="fa fa-plus-square"></i></span>
  		<input type="text" class="form-control" placeholder="CDST">
	</div>
	<div class="input-group col-md-8"style="margin: 5px">
  		<span class="input-group-addon"><i class="fa fa-plus-square"></i></span>
  		<input type="text" class="form-control" placeholder="RNN">
	</div>
	<div class="input-group col-md-8"style="margin: 5px">
		
		<div class="btn-group" data-toggle="buttons">
			<label class="btn btn-default">
		    	<input type="radio" name="oldnew" id="oldnew"> Yes
			</label>
			<label class="btn btn-default">
				<input type="radio" name="oldnew" id="oldnew"> No
			</label>
		</div>
		<span style="margin-left: 5px;">JOB </span>
	</div>
	<div class="input-group col-md-8"style="margin: 5px">
		
		<div class="btn-group" data-toggle="buttons">
			<label class="btn btn-default">
		    	<input type="radio" name="oldnew" id="oldnew"> Yes
			</label>
			<label class="btn btn-default">
				<input type="radio" name="oldnew" id="oldnew"> No
			</label>
		</div>
		<span style="margin-left: 5px;">Illitaracy </span>
	</div>
	<div class="input-group col-md-8"style="margin: 5px">
		
		<div class="btn-group" data-toggle="buttons">
			<label class="btn btn-default">
		    	<input type="radio" name="oldnew" id="oldnew"> 20 Minute
			</label>
			<label class="btn btn-default">
				<input type="radio" name="oldnew" id="oldnew"> More Time
			</label>
		</div>
		<span style="margin-left: 5px;">Distance </span>
	</div>
	<div class="input-group col-md-8"style="margin: 5px">
		
		<div class="btn-group" data-toggle="buttons">
			<label class="btn btn-default">
		    	<input type="radio" name="oldnew" id="oldnew"> Yes
			</label>
			<label class="btn btn-default">
				<input type="radio" name="oldnew" id="oldnew"> No
			</label>
		</div>
		<span style="margin-left: 5px;">Drink </span>
	</div>
	<div class="input-group col-md-8"style="margin: 5px">
		
		<div class="btn-group" data-toggle="buttons">
			<label class="btn btn-default">
		    	<input type="radio" name="oldnew" id="oldnew"> Yes
			</label>
			<label class="btn btn-default">
				<input type="radio" name="oldnew" id="oldnew"> No
			</label>
		</div>
		<span style="margin-left: 5px;">Family History </span>
	</div>
	
	<div class="input-group col-md-8"style="margin: 5px">
		
		<div class="btn-group" data-toggle="buttons">
			<label class="btn btn-default">
		    	<input type="radio" name="oldnew" id="oldnew"> Yes
			</label>
			<label class="btn btn-default">
				<input type="radio" name="oldnew" id="oldnew"> No
			</label>
		</div>
		<span style="margin-left: 5px;">X-ray </span>
	</div>
	<div class="input-group col-md-8"style="margin: 5px">
  		<span class="input-group-addon"><i class="fa fa-plus-square"></i></span>
  		<input type="text" class="form-control" placeholder="SPTM1">
	</div>
	<div class="input-group col-md-8"style="margin: 5px">
  		<span class="input-group-addon"><i class="fa fa-plus-square"></i></span>
  		<input type="text" class="form-control" placeholder="SPTM2">
	</div>
	<div class="input-group col-md-8"style="margin: 5px">
  		<span class="input-group-addon"><i class="fa fa-plus-square"></i></span>
  		<input type="text" class="form-control" placeholder="SPTM3">
	</div>
	
	<div class="input-group col-md-8"style="margin: 5px">
		
		<div class="btn-group" data-toggle="buttons">
			<label class="btn btn-default">
		    	<input type="radio" name="oldnew" id="oldnew"> Yes
			</label>
			<label class="btn btn-default">
				<input type="radio" name="oldnew" id="oldnew"> No
			</label>
		</div>
		<span style="margin-left: 5px;">BCG </span>
	</div>
	<button class="btn btn-default">Submit</button>
</div>

</form>
<!-- Core Scripts - Include with every page -->
    <script src="/PromesService/js/jquery-2.1.0.min.js"></script>
    <script src="/PromesService/js/bootstrap.min.js"></script>
    <script type="text/javascript">
    
    $(function (){
//     	$('form').submit(function (){
//     	});
    	
    });
    </script>
</body>

</html>