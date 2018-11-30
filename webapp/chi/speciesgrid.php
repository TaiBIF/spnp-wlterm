<!DOCTYPE html PUBLIC "-//IETF//DTD HTML 2.0//EN"> 
<html xmlns="http://www.w3.org/1999/xhtml">
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE9" /> 
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>WLTERM</title>
<head>
<script language="JavaScript" src="menu.js"></script>
<link rel='STYLESHEET' type='text/css' href='../dhtmlxGrid/codebase/style.css'>
<link rel="STYLESHEET" type="text/css" href="../dhtmlxGrid/codebase/dhtmlxgrid.css">
	<script>_js_prefix = "../dhtmlxGrid/codebase/";</script>
	<script  src="../dhtmlxGrid/codebase/dhtmlxcommon.js"></script>
	<script  src="../dhtmlxGrid/codebase/dhtmlxgrid.js"></script>		
	<script  src="../dhtmlxGrid/codebase/dhtmlxgridcell.js"></script>
	<script  src="../dhtmlxGrid/codebase/excells/dhtmlxgrid_excell_calendar.js"></script>
	<script  src="../dhtmlxGrid/codebase/dhtmlxdataprocessor.js"></script>
	<script  src="../dhtmlxGrid/codebase/ext/dhtmlxgrid_srnd.js"></script>
	<script  src="../dhtmlxGrid/codebase/dhtmlxgridcell.js"></script>
	<script  src="../dhtmlxGrid/codebase/ext/dhtmlxgrid_splt.js"></script>
    <script  src="DateExpFunction.js"></script>
<script>
   var crit="";
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
PassValue();
</script>	
<script>
	    var headerno=0;
	    var headerno1=0;
	    var headerno2=0;
		var timeoutHnd;
		var flAuto = false;
		function doOnLoad(){
			mygrid = new dhtmlXGridObject('gridbox');
			mygrid.setImagePath("../dhtmlxGrid/codebase/imgs/");
	    var flds ="門中文,門名,綱中文,綱名,目中文,目名,科中文,科名,學名,中文名,命名者,數量,查詢,地圖";
		mygrid.setHeader(flds);
		mygrid.setInitWidths("65,50,52,47,52,47,55,85,175,75,75,55,45,45")
		mygrid.setColAlign("left,left,left,left,left,left,left,left,left,left,left,center,center,center");
		mygrid.setColTypes("ed,ed,ed,ed,ed,ed,ed,ed,ed,ed,ed,ro,ro,ro");
		mygrid.setColumnIds(flds);
		mygrid.setSkin("light");
		mygrid.setColSorting("str,str,str,str,str,str,str,str,str,str,str,int,str,str");
			if (mygrid.setOnColumnSort)
			    mygrid.setOnColumnSort(customColumnSort)
		    mygrid.init();
		    mygrid.enableSmartRendering(true);

			//available in Pro Edition only
			if (mygrid.setOnLoadingEnd)
			   	mygrid.setOnLoadingEnd(setCounter)
			else{
				//code below written to support standard edtiton
                //it written especially for current sample and may not work
				//in other cases, DON'T USE it if you have pro version
				mygrid.sortField_old=mygrid.sortField;
				mygrid.sortField=function(){
					mygrid.setColSorting("str,str,str,str,str,str,str,str,str,str,str,int,str,str");
                	if (customColumnSort(arguments[0]))
						mygrid.sortField_old.apply(this,arguments);
				}
				mygrid.sortRows=function(col,type,order){
				}
			}


			//mygrid.setOnLoadingStart(showLoading)
			       				//mygrid.splitAt(1);
            if (queryPair[0]!="D1"){
		    mygrid.loadXML("speciesgrid_gridget.php?un="+Date.parse(new Date()));
			}else{
		    mygrid.loadXML("speciesgrid_gridget.php?sc_mask=id&cr_mask=equal&fa_mask="+valuePair[0]);
			}
			showLoading();
	//============================================================================================
	//myDataProcessor = new dataProcessor("day_gridupdate.php");
	//myDataProcessor.enableDebug(false);
	//myDataProcessor.enableDataNames(true);
	//myDataProcessor.setVerificator(1)
	//myDataProcessor.setVerificator(25,checkIfNotdate);
	//myDataProcessor.setUpdateMode("row");//available values: cell (default), row, off
	//myDataProcessor.defineAction("error",myErrorHandler);
	//myDataProcessor.setTransactionMode("GET");
	//myDataProcessor.init(mygrid);
//============================================================================================
		}
		function setCounter(){
			var span = document.getElementById("recfound")
			span.style.color = "";
			span.innerHTML = "<font class='mydefine5'>共 "+mygrid.getRowsNum()+" 種</font>";
		}
		function showLoading(){
			var span = document.getElementById("recfound")
			if(!mygrid.setOnLoadingEnd){
				span.innerHTML = ""
				return;
			}
			span.style.color = "red";
			span.innerHTML = "loading...";
		}
		function doSearch(ev){
			if(!flAuto)
				return;
			var elem = ev.target||ev.srcElement;
			if(timeoutHnd)
				clearTimeout(timeoutHnd)
			timeoutHnd = setTimeout(reloadGrid,500)
		}
		function reloadGrid(){
			var cr_mask = document.getElementById("pcr").value;
			var sc_mask = document.getElementById("pfield").value;
			var fa_mask = document.getElementById("pvalue").value;
			mygrid.clearAll();
			mygrid.loadXML("speciesgrid_gridget.php?sc_mask="+escape(sc_mask)+"&fa_mask="+escape(fa_mask)+"&cr_mask="+escape(cr_mask)+"&orderBy="+window.s_col+"&direction="+window.a_direction);
			if (window.a_direction)
				mygrid.setSortImgState(true,window.s_col,window.a_direction);
			showLoading()
		}
		function reloadGrid2(mygrid){
			var cr_mask = document.getElementById("pcr").value;
			var sc_mask = document.getElementById("pfield").value;
			var fa_mask = document.getElementById("pvalue").value;
			mygrid.clearAll();
			mygrid.loadXML("speciesgrid_gridget.php?sc_mask="+escape(sc_mask)+"&fa_mask="+escape(fa_mask)+"&cr_mask="+escape(cr_mask)+"&orderBy="+window.s_col+"&direction="+window.a_direction);
			if (window.a_direction)
				mygrid.setSortImgState(true,window.s_col,window.a_direction);
			showLoading()
		}
		function enableAutosubmit(state){
			flAuto = state;
			document.getElementById("submitButton").disabled = state
		}
		function customColumnSort(ind){
			if (ind==99) {
				alert("Table can't be sorted by this column.");
				if (window.s_col)
					mygrid.setSortImgState(true,window.s_col,window.a_direction);
				return false;
			}
			var a_state = mygrid.getSortingState();
			window.s_col=ind;
			window.a_direction = ((a_state[1] == "des")?"asc":"des");
            reloadGrid();
			return true;
		}
		function addrow(){
		if (mygrid.getSelectedId() > 0){
		//mygrid.addRow((new Date()).valueOf(),[0,'','','',false,'na',false,''],mygrid.getRowIndex(mygrid.getSelectedId()));
		//mygrid.addRow((new Date()).valueOf(),['',1,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',new Date().toFormat('yyyy-mm-dd'),'','','','','','','','','','','','',''],mygrid.getRowIndex(mygrid.getSelectedId()));
		mygrid.addRow((new Date()).valueOf(),['','',''],mygrid.getRowIndex(mygrid.getSelectedId()));
		}else{
		alert("請先選取一列，再按新增");
		}
		}
		
			function chfont(skin){
		  if (skin=="xp"){
		   mygrid.setAwaitedRowHeight(22);
		   mygrid.setSkin(skin);
		  //reloadGrid();
		  }else{
		   mygrid.setAwaitedRowHeight(20);
		   mygrid.setSkin(skin);
		  } 
		   }
		 function gcheckbox(pobj){
			if (pobj.checked==true){
				    var flds2 = "測站代號,測站名稱,日期,PH,Conductivity,Temperature,DO,Clarity,Alkali_Silicate,NO3_N,NO2_N,SO4,Chloride,Phosphate,AN,TOC";
 			 mygrid.attachHeader(flds2);
			 headerno+=1;
			 headerno1=headerno;
			 reloadGrid();
			}else{
			 mygrid.detachHeader(headerno1);
			 headerno-=1;
			 headerno1=0
			} 
		 }
		 function gcheckbox2(pobj){
			if (pobj.checked==true){
				    var flds2 = "-,-,-,m,m,m,m,m,%,-,-,-,-";

			 mygrid.attachHeader(flds2);
 			 headerno+=1;
			 headerno2=headerno;
			 reloadGrid();
			}else{
			 mygrid.detachHeader(headerno2);
			 headerno-=1;
			 headerno2=0
			} 
		 }
	   
	</script>	
    <script>

	//Example of error handler. It gets <action> tag object as incomming argument.
	function myErrorHandler(obj){
		alert("Error occured.\n"+obj.firstChild.nodeValue);
		myDataProcessor.stopOnError = true;
		return false;
	}
	
	//Example of verification function. It verifies that value is not 0 (zero).
	//If verification failed it should return false otherwise true.
	//Verification fucntion specified in setVerificator method will always get two argumentrs: value to verify and column name (use it for message)
	  function isDate(dateStr) {
	   	
		var datePat = /^(\d{4})(\/|-)(\d{1,2})(\/|-)(\d{1,2})$/;
		var matchArray = dateStr.match(datePat); // is the format ok?
		
		if (matchArray == null) {
		//alert("Please enter date as yyyy-mm-dd");
		return false;
		}
		
		month = matchArray[3]; // p@rse date into variables
		day = matchArray[5];
		year = matchArray[1];
		
		if (year < 1900 || month > 2050) { // check month range
		//alert("Month must be between 1 and 12.");
		return false;
		}
		if (month < 1 || month > 12) { // check month range
		//alert("Month must be between 1 and 12.");
		return false;
		}
		
		if (day < 1 || day > 31) {
		//alert("Day must be between 1 and 31.");
		return false;
		}
		
		if ((month==4 || month==6 || month==9 || month==11) && day==31) {
		//alert("Month "+month+" doesn`t have 31 days!")
		return false;
		}
		
		if (month == 2) { // check for february 29th
		var isleap = (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0));
		if (day > 29 || (day==29 && !isleap)) {
		//alert("February " + year + " doesn`t have " + day + " days!");
		return false;
		}
		}
		return true; // date is valid
		}
		
		function checkIfNotdate(value,colName){
		  var inString=value.toString()._dhx_trim();
		  if (! isDate(inString) && inString!="" )    {    
			showMessage(colName+ " 必須是日期")
		   return false;  
				  }    
		   return true;
	}
	
	//we use this function instead of alert to show messages on page (it is used in checkIfNotZero verification function).
	function showMessage(msg){
		var span = document.getElementById("messanger")
			span.style.color = "red";
			span.innerHTML = msg;
		//var msger = document.getElementById("messanger");
		//msger.innerHTML = msg;
		clearTimeout(toRef) 
		toRef = setTimeout("showMessage('&nbsp;')",5000)
	}
	
	//these functions doesn't have direct relation to data processor. It related to this example interface only.
	function doOnAutoupdateChecked(state){
		if(state){
			document.getElementById("updmdflt").click()
			//myDataProcessor.setUpdateMode('cell')
		}else
			myDataProcessor.setUpdateMode('off')
		document.getElementById('updatebutton').style.display=state?'none':'inline';
		document.getElementById('updatemodes').style.display=state?'':'none'
	}
	var toRef;

	
	</script>
</head>
<body topmargin="0" bgcolor="#EFEFEF"  onLoad="doOnLoad()">
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

<tr><td valign="top" width="100%" align="center" height="52" >
<?php  
$_SESSION['item']=8;
include("left.php");
?>

</td></tr><tr height="5"><td></td></tr><tr><td width="100%" valign="top" align="center">
  <!--Begin of webpage//--><!--Begin of webpage//-->   




<table border="0" cellpadding="0" cellspacing="0" width="95%" height="99%"><tr><td valign="top"> 

<table cellspacing="0" cellpadding="0" border="0">
	<tr valign="middle">
		<td width="240" align="center" valign="middle"></td>
		<td width="140" align="left" valign="middle"><div class="mydefine3">調查物種數量統計</div></td>
		<td width="10" align="center"></td>
		<td width="330" align="left" valign="middle">
        <select class="mydefine" id="pfield" >
        <option class="mydefine" value="phylum_c">門中文</option>
        <option class="mydefine" value="phylum">門名</option>
        <option class="mydefine" value="class_c">綱中文</option>
        <option class="mydefine" value="class">綱名</option>
        <option class="mydefine" value="order_c">目中文</option>
        <option class="mydefine" value="order">目名</option>
        <option class="mydefine" value="family_c">科中文</option>
        <option class="mydefine" value="family">科名</option>
        <option class="mydefine" value="scientific_name">學名</option>
        <option class="mydefine" value="chinese">中文名</option>
        <option class="mydefine" value="author">命名者</option>
        <option class="mydefine" value="total">數量</option>
        </select>
        <select class="mydefine" id="pcr" >
        <option class="mydefine" value="begin">開頭</option>
        <option class="mydefine" value="equal">等於</option>
        <option class="mydefine" value="contain">包含</option>
        </select>
	    <input class="mydefine7" type="text" id="pvalue" ><button class="mydefine7" onClick="reloadGrid()" name="submitButton" id="submitButton" style="margin-left:3px;">搜尋</button></td>
        <td width="120" valign="middle" align="left">
        <span id="recfound">123</span>
        </td>
        <td></td>
        <td>

                
 </td><td><span id="messanger"></span></td>
	<td></td><td align="left"  valign="middle" nowrap>
        </td><td align="left"  valign="middle" nowrap></td>
		
	</tr>
</table>
</td></tr><tr><td valign="top" height="100%"  > 	
	
				<div id="gridbox" width="100%" height="100%" style="background-color:white;overflow:hidden"></div>
	
</td></tr><tr><td valign="top"> 
<table cellspacing="3" cellpadding="0" class="sample_header2" border="0">
	<tr valign="middle"><td align="left">
    <table cellspacing="0" cellpadding="0" border="0" align="center"><tr>
    
<td><input type='radio' name='font' id='font' value='xp' style='margin-left:6px;' onClick='chfont(this.value)'></td><td align="left"  valign="middle" nowrap><font class="mydefine2">大型字</font></td><td align="left"  valign="middle" nowrap>
        <input type='radio' name='font' id='font' value='light' style='margin-left:6px;' onClick='chfont(this.value)' checked></td><td align="left"  valign="middle" nowrap><font class="mydefine2">中型字</font></td><td align="left"  valign="middle" nowrap>
        <input type='radio' name='font' id='font' value='gray' style='margin-left:6px;' onClick='chfont(this.value)'></td><td align="left"  valign="middle" nowrap><font class="mydefine2">小型字</font>
         
         </td></tr></table>
         
         </td>
        <td  align="center"></td>

	</tr>
</table>
</td></tr></table>

  <!--End of webpage//--><!--End of webpage//-->         
</td></tr></table>  
                                                                     
</body>
<script>
if (queryPair[0]!=undefined || queryPair[0]!=null){
document.getElementById("pfield").value = queryPair[0];
document.getElementById("pcr").value = "equal";
document.getElementById("pvalue").value = valuePair[0];
}else{
document.getElementById("pfield").value = "scientific_name";
document.getElementById("pcr").value = "contain";
document.getElementById("pvalue").value = "";

}
</script>
</html>