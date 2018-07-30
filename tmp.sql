

select * from table(zyhbrptfz.f_cur_tb_beg(org_code_param => '1007Z',subj_code_param => '1122%',beg_year_param => '2016' , 
beg_month_param => '01',end_year_param => '2016',end_month_param => '02'))

select * from table(zyhbrptfz.f_cur_tb_accur(org_code_param => '1007Z',subj_code_param => '1122%',beg_year_param => '2016' ,
beg_month_param => '00',end_year_param => '2016',end_month_param => '01'))  

select * from table(zyhbrptfz.f_hx(org_code_param => '1000',subj_code_param => '1122%',beg_year_param => '2016' ,
beg_month_param => '01',end_year_param => '2016',end_month_param => '12')) 


select * from table(zyhbrptfz.f_hx(org_code_param => '1000',subj_code_param => '1122%',beg_year_param => '2016' ,
beg_month_param => '01',end_year_param => '2016',end_month_param => '12')) 


select * from table(zyhbrptfz.f_arap_age_year_month_tb(org_code_param => '1008Z',subj_code_param => '224110.*',
end_year_param => '2016',end_month_param => '12')) 

select * from table(zyhbrptfz.f_arap_age_year_month_tb(org_code_param => '1008Z',subj_code_param => '224110.*',
end_year_param => '2017',end_month_param => '12')) 


     
     drop table zyhb_arap_age_year_month
     
     delete   from zyhb_arap_age_year_month   ; 
     
     
     commit; 
     
     
     select * from zyhb_arap_age_year_month  where year_month = '201601' and subj_code like '1122%' and org_code = '1007Z' 
       order by  ks_name,  subj_code,  voucher_date ; 
       
       
     select * from zyhb_arap_age_year_month  where year_month = '201712' and subj_code like '1122%' and org_code = '1007Z' 
       order by  ks_name,  subj_code,  voucher_date ; 
       
       
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
  
  select * from bd_project 
  
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
  


    
    
