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
    