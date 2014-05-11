<%@page contentType="text/html; charset=euc-kr"%>
<%String msg = (String)request.getAttribute("msg"); %>
<%String close = (String)request.getAttribute("close"); %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript">
<!--
function init(){
	<%
		if(msg != null && !msg.equals("")){
			%>
				alert('<%=msg%>');	
			<%				
			if(close != null && Boolean.valueOf(close)){%>
					parent.popupClose();
							
			<%}
		}
	%>
}
//-->
</script>
</head>
<body onload="init();">
</body>
</html>
