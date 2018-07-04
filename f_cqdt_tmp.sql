select * from gl_detail cc  
inner join  gl_voucher dd 
on(
  cc.pk_voucher = dd.pk_voucher 
  and dd.tempsaveflag = 'N'
  and dd.dr = 0
  and dd.discardflag = 'N'
  and length(cc.adjustperiod) <= 3
  and cc.dr = 0 
  and cc.discardflagv = 'N'
  and cc.pk_currtype = '1002Z0100000000001K1'
  and cc.periodv <= parameter('end_month_param') ||'Z'
  and cc.periodv >= '00'
  and cc.yearv = parameter('end_year_param')
  and cc.pk_accountingbook = (select bb.pk_accountingbook  from  org_financeorg aa   
             inner join org_accountingbook  bb  
             on ( bb.pk_relorg = aa.pk_financeorg  and bb.dr = 0   
             and  aa.dr = 0  and aa.code  = parameter('org_code_param') ) 
             ) 

)

       

                   