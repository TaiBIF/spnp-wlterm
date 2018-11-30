<?php 
function redirect($url, $type=301) 
{ 
if ($type == 301) header("HTTP/1.1 301 Moved Permanently"); 
header("Location: $url"); 
echo 'This page has moved to <a href="'.$url.'">'.$url.'</a>'; 
exit(); 
}

?> 
