create or replace package zyhbrptfz  authid current_user is

   procedure  p_arap_create_table  ;
   
   
   cursor cur_tb_beg(org_code_param varchar2 , subj_code_param varchar2 , beg_year_param varchar2  ,beg_month_param varchar2 , 
     end_year_param varchar2  , end_month_param varchar2  )  
    is
    select   pk_org  , org_code , org_name , pk_account , subj_code , subj_name , disp_name, 
       balanorient , ks_code , ks_name, ks_pk , ry_code, ry_name,ry_pk, voucher_date ,  year_month , amount  ,'n' handle_mark  
    from 
    (
    select pk_org  , org_code , org_name , pk_account , subj_code , subj_name , disp_name, 
       balanorient , ks_code , ks_name, ks_pk , ry_code, ry_name,ry_pk, voucher_date ,  year_month, sum(amount ) amount 
from 
(
select aa.pk_financeorg pk_org , aa.code org_code, aa.name org_name  ,  ff.pk_account pk_account  , 
       ff.code  subj_code , ee.name subj_name , ee.dispname  disp_name , gg.balanorient,
       nvl(ii.code , ee.dispname) ks_code ,nvl(ii.name , ee.dispname) ks_name, nvl(ii.pk_cust_sup ,ee.dispname) ks_pk ,
       nvl(kk.code , ee.dispname) ry_code ,nvl(kk.name , ee.dispname) ry_name, nvl(kk.pk_psndoc ,ee.dispname) ry_pk ,
       decode( gg.balanorient, 0,   cc.localdebitamount - cc.localcreditamount ,  cc.localcreditamount -  cc.localdebitamount ) amount , 
       beg_year_param ||'-01-01' voucher_date  ,  end_year_param||end_month_param  year_month 
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
       
left join  bd_psndoc   kk 
      on (
      
             kk.pk_psndoc =  hh.f2 
             and kk.dr = 0 
      
      )       
       
        
left join  bd_cust_supplier  ii
      on (
      
             ii.pk_cust_sup = hh.f4
             and ii.dr = 0 
      
      ) 
)
group by  pk_org  , org_code , org_name , pk_account , subj_code , subj_name , disp_name, 
       balanorient , ks_code , ks_name, ks_pk ,ry_code, ry_name, ry_pk ,  voucher_date  , year_month
       )  order by  org_code, subj_code, ks_code, voucher_date  ;

type  nt_tb_beg  is table of  cur_tb_beg%rowtype ; 


function f_cur_tb_beg (org_code_param varchar2 , subj_code_param varchar2 , beg_year_param varchar2  ,
   beg_month_param varchar2 , end_year_param varchar2 , end_month_param  varchar2)
  return nt_tb_beg 
  pipelined  ; 
  

 cursor cur_tb_accur(org_code_param varchar2 , subj_code_param varchar2 , beg_year_param varchar2 ,
 beg_month_param varchar2 , end_year_param varchar2 , end_month_param varchar2  )
 is
select pk_org  , org_code , org_name , pk_account , subj_code , subj_name , disp_name, 
     balanorient , ks_code , ks_name, ks_pk ,  ry_code,  ry_name,   ry_pk, 
     voucher_date , year_month    ,amount  ,'n' handle_mark 
from 
(
select  aa.pk_financeorg pk_org , aa.code org_code, aa.name org_name  ,  ff.pk_account pk_account  , 
        ff.code  subj_code , ee.name subj_name , ee.dispname  disp_name , gg.balanorient,
       nvl(ii.code , ee.dispname) ks_code ,nvl(ii.name , ee.dispname) ks_name, nvl(ii.pk_cust_sup ,ee.dispname) ks_pk ,
       nvl(kk.code , ee.dispname) ry_code ,nvl(kk.name , ee.dispname) ry_name, nvl(kk.pk_psndoc ,ee.dispname) ry_pk ,
       substr(cc.PREPAREDDATEV , 1, 10)  voucher_date  ,
       decode( gg.balanorient, 0,   cc.localdebitamount - cc.localcreditamount ,  
       cc.localcreditamount -  cc.localdebitamount )  amount , 
       end_year_param ||end_month_param   year_month 
      
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
           and cc.yearv||cc.periodv <= end_year_param || end_month_param|| 'Z'
           and cc.yearv||cc.periodv > beg_year_param||beg_month_param
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
       
left join  bd_psndoc   kk 
      on (
      
             kk.pk_psndoc =  hh.f2 
             and kk.dr = 0 
      
      )           
       
       
       
left join  bd_cust_supplier  ii
      on (
      
             ii.pk_cust_sup = hh.f4
             and ii.dr = 0 
      
      ) 
)  order by  org_code, subj_code,  ks_code, ry_code ,  voucher_date;


type nt_tb_accur  is table of  cur_tb_accur%rowtype ; 


function f_cur_tb_accur (org_code_param varchar2 , subj_code_param varchar2 , beg_year_param varchar2 , beg_month_param  varchar2 , 
   end_year_param varchar2 , end_month_param varchar2  )
  return nt_tb_accur 
  pipelined ;


cursor arap_voucher_detail(org_code_param varchar2 , subj_code_param varchar2 , beg_year_param varchar2 , beg_month_param  varchar2  , 
end_year_param varchar2 , end_month_param  varchar2)
is
select  pk_org  , org_code , org_name , pk_account , subj_code , subj_name , disp_name, 
     balanorient , ks_code , ks_name, ks_pk ,ry_code, ry_name, ry_pk, voucher_date ,year_month,   amount  ,'n'  handle_mark  
from  zyhb_arap_age_year_month 
where 
year_month =  beg_year_param ||beg_month_param 
and org_code =  org_code_param
order by  org_code , subj_code, ks_code,ry_code,  voucher_date  ;


type nt_arap_voucher_detail   is table of   arap_voucher_detail%rowtype ;


procedure p_hx(org_code_param varchar2 , subj_code_param varchar2 , beg_year_param varchar2 ,
              beg_month_param varchar2 , end_year_param varchar2 , end_month_param varchar2 ,init_mark  varchar2  default 'n' )  ;
              
              
function f_hx(org_code_param varchar2 , subj_code_param varchar2 , beg_year_param varchar2 ,
              beg_month_param varchar2 , end_year_param varchar2 , end_month_param varchar2 ,init_mark  varchar2  default 'n' ) 
              
 return nt_tb_accur
 pipelined ;

cursor  cur_arap_age_year_month_tb(org_code_param varchar2 , subj_code_param varchar2 , end_year_param varchar2 , end_month_param varchar2) 
is
select  pk_org  , org_code , org_name , pk_account , subj_code , subj_name , disp_name, 
     balanorient , ks_code , ks_name, ks_pk  , ry_code, ry_name ,ry_pk,  sum(amount) amount 
from  zyhb_arap_age_year_month 
where   
1=1
and   regexp_like(subj_code , subj_code_param) 
and org_code = org_code_param  
and  year_month = end_year_param || end_month_param 
group by pk_org  , org_code , org_name , pk_account , subj_code , subj_name , disp_name, 
     balanorient , ks_code , ks_name, ks_pk , ry_code, ry_name ,ry_pk  ; 


type  nt_arap_age_year_month_tb  is table of cur_arap_age_year_month_tb%rowtype ;


function  f_arap_age_year_month_tb(org_code_param varchar2 , subj_code_param varchar2 , end_year_param varchar2 , end_month_param varchar2) 
return  nt_arap_age_year_month_tb 
pipelined; 


end zyhbrptfz;
/
create or replace package body zyhbrptfz is

 l_create_sequence varchar2(2000) := 'CREATE  SEQUENCE SEQ_arap INCREMENT BY 1  START WITH 1  NOMAXvalue  NOCYCLE  NOCACHE' ; 


 l_insert_arap_age_year_month  varchar2(2000)  := 'insert into  zyhb_arap_age_year_month values( :pk_number ,:pk_org , :org_code , :org_name, :pk_account ,    ' ||
                       ':subj_code , :subj_name,  :disp_name  , :balanorient , :ks_code, :ks_name  ,  :ks_pk , :ry_code, :ry_name, :ry_pk ,  '  ||
                       ':voucher_date , :amount, :year_month  ) ' ; 
                       
                       
  
 l_delete_arap_age_year_month  varchar2(2000)  :=
  ' delete from  zyhb_arap_age_year_month where  year_month > :beg_year_month_param  and subj_code like :subj_code_param  and org_code = :org_code_param ' ;                   
                       
 l_delete_arap_age_year_month_1  varchar2(2000)  :=
  ' delete from  zyhb_arap_age_year_month where  year_month >= :beg_year_month_param and subj_code like :subj_code_param  and org_code = :org_code_param  ' ;  

 l_arap_creat_table_1 varchar2(2000) := ' create table zyhb_arap_age_year_month ( pk_number number(38) primary key ,pk_org varchar2(20) , ' 
      || 'org_code varchar2(40), org_name varchar2(300) , 
	   pk_account varchar2(20), subj_code   varchar2(40), subj_name  varchar2(300), 
	   disp_name varchar2(300), balanorient NUMBER(28,8), ks_code varchar2(300), 
	   ks_name varchar2(300), ks_pk  varchar2(300) , ry_code varchar2(300), 
	   ry_name varchar2(300), ry_pk  varchar2(300) , voucher_date varchar2(10) , 
	   amount  NUMBER(28,8) ,year_month varchar2(6)  )' ;  
     
 l_idx_arap_age_year_month varchar2(2000) :=  ' create index  idx_arap_age on zyhb_arap_age_year_month (year_month) ' ; 
 
 l_arap_creat_table_2 varchar2(2000) := 'create table   zyhb_arap_age_year_month(  year_month char(6) ,  pk_org char(20) ) '; 
 
 
 
 l_query_table   varchar2(2000) := ' select  count(table_name)   exist_mark  from all_tables  where owner = (select user from dual) '
                                 || ' and table_name = :table_name_param '  ; 
                                 
 function f_daynum(the_year  varchar2 , the_month varchar2)
  return char 
    is 
    l_daynum char(2) ;
    begin
         case  the_month 
              when  '01'   then  l_daynum :='31' ;
                when  '03' then  l_daynum :='31' ;
                when  '05' then  l_daynum :='31' ;
                when  '07' then  l_daynum :='31' ;
              when  '08' then  l_daynum :='31' ;
              when  '10' then  l_daynum :='31' ;
                when  '12' then  l_daynum :='31' ;
                when  '04' then  l_daynum :='31' ;
                when  '06' then  l_daynum :='31' ;
                when  '09' then  l_daynum :='31' ;
              when  '11' then  l_daynum :='31' ;
              when  '02' then  
                     if(mod(to_number(the_year),4)=0) then 
                        l_daynum :='29' ;
                     else 
                          l_daynum :='28' ;
                     end if ;
         end case ;
         return l_daynum;     
 end ;                                
                                 
                                 
 procedure   p_arap_create_table
   is
   l_exist_arap_age  pls_integer  := 0 ; 
   l_exist_arap_age_year_month  pls_integer  := 0 ; 
   l_arap_age varchar2(200) := 'zyhb_arap_age' ; 
   l_arap_age_year_month varchar2(200) := 'zyhb_arap_age_year_month ' ; 
   begin 

      execute immediate l_query_table  into l_exist_arap_age  using  upper(l_arap_age)   ; 
      
    
    
      if ( l_exist_arap_age =1 ) then 
        
          execute immediate  'drop  table ' || l_arap_age   ; 
      
      end if;  
      
      
      execute immediate l_arap_creat_table_1 ; 
      
      commit; 
      

     
       execute immediate l_query_table  into l_exist_arap_age_year_month  using  upper(l_arap_age_year_month)   ; 
      
        if ( l_exist_arap_age_year_month =1 ) then 
        
          execute immediate  'drop table ' || l_arap_age_year_month   ; 
      
      end if;  
      
      
      execute immediate  l_arap_creat_table_2 ; 
      
      null;
     
   end ; 
   
   
   
  function f_cur_tb_beg (org_code_param varchar2 , subj_code_param varchar2 , beg_year_param varchar2  , 
    beg_month_param varchar2 , end_year_param varchar2 , end_month_param  varchar2)
  return nt_tb_beg 
  pipelined  
  is
  l_tbl  nt_tb_beg := new nt_tb_beg() ; 
  begin 
    
     open cur_tb_beg (org_code_param , subj_code_param , beg_year_param ,beg_month_param, end_year_param, end_month_param) ; 
     fetch cur_tb_beg bulk collect into l_tbl ; 
     close cur_tb_beg ; 
     
     
     for x in 1 .. l_tbl.count loop 
       
           pipe row (l_tbl(x)) ; 
         
     end loop; 
      
  
     return ;
     
     exception 
       
            when others then 
              
                if( cur_tb_beg  %isopen ) then 
                
                    close cur_tb_beg ;
                
                end if; 
     end ; 
     
     
     
     
  function f_cur_tb_accur (org_code_param varchar2 , subj_code_param varchar2 , 
   beg_year_param varchar2 , beg_month_param  varchar2 , 
   end_year_param varchar2 , end_month_param varchar2  )
  return nt_tb_accur 
  pipelined
  is
  l_tbl  nt_tb_accur := new nt_tb_accur() ; 
  begin 
    
     open cur_tb_accur (org_code_param , subj_code_param , beg_year_param , beg_month_param  ,end_year_param, end_month_param ) ; 
     fetch cur_tb_accur bulk collect into l_tbl ; 
     close cur_tb_accur ; 
     
     
     
     for x in 1 .. l_tbl.count loop 
       
           pipe row (l_tbl(x)) ; 
         
     end loop; 
      
  
     return ;
    
  
     exception 
       
            when others then 
              
                if( cur_tb_beg  %isopen ) then 
                
                    close cur_tb_beg ;
                
                end if; 
     end ; 
  

 
 
 
procedure p_hx(org_code_param varchar2 , subj_code_param varchar2 , beg_year_param varchar2 ,
              beg_month_param varchar2 , end_year_param varchar2 , end_month_param varchar2 ,init_mark  varchar2  default 'n' ) 
is
 l_beg_table  nt_arap_voucher_detail := new nt_arap_voucher_detail() ; 
 l_beg_table_init  nt_tb_beg := new nt_tb_beg() ; 
 l_accur_table  nt_tb_accur := new nt_tb_accur() ;
 l_bal_count pls_integer := 0 ;
 l_accur_count pls_integer := 0 ;  
 l_find_mark  pls_integer :=0 ; 
 l_acur_beg_month varchar2(2) := '00' ; 
 begin 
   
   if(init_mark = 'n') then 
   
       l_acur_beg_month  := beg_month_param ; 
   
       open arap_voucher_detail(org_code_param , subj_code_param , beg_year_param, beg_month_param , end_year_param , end_month_param ) ;
       fetch arap_voucher_detail bulk collect into l_beg_table ; 
       close arap_voucher_detail ; 
   else  
        l_acur_beg_month  := '00' ; 
   
        open cur_tb_beg(org_code_param , subj_code_param, beg_year_param, '00' ,end_year_param, end_month_param) ; 
        fetch cur_tb_beg bulk collect into l_beg_table_init ;
        close cur_tb_beg ; 
   
   end if;
   

   
   open cur_tb_accur(org_code_param , subj_code_param , beg_year_param, l_acur_beg_month, end_year_param, end_month_param) ;
       fetch cur_tb_accur bulk collect into l_accur_table ; 
   close cur_tb_accur ; 
   
   
   if ( l_beg_table_init.count >=1 and init_mark = 'y') then  
   
       for x  in 1 ..  l_beg_table_init.count loop 
       
            l_beg_table.extend; 
            l_beg_table(x) := l_beg_table_init(x) ;
       
       end loop; 
   
  end if;
  
  
  
  
  for x  in 1 .. l_accur_table.count loop
   
  
       if(  l_accur_table(x).amount = 0  or l_accur_table(x).handle_mark ='y' ) then 
       
            continue; 
            
       end if; 
    
       l_accur_count := x +1 ; 
       
       
       
       for  y  in  l_accur_count  .. l_accur_table.count loop 
       
                 if( l_accur_table(x).org_code = l_accur_table(y).org_code  and  
                   l_accur_table(x).subj_code = l_accur_table(y).subj_code and 
                   l_accur_table(x).ks_code = l_accur_table(y).ks_code  and 
                   l_accur_table(x).ry_code = l_accur_table(y).ry_code  )  then 
                   
                        if( l_accur_table(x).amount = - l_accur_table(y).amount  ) then 
                        
                                      l_accur_table(x).amount := 0 ; 
                                      l_accur_table(y).amount := 0 ;  
                                      l_accur_table(x).handle_mark :='y' ; 
                                      l_accur_table(y).handle_mark :='y' ; 
                                      
                                      
                                      exit ;
                        
                        end if; 
                   
                   
                 end if; 
          
       
      end loop ; 
          
  
 end loop; 
  
  

  for x  in  1   ..  l_beg_table.count loop  
  
         l_bal_count  := x; 
         
         if( l_beg_table(x).amount = 0  or  l_beg_table(x).handle_mark ='y'  ) then 
              continue ; 
         end if; 

         
         for y in 1 .. l_accur_table.count loop 
               
                if(l_accur_table(y).amount = 0  or l_accur_table(y).handle_mark = 'y'  ) then 
                         
                      continue; 
                 
                end if; 
                 
               if( l_beg_table(x).org_code = l_accur_table(y).org_code  and  
                   l_beg_table(x).subj_code = l_accur_table(y).subj_code and 
                   l_beg_table(x).ks_code = l_accur_table(y).ks_code and 
                   l_beg_table(x).ry_code = l_accur_table(y).ry_code )  then 
                   
                    
               
                      if(l_beg_table(x).amount * l_accur_table(y).amount  <0   )  then 
                      
                            if(abs(l_beg_table(x).amount ) <= abs(l_accur_table(y).amount)  ) then 
                            
                                    l_accur_table(y).amount  := l_accur_table(y).amount +   l_beg_table(x).amount ; 
                                    l_beg_table(x).amount := 0 ; 
                                    exit; 
                                
                            
                            else 
                            
                                    l_beg_table(x).amount := l_accur_table(y).amount +  l_beg_table(x).amount ; 
                                    l_accur_table(y).amount := 0 ;    
                              
                                      
                            end if; 
                      
                     end if; 
                    
               
               end if; 
               
              
               
         
        end loop; 
  
  
  
  end loop; 
  

  

  
  for x  in 1 .. l_accur_table.count loop
  
         l_accur_count :=  x +1; 
         
         if( l_accur_table(x).amount = 0 or  l_accur_table(x).handle_mark = 'y'  ) then 
         
                continue ; 
         
          end if; 
          
          
         for y  in   l_accur_count  ..   l_accur_table.count loop
         
        
         
                 if( l_accur_table(y).handle_mark ='y'  or l_accur_table(y).amount = 0  )  then 
                      
                          continue; 
                 
                 end if; 
                  
         
                 if( l_accur_table(x).org_code = l_accur_table(y).org_code  and  
                   l_accur_table(x).subj_code = l_accur_table(y).subj_code and 
                   l_accur_table(x).ks_code = l_accur_table(y).ks_code  and 
                   l_accur_table(x).ry_code = l_accur_table(y).ry_code )  then 
                    
                   
                        if(l_accur_table(x).amount * l_accur_table(y).amount  <0   )  then 
                      
                            if(abs(l_accur_table(x).amount ) <= abs(l_accur_table(y).amount)  ) then 
                            
                                    l_accur_table(y).amount  := l_accur_table(y).amount +   l_accur_table(x).amount ; 
                                    l_accur_table(x).amount := 0 ; 
                                    exit;
                                
                            
                            else 
                            
                                    l_accur_table(x).amount := l_accur_table(y).amount +  l_accur_table(x).amount ; 
                                    l_accur_table(y).amount := 0 ;    
                              
                                      
                            end if; 
                      
                     end if; 
                   
                 
                 
                  end if; 
                  
                 
         
        end loop ;  
  
  
 end loop; 
 

 
      savepoint  p_hx ;  
 
      if( init_mark = 'y') then
       
          execute immediate  l_delete_arap_age_year_month_1   
          using beg_year_param|| beg_month_param , subj_code_param ,org_code_param; 
      
      else  
 
      execute immediate  l_delete_arap_age_year_month   
          using beg_year_param||beg_month_param  , subj_code_param ,org_code_param; 
      
      end if; 
 
 
     for x  in 1 .. l_beg_table.count loop 
       
               if(  l_beg_table(x).amount <> 0) then 
               
                    execute immediate  l_insert_arap_age_year_month 
                    using seq_arap.nextval, l_beg_table(x).pk_org,  
                    l_beg_table(x).org_code, 
                    l_beg_table(x).org_name, 
                    l_beg_table(x).pk_account, 
                    l_beg_table(x).subj_code, 
                    l_beg_table(x).subj_name, 
                    l_beg_table(x).disp_name, 
                    l_beg_table(x).balanorient, 
                    l_beg_table(x).ks_code, 
                    l_beg_table(x).ks_name, 
                    l_beg_table(x).ks_pk, 
                    l_beg_table(x).ry_code, 
                    l_beg_table(x).ry_name, 
                    l_beg_table(x).ry_pk,
                    l_beg_table(x).voucher_date, 
                    l_beg_table(x).amount,
                    --l_beg_table(x).year_month  ; 
                    end_year_param||end_month_param ; 
        
                       
                end if; 
        
       end loop ; 
       
       

       
       for x in  1 ..   l_accur_table.count   loop
       
                if(l_accur_table(x).amount <>0) then 
                 
                   execute immediate   l_insert_arap_age_year_month  
                    using seq_arap.nextval ,l_accur_table(x).pk_org,  
                    l_accur_table(x).org_code, 
                    l_accur_table(x).org_name, 
                    l_accur_table(x).pk_account, 
                    l_accur_table(x).subj_code, 
                    l_accur_table(x).subj_name, 
                    l_accur_table(x).disp_name, 
                    l_accur_table(x).balanorient, 
                    l_accur_table(x).ks_code, 
                    l_accur_table(x).ks_name, 
                    l_accur_table(x).ks_pk, 
                    l_beg_table(x).ry_code, 
                    l_beg_table(x).ry_name, 
                    l_beg_table(x).ry_pk,
                    l_accur_table(x).voucher_date, 
                    l_accur_table(x).amount,
                    l_accur_table(x).year_month  ; 
                    
                    
           
                end if; 
       
      end loop ; 
      

      
      commit; 
      
  /*
   exception 
   
         when  others    then 
         
         
              if  (cur_tb_accur % isopen ) then close cur_tb_accur ;  end if ; 
              if  (cur_tb_beg % isopen )   then  close cur_tb_beg  ; end if ; 
 
 
 							rollback to p_hx ;  
    */          
   
 end ; 
 
 
 
 
 function f_hx(org_code_param varchar2 , subj_code_param varchar2 , beg_year_param varchar2 ,
              beg_month_param varchar2 , end_year_param varchar2 , end_month_param varchar2 ,init_mark  varchar2  default 'n' ) 
              
 return nt_tb_accur
 pipelined
is
 l_beg_table  nt_arap_voucher_detail := new nt_arap_voucher_detail() ; 
 l_beg_table_init  nt_tb_beg := new nt_tb_beg() ; 
 l_accur_table  nt_tb_accur := new nt_tb_accur() ;
 l_bal_count pls_integer := 0 ;
 l_accur_count pls_integer := 0 ;  
 l_find_mark  pls_integer :=0 ; 
 begin 
  
   if(init_mark = 'n') then 
   
       open arap_voucher_detail(org_code_param , subj_code_param , beg_year_param, beg_month_param ,end_year_param , end_month_param  ) ;
       fetch arap_voucher_detail bulk collect into l_beg_table ; 
       close arap_voucher_detail ; 
   else  
   
        open cur_tb_beg(org_code_param , subj_code_param, beg_year_param ,beg_month_param , end_year_param, end_month_param ) ; 
        fetch cur_tb_beg bulk collect into l_beg_table_init ;
        close cur_tb_beg ; 
   
   end if;
   
   
   open cur_tb_accur(org_code_param , subj_code_param , beg_year_param, beg_month_param, end_year_param, end_month_param) ;
       fetch cur_tb_accur bulk collect into l_accur_table ; 
   close cur_tb_accur ; 
   
   
   if ( l_beg_table_init.count > 0) then  
   
       for x  in 1 ..  l_beg_table_init.count loop 
       
            l_beg_table.extend; 
            l_beg_table(x) := l_beg_table_init(x) ;
       
       end loop; 
   
  end if;
  
  
  
  
  for x  in 1 .. l_accur_table.count loop
   
  
       if(  l_accur_table(x).amount = 0  or l_accur_table(x).handle_mark ='y' ) then 
       
            continue; 
            
       end if; 
    
       l_accur_count := x +1 ; 
       
       
       
       for  y  in  l_accur_count  .. l_accur_table.count loop 
       
                 if( l_accur_table(x).org_code = l_accur_table(y).org_code  and  
                   l_accur_table(x).subj_code = l_accur_table(y).subj_code and 
                   l_accur_table(x).ks_code = l_accur_table(y).ks_code  )  then 
                   
                        if( l_accur_table(x).amount = - l_accur_table(y).amount  ) then 
                        
                                      l_accur_table(x).amount := 0 ; 
                                      l_accur_table(y).amount := 0 ;  
                                      l_accur_table(x).handle_mark :='y' ; 
                                      l_accur_table(y).handle_mark :='y' ; 
                                      
                                      
                                      exit ;
                        
                        end if; 
                   
                   
                 end if; 
          
       
      end loop ; 
          
  
 end loop; 
  
  

  l_accur_count := 1; 
  for x  in  1   ..  l_beg_table.count loop  
  
         l_bal_count  := x; 
         
         
         if( l_beg_table(x).amount = 0  or  l_beg_table(x).handle_mark ='y'  ) then 
         
              continue ; 
         end if; 
         
         
         l_find_mark := 0 ;
 
         
         for y in l_accur_count .. l_accur_table.count loop 
        
         
               l_accur_count :=  y ; 
               
          
               
               
               if( l_find_mark = 3) then 
               
                  exit; 
                  
                end if; 
               
               if(l_accur_table(y).amount = 0  or l_accur_table(y).handle_mark = 'y'  ) then 
                       
                    continue; 
               
              end if; 
               
               if( l_beg_table(x).org_code = l_accur_table(y).org_code  and  
                   l_beg_table(x).subj_code = l_accur_table(y).subj_code and 
                   l_beg_table(x).ks_code = l_accur_table(y).ks_code  )  then 
                   
                      l_find_mark :=1 ; 
               
                      if(l_beg_table(x).amount * l_accur_table(y).amount  <0   )  then 
                      
                            if(abs(l_beg_table(x).amount ) <= abs(l_accur_table(y).amount)  ) then 
                            
                                    l_accur_table(y).amount  := l_accur_table(y).amount +   l_beg_table(x).amount ; 
                                    l_beg_table(x).amount := 0 ; 
                                    exit; 
                                
                            
                            else 
                            
                                    l_accur_table(x).amount := l_accur_table(y).amount +  l_beg_table(x).amount ; 
                                    l_accur_table(y).amount := 0 ;    
                              
                                      
                            end if; 
                      
                     end if; 
                    
               
               end if; 
               
               if(l_find_mark = 1 ) then 
                    l_find_mark := 2; 
               elsif(l_find_mark =2) then 
                    l_find_mark := 3 ; 
               else 
                    l_find_mark := 0 ; 
               end if;  
               
         
        end loop; 
  
  
  
  end loop; 
  
  
  l_accur_count := 0  ;
   
   
  
  
  for x  in 1 .. l_accur_table.count loop
  
         l_accur_count :=  x +1; 
         
         if( l_accur_table(x).amount = 0 or  l_accur_table(x).handle_mark = 'y'  ) then 
         
                continue ; 
         
          end if; 
          
          
         l_find_mark := 0 ; 
         
         for y  in   l_accur_count  ..   l_accur_table.count loop
         
         
         
                 if( l_find_mark = 3   ) then 
                 
                      exit; 
                 
                 end if ; 
         
                 if( l_accur_table(y).handle_mark ='y'  or l_accur_table(y).amount = 0  )  then 
                      
                          continue; 
                 
                 end if; 
                  
         
                 if( l_accur_table(x).org_code = l_accur_table(y).org_code  and  
                   l_accur_table(x).subj_code = l_accur_table(y).subj_code and 
                   l_accur_table(x).ks_code = l_accur_table(y).ks_code  )  then 
                   
                   
                        l_find_mark := 1 ; 
                   
                        if(l_accur_table(x).amount * l_accur_table(y).amount  <0   )  then 
                      
                            if(abs(l_accur_table(x).amount ) <= abs(l_accur_table(y).amount)  ) then 
                            
                                    l_accur_table(y).amount  := l_accur_table(y).amount +   l_accur_table(x).amount ; 
                                    l_accur_table(x).amount := 0 ; 
                                
                            
                            else 
                            
                                    l_accur_table(x).amount := l_accur_table(y).amount +  l_accur_table(x).amount ; 
                                    l_accur_table(y).amount := 0 ;    
                              
                                      
                            end if; 
                      
                     end if; 
                   
                 
                 
                  end if; 
                  
                  
                  if(l_find_mark =1  ) then 
                      
                        l_find_mark := 2 ; 
                  
                  elsif ( l_find_mark =2)  then 
                  
                       l_find_mark := 3; 
                        
                        
                  else
                  
                      l_find_mark  := 0 ; 
                  
                  end if; 
                  
                   
         
         
        end loop ;  
  
  
 end loop; 
 
 
 


 
     for x  in 1 .. l_beg_table.count loop 
       
               if(  l_beg_table(x).amount <> 0 ) then 
               
                    pipe row ( l_beg_table(x)) ; 
        
                       
                end if; 
        
       end loop ; 
       
    
    
       
       for x in  1 ..   l_accur_table.count   loop
       
                if(l_accur_table(x).amount <> 0 ) then 
                 
                   pipe row (l_accur_table(x)) ; 
                       
                end if; 
       
      end loop ; 
      
      
   
      

      

   exception 
   
         when  others    then 
         
         
              if  (cur_tb_accur % isopen ) then close cur_tb_accur ;  end if ; 
              if  (cur_tb_beg % isopen )   then  close cur_tb_beg  ; end if ; 
 


 end ; 
  
 
 
function  f_arap_age_year_month_tb(org_code_param varchar2 , subj_code_param varchar2 , 
  end_year_param varchar2 , end_month_param varchar2) 
return  nt_arap_age_year_month_tb 
pipelined
is
l_tbl   nt_arap_age_year_month_tb  :=  new nt_arap_age_year_month_tb() ; 
begin 
  
open cur_arap_age_year_month_tb(org_code_param , subj_code_param , end_year_param , end_month_param) ; 
fetch cur_arap_age_year_month_tb bulk collect into l_tbl ; 
close cur_arap_age_year_month_tb  ; 
        

for x  in 1  ..  l_tbl.count loop 
  
    pipe row (l_tbl(x)) ; 

end loop; 

return; 


exception 
  
       when others then 
         
             if( cur_arap_age_year_month_tb  % isopen )  then 
             
                        close cur_arap_age_year_month_tb ; 
             
             end if; 
end ;
  
begin
 
  null; 
end zyhbrptfz;
/
