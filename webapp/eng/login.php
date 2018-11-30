<!DOCTYPE html PUBLIC "-//IETF//DTD HTML 2.0//EN"> 
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
$_SESSION['item']="13";
include("left.php");
$page=$_GET['page'];
$PI=$_GET['PI'];
$id=$_GET['id'];
$record_id=$_GET['record_id'];

?>
</td></tr><tr><td width="100%" valign="top" align="center">
  <!--Begin of webpage//--><!--Begin of webpage//-->         
<p align="center"><br>
<p align="center"><b><font size="4">Login for Maintenance</font><font color="#cc0000" size="4"><br>
</font>
</b><br>
<form method="POST" action="login_pass.php">
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
        <p align="right"><font size="2">USERNAME :</font>
      </td>
    <center>
  <center>
      <td width="31" bgcolor="#E7E3E7" height="30" align="right" nowrap><input type="text" name="username" value="" size="15"></td>
    </tr>
  </center>
  </center>
    <tr>
      <td width="152" bgcolor="#E7E3E7" height="30" align="right" nowrap>
        <p align="right"><font size="2">PASSWORD :</font></p>
      </td>
    <center>
  <center>
      <td width="206" bgcolor="#E7E3E7" height="30"><input type="password" name="password" size="15"></td>
    </tr>
    <tr>
      <td width="474" bgcolor="#E7E3E7" colspan="3" height="50">
        <p align="center">　　　　　<input type="submit" value="Login" name="B1" style="font-size: 10pt">　　　<input type="reset" value="Cancel" name="B2" style="font-size: 10pt"></td>
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