create or replace package zyhbbi is


--19位日期字符串格式
  V_DATE_FORMAT_19 constant varchar2(21) := 'yyyy-mm-dd hh24:mi:ss';

  --10位日期字符串格式
  V_DATE_FORMAT_10 constant varchar2(10) := 'yyyy-mm-dd';

  --测试用当前日期字符串
  V_TMP_CURR_DATE_STR    constant varchar2(19) := '2018-06-30 23:56:56';
  V_TMP_CURR_DATE_STR_10 constant varchar2(19) := '2018-06-30';
  V_TMP_BEGIN_DATE_STR   constant varchar2(19) := '2018-01-01 01:01:01';

cursor cur_orgbook_info(org_code_param varchar2 default '1000')
is
select aa.pk_financeorg pk_org , bb.pk_accountingbook , aa.code  org_code , aa.name org_name 
from  org_financeorg aa,  org_accountingbook bb 
 where 
 1=1
 and bb.pk_relorg = aa.pk_financeorg 
 and bb.dr = 0 
 and aa.dr = 0 
 and aa.code  like org_code_param  ;
 
type nt_orgbook_info is table of cur_orgbook_info%rowtype  ; 


cursor cur_arap_dd(pk_accountingbook_param varchar2 default '1000' , 
                subj_code_param varchar2 default '1122.*$'  ,
                end_date_param varchar2 default '2018-06-30' , 
                dir_param   pls_integer  default  0  , 
                ks_class_param varchar2 default '[^(集团内)]'  , 
                p_perious_date_0    date default add_months(to_date(V_TMP_CURR_DATE_STR,
                                                                                V_DATE_FORMAT_19),
                                                                        -12 * 1),
                p_perious_date_1    date default add_months(to_date(V_TMP_CURR_DATE_STR,
                                                                                V_DATE_FORMAT_19),
                                                                        -12 * 2),
                p_perious_date_2    date default add_months(to_date(V_TMP_CURR_DATE_STR,
                                                                                V_DATE_FORMAT_19),
                                                                        -12 * 3),
                p_perious_date_3    date default add_months(to_date(V_TMP_CURR_DATE_STR,
                                                                                V_DATE_FORMAT_19),
                                                                        -12 * 4),
                p_perious_date_4    date default add_months(to_date(V_TMP_CURR_DATE_STR,
                                                                                V_DATE_FORMAT_19),
                                                                        -12 * 5)
                
                ) 
is

with gl_info as
     (
       select  d.code subj_code , c.name subj_name , c.dispname  disp_name , 
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
           decode(e.balanorient, dir_param, '+', '-') bal_filter_dir_bz  , 
           nvl( h.code , d.code) aux_code , 
           nvl(h.name , c.name ) aux_name  , 
           nvl( k.code , d.code) ry_code , 
           nvl( k.name , c.name ) ry_name  , 
           nvl(i.code , '~')  aux_class_cust , 
           nvl(j.code,  '~')   aux_class_supplier , 
           0 bal_0 , 0 bal_1 , 0 bal_2,  0 bal_3, 0 bal_4,  0 bal_5 
           from  gl_detail  a  
           inner join  gl_voucher  b 
               on (
                     b.pk_voucher = a.pk_voucher
                     and b.tempsaveflag = 'N'
                     and b.dr = 0
                     and b.discardflag = 'N'
                     and a.discardflagv = 'N'
                     and a.dr = 0
                     and length(a.adjustperiod) <= 3
                     and decode(nvl(b.tallydate, 'Y'), 'Y', 1, 2) >= 1
                     and a.pk_currtype = '1002Z0100000000001K1'
                     and a.periodv between '00' and (substr(end_date_param , 6,2) || 'Z')
                     and a.yearv = substr( end_date_param , 1, 4)
                     and a.pk_accountingbook = pk_accountingbook_param
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
                      and regexp_like( d.code , subj_code_param ) 
              
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
                       

) , 



gl_verify_info as (

select  ccc.code  subj_code , bbb.name  subj_name , bbb.dispname  disp_name  , ddd.balanorient   , 
0 localdebitamount ,  0 localcreditamount ,  0 bal , 0 bal_beg , 
decode(ddd.balanorient,0,
                     aaa.localdebitamount -  aaa.localcreditamount - (nvl(fff.verifylocaldebitamount,0)- 
                     nvl(fff.verifylocalcreditamount,0)) ,
                     aaa.localcreditamount - aaa.localdebitamount  - (nvl(fff.verifylocalcreditamount,0) - 
                     nvl(fff.verifylocaldebitamount,0) )) bal_age,
0  bal_beg_age , 
decode(ddd.balanorient, dir_param , '+', '-') bal_filter_dir_bz , 
nvl(ggg.code , ccc.code) aux_code , 
nvl(ggg.name , bbb.name) aux_name ,
nvl(kkk.code , ccc.code) ry_code , 
nvl(kkk.name , bbb.name) ry_name ,
nvl(hhh.code , '~')  aux_class_cust , 
nvl(iii.code,  '~')   aux_class_supplier , 
case
               when to_date(aaa.prepareddate, V_DATE_FORMAT_19) >
                     p_perious_date_0 then
                 decode(ddd.balanorient,
                        0,
                        aaa.localdebitamount -  aaa.localcreditamount - 
                        (nvl(fff.verifylocaldebitamount,0)- nvl(fff.verifylocalcreditamount,0)) ,
                        aaa.localcreditamount - aaa.localdebitamount  - 
                        (nvl(fff.verifylocalcreditamount,0) - nvl(fff.verifylocaldebitamount,0) ))
                else
                 0
end bal_0 , 
case 
                when 
                  to_date(aaa.prepareddate, V_DATE_FORMAT_19) <= p_perious_date_0
                  and 
                  to_date(aaa.prepareddate, V_DATE_FORMAT_19) >
                     p_perious_date_1 then
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
                when to_date(aaa.prepareddate, V_DATE_FORMAT_19) <=
                     p_perious_date_1 and
                     to_date(aaa.prepareddate, V_DATE_FORMAT_19) >
                     p_perious_date_2 then
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
                when to_date(aaa.prepareddate, V_DATE_FORMAT_19) <=
                     p_perious_date_2 and
                     to_date(aaa.prepareddate, V_DATE_FORMAT_19) >
                     p_perious_date_3 then
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
                when to_date(aaa.prepareddate, V_DATE_FORMAT_19) <=
                     p_perious_date_3 and
                     to_date(aaa.prepareddate, V_DATE_FORMAT_19) >
                     p_perious_date_4 then
                 decode(ddd.balanorient,
                        0,
                      aaa.localdebitamount -  aaa.localcreditamount - (nvl(fff.verifylocaldebitamount,0)- nvl(fff.verifylocalcreditamount,0)) ,
                        aaa.localcreditamount - aaa.localdebitamount  - (nvl(fff.verifylocalcreditamount,0) - nvl(fff.verifylocaldebitamount,0) ))
                else
                 0
end bal_4,

case
                when to_date(aaa.prepareddate, V_DATE_FORMAT_19) <= p_perious_date_4 then
                 decode(ddd.balanorient,
                        0,
                        aaa.localdebitamount -  aaa.localcreditamount - 
                        (nvl(fff.verifylocaldebitamount,0)- nvl(fff.verifylocalcreditamount,0)) ,
                        aaa.localcreditamount - aaa.localdebitamount  - 
                        (nvl(fff.verifylocalcreditamount,0) - nvl(fff.verifylocaldebitamount,0) ))
                else
                 0
end bal_5  
from gl_verifydetail aaa 
inner join  bd_accasoa  bbb 
  on (
          bbb.pk_accasoa = aaa.pk_accasoa
          and bbb.dr = 0 
          and aaa.dr =0 
          and aaa.prepareddate <= end_date_param || ' 23:59:59'
          and aaa.pk_accountingbook =  pk_accountingbook_param
      )
inner join  bd_account  ccc 
   on (
         ccc.pk_account  =  bbb.pk_account 
         and ccc.dr = 0 
         and regexp_like(ccc.code, subj_code_param )
    
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
              where   aa.byvoucherdate <= end_date_param  || ' 23:59:59'
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
    

)   , 


gl_age_union_info as 
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
    select subj_code, subj_name ,disp_name ,balanorient , localdebitamount , localcreditamount  ,
    bal , bal_beg , bal_age ,bal_beg_age,  bal_filter_dir_bz , aux_code ,aux_name ,ry_code, ry_name, aux_class_cust , 
    aux_class_supplier,  bal_0 , bal_1, bal_2, bal_3, bal_4, bal_5 
    from gl_info 
    union all 
    select subj_code, subj_name ,disp_name ,balanorient , localdebitamount , localcreditamount  ,
    bal , bal_beg , bal_age ,bal_beg_age,  bal_filter_dir_bz , aux_code ,aux_name , ry_code, ry_name, aux_class_cust , 
    aux_class_supplier, bal_0 , bal_1, bal_2, bal_3, bal_4, bal_5 
    from gl_verify_info
    )  
    group by subj_code, subj_name ,disp_name ,balanorient ,  bal_filter_dir_bz , 
    aux_code ,aux_name , ry_code, ry_name, aux_class_cust ,aux_class_supplier 

) , 

gl_with_age  as 
(
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
     from gl_age_union_info 
     where 
     selected_mark <> 'N'
     and ( regexp_like(aux_class_cust  , ks_class_param )
     or regexp_like(aux_class_supplier  , ks_class_param ) )
) 


select * from gl_with_age  ; 


type nt_arap is table of cur_arap_dd%rowtype;


cursor cur_arap_dd_sum(pk_accountingbook_param varchar2 default '1000' , 
                subj_code_param varchar2 default '^1122.*$'  ,
                end_date_param varchar2 default '2018-06-30' , 
                dir_param   pls_integer  default  0  , 
                ks_class_param varchar2 default '[^(集团内)]'  , 
                p_perious_date_0    date default add_months(to_date(V_TMP_CURR_DATE_STR,
                                                                                V_DATE_FORMAT_19),
                                                                        -12 * 1),
                p_perious_date_1    date default add_months(to_date(V_TMP_CURR_DATE_STR,
                                                                                V_DATE_FORMAT_19),
                                                                        -12 * 2),
                p_perious_date_2    date default add_months(to_date(V_TMP_CURR_DATE_STR,
                                                                                V_DATE_FORMAT_19),
                                                                        -12 * 3),
                p_perious_date_3    date default add_months(to_date(V_TMP_CURR_DATE_STR,
                                                                                V_DATE_FORMAT_19),
                                                                        -12 * 4),
                p_perious_date_4    date default add_months(to_date(V_TMP_CURR_DATE_STR,
                                                                                V_DATE_FORMAT_19),
                                                                        -12 * 5)
                
                ) 
is

with gl_info as
     (
       select  d.code subj_code , c.name subj_name , c.dispname  disp_name , 
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
           decode(e.balanorient, dir_param, '+', '-') bal_filter_dir_bz  , 
           nvl( h.code , d.code) aux_code , 
           nvl(h.name , c.name ) aux_name  , 
           nvl( k.code , d.code) ry_code , 
           nvl(k.name , c.name ) ry_name  , 
           nvl(i.code , '~')  aux_class_cust , 
           nvl(j.code,  '~')   aux_class_supplier , 
           0 bal_0 , 0 bal_1 , 0 bal_2,  0 bal_3, 0 bal_4,  0 bal_5 
           from  gl_detail  a  
           inner join  gl_voucher  b 
               on (
                     b.pk_voucher = a.pk_voucher
                     and b.tempsaveflag = 'N'
                     and b.dr = 0
                     and b.discardflag = 'N'
                     and a.discardflagv = 'N'
                     and a.dr = 0
                     and length(a.adjustperiod) <= 3
                     and decode(nvl(b.tallydate, 'Y'), 'Y', 1, 2) >= 1
                     and a.pk_currtype = '1002Z0100000000001K1'
                     and a.periodv between '00' and (substr(end_date_param , 6,2) || 'Z')
                     and a.yearv = substr( end_date_param , 1, 4)
                     and a.pk_accountingbook = pk_accountingbook_param
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
                      and regexp_like( d.code , subj_code_param ) 
              
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
                
           left join bd_psndoc  k 
                 on (
                     k.pk_psndoc = f.f2 
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
                       

) , 



gl_verify_info as (

select  ccc.code  subj_code , bbb.name  subj_name , bbb.dispname  disp_name  , ddd.balanorient   , 
0 localdebitamount ,  0 localcreditamount ,  0 bal , 0 bal_beg , 
decode(ddd.balanorient,0,
                     aaa.localdebitamount -  aaa.localcreditamount - (nvl(fff.verifylocaldebitamount,0)- 
                     nvl(fff.verifylocalcreditamount,0)) ,
                     aaa.localcreditamount - aaa.localdebitamount  - (nvl(fff.verifylocalcreditamount,0) - 
                     nvl(fff.verifylocaldebitamount,0) )) bal_age,
0  bal_beg_age , 
decode(ddd.balanorient, dir_param , '+', '-') bal_filter_dir_bz , 
nvl(ggg.code , ccc.code) aux_code , 
nvl(ggg.name , bbb.name) aux_name ,
nvl(kkk.code , ccc.code) ry_code , 
nvl(kkk.name , bbb.name) ry_name ,
nvl(hhh.code , '~')  aux_class_cust , 
nvl(iii.code,  '~')   aux_class_supplier , 
case
               when to_date(aaa.prepareddate, V_DATE_FORMAT_19) >
                     p_perious_date_0 then
                 decode(ddd.balanorient,
                        0,
                        aaa.localdebitamount -  aaa.localcreditamount - 
                        (nvl(fff.verifylocaldebitamount,0)- nvl(fff.verifylocalcreditamount,0)) ,
                        aaa.localcreditamount - aaa.localdebitamount  - 
                        (nvl(fff.verifylocalcreditamount,0) - nvl(fff.verifylocaldebitamount,0) ))
                else
                 0
end bal_0 , 
case 
                when 
                  to_date(aaa.prepareddate, V_DATE_FORMAT_19) <= p_perious_date_0
                  and 
                  to_date(aaa.prepareddate, V_DATE_FORMAT_19) >
                     p_perious_date_1 then
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
                when to_date(aaa.prepareddate, V_DATE_FORMAT_19) <=
                     p_perious_date_1 and
                     to_date(aaa.prepareddate, V_DATE_FORMAT_19) >
                     p_perious_date_2 then
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
                when to_date(aaa.prepareddate, V_DATE_FORMAT_19) <=
                     p_perious_date_2 and
                     to_date(aaa.prepareddate, V_DATE_FORMAT_19) >
                     p_perious_date_3 then
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
                when to_date(aaa.prepareddate, V_DATE_FORMAT_19) <=
                     p_perious_date_3 and
                     to_date(aaa.prepareddate, V_DATE_FORMAT_19) >
                     p_perious_date_4 then
                 decode(ddd.balanorient,
                        0,
                      aaa.localdebitamount -  aaa.localcreditamount - (nvl(fff.verifylocaldebitamount,0)- nvl(fff.verifylocalcreditamount,0)) ,
                        aaa.localcreditamount - aaa.localdebitamount  - (nvl(fff.verifylocalcreditamount,0) - nvl(fff.verifylocaldebitamount,0) ))
                else
                 0
end bal_4,

case
                when to_date(aaa.prepareddate, V_DATE_FORMAT_19) <= p_perious_date_4 then
                 decode(ddd.balanorient,
                        0,
                        aaa.localdebitamount -  aaa.localcreditamount - 
                        (nvl(fff.verifylocaldebitamount,0)- nvl(fff.verifylocalcreditamount,0)) ,
                        aaa.localcreditamount - aaa.localdebitamount  - 
                        (nvl(fff.verifylocalcreditamount,0) - nvl(fff.verifylocaldebitamount,0) ))
                else
                 0
end bal_5  
from gl_verifydetail aaa 
inner join  bd_accasoa  bbb 
  on (
          bbb.pk_accasoa = aaa.pk_accasoa
          and bbb.dr = 0 
          and aaa.dr =0 
          and aaa.prepareddate <= end_date_param || ' 23:59:59'
          and aaa.pk_accountingbook =  pk_accountingbook_param
      )
inner join  bd_account  ccc 
   on (
         ccc.pk_account  =  bbb.pk_account 
         and ccc.dr = 0 
         and regexp_like(ccc.code, subj_code_param )
    
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
              where   aa.byvoucherdate <= end_date_param  || ' 23:59:59'
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
    
left join   bd_psndoc   kkk 
    on (
        kkk.pk_psndoc = eee.f2 
        and  kkk.dr = 0 
    
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
    

)   , 


gl_age_union_info as 
(

    select subj_code, subj_name ,disp_name ,balanorient ,  bal_filter_dir_bz , 
    aux_code ,aux_name ,  aux_class_cust ,aux_class_supplier , 
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
    select subj_code, subj_name ,disp_name ,balanorient , localdebitamount , localcreditamount  ,
    bal , bal_beg , bal_age ,bal_beg_age,  bal_filter_dir_bz , aux_code ,aux_name , aux_class_cust , 
    aux_class_supplier,  bal_0 , bal_1, bal_2, bal_3, bal_4, bal_5 
    from gl_info 
    union all 
    select subj_code, subj_name ,disp_name ,balanorient , localdebitamount , localcreditamount  ,
    bal , bal_beg , bal_age ,bal_beg_age,  bal_filter_dir_bz , aux_code ,aux_name ,  aux_class_cust , 
    aux_class_supplier, bal_0 , bal_1, bal_2, bal_3, bal_4, bal_5 
    from gl_verify_info
    )  
    group by subj_code, subj_name ,disp_name ,balanorient ,  bal_filter_dir_bz , 
    aux_code ,aux_name ,  aux_class_cust ,aux_class_supplier 

) , 

gl_with_age_info  as 
(
    select subj_code, subj_name ,disp_name ,balanorient ,  bal_filter_dir_bz , 
    aux_code ,aux_name ,  aux_class_cust ,aux_class_supplier ,   
     decode(selected_mark, 'Y+', localdebitamount, -localdebitamount) localdebitamount,
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
     from gl_age_union_info 
     where 
     selected_mark <> 'N'
     and ( regexp_like(aux_class_cust  , ks_class_param )
     or regexp_like(aux_class_supplier  , ks_class_param ) )
)  ,

gl_with_age_info_sum as 
(
select
    sum( localdebitamount) localdebitamount , 
    sum(localcreditamount ) localcreditamount , 
    sum(bal) bal , 
    sum(bal_beg) bal_beg , 
    sum(bal_age)  bal_age , 
    sum(bal_beg_age)  bal_beg_age , 
    sum(bal_diff) bal_diff , 
    sum(bal_0)  bal_0 , 
    sum(bal_1)  bal_1, 
    sum(bal_2)  bal_2, 
    sum(bal_3)  bal_3 , 
    sum(bal_4)  bal_4 , 
    sum(bal_5)  bal_5
    from gl_with_age_info  )
    
select * from gl_with_age_info_sum ; 


type  nt_arap_sum  is table of cur_arap_dd_sum%rowtype ; 

function f_arap(org_code_param varchar2 default '1000' , 
                subj_code_param varchar2 default '^1122.*$'  , 
                end_date_param varchar2 default '2018-06-30' , 
                dir_param   pls_integer  default  0  , 
                ks_class_param varchar2 default '[^(集团内)]' ,
                sum_param   varchar2 default 'single') 
return nt_arap
pipelined ;



cursor cur_tb_test(pk_accountingbook_param varchar2 default '1000' , 
                subj_code_param varchar2 default '1122.*$'  ,
                end_date_param varchar2 default '2018-06-30' , 
                dir_param   pls_integer  default  0  , 
                ks_class_param varchar2 default '[^(集团内)]' 
                ) 
is

with gl_info as
     (
       select  d.code subj_code , c.name subj_name , c.dispname  disp_name , 
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
           decode(e.balanorient, dir_param, '+', '-') bal_filter_dir_bz  , 
           nvl(k.code , d.code )   psn_code, 
           nvl(k.name , c.name )    psn_name, 
           nvl( h.code , d.code) aux_code , 
           nvl(h.name , c.name ) aux_name  , 
           nvl(i.code , '~')  aux_class_cust , 
           nvl(j.code,  '~')   aux_class_supplier 
           from  gl_detail  a  
           inner join  gl_voucher  b 
               on (
                     b.pk_voucher = a.pk_voucher
                     and b.tempsaveflag = 'N'
                     and b.dr = 0
                     and b.discardflag = 'N'
                     and a.discardflagv = 'N'
                     and a.dr = 0
                     and length(a.adjustperiod) <= 3
                     and decode(nvl(b.tallydate, 'Y'), 'Y', 1, 2) >= 1
                     and a.pk_currtype = '1002Z0100000000001K1'
                     and a.periodv between '00' and (substr(end_date_param , 6,2) || 'Z')
                     and a.yearv = substr( end_date_param , 1, 4)
                     and a.pk_accountingbook = pk_accountingbook_param
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
                      and regexp_like( d.code , subj_code_param ) 
              
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
                
            left join bd_psndoc  k 
                on (
                      k.pk_psndoc = f.f2
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
                       

)



select * from gl_info  ; 


type nt_tb_test is table of cur_tb_test%rowtype;



function f_tb_test(org_code_param varchar2 default '1000' , 
                subj_code_param varchar2 default '^1122.*$'  , 
                end_date_param varchar2 default '2018-06-30' , 
                dir_param   pls_integer  default  0  , 
                ks_class_param varchar2 default '[^(集团内)]' ) 
return nt_tb_test
pipelined ;


end zyhbbi;
/
create or replace package body zyhbbi is


function f_arap(org_code_param varchar2 default '1000' , 
                subj_code_param varchar2 default '^1122.*$'  , 
                end_date_param varchar2 default '2018-06-30' , 
                dir_param   pls_integer  default  0  , 
                ks_class_param varchar2 default '[^(集团内)]' ,
                sum_param   varchar2 default 'single' )  
return nt_arap
pipelined 
is
l_tbl_org  nt_orgbook_info  := new nt_orgbook_info() ; 
l_tbl_single  nt_arap  := new nt_arap() ; 
l_tbl_sum nt_arap_sum := new nt_arap_sum() ;
l_tbl  nt_arap  := new nt_arap() ; 
l_count pls_integer := 0 ;  
begin 
  
open cur_orgbook_info(org_code_param )  ; 
fetch cur_orgbook_info bulk collect into l_tbl_org ; 
close cur_orgbook_info ;


case sum_param 
    when 'single' then 
          open cur_arap_dd(l_tbl_org(1).pk_accountingbook , subj_code_param , end_date_param ,
           dir_param , ks_class_param ) ; 
          fetch cur_arap_dd bulk collect into l_tbl_single ;
          close cur_arap_dd ; 
    when  'sum'  then 
          open cur_arap_dd_sum(l_tbl_org(1).pk_accountingbook , subj_code_param ,
           end_date_param , dir_param , ks_class_param ) ; 
          fetch cur_arap_dd_sum bulk collect into l_tbl_sum ;
          close cur_arap_dd_sum ; 
          
end case ; 
    
l_count := l_tbl.count ; 
for x in  1 .. l_tbl_single.count loop 
     l_count := l_count +1 ; 
     l_tbl.extend; 
     l_tbl(l_count) := l_tbl_single(x) ; 

end loop; 

for x in  1 .. l_tbl_sum.count loop 
     l_count := l_count +1 ; 
     l_tbl.extend; 
     l_tbl(l_count).bal := l_tbl_sum(x).bal ; 
     l_tbl(l_count).bal_0 := l_tbl_sum(x).bal_0 ; 
     l_tbl(l_count).bal_1 := l_tbl_sum(x).bal_1 ; 
     l_tbl(l_count).bal_2 := l_tbl_sum(x).bal_2 ; 
     l_tbl(l_count).bal_3 := l_tbl_sum(x).bal_3 ; 
     l_tbl(l_count).bal_4 := l_tbl_sum(x).bal_4 ; 
     l_tbl(l_count).bal_5 := l_tbl_sum(x).bal_5 ;
end loop; 



for x in 1 .. l_tbl.count loop 
  
pipe row (l_tbl(x)) ; 

end loop; 




exception 
  
    when others  then 
      
       if( cur_orgbook_info % isopen ) then 
       
           close cur_orgbook_info ;
 
       end if; 
      
       if( cur_arap_dd % isopen ) then 
       
             close cur_arap_dd ; 
       
       end  if; 
       
            if( cur_arap_dd_sum % isopen ) then 
       
             close cur_arap_dd_sum ; 
       
       end  if; 

end ;




function f_tb_test(org_code_param varchar2 default '1000' , 
                subj_code_param varchar2 default '^1122.*$'  , 
                end_date_param varchar2 default '2018-06-30' , 
                dir_param   pls_integer  default  0  , 
                ks_class_param varchar2 default '[^(集团内)]' ) 
return nt_tb_test
pipelined
is
l_tbl_org  nt_orgbook_info  := new nt_orgbook_info() ; 
l_tbl  nt_tb_test  := new nt_tb_test() ;
begin 
  
open cur_orgbook_info(org_code_param )  ; 
fetch cur_orgbook_info bulk collect into l_tbl_org ; 
close cur_orgbook_info ;

          open cur_tb_test(l_tbl_org(1).pk_accountingbook , subj_code_param ,
               end_date_param , dir_param , ks_class_param ) ; 
          fetch cur_tb_test bulk collect into l_tbl ;
          close cur_tb_test ; 
          

    
for x in 1 .. l_tbl.count loop 
  
pipe row (l_tbl(x)) ; 

end loop; 




exception 
  
    when others  then 
      
       if( cur_orgbook_info % isopen ) then 
       
           close cur_orgbook_info ;
 
       end if; 
      
       if( cur_tb_test % isopen ) then 
       
             close cur_tb_test ; 
       
       end  if; 
       

end ;



begin
   

   null; 
   
   
end zyhbbi;
/
