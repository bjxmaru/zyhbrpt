create or replace package zyhbrpt_spec is


   --report orgination structure

  type rcd_rpt_org is record (
   
      org_code  varchar2(90)  , 
      org_name  varchar2(300)   ,
      pk_org    varchar2(20) , 
      pk_rpt_org  varchar2(20) 
      
  
  ) ; 
  
  
  type nt_rcd_rpt_org is table of  rcd_rpt_org  ; 
  
  
  
  

end zyhbrpt_spec;
/
create or replace package body zyhbrpt_spec is

 

begin
 

 null; 
end zyhbrpt_spec;
/
