create or replace package zyhbrpt is

   --default org code 
   
   V_ORG_CODE constant  varchar2(90)   := '1000' ; 
   
   --default report org system  primary key  
   V_RPT_ORG_SYS constant varchar2(20) := '1001A1100000000CZ6WX' ;
   
   
   --default report org system version id 
   V_RPT_ORG_SYS_V constant varchar2(20) := '0001A110000000051X4K' ;
   
   
   
   --default report org  consolidate  system  primary key  
   V_RPT_ORG_SYS_CONSOLIDATE constant varchar2(20) := '1001A1100000000D2S6J' ;
   
   
   --default report org  consolidate  system version id 
   V_RPT_ORG_SYS_CONSOLIDATE_V constant varchar2(20) := '0001A110000000052JJX' ;
   
   --300 charaset 
   
   V_300_STR  constant  org_orgs.name%type :=  'aa' ; 
   V_40_STR   constant  org_orgs.code%type :=  'bb' ; 
   V_20_STR   constant  varchar2(20) :=  'bb' ; 
   
   
   -- report org  info without children ,single row
   
   cursor cur_org_rpt_single(rpt_code_param varchar2 default  V_ORG_CODE ) is 
        
            select  aa.code  father_rpt_org_code , aa.name father_rpt_org_name , 
            aa.pk_reportorg  father_pk_rpt_org, aa.pk_vid  father_pk_rpt_org_vid ,
            bb.pk_org  father_pk_org   , bb.code   father_org_code , bb.name  father_org_name , bb.pk_vid father_pk_org_vid
            from  org_orgs bb  , org_reportorg aa 
            where 
            11=11
            and bb.dr = 0 
            and bb.pk_org = aa.pk_reportorg
            and aa.dr = 0 
            and aa.code = rpt_code_param    ;       
          
   type nt_org_rpt_single is table of cur_org_rpt_single%rowtype ;  
   
    
   function f_nt_org_rpt_single(rpt_code_param varchar2 default V_ORG_CODE)  
   return nt_org_rpt_single 
   pipelined; 
   
   
   
   

   
   
   -- report org  info with children 
   
   cursor cur_org_rpt(rpt_code_param varchar2 default  V_ORG_CODE ,
                      rpt_org_sys    varchar2 default  V_RPT_ORG_SYS , 
                      rpt_org_sys_v  varchar2 default  V_RPT_ORG_SYS_V) is 
                      
          with a_all as 
          (
            select c.code children_org_code , c.name  children_org_name, 
            c.pk_org  pk_children_org  , b.code  children_rpt_code,  b.name children_rpt_name, 
            a.pk_fatherorg pk_father_report_org_join
            from  org_orgs c  , org_reportorg_v b , org_reportmanastrumember_v  a 
            where
            11=11
            and c.pk_org = b.pk_reportorg        
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
            aa.pk_reportorg  father_pk_rpt_org, aa.pk_vid  father_pk_rpt_org_vid ,
            bb.pk_org  fahter_pk_org   , bb.code   father_org_code , bb.name  father_org_name , bb.pk_vid father_pk_org_vid
            from  org_orgs bb  , org_reportorg aa 
            where 
            11=11
            and bb.dr = 0 
            and bb.pk_org = aa.pk_reportorg
            and aa.dr = 0 
            and aa.code like rpt_code_param    
          ) , 
          a_father_children as 
          (
            select * 
            from  a_all   bbb ,  a_father aaa 
            where 
            11=11
            and  bbb.pk_father_report_org_join  (+)= aaa.father_pk_rpt_org
          )
          
          select * from a_father_children
          ;
     
          
          
   type nt_org_rpt is table of cur_org_rpt%rowtype ;  
   
   
   function f_nt_org_rpt(rpt_code_param varchar2 default V_ORG_CODE)  
   return nt_org_rpt 
   pipelined; 
   
   
   --report consolidate  org info with children 
   
   cursor cur_org_rpt_consolidate(rpt_code_param varchar2 default  V_ORG_CODE ,
                      rpt_org_sys_consolidate    varchar2 default  V_RPT_ORG_SYS_CONSOLIDATE , 
                      rpt_org_sys_consolidate_v  varchar2 default  V_RPT_ORG_SYS_CONSOLIDATE_V) is 
                      
          with a_all as 
          (
            select c.code children_org_code , c.name  children_org_name, 
            c.pk_org  children_pk_org  , b.code  children_rpt_code,  b.name children_rpt_name, b.pk_reportorg children_pk_report_org ,
            a.pk_fatherorg pk_father_report_org_join
            from  org_orgs c  , org_reportorg_v b , ORG_RCSMEMBER_v  a
            where
            11=11
            and c.pk_org = b.pk_reportorg
            and b.dr = 0 
            and b.pk_vid = a.pk_orgvid
            and b.pk_reportorg = a.pk_org
            and a.dr = 0 
            and a.pk_svid = rpt_org_sys_consolidate_v
            and a.pk_rcs= rpt_org_sys_consolidate  
          ) , 
          a_father as 
          (
            select  aa.code  father_rpt_org_code , aa.name father_rpt_org_name , 
            aa.pk_reportorg  father_pk_rpt_org, aa.pk_vid  father_pk_rpt_org_vid ,
            bb.pk_org  fahter_pk_org   , bb.code   father_org_code , bb.name  father_org_name , bb.pk_vid father_pk_org_vid 
            from  org_orgs bb  , org_reportorg aa 
            where 
            11=11
            and bb.dr = 0 
            and bb.pk_org = aa.pk_reportorg
            and aa.dr = 0 
            and aa.code like rpt_code_param    
          ) , 
          
          a_father_children as 
          (
           select bbb.children_org_code , bbb.children_org_name, bbb.children_pk_org , 'n'  b_children_is_father ,
             'n' b_father 
            from  a_all   bbb ,  a_father aaa 
            where 
            11=11
            and  bbb.pk_father_report_org_join  (+)= aaa.father_pk_rpt_org     
          )  
          select * from a_father_children  ;
     
          
          
   type nt_org_rpt_consolidate is table of cur_org_rpt_consolidate%rowtype ;  
   
   
   
   --report consolidate  org info with children   ; 
   function f_nt_org_rpt_consolidate(rpt_code_param varchar2 default V_ORG_CODE ,
                                     rpt_org_sys_consolidate    varchar2 default  V_RPT_ORG_SYS_CONSOLIDATE , 
                                     rpt_org_sys_consolidate_v  varchar2 default  V_RPT_ORG_SYS_CONSOLIDATE_V)  
   return nt_org_rpt_consolidate
   pipelined; 
   


   --report org for consolidate , with children  org   list  
   
   cursor cur_father_org_with_children( rpt_org_sys_consolidate    varchar2 default  V_RPT_ORG_SYS_CONSOLIDATE , 
                                        rpt_org_sys_consolidate_v  varchar2 default  V_RPT_ORG_SYS_CONSOLIDATE_V) 
   is
    select  distinct  s.PK_FATHERMEMBER  , s.PK_FATHERORG  from ORG_RCSMEMBER  s
    where  11=11
    and s.PK_FATHERORG <> '~'
    and s.PK_RCS = rpt_org_sys_consolidate and s.PK_SVID =rpt_org_sys_consolidate_v ; 
    
   type nt_father_org_with_children is table of cur_father_org_with_children%rowtype ;  
   
   
   --org info 
   
   cursor cur_org_info(org_code varchar2) 
   is
   select code org_code , name  org_name , pk_org  
   from org_orgs 
   where  code = org_code ; 
   
   type nt_org_info   is table of cur_org_info%rowtype ; 
   
   
   
   --fix assert  info  
   
   cursor cur_fa_detail(pk_org varchar2 default 1000) 
   is
   select   V_40_STR  org_code_  ,  V_300_STR org_name_  ,   V_20_STR pk_org_ ,  aa.* 
   from fa_cardhistory  aa 
   where 1=1 
   and aa.pk_org = pk_org ; 
   
   
   type  nt_fa_detail  is table of cur_fa_detail%rowtype ;
   
   --fix assert  detail  list 
   function f_fa_detail(org_code  varchar2) 
   return nt_fa_detail 
   pipelined; 
   
   
   
   
   
    


end zyhbrpt;
/
create or replace package body zyhbrpt is




 -- report org  info  without children ,single 
 
 function f_nt_org_rpt_single(rpt_code_param varchar2 default V_ORG_CODE)  
   return nt_org_rpt_single 
   pipelined
   is
   l_nt_org_rpt_single  nt_org_rpt_single  := new nt_org_rpt_single() ;
   begin    
       open cur_org_rpt_single(rpt_code_param) ;
         fetch cur_org_rpt_single   bulk collect into l_nt_org_rpt_single ;
       close cur_org_rpt_single ;
           
       for x  in 1 .. l_nt_org_rpt_single.count loop    
         pipe row(l_nt_org_rpt_single(x)) ; 
       end loop; 
           
       return ;   
    
   end ; 



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
   
   
   
  --report consolidate  org info with children  , but not include itselft ; 
 
 function f_nt_org_rpt_consolidate(rpt_code_param varchar2 default V_ORG_CODE , 
                                   rpt_org_sys_consolidate    varchar2 default  V_RPT_ORG_SYS_CONSOLIDATE , 
                                   rpt_org_sys_consolidate_v  varchar2 default  V_RPT_ORG_SYS_CONSOLIDATE_V)  
   return nt_org_rpt_consolidate 
   pipelined
   is
   l_nt_org_rpt_consolidate  nt_org_rpt_consolidate  := new nt_org_rpt_consolidate() ;
   l_nt_father_org_with_children nt_father_org_with_children := new nt_father_org_with_children() ; 
   l_nt_org_rpt_single   nt_org_rpt_single  := new nt_org_rpt_single() ;
   l_count  pls_integer  :=  0; 
   begin    
       open cur_org_rpt_consolidate(rpt_code_param,rpt_org_sys_consolidate ,rpt_org_sys_consolidate_v ) ;
         fetch cur_org_rpt_consolidate   bulk collect into l_nt_org_rpt_consolidate ;
       close cur_org_rpt_consolidate ;
       
       
       open cur_father_org_with_children(rpt_org_sys_consolidate ,rpt_org_sys_consolidate_v) ; 
         fetch cur_father_org_with_children bulk collect into l_nt_father_org_with_children ;
       close   cur_father_org_with_children  ; 
       
       
        open cur_org_rpt_single(rpt_code_param)  ; 
         fetch cur_org_rpt_single  bulk collect into l_nt_org_rpt_single ; 
        close cur_org_rpt_single ; 
        
        
       
       
       
           
         
       for x  in 1 .. l_nt_org_rpt_consolidate.count loop  
         for  y in 1 .. l_nt_father_org_with_children.count   loop 
             if(  l_nt_org_rpt_consolidate(x).children_pk_org = l_nt_father_org_with_children(y).PK_FATHERORG ) then 
                   l_nt_org_rpt_consolidate(x).b_children_is_father := 'y' ; 
                   exit;
             end if;
         end loop; 
        
        
       end loop; 
       
       if(l_nt_org_rpt_single.count> 0)  then 
          l_nt_org_rpt_consolidate.extend; 
          l_count := l_nt_org_rpt_consolidate.count; 
          l_nt_org_rpt_consolidate(l_count).children_org_code := l_nt_org_rpt_single(1).father_org_code; 
          l_nt_org_rpt_consolidate(l_count).children_org_name := l_nt_org_rpt_single(1).father_org_name; 
          l_nt_org_rpt_consolidate(l_count).children_pk_org   := l_nt_org_rpt_single(1).father_pk_org; 
          l_nt_org_rpt_consolidate(l_count).b_children_is_father := 'y';
          l_nt_org_rpt_consolidate(l_count).b_father :='y' ; 
         
       end if;
       
    
       
       for x  in 1 .. l_nt_org_rpt_consolidate.count loop     
          pipe row(l_nt_org_rpt_consolidate(x)) ; 
       end loop ;
       
     
           
       return ;   
    
   end ; 
   
   



   --fix assert  detail  list 
   function f_fa_detail(org_code  varchar2) 
   return nt_fa_detail 
   pipelined
   is
   l_nt_fa_detail  nt_fa_detail := new nt_fa_detail() ; 
   l_nt_org_info   nt_org_info  := new nt_org_info() ; 
   l_pk_org varchar2(20) ;
   l_org_code  org_orgs.code%type ;
   l_org_name  org_orgs.name%type ; 
   
   begin 
     
  /*  open  cur_org_info(org_code); 
    fetch cur_org_info bulk collect into l_nt_org_info; 
    close cur_org_info ; */
    
    execute immediate 'select code org_code,name org_name,pk_org from org_orgs where rownum =1  and code=:1' 
    into   l_org_code ,l_org_name, l_pk_org  using org_code ; 
    

     
    open cur_fa_detail(l_pk_org ) ; 
    fetch cur_fa_detail bulk collect into l_nt_fa_detail ; 
    close cur_fa_detail ; 
    
    for x  in 1 .. l_nt_fa_detail.count loop
      l_nt_fa_detail(x).org_code_ := l_org_code ; 
      l_nt_fa_detail(x).org_name_ := l_org_name ;
      l_nt_fa_detail(x).pk_org_ := l_pk_org ;     
      pipe row(l_nt_fa_detail(x)) ; 
    
    end loop; 
   
   return; 
   
   end ; 

   

begin
  
   null; 
end zyhbrpt;
/
