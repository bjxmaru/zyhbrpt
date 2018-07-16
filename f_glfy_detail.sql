
select subj_code  ,subj_name ,  disp_name , balanorient , 
       sum(localdebitamount)  debitamount , 
       sum(localcreditamount) creditamount , 
       sum(localdebitamount_last)  debitamount_last , 
       sum(localcreditamount_last) creditamount_last

from 
(
select ff.code  subj_code , ee.name subj_name , ee.dispname  disp_name , gg.balanorient, 
       decode( cc.yearv , parameter('begin_year_param') , 0 , decode(cc.periodv, '00', 0, cc.localdebitamount) ) localdebitamount,
       decode( cc.yearv , parameter('begin_year_param') , 0 , decode(cc.periodv, '00', 0, cc.localcreditamount)) localcreditamount,
      
       decode( cc.yearv , parameter('end_year_param') , 0 ,  decode(cc.periodv, '00', 0, cc.localdebitamount) )  localdebitamount_last , 
       decode( cc.yearv , parameter('end_year_param') , 0 ,  decode(cc.periodv, '00', 0, cc.localcreditamount))  localcreditamount_last 
from  org_financeorg aa   
inner join org_accountingbook  bb  
      on ( bb.pk_relorg = aa.pk_financeorg  and bb.dr = 0   
             and  aa.dr = 0  and aa.code  = parameter('org_code_param') )
inner join gl_detail cc  
      on (
           cc.pk_accountingbook =  bb.pk_accountingbook 
           and length(cc.adjustperiod) <= 3
					 and cc.dr = 0 
					 and cc.discardflagv = 'N'
					 and cc.pk_currtype = '1002Z0100000000001K1'
					 and cc.periodv <= parameter('end_month_param') ||'Z'
					 and cc.periodv >= '00'
					 and cc.yearv <= parameter('end_year_param')
					 and cc.yearv >= parameter('begin_year_param')
      
      )
inner join  gl_voucher dd  
       on (
           cc.pk_voucher = dd.pk_voucher 
           and dd.tempsaveflag = 'N'
           and dd.dr = 0
           and dd.discardflag = 'N'  
       )
inner join  bd_accasoa ee 
       on (
            ee.pk_accasoa = cc.pk_accasoa 
            and ee.dr = 0 
       )             
inner join  bd_account ff
       on (
            ff.pk_account = ee.pk_account 
            and ff.dr = 0 
            and ff.code like '6602%'
       )

inner join  bd_acctype gg
       on (
             gg.pk_acctype = ff.pk_acctype
             and gg.dr = 0 
        
       )      
       
) group by  subj_code  , subj_name , disp_name , balanorient 
       

                   