CREATE OR REPLACE PROCEDURE func1 (s_day in date,s_daym IN number,s_dayy IN number,uyr in number,eofm out date)
IS
begin
  if s_daym = 3 and s_dayy = uyr
  then
  eofm := fy_startf(s_daym+1,s_dayy);
  else
  eofm := fy_startf(s_daym,s_dayy);
  end if;
  if s_day > eofm and s_daym != 12
  then
  eofm := fy_startf(s_daym+1,s_dayy);
  end if;
  if s_day > eofm and s_daym = 12
  then 
  eofm := fy_startf(1,uyr+1);
  end if;
end;
/