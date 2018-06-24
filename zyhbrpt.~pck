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
   
   V_FIX_ASSET_REDUCE_USELESS  constant  pam_addreducestyle.style_name%type := '报废' ;
   V_FIX_ASSET_REDUCE_OTHER  constant  pam_addreducestyle.style_name%type := '其他' ;

   
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
   aa.localoriginvalue , aa.accudep , cc.pk_addreducestyle ,aa.newasset_flag ,aa.asset_state ,aa.pk_card ,
   
   
  decode(  begin_year_param || begin_month_param  , '201801' ,        
           decode( aa.accyear||aa.period , begin_year_param || begin_month_param , 
                 decode( aa.newasset_flag, 1 , 0,
                      decode( aa.asset_state ,'reduce' , 0, aa.localoriginvalue)) , 0 ),
           decode( aa.accyear||aa.period  , begin_year_param || begin_month_param  , 
                   decode(aa.newasset_flag ,0 , 0  , 1, 0 , 
                        decode(aa.asset_state , 'reduce' , 0 , aa.localoriginvalue) )  , 0 )
           ) fa_value_begin   ,    
           
   decode(   begin_year_param || begin_month_param  , '201801' ,        
           decode( aa.accyear||aa.period , begin_year_param || begin_month_param , 
                 decode( aa.newasset_flag, 1 , 0,
                      decode( aa.asset_state ,'reduce' , 0, aa.accudep)) , 0 ),
           decode( aa.accyear||aa.period  , begin_year_param || begin_month_param  , 
                   decode(aa.newasset_flag ,0 , 0  , 1, 0 , 
                        decode(aa.asset_state , 'reduce' , 0 , aa.accudep) )  , 0 )
           ) fa_accu_dep_begin   ,     
           
   0 fa_curr_dep_begin ,
   case  
      when   aa.accyear||aa.period <> end_year_dep_param||end_month_dep_param  
             and  aa.newasset_flag =1 then  aa.localoriginvalue 
      when   aa.accyear||aa.period < end_year_dep_param||end_month_dep_param   
             and  aa.accyear||aa.period <> '201801'   
             and    aa.newasset_flag = 0 then aa.localoriginvalue  
      else  0 
   end fa_value_add    ,  
   
   case  
      when   aa.accyear||aa.period <> end_year_dep_param||end_month_dep_param  
             and  aa.newasset_flag =1 then   aa.accudep
      when   aa.accyear||aa.period <> end_year_dep_param||end_month_dep_param   
             and  aa.accyear||aa.period <> '201801'   
             and    aa.newasset_flag = 0 then  aa.accudep
      else  0 
   end fa_accu_dep_add  ,  
   
   decode( aa.accyear||aa.period  ,begin_year_param||begin_month_param , 0 , 
           decode(  aa.asset_state ,'reduce' ,  aa.localoriginvalue , 0 ) )     fa_value_reduce , 
   decode( aa.accyear||aa.period  ,begin_year_param||begin_month_param , 0 , 
           decode(  aa.asset_state ,'reduce' ,  aa.accudep , 0 ) )     fa_accu_dep_reduce ,   
           
           
  decode(  end_year_dep_param || end_month_dep_param, '201801' , 
         
           decode( aa.accyear||aa.period , end_year_dep_param || end_month_dep_param , decode( aa.newasset_flag, 1 , 0,
                   decode( aa.asset_state ,'reduce' , 0, aa.localoriginvalue))  , 0 )  ,
                   
                   
           decode( aa.accyear||aa.period  ,end_year_dep_param || end_month_dep_param , 
                   decode(aa.newasset_flag ,0 , 0  , 1, 0 , 
                        decode(aa.asset_state , 'reduce' , 0 , aa.localoriginvalue) )  , 0 )
           ) fa_value_end  , 
           
           
  decode(  end_year_dep_param || end_month_dep_param , '201801' ,        
           decode( aa.accyear||aa.period , end_year_dep_param || end_month_dep_param , decode( aa.newasset_flag, 1 , 0,
                   decode( aa.asset_state ,'reduce' , 0, aa.accudep))  , 0 )  ,
           decode( aa.accyear||aa.period  , end_year_dep_param || end_month_dep_param , 
                   decode(aa.newasset_flag ,0 , 0  , 1, 0 , 
                        decode(aa.asset_state , 'reduce' , 0 , aa.accudep) )  , 0 )
           ) fa_accu_dep_end  ,            
                 

   case 
       when 
            aa.accyear||aa.period > begin_year_param||begin_month_param  then   aa.depamount 
       else  0 
   end   fa_curr_dep_end 
 
   from   fa_card cc , fa_category bb  , fa_cardhistory  aa 
   where 1=1 
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
   and aa.pk_org = pk_org_param  
   
   ) , 
   
   bal_dep_sum as 
   (
       select * from bal_dep_before_sum 
      
   )  , 
   
   fa_add as 
   (
   
     select aaa.fa_cate_name ,aaa.fa_code ,aaa.fa_name  ,
     decode( bbb.style_name , V_FIX_ASSET_ADD_PURCHASE ,  decode(  aaa.newasset_flag  , 0  , 0 , aaa.fa_value_add) , 0 ) fa_value_add_purchase ,
     decode( bbb.style_name , V_FIX_ASSET_ADD_PURCHASE ,  decode(  aaa.newasset_flag  , 0  , 0 ,aaa.fa_accu_dep_add) , 0 ) fa_accu_dep_add_purchase ,
     decode( bbb.style_name , V_FIX_ASSET_ADD_CONSTRUCTURE ,  decode(  aaa.newasset_flag  , 0  , 0 ,aaa.fa_value_add) , 0 ) fa_value_add_constructure ,
     decode( bbb.style_name , V_FIX_ASSET_ADD_CONSTRUCTURE ,  decode(  aaa.newasset_flag  , 0  , 0 , aaa.fa_accu_dep_add) , 0 ) fa_accu_dep_add_constructure , 
     case  
            when bbb.style_name = V_FIX_ASSET_ADD_PURCHASE and aaa.newasset_flag = 1   then  0  
            when bbb.style_name = V_FIX_ASSET_ADD_CONSTRUCTURE  and aaa.newasset_flag = 1  then  0 
            else  aaa.fa_value_add 
     end fa_value_add_other,   
     case  
           when bbb.style_name = V_FIX_ASSET_ADD_PURCHASE and aaa.newasset_flag = 1  then  0  
           when bbb.style_name = V_FIX_ASSET_ADD_CONSTRUCTURE  and aaa.newasset_flag = 1  then 0 
           else  aaa.fa_accu_dep_add 
     end fa_accu_dep_add_other
     from pam_addreducestyle bbb  , bal_dep_before_sum   aaa
     where 
     1=1
     and bbb.dr = 0 
     and bbb.pk_addreducestyle  = aaa.pk_addreducestyle
     and aaa.fa_value_add > 0 
     and aaa.newasset_flag  <10 
    
   ) , 
   
   fa_reduce as 
   (
   
     select mmm.fa_cate_name ,mmm.fa_code ,mmm.fa_name ,
     decode(ooo.style_name  , V_FIX_ASSET_REDUCE_USELESS , nnn.red_localoriginvalue , 0 )  fa_value_reduce_useless , 
     decode(ooo.style_name  , V_FIX_ASSET_REDUCE_USELESS , nnn.red_accudep , 0 )  fa_accu_dep_reduce_useless ,
     case  ooo.style_name 
            when V_FIX_ASSET_REDUCE_USELESS   then  0  
            else   nnn.red_localoriginvalue
     end fa_value_reduce_other,   
     case  ooo.style_name 
            when V_FIX_ASSET_REDUCE_USELESS   then  0  
            else  nnn.red_accudep  
     end fa_accu_dep_reduce_other
     from  pam_addreducestyle ooo ,  fa_reduce_b nnn  , bal_dep_before_sum  mmm
     where 1=1
     and ooo.pk_addreducestyle = nnn.pk_reducestyle
     and nnn.pk_card = nnn.pk_card 
     and mmm.fa_value_reduce > 0
     and mmm.asset_state = 'reduce' 
   
   )  ,
   
   fa_total as 
   (
   
      select fa_cate_name , fa_code ,fa_name , 
             fa_value_begin , 
             decode(fa_cate_name ,V_FIX_ASSET_CATEGORY_MACHINE , fa_value_begin , 0 ) fa_value_begin_machine ,
             decode(fa_cate_name ,V_FIX_ASSET_CATEGORY_BUILDING , fa_value_begin , 0 ) fa_value_begin_building ,
             decode(fa_cate_name ,V_FIX_ASSET_CATEGORY_VEHICLE, fa_value_begin , 0 ) fa_value_begin_vehicle ,
             decode(fa_cate_name ,V_FIX_ASSET_CATEGORY_OTHER , fa_value_begin , 0 ) fa_value_begin_other , 
             fa_accu_dep_begin , 
             decode(fa_cate_name ,V_FIX_ASSET_CATEGORY_MACHINE , fa_accu_dep_begin , 0 ) fa_accu_dep_begin_machine ,
             decode(fa_cate_name ,V_FIX_ASSET_CATEGORY_BUILDING , fa_accu_dep_begin , 0 ) fa_accu_dep_begin_building ,
             decode(fa_cate_name ,V_FIX_ASSET_CATEGORY_VEHICLE, fa_accu_dep_begin , 0 ) fa_accu_dep_begin_vehicle ,
             decode(fa_cate_name ,V_FIX_ASSET_CATEGORY_OTHER , fa_accu_dep_begin , 0 ) fa_accu_dep_begin_other , 
             fa_value_add  ,
             fa_accu_dep_add  , 
             0  fa_value_add_purchase , 
             0 fa_value_add_purchase_machine,
             0 fa_value_add_purchase_building,
             0 fa_value_add_purchase_vehicle,
             0 fa_value_add_purchase_other, 
             0 fa_accu_dep_add_purchase , 
             0 fa_accu_dep_add_pur_machine , 
             0 fa_accu_dep_add_pur_building , 
             0 fa_accu_dep_add_pur_vehicle , 
             0 fa_accu_dep_add_pur_other , 
         
             0  fa_value_add_constructure  , 
             0  fa_value_add_cons_mechine  ,  
             0  fa_value_add_cons_building  ,  
             0  fa_value_add_cons_vehicle  , 
             0  fa_value_add_cons_other  ,   
                 
             0 fa_accu_dep_add_constructure,
             0 fa_accu_dep_add_cons_machine,
             0 fa_accu_dep_add_cons_building,
             0 fa_accu_dep_add_cons_vehicle,
             0 fa_accu_dep_add_cons_other,
             
             
             0  fa_value_add_other  ,  
             0  fa_value_add_other_machine  ,
             0  fa_value_add_other_building  ,
             0  fa_value_add_other_vehicle  ,
             0  fa_value_add_other_other  ,
             
             0 fa_accu_dep_add_other, 
             0 fa_accu_dep_add_other_machine, 
             0 fa_accu_dep_add_other_building, 
             0 fa_accu_dep_add_other_vehicle, 
             0 fa_accu_dep_add_other_other, 
             
             fa_value_reduce ,
             fa_accu_dep_reduce ,
             
             0  fa_value_reduce_useless , 
             0  fa_value_red_useless_machine ,
             0  fa_value_red_useless_building , 
             0  fa_value_red_useless_vehicle , 
             0  fa_value_red_useless_other , 
             
             0 fa_accu_dep_reduce_useless , 
             0 fa_accu_dep_red_ul_machine , 
             0 fa_accu_dep_red_ul_building ,
             0 fa_accu_dep_red_ul_vehicle ,
             0 fa_accu_dep_red_ul_other ,
             
             
             0 fa_value_reduce_other, 
             0 fa_value_red_other_machine,
             0 fa_value_red_other_building,
             0 fa_value_red_other_vehicle,
             0 fa_value_red_other_other, 
             
             0 fa_accu_dep_reduce_other, 
             0 fa_accu_dep_red_other_machine, 
             0 fa_accu_dep_red_other_building, 
             0 fa_accu_dep_red_other_vehicle, 
             0 fa_accu_dep_red_other_other, 
             
             fa_value_end  , 
             decode(fa_cate_name ,V_FIX_ASSET_CATEGORY_MACHINE , fa_value_end , 0 ) fa_value_end_machine ,
             decode(fa_cate_name ,V_FIX_ASSET_CATEGORY_BUILDING , fa_value_end , 0 ) fa_value_end_building ,
             decode(fa_cate_name ,V_FIX_ASSET_CATEGORY_VEHICLE, fa_value_end , 0 ) fa_value_end_vehicle ,
             decode(fa_cate_name ,V_FIX_ASSET_CATEGORY_OTHER , fa_value_end , 0 ) fa_value_end_other ,
             fa_accu_dep_end  ,
             decode(fa_cate_name ,V_FIX_ASSET_CATEGORY_MACHINE , fa_accu_dep_end , 0 ) fa_accu_dep_end_machine ,
             decode(fa_cate_name ,V_FIX_ASSET_CATEGORY_BUILDING , fa_accu_dep_end , 0 ) fa_accu_dep_end_building ,
             decode(fa_cate_name ,V_FIX_ASSET_CATEGORY_VEHICLE, fa_accu_dep_end , 0 ) fa_accu_dep_end_vehicle ,
             decode(fa_cate_name ,V_FIX_ASSET_CATEGORY_OTHER , fa_accu_dep_end , 0 ) fa_accu_dep_end_other  , 
             
             fa_curr_dep_end , 
             decode(fa_cate_name ,V_FIX_ASSET_CATEGORY_MACHINE , fa_curr_dep_end , 0 ) fa_curr_dep_end_machine ,
             decode(fa_cate_name ,V_FIX_ASSET_CATEGORY_BUILDING , fa_curr_dep_end , 0 )fa_curr_dep_end_building ,
             decode(fa_cate_name ,V_FIX_ASSET_CATEGORY_VEHICLE, fa_curr_dep_end , 0 ) fa_curr_dep_end_vehicle ,
             decode(fa_cate_name ,V_FIX_ASSET_CATEGORY_OTHER , fa_curr_dep_end , 0 ) fa_curr_dep_end_other  
             
      from bal_dep_before_sum  
      
      union all 
      
        select fa_cate_name , fa_code ,fa_name , 
             0 fa_value_begin , 
             0 fa_value_begin_machine ,
             0 fa_value_begin_building ,
             0 fa_value_begin_vehicle ,
             0 fa_value_begin_other , 
             0 fa_accu_dep_begin , 
             0 fa_accu_dep_begin_machine ,
             0 fa_accu_dep_begin_building ,
             0 fa_accu_dep_begin_vehicle ,
             0 fa_accu_dep_begin_other , 
             0 fa_value_add  ,
             0 fa_accu_dep_add  , 
             fa_value_add_purchase , 
             decode(fa_cate_name ,V_FIX_ASSET_CATEGORY_MACHINE , fa_value_add_purchase , 0 ) fa_value_add_purchase_machine,
             decode(fa_cate_name ,V_FIX_ASSET_CATEGORY_BUILDING , fa_value_add_purchase , 0 ) fa_value_add_purchase_building,
             decode(fa_cate_name ,V_FIX_ASSET_CATEGORY_VEHICLE , fa_value_add_purchase , 0 ) fa_value_add_purchase_vehicle,
             decode(fa_cate_name ,V_FIX_ASSET_CATEGORY_OTHER , fa_value_add_purchase , 0 ) fa_value_add_purchase_other, 
             fa_accu_dep_add_purchase , 
             decode(fa_cate_name ,V_FIX_ASSET_CATEGORY_MACHINE , fa_accu_dep_add_purchase , 0 ) fa_accu_dep_add_pur_machine , 
             decode(fa_cate_name ,V_FIX_ASSET_CATEGORY_BUILDING , fa_accu_dep_add_purchase , 0 ) fa_accu_dep_add_pur_building , 
             decode(fa_cate_name ,V_FIX_ASSET_CATEGORY_VEHICLE , fa_accu_dep_add_purchase , 0 ) fa_accu_dep_add_pur_vehicle , 
             decode(fa_cate_name ,V_FIX_ASSET_CATEGORY_OTHER , fa_accu_dep_add_purchase , 0 ) fa_accu_dep_add_pur_other , 
         
             fa_value_add_constructure  , 
             decode(fa_cate_name ,V_FIX_ASSET_CATEGORY_MACHINE , fa_value_add_constructure , 0 )  fa_value_add_cons_mechine  ,  
             decode(fa_cate_name ,V_FIX_ASSET_CATEGORY_BUILDING , fa_value_add_constructure , 0 )  fa_value_add_cons_building  ,  
             decode(fa_cate_name ,V_FIX_ASSET_CATEGORY_VEHICLE , fa_value_add_constructure , 0 )  fa_value_add_cons_vehicle  , 
             decode(fa_cate_name ,V_FIX_ASSET_CATEGORY_OTHER , fa_value_add_constructure , 0 )  fa_value_add_cons_other  ,   
                 
             fa_accu_dep_add_constructure,
             decode(fa_cate_name ,V_FIX_ASSET_CATEGORY_MACHINE , fa_accu_dep_add_constructure , 0 )  fa_accu_dep_add_cons_machine,
             decode(fa_cate_name ,V_FIX_ASSET_CATEGORY_BUILDING , fa_accu_dep_add_constructure , 0 ) fa_accu_dep_add_cons_building,
             decode(fa_cate_name ,V_FIX_ASSET_CATEGORY_VEHICLE , fa_accu_dep_add_constructure , 0 ) fa_accu_dep_add_cons_vehicle,
             decode(fa_cate_name ,V_FIX_ASSET_CATEGORY_OTHER , fa_accu_dep_add_constructure , 0 ) fa_accu_dep_add_cons_other,
             
             
             fa_value_add_other  ,  
             decode(fa_cate_name ,V_FIX_ASSET_CATEGORY_MACHINE , fa_value_add_other , 0 )  fa_value_add_other_machine  ,
             decode(fa_cate_name ,V_FIX_ASSET_CATEGORY_BUILDING , fa_value_add_other , 0 )  fa_value_add_other_building  ,
             decode(fa_cate_name ,V_FIX_ASSET_CATEGORY_VEHICLE , fa_value_add_other , 0 )  fa_value_add_other_vehicle  ,
             decode(fa_cate_name ,V_FIX_ASSET_CATEGORY_OTHER , fa_value_add_other , 0 )  fa_value_add_other_other  ,
             
             fa_accu_dep_add_other, 
             decode(fa_cate_name ,V_FIX_ASSET_CATEGORY_MACHINE , fa_accu_dep_add_other , 0 ) fa_accu_dep_add_other_machine, 
             decode(fa_cate_name ,V_FIX_ASSET_CATEGORY_BUILDING , fa_accu_dep_add_other , 0 ) fa_accu_dep_add_other_building, 
             decode(fa_cate_name ,V_FIX_ASSET_CATEGORY_VEHICLE , fa_accu_dep_add_other , 0 ) fa_accu_dep_add_other_vehicle, 
             decode(fa_cate_name ,V_FIX_ASSET_CATEGORY_OTHER , fa_accu_dep_add_other , 0 ) fa_accu_dep_add_other_other, 
             
             0 fa_value_reduce ,
             0 fa_accu_dep_reduce ,
             
             0  fa_value_reduce_useless , 
             0  fa_value_red_useless_machine ,
             0  fa_value_red_useless_building , 
             0  fa_value_red_useless_vehicle , 
             0  fa_value_red_useless_other , 
             
             0 fa_accu_dep_reduce_useless , 
             0 fa_accu_dep_red_ul_machine , 
             0 fa_accu_dep_red_ul_building ,
             0 fa_accu_dep_red_ul_vehicle ,
             0 fa_accu_dep_red_ul_other ,
             
             
             0 fa_value_reduce_other, 
             0 fa_value_red_other_machine,
             0 fa_value_red_other_building,
             0 fa_value_red_other_vehicle,
             0 fa_value_red_other_other, 
             
             0 fa_accu_dep_reduce_other, 
             0 fa_accu_dep_red_other_machine, 
             0 fa_accu_dep_red_other_building, 
             0 fa_accu_dep_red_other_vehicle, 
             0 fa_accu_dep_red_other_other, 
             
             0 fa_value_end  , 
             0 fa_value_end_machine ,
             0 fa_value_end_building ,
             0 fa_value_end_vehicle ,
             0 fa_value_end_other ,
             0 fa_accu_dep_end  ,
             0 fa_accu_dep_end_machine ,
             0 fa_accu_dep_end_building ,
             0 fa_accu_dep_end_vehicle ,
             0 fa_accu_dep_end_other  , 
             
             
             0 fa_curr_dep_end , 
             0 fa_curr_dep_end_machine ,
             0 fa_curr_dep_end_building ,
             0 fa_curr_dep_end_vehicle ,
             0 fa_curr_dep_end_other   
      from  fa_add  
      
      
      union all 
      
      select      fa_cate_name , fa_code ,fa_name , 
             0 fa_value_begin , 
             0 fa_value_begin_machine ,
             0 fa_value_begin_building ,
             0 fa_value_begin_vehicle ,
             0 fa_value_begin_other , 
             0 fa_accu_dep_begin , 
             0 fa_accu_dep_begin_machine ,
             0 fa_accu_dep_begin_building ,
             0 fa_accu_dep_begin_vehicle ,
             0 fa_accu_dep_begin_other , 
             0 fa_value_add  ,
             0 fa_accu_dep_add  , 
             0 fa_value_add_purchase , 
             0 fa_value_add_purchase_machine,
             0 fa_value_add_purchase_building,
             0 fa_value_add_purchase_vehicle,
             0 fa_value_add_purchase_other, 
             0 fa_accu_dep_add_purchase , 
             0 fa_accu_dep_add_pur_machine , 
             0 fa_accu_dep_add_pur_building , 
             0 fa_accu_dep_add_pur_vehicle , 
             0 fa_accu_dep_add_pur_other , 
         
             0 fa_value_add_constructure  , 
             0 fa_value_add_cons_mechine  ,  
             0 fa_value_add_cons_building  ,  
             0 fa_value_add_cons_vehicle  , 
             0 fa_value_add_cons_other  ,   
                 
             0 fa_accu_dep_add_constructure,
             0 fa_accu_dep_add_cons_machine,
             0 fa_accu_dep_add_cons_building,
             0 fa_accu_dep_add_cons_vehicle,
             0 fa_accu_dep_add_cons_other,
             
             
             0 fa_value_add_other  ,  
             0 fa_value_add_other_machine  ,
             0 fa_value_add_other_building  ,
             0 fa_value_add_other_vehicle  ,
             0 fa_value_add_other_other  ,
             
             0 fa_accu_dep_add_other, 
             0 fa_accu_dep_add_other_machine, 
             0 fa_accu_dep_add_other_building, 
             0 fa_accu_dep_add_other_vehicle, 
             0 fa_accu_dep_add_other_other, 
             
             0 fa_value_reduce ,
             0 fa_accu_dep_reduce ,
             
             fa_value_reduce_useless , 
             decode(fa_cate_name ,V_FIX_ASSET_CATEGORY_MACHINE , fa_value_reduce_useless , 0 )  fa_value_red_useless_machine ,
             decode(fa_cate_name ,V_FIX_ASSET_CATEGORY_BUILDING , fa_value_reduce_useless , 0 )  fa_value_red_useless_building , 
             decode(fa_cate_name ,V_FIX_ASSET_CATEGORY_VEHICLE , fa_value_reduce_useless , 0 )  fa_value_red_useless_vehicle , 
             decode(fa_cate_name ,V_FIX_ASSET_CATEGORY_OTHER , fa_value_reduce_useless , 0 )  fa_value_red_useless_other , 
             
             fa_accu_dep_reduce_useless , 
             decode(fa_cate_name ,V_FIX_ASSET_CATEGORY_MACHINE , fa_accu_dep_reduce_useless , 0 ) fa_accu_dep_red_ul_machine , 
             decode(fa_cate_name ,V_FIX_ASSET_CATEGORY_BUILDING , fa_accu_dep_reduce_useless , 0 ) fa_accu_dep_red_ul_building ,
             decode(fa_cate_name ,V_FIX_ASSET_CATEGORY_VEHICLE , fa_accu_dep_reduce_useless , 0 ) fa_accu_dep_red_ul_vehicle ,
             decode(fa_cate_name ,V_FIX_ASSET_CATEGORY_OTHER , fa_accu_dep_reduce_useless , 0 ) fa_accu_dep_red_ul_other ,
             
             
             fa_value_reduce_other, 
             decode(fa_cate_name ,V_FIX_ASSET_CATEGORY_MACHINE , fa_value_reduce_other , 0 ) fa_value_red_other_machine,
             decode(fa_cate_name ,V_FIX_ASSET_CATEGORY_BUILDING , fa_value_reduce_other , 0 ) fa_value_red_other_building,
             decode(fa_cate_name ,V_FIX_ASSET_CATEGORY_VEHICLE , fa_value_reduce_other , 0 ) fa_value_red_other_vehicle,
             decode(fa_cate_name ,V_FIX_ASSET_CATEGORY_OTHER , fa_value_reduce_other , 0 ) fa_value_red_other_other, 
             
             fa_accu_dep_reduce_other, 
             decode(fa_cate_name ,V_FIX_ASSET_CATEGORY_MACHINE , fa_accu_dep_reduce_other , 0 ) fa_accu_dep_red_other_machine, 
             decode(fa_cate_name ,V_FIX_ASSET_CATEGORY_BUILDING , fa_accu_dep_reduce_other , 0 ) fa_accu_dep_red_other_building, 
             decode(fa_cate_name ,V_FIX_ASSET_CATEGORY_VEHICLE , fa_accu_dep_reduce_other , 0 ) fa_accu_dep_red_other_vehicle, 
             decode(fa_cate_name ,V_FIX_ASSET_CATEGORY_OTHER , fa_accu_dep_reduce_other , 0 ) fa_accu_dep_red_other_other, 
             
             0 fa_value_end  , 
             0 fa_value_end_machine ,
             0 fa_value_end_building ,
             0 fa_value_end_vehicle ,
             0 fa_value_end_other ,
             0 fa_accu_dep_end  ,
             0 fa_accu_dep_end_machine ,
             0 fa_accu_dep_end_building ,
             0 fa_accu_dep_end_vehicle ,
             0 fa_accu_dep_end_other ,
             
             0 fa_curr_dep_end , 
             0 fa_curr_dep_end_machine ,
             0 fa_curr_dep_end_building ,
             0 fa_curr_dep_end_vehicle ,
             0 fa_curr_dep_end_other   
      from  fa_reduce
             
   
   )
   

   select 
     fa_code ,fa_name , 
     sum(fa_value_begin) fa_value_begin , 
     sum(fa_value_begin_machine) fa_value_begin_machine ,
     sum(fa_value_begin_building) fa_value_begin_building ,
     sum(fa_value_begin_vehicle) fa_value_begin_vehicle ,
     sum(fa_value_begin_other) fa_value_begin_other , 
     sum(fa_accu_dep_begin) fa_accu_dep_begin , 
     sum(fa_accu_dep_begin_machine) fa_accu_dep_begin_machine ,
     sum(fa_accu_dep_begin_building) fa_accu_dep_begin_building ,
     sum(fa_accu_dep_begin_vehicle) fa_accu_dep_begin_vehicle ,
     sum(fa_accu_dep_begin_other) fa_accu_dep_begin_other , 
     sum(fa_value_add) fa_value_add  ,
     sum(fa_accu_dep_add) fa_accu_dep_add  , 
     sum(fa_value_add_purchase) fa_value_add_purchase , 
     sum(fa_value_add_purchase_machine) fa_value_add_purchase_machine,
     sum(fa_value_add_purchase_building) fa_value_add_purchase_building,
     sum(fa_value_add_purchase_vehicle) fa_value_add_purchase_vehicle,
     sum(fa_value_add_purchase_other) fa_value_add_purchase_other, 
     sum(fa_accu_dep_add_purchase) fa_accu_dep_add_purchase , 
     sum(fa_accu_dep_add_pur_machine) fa_accu_dep_add_pur_machine , 
     sum(fa_accu_dep_add_pur_building) fa_accu_dep_add_pur_building , 
     sum(fa_accu_dep_add_pur_vehicle) fa_accu_dep_add_pur_vehicle , 
     sum(fa_accu_dep_add_pur_other) fa_accu_dep_add_pur_other , 
         
     sum(fa_value_add_constructure) fa_value_add_constructure  , 
     sum(fa_value_add_cons_mechine)  fa_value_add_cons_mechine  ,  
     sum(fa_value_add_cons_building)  fa_value_add_cons_building  ,  
     sum(fa_value_add_cons_vehicle)  fa_value_add_cons_vehicle  , 
     sum(fa_value_add_cons_other)  fa_value_add_cons_other  ,   
                 
     sum(fa_accu_dep_add_constructure) fa_accu_dep_add_constructure,
     sum(fa_accu_dep_add_cons_machine)  fa_accu_dep_add_cons_machine,
     sum(fa_accu_dep_add_cons_building) fa_accu_dep_add_cons_building,
     sum(fa_accu_dep_add_cons_vehicle) fa_accu_dep_add_cons_vehicle,
     sum(fa_accu_dep_add_cons_other) fa_accu_dep_add_cons_other,
             
             
     sum(fa_value_add_other) fa_value_add_other  ,  
     sum(fa_value_add_other_machine) fa_value_add_other_machine  ,
     sum(fa_value_add_other_building)  fa_value_add_other_building  ,
     sum(fa_value_add_other_vehicle)  fa_value_add_other_vehicle  ,
     sum(fa_value_add_other_other)  fa_value_add_other_other  ,
             
     sum(fa_accu_dep_add_other) fa_accu_dep_add_other, 
     sum(fa_accu_dep_add_other_machine) fa_accu_dep_add_other_machine, 
     sum(fa_accu_dep_add_other_building) fa_accu_dep_add_other_building, 
     sum(fa_accu_dep_add_other_vehicle) fa_accu_dep_add_other_vehicle, 
     sum(fa_accu_dep_add_other_other) fa_accu_dep_add_other_other, 
             
     sum(fa_value_reduce) fa_value_reduce ,
     sum(fa_accu_dep_reduce)fa_accu_dep_reduce ,
             
     sum(fa_value_reduce_useless)  fa_value_reduce_useless , 
     sum(fa_value_red_useless_machine)  fa_value_red_useless_machine ,
     sum(fa_value_red_useless_building)  fa_value_red_useless_building , 
     sum(fa_value_red_useless_vehicle)  fa_value_red_useless_vehicle , 
     sum(fa_value_red_useless_other)  fa_value_red_useless_other , 
             
     sum(fa_accu_dep_reduce_useless) fa_accu_dep_reduce_useless , 
     sum(fa_accu_dep_red_ul_machine) fa_accu_dep_red_ul_machine , 
     sum(fa_accu_dep_red_ul_building) fa_accu_dep_red_ul_building ,
     sum(fa_accu_dep_red_ul_vehicle) fa_accu_dep_red_ul_vehicle ,
     sum(fa_accu_dep_red_ul_other) fa_accu_dep_red_ul_other ,
             
             
     sum(fa_value_reduce_other) fa_value_reduce_other, 
     sum(fa_value_red_other_machine) fa_value_red_other_machine,
     sum(fa_value_red_other_building) fa_value_red_other_building,
     sum(fa_value_red_other_vehicle) fa_value_red_other_vehicle,
     sum(fa_value_red_other_other) fa_value_red_other_other, 
             
     sum(fa_accu_dep_reduce_other) fa_accu_dep_reduce_other, 
     sum(fa_accu_dep_red_other_machine) fa_accu_dep_red_other_machine, 
     sum(fa_accu_dep_red_other_building) fa_accu_dep_red_other_building, 
     sum(fa_accu_dep_red_other_vehicle) fa_accu_dep_red_other_vehicle, 
     sum(fa_accu_dep_red_other_other) fa_accu_dep_red_other_other, 
             
     sum(fa_value_end) fa_value_end  , 
     sum(fa_value_end_machine) fa_value_end_machine ,
     sum(fa_value_end_building) fa_value_end_building ,
     sum(fa_value_end_vehicle) fa_value_end_vehicle ,
     sum(fa_value_end_other) fa_value_end_other ,
     sum(fa_accu_dep_end) fa_accu_dep_end  ,
     sum(fa_accu_dep_end_machine) fa_accu_dep_end_machine ,
     sum(fa_accu_dep_end_building) fa_accu_dep_end_building ,
     sum(fa_accu_dep_end_vehicle) fa_accu_dep_end_vehicle ,
     sum(fa_accu_dep_end_other) fa_accu_dep_end_other   , 
     sum(fa_curr_dep_end)  fa_curr_dep_end , 
     sum(fa_curr_dep_end_machine) fa_curr_dep_end_machine ,
     sum(fa_curr_dep_end_building) fa_curr_dep_end_building ,
     sum(fa_curr_dep_end_vehicle) fa_curr_dep_end_vehicle ,
     sum(fa_curr_dep_end_other) fa_curr_dep_end_other   
   from fa_total 
   group by  fa_code ,fa_name;
   
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
