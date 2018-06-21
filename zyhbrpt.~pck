create or replace package zyhbrpt is

   --default org code 
   
   V_ORG_CODE constant  varchar2(90)   := '1000' ; 
 
   
   --300 charaset 
   
   V_300_STR  constant  org_orgs.name%type :=  'aa' ; 
   
    --40 charaset
   V_40_STR   constant  org_orgs.code%type :=  'bb' ; 
   
    --20 charaset
   V_20_STR   constant  varchar2(20) :=  'bb' ; 
   
   
   --fixed asset catalory  name   machine 
   
   V_FIX_ASSET_CATEGORY_MACHINE constant   fa_category.cate_name%type:= '机器设备' ;
   V_FIX_ASSET_CATEGORY_BUILDING constant  fa_category.cate_name%type:= '房屋及建筑物' ;
   V_FIX_ASSET_CATEGORY_VEHICLE constant  fa_category.cate_name%type:= '运输工具' ;
   V_FIX_ASSET_CATEGORY_OTHER constant  fa_category.cate_name%type:= '电子设备及其他' ;
   

   
   -- calculate the date for fixed asset  info 
   
   type rcd_fa_date is record (

      end_year_param  varchar2(4) , 
      end_month_param varchar2(2) ,
      begin_year_param varchar2(4),
      begin_month_param varchar2(2),
      end_year   varchar2(4) , --for bal 
      end_month  varchar2(4) , --for bal 
      begin_year_dep varchar2(4) ,   --for depreciation 
      begin_month_dep varchar2(2) ,  --for depreciation 
      end_year_dep varchar2(4)   ,  --for depreciation 
      end_month_dep varchar2(2)  --for depreciation 
   
      
   
   ) ;  
   
   
   
   --fix assert depreciation   info  
   
   cursor cur_fa_dep(pk_org_param varchar2 default 1000 ,  
                        end_year_dep_param varchar2 default '2018',
                        end_month_dep_param varchar2 default '02',
                        begin_year_dep_param varchar2 default '2018' ,
                        begin_month_dep_param varchar2 default '06' ,
                        fa_code     varchar2 default '201801290241'    
                       
    ) 
   is
   with dep_before_sum as (
   select bb.cate_code fa_cate_code , 
   case bb.cate_name  
        when V_FIX_ASSET_CATEGORY_MACHINE   then  V_FIX_ASSET_CATEGORY_MACHINE 
        when V_FIX_ASSET_CATEGORY_BUILDING  then  V_FIX_ASSET_CATEGORY_BUILDING 
        when V_FIX_ASSET_CATEGORY_VEHICLE   then  V_FIX_ASSET_CATEGORY_VEHICLE 
        else V_FIX_ASSET_CATEGORY_OTHER
   end fa_cate_name ,       
   cc.asset_code  fa_code , 
   cc.asset_name  fa_name,  
   dd.style_name  fa_add_reduce_style_name, 
   decode( aa.accyear||aa.period  ,end_year_dep_param||end_month_dep_param  , aa.originvalue , 0 ) fa_value, 
   decode( aa.accyear||aa.period  ,end_year_dep_param||end_month_dep_param  , aa.accudep , 0 )  fa_accu_dep ,
   aa.depamount  fa_curr_dep
   from  pam_addreducestyle dd , fa_card cc , fa_category bb  , fa_cardhistory  aa 
   where 1=1 
   and dd.dr = 0 
   and dd.pk_addreducestyle = cc.pk_addreducestyle
   and cc.dr = 0 
   and cc.asset_code like  fa_code 
   and cc.pk_card =  aa.pk_card
   and bb.dr = 0 
   and bb.pk_category = aa.pk_category_old 
   and aa.newasset_flag <>1
   and aa.laststate_flag = 'N'
   and aa.asset_state = 'exist'
   and aa.dr = 0 
   and (  ( aa.period between  begin_month_dep_param and '12' and   aa.accyear =  begin_year_dep_param )  
          or 
          ( aa.period between  '01' and end_month_dep_param   and   aa.accyear  = end_year_dep_param )
       ) 
   and aa.pk_org = pk_org_param  ) , 
   
   dep_sum as 
   (
   select fa_cate_name , fa_code , fa_name ,  
   fa_add_reduce_style_name, sum( fa_value) fa_value, sum( fa_accu_dep ) fa_accu_dep, 
   sum(fa_curr_dep)  fa_curr_dep
   from dep_before_sum 
   group by fa_cate_name , fa_code , fa_name , fa_add_reduce_style_name 
   
   )
   
   select * from dep_sum ; 
   
   
   type  nt_fa_dep  is table of cur_fa_dep%rowtype ;
   
   
   function  f_fa_dep(org_code varchar2 default 1000 ,  
                        end_year_param varchar2 default '2018',
                        end_month_param varchar2 default '06',
                     
                        begin_year_param varchar2 default '2018' ,
                        begin_month_param varchar2 default '01'  ,
                        fa_code     varchar2 default '201801290241'           
   )
   return nt_fa_dep 
   pipelined; 
 
   
   
   
   
   
    


end zyhbrpt;
/
create or replace package body zyhbrpt is



   l_sql_org_info constant  varchar2(2000)  := 
   'select code org_code,name org_name ,PK_FINANCEORG pk_org from org_financeorg where  code=:1'  ;


   
 
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
    
    
    l_rcd_fa_date.begin_year_param :=  begin_year_param; 
    l_rcd_fa_date.begin_month_param := begin_month_param ; 
    
    
    
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
   function f_fa_dep(org_code  varchar2 ,     
                        end_year_param varchar2 default '2018' ,
                        end_month_param varchar2 default '06' ,
                      
                        begin_year_param varchar2 default '2018' ,
                        begin_month_param varchar2 default '01'    ,
                         fa_code     varchar2 default '201801290241'
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
    

     
    open cur_fa_dep(l_pk_org ,l_rcd_fa_date.end_year_dep , l_rcd_fa_date.end_month_dep , 
                    l_rcd_fa_date.begin_year_dep , l_rcd_fa_date.begin_month_dep , fa_code ) ; 
    fetch cur_fa_dep bulk collect into l_nt_fa_dep ; 
    close cur_fa_dep ; 
    
    for x  in 1 .. l_nt_fa_dep.count loop
     /* l_nt_fa_dep(x).org_code := l_org_code ; 
      l_nt_fa_dep(x).org_name := l_org_name ;
      l_nt_fa_dep(x).pk_org := l_pk_org ;  */   
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
