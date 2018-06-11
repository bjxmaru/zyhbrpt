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
                      
          with a_all as 
          (
            select c.code children_org_code , c.name  children_org_name, 
            c.pk_org  pk_children_org  , b.code  children_rpt_code,  b.name children_rpt_name, 
            a.pk_fatherorg pk_father_report_org_join , a.pk_org  pk_children_report_org
            from  org_orgs c  , org_reportorg_v b , org_reportmanastrumember_v  a 
            where
            11=11
            and c.pk_org = b.pk_org
            and b.dr = 0 
            and b.pk_vid = a.pk_orgvid
            and b.pk_reportorg = a.pk_org
            and a.dr = 0 
            and a.pk_svid = rpt_org_sys_v
            and a.pk_rms= rpt_org_sys   
          ) , 
          a_father as 
          (
            select  aa.code  father_rpt_org_code , aa.name father_rpt_org_name , 
            aa.pk_reportorg  father_pk_rpt_org, aa.pk_vid  father_pk_report_org_vid ,
            bb.pk_org  fahter_pk_org   , bb.code   father_org_code , bb.name  father_org_name , bb.pk_vid father_pk_org_vid
            from  org_orgs bb  , org_reportorg aa 
            where 
            11=11
            and bb.dr = 0 
            and bb.pk_org = aa.pk_org
            and aa.dr = 0 
            and aa.code like rpt_code_param    
          ) , 
          a_father_children as 
          (
            select * 
            from  a_all   bbb ,  a_father aaa 
            where 
            11=11
            and  bbb.pk_father_report_org_join  = aaa.father_pk_rpt_org
          )
          
          select * from a_father
          ;
     
          
          
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
