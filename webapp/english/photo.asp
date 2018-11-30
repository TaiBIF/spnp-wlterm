<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<meta name="GENERATOR" content="Microsoft FrontPage 6.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>新網頁1</title>
</head>

<body>
<div align="center">
  <center>
<table border="0" width="95%">
  <tr>
    <td width="100%">
<%
Set fs = Server.CreateObject("Scripting.FileSystemObject")
set fd=fs.GetFolder("D:\WLTERM\smallphotos")
for each f in fd.files
%>
<a href="photoLarge.asp?file=..\photos\<%=f.name%>"><img border="0"  src="..\smallphotos\<%=f.name%>"></a>
<%
next 
%>
</td>
  </tr>
</table>
  </center>
</div>
</body>

</html>