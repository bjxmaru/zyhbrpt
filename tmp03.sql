

select * from table(zyhbrptfz.f_cur_tb_beg(org_code_param => '1000',subj_code_param => '1122%',beg_year_param => '2016'))

select * from table(zyhbrptfz.f_cur_tb_accur(org_code_param => '1000',subj_code_param => '1122%',beg_year_param => '2016' ,
beg_month_param => '01',end_year_param => '2016',end_month_param => '12'))  

select * from table(zyhbrptfz.f_hx(org_code_param => '1000',subj_code_param => '1122%',beg_year_param => '2016' ,
beg_month_param => '01',end_year_param => '2016',end_month_param => '12')) 


select * from table(zyhbrptfz.f_hx(org_code_param => '1000',subj_code_param => '1122%',beg_year_param => '2016' ,
beg_month_param => '01',end_year_param => '2016',end_month_param => '12')) 


  create table zyhb_arap_age_year_month (  pk_number integer  ,pk_org varchar2(20) , org_code varchar2(40), org_name varchar2(300) , 
     pk_account varchar2(20), subj_code   varchar2(40), subj_name  varchar2(300), 
     disp_name varchar2(300), balanorient NUMBER(28,8), ks_code varchar2(300), 
     ks_name varchar2(300), ks_pk  varchar2(300) , voucher_date varchar2(10) , 
     amount  NUMBER(28,8) ,year_month varchar2(6)  )
     
     
     drop table zyhb_arap_age_year_month
     
     
     select * from zyhb_arap_age_year_month ; 
     
     select * from org_orgs a  where a.countryzone <> '~' ; 
     
     
     
     begin 
       zyhbrptfz.p_hx(org_code_param => '1023',subj_code_param => '1221%',beg_year_param => '2016' ,
beg_month_param => '00',end_year_param => '2016',end_month_param => '12' , init_mark =>'y' ) ; 

    end ; 
    
      begin 
       zyhbrptfz.p_hx(org_code_param => '1023',subj_code_param => '1221%',beg_year_param => '2016' ,
beg_month_param => '12',end_year_param => '2017',end_month_param => '12',init_mark => 'n') ; 

    end ; 
 
    
    
    CREATE SEQUENCE SEQ_arap INCREMENT BY 1  START WITH 1  NOMAXvalue  NOCYCLE  NOCACHE  ;
    
     create index  idx_arap_age on zyhb_arap_age_year_month (year_month) ; 
     
     
     
     select * from  table( zyhbbi.f_arap(org_code_param => '1000',end_year_param => '2018',
     end_month_param => '05' ,beg_year_param => '2018',beg_month_param => '01',glf_mark_param => '[^(¼¯ÍÅÄÚ)]') )
