<!--#include file="conn.asp "-->
<!--#include file="changeunicode.asp"-->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<meta name="GENERATOR" content="Microsoft FrontPage 6.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title></title>
<title></title>
<STYLE TYPE="text/css">
        <!-- body, th, td, input, select, textarea, select, checkbox {font:10pt Arial}
         a:link {font: 10pt "Arial"; text-decoration: none;color:none}
         a:visited      {font: 10pt "Arial"; text-decoration: none; color: 000000}
         a:active       {font: 10pt "Arial"; text-decoration: none; color: 00CC66}
         a:hover        {font: 10pt Arial; text-decoration: underline; color: ff0000}
        -->
   </STYLE>
<Script Language="JavaScript">
<!--
function clean()
{
if (document.form1.search.value=="Key Words"){document.form1.search.value=""}
}
//-->
</script>

</head>
<body>
<%            
porder=request("R1")
pcrit=request("D1")
if porder="" then porder="kingdom"
if porder="kingdom" then 
  pporder="kingdom,phylum,theclass,theorder,family,scientific_name"
  p11=" style='border: 1 ridge #B4B4B4'"
elseif porder="phylum" then 
  pporder="phylum,theclass,theorder,family,scientific_name"
  porderch="門名"
  p1=" style='border: 1 ridge #B4B4B4'"
elseif porder="theclass" then 
 pporder="theclass,theorder,family,scientific_name"
 porderch="綱名"
  p3=" style='border: 1 ridge #B4B4B4'"
elseif porder="theorder" then
 pporder="theclass,theorder,family,scientific_name"
 porderch="目名"
  p5=" style='border: 1 ridge #B4B4B4'"
elseif porder="family" then
 pporder="family,scientific_name"
 porderch="科名"
  p7=" style='border: 1 ridge #B4B4B4'"
elseif porder="scientific_name" then
 pporder="scientific_name"
 porderch="學名"
  p9=" style='border: 1 ridge #B4B4B4'"
elseif porder="phylum_c" then
 pporder="phylum_c,class_c,order_c,family_c,scientific_name"
 porderch="門中文名"
  p2=" style='border: 1 ridge #B4B4B4'"
elseif porder="class_c" then
 pporder="class_c,order_c,family_c,scientific_name"
 porderch="綱中文名"
  p4=" style='border: 1 ridge #B4B4B4'"
elseif porder="order_c" then
 pporder="order_c,family_c,scientific_name"
 porderch="目中文名"
  p6=" style='border: 1 ridge #B4B4B4'"
elseif porder="family_c" then
 pporder="family_c,scientific_name"
 porderch="科中文名"
  p8=" style='border: 1 ridge #B4B4B4'"
elseif porder="chinese" then
 pporder="chinese"
 porderch="中文名"
  p10=" style='border: 1 ridge #B4B4B4'"
elseif porder="total" then
 pporder="total"
 porderch="筆數"
  p11=" style='border: 1 ridge #B4B4B4'"
end if  
if pcrit=""  then pcrit="Plantae"
if pcrit="Animalia" then ch1="selected"
if pcrit="Plantae" then ch2="selected"
if pcrit="Fungi" then ch3="selected"
if pcrit="Protista" then ch4="selected"
if pcrit="Monera" then ch5="selected"
if pcrit="all" then ch6="selected"
key=trim(request("search"))
if key="" then
 sql="SELECT * from view_wlspecies order by " & pporder
else
 sql="SELECT * from view_wlspecies where phylum_c like '%" & key & "%' or phylum like '%" & key & "%' or class_c like '%" & key & "%' or theclass like '%" & key & "%' or order_c like '%" & key & "%' or theorder like '%" & key & "%' or family_c like '%" & key & "%' or family like '%" & key & "%' or scientific_name like '%" & key & "%' or chinese like '%" & key & "%' order by " & pporder
end if 
rs.open sql ,conn ,1,1 
if rs.eof then 
 response.write "Not Found Records for Key Word:[" & key & "]"              
 response.end
end if 

if request("pagesize") <>"" then
 rs.pagesize=request("pagesize")
else
 rs.pagesize=20
end if
pagesize=rs.pagesize 
pagecount=rs.pagecount
page=clng(request("page"))
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
<form name="form1" action="speciesList.asp">
<center>
  <%if key="" then%>
  <font size="4" color="#393939"><B><%=rs.recordcount%> Species Organism in All Stations</B></font>
  <%else%>
  <font size="4" color="#393939"><B><%=rs.recordcount%> Records for Key Word:[<%=key%>]</font>&nbsp;&nbsp;&nbsp;
  <%end if%>
  <input type="text" onclick=clean() name="search" size="11" value="Key Words" style="color: #666666"><input type="submit" value="搜尋" name="sent" style="font-size: 8pt; position: relative; width: 35; height: 25; left: 1; top: 0; letter-spacing: 1">
  <center><A HREF="http://wlterm.biodiv.sinica.edu.tw/english/specieslist.asp?page=1&R1=<%=porder%>&D1=<%=pcrit%>&pagesize=<%=pagesize%>"><img border="0"  src="../images/first.gif" ALT="第一頁"></a>&nbsp;    
  <% if group > 1 then %>                   
  <A HREF="http://wlterm.biodiv.sinica.edu.tw/english/specieslist.asp?page=<%=(page-10)%>&R1=<%=porder%>&D1=<%=pcrit%>&pagesize=<%=pagesize%>"><img border="0"  src="../images/previous10.gif" ALT="上10頁"></a>&nbsp;                                                    
   <% else %>               
  <img border="0"  src="../images/previous10dis.gif" ALT="上10頁(失效)">&nbsp;                                                    
   <% end if %>                  
    <A HREF="http://wlterm.biodiv.sinica.edu.tw/english/specieslist.asp?page=<%=(page-1)%>&R1=<%=porder%>&D1=<%=pcrit%>&pagesize=<%=pagesize%>"><img border="0"  src="../images/previous.gif" ALT="上一頁"></a>&nbsp;                                                    
<A HREF="http://wlterm.biodiv.sinica.edu.tw/english/specieslist.asp?page=<%=(page+1)%>&R1=<%=porder%>&D1=<%=pcrit%>&pagesize=<%=pagesize%>"><img border="0"  src="../images/next.gif" ALT="下一頁"></a>&nbsp;                                                     
   <% if group < (pgroup*10+1) then %>                  
<A HREF="http://wlterm.biodiv.sinica.edu.tw/english/specieslist.asp?page=<%=(page+10)%>&R1=<%=porder%>&D1=<%=pcrit%>&pagesize=<%=pagesize%>"><img border="0"  src="../images/next10.gif" ALT="下10頁"></a>&nbsp;                                                     
   <% else %>               
<img border="0"  src="../images/next10dis.gif" ALT="下10頁(失效)">&nbsp;                                                     
  <% end if %>                 
  <A HREF="http://wlterm.biodiv.sinica.edu.tw/english/specieslist.asp?page=<%=pagecount%>&R1=<%=porder%>&D1=<%=pcrit%>&pagesize=<%=pagesize%>"><img border="0"  src="../images/last.gif" ALT="最後一頁"></a>&nbsp;&nbsp;          
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
<A HREF="http://wlterm.biodiv.sinica.edu.tw/english/specieslist.asp?page=<%=i%>&R1=<%=porder%>&D1=<%=pcrit%>&pagesize=<%=pagesize%>"><font size="2" color="<%=icolor%>"><%=ibold%><%=i%><%=ibold2%></font></a>                                                
<%                                                   
next                 
                      
%>                 
  <font size="2"><font   size="2" >Page:<%=page%>/<%=pagecount%>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Page size:<input type="text" name="pagesize" size="1" value="<%=pagesize%>" style="font-size: 9pt; position: relative; width: 25; height: 19"></font><input type="submit" value="change" name="sent" style="color: #ff0000; font-size: 12px; background-color: #FFFFFF; vertical-align: -1; width: 45; height: 20" color="#000080">&nbsp;&nbsp;                    
 
<table border="1" height="49" cellspacing="1" cellpadding="2">         
   <tr>         
    <td bgcolor="#D6D7D6"><img border="0" src="../images/bg03-2.gif"></td>  
   </font>  
</font>
    <td bgcolor="#D6D7D6" height="17" align="center" nowrap><font   color="#000000" size="2">&nbsp;&nbsp;Kingdom&nbsp;&nbsp<a href="http://wlterm.biodiv.sinica.edu.tw/english/specieslist.asp?page=<%=page%>&R1=kingdom&D1=<%=pcrit%>&pagesize=<%=pagesize%>"><img border="0" src="../images/arrow.gif" align="absmiddle" hspace="2" vspace="2" alt="排序" <%=p11%>></a></font></td>         
    <td bgcolor="#D6D7D6" height="17" align="center" nowrap><font   color="#000000" size="2">&nbsp;&nbsp;Phylum&nbsp;&nbsp;<a href="http://wlterm.biodiv.sinica.edu.tw/english/specieslist.asp?page=<%=page%>&R1=phylum&D1=<%=pcrit%>&pagesize=<%=pagesize%>"><img border="0" src="../images/arrow.gif" align="absmiddle" hspace="2" vspace="2" alt="排序" <%=p2%>></a></font></td>         
    <td bgcolor="#D6D7D6" height="17" align="center" nowrap><font   color="#000000" size="2">&nbsp;&nbsp;Class&nbsp;&nbsp;<a href="http://wlterm.biodiv.sinica.edu.tw/english/specieslist.asp?page=<%=page%>&R1=theclass&D1=<%=pcrit%>&pagesize=<%=pagesize%>"><img border="0" src="../images/arrow.gif" align="absmiddle" hspace="2" vspace="2" alt="排序" <%=p3%>></a></font></td>         
    <td bgcolor="#D6D7D6" height="17" align="center" nowrap><font   color="#000000" size="2">&nbsp;&nbsp;Order&nbsp;&nbsp;<a href="http://wlterm.biodiv.sinica.edu.tw/english/specieslist.asp?page=<%=page%>&R1=theorder&D1=<%=pcrit%>&pagesize=<%=pagesize%>"><img border="0" src="../images/arrow.gif" align="absmiddle" hspace="2" vspace="2" alt="排序" <%=p5%>></a></font></td>      
    <td bgcolor="#D6D7D6" height="17" align="center" nowrap><font   color="#000000" size="2">&nbsp;&nbsp;Family&nbsp;&nbsp;<a href="http://wlterm.biodiv.sinica.edu.tw/english/specieslist.asp?page=<%=page%>&R1=family&D1=<%=pcrit%>&pagesize=<%=pagesize%>"><img border="0" src="../images/arrow.gif" align="absmiddle" hspace="2" vspace="2" alt="排序" <%=p7%>></a></font></td>      
    <td bgcolor="#D6D7D6" height="17" align="center" nowrap><font   color="#000000" size="2">&nbsp;&nbsp;Scientific Name&nbsp;&nbsp;<a href="http://wlterm.biodiv.sinica.edu.tw/english/specieslist.asp?page=<%=page%>&R1=scientific_name&D1=<%=pcrit%>&pagesize=<%=pagesize%>"><img border="0" src="../images/arrow.gif" align="absmiddle" hspace="2" vspace="2" alt="排序" <%=p9%>></a></font></td>      
    <td bgcolor="#D6D7D6" height="17" align="center" nowrap><font   color="#000000" size="2">Total<a href="http://wlterm.biodiv.sinica.edu.tw/english/specieslist.asp?page=<%=page%>&R1=total&D1=<%=pcrit%>&pagesize=<%=pagesize%>"><img border="0" src="../images/arrow.gif" align="absmiddle" vspace="2" hspace="2" alt="排序" <%=p11%>></a></font></td>      
    </tr>         
    
        <%        
rs.absolutepage=page               
for i=1 to rs.pagesize    
 %>           
  <tr>   
     <td bgcolor="#F7F3FF"><img border="0" src="../images/bg03-2.gif"></td>  
     <td height="20" bgcolor="#F7F3FF"><font size="1" ><%=rs("Kingdom")%></font></td>       
     <td height="20" bgcolor="#F7F3FF"><font size="1" ><%=rs("phylum")%></font></td>       
     <td height="20" bgcolor="#F7F3FF"><font size="1" ><%=rs("theclass")%></font></td>   
     <td height="20" bgcolor="#F7F3FF"><font size="1" ><%=rs("theorder")%></font></td>   
     <td height="20" bgcolor="#F7F3FF"><font size="1" ><%=rs("family")%></font></td>   
      <%      
     plink="specieslist2.asp?science=" & rs("scientific_name")
     %>
     <td height="20" bgcolor="#F7F3FF"><font size="1" ><i><a href="<%=plink%>"><%=rs("scientific_name")%></a></i></font></td>   
     <td height="20" bgcolor="#F7F3FF" align=center><font size="1" ><a href="<%=plink%>"><%=rs("total")%></a></font></td>   
     
   </tr>        
 <%         
   rs.movenext        
  if rs.eof then exit for      
  next        
    %>        
  </table>       
   <p style="margin-top: 3">       
 <font  size="2" color="#800000">      
    <A HREF="http://wlterm.biodiv.sinica.edu.tw/english/specieslist.asp?page=1&R1=<%=porder%>&D1=<%=pcrit%>&pagesize=<%=pagesize%>"><img border="0"  src="../images/first.gif" ALT="第一頁" align="absmiddle" hspace="3" vspace="1"></a>              
    <% if group > 1 then %>                       
  <A HREF="http://wlterm.biodiv.sinica.edu.tw/english/specieslist.asp?page=<%=(page-10)%>&R1=<%=porder%>&D1=<%=pcrit%>&pagesize=<%=pagesize%>"><img border="0"  src="../images/previous10.gif" ALT="上10頁" align="absmiddle" hspace="3" vspace="1"></a>                                    
   <% else %>                     
  <img border="0"  src="../images/previous10dis.gif" ALT="上10頁" align="absmiddle" hspace="3" vspace="1">                                    
   <% end if %>                        
    <A HREF="taibnet_species_list.asp?page=<%=(page-1)%>&R1=<%=porder%>&D1=<%=pcrit%>&pagesize=<%=pagesize%>"><img border="0"  src="../images/previous.gif" ALT="上一頁" align="absmiddle" hspace="3" vspace="1"></a>                                    
<A HREF="http://wlterm.biodiv.sinica.edu.tw/english/specieslist.asp?page=<%=(page+1)%>&R1=<%=porder%>&D1=<%=pcrit%>&pagesize=<%=pagesize%>"><img border="0"  src="../images/next.gif" ALT="下一頁" align="absmiddle" hspace="3" vspace="1"></a>                                     
   <% if group < (pgroup*10+1) then %>                   
<A HREF="http://wlterm.biodiv.sinica.edu.tw/english/specieslist.asp?page=<%=(page+10)%>&R1=<%=porder%>&D1=<%=pcrit%>&pagesize=<%=pagesize%>"><img border="0"  src="../images/next10.gif" ALT="下10頁" align="absmiddle" hspace="3" vspace="1"></a>                                     
   <% else %>                     
<img border="0"  src="../images/next10dis.gif" ALT="下10頁" align="absmiddle" hspace="3" vspace="1">                                     
  <% end if %>                       
  <A HREF="http://wlterm.biodiv.sinica.edu.tw/english/specieslist.asp?page=<%=pagecount%>&R1=<%=porder%>&D1=<%=pcrit%>&pagesize=<%=pagesize%>"><img border="0"  src="../images/last.gif" ALT="最後一頁" align="absmiddle" hspace="3" vspace="1"></a>              
  </center>
</font>
 <p style="margin-top: 3" align="center"><font size="2">Jump to page:</font><font size="2"><input type="text" name="page" size="5" style="font-size: 10pt; position: relative; width: 40; height: 20" value="1"></font><font size="2"><input type="submit" value="jump" name="B1" style="font-size: 8pt; position: relative; width: 50; height: 22; left: 1; top: 0; letter-spacing: 3"></p>
 <input type="hidden" name="R1" value="<%=porder%>">
 <input type="hidden" name="D1" value="<%=pcrit%>">
 <input type="hidden" name="PI" value="<%=PI%>">

</form>


  </center>


  </font>
</td></tr></table>

</body>

</html>