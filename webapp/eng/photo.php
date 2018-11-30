<!DOCTYPE html PUBLIC "-//IETF//DTD HTML 2.0//EN"> 
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>WLTERM</title>
<script language="JavaScript" src="menu.js"></script>
</head>
<style type="text/css">
a:link {
	font-family: "Times New Roman", Times, serif;
	color: #000000;
	text-decoration:none;
}	
a:visited {
	font-family: "Times New Roman", Times, serif;
	color: #000000;
	text-decoration:none;
}	
a:active {
	font-family: "Times New Roman", Times, serif;
	color: 00CC66;
	text-decoration:none;
}	
a:hover {
	font-family: "Times New Roman", Times, serif;
	color: #FF0000;
	text-decoration: underline;
	
}	
</style>
<body topmargin="0" bgcolor="#EFEFEF">
<center><table border="0" cellpadding="0" cellspacing="0" width="998" height="100%"  background="../images/bd_background_998.gif">
<tr height="65"><td >
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="45">
  <tr height="45">
    <td align="center" valign="middle" height="45"  colspan="2"><map name="FPMap0">
	<area target="_blank" coords="22, 4, 87, 44" shape="rect" href="http://www.spnp.gov.tw/">
	<area target="_blank" coords="90, 0, 139, 44" shape="rect" href="http://www.spnp.gov.tw/">
	</map><img border="0" src="../images/title_E.gif" align="center" usemap="#FPMap0" width="750" height="45" hspace="5">
    </td>
  </tr>
  </table>
</td></tr>

<tr><td valign="top" width="100%" align="center" >
<?php  
$_SESSION['item']="2";
include("left.php");
?>
</td></tr><tr height="5"><td></td></tr><tr><td width="95%" valign="top" align="center">
  <!--Begin of webpage//--><!--Begin of webpage//-->        
<table border="0" width="99%">
  <tr>
    <td width="100%" align="center" valign="top">

<?php
// open the current directory
$dhandle = opendir('/home/webroot/wlterm/smallphotos/');
// define an array to hold the files
$files = array();

if ($dhandle) {
   // loop through all of the files
   while (false !== ($fname = readdir($dhandle))) {
      // if the file is not this file, and does not start with a '.' or '..',
      // then store it for later display
      if (($fname != '.') && ($fname != '..') &&
          ($fname != basename($_SERVER['PHP_SELF']))) {
          // store the filename
          $files[] = (is_dir( "./$fname" )) ? "(Dir) {$fname}" : $fname;
      }
   }
   // close the directory
   closedir($dhandle);
}

// Now loop through the files, echoing out a new select option for each one
$i=0;
foreach($files as $fname )
{
$filename="/home/webroot/wlterm/smallphotos/". $fname;
if (file_exists($filename)){
  echo "<a href='photoLarge.php?file=photos/{$fname}'><img border='0'  src='/smallphotos/{$fname}' width='186'></a>&nbsp;";
  $i++;
  if (fmod($i,5)==0){
  echo "<br>";
  }
}  
}
?>
</td>
  </tr>
</table>


  <!--End of webpage//--><!--End of webpage//-->         
</td></tr></table>  
                                                                     
</body>
</html>
 

