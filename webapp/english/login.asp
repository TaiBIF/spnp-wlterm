<html>

<head>
<meta http-equiv="Content-Language" content="zh-tw">
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<meta name="GENERATOR" content="Microsoft FrontPage 6.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>WLTERM</title>
</head>

<body>
<p align="center"><br>
<p align="center"><b><font size="4">Login for Maintenance</font><font color="#cc0000" size="4"><br>
</font>
</b><br>
<br>
<%
name=request("name")%>
<form method="POST" action="modi.asp?name=<%=name%>">
  <div align="center">
    <center>
    <table border="1" cellpadding="0" cellspacing="0">
      <tr>
        <td>
<div align="center">
  <center>
  <table border="0" cellpadding="0" width="484" bgcolor="#FFFFFF" cellspacing="0">
    <tr>
      <td width="369" bgcolor="#E7E3E7" colspan="3">
        <img border="0" src="../images/login_title.jpg" width="519" height="134">
      </td>
    </tr>
    <tr>
      <td width="169" bgcolor="#E7E3E7" rowspan="2">
        <p align="center"><img border="0" src="../images/key_a.gif" width="125" height="40"></p>
      </td>
  </center>
    </center>
      <td width="152" bgcolor="#E7E3E7">
        <p align="right"><font size="2">username：</font>
      </td>
    <center>
  <center>
      <td width="31" bgcolor="#E7E3E7" height="30" align="right" nowrap><input type="text" name="username" value="<%=name%>" size="15"></td>
    </tr>
  </center>
  </center>
    <tr>
      <td width="152" bgcolor="#E7E3E7" height="30" align="right" nowrap>
        <p align="right"><font size="2">password：</font></p>
      </td>
    <center>
  <center>
      <td width="206" bgcolor="#E7E3E7" height="30"><input type="password" name="password" size="15"></td>
    </tr>
    <tr>
      <td width="474" bgcolor="#E7E3E7" colspan="3" height="50">
        <p align="center">　　　　　<input type="submit" value="login" name="B1" style="font-size: 10pt">　　　<input type="reset" value="cancel" name="B2" style="font-size: 10pt"></td>
    </tr>
  </table>
  </center>
</div>
        </td>
      </tr>
    </table>
  </div>
</form>

</body>

</html>