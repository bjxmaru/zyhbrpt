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
   
   
   --fixed assert  book primary key 
   V_FIX_ASSET_BOOK_PK  constant varchar2(20) := '1001A11000000008I9D3' ;
   
   
   -- calculate the date for fixed asset  info 
   
   type rcd_fa_date is record (

      end_year_param  varchar2(4) , 
      end_month_param varchar2(2) ,
      end_year   varchar2(4) , 
      end_month  varchar2(4) ,
      begin_year_dep varchar2(4) , 
      begin_month_dep varchar2(2) , 
      end_year_dep varchar2(4)   , 
      end_month_dep varchar2(2)
   
   ) ;  
   
   
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
   
   
   
   --fix assert  balance  info  
   
   cursor cur_fa_detail(pk_org_param varchar2 default 1000 ,  
                        end_year_param varchar2 default '2018' ,
                        end_month_param varchar2 default '06' , 
                        fa_code     varchar2 default '201801290241' 
    ) 
   is
   select   aa.newasset_flag, aa.laststate_flag ,V_40_STR  org_code  ,  V_300_STR org_name  ,   
   V_20_STR pk_org , aa.accyear  fa_year , 
   aa.period  fa_month , bb.cate_code fa_cate_code , bb.cate_name  fa_cate_name , 
   cc.asset_code  fa_code , cc.asset_name  fa_name,  dd.style_code fa_add_reduce_style_code , 
   dd.style_name  fa_add_reduce_style_name, aa.localoriginvalue fa_value, 
   aa.accudep fa_accu_dep ,aa.depamount  fa_curr_dep
   from  pam_addreducestyle dd , fa_card cc , fa_category bb  , fa_cardhistory  aa 
   where 1=1 
   and dd.dr = 0 
   and dd.pk_addreducestyle = cc.pk_addreducestyle
   and cc.dr = 0 
   and cc.asset_code like  fa_code 
   and cc.pk_card =  aa.pk_card
   and bb.dr = 0 
   and bb.pk_category = aa.pk_category_old 
   and aa.newasset_flag >=10
   and aa.laststate_flag = 'N'
   and aa.asset_state = 'exist'
   and aa.accyear = end_year_param
   and aa.period = end_month_param 
   and aa.dr = 0 
   and aa.pk_org = pk_org_param ; 
   
   
   type  nt_fa_detail  is table of cur_fa_detail%rowtype ;
   
   --fix assert  detail  list 
   function f_fa_detail(org_code  varchar2 , 
                        end_year_param varchar2 default '2018' ,
                        end_month_param varchar2 default '06' ,
                        fa_code     varchar2 default '201801290241' ) 
   return nt_fa_detail 
   pipelined; 
   
   
   
    --fix assert depreciation   info  
   
   cursor cur_fa_dep(pk_org_param varchar2 default 1000 ,  
                        end_year_dep_param varchar2 default '2018',
                        end_month_dep_param varchar2 default '02',
                        fa_code     varchar2 default '201801290241' ,
                        begin_year_dep_param varchar2 default '2018' ,
                        begin_month_dep_param varchar2 default '06'        
                       
    ) 
   is
   select   V_40_STR  org_code  ,  V_300_STR org_name  ,   V_20_STR pk_org , end_year_dep_param  fa_year , 
   end_month_dep_param  fa_month , bb.cate_code fa_cate_code , bb.cate_name  fa_cate_name , 
   cc.asset_code  fa_code , cc.asset_name  fa_name,  dd.style_code fa_add_reduce_style_code , 
   dd.style_name  fa_add_reduce_style_name, 
   sum( decode( aa.accyear||aa.period  ,end_year_dep_param||end_month_dep_param  , aa.originvalue , 0 )) fa_value, 
   sum( decode( aa.accyear||aa.period  ,end_year_dep_param||end_month_dep_param  , aa.accudep , 0 ) ) fa_accu_dep ,
   sum(aa.depamount)  fa_curr_dep
   from  pam_addreducestyle dd , fa_card cc , fa_category bb  , fa_cardhistory  aa 
   where 1=1 
   and dd.dr = 0 
   and dd.pk_addreducestyle = cc.pk_addreducestyle
   and cc.dr = 0 
   and cc.asset_code like  fa_code 
   and cc.pk_card =  aa.pk_card
   and bb.dr = 0 
   and bb.pk_category = aa.pk_category_old 
   and aa.newasset_flag >=10
   and aa.laststate_flag = 'N'
   and aa.asset_state = 'exist'
   and aa.dr = 0 
   and (  ( aa.period between  begin_month_dep_param and '12' and   aa.accyear =  begin_year_dep_param )  
          or 
          ( aa.period between  '01' and end_month_dep_param   and   aa.accyear  = end_year_dep_param )
       ) 
   and aa.pk_org = pk_org_param  
   group by bb.cate_code , bb.cate_name  ,cc.asset_code  , 
   cc.asset_name  ,  dd.style_code  , dd.style_name      ; 
   
   
   type  nt_fa_dep  is table of cur_fa_dep%rowtype ;
   
   
   function  f_fa_dep(org_code varchar2 default 1000 ,  
                        end_year_param varchar2 default '2018',
                        end_month_param varchar2 default '06',
                        fa_code     varchar2 default '201801290241' ,
                        begin_year_param varchar2 default '2018' ,
                        begin_month_param varchar2 default '01'                 
   )
   return nt_fa_dep 
   pipelined; 
 
   
   
   
   
   
    


end zyhbrpt;
/
create or replace package body zyhbrpt is



 l_sql_org_info varchar2(2000)  := 'select code org_code,name org_name,pk_org from org_orgs where rownum =1  and code=:1'  ;

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
   
   
   
   

   -- calculate the date for fixed asset  info 
   
   function f_fa_date(end_year_param  varchar2 default '2018' , 
                      end_month_param  varchar2 default '01'  , 
                      begin_year_param varchar2 default '2018' ,
                      begin_month_param varchar2 default '01')
   return rcd_fa_date 
   is
   l_rcd_fa_date  rcd_fa_date ;  
   begin 
     
    l_rcd_fa_date.end_year_param := end_year_param; 
    l_rcd_fa_date.end_month_param := end_month_param ; 
    
    
    
    if ((mod(to_number(end_month_param), 12) + 1) < 10) then
            l_rcd_fa_date.end_month := '0' || to_char((mod(to_number(end_month_param), 12) + 1));     
    else
            l_rcd_fa_date.end_month := to_char((mod(to_number(end_month_param), 12) + 1));    
    end if;
    
    l_rcd_fa_date.end_month_dep :=  l_rcd_fa_date.end_month ;
    
    
    if (end_month_param = '12') then
            l_rcd_fa_date.end_year := to_char(to_number(end_year_param) + 1);        
    else
            l_rcd_fa_date.end_year := end_year_param;     
    end if;
    
    
    l_rcd_fa_date.end_year_dep :=  l_rcd_fa_date.end_year ; 
    
    
   
    if ((mod(to_number(begin_month_param), 12) + 1) < 10) then
            l_rcd_fa_date.begin_month_dep := '0' || to_char((mod(to_number(begin_month_param), 12) + 1));     
    else
            l_rcd_fa_date.begin_month_dep := to_char((mod(to_number(begin_month_param), 12) + 1));    
    end if;

    if (begin_month_param = '12') then
             l_rcd_fa_date.begin_year_dep := to_char(to_number(begin_year_param) + 1);
    else
             l_rcd_fa_date.begin_year_dep:= begin_year_param;
    end if;
    
    
    
    
    return l_rcd_fa_date; 
   
   end ; 



   --fix assert  detail  list 
   function f_fa_detail(org_code  varchar2 ,     
                        end_year_param varchar2 default '2018' ,
                        end_month_param varchar2 default '06' ,
                        fa_code     varchar2 default '201801290241'
                         ) 
   return nt_fa_detail 
   pipelined
   is
   l_nt_fa_detail  nt_fa_detail := new nt_fa_detail() ; 
   l_pk_org varchar2(20) ;
   l_org_code  org_orgs.code%type ;
   l_org_name  org_orgs.name%type ; 
   l_rcd_fa_date  rcd_fa_date ; 
   begin 
     
   
    l_rcd_fa_date := f_fa_date(end_year_param , end_month_param ) ; 
    
    execute immediate  l_sql_org_info  
    into   l_org_code ,l_org_name, l_pk_org  using org_code ; 
    

     
    open cur_fa_detail(l_pk_org ,l_rcd_fa_date.end_year , l_rcd_fa_date.end_month , fa_code ) ; 
    fetch cur_fa_detail bulk collect into l_nt_fa_detail ; 
    close cur_fa_detail ; 
    
    for x  in 1 .. l_nt_fa_detail.count loop
      l_nt_fa_detail(x).org_code := l_org_code ; 
      l_nt_fa_detail(x).org_name := l_org_name ;
      l_nt_fa_detail(x).pk_org := l_pk_org ;     
      pipe row(l_nt_fa_detail(x)) ; 
    
    end loop; 
   
   return; 
   
   exception 
     
        when others   then 
   
        if( cur_fa_detail%isopen ) then 
        
        
           close cur_fa_detail ; 
        
        end if; 
   end ; 



 --fix assert  detail  list 
   function f_fa_dep(org_code  varchar2 ,     
                        end_year_param varchar2 default '2018' ,
                        end_month_param varchar2 default '06' ,
                        fa_code     varchar2 default '201801290241',
                        begin_year_param varchar2 default '2018' ,
                        begin_month_param varchar2 default '01'     
                         ) 
   return nt_fa_dep
   pipelined
   is
   l_nt_fa_dep  nt_fa_dep := new nt_fa_dep() ; 
   l_pk_org varchar2(20) ;
   l_org_code  org_orgs.code%type ;
   l_org_name  org_orgs.name%type ; 
   l_rcd_fa_date  rcd_fa_date ; 
   begin 
     
   
    l_rcd_fa_date := f_fa_date(end_year_param , end_month_param , begin_year_param , begin_month_param) ; 
    
    execute immediate  l_sql_org_info  
    into   l_org_code ,l_org_name, l_pk_org  using org_code ; 
    

     
    open cur_fa_dep(l_pk_org ,l_rcd_fa_date.end_year_dep , l_rcd_fa_date.end_month_dep , fa_code , 
                    l_rcd_fa_date.begin_year_dep , l_rcd_fa_date.begin_month_dep ) ; 
    fetch cur_fa_dep bulk collect into l_nt_fa_dep ; 
    close cur_fa_dep ; 
    
    for x  in 1 .. l_nt_fa_dep.count loop
      l_nt_fa_dep(x).org_code := l_org_code ; 
      l_nt_fa_dep(x).org_name := l_org_name ;
      l_nt_fa_dep(x).pk_org := l_pk_org ;     
      pipe row(l_nt_fa_dep(x)) ; 
    
    end loop; 
   
   return; 
   
   exception 
     
        when others   then 
   
        if( cur_fa_dep%isopen ) then 
        
           close cur_fa_dep ; 
        
        end if; 
   end ; 
   

begin
  
   null; 
end zyhbrpt;
/
