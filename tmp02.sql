begin 
  
  zyhbrptfz.p_hx(org_code_param => '1000',subj_code_param => '1122%',beg_year_param => '2016',beg_month_param => '12',
  end_year_param => '2017',end_month_param => '12',init_mark => 'n') ; 

end ; 


   select * from zyhb_arap_age_year_month  where year_month = '201701'  order by  ks_name,  subj_code,  voucher_date ; 
   
   
begin 
  
  zyhbrptfz.p_hx(org_code_param => '1000',subj_code_param => '1122%',beg_year_param => '2016',beg_month_param => '01',
  end_year_param => '2016',end_month_param => '12',init_mark => 'y') ; 

end ; 
