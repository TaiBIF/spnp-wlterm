<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">  
<head>    
<meta http-equiv="content-type" content="text/html; charset=utf-8"/>    
<title>WLTERM</title>    
<script language="JavaScript" src="menu.js"></script>
    <script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=ABQIAAAA1Zc6d9M907-OpbNNM0nS7BT7gINZLjxxLt7dmrzjF7jzv_AMFhTexy9JQuKIr55kQJkPd6_yu3Ohxw"
      type="text/javascript"></script>

<SCRIPT type=text/javascript>
     //<![CDATA[

    var u_buttonText="武陵混合";
    var us_buttonText="武陵衛星";
    var map;
    function load() {
	
	var t_tileLayers = [ G_SATELLITE_MAP.getTileLayers()[0],G_HYBRID_MAP.getTileLayers()[1]];
    var t_customMap = new GMapType(t_tileLayers,  G_NORMAL_MAP.getProjection(), "混合",
            {maxResolution:16, minResolution:7, errorMessage:"Data not available"});

    var s_tileLayers = [ G_SATELLITE_MAP.getTileLayers()[0], new GTileLayer(copyrightCollection, 0, 17)];
    var s_customMap = new GMapType(s_tileLayers,  G_NORMAL_MAP.getProjection(), "衛星",
            {maxResolution:16, minResolution:7, errorMessage:"Data not available"});

	var v_tileLayers = [ G_NORMAL_MAP.getTileLayers()[0], new GTileLayer(copyrightCollection, 0, 17)];
    var v_customMap = new GMapType(v_tileLayers,  G_NORMAL_MAP.getProjection(), "地圖",
            {maxResolution:16, minResolution:7, errorMessage:"Data not available"});

    var copyright = new GCopyright(1,
                              new GLatLngBounds(new GLatLng(-90, -180),
                                                new GLatLng(90, 180)),
                              0,
                              "<a href=\"http://gis.ascc.net\">ASCC_GIS</a>");
    var copyrightCollection = new GCopyrightCollection("Sinica");
     copyrightCollection.addCopyright(copyright);

            

        //create a custom Topomap+Baotu layer
        var u_tileLayers = [ G_NORMAL_MAP.getTileLayers()[0],new GTileLayer(copyrightCollection , -1, 17),G_HYBRID_MAP.getTileLayers()[1]];
        u_tileLayers[1].getTileUrl = function(tile, zoom) {
      	 zoom1=17-zoom;
      	 if (zoom1>-2&&zoom1<6)
      	  {
      	   return ".././"+zoom1+'/'+tile.x+'/IMG_'+tile.x + '_' + tile.y + '_'+zoom1+".jpg";
      	  }
      	 else 
      	  {
      	   return "";
      	  }
      	 
      }
        var us_tileLayers = [ G_NORMAL_MAP.getTileLayers()[0],new GTileLayer(copyrightCollection , -1, 17)];
        us_tileLayers[1].getTileUrl = function(tile, zoom) {
      	 zoom1=17-zoom;
      	 if (zoom1>-2&&zoom1<6)
      	  {
      	   return ".././"+zoom1+'/'+tile.x+'/IMG_'+tile.x + '_' + tile.y + '_'+zoom1+".jpg";
      	  }
      	 else 
      	  {
      	   return "";
      	  }
      	 
      }
        var u_customMap = new GMapType(u_tileLayers, G_HYBRID_MAP.getProjection(), u_buttonText,
            {maxResolution:18, minResolution:0});
        var us_customMap = new GMapType(us_tileLayers, G_NORMAL_MAP.getProjection(), us_buttonText,
            {maxResolution:18, minResolution:0});

       map = new GMap2(document.getElementById("map"),{mapTypes:[s_customMap,t_customMap,u_customMap,us_customMap,v_customMap]});

        map.addControl(new GLargeMapControl());
        map.addControl(new GMapTypeControl());
        map.addControl(new GScaleControl());  
        map.enableContinuousZoom();
        map.setCenter(new GLatLng(24.3601, 121.3146), 13, u_customMap); //17 equa 0 layer

PassValue();

      var pid=valuePair[1];
      if (pid ==1){
      document.getElementById("ptitle").innerHTML = "藻類與有機碎屑調查點圖";}
      else if (pid ==3){
      document.getElementById("ptitle").innerHTML = "水質調查點圖";}
      else if (pid ==4){
      document.getElementById("ptitle").innerHTML = "硝酸鹽調查點圖";}
      else if  (pid ==13){
      document.getElementById("ptitle").innerHTML = "主要元素通量調查點圖";}
      else if  (pid ==14){
      document.getElementById("ptitle").innerHTML = "環境溫度調查點圖";}
      else if  (pid ==0){
      document.getElementById("ptitle").innerHTML = "主要調查測站圖";}
      else if  (pid ==99){
      document.getElementById("ptitle").innerHTML = valuePair[3]+" "+valuePair[2]+" 調查分布點圖";}
      else{
      document.getElementById("ptitle").innerHTML = crit +"調查點圖";}

   var icon = new GIcon();
   icon.image = "http://wlterm.biodiv.sinica.edu.tw/images/icon.png";
   icon.shadow ="http://wlterm.biodiv.sinica.edu.tw/images/icon.png";
   icon.iconSize = new GSize(10, 10);
   icon.shadowSize = new GSize(10, 10);
   icon.iconAnchor=new GPoint(5,5)
   icon.infoWindowAnchor = new GPoint(5, 5); 
var request = GXmlHttp.create();
var GetDataXml="GetDataXml.php?" + queryPair[0] + "=" + escape(valuePair[0]) + "&" + queryPair[1] + "=" + escape(valuePair[1])+ "&" + queryPair[2] + "=" + escape(valuePair[2])+ "&" + queryPair[3] + "=" + escape(valuePair[3])+ "&" + queryPair[4] + "=" + valuePair[4] ;

request.open("GET",GetDataXml, true);
request.onreadystatechange = function() {
  if (request.readyState == 4) {
    var xmlDoc = request.responseXML;
    var markers = xmlDoc.documentElement.getElementsByTagName("marker");
    for (var i = 0; i < markers.length; i++) {
      var point = new GLatLng(parseFloat(markers[i].getAttribute("lat")),parseFloat(markers[i].getAttribute("lng")));
      var id=markers[i].getAttribute("id");
      var loca=markers[i].getAttribute("loca");
      var marker = createMarkerWithLnk(point,icon,id,loca);
      map.addOverlay(marker);
    }
}
}

 GEvent.addListener(map,"click", function(overlay,point) {
        document.getElementById("message").innerHTML = "<font size=2>武陵衛星影像拍攝日期：2004/10/22，您點擊的座標：" + round1(point.y,5)+","+round1(point.x,5)+"</font>";          
          });   

request.send(null);

    }
    function createMarkerWithLnk(point,icon,id,loca) {
      var name;
      if (id < 14){
      name="測站";}
      else{
      name="臨時測站";}
      var urlstr=name+ id+":" +loca;
      var pid=valuePair[1];
      if ((pid ==1) ||(pid ==3) || (pid ==4) ||(pid ==13)) {
      var url="http://wlterm.biodiv.sinica.edu.tw/chi/WaterQ.php?D1=" + id + "&PI=" + pid;}
      else if (pid ==14){
      var url="http://wlterm.biodiv.sinica.edu.tw/chi/temperature.php?D1=" + id ;}
      else{
       if (queryPair[2]=='sc') {
        var url="http://wlterm.biodiv.sinica.edu.tw/chi/record_list.php?D1=" + id+"&sc="+valuePair[2];}
       else if (queryPair[2]=='fa') {
        var url="http://wlterm.biodiv.sinica.edu.tw/chi/record_list.php?D1=" + id+"&fa="+valuePair[2];}
       else if (queryPair[2]=='or') {
        var url="http://wlterm.biodiv.sinica.edu.tw/chi/record_list.php?D1=" + id+"&or="+valuePair[2];}
       else if (queryPair[2]=='cl') {
        var url="http://wlterm.biodiv.sinica.edu.tw/chi/record_list.php?D1=" + id+"&cl="+valuePair[2];}
       else{
        var url="http://wlterm.biodiv.sinica.edu.tw/chi/record_list.php?D1=" + id;}
      } 
  	  	var marker = new GMarker(point,{icon:icon, clickable:true,title:urlstr});
	    GEvent.addListener(marker, "click", function() {location.href=url});   
	    return marker;
	}
	
var crit;	
   function PassValue() {	
		var queryString = location.search.replace("?", "");
		queryPair = new Array();    //存放 key 值的陣列
		valuePair = new Array();    // 存放 value 的陣列
		var tmpQuery = queryString.split("&");
		var tmpValue = new Array();
		var count = (queryString.length > 0) ? tmpQuery.length : 0;
		 
		for (var i=0; i<count; i++)
		{
		    tmpValue = tmpQuery[i].split("=");
		    queryPair[i] = tmpValue[0];
		    valuePair[i] = unescape(tmpValue[1]);
			if (i>1 && i <5 && valuePair[i]!="" ){
			 crit=valuePair[i];
			} 
		}
	}

function round1(value,num){ return parseInt(value * Math.pow(10,num) + 0.5) / Math.pow(10,num); } function round2(value,num){ return Math.round(value * Math.pow(10,num)) / Math.pow(10,num); } 
   //]]>
    </script>
<BODY onload=load() onunload=GUnload() scroll="yes" topmargin="0"  bgcolor="#EFEFEF">
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

<tr><td valign="top" width="100%" align="center" height="52">
<?php  
$_SESSION['item']=4;
include("left.php");
?>

</td></tr><tr height="5"><td></td></tr><tr><td width="100%" valign="top" align="center">
  <!--Begin of webpage//--><!--Begin of webpage//-->   
<div id="ptitle" style="margin-top:2px"><font size=2>武陵衛星</font></div>
<div id="map" style="width: 97%; height: 92%"></div>
<div id="message"><font size=2>武陵衛星影像拍攝日期：2004/10/22</font></div>
  <!--End of webpage//--><!--End of webpage//-->         
</td></tr></table>  
                                                                     
</body>
</html>