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
	<div id="test">${result }</div>
<!-- Core Scripts - Include with every page -->
    <script src="/PromesService/js/jquery-2.1.0.min.js"></script>
    <script src="/PromesService/js/bootstrap.min.js"></script>
    <script src="/PromesService/js/jquery.twbsPagination.js"></script>
    <script type="text/javascript">
    
    $(function (){
    		$('#test > div').each(function(){
    			console.log('1');
    		});
    });
    </script>
</body>

</html>