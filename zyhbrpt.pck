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
   
   --fixed asset add style name 
   V_FIX_ASSET_ADD_PURCHASE  constant  pam_addreducestyle.style_name%type := '直接购入' ;
   V_FIX_ASSET_ADD_CONSTRUCTURE  constant  pam_addreducestyle.style_name%type := '在建工程转入' ;
   V_FIX_ASSET_ADD_OTHER  constant  pam_addreducestyle.style_name%type := '其他' ;

   
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
      end_month_dep varchar2(2)   --for depreciation 
      
   
      
   
   ) ;  
   
   
   
   --fix assert depreciation   info  
   
   cursor cur_fa(pk_org_param varchar2 default '1000' , 
                     begin_year_param  varchar2 default '2018',
                     begin_month_param varchar2  default '01' ,
                     end_year_dep_param varchar2 default '2018',
                     end_month_dep_param varchar2 default '02' ,
                     begin_year_dep_param varchar2  default '2018',   
                     begin_month_dep_param varchar2 default '02' ,   
                     fa_code     varchar2 default '201801290241'    
                       
    ) 
   is
   with bal_dep_before_sum as (
   select
   case bb.cate_name  
        when V_FIX_ASSET_CATEGORY_MACHINE   then  V_FIX_ASSET_CATEGORY_MACHINE 
        when V_FIX_ASSET_CATEGORY_BUILDING  then  V_FIX_ASSET_CATEGORY_BUILDING 
        when V_FIX_ASSET_CATEGORY_VEHICLE   then  V_FIX_ASSET_CATEGORY_VEHICLE 
        else V_FIX_ASSET_CATEGORY_OTHER
   end fa_cate_name ,       
   cc.asset_code  fa_code , 
   cc.asset_name  fa_name,  
   case dd.style_name 
     when V_FIX_ASSET_ADD_PURCHASE then  V_FIX_ASSET_ADD_PURCHASE 
     when V_FIX_ASSET_ADD_CONSTRUCTURE then V_FIX_ASSET_ADD_CONSTRUCTURE
     else  V_FIX_ASSET_ADD_OTHER
   end fa_add_reduce_style_name ,
   decode( aa.accyear||aa.period  ,begin_year_param||begin_month_param  , decode( aa.newasset_flag ,1, 0 , decode(  aa.asset_state ,'reduce' , 0  , aa.localoriginvalue)) , 0 ) fa_value_begin, 
   decode( aa.accyear||aa.period  ,begin_year_param||begin_month_param ,  decode( aa.newasset_flag ,1,0 , decode( aa.asset_state ,'reduce' , 0 ,aa.accudep)) , 0 )  fa_accu_dep_begin ,
   0 fa_curr_dep_begin ,  
   decode(aa.accyear||aa.period  ,  end_year_dep_param||end_month_dep_param , 0 ,decode( aa.newasset_flag ,1, aa.localoriginvalue , 0)  ) fa_value_add,
   

   decode( aa.accyear||aa.period  ,end_year_dep_param||end_month_dep_param  , decode( aa.newasset_flag ,1,0 ,aa.localoriginvalue) , 0 ) fa_value_end, 
   decode( aa.accyear||aa.period  ,end_year_dep_param||end_month_dep_param  , decode( aa.newasset_flag ,1,0 ,aa.accudep) , 0 )  fa_accu_dep_end ,
   case 
       when 
            aa.accyear||aa.period >= begin_year_dep_param || begin_month_dep_param  then   aa.depamount 
       else  0 
   end   fa_curr_dep_end 
   from  pam_addreducestyle dd , fa_card cc , fa_category bb  , fa_cardhistory  aa 
   where 1=1 
   and dd.dr = 0 
   and dd.pk_addreducestyle = cc.pk_addreducestyle
   and cc.dr = 0 
   and cc.asset_code like  fa_code 
   and cc.pk_card =  aa.pk_card
   and bb.dr = 0 
   and bb.pk_category = aa.pk_category_old 
   --and aa.newasset_flag <>1
   and aa.laststate_flag = 'N'
   --and aa.asset_state = 'exist'
   and aa.dr = 0 
   and  aa.accyear||aa.period  <= end_year_dep_param ||end_month_dep_param
   and  aa.accyear||aa.period  >= begin_year_param || begin_month_param 
   and aa.pk_org = pk_org_param  ) , 
   
   bal_dep_sum as 
   (
   select fa_cate_name , fa_code , fa_name ,  
   fa_add_reduce_style_name,  sum( fa_value_begin) fa_value_begin, sum( fa_accu_dep_begin ) fa_accu_dep_begin, 
   sum(fa_curr_dep_begin)  fa_curr_dep_begin ,  sum(fa_value_add)  fa_value_add ,
   sum( fa_value_end) fa_value_end, sum( fa_accu_dep_end ) fa_accu_dep_end, 
   sum(fa_curr_dep_end)  fa_curr_dep_end 
   from bal_dep_before_sum 
   group by fa_cate_name , fa_code , fa_name , fa_add_reduce_style_name 
   
   ) 
  
   
   
   
   select * from bal_dep_sum ; 
   
   
   type  nt_fa  is table of cur_fa%rowtype ;
   
   
   function  f_fa(org_code varchar2 default 1000 ,  
                        end_year_param varchar2 default '2018',
                        end_month_param varchar2 default '06',
                        begin_year_param varchar2 default '2018' ,
                        begin_month_param varchar2 default '01'  ,
                        fa_code     varchar2 default '201801290241'           
   )
   return nt_fa 
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
   function f_fa(org_code  varchar2 ,     
                        end_year_param varchar2 default '2018' ,
                        end_month_param varchar2 default '06' ,
                        begin_year_param varchar2 default '2018' ,
                        begin_month_param varchar2 default '01'    ,
                         fa_code     varchar2 default '201801290241'
                         ) 
   return nt_fa
   pipelined
   is
   l_nt_fa  nt_fa := new nt_fa() ; 
   l_pk_org varchar2(20) ;
   l_org_code  org_orgs.code%type ;
   l_org_name  org_orgs.name%type ; 
   l_rcd_fa_date  rcd_fa_date ; 
   begin 
     
   
    l_rcd_fa_date := f_fa_date(end_year_param , end_month_param , begin_year_param , begin_month_param) ; 
    
    execute immediate  l_sql_org_info  
    into   l_org_code ,l_org_name, l_pk_org  using org_code ; 
    

     
    open cur_fa(l_pk_org ,l_rcd_fa_date.begin_year_param , l_rcd_fa_date.begin_month_param , 
                    l_rcd_fa_date.end_year_dep , l_rcd_fa_date.end_month_dep , 
                    l_rcd_fa_date.begin_year_dep , l_rcd_fa_date.begin_month_dep , fa_code ) ; 
    fetch cur_fa bulk collect into l_nt_fa ; 
    close cur_fa ; 
    
    for x  in 1 .. l_nt_fa.count loop
     /* l_nt_fa(x).org_code := l_org_code ; 
      l_nt_fa(x).org_name := l_org_name ;
      l_nt_fa(x).pk_org := l_pk_org ;  */   
      pipe row(l_nt_fa(x)) ; 
    
    end loop; 
   
   return; 
   
   exception 
     
        when others   then 
   
        if( cur_fa%isopen ) then 
        
           close cur_fa ; 
        
        end if; 
   end ; 
   

begin
  
   null; 
end zyhbrpt;
/
