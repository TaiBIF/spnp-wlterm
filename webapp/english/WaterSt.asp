<html>

<head>
<meta name="GENERATOR" content="Microsoft FrontPage 6.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=big5">
</head>
<body topmargin="0">
<%PI=request("PI")
if PI="3" then
   PIN="Water Quality"
elseif PI="4" then
   PIN="Nitrate"
elseif PI="1" then
   PIN="Alage and<br>Organic Detritus"
end if      
%>
<table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" >
  <tr>
    <td valign="top">
    <br><font size="4" face="Arial">Query <%=PIN%><br>
    Investigated Records</br>
    <form method="POST" action="WaterQ.asp">
    &nbsp;<select size="1" name="D1">
    <option value="ALL">All Station</option>
    <option value="1">Station# 1</option>
<option value="2">Station# 2</option>
<option value="3">Station# 3</option>
<option value="4">Station# 4</option>
<option value="5">Station# 5</option>
<option value="6">Station# 6</option>
<option value="7">Station# 7</option>
<option value="8">Station# 8</option>
<option value="9">Station# 9</option>
<option value="10">Station#10</option>
<option value="11">Station#11</option>

    </select></font><br></br>
<input type="hidden" name="PI" value="<%=PI%>">    
    &nbsp;&nbsp;&nbsp;&nbsp;<input type="submit" value="Query" name="B1">
</form>
　</td>
    <td>
    <map name="FPMap0">
    <area coords="267, 39, 357, 66" shape="rect" href="WaterQ.asp?D1=1&PI=<%=PI%>">
    <area href="WaterQ.asp?D1=2&PI=<%=PI%>" shape="rect" coords="183, 62, 265, 92">
    <area href="WaterQ.asp?D1=3&PI=<%=PI%>" shape="rect" coords="208, 155, 291, 181">
    <area href="WaterQ.asp?D1=4&PI=<%=PI%>" shape="rect" coords="280, 230, 363, 249">
    <area href="WaterQ.asp?D1=8&PI=<%=PI%>" shape="rect" coords="179, 253, 256, 273">
    <area href="WaterQ.asp?D1=5&PI=<%=PI%>" shape="rect" coords="226, 284, 306, 304">
    <area href="WaterQ.asp?D1=6&PI=<%=PI%>" shape="rect" coords="218, 321, 295, 340">
    <area href="WaterQ.asp?D1=7&PI=<%=PI%>" shape="rect" coords="196, 350, 272, 367">
    <area href="WaterQ.asp?D1=9&PI=<%=PI%>" shape="rect" coords="289, 354, 366, 385">
    <area href="WaterQ.asp?D1=10&PI=<%=PI%>" shape="rect" coords="55, 407, 132, 437">
    <area href="WaterQ.asp?D1=11&PI=<%=PI%>" shape="rect" coords="145, 435, 216, 464">
    </map>
    <img border="0" src="../images/stationM.gif" usemap="#FPMap0"></td>
  </tr>


</body>

</html>