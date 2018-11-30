<!--#include file="conn.asp "-->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<meta name="GENERATOR" content="Microsoft FrontPage 6.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title></title>
<STYLE TYPE="text/css">
        <!-- body, th, td, input, select, textarea, select, checkbox {font:10pt Arial}
         a:link {font: 10pt "Arial"; text-decoration: none;color:none}
         a:visited      {font: 10pt "Arial"; text-decoration: none; color: 000000}
         a:active       {font: 10pt "Arial"; text-decoration: none; color: 00CC66}
         a:hover        {font: 10pt Arial; text-decoration: underline; color: ff0000}
        -->
   </STYLE>

</head>
<body>
<% 
science=request("science")  
if science<>"" then Ptitle=science
fa=request("fa")  
if fa <> "" then Ptitle=fa       
porder=request("R1")
id=request("id")
latitude=request("latitude")
longitude=request("longitude")  
if porder="" then porder="date"
pporder=porder
if porder="scientific_name" then 
  p1=" style='border: 1 ridge #B4B4B4'"
elseif porder="date" then 
  p2=" style='border: 1 ridge #B4B4B4'"
elseif porder="locality" then
  p3=" style='border: 1 ridge #B4B4B4'"
elseif porder="latitude" then
  p4=" style='border: 1 ridge #B4B4B4'"
elseif porder="longitude" then
  p5=" style='border: 1 ridge #B4B4B4'"
elseif porder="minimum_depth" then
  p6=" style='border: 1 ridge #B4B4B4'"
elseif porder="collector" then
  p7=" style='border: 1 ridge #B4B4B4'"
end if  
if fa = "" then
	if science<>"" then
	 sql="SELECT main.*, Station.* FROM main INNER JOIN Station ON main.id = Station.id where scientific_name='" & science & "'  order by " & pporder
	elseif latitude<>"" then
	 sql="SELECT main.*, Station.* FROM main INNER JOIN Station ON main.id = Station.id where latitude >" & latitude-0.0001 & " and latitude <" & latitude+0.0001 & " and longitude >" & longitude-0.0001 & " and longitude <" & longitude+0.0001 & " order by " & pporder
	elseif mid(id,1,2)="W_" then
	 rederectStr="data_detail.asp?id=" & id
	 response.redirect rederectStr
	elseif mid(id,1,2)="PP" then
	 sql="SELECT * FROM (main INNER JOIN Station ON main.id = Station.id) INNER JOIN Project ON Station.P_ID = Project.Project_id where Project_id='" & mid(id,3) & "'"
	else
	 sql="SELECT main.*, Station.* FROM main INNER JOIN Station ON main.id = Station.id where main.id ='" & id & "'  order by " & pporder
	end if
else
	 sql="SELECT main.*, Station.* FROM main INNER JOIN Station ON main.id = Station.id where family='" & fa & "'  order by " & pporder
end if	
rs.open sql ,conn ,1,1 
%> 
<table border=0 cellpadding=0 cellspacing=0><tr><td>
<center>
  <font size="3">
 
  <% if science<>"" or fa <> "" then %>
  <%=Ptitle%>&nbsp;&nbsp;<%=rs.recordcount%>&nbsp;records&nbsp;
	  <%if science<>"" then%> 
	  <a href="../LocalMapE.asp?id=0&pid=99&sc=<%=science%>"><img border="0" src="../images/googlemap.gif" align="absmiddle"></a>
	  <%elseif fa<>"" then%>
	  <a href="../LocalMapE.asp?id=0&pid=99&fa=<%=fa%>"><img border="0" src="../images/googlemap.gif" align="absmiddle"></a>
	  <%end if%>
  <%elseif latitude<>"" then%>
  <%=rs.recordcount%>&nbsp;records for coordinate&nbsp;<%=latitude%> , <%=longitude%>
  <%elseif mid(id,1,2)="PP" then%>
  &nbsp;<%=rs.recordcount%>&nbsp;records&nbsp;<a href="map.asp?id=<%=id%>"><img border="0" src="../images/position_link5.gif" align="absmiddle"></a>
  <%else%>
  <%=rs.recordcount%>&nbsp;records for coordinate&nbsp;<%=rs("longitude")%>&nbsp;,&nbsp;<%=rs("latitude")%>&nbsp;<a href="map.asp?id=<%=rs("Station.id")%>"><img border="0" src="../images/position_link5.gif" align="absmiddle"></a>
  <%end if%>
 
<table border="1" height="49" cellspacing="1" cellpadding="2">         
   <tr>         
    <td bgcolor="#D6D7D6" height="17" align="center" nowrap><font color="#000000" size="2">Scientific Name<a href="http://wlterm.biodiv.sinica.edu.tw/english/specieslist2.asp?id=<%=id%>&R1=scientific_name&D1=<%=pcrit%>&science=<%=science%>&fa=<%=fa%>"><img border="0" src="../images/arrow.gif" align="absmiddle" hspace="2" vspace="2" alt="排序" <%=p1%>></a></font></td>         
    <td bgcolor="#D6D7D6" height="17" align="center" nowrap><font color="#000000" size="2">Date<a href="http://wlterm.biodiv.sinica.edu.tw/english/specieslist2.asp?id=<%=id%>&R1=date&D1=<%=pcrit%>&science=<%=science%>&fa=<%=fa%>"><img border="0" src="../images/arrow.gif" align="absmiddle" hspace="2" vspace="2" alt="排序" <%=p2%>></a></font></td>         
    <td bgcolor="#D6D7D6" height="17" align="center" nowrap><font color="#000000" size="2">Locality<a href="http://wlterm.biodiv.sinica.edu.tw/english/specieslist2.asp?id=<%=id%>&R1=locality&D1=<%=pcrit%>&science=<%=science%>&fa=<%=fa%>"><img border="0" src="../images/arrow.gif" align="absmiddle" hspace="2" vspace="2" alt="排序" <%=p3%>></a></font></td>         
    <td bgcolor="#D6D7D6" height="17" align="center" nowrap><font color="#000000" size="2">Latitude<a href="http://wlterm.biodiv.sinica.edu.tw/english/specieslist2.asp?id=<%=id%>&R1=latitude&D1=<%=pcrit%>&science=<%=science%>&fa=<%=fa%>"><img border="0" src="../images/arrow.gif" align="absmiddle" hspace="2" vspace="2" alt="排序" <%=p4%>></a></font></td>         
    <td bgcolor="#D6D7D6" height="17" align="center" nowrap><font color="#000000" size="2">Longitude<a href="http://wlterm.biodiv.sinica.edu.tw/english/specieslist2.asp?id=<%=id%>&R1=longitude&D1=<%=pcrit%>&science=<%=science%>&fa=<%=fa%>"><img border="0" src="../images/arrow.gif" align="absmiddle" hspace="2" vspace="2" alt="排序" <%=p5%>></a></font></td>         
    <td bgcolor="#D6D7D6" height="17" align="center" nowrap><font color="#000000" size="2">Depth<a href="http://wlterm.biodiv.sinica.edu.tw/english/specieslist2.asp?id=<%=id%>&R1=minimum_depth&D1=<%=pcrit%>&science=<%=science%>&fa=<%=fa%>"><img border="0" src="../images/arrow.gif" align="absmiddle" hspace="2" vspace="2" alt="排序" <%=p6%>></a></font></td>      
    <td bgcolor="#D6D7D6" height="17" align="center" nowrap><font color="#000000" size="2">Collector<a href="http://wlterm.biodiv.sinica.edu.tw/english/specieslist2.asp?id=<%=id%>&R1=collector&D1=<%=pcrit%>&science=<%=science%>&fa=<%=fa%>"><img border="0" src="../images/arrow.gif" align="absmiddle" hspace="2" vspace="2" alt="排序" <%=p7%>></a></font></td>      
    <td bgcolor="#D6D7D6" height="17" align="center" nowrap><font color="#000000" size="2">Detail</font></td>      
    </tr>         
    
        <%        
      
for i=1 to rs.recordcount
 %>           
  <tr>   
     <td height="20" bgcolor="#F7F3FF"><font size="1" ><%=rs("scientific_name")%></font></td>       
     <td height="20" bgcolor="#F7F3FF"><font size="1" ><%=rs("date")%></font></td>   
     <td height="20" bgcolor="#F7F3FF"><font size="1" ><%=rs("locality")%></font></td>   
     <td height="20" bgcolor="#F7F3FF"><font size="1" ><%=rs("latitude")%></font></td>   
     <td height="20" bgcolor="#F7F3FF"><font size="1" ><%=rs("longitude")%></font></td>   
     <td height="20" bgcolor="#F7F3FF"><font size="1" ><%=rs("minimum_depth")%>-<%=rs("maximum_depth")%></font></td>   
     <td height="20" bgcolor="#F7F3FF"><font size="1" ><%=rs("collector")%></font></td>   
      <%      
     plink="data_detail.asp?record_id=" & rs("record_id")
     %>
     <td height="20" align="center" bgcolor="#F7F3FF"><a href="<%=plink%>"><font size="1" ><img border="0" src="../images/smallearth.gif" width="22" height="15" align="center"></font></a></td>   
   </tr>        
 <%         
   rs.movenext        
  if rs.eof then exit for      
  next        
    %>        
  </table>       


  </font>

</td></tr></table>
</body>

</html>