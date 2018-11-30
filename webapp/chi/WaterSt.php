<html>

<head>
<meta name="GENERATOR" content="Microsoft FrontPage 6.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>水質調查紀錄</title>
</head>
<body topmargin="0">
<%PI=request("PI")
if PI="3" then
   PIN="水質"
elseif PI="4" then
   PIN="硝酸鹽"
elseif PI="1" then
   PIN="藻類與<br>有機碎屑"
elseif PI="13" then
   PIN="主要元<br>素通量"
end if      
%>
<table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" >
  <tr>
    <td valign="top">
    <br><font size="4" face="標楷體">查詢<%=PIN%><br>
    調查紀錄</br>
    <form method="POST" action="WaterQ.asp">
    &nbsp;<select size="1" name="D1">
    <option value="ALL">全部測站</option>
    <option value="1">測站# 1</option>
<option value="2">測站# 2</option>
<option value="3">測站# 3</option>
<option value="4">測站# 4</option>
<option value="5">測站# 5</option>
<option value="6">測站# 6</option>
<option value="7">測站# 7</option>
<option value="8">測站# 8</option>
<option value="9">測站# 9</option>
<option value="10">測站#10</option>
<option value="11">測站#11</option>

    </select></font><br></br>
<input type="hidden" name="PI" value="<%=PI%>">    
    &nbsp;&nbsp;&nbsp;&nbsp;<input type="submit" value="查詢" name="B1">
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
    <img border="0" src="images/stationM.gif" usemap="#FPMap0"></td>
  </tr>


</body>

</html>