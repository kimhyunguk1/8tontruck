<%@page contentType="text/html; charset=utf-8" isELIgnored="false"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<fmt:setBundle basename="lang_fr"/>
<%String type = (String) request.getAttribute("type");%>
<%String parentType = (String) request.getAttribute("parentType");%>
<%String year = (String) request.getAttribute("year");%>
<%String month = (String) request.getAttribute("month");%>
<%String date = (String) request.getAttribute("date");%>
<%String firstDay = (String) request.getAttribute("firstDay");%>
<%String lastDate = (String) request.getAttribute("lastDate");%>
<%String isToday = (String) request.getAttribute("isToday");%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>e-PROMMS 2.0 Calendar</title>
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style>
<link href="/PromesService/css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
<!--
function selectDate(value)
{	
	var mainForm = document.form;
	var tmpMon = mainForm._month.value;
	if(tmpMon < 10){
		tmpMon = "0" + tmpMon;
	}
	if(value < 10){
		value = "0" + value;
	}
	var _date = mainForm._year.value + '-' + tmpMon + '-' + value + '';
	<%if(parentType.equals("PARENT")){%>	
		parent.changeDate('<%=type%>', _date);
	<%}else{%>
		opener.changeDate('<%=type%>', _date);
		this.close();
	<%}%>
}

function chagenDate(){
	var mainForm = document.form;
	mainForm.cmd.value = "loadCalendarPage";
	mainForm.type.value = '<%=type%>';
	mainForm._parentType.value = '<%=parentType%>';
	mainForm.target = "calendarPopup";
	mainForm.submit();	
}
//-->
</script>
</head>
<body>
<form name="form" method="post" action="/PromesService/PromesServerServlet">
<input name="cmd" type="hidden" value=""/>
<input name="type" type="hidden" value=""/>
<input name="_parentType" type="hidden" value=""/>
<table width="210" border="1" cellspacing="0" cellpadding="0">
  <tr>
    <td height="190" valign="top" bgcolor="#fff1d3"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td height="25" align="center" valign="bottom"><table width="140" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td><select name="_year" class="select_white" style="width:80px" onchange="javascript:chagenDate();">
              <%
              	try{
				int tmpYear = Integer.parseInt(year);
              	for(int i=tmpYear-3;i<=tmpYear+3;i++){%>
                  <option value='<%=i%>' <%if(i == Integer.parseInt(year)){%> selected="true"<%} %> ><%=i %></option>
              <%}
              	}catch(Exception e){}%>
              </select></td>
              <td align="right"><select name="_month" class="select_white" style="width:50px" onchange="javascript:chagenDate();">
              	<%try{
              	for(int i=1;i <=12;i++){%>
                  <option value='<%=i%>' <%if(i == Integer.parseInt(month)){%> selected="true"<%} %>><%=i %></option>
              	<%}
              	}catch(Exception e){}%>
              </select></td>
            </tr>
        </table></td>
      </tr>
      <tr>
        <td height="8"></td>
      </tr>
      <tr>
        <td align="center"><table width="196" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td height="140" align="center" valign="top" background="/PromesService/images/common/popup_calendar.gif"><table width="175" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td height="27"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                          <td width="25" height="18" align="center" valign="bottom" class="td_table03"><fmt:message key='sunday' /></td>
                          <td width="25" align="center" valign="bottom" class="td_login2"><fmt:message key='monday' /></td>
                          <td width="25" align="center" valign="bottom" class="td_login2"><fmt:message key='tuesday' /></td>
                          <td width="25" align="center" valign="bottom" class="td_login2"><fmt:message key='wednesday' /></td>
                          <td width="25" align="center" valign="bottom" class="td_login2"><fmt:message key='thursday' /></td>
                          <td width="25" align="center" valign="bottom" class="td_login2"><fmt:message key='friday' /></td>
                          <td width="25" align="center" valign="bottom" class="td_table04"><fmt:message key='saturday' /></td>
                        </tr>
                    </table></td>
                  </tr>
                  <tr>
                    <td height="2" bgcolor="#87aac6"></td>
                  </tr>
                  <tr>
                    <td height="5"></td>
                  </tr>
                  <tr>
                    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                      	<%try{
                      	int tmpFirstDay = Integer.parseInt(firstDay);
                      	int tmpLastDate = Integer.parseInt(lastDate);
                      	int tmp = 1;
                      	int tmpDate = Integer.parseInt(date);
                      	String tmpColor = "#FFFFFF";
                      	boolean countStart = false;
                      	for(int i = 0;i < 42;i++){
              				if(i + 1 ==  tmpFirstDay) {
              					countStart = true;
              				}else if(tmp > tmpLastDate){
              					countStart = false;
              				}
              				if(Boolean.valueOf(isToday) && tmp == tmpDate && countStart){
              					tmpColor = "#FFCC99";
              				}else{
                              	tmpColor = "#FFFFFF";
              				}
                      		if(i % 7 == 0){%>
                      			<tr>
                      				<td width="25" height="20" align="center" class="td_table03_" bgcolor='<%=tmpColor%>' >
										<%if(countStart){%>
										<a href="javascript:selectDate('<%=tmp %>');"><font color="#ef6163">
										<%=tmp++%></font></a><%}else{%>&nbsp;<%}%>
									</td>
                      		<%}else if(i % 7 == 6){%>
                      			    <td width="25" align="center" class="td_table04_" bgcolor='<%=tmpColor%>'>
                      			    	<%if(countStart){%>
                      			    	<a href="javascript:selectDate('<%=tmp %>');"><font color="#5a75e7">
                      			    	<%=tmp++%></font></a><%}else{%>&nbsp;<%}%>
                      			    </td>
                      			</tr>
                      		<%}else{%>
                      		        <td width="25" align="center" bgcolor='<%=tmpColor%>'>
                      		        	<%if(countStart){%>
                      		        	<a href="javascript:selectDate('<%=tmp %>');">
                      		        	<%=tmp++%></a><%}else{%>&nbsp;<%}%>
                      		        </td>
                      	<%}}
                      	}catch(Exception e){}%>
                    </table></td>
                  </tr>
                  <tr>
                     <td height="5"></td>
                  </tr>
              </table></td>
            </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
</table>
</form>
</body>
</html>
