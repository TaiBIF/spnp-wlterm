<!--#include file="conn.asp "-->
<html>
<head>
<meta name="GENERATOR" content="Microsoft FrontPage 6.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>WQ</title>
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
porder=request("R1")
pcrit=request("D1")
PI=request("PI")
if PI="3" then
   PIN="Water Quality"
elseif PI="4" then
   PIN="Nitrate"
elseif PI="1" then
   PIN="Alage Detritus"
elseif PI="13" then
   PIN="Water Elements"
end if   
if pcrit="ALL" then
 ppcrit="ALL Stations"
else
 ppcrit="St:" & pcrit    
end if 

if porder="" then porder="station.id"
if porder="station.id" then 
  p1=" style='border: 1 ridge #B4B4B4'"
  pporder="station.id,date"
elseif porder="locality_chinese" then 
  p2=" style='border: 1 ridge #B4B4B4'"
  pporder="locality_chinese,date"
elseif porder="latitude" then
  p3=" style='border: 1 ridge #B4B4B4'"
  pporder="latitude,date"
elseif porder="longitude" then
  p4=" style='border: 1 ridge #B4B4B4'"
  pporder="longitude,date"
elseif porder="Minimum_Elevation" then
  p5=" style='border: 1 ridge #B4B4B4'"
  pporder="Minimum_Elevation,date"
elseif porder="Minimum_depth" then
  p6=" style='border: 1 ridge #B4B4B4'"
  pporder="Minimum_depth,date"
elseif porder="collector_chinese" then
  p7=" style='border: 1 ridge #B4B4B4'"
  pporder="collector_chinese,date"
elseif porder="date" then
  p8=" style='border: 1 ridge #B4B4B4'"
  pporder="date,station.id"
end if 
if PI="3" then 
 if pcrit <> "ALL" then
  sql="SELECT water.*, Station.* FROM water INNER JOIN Station ON water.id = Station.id where Station.id=" & pcrit & " and  project_id=3 order by " & pporder
 else
  sql="SELECT water.*, Station.* FROM water INNER JOIN Station ON water.id = Station.id"  & " where project_id=3 order by " & pporder
 end if 
elseif PI="4" then
 if pcrit <> "ALL" then
  sql="SELECT water.*, Station.* FROM water INNER JOIN Station ON water.id = Station.id where Station.id=" & pcrit & " and  project_id=4 order by " & pporder
 else
  sql="SELECT water.*, Station.* FROM water INNER JOIN Station ON water.id = Station.id"  & " where project_id=4 order by " & pporder
 end if 
elseif PI="13" then
 if pcrit <> "ALL" then
  sql="SELECT water.*, Station.* FROM water INNER JOIN Station ON water.id = Station.id where Station.id=" & pcrit & " and  project_id=13 order by " & pporder
 else
  sql="SELECT water.*, Station.* FROM water INNER JOIN Station ON water.id = Station.id"  & " where project_id=13 order by " & pporder
 end if 
elseif PI="1" then
 if pcrit <> "ALL" then
  sql="SELECT alage.*, Station.* FROM alage INNER JOIN Station ON alage.id = Station.id where Station.id=" & pcrit & " and  project_id=1 order by " & pporder
 else
  sql="SELECT alage.*, Station.* FROM alage INNER JOIN Station ON alage.id = Station.id"  & " where project_id=1 order by " & pporder
 end if 
end if 
rs.open sql ,conn ,1,1 
if rs.eof then
 response.write "<center>Not Foind !</center>"
 response.end
end if 
if request("pagesize") <>"" then
 rs.pagesize=request("pagesize")
else
 rs.pagesize=20
end if
pagesize=rs.pagesize 
pagecount=rs.pagecount
page=cint(request("page"))
plen=len(cstr(page-1))-1
group=clng(mid(cstr(page-1),1,plen) & "1")
pgroup=int(pagecount/10)
if page < 11 then group=1
if page < 1  then page=1
if page > pagecount then page=pagecount
if group < 1 then group=1
if group > pagecount then group=pagecount

%> 
<table border=0 cellpadding=0 cellspacing=0><tr><td>
<form name="form1" action="WaterQ.asp">
  <center><font size="4" color="#393939"><B><%=ppcrit%>&nbsp;<%=PIN%>&nbsp;Records</B></font>
   <a href="../LocalMapE.asp?id=<%=pcrit%>&pid=<%=PI%>"><img border="0" src="../images/googlemap.gif" align="absmiddle"></a>

  <center><A HREF="http://wlterm.biodiv.sinica.edu.tw/english/WaterQ.asp?page=1&R1=<%=porder%>&D1=<%=pcrit%>&pagesize=<%=pagesize%>&PI=<%=PI%>"><img border="0"  src="../images/first.gif" ALT="第一頁"></a>&nbsp;    
  <% if group > 1 then %>                   
  <A HREF="http://wlterm.biodiv.sinica.edu.tw/english/WaterQ.asp?page=<%=(page-10)%>&R1=<%=porder%>&D1=<%=pcrit%>&pagesize=<%=pagesize%>&PI=<%=PI%>"><img border="0"  src="../images/previous10.gif" ALT="上10頁"></a>&nbsp;                                                    
   <% else %>               
  <img border="0"  src="../images/previous10dis.gif" ALT="上10頁(失效)">&nbsp;                                                    
   <% end if %>                  
    <A HREF="http://wlterm.biodiv.sinica.edu.tw/english/WaterQ.asp?page=<%=(page-1)%>&R1=<%=porder%>&D1=<%=pcrit%>&pagesize=<%=pagesize%>&PI=<%=PI%>"><img border="0"  src="../images/previous.gif" ALT="上一頁"></a>&nbsp;                                                    
<A HREF="http://wlterm.biodiv.sinica.edu.tw/english/WaterQ.asp?page=<%=(page+1)%>&R1=<%=porder%>&D1=<%=pcrit%>&pagesize=<%=pagesize%>&PI=<%=PI%>"><img border="0"  src="../images/next.gif" ALT="下一頁"></a>&nbsp;                                                     
   <% if group < (pgroup*10+1) then %>                  
<A HREF="http://wlterm.biodiv.sinica.edu.tw/english/WaterQ.asp?page=<%=(page+10)%>&R1=<%=porder%>&D1=<%=pcrit%>&pagesize=<%=pagesize%>&PI=<%=PI%>"><img border="0"  src="../images/next10.gif" ALT="下10頁"></a>&nbsp;                                                     
   <% else %>               
<img border="0"  src="../images/next10dis.gif" ALT="下10頁(失效)">&nbsp;                                                     
  <% end if %>                 
  <A HREF="http://wlterm.biodiv.sinica.edu.tw/english/WaterQ.asp?page=<%=pagecount%>&R1=<%=porder%>&D1=<%=pcrit%>&pagesize=<%=pagesize%>&PI=<%=PI%>"><img border="0"  src="../images/last.gif" ALT="最後一頁"></a>&nbsp;&nbsp;          
  <font size="2"><%                  
for i=group to group+9                      
 if i > pagecount then exit for
    if i=page then 
     icolor="#FF0000"
     ibold="<B>"
     ibold2="</B>"
    else
     icolor=""
     ibold=""
     ibold2=""
    end if                 
%>                         
<A HREF="http://wlterm.biodiv.sinica.edu.tw/english/WaterQ.asp?page=<%=i%>&R1=<%=porder%>&D1=<%=pcrit%>&pagesize=<%=pagesize%>&PI=<%=PI%>"><font size="2" color="<%=icolor%>"><%=ibold%><%=i%><%=ibold2%></font></a>                                                
<%                                                   
next                 
                      
%>                 
  <font size="2"><font  size="2" >Page:&nbsp;<%=page%>/<%=pagecount%>&nbsp;&nbsp;&nbsp;Total: <%=rs.recordcount%>records&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Page size:<input type="text" name="pagesize" size="1" value="<%=pagesize%>" style="font-size: 9pt; position: relative; width: 25; height: 19"></font><input type="submit" value="change" name="sent" style="color: #ff0000; font-size: 12px; background-color: #FFFFFF; vertical-align: -1; width: 45; height: 20" color="#000080">&nbsp;&nbsp;                    
 
<table border="1" height="49" cellspacing="1" cellpadding="2">         
   <tr>         
    <td bgcolor="#D6D7D6"><img border="0" src="../images/bg03-2.gif"></td>  
   </font>  
</font>
    <td bgcolor="#D6D7D6" height="17" align="center" nowrap><font  color="#000000" size="2">St<a href="http://wlterm.biodiv.sinica.edu.tw/english/WaterQ.asp?page=<%=page%>&R1=station.id&D1=<%=pcrit%>&pagesize=<%=pagesize%>&PI=<%=PI%>"></font><img border="0" src="../images/arrow.gif" align="absmiddle" hspace="2" vspace="2" alt="排序" <%=p1%>></a></td>         
    <td bgcolor="#D6D7D6" height="17" align="center" nowrap><font  color="#000000" size="2">St. Name<a href="http://wlterm.biodiv.sinica.edu.tw/english/WaterQ.asp?page=<%=page%>&R1=locality_chinese&D1=<%=pcrit%>&pagesize=<%=pagesize%>&PI=<%=PI%>"></font><img border="0" src="../images/arrow.gif" align="absmiddle" hspace="2" vspace="2" alt="排序" <%=p2%>></a></td>         
    <td bgcolor="#D6D7D6" height="17" align="center" nowrap><font  color="#000000" size="2">latitude<a href="http://wlterm.biodiv.sinica.edu.tw/english/WaterQ.asp?page=<%=page%>&R1=latitude&D1=<%=pcrit%>&pagesize=<%=pagesize%>&PI=<%=PI%>"></font><img border="0" src="../images/arrow.gif" align="absmiddle" hspace="2" vspace="2" alt="排序" <%=p3%>></a></td>         
    <td bgcolor="#D6D7D6" height="17" align="center" nowrap><font  color="#000000" size="2">longitude<a href="http://wlterm.biodiv.sinica.edu.tw/english/WaterQ.asp?page=<%=page%>&R1=longitude&D1=<%=pcrit%>&pagesize=<%=pagesize%>&PI=<%=PI%>"></font><img border="0" src="../images/arrow.gif" align="absmiddle" hspace="2" vspace="2" alt="排序" <%=p4%>></a></td>      
    <td bgcolor="#D6D7D6" height="17" align="center" nowrap><font  color="#000000" size="2">Elevation<a href="http://wlterm.biodiv.sinica.edu.tw/english/WaterQ.asp?page=<%=page%>&R1=Minimum_Elevation&D1=<%=pcrit%>&pagesize=<%=pagesize%>&PI=<%=PI%>"></font><img border="0" src="../images/arrow.gif" align="absmiddle" hspace="2" vspace="2" alt="排序" <%=p5%>></a></td>         
    <td bgcolor="#D6D7D6" height="17" align="center" nowrap><font  color="#000000" size="2">Depth<a href="http://wlterm.biodiv.sinica.edu.tw/english/WaterQ.asp?page=<%=page%>&R1=Minimum_depth&D1=<%=pcrit%>&pagesize=<%=pagesize%>&PI=<%=PI%>"></font><img border="0" src="../images/arrow.gif" align="absmiddle" hspace="2" vspace="2" alt="排序" <%=p6%>></a></td>      
    <td bgcolor="#D6D7D6" height="17" align="center" nowrap><font  color="#000000" size="2">Collector<a href="http://wlterm.biodiv.sinica.edu.tw/english/WaterQ.asp?page=<%=page%>&R1=collector_chinese&D1=<%=pcrit%>&pagesize=<%=pagesize%>&PI=<%=PI%>"></font><img border="0" src="../images/arrow.gif" align="absmiddle" hspace="2" vspace="2" alt="排序" <%=p7%>></a></td>      
    <td bgcolor="#D6D7D6" height="17" align="center" nowrap><font  color="#000000" size="2">Date<a href="http://wlterm.biodiv.sinica.edu.tw/english/WaterQ.asp?page=<%=page%>&R1=date&D1=<%=pcrit%>&pagesize=<%=pagesize%>&PI=<%=PI%>"></font><img border="0" src="../images/arrow.gif" align="absmiddle" hspace="2" vspace="2" alt="排序" <%=p8%>></a></td>      
    <td bgcolor="#D6D7D6" height="17" align="center" nowrap><font  color="#000000" size="2">Query</font></td>      
    </tr>         
    
        <%        
rs.absolutepage=page               
for i=1 to rs.pagesize    
 %>           
  <tr>   
     <td bgcolor="#F7F3FF"><img border="0" src="../images/bg03-2.gif"></td>  
     <td height="20" align="center" bgcolor="#F7F3FF"><font size="1" ><%=rs("station.id")%></font></td>       
     <td height="20" bgcolor="#F7F3FF"><font size="1" ><%=rs("locality")%></font></td>   
     <td height="20" bgcolor="#F7F3FF"><font size="1" ><%=rs("latitude")%></font></td>   
     <td height="20" bgcolor="#F7F3FF"><font size="1" ><%=rs("longitude")%></font></td>   
     <td height="20" bgcolor="#F7F3FF"><font size="1" ><%=rs("Minimum_Elevation")%> - <%=rs("Maximum_Elevation")%> M</font></td>   
     <td height="20" bgcolor="#F7F3FF"><font size="1" ><%=rs("Minimum_Depth")%> - <%=rs("Maximum_Depth")%> M</font></td>   
     <td height="20" bgcolor="#F7F3FF"><font size="1" ><%=rs("collector")%></font></td>   
     <td height="20" bgcolor="#F7F3FF"><font size="1" ><%=rs("date")%></font></td>   
     <td height="20" align="center" bgcolor="#F7F3FF"><a href="WaterQ2.asp?record_id=<%=rs("record_id")%>&PI=<%=PI%>"><img border="0" src="../images/smallearth.gif" width="22" height="15"></a></td>   
   </tr>        
 <%         
   rs.movenext        
  if rs.eof then exit for      
  next        
    %>        
  </table>       
   <p style="margin-top: 3">       
 <font  size="2" color="#800000">      
    <A HREF="http://wlterm.biodiv.sinica.edu.tw/english/WaterQ.asp?page=1&R1=<%=porder%>&D1=<%=pcrit%>&pagesize=<%=pagesize%>&PI=<%=PI%>"><img border="0"  src="../images/first.gif" ALT="第一頁" align="absmiddle" hspace="3" vspace="1"></a>              
    <% if group > 1 then %>                       
  <A HREF="http://wlterm.biodiv.sinica.edu.tw/english/WaterQ.asp?page=<%=(page-10)%>&R1=<%=porder%>&D1=<%=pcrit%>&pagesize=<%=pagesize%>&PI=<%=PI%>"><img border="0"  src="../images/previous10.gif" ALT="上10頁" align="absmiddle" hspace="3" vspace="1"></a>                                    
   <% else %>                     
  <img border="0"  src="../images/previous10dis.gif" ALT="上10頁" align="absmiddle" hspace="3" vspace="1">                                    
   <% end if %>                        
    <A HREF="taibnet_species_list.asp?page=<%=(page-1)%>&R1=<%=porder%>&D1=<%=pcrit%>&pagesize=<%=pagesize%>&PI=<%=PI%>"><img border="0"  src="../images/previous.gif" ALT="上一頁" align="absmiddle" hspace="3" vspace="1"></a>                                    
<A HREF="http://wlterm.biodiv.sinica.edu.tw/english/WaterQ.asp?page=<%=(page+1)%>&R1=<%=porder%>&D1=<%=pcrit%>&pagesize=<%=pagesize%>&PI=<%=PI%>"><img border="0"  src="../images/next.gif" ALT="下一頁" align="absmiddle" hspace="3" vspace="1"></a>                                     
   <% if group < (pgroup*10+1) then %>                   
<A HREF="http://wlterm.biodiv.sinica.edu.tw/english/WaterQ.asp?page=<%=(page+10)%>&R1=<%=porder%>&D1=<%=pcrit%>&pagesize=<%=pagesize%>&PI=<%=PI%>"><img border="0"  src="../images/next10.gif" ALT="下10頁" align="absmiddle" hspace="3" vspace="1"></a>                                     
   <% else %>                     
<img border="0"  src="../images/next10dis.gif" ALT="下10頁" align="absmiddle" hspace="3" vspace="1">                                     
  <% end if %>                       
  <A HREF="http://wlterm.biodiv.sinica.edu.tw/english/WaterQ.asp?page=<%=pagecount%>&R1=<%=porder%>&D1=<%=pcrit%>&pagesize=<%=pagesize%>&PI=<%=PI%>"><img border="0"  src="../images/last.gif" ALT="最後一頁" align="absmiddle" hspace="3" vspace="1"></a>              
  </center>
</font>
 <p style="margin-top: 3" align="center"><font size="2">Jump tp pgae: </font><font size="2"><input type="text" name="page" size="5" style="font-size: 10pt; position: relative; width: 40; height: 20" value="1"></font><font size="2"><input type="submit" value="jump" name="B1" style="font-size: 8pt; position: relative; width: 50; height: 22; left: 1; top: 0; letter-spacing: 3"></p>
 <input type="hidden" name="R1" value="<%=porder%>">
 <input type="hidden" name="D1" value="<%=pcrit%>">
 <input type="hidden" name="PI" value="<%=PI%>">
</form>


  </center>


  </font>
</td></tr></table>

</body>

</html>