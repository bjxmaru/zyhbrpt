select pk_org  , org_code , org_name , pk_account , subj_code , subj_name , disp_name, balanorient , ks_code , ks_name, ks_pk , voucher_date ,  amount
from 
(
select  aa.pk_financeorg pk_org , aa.code org_code, aa.name org_name  ,  ee.pk_account pk_account  , ff.code  subj_code , ee.name subj_name , ee.dispname  disp_name , gg.balanorient,
       nvl(ii.code , ee.dispname) ks_code ,nvl(ii.name , ee.dispname) ks_name, nvl(ii.pk_cust_sup ,ee.dispname) ks_pk ,
       decode( gg.balanorient, 0,   cc.localdebitamount - cc.localcreditamount ,  cc.localcreditamount -  cc.localdebitamount )  amount , 
       substr(cc.PREPAREDDATEV , 1, 10)  voucher_date 
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
           and cc.periodv <> '00'
           and cc.periodv <= '12' || 'Z'
           and cc.periodv >= '01'
           and cc.yearv <='2016'
           and cc.yearv  >= '2016'
      
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
      
      ) 
)

order by  org_code,   subj_code,  ks_pk ,  voucher_date 


select * from table(zyhbrptfz.f_cur_tb_beg(org_code_param => '1000',subj_code_param => '112202%',beg_year_param => '2016' , 
beg_month_param => '01',end_year_param => '2016',end_month_param => '03'))

select * from table(zyhbrptfz.f_cur_tb_accur(org_code_param => '1000',subj_code_param => '112202%',beg_year_param => '2017' ,
beg_month_param => '00',end_year_param => '2017',end_month_param => '01'))  

select * from table(zyhbrptfz.f_hx(org_code_param => '1000',subj_code_param => '1122%',beg_year_param => '2016' ,
beg_month_param => '01',end_year_param => '2016',end_month_param => '12')) 


select * from table(zyhbrptfz.f_hx(org_code_param => '1000',subj_code_param => '1122%',beg_year_param => '2016' ,
beg_month_param => '01',end_year_param => '2016',end_month_param => '12')) 


select * from table(zyhbrptfz.f_arap_age_year_month_tb(org_code_param => '1000',
subj_code_param => '1122.*',end_year_param => '2017',end_month_param => '12')) 




  create table zyhb_arap_age_year_month (pk_org varchar2(20) , org_code varchar2(40), org_name varchar2(300) , 
	   pk_account varchar2(20), subj_code   varchar2(40), subj_name  varchar2(300), 
	   disp_name varchar2(300), balanorient NUMBER(28,8), ks_code varchar2(300), 
	   ks_name varchar2(300), ks_pk  varchar2(300) , voucher_date varchar2(10) , 
	   amount  NUMBER(28,8) ,year_month varchar2(6) ,PRIMARY KEY (org_code,subj_code, ks_code) )
     
     
     drop table zyhb_arap_age_year_month
     
     delete   from zyhb_arap_age_year_month   ; 
     
     
     commit; 
     
     
     select * from zyhb_arap_age_year_month  where year_month = '201701'  order by  ks_name,  subj_code,  voucher_date ; 
     select * from zyhb_arap_age_year_month  where year_month = '201712'  order by  ks_name,  subj_code,  voucher_date ;
         select distinct  ee.year_month   from zyhb_arap_age_year_month ee
     
     begin 
       zyhbrptfz.p_hx(org_code_param => '1000',subj_code_param => '112202%',beg_year_param => '2016' ,
beg_month_param => '01',end_year_param => '2016',end_month_param => '12') ; 

    end ; 
    

    
    CREATE SEQUENCE SEQ_arap INCREMENT BY 1  START WITH 1  NOMAXvalue  NOCYCLE  NOCACHE
    
    
begin 
  
  zyhbrptfz.p_hx(org_code_param => '1000',subj_code_param => '1122%',beg_year_param => '2016',beg_month_param => '01',
  end_year_param => '2016',end_month_param => '12',init_mark => 'y') ; 

end ; 

  decode( abs(aa.amount) - aa.amount  ,  0 ,  decode(aa.balanorient , 0 , '½è' , '´û'  ) , decode(aa.balanorient , 0 , '´û' , '½è'  ) ) dir ,

  select aa.voucher_date voucher_date , aa.voucher_date  business_date , 
  decode(aa.balanorient , 0 , '½è' , '´û'  )  dir , 
  'CNY' cny , '' hx_number , 'init' zhaiyao , '' pingzhenghao , '' pingzhengleibie, 
  aa.amount  yuanbi_amount, aa.amount  benbi_amount ,  '¿ÍÉÌ' aux1 , aa.ks_code  aux_content1,  '¿â´æ×éÖ¯' aux2 , '' aux_content2
  from zyhb_arap_age_year_month aa 
  where 
  aa.org_code = '1000'
  and aa.subj_code = '112202'
  and aa.year_month = '201712'  
  order by  ks_name,  subj_code,  voucher_date ;
  
  select  distinct balanorient , name  from bd_acctype  where dr = 0 
  
  
  
  select aa.voucher_date voucher_date , aa.voucher_date  business_date , 
  decode(aa.balanorient , 0 , '½è' , '´û'  )  dir , 
  'CNY' cny , '' hx_number , 'init' zhaiyao , '' pingzhenghao , '' pingzhengleibie, 
  aa.amount  yuanbi_amount, aa.amount  benbi_amount ,  '¿ÍÉÌ' aux1 , aa.ks_code  aux_content1
  from zyhb_arap_age_year_month aa 
  where 
  aa.org_code = '1000'
  and aa.subj_code = '112202'
  and aa.year_month = '201712'  
  order by  ks_name,  subj_code,  voucher_date ;
  


    
    
