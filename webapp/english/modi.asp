<!--#include file="conn.asp"-->

<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>�s����4</title>
</head>
<%
name=request("username")
password=request("password")
modi=request("modi")
if ucase(name) <> "GLORIA" and  ucase(password)<>"GLORIA"  then
    response.write "�K�X���~�I"
    response.end 
end if
id=request("id")
if id="" or id="0" then id="1"
if id="12" then id="11"
sql="select * from station where id=" & id
rs.open sql,conn,1,1
%>
<body background="images/bg01.gif">
  <div align="center">
<form name="f1" action="modi2.asp">

  <p><b><font  size="3">�ק�������</font></b><p><b><font size="2">
<a href="modi.asp?id=<%=id-1%>&name=<%=name%>&password=<%=password%>">&lt;�W�@��&gt;</a>&#63736;
  <a href="modi.asp?id=<%=id+1%>&name=<%=name%>&password=<%=password%>">&lt;�U�@��&gt;</a></font>&#63736; </b></font>
<% if modi="Y" then %>
<font size="2"> �ק粒���A���~��I</font>
<%end if%>

    <table border="1" cellpadding="4" bgcolor="#F7F3FF">
      <tr>
        <td>�����s��</td>
        <td><input type="text" name="id" size="20" value="<%=rs("id")%>"></td>
        <td>�̧C���ް���</td>
        <td><input type="text" value="<%=rs("Minimum_Elevation")%>" name="Minimum_Elevation" size="20"></td> 
      </tr>
      <tr>
        <td>�n��</td>
        <td><input type="text" name="latitude" size="20" value="<%=rs("latitude")%>"></td>
        <td>�̰����ް���</td>
        <td><input type="text" value="<%=rs("Maximum_Elevation")%>" name="Maximum_Elevation" size="20"></td> 
      </tr>
      <tr>
        <td>�g��</td>
        <td><input type="text" name="longitude" size="20" value="<%=rs("longitude")%>"></td>
        <td>�̲L�`��</td>
        <td><input type="text" value="<%=rs("Minimum_Depth")%>" name="Minimum_Depth" size="20"></td> 
      </tr>
      <tr>
        <td>�y�л~�t</td>
        <td><input type="text" name="Coordinate_Precision" size="20" value="<%=rs("Coordinate_Precision")%>"></td>
        <td>�̲`�`��</td>
        <td><input type="text" value="<%=rs("Maximum_Depth")%>" name="Maximum_Depth" size="20"></td> 
      </tr>
      <tr>
        <td>�^��a�W</td>
        <td><input type="text" name="Locality" size="20" value="<%=rs("Locality")%>"></td>
        <td>���ѥ��Ű�</td>
        <td><input type="text" value="<%=rs("���ѥ��Ű�")%>" name="���ѥ��Ű�" size="20"></td> 
      </tr>
      <tr>
        <td>����a�W</td>
        <td><input type="text" name="Locality_chinese" size="20" value="<%=rs("Locality_chinese")%>"></td>
        <td>���g���Ű�</td>
        <td><input type="text" value="<%=rs("���g���Ű�")%>" name="���g���Ű�" size="20"></td> 
      </tr>
      <tr>
        <td>�����y�z</td>
        <td colspan="3"><input type="text" name="Locality_describe" size="55" value="<%=rs("Locality_describe")%>" ></td>
      </tr>
      </table>
    <p><input type="submit" value="�ס@��" name="B1">&nbsp;&nbsp;&nbsp;&nbsp;<input type="submit" value="���ק�" name="B1"></p>
  <input type="hidden" name="name" value="<%=name%>">
  <input type="hidden" name="password" value="<%=password%>">
  </form>
</div>

  

</body>

</html>