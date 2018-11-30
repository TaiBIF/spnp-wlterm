<?php
include("../function_redirect.php");
   if (strtolower($_POST['username'])=="wlterm"){
     if (strtolower($_POST['password'])=="wlterm"){
	   $_SESSION['login']="y";
	   if ($_POST['page']!=""){
       $redi="http://wlterm.biodiv.sinica.edu.tw/eng/".$_POST['page'].".php?id=".$_POST['id']."&record_id=".$_POST['record_id']."&PI=".$_POST['PI'];
       redirect($redi,301);
	   }else{
	   echo "<center>Already Login !";
	   }
     }else{
      echo "<center>Invalid username";
      $_SESSION['login']="n";
	 }
   }else{
    echo "<center>Invalid password!";
	$_SESSION['login']="n";
   }
?>