CREATE OR REPLACE FUNCTION fy_startf ( umon in number, uyr in number)
RETURN date 
IS
temp char(20);
last_date date;
fm_strt date;
BEGIN
  temp := umon || '-' || uyr;
  last_date := last_day(to_date(temp,'mm-yyyy'));
  temp:=to_char(last_date,'DY') ;
  IF temp = 'SUN'
   THEN
    fm_strt:= last_date + interval '0' day;
    ELSIF temp = 'MON' THEN
    fm_strt:= last_date + interval '-1' day;
   ELSIF temp = 'TUE' THEN
    fm_strt:= last_date + interval '-2' day;
   ELSIF temp = 'WED' THEN
    fm_strt:= last_date + interval '-3' day;
   ELSIF temp = 'THU' THEN
    fm_strt:= last_date + interval '-4' day;
   ELSIF temp = 'FRI' THEN
    fm_strt:= last_date + interval '-5' day;
   ELSIF temp = 'SAT' THEN
    fm_strt:= last_date + interval '-6' day;
   END IF;
   return fm_strt;    
END;
/
