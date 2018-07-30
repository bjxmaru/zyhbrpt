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
                subj_code_param varchar2 default '^1122.*$'  ,
                end_date_param varchar2 default '2018-06-30' , 
                dir_param   pls_integer  default  0  , 
                glf_mark_param varchar2 default '[^(集团内)]'  , 
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

with glf_info as 
(
 select pk_cust_sup , aux_code_ks , aux_name_ks , kh_lb_name , gys_lb_name
 from 
 (
     select   xx.pk_cust_sup , xx.code aux_code_ks , xx.name aux_name_ks  , nvl(yy.name,'~') kh_lb_name , 
     nvl(zz.name, '~') gys_lb_name 
     from bd_cust_supplier  xx 
     left  join  bd_custclass  yy 
        on (
              yy.pk_custclass = xx.pk_custclass
              and yy.dr =  0 
            
            )
      left join  bd_supplierclass  zz
        on (
              zz.pk_supplierclass = xx.pk_supplierclass
              and zz.dr = 0 
             
        )
   )  
   where 
   regexp_like(kh_lb_name , glf_mark_param ) 
   or regexp_like(gys_lb_name , glf_mark_param  )
) , 
gl_info as
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
                
            left  join  bd_cust_supplier  h 
               on (
                       h.pk_cust_sup = f.f4
                       and h.dr = 0 
               
               )
                       

) , 

gl_verify_log_info as (
          
     
          select  aa.pk_verifydetail  pk_verifydetail_from_log0 ,
                  sum(aa.verifylocaldebitamount) verifylocaldebitamount , 
                  sum(aa.verifylocalcreditamount)  verifylocalcreditamount      
                  
          from   gl_verify_log aa 
          where   aa.byvoucherdate <= end_date_param  || ' 23:59:59'
          and aa.dr = 0 
          group by aa.pk_verifydetail 
)  , 

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
    
left  join gl_verify_log_info fff  
    on (
    
        fff.pk_verifydetail_from_log0 =  aaa.pk_verifydetail 
    )
  
left join    gl_docfree1   eee  
    on (
        eee.assid = aaa.assid
        and eee.dr = 0 
    
    )

left join   bd_cust_supplier ggg 
     on (
         ggg.pk_cust_sup = eee.f4 
         and ggg.dr = 0 
     )
    

) 


select * from gl_info  ; 


type nt_arap is table of cur_arap_dd%rowtype;




function f_arap(org_code_param varchar2 default '1000' , 
                subj_code_param varchar2 default '^1122.*$'  , 
                end_date_param varchar2 default '2018-06-30' , 
                dir_param   pls_integer  default  0  , 
                glf_mark_param varchar2 default '[^(集团内)]') 
return nt_arap
pipelined ;

end zyhbbi;
/
create or replace package body zyhbbi is


function f_arap(org_code_param varchar2 default '1000' , 
                subj_code_param varchar2 default '^1122.*$'  , 
                end_date_param varchar2 default '2018-06-30' , 
                dir_param   pls_integer  default  0  , 
                glf_mark_param varchar2 default '[^(集团内)]') 
return nt_arap
pipelined 
is
l_tbl_org  nt_orgbook_info  := new nt_orgbook_info() ; 
l_tbl  nt_arap  := new nt_arap() ; 
begin 
  
open cur_orgbook_info(org_code_param )  ; 
fetch cur_orgbook_info bulk collect into l_tbl_org ; 
close cur_orgbook_info ;

  
open cur_arap_dd(l_tbl_org(1).pk_accountingbook , subj_code_param , end_date_param , dir_param , glf_mark_param ) ; 
fetch cur_arap_dd bulk collect into l_tbl ;
close cur_arap_dd ; 


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

end ;

begin
   

   null; 
   
   
end zyhbbi;
/
