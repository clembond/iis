<%@Language="VBScript"%>
<HTML>
<!--#include file = "text.asp"-->

<title><%=L_Title_Text%></title>

<FONT COLOR=FFFFFF>
<STYLE>
</STYLE>
</FONT>

<head>
		<META HTTP-EQUIV="Content-Type" Content="text/html; charset=Windows-1252">
</head>

<style>
	body {
		font-style: "Verdana" !important;
	}
	input[type=text], input[type=password] {
	  width: 100%;
	  padding: 6px 20px;
	  margin: 8px 0;
	  display: inline-block;
	  border: 1px solid #ccc;
	  border-radius: 4px;
	  box-sizing: border-box;
	}

	input[type=submit], input[type=reset] {
	  width: 15%;
	  background-color: #4CAF50;
	  color: white;
	  padding: 14px 20px;
	  margin: 8px 0;
	  border: none;
	  border-radius: 4px;
	  cursor: pointer;
	}
	
	form {
		width: 100%;
	}
	
	td {
		font-style: "Verdana" !important;
	}
	
	
</style>

<BODY BGCOLOR=#FFFFFF LINK=000000 VLINK=000000>

<%On Error goto 0%>
<%if Request.Form("cancel") <> "" then
	Response.Redirect(Request.QueryString) 
	Response.End
end if

	dim domain, username, posbs, posat

	username = Request.Form("acct")
	if username <> "" then
		username = Server.HTMLEncode(username)
	else
		username = Server.HTMLEncode(Request.ServerVariables("REMOTE_USER"))
	end if

	domain = Request.Form("domain")
	if domain <> "" then
		domain = Server.HTMLEncode(domain)
	else
		posbs = Instr(1, username, "\")
		posat = Instr(1, username, "@")
		if posbs > 0 then
			domain = Left(username, posbs - 1)
			username = Right(username, len(username) - posbs)
		elseif posat > 0 then
			domain = Right(username, len(username) - posat)
			username = Left(username, posat - 1)
		else	
			set nw = Server.CreateObject("WScript.Network")
			domain = nw.UserDomain
		end if 
	end if

%>

<!-- Windows NT Server with IIS  -->
<%if Instr(1,Request.ServerVariables("SERVER_SOFTWARE"), "IIS") > 0 then%>
	<TABLE BORDER=0 CELLPADDING=0 CELLSPACING=0>
	<TR VALIGN=CENTER>
		<TD></TD>
		<TD WIDTH=20> </TD>
		<TD><FONT SIZE=+3 COLOR=#000000><B>Password Reset Manager<BR> <FONT SIZE=-1>Warning: Please don't let your password expire before you change it.<FONT></B></FONT></TD>
	</TR>
	</Table>
<%end if%>   

<!-- Windows NT Workstation with PWS  -->
<%if Instr(1,Request.ServerVariables("SERVER_SOFTWARE"), "PWS") then%>

<TABLE BORDER=0 CELLPADDING=0 CELLSPACING=0>
<TR VALIGN=CENTER>
	<TD></TD>
	<TD WIDTH=20> </TD>
	<TD><FONT SIZE=+3 COLOR=#000000><B><%=L_ISM_Text%><BR> <FONT SIZE=-1><FONT></B></FONT></TD>
</TR>
</Table>
<%end if%>

<p>

<form 
style="padding: 10px 50px; font-style: Verdana"
method="POST" action="http://<%=Server.HTMLEncode(Request.ServerVariables("SERVER_NAME"))%>/achg.asp?<%=Server.HTMLEncode(Request.QueryString)%>">
<div>
	<img src="https://vmn-email-banners.s3.us-west-2.amazonaws.com/vmn+logosmallw2.jpg" alt="vmn logo" />
</div>
<table>
<tr>
<td><b><%=L_Domain_Text%></b></td><td><input type="text"  name="domain" value="
<%
	Response.Write domain
%>
"></td></tr>
<tr>
<td><b>Username</b></td><td><input  type="text" name="acct" value="
<%
	Response.Write username
%>
"></td>
</tr>
<tr>
<td><b><%=L_OldPassword_Text%></b></td><td><input type="password" name="old" value="" ></td>
</tr>
<tr>
<td><b><%=L_NewPassword_Text%></b></td><td><input type="password" name="new" value="" ></td>
</tr>
<tr>
<td><b><%=L_Confirm_Text%></b></td><td><input type="password" name="new2" value="" ></td>
</tr>
</table>

<p>

<input type="submit" value="<%=L_OK_Text%>"><br />
<input type="submit" name="cancel" value="<%=L_Cancel_Text%>"><br />
<input type="reset" value="<%=L_Reset_Text%>"><br />

</form>
</body>
</html>
