<?php
include("../function_redirect.php");
   if (strtolower($_POST['username'])=="wlterm"){
     if (strtolower($_POST['password'])=="wlterm"){
	   $_SESSION['login']="y";
	   if ($_POST['page']!=""){
       $redi="http://wlterm.biodiv.sinica.edu.tw/chi/".$_POST['page'].".php?id=".$_POST['id']."&record_id=".$_POST['record_id']."&PI=".$_POST['PI'];
       redirect($redi,301);
	   }else{
	   echo "<center>您已成功登入！";
	   }
     }else{
      echo "<center>密碼錯誤！";
      $_SESSION['login']="n";
	 }
   }else{
    echo "<center>帳號錯誤！";
	$_SESSION['login']="n";
   }
?>