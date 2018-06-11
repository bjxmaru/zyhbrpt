create or replace package zyhbrpt is

   --default org code 
   
   V_ORG_CODE constant  varchar2(90)   := '1000' ; 
   
   --default report org system  primary key  
   V_RPT_ORG_SYS constant varchar2(20) := '1001A1100000000CZ6WX' ;
   
   
   --default report org system version id 
   V_RPT_ORG_SYS_V constant varchar2(20) := '0001A110000000051X4K' ;
   
   
   -- report org  info with children 
   
   cursor cur_org_rpt(rpt_code_param varchar2 default  V_ORG_CODE ,
                      rpt_org_sys    varchar2 default  V_RPT_ORG_SYS , 
                      rpt_org_sys_v  varchar2 default  V_RPT_ORG_SYS_V) is 
   
          select a.* 
          from   org_reportmanastrumember_v  a 
          where
          11=11
          and a.dr = 0 
          and a.pk_svid = rpt_org_sys_v
          and a.pk_rms= rpt_org_sys   ;
     
          
          
   type nt_org_rpt is table of cur_org_rpt%rowtype ;  
   
   
   function f_nt_org_rpt(rpt_code_param varchar2 default V_ORG_CODE)  
   return nt_org_rpt 
   pipelined; 



end zyhbrpt;
/
create or replace package body zyhbrpt is



 -- report org  info with children 
 
 function f_nt_org_rpt(rpt_code_param varchar2 default V_ORG_CODE)  
   return nt_org_rpt 
   pipelined
   is
   l_nt_org_rpt  nt_org_rpt  := new nt_org_rpt() ;
   begin    
       open cur_org_rpt(rpt_code_param) ;
         fetch cur_org_rpt   bulk collect into l_nt_org_rpt ;
       close cur_org_rpt ;
           
       for x  in 1 .. l_nt_org_rpt.count loop    
         pipe row(l_nt_org_rpt(x)) ; 
       end loop; 
           
       return ;   
    
   end ; 

begin
  
   null; 
end zyhbrpt;
/
