<%@page contentType="text/html; charset=utf-8" isELIgnored="false"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<fmt:setBundle basename="lang_fr"/>
<%String beforePage = (String)request.getAttribute("beforePage"); %>
<%String result = (String)request.getAttribute("result"); %>
<%String takenboxIdchk = (String)request.getAttribute("takenboxIdchk"); %>
<%String msg = (String)request.getAttribute("msg"); %>
<%String close = (String)request.getAttribute("close"); %>
<%String type = (String)request.getAttribute("type"); %>
<%String delBool = (String)request.getAttribute("delBool"); %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript">
<!--
function init(){
	<%if(beforePage != null && !beforePage.equals(""))
	{
		if(beforePage.equals("AddPillBox"))
		{
			if(Boolean.valueOf(result) && !Boolean.valueOf(takenboxIdchk)){%>
				parent.addPillBox();
			<%}else if(Boolean.valueOf(takenboxIdchk)){%>
				alert("<fmt:message key='the_registered_box__can_not_be_changed.'/>");			
			<%}else{%>
				alert("<fmt:message key='the_registered_box__can_not_be_deleted.'/>");
			<%}
		}else if(beforePage.equals("Join")){%>
			alert('<%=msg%>');
			<%if(Boolean.valueOf(result)){%>
				parent.reloadPage();
			<%}
		}else if(beforePage.equals("AddUser")){%>
			alert('<%=msg%>');
			<%if(Boolean.valueOf(result)){%>
				parent.changePage('<%=type%>');
			<%}%>
		<%}else if(beforePage.equals("ModifyUser")){%>
			alert('<%=msg%>');
		<%}else if(beforePage.equals("ModifyUserAndPrescription")){%>
			alert('<%=msg%>');
			parent.close();
		<%}else if(beforePage.equals("DeleteUser")){%>
			alert('<%=msg%>');
			parent.searchUser();
		<%}else if(beforePage.equals("checkPrescriptionId")){
			if(!Boolean.valueOf(result)){%>
				alert('<%=msg%>');
				parent.resetId();
			<%}
		}else if(beforePage.equals("DelPillBox")){
			if(Boolean.valueOf(result)){%>
				alert("<fmt:message key='the_registered_box__can_not_be_deleted.'/>");
			<%}else{%>
				parent.delPillBox('<%=delBool%>');
			<%}
		}else if(beforePage.equals("DeletePrescription")){%>
			alert('<%=msg%>');
			parent.searchPrescription();
		<%}else if(beforePage.equals("FinishPrescription")){%>
			alert('<%=msg%>');
			parent.searchPrescription();
		<%}else if(beforePage.equals("Takenconfirm")){%>			
			alert('<%=msg%>');
			parent.refresh(); 			
		<%}else if(beforePage.equals("imgsrc")){%>			
		alert('<%=msg%>');		
		
	<%}
	}
	%>
}


//-->
</script>
</head>
<body onload="init()">
</body>
</html>
