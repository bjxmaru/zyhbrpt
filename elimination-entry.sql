select ff.code  subj_code , ee.name subj_name , ee.dispname  disp_name , gg.balanorient,
       nvl(ii.code , ee.dispname) ks_code ,nvl(ii.name , ee.dispname) ks_name, nvl(ii.pk_cust_sup ,ee.dispname) ks_pk ,
       decode( gg.balanorient, 0,   cc.localdebitamount - cc.localcreditamount ,  cc.localcreditamount -  cc.localdebitamount ) beg_bal , 
       '2018-' ||'01-01' voucher_date 
from  org_financeorg aa  
inner join org_accountingbook  bb  
      on ( bb.pk_relorg = aa.pk_financeorg  and bb.dr = 0   
             and  aa.dr = 0  and aa.code  = '1000')
inner join gl_detail cc  
      on (
           cc.pk_accountingbook =  bb.pk_accountingbook 
           and length(cc.adjustperiod) <= 3
           and cc.dr = 0 
           and cc.discardflagv = 'N'
           and cc.pk_currtype = '1002Z0100000000001K1'
           and cc.periodv = '00'
           and cc.yearv =  '2018'
      
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
            and ff.code like  '1122%'
       )

inner join  bd_acctype gg
       on (
             gg.pk_acctype = ff.pk_acctype
             and gg.dr = 0 
        
       )    
       
left join  gl_docfree1 hh 
      on (
             hh.assid = cc.assid 
             and hh.dr = 0 
       )  
left join  bd_cust_supplier  ii
      on (
      
             ii.pk_cust_sup = hh.f4
             and ii.dr = 0 
      
      ) ; 
