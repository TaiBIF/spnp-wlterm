<%
sub replunicode(strfont)
if not isnull(strfont) then
 while len(strfont) >3
  puni=mid(strfont,1,4)
  if puni > "E2B5" and puni < "E358" then %><img border=0 src='images\font\<%=puni%>.gif' align="texttop"><%else%>&#x<%=puni%>;<%
  end if
  strfont=mid(strfont,5)
 wend         
end if 
end sub        
%>