CREATE OR REPLACE PROCEDURE FISCAL1 (uyr IN number)
IS

s_day date;e_day date;umon number;temp date;eofm date;eofq date;s_dayd number;s_daym number;s_dayy number;s_dayt number;s_days number;
f1 number;f2 number;f3 number;f4 number;f5 number;f6 number;f7 number;f8 number;f9 number;f10 number;f11 number;f12 number;f13 number;f14 number;f15 number;f16 number;
temp1 number;fmdesc char(20);fqdesc char(20);fqnum int;fqwn int;fqmwn int;difm number;difq number;wk number;

BEGIN
umon := 03;wk :=0;f2 :=0;f3 :=0;f5 :=0;f6 :=0;f7 :=0;f8:=0;f9:=0;f10:=0;f11:=0;f12:=0;f13:=0;f14:=0;f15:=0;f16:=0;
  delete az_fiscal1;
  s_day := fy_startf(umon,uyr);
  s_day := s_day + interval '1' day;
  e_day := fy_startf(umon,uyr+1) + interval '1' day;
  temp := s_day;
 
  WHILE s_day < e_day
  LOOP
  s_dayd := extract (day from s_day);
  s_daym := extract (month from s_day);
  s_dayy := extract (year from s_day);




  
  func1(s_day,s_daym,s_dayy,uyr,eofm);
  func2(s_day,f1,f2,eofm,f3,wk,7,f7); 
  func2(s_day,f4,f5,eofm,f6,difm,1,temp1);
  fmdesc := to_char( uyr||'-'||f7);
  fqnum := ceil(f7/3);
  fqdesc := to_char(uyr ||'-'||fqnum);
   if s_daym <= umon+(3*fqnum) and fqnum<=3 then
     eofq := fy_startf(umon+(3*fqnum),uyr);
     elsif fqnum = 4 then
     eofq := fy_startf(umon,uyr+1);  
     end if;
   func2(s_day,f8,f9,eofq,f10,difq,1,temp1);
   func2(s_day,f11,f12,eofq,f13,fqmwn,7,temp1);
   func2(s_day,f14,f15,e_day,f16,fqwn,7,temp1);

 insert into az_fiscal1(time_id,
		dayname,
		fm_name,
		fy_strt,
 	                      fy_end,
                                          end_of_fm,
                        	fw_number,
	                     day_in_fm,
  		fm_number,
		fm_desc ,
                     		fq_desc,
	                     fq_number,
	                     end_of_fq,
                     		fyw_number,
		day_in_fq,
                                           fqw_number
                        ) 
	 values(
		s_day,
		to_char(s_day,'DY'),
		to_char(s_day,'MON'),
	                      to_date(temp),
	 	to_date(e_day),
                     		eofm,
    		wk,
	                     difm,
		f7,
		fmdesc,
		fqdesc,
    		fqnum,
 		eofq,
                        	fqwn,
	                    difq,
		fqmwn
	      );
  s_day := s_day + interval '1' day;
  END LOOP;
END;
/
