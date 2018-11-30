<!--#include file="conn.asp "-->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<meta name="GENERATOR" content="Microsoft FrontPage 6.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>WLTERM</title>
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
<body topmargin="5">
<%            
porder=request("R1")
pcrit=request("D1")
if pcrit="" then pcrit="ALL"
if pcrit="ALL" then
 ppcrit="All Station "
else
 ppcrit="St:" & pcrit    
end if 
if porder="" then porder="station.id"
if porder="station.id" then 
  p1=" style='border: 1 ridge #B4B4B4'"
  pporder="station.id,date"
elseif porder="locality" then 
  p2=" style='border: 1 ridge #B4B4B4'"
  pporder="locality,date"
elseif porder="date" then
  p3=" style='border: 1 ridge #B4B4B4'"
  pporder="date,station.id"
elseif porder="air" then
  p4=" style='border: 1 ridge #B4B4B4'"
  pporder="air desc"
elseif porder="water" then
  p5=" style='border: 1 ridge #B4B4B4'"
  pporder="water desc"
elseif porder="soil_0cm" then
  p6=" style='border: 1 ridge #B4B4B4'"
  pporder="soil_0cm desc"
elseif porder="soil_25cm" then
  p7=" style='border: 1 ridge #B4B4B4'"
  pporder="soil_25cm desc"
elseif porder="soil_50cm" then
  p8=" style='border: 1 ridge #B4B4B4'"
  pporder="date,station.id"
elseif porder="soil_65cm" then
  p9=" style='border: 1 ridge #B4B4B4'"
  pporder="soil_65cm desc"
elseif porder="soil_90cm" then
  p10=" style='border: 1 ridge #B4B4B4'"
  pporder="soil_90cm desc"
end if 
 if pcrit <> "ALL" then
  sql="SELECT temperature.*, Station.* FROM temperature INNER JOIN Station ON temperature.id = Station.id where Station.id=" & pcrit & "  order by " & pporder
 else
  sql="SELECT temperature.*, Station.* FROM temperature INNER JOIN Station ON temperature.id = Station.id"  & "  order by " & pporder
 end if 
rs.open sql ,conn ,1,1 
if rs.eof then
 response.write "<center>查無資料!</center>"
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
<form name="form1" action="Temperature.asp">
  <center><font size="4" color="#393939"><B><%=ppcrit%> Enviroment Temperature(Day Average)</B></font>
    <a href="LocalMap.asp?id=<%=pcrit%>&pid=14"><img border="0" src="../images/googlemap.gif" align="absmiddle"></a>
  </center>
  <center><A HREF="http://wlterm.biodiv.sinica.edu.tw/english/Temperature.asp?page=1&R1=<%=porder%>&D1=<%=pcrit%>&pagesize=<%=pagesize%>"><img border="0"  src="../images/first.gif" ALT="第一頁"></a>&nbsp;    
  <% if group > 1 then %>                   
  <A HREF="http://wlterm.biodiv.sinica.edu.tw/english/Temperature.asp?page=<%=(page-10)%>&R1=<%=porder%>&D1=<%=pcrit%>&pagesize=<%=pagesize%>"><img border="0"  src="../images/previous10.gif" ALT="上10頁"></a>&nbsp;                                                    
   <% else %>               
  <img border="0"  src="../images/previous10dis.gif" ALT="上10頁(失效)">&nbsp;                                                    
   <% end if %>                  
    <A HREF="http://wlterm.biodiv.sinica.edu.tw/english/Temperature.asp?page=<%=(page-1)%>&R1=<%=porder%>&D1=<%=pcrit%>&pagesize=<%=pagesize%>"><img border="0"  src="../images/previous.gif" ALT="上一頁"></a>&nbsp;                                                    
<A HREF="http://wlterm.biodiv.sinica.edu.tw/english/Temperature.asp?page=<%=(page+1)%>&R1=<%=porder%>&D1=<%=pcrit%>&pagesize=<%=pagesize%>"><img border="0"  src="../images/next.gif" ALT="下一頁"></a>&nbsp;                                                     
   <% if group < (pgroup*10+1) then %>                  
<A HREF="http://wlterm.biodiv.sinica.edu.tw/english/Temperature.asp?page=<%=(page+10)%>&R1=<%=porder%>&D1=<%=pcrit%>&pagesize=<%=pagesize%>"><img border="0"  src="../images/next10.gif" ALT="下10頁"></a>&nbsp;                                                     
   <% else %>               
<img border="0"  src="../images/next10dis.gif" ALT="下10頁(失效)">&nbsp;                                                     
  <% end if %>                 
  <A HREF="http://wlterm.biodiv.sinica.edu.tw/english/Temperature.asp?page=<%=pagecount%>&R1=<%=porder%>&D1=<%=pcrit%>&pagesize=<%=pagesize%>"><img border="0"  src="../images/last.gif" ALT="最後一頁"></a>&nbsp;&nbsp;          
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
<A HREF="http://wlterm.biodiv.sinica.edu.tw/english/Temperature.asp?page=<%=i%>&R1=<%=porder%>&D1=<%=pcrit%>&pagesize=<%=pagesize%>"><font size="2" color="<%=icolor%>"><%=ibold%><%=i%><%=ibold2%></font></a>                                                
<%                                                   
next                 
                      
%>                 
  <font size="2">　Page:<%=page%>/<%=pagecount%>&nbsp;&nbsp;&nbsp;&nbsp;Total:&nbsp;<%=rs.recordcount%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Page size:<input type="text" name="pagesize" size="1" value="<%=pagesize%>" style="font-size: 9pt; position: relative; width: 25; height: 19"></font><input type="submit" value="change" name="sent" style="color: #ff0000; font-size: 12px; background-color: #FFFFFF; vertical-align: -1; width: 55; height: 20" color="#000080">&nbsp;&nbsp;                    
 
<table border="1" height="49" cellspacing="1" cellpadding="2">         
   <tr>         
    <td bgcolor="#D6D7D6"><img border="0" src="../images/bg03-2.gif"></td>  
   </font>  
</font>
    <td bgcolor="#D6D7D6" height="17" align="center" nowrap><font face="細明體" color="#000000" size="1">ST<a href="http://wlterm.biodiv.sinica.edu.tw/english/Temperature.asp?page=<%=page%>&R1=station.id&D1=<%=pcrit%>&pagesize=<%=pagesize%>"></font><img border="0" src="../images/arrow.gif" align="absmiddle" hspace="2" vspace="2" alt="排序" <%=p1%>></a></td>         
    <td bgcolor="#D6D7D6" height="17" align="center" nowrap><font face="細明體" color="#000000" size="1">Locality<a href="http://wlterm.biodiv.sinica.edu.tw/english/Temperature.asp?page=<%=page%>&R1=locality&D1=<%=pcrit%>&pagesize=<%=pagesize%>"></font><img border="0" src="../images/arrow.gif" align="absmiddle" hspace="2" vspace="2" alt="排序" <%=p2%>></a></td>         
    <td bgcolor="#D6D7D6" height="17" align="center" nowrap><font face="細明體" color="#000000" size="1">Date<a href="http://wlterm.biodiv.sinica.edu.tw/english/Temperature.asp?page=<%=page%>&R1=date&D1=<%=pcrit%>&pagesize=<%=pagesize%>"></font><img border="0" src="../images/arrow.gif" align="absmiddle" hspace="2" vspace="2" alt="排序" <%=p3%>></a></td>      
    <td bgcolor="#D6D7D6" height="17" align="center" nowrap><font face="細明體" color="#000000" size="1">Air Temp.<a href="http://wlterm.biodiv.sinica.edu.tw/english/Temperature.asp?page=<%=page%>&R1=air&D1=<%=pcrit%>&pagesize=<%=pagesize%>"></font><img border="0" src="../images/arrow.gif" align="absmiddle" hspace="2" vspace="2" alt="排序" <%=p4%>></a></td>         
    <td bgcolor="#D6D7D6" height="17" align="center" nowrap><font face="細明體" color="#000000" size="1">Water Temp.<a href="http://wlterm.biodiv.sinica.edu.tw/english/Temperature.asp?page=<%=page%>&R1=water&D1=<%=pcrit%>&pagesize=<%=pagesize%>"></font><img border="0" src="../images/arrow.gif" align="absmiddle" hspace="2" vspace="2" alt="排序" <%=p5%>></a></td>      
    <td bgcolor="#D6D7D6" height="17" align="center" nowrap><font face="細明體" color="#000000" size="1">Soil surface<a href="http://wlterm.biodiv.sinica.edu.tw/english/Temperature.asp?page=<%=page%>&R1=soil_0cm&D1=<%=pcrit%>&pagesize=<%=pagesize%>"></font><img border="0" src="../images/arrow.gif" align="absmiddle" hspace="2" vspace="2" alt="排序" <%=p6%>></a></td>         
    <td bgcolor="#D6D7D6" height="17" align="center" nowrap><font face="細明體" color="#000000" size="1">Soil 25cm<a href="http://wlterm.biodiv.sinica.edu.tw/english/Temperature.asp?page=<%=page%>&R1=soil_25cm&D1=<%=pcrit%>&pagesize=<%=pagesize%>"></font><img border="0" src="../images/arrow.gif" align="absmiddle" hspace="2" vspace="2" alt="排序" <%=p7%>></a></td>      
    <td bgcolor="#D6D7D6" height="17" align="center" nowrap><font face="細明體" color="#000000" size="1">Soil 50cm<a href="http://wlterm.biodiv.sinica.edu.tw/english/Temperature.asp?page=<%=page%>&R1=soil_50cm&D1=<%=pcrit%>&pagesize=<%=pagesize%>"></font><img border="0" src="../images/arrow.gif" align="absmiddle" hspace="2" vspace="2" alt="排序" <%=p8%>></a></td>      
    <td bgcolor="#D6D7D6" height="17" align="center" nowrap><font face="細明體" color="#000000" size="1">Soil 65cm<a href="http://wlterm.biodiv.sinica.edu.tw/english/Temperature.asp?page=<%=page%>&R1=soil_65cm&D1=<%=pcrit%>&pagesize=<%=pagesize%>"></font><img border="0" src="../images/arrow.gif" align="absmiddle" hspace="2" vspace="2" alt="排序" <%=p9%>></a></td>      
    <td bgcolor="#D6D7D6" height="17" align="center" nowrap><font face="細明體" color="#000000" size="1">Soil 90cm<a href="http://wlterm.biodiv.sinica.edu.tw/english/Temperature.asp?page=<%=page%>&R1=soil_90cm&D1=<%=pcrit%>&pagesize=<%=pagesize%>"></font><img border="0" src="../images/arrow.gif" align="absmiddle" hspace="2" vspace="2" alt="排序" <%=p10%>></a></td>      
    <td bgcolor="#D6D7D6" height="17" align="center" nowrap><font face="細明體" color="#000000" size="1">xml</font></td>      
    </tr>         
    
        <%        
rs.absolutepage=page               
for i=1 to rs.pagesize    
 %>           
  <tr>   
     <td bgcolor="#F7F3FF"><img border="0" src="../images/bg03-2.gif"></td>  
     <td height="20" align="center" bgcolor="#F7F3FF"><font size="1" ><%=rs("station.id")%></font></td>       
     <td height="20" bgcolor="#F7F3FF"><font size="1" ><%=rs("locality")%></font></td>   
     <td height="20" bgcolor="#F7F3FF"><font size="1" ><%=rs("date")%></font></td>   
     <td height="20" bgcolor="#F7F3FF" align="center"><font size="1" ><%=rs("air")%>&nbsp;</font></td>   
     <td height="20" bgcolor="#F7F3FF" align="center"><font size="1" ><%=rs("water")%>&nbsp;</font></td>   
     <td height="20" bgcolor="#F7F3FF" align="center"><font size="1" ><%=rs("soil_0cm")%>&nbsp;</font></td>   
     <td height="20" bgcolor="#F7F3FF" align="center"><font size="1" ><%=rs("soil_25cm")%>&nbsp;</font></td>   
     <td height="20" bgcolor="#F7F3FF" align="center"><font size="1" ><%=rs("soil_50cm")%>&nbsp;</font></td>   
     <td height="20" bgcolor="#F7F3FF" align="center"><font size="1" ><%=rs("soil_65cm")%>&nbsp;</font></td>   
     <td height="20" bgcolor="#F7F3FF" align="center"><font size="1" ><%=rs("soil_90cm")%>&nbsp;</font></td>   
     <td height="20" align="center" bgcolor="#F7F3FF"><a href="XML/WLTERMTemp<%=rs("record_id")%>.xml"><img border="0" src="../images/smallearth.gif" width="22" height="15"></a></td>   
   </tr>        
 <%         
   rs.movenext        
  if rs.eof then exit for      
  next        
    %>        
  </table>       
   <p style="margin-top: 3">       
 <font face="新細明體" size="2" color="#800000">      
    <A HREF="http://wlterm.biodiv.sinica.edu.tw/english/Temperature.asp?page=1&R1=<%=porder%>&D1=<%=pcrit%>&pagesize=<%=pagesize%>"><img border="0"  src="../images/first_2.gif" ALT="第一頁" align="absmiddle" hspace="3" vspace="1"></a>              
    <% if group > 1 then %>                       
  <A HREF="http://wlterm.biodiv.sinica.edu.tw/english/Temperature.asp?page=<%=(page-10)%>&R1=<%=porder%>&D1=<%=pcrit%>&pagesize=<%=pagesize%>"><img border="0"  src="../images/previous10_2.gif" ALT="上10頁" align="absmiddle" hspace="3" vspace="1"></a>                                    
   <% else %>                     
  <img border="0"  src="../images/previous10dis_2.gif" ALT="上10頁" align="absmiddle" hspace="3" vspace="1">                                    
   <% end if %>                        
    <A HREF="http://wlterm.biodiv.sinica.edu.tw/english/Temperature.asp?page=<%=(page-1)%>&R1=<%=porder%>&D1=<%=pcrit%>&pagesize=<%=pagesize%>"><img border="0"  src="../images/previous_2.gif" ALT="上一頁" align="absmiddle" hspace="3" vspace="1"></a>                                    
<A HREF="http://wlterm.biodiv.sinica.edu.tw/english/Temperature.asp?page=<%=(page+1)%>&R1=<%=porder%>&D1=<%=pcrit%>&pagesize=<%=pagesize%>"><img border="0"  src="../images/next_2.gif" ALT="下一頁" align="absmiddle" hspace="3" vspace="1"></a>                                     
   <% if group < (pgroup*10+1) then %>                   
<A HREF="http://wlterm.biodiv.sinica.edu.tw/english/Temperature.asp?page=<%=(page+10)%>&R1=<%=porder%>&D1=<%=pcrit%>&pagesize=<%=pagesize%>"><img border="0"  src="../images/next10_2.gif" ALT="下10頁" align="absmiddle" hspace="3" vspace="1"></a>                                     
   <% else %>                     
<img border="0"  src="../images/next10dis_2.gif" ALT="下10頁" align="absmiddle" hspace="3" vspace="1">                                     
  <% end if %>                       
  <A HREF="http://wlterm.biodiv.sinica.edu.tw/english/Temperature.asp?page=<%=pagecount%>&R1=<%=porder%>&D1=<%=pcrit%>&pagesize=<%=pagesize%>"><img border="0"  src="../images/last_2.gif" ALT="最後一頁" align="absmiddle" hspace="3" vspace="1"></a>              
  </center>
</font>
 <p style="margin-top: 3" align="center"><font size="2">Jump to Page:<input type="text" name="page" size="5" style="font-size: 10pt; position: relative; width: 40; height: 20" value="1"></font><font size="2"><input type="submit" value="Jump" name="B1" style="font-size: 8pt; position: relative; width: 50; height: 22; left: 1; top: 0; letter-spacing: 3"></p>
 <input type="hidden" name="R1" value="<%=porder%>">
 <input type="hidden" name="D1" value="<%=pcrit%>">
</form>


  </center>


  </font>
</td></tr></table>

</body>

</html>