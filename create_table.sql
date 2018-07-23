      create table zyhb_arap_age_year_month (pk_org varchar2(20) , org_code varchar2(40), org_name varchar2(300) , 
	   pk_account varchar2(20), subj_code   varchar2(40), subj_name  varchar2(300), 
	   disp_name varchar2(300), balanorient NUMBER(28,8), ks_code varchar2(300), 
	   ks_name varchar2(300), ks_pk  varchar2(300) , voucher_date varchar2(10) , 
	   amount  NUMBER(28,8) ,year_month varchar2(6) ,PRIMARY KEY (org_code,subj_code, ks_code) )