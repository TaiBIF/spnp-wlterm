﻿<!DOCTYPE html PUBLIC "-//IETF//DTD HTML 2.0//EN"> 
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>WLTERM</title>
<script language="JavaScript" src="menu.js"></script>
</head>
<body topmargin="0"  bgcolor="#EFEFEF">
<center>
<table border="0" cellpadding="0" cellspacing="0" width="998" height="100%"  background="../images/bd_background_998.gif">
<tr height="65"><td colspan="2">
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="45">
  <tr height="45">
    <td align="center" valign="middle" height="45" ><map name="FPMap0">
	<area target="_blank" coords="22, 4, 87, 44" shape="rect" href="http://www.spnp.gov.tw/">
	<area target="_blank" coords="90, 0, 139, 44" shape="rect" href="http://www.spnp.gov.tw/">
	</map><img border="0" src="../images/title_E.gif" align="center" usemap="#FPMap0" width="750" height="45" hspace="5">
    </td>
  </tr>
  </table>
</td></tr>

<tr><td valign="top" width="100%" align="center" height="52"> 
<?php  
$_SESSION['item']="3";
include("left.php");
?>
</td></tr><tr height="5"><td></td></tr><tr><td width="100%" valign="top" align="center">
  <!--Begin of webpage//--><!--Begin of webpage//-->         
<table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse">
  <tr>
    <td  valign="top">
     <br><font size="4">Query Invested<br>
      Species</br>

    <form method="GET" action="record_list.php">
<select size="1" name="D1">
    <option value="ALL">ALL</option>
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
    &nbsp;&nbsp;&nbsp;&nbsp;<input type="submit" value="Query" name="B1">
    </form>
    <p>　</td>
    <td>
    <map name="FPMap0">
    <area coords="267, 39, 357, 66" shape="rect" href="record_list.php?D1=1">
    <area href="record_list.php?D1=2" shape="rect" coords="183, 62, 265, 92">
    <area href="record_list.php?D1=3" shape="rect" coords="208, 155, 291, 181">
    <area href="record_list.php?D1=4" shape="rect" coords="280, 230, 363, 249">
    <area href="record_list.php?D1=8" shape="rect" coords="179, 253, 256, 273">
    <area href="record_list.php?D1=5" shape="rect" coords="226, 284, 306, 304">
    <area href="record_list.php?D1=6" shape="rect" coords="218, 321, 295, 340">
    <area href="record_list.php?D1=7" shape="rect" coords="196, 350, 272, 367">
    <area href="record_list.php?D1=9" shape="rect" coords="289, 354, 366, 385">
    <area href="record_list.php?D1=10" shape="rect" coords="55, 407, 132, 437">
    <area href="record_list.php?D1=11" shape="rect" coords="145, 435, 216, 464">
    </map>
    <img border="0" src="../images/stationM.gif" usemap="#FPMap0"></td>
  </tr>
</table>


  <!--End of webpage//--><!--End of webpage//-->         
</td></tr></table>  
                                                                     
</body>
</html>