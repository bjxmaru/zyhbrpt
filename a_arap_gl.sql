select d.code subj_code , c.name subj_name , c.dispname  disp_name , 
           e.balanorient , decode(a.periodv, '00', 0, a.localdebitamount) localdebitamount,
           decode(a.periodv, '00', 0, a.localcreditamount) localcreditamount, 
           decode(e.balanorient,
                    0,
                    a.localdebitamount - a.localcreditamount,
                    a.localcreditamount - a.localdebitamount) bal,
            decode(a.periodv,
                    '00',
                    decode(e.balanorient,
                           0,
                           a.localdebitamount - a.localcreditamount,
                           a.localcreditamount - a.localdebitamount),
                    0) bal_beg,  
           0  bal_age , 0 bal_beg_age , 
           decode(e.balanorient, parameter('dir_param') , '+', '-') bal_filter_dir_bz  , 
           nvl( h.code , d.code) aux_code , 
           nvl(h.name , c.name ) aux_name  , 
           nvl( k.code , d.code) ry_code , 
           nvl( k.name , c.name ) ry_name  , 
           nvl(i.code , '~')  aux_class_cust , 
           nvl(j.code,  '~')   aux_class_supplier , 
           0 bal_0 , 0 bal_1 , 0 bal_2,  0 bal_3, 0 bal_4,  0 bal_5 
from  org_financeorg x
inner join  org_accountingbook y
		 on (
		   y.pk_relorg = x.pk_financeorg 
			 and y.dr = 0 
			 and x.dr = 0 
			 and x.code  like parameter('org_code_param')
 
		 )
inner  join  gl_detail  a 
      on (
      
        a.pk_accountingbook = y.pk_accountingbook
        and a.discardflagv = 'N'
        and a.dr = 0
        and length(a.adjustperiod) <= 3
        and a.pk_currtype = '1002Z0100000000001K1'
        and a.periodv between '00' and (substr(parameter('end_date_param') , 6,2) || 'Z')
        and a.yearv = substr( parameter('end_date_param') , 1, 4)
      
      )
inner join  gl_voucher b 
      on (
        b.pk_voucher = a.pk_voucher
        and b.tempsaveflag = 'N'
        and b.dr = 0
        and b.discardflag = 'N'
      )
inner  join bd_accasoa c  
      on (
                      c.pk_accasoa = a.pk_accasoa
                      and c.dr = 0 
               )
  inner join bd_account  d 
              on (
                      d.pk_account = c.pk_account 
                      and d.dr = 0 
                      and  (   d.code like parameter('subj_code_param_1')    or 
      
                               d.code like parameter('subj_code_param_2') )
              
              )
     inner join  bd_acctype e  
               on (
                       e.pk_acctype = d.pk_acctype
                       and e.dr = 0 
               )
               
           left join gl_docfree1 f   
                on (
                     f.assid = a.assid 
                     and f.dr = 0 
                
                )
                
             left join  bd_psndoc   k 
                on (
                       k.pk_psndoc =  f.f2
                       and k.dr = 0 
                
                )   
                
            left  join  bd_cust_supplier  h 
               on (
                       h.pk_cust_sup = f.f4
                       and h.dr = 0 
               
               )
               
          
                        
           left join  bd_custclass   i 
              on (
                   i.pk_custclass = h.pk_custclass
                   and i.dr = 0 
              
              ) 
    
          left join  bd_supplierclass j
              on (
                   j.pk_supplierclass = h.pk_supplierclass
                   and j.dr = 0 
              
              )                    
                        


                       
  
      
