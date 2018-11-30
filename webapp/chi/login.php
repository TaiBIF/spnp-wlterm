
<!DOCTYPE html PUBLIC "-//IETF//DTD HTML 2.0//EN"> 
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE9" /> 
<title>WLTERM</title>
<script language="JavaScript" src="menu.js"></script>
<STYLE TYPE="text/css">
        <!-- body, th, td, input, select, textarea, select, checkbox {font:10pt Arial}
         a:link {font: 10pt "Arial"; text-decoration: none;color:none}
         a:visited      {font: 10pt "Arial"; text-decoration: none; color: 000000}
         a:active       {font: 10pt "Arial"; text-decoration: none; color: 00CC66}
         a:hover        {font: 10pt Arial; text-decoration: underline; color: ff0000}
        -->
   </STYLE>
</head>

<body topmargin="0" bgcolor="#EFEFEF">
<center><table border="0" cellpadding="0" cellspacing="0" width="998" height="100%"  background="../images/bd_background_998.gif">
<tr height="65"><td >
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="45">
  <tr height="45">
    <td align="center" valign="middle" height="45"  colspan="2"><map name="FPMap0">
	<area target="_blank" coords="75, 0, 139, 44" shape="rect" href="http://www.spnp.gov.tw/">
	</map><img border="0" src="../images/title.jpg" align="center" usemap="#FPMap0" width="750" height="45" hspace="5">
    </td>
  </tr>
  </table>
</td></tr>
<tr height="1"><td valign="top" width="100%" align="center" >
<?php  
include("left.php");
$page=$_GET['page'];
$PI=$_GET['PI'];
$id=$_GET['id'];
$record_id=$_GET['record_id'];
?>
</td></tr><tr><td width="100%" valign="top" align="center">
  <!--Begin of webpage//--><!--Begin of webpage//-->   
<p align="center" style="margin-top:30"><b><font size="4">請輸入帳號密碼</font><font color="#cc0000" size="4"><br>
</font>
</b><br>

<form method="POST" action="login_pass.php">
  <div align="center">
    <center>
    <table border="0" cellpadding="0" cellspacing="0">
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
      <td width="152" bgcolor="#E7E3E7" align="right">
        <font size="2">帳號：</font></td>
      <td width="31" bgcolor="#E7E3E7" height="30" align="left" nowrap><input type="text" name="username" value="" size="15"></td>
    </tr>
    <tr>
      <td width="152" bgcolor="#E7E3E7" height="30" align="right" nowrap>
        <font size="2">密碼：</font>
      </td>
    <center>
  <center>
      <td width="206" bgcolor="#E7E3E7" height="30" align="left"><input type="password" name="password" size="15"></td>
    </tr>
    <tr>
      <td width="474" bgcolor="#E7E3E7" colspan="3" height="50">
        <p align="center">　　　　　<input type="submit" value="登入" name="B1" style="font-size: 10pt">　　　<input type="reset" value="取消" name="B2" style="font-size: 10pt"></td>
    </tr>
  </table>
  </center>
</div>
        </td>
      </tr>
    </table>
  </div>
  <input type="hidden" name="page" value="<?php echo $page?>">
  <input type="hidden" name="id" value="<?php echo $id?>">
  <input type="hidden" name="record_id" value="<?php echo $record_id?>">
  <input type="hidden" name="PI" value="<?php echo $PI?>">
</form>
  <!--End of webpage//--><!--End of webpage//-->         
</td></tr></table>  
                                                                 
</body>
</html>