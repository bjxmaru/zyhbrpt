 select subj_code, subj_name ,disp_name ,balanorient ,  bal_filter_dir_bz , 
    aux_code ,aux_name ,ry_code, ry_name ,   aux_class_cust ,aux_class_supplier ,     
    decode(selected_mark,  'Y+', localdebitamount, -localdebitamount) localdebitamount,
     decode(selected_mark, 'Y+', localcreditamount, -localcreditamount) localcreditamount,
     decode(selected_mark, 'Y+', bal, -bal) bal,
     decode(selected_mark, 'Y+', bal_beg, -bal_beg) bal_beg,
     decode(selected_mark, 'Y+', bal_age, -bal_age) bal_age,
     decode(selected_mark, 'Y+', bal_beg_age, -bal_beg_age) bal_beg_age,
     decode(selected_mark, 'Y+', bal_diff, -bal_diff) bal_diff,
     decode(selected_mark, 'Y+', bal_0, -bal_0) bal_0,
     decode(selected_mark, 'Y+', bal_1, -bal_1) bal_1,
     decode(selected_mark, 'Y+', bal_2, -bal_2) bal_2,
     decode(selected_mark, 'Y+', bal_3, -bal_3) bal_3,
     decode(selected_mark, 'Y+', bal_4, -bal_4) bal_4,
     decode(selected_mark, 'Y+', bal_5, -bal_5) bal_5

from 
(
 select subj_code, subj_name ,disp_name ,balanorient ,  bal_filter_dir_bz , 
    aux_code ,aux_name ,ry_code ,ry_name,   aux_class_cust ,aux_class_supplier , 
    sum( localdebitamount) localdebitamount , 
    sum(localcreditamount ) localcreditamount , 
    sum(bal) bal , 
    sum(bal_beg) bal_beg , 
    sum(bal_age)  bal_age , 
    sum(bal_beg_age)  bal_beg_age , 
     sum(bal) - sum(bal_age)   bal_diff, 
    sum(bal_0)  bal_0 , 
    sum(bal_1)  bal_1, 
    sum(bal_2)  bal_2, 
    sum(bal_3)  bal_3 , 
    sum(bal_4)  bal_4 , 
    sum(bal_5)  bal_5 ,
  case bal_filter_dir_bz
                when '+' then
                 case
                   when sum(bal) >= 0 then
                    'Y+'
                   else
                    'N'
                 end
                when '-' then
                 case
                   when sum(bal) <= 0 then
                    'Y-'
                   else
                    'N'
                 end
    end selected_mark 
  
from 
(
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
                        
union all 

select  ccc.code  subj_code , bbb.name  subj_name , bbb.dispname  disp_name  , ddd.balanorient   , 
0 localdebitamount ,  0 localcreditamount ,  0 bal , 0 bal_beg , 
decode(ddd.balanorient,0,
                     aaa.localdebitamount -  aaa.localcreditamount - (nvl(fff.verifylocaldebitamount,0)- 
                     nvl(fff.verifylocalcreditamount,0)) ,
                     aaa.localcreditamount - aaa.localdebitamount  - (nvl(fff.verifylocalcreditamount,0) - 
                     nvl(fff.verifylocaldebitamount,0) )) bal_age,
0  bal_beg_age , 
decode(ddd.balanorient, parameter('dir_param') , '+', '-') bal_filter_dir_bz , 
nvl(ggg.code , ccc.code) aux_code , 
nvl(ggg.name , bbb.name) aux_name ,
nvl(kkk.code , ccc.code) ry_code , 
nvl(kkk.name , bbb.name) ry_name ,
nvl(hhh.code , '~')  aux_class_cust , 
nvl(iii.code,  '~')   aux_class_supplier  , 
case
               when to_date(aaa.prepareddate, 'yyyy-mm-dd hh24:mi:ss') >
                   to_date(macro('p_perious_date_0'), 'yyyy-mm-dd hh24:mi:ss')  then
                 decode(ddd.balanorient,
                        0,
                        aaa.localdebitamount -  aaa.localcreditamount - 
                        (nvl(fff.verifylocaldebitamount,0)- nvl(fff.verifylocalcreditamount,0)) ,
                        aaa.localcreditamount - aaa.localdebitamount  - 
                        (nvl(fff.verifylocalcreditamount,0) - nvl(fff.verifylocaldebitamount,0) ))
                else
                 0
end bal_0  , 

case 
                when 
                  to_date(aaa.prepareddate, 'yyyy-mm-dd hh24:mi:ss') <=  to_date(macro('p_perious_date_0'), 'yyyy-mm-dd hh24:mi:ss')
                  and 
                  to_date(aaa.prepareddate, 'yyyy-mm-dd hh24:mi:ss') >
                     to_date(macro('p_perious_date_1'), 'yyyy-mm-dd hh24:mi:ss') then
                 decode(ddd.balanorient,
                        0,
                        aaa.localdebitamount -  aaa.localcreditamount - 
                        (nvl(fff.verifylocaldebitamount,0)- nvl(fff.verifylocalcreditamount,0)) ,
                        aaa.localcreditamount - aaa.localdebitamount  - 
                        (nvl(fff.verifylocalcreditamount,0) - nvl(fff.verifylocaldebitamount,0) ))
                else
                 0
end bal_1,

case
                when to_date(aaa.prepareddate, 'yyyy-mm-dd hh24:mi:ss') <=
                      to_date(macro('p_perious_date_1'), 'yyyy-mm-dd hh24:mi:ss') and
                     to_date(aaa.prepareddate, 'yyyy-mm-dd hh24:mi:ss') >
                      to_date(macro('p_perious_date_2'), 'yyyy-mm-dd hh24:mi:ss')then
                 decode(ddd.balanorient,
                        0,
                    aaa.localdebitamount -  aaa.localcreditamount - 
                    (nvl(fff.verifylocaldebitamount,0)- nvl(fff.verifylocalcreditamount,0)) ,
                        aaa.localcreditamount - aaa.localdebitamount  - 
                        (nvl(fff.verifylocalcreditamount,0) - nvl(fff.verifylocaldebitamount,0) ))
                else
                 0
end bal_2,

case
                when to_date(aaa.prepareddate, 'yyyy-mm-dd hh24:mi:ss') <=
                      to_date(macro('p_perious_date_2'), 'yyyy-mm-dd hh24:mi:ss') and
                     to_date(aaa.prepareddate, 'yyyy-mm-dd hh24:mi:ss') >
                     to_date(macro('p_perious_date_3'), 'yyyy-mm-dd hh24:mi:ss') then
                 decode(ddd.balanorient,
                        0,
                       aaa.localdebitamount -  aaa.localcreditamount - 
                       (nvl(fff.verifylocaldebitamount,0)- nvl(fff.verifylocalcreditamount,0)) ,
                        aaa.localcreditamount - aaa.localdebitamount  - 
                        (nvl(fff.verifylocalcreditamount,0) - nvl(fff.verifylocaldebitamount,0) ))
                else
                 0
end bal_3 ,

case
                when to_date(aaa.prepareddate, 'yyyy-mm-dd hh24:mi:ss') <=
                      to_date(macro('p_perious_date_3'), 'yyyy-mm-dd hh24:mi:ss') and 
                     to_date(aaa.prepareddate, 'yyyy-mm-dd hh24:mi:ss') >
                      to_date(macro('p_perious_date_4'), 'yyyy-mm-dd hh24:mi:ss') then
                 decode(ddd.balanorient,
                        0,
                      aaa.localdebitamount -  aaa.localcreditamount - (nvl(fff.verifylocaldebitamount,0)- nvl(fff.verifylocalcreditamount,0)) ,
                        aaa.localcreditamount - aaa.localdebitamount  - (nvl(fff.verifylocalcreditamount,0) - nvl(fff.verifylocaldebitamount,0) ))
                else
                 0
end bal_4,

case
                when to_date(aaa.prepareddate, 'yyyy-mm-dd hh24:mi:ss') <=  to_date(macro('p_perious_date_4'), 'yyyy-mm-dd hh24:mi:ss') then
                 decode(ddd.balanorient,
                        0,
                        aaa.localdebitamount -  aaa.localcreditamount - 
                        (nvl(fff.verifylocaldebitamount,0)- nvl(fff.verifylocalcreditamount,0)) ,
                        aaa.localcreditamount - aaa.localdebitamount  - 
                        (nvl(fff.verifylocalcreditamount,0) - nvl(fff.verifylocaldebitamount,0) ))
                else
                 0
end bal_5  

from org_financeorg x
inner join  org_accountingbook y
		 on (
		   y.pk_relorg = x.pk_financeorg 
			 and y.dr = 0 
			 and x.dr = 0 
			 and x.code  like parameter('org_code_param')
 
		 )

inner join gl_verifydetail aaa  
    on (
     aaa.pk_accountingbook  = y.pk_accountingbook
     and aaa.dr =0 
     and aaa.prepareddate <= parameter('end_date_param') || ' 23:59:59'
    )
inner join  bd_accasoa  bbb 
  on (
          bbb.pk_accasoa = aaa.pk_accasoa
          and bbb.dr = 0 
      )
inner join  bd_account  ccc 
   on (
         ccc.pk_account  =  bbb.pk_account 
         and ccc.dr = 0 
         and (
             ccc.code like parameter('subj_code_param_1')  or 
             ccc.code like parameter('subj_code_param_2') 
         )
    
   ) 
inner join bd_acctype   ddd 
    on  (
         ddd.pk_acctype = ccc.pk_acctype
         and ddd.dr = 0 
    
    )    
left  join 

         (
              select  aa.pk_verifydetail  pk_verifydetail_from_log0 ,
                      sum(aa.verifylocaldebitamount) verifylocaldebitamount , 
                      sum(aa.verifylocalcreditamount)  verifylocalcreditamount      
                      
              from   gl_verify_log aa 
              where   aa.byvoucherdate <= parameter('end_date_param' ) || ' 23:59:59'
              and aa.dr = 0 
              group by aa.pk_verifydetail 
          ) fff  
    on (
    
        fff.pk_verifydetail_from_log0 =  aaa.pk_verifydetail 
    )
left join    gl_docfree1   eee  
    on (
        eee.assid = aaa.assid
        and eee.dr = 0 
    
    )
    
    
left join  bd_psndoc    kkk 
   on (
   
        kkk.pk_psndoc = eee.f2
        and kkk.dr = 0 
   
   )

left join   bd_cust_supplier ggg 
     on (
         ggg.pk_cust_sup = eee.f4 
         and ggg.dr = 0 
     )
     
left join  bd_custclass   hhh 
    on (
         hhh.pk_custclass = ggg.pk_custclass
         and hhh.dr = 0 
    
    ) 
    
left join  bd_supplierclass iii
    on (
         iii.pk_supplierclass = ggg.pk_supplierclass
         and iii.dr = 0 
    
    )
 )   

 group by subj_code, subj_name ,disp_name ,balanorient ,  bal_filter_dir_bz , 
    aux_code ,aux_name , ry_code, ry_name, aux_class_cust ,aux_class_supplier 

   )                    
  
   where 
     selected_mark <> 'N'
     and ( aux_class_cust   like  parameter('ks_class_param')    
     or    aux_class_supplier   like  parameter('ks_class_param' ) )
      
