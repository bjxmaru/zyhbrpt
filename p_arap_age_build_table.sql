

type nt_pk  is table of char(20) ; 

cursor cur_ks  as 
select  
pk_cust_sup 
from 
bd_cust_supplier  aa
where aa.dr = 0  ;


cursor cur_tb_beg(org_code_param varchar2 , subj_code_param varchar2 , beg_year_param varchar2  )  as 
select pk_org  , org_code , org_name , pk_account , subj_code , subj_name , disp_name, 
       balanorient , ks_code , ks_name, ks_pk , voucher_date ,  amount ,  sum(amount ) amount , ks_code ||'_' || subj_code || '_' || 'org_code'  the_key 
from 
(
select aa.pk_financeorg pk_org , aa.code org_code, aa.name org_name  ,  ff.pk_account pk_account  , 
       ff.code  subj_code , ee.name subj_name , ee.dispname  disp_name , gg.balanorient,
       nvl(ii.code , ee.dispname) ks_code ,nvl(ii.name , ee.dispname) ks_name, nvl(ii.pk_cust_sup ,ee.dispname) ks_pk ,
       decode( gg.balanorient, 0,   cc.localdebitamount - cc.localcreditamount ,  cc.localcreditamount -  cc.localdebitamount ) amount , 
       beg_year ||'-01-01' voucher_date 
from  org_financeorg aa  
inner join org_accountingbook  bb  
      on ( bb.pk_relorg = aa.pk_financeorg  and bb.dr = 0   
             and  aa.dr = 0  and aa.code  = org_code_param)
inner join gl_detail cc  
      on (
           cc.pk_accountingbook =  bb.pk_accountingbook 
           and length(cc.adjustperiod) <= 3
           and cc.dr = 0 
           and cc.discardflagv = 'N'
           and cc.pk_currtype = '1002Z0100000000001K1'
           and cc.periodv = '00'
           and cc.yearv =  beg_year_param
      
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
            and ff.code like  subj_code_param
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
      
      ) 
)
group by subj_code , subj_name , disp_name, balanorient , ks_code , ks_name, ks_pk , voucher_date ;



cursor cur_tb_accur(org_code_param varchar2 , subj_code_param varchar2 , beg_year_param varchar2 ,
 beg_month_param varchar2 , end_year_param varchar2 , end_month varchar2  )
as 
select pk_org  , org_code , org_name , pk_account , subj_code , subj_name , disp_name, 
     balanorient , ks_code , ks_name, ks_pk , voucher_date ,  amount , ks_code ||'_' || subj_code || '_' || 'org_code'  the_key 
from 
(
select  aa.pk_financeorg pk_org , aa.code org_code, aa.name org_name  ,  ff.pk_account pk_account  , 
        ff.code  subj_code , ee.name subj_name , ee.dispname  disp_name , gg.balanorient,
       nvl(ii.code , ee.dispname) ks_code ,nvl(ii.name , ee.dispname) ks_name, nvl(ii.pk_cust_sup ,ee.dispname) ks_pk ,
       decode( gg.balanorient, 0,   cc.localdebitamount - cc.localcreditamount ,  cc.localcreditamount -  cc.localdebitamount )  amount , 
       substr(cc.PREPAREDDATEV , 1, 10)  voucher_date 
from  org_financeorg aa  
inner join org_accountingbook  bb  
      on ( bb.pk_relorg = aa.pk_financeorg  and bb.dr = 0   
             and  aa.dr = 0  and aa.code  =  org_code_param)
inner join gl_detail cc  
      on (
           cc.pk_accountingbook =  bb.pk_accountingbook 
           and length(cc.adjustperiod) <= 3
           and cc.dr = 0 
           and cc.discardflagv = 'N'
           and cc.pk_currtype = '1002Z0100000000001K1'
           and cc.periodv <> '00'
           and cc.periodv <=  end_month_param || 'Z'
           and cc.periodv >= beg_month_param
           and cc.yearv <=  end_year_param
           and cc.yearv  >=  beg_year_param
      
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
            and ff.code like  subj_code_param
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
      
      ) 
)

order by  org_code,   subj_code,  ks_pk ,  voucher_date 




procedure  p_arap_age_build_table(end_year   varchar2 default 2012 ,
                                  end_month  varchar2 default '07', 
                                  begn_year   varchar2 default 2012 ,
                                  begn_month  varchar2 default '01', 
                                  corp_code varchar2 default '01' )
is

l_ks_list  nt_pk := new  nt_pk() ; 
begin
	
	 open cur_ks  ; 
	 
	 fetch cur_ks   bulk collect into l_ks_list ; 
	 
	 close cur_ks ; 
	 
	 
	 
	 exception 
	 
	   when  others   then 
	   
	      if(cur_ks % isopen)  then 
	     
	          close  cur_ks ; 
	      
	      end if; 
	
	
end; 