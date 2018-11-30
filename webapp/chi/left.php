<?php
if ($_SESSION['item']==1){
$i1="c";
}elseif ($_SESSION['item']==2){
$i2="c";
}elseif ($_SESSION['item']==3){
$i3="c";
}elseif ($_SESSION['item']==4){
$i4="c";
}elseif ($_SESSION['item']==5){
$i5="c";
}elseif ($_SESSION['item']==6){
$i6="c";
}elseif ($_SESSION['item']==7){
$i7="c";
}elseif ($_SESSION['item']==8){
$i8="c";
}elseif ($_SESSION['item']==9){
$i9="c";
}elseif ($_SESSION['item']==10){
$i10="c";
}elseif ($_SESSION['item']==11){
$i11="c";
}elseif ($_SESSION['item']==12){
$i12="c";
}elseif ($_SESSION['item']==13){
$i13="c";
}elseif ($_SESSION['item']==14){
$i14="c";
}elseif ($_SESSION['item']==15){
$i15="c";
}elseif ($_SESSION['item']==16){
$i16="c";
}else{
	$i1="c";
}
?>
<a href="http://wlterm.biodiv.tw/home.php" target="_self" ONMOUSEDOWN="if (bIsSupportOK) ReplaceImage('U1', MouseDownState);" ONMOUSEUP="if (bIsSupportOK) ReplaceImage('U1', MouseOverState);" ONMOUSEOUT="if (bIsSupportOK) ReplaceImage('U1',DefaultState);" ONMOUSEOVER="if (bIsSupportOK) ReplaceImage('U1', MouseOverState);"><img name="U1<?php echo $i1?>" alt="計畫簡介" border="0" src="../images/leftnew1<?php echo $i1?>.jpg" width="88" height="26"></a>
<a href="http://wlterm.biodiv.tw/chi/photo.php" target="_self" ONMOUSEDOWN="if (bIsSupportOK) ReplaceImage('U2', MouseDownState);" ONMOUSEUP="if (bIsSupportOK) ReplaceImage('U2', MouseOverState);" ONMOUSEOUT="if (bIsSupportOK) ReplaceImage('U2',DefaultState);" ONMOUSEOVER="if (bIsSupportOK) ReplaceImage('U2', MouseOverState);"><img name="U2<?php echo $i2?>" alt="現場影像" border="0" src="../images/leftnew2<?php echo $i2?>.jpg" width="88" height="26"></a>
<a href="http://wlterm.biodiv.tw/chi/stationgrid.php" target="_self" ONMOUSEDOWN="if (bIsSupportOK) ReplaceImage('U3', MouseDownState);" ONMOUSEUP="if (bIsSupportOK) ReplaceImage('U3', MouseOverState);" ONMOUSEOUT="if (bIsSupportOK) ReplaceImage('U3',DefaultState);" ONMOUSEOVER="if (bIsSupportOK) ReplaceImage('U3', MouseOverState);"><img name="U3<?php echo $i3?>" alt="測站資料" border="0" src="../images/leftnew19<?php echo $i3?>.jpg" width="88" height="26"></a>
<a href="http://wlterm.biodiv.tw/chi/locamap.php?id=0&pid=0" target="_self" ONMOUSEDOWN="if (bIsSupportOK) ReplaceImage('U4', MouseDownState);" ONMOUSEUP="if (bIsSupportOK) ReplaceImage('U4', MouseOverState);" ONMOUSEOUT="if (bIsSupportOK) ReplaceImage('U4',DefaultState);" ONMOUSEOVER="if (bIsSupportOK) ReplaceImage('U4', MouseOverState);"><img name="U4<?php echo $i4?>" alt="衛星地圖" border="0" src="../images/leftnew4<?php echo $i4?>.jpg" width="88" height="26"></a>
<a href="http://wlterm.biodiv.tw/chi/phylumgrid.php" target="_self" ONMOUSEDOWN="if (bIsSupportOK) ReplaceImage('U9', MouseDownState);" ONMOUSEUP="if (bIsSupportOK) ReplaceImage('U9', MouseOverState);" ONMOUSEOUT="if (bIsSupportOK) ReplaceImage('U9',DefaultState);" ONMOUSEOVER="if (bIsSupportOK) ReplaceImage('U9', MouseOverState);"><img name="U9<?php echo $i11?>" alt="門別統計" border="0" src="../images/leftnew9<?php echo $i11?>.jpg" width="88" height="26"></a>
<a href="http://wlterm.biodiv.tw/chi/classgrid.php" target="_self" ONMOUSEDOWN="if (bIsSupportOK) ReplaceImage('U15', MouseDownState);" ONMOUSEUP="if (bIsSupportOK) ReplaceImage('U15', MouseOverState);" ONMOUSEOUT="if (bIsSupportOK) ReplaceImage('U15',DefaultState);" ONMOUSEOVER="if (bIsSupportOK) ReplaceImage('U15', MouseOverState);"><img name="U15<?php echo $i5?>" alt="綱別統計" border="0" src="../images/leftnew15<?php echo $i5?>.jpg" width="88" height="26"></a>
<a href="http://wlterm.biodiv.tw/chi/ordergrid.php" target="_self" ONMOUSEDOWN="if (bIsSupportOK) ReplaceImage('U16', MouseDownState);" ONMOUSEUP="if (bIsSupportOK) ReplaceImage('U16', MouseOverState);" ONMOUSEOUT="if (bIsSupportOK) ReplaceImage('U16',DefaultState);" ONMOUSEOVER="if (bIsSupportOK) ReplaceImage('U16', MouseOverState);"><img name="U16<?php echo $i6?>" alt="目別統計" border="0" src="../images/leftnew16<?php echo $i6?>.jpg" width="88" height="26"></a>
<a href="http://wlterm.biodiv.tw/chi/familygrid.php" target="_self" ONMOUSEDOWN="if (bIsSupportOK) ReplaceImage('U5', MouseDownState);" ONMOUSEUP="if (bIsSupportOK) ReplaceImage('U5', MouseOverState);" ONMOUSEOUT="if (bIsSupportOK) ReplaceImage('U5',DefaultState);" ONMOUSEOVER="if (bIsSupportOK) ReplaceImage('U5', MouseOverState);"><img name="U5<?php echo $i7?>" alt="科別統計" border="0" src="../images/leftnew5<?php echo $i7?>.jpg" width="88" height="26"></a></br>
<a href="http://wlterm.biodiv.tw/chi/speciesgrid.php" target="_self" ONMOUSEDOWN="if (bIsSupportOK) ReplaceImage('U6', MouseDownState);" ONMOUSEUP="if (bIsSupportOK) ReplaceImage('U6', MouseOverState);" ONMOUSEOUT="if (bIsSupportOK) ReplaceImage('U6',DefaultState);" ONMOUSEOVER="if (bIsSupportOK) ReplaceImage('U6', MouseOverState);"><img name="U6<?php echo $i8?>" alt="物種統計" border="0" src="../images/leftnew6<?php echo $i8?>.jpg" width="88" height="26"></a>
<a href="http://wlterm.biodiv.tw/chi/recordgrid.php" target="_self" ONMOUSEDOWN="if (bIsSupportOK) ReplaceImage('U7', MouseDownState);" ONMOUSEUP="if (bIsSupportOK) ReplaceImage('U7', MouseOverState);" ONMOUSEOUT="if (bIsSupportOK) ReplaceImage('U7',DefaultState);" ONMOUSEOVER="if (bIsSupportOK) ReplaceImage('U7', MouseOverState);"><img name="U7<?php echo $i9?>" alt="物種紀錄" border="0" src="../images/leftnew7<?php echo $i9?>.jpg" width="88" height="26"></a>
<a href="http://wlterm.biodiv.tw/chi/watergrid.php?PI=3&D1=ALL" target="_self" ONMOUSEDOWN="if (bIsSupportOK) ReplaceImage('U8', MouseDownState);" ONMOUSEUP="if (bIsSupportOK) ReplaceImage('U8', MouseOverState);" ONMOUSEOUT="if (bIsSupportOK) ReplaceImage('U8',DefaultState);" ONMOUSEOVER="if (bIsSupportOK) ReplaceImage('U8', MouseOverState);"><img name="U8<?php echo $i10?>" alt="水質調查" border="0" src="../images/leftnew8<?php echo $i10?>.jpg" width="88" height="26"></a>
<a href="http://wlterm.biodiv.tw/chi/elementgrid.php?PI=13&D1=ALL" target="_self" ONMOUSEDOWN="if (bIsSupportOK) ReplaceImage('U10', MouseDownState);" ONMOUSEUP="if (bIsSupportOK) ReplaceImage('U10', MouseOverState);" ONMOUSEOUT="if (bIsSupportOK) ReplaceImage('U10',DefaultState);" ONMOUSEOVER="if (bIsSupportOK) ReplaceImage('U10', MouseOverState);"><img name="U10<?php echo $i12?>" alt="元素通量" border="0" src="../images/leftnew10<?php echo $i12?>.jpg" width="88" height="26"></a>
<a href="http://wlterm.biodiv.tw/chi/temperaturegrid.php" target="_self" ONMOUSEDOWN="if (bIsSupportOK) ReplaceImage('U11', MouseDownState);" ONMOUSEUP="if (bIsSupportOK) ReplaceImage('U11', MouseOverState);" ONMOUSEOUT="if (bIsSupportOK) ReplaceImage('U11',DefaultState);" ONMOUSEOVER="if (bIsSupportOK) ReplaceImage('U11', MouseOverState);"><img name="U11<?php echo $i13?>" alt="溫度監測" border="0" src="../images/leftnew11<?php echo $i13?>.jpg" width="88" height="26"></a>
<a href="http://wlterm.biodiv.tw/chi/alagegrid.php" target="_self" ONMOUSEDOWN="if (bIsSupportOK) ReplaceImage('U12', MouseDownState);" ONMOUSEUP="if (bIsSupportOK) ReplaceImage('U12', MouseOverState);" ONMOUSEOUT="if (bIsSupportOK) ReplaceImage('U12',DefaultState);" ONMOUSEOVER="if (bIsSupportOK) ReplaceImage('U12', MouseOverState);"><img name="U12<?php echo $i14?>" alt="藻類碎屑" border="0" src="../images/leftnew12<?php echo $i14?>.jpg" width="88" height="26"></a>
<a href="http://wlterm.biodiv.tw/chi/flowgrid.php" target="_self" ONMOUSEDOWN="if (bIsSupportOK) ReplaceImage('U18', MouseDownState);" ONMOUSEUP="if (bIsSupportOK) ReplaceImage('U18', MouseOverState);" ONMOUSEOUT="if (bIsSupportOK) ReplaceImage('U18',DefaultState);" ONMOUSEOVER="if (bIsSupportOK) ReplaceImage('U18', MouseOverState);"><img name="U18<?php echo $i15?>" alt="流量推估" border="0" src="../images/leftnew18<?php echo $i15?>.jpg" width="88" height="26"></a>
<a href="http://wlterm.biodiv.tw/eng/home.php" target="_top" ONMOUSEDOWN="if (bIsSupportOK) ReplaceImage('Uen', MouseDownState);" ONMOUSEUP="if (bIsSupportOK) ReplaceImage('Uen', MouseOverState);" ONMOUSEOUT="if (bIsSupportOK) ReplaceImage('Uen',DefaultState);" ONMOUSEOVER="if (bIsSupportOK) ReplaceImage('Uen', MouseOverState);"><img name="Uen<?php echo $i16?>" alt="English Version" border="0" src="../images/leftnew17<?php echo $i16?>.jpg" width="88" height="26"></a>