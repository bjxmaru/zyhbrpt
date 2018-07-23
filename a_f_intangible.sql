select 
sum(fa_value_begin) fa_value_begin , 
sum(fa_accu_dep_begin) fa_accu_dep_begin , 
sum(fa_value_end) fa_value_end , 
sum(fa_accu_dep_end) fa_accu_dep_end , 
sum(fa_curr_dep_end) fa_curr_dep_end , 
sum(fa_value_add) fa_value_add , 
sum(fa_value_add_other) fa_value_add_other , 
sum(fa_value_add_pur) fa_value_add_pur , 
sum(fa_value_add_cons) fa_value_add_cons , 
sum(fa_accu_dep_add) fa_accu_dep_add , 
sum(fa_accu_dep_add_other) fa_accu_dep_add_other ,
sum(fa_accu_dep_add_pur) fa_accu_dep_add_pur , 
sum(fa_accu_dep_add_cons) fa_accu_dep_add_cons  ,
sum(fa_accu_dep_reduce ) fa_accu_dep_reduce , 
sum(fa_accu_dep_reduce_bf ) fa_accu_dep_reduce_bf , 
sum(fa_accu_dep_reduce_other ) fa_accu_dep_reduce_other , 
sum(fa_value_reduce ) fa_value_reduce , 
sum(fa_value_reduce_bf ) fa_value_reduce_bf , 
sum(fa_value_reduce_other ) fa_value_reduce_other,
sum(fa_curr_dep_end) fa_curr_dep_end
from 

(

select   cc.ASSET_CODE,cc.ASSET_NAME ,
  decode(  parameter('begin_year_param') || parameter('begin_month_param')  ,min_year_month.init_year_month ,        
           decode( aa.accyear||aa.period , parameter('begin_year_param') || parameter('begin_month_param') , 
                 decode( aa.newasset_flag, 1 , 0,
                      decode( aa.asset_state ,'reduce' , 0, aa.localoriginvalue)) , 0 ),
           decode( aa.accyear||aa.period  , parameter('begin_year_param') || parameter('begin_month_param')  , 
                   decode(aa.newasset_flag ,0 , 0  , 1, 0 , 
                        decode(aa.asset_state , 'reduce' , 0 , aa.localoriginvalue) )  , 0 )
           ) fa_value_begin   , 

           
           
      decode(  parameter('begin_year_param') || parameter('begin_month_param')  , min_year_month.init_year_month ,        
           decode( aa.accyear||aa.period , parameter('begin_year_param') || parameter('begin_month_param') , 
                 decode( aa.newasset_flag, 1 , 0,
                      decode( aa.asset_state ,'reduce' , 0, aa.accudep)) , 0 ),
           decode( aa.accyear||aa.period  , parameter('begin_year_param') || parameter('begin_month_param')  , 
                   decode(aa.newasset_flag ,0 , 0  , 1, 0 , 
                        decode(aa.asset_state , 'reduce' , 0 , aa.accudep) )  , 0 )
           ) fa_accu_dep_begin   , 



     
           
    decode(  macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep') , min_year_month.init_year_month ,    
       
        decode(  aa.accyear||aa.period  , macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep') ,  decode( aa.newasset_flag, 1 , 0,
                   decode( aa.asset_state ,'reduce' , 0, aa.localoriginvalue))  , 0) ,
           decode( aa.accyear||aa.period  ,macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep') , 
                   decode(aa.newasset_flag ,0 , 0  , 1, 0 , 
                        decode(aa.asset_state , 'reduce' , 0 , aa.localoriginvalue) )  , 0 )
           ) fa_value_end  ,  
           
 
           
       decode(  macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep') , min_year_month.init_year_month ,    
       
        decode(  aa.accyear||aa.period  , macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep') ,  decode( aa.newasset_flag, 1 , 0,
                   decode( aa.asset_state ,'reduce' , 0, aa.accudep))  , 0) ,
           decode( aa.accyear||aa.period  ,macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep') , 
                   decode(aa.newasset_flag ,0 , 0  , 1, 0 , 
                        decode(aa.asset_state , 'reduce' , 0 , aa.accudep) )  , 0 )
           )    fa_accu_dep_end   , 
           
           
      decode(aa.accyear || aa.period, parameter('begin_year_param') || parameter('begin_month_param') , 0  , aa.depamount ) fa_curr_dep_end ,
      
        decode( aa.accyear || aa.period  , min_year_month.init_year_month ,  
          decode( aa.newasset_flag , 1, aa.localoriginvalue , 0 ) , 
          decode ( aa.accyear || aa.period  , macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep')  ,  0 , 
                    decode ( aa.newasset_flag  , 1 ,  aa.localoriginvalue  , 0  ,  aa.localoriginvalue  ,0 )  ) )
                  fa_value_add  , 
                  
      decode (dd.style_name, '直接购入',0 , '在建工程转入' , 0  ,decode( aa.accyear || aa.period  , min_year_month.init_year_month ,  
          decode( aa.newasset_flag , 1, aa.localoriginvalue , 0 ) , 
          decode ( aa.accyear || aa.period  , macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep')  ,  0 , 
             decode ( aa.newasset_flag  , 1 ,  aa.localoriginvalue  , 0  ,  aa.localoriginvalue  ,0 )  ) ) )  fa_value_add_other , 
             
             
      decode (dd.style_name, '直接购入' ,   decode( aa.accyear || aa.period  , min_year_month.init_year_month ,  
          decode( aa.newasset_flag , 1, aa.localoriginvalue , 0 ) , 
          decode ( aa.accyear || aa.period  , macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep')  ,  0 , 
                    decode ( aa.newasset_flag  , 1 ,  aa.localoriginvalue  , 0  ,  aa.localoriginvalue  ,0 )  ) ) , 0 )   fa_value_add_pur, 
                    
      
      decode (dd.style_name, '在建工程转入' ,   decode( aa.accyear || aa.period  , min_year_month.init_year_month ,  
          decode( aa.newasset_flag , 1, aa.localoriginvalue , 0 ) , 
          decode ( aa.accyear || aa.period  , macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep')  ,  0 , 
                    decode ( aa.newasset_flag  , 1 ,  aa.localoriginvalue  , 0  ,  aa.localoriginvalue  ,0 )  ) ) , 0 )   fa_value_add_cons,
                    
                      
      
        decode( aa.accyear || aa.period  , min_year_month.init_year_month ,  
          decode( aa.newasset_flag , 1, aa.accudep , 0 ) , 
          decode ( aa.accyear || aa.period  , macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep')  ,  0 , 
                    decode ( aa.newasset_flag  , 1 ,  aa.accudep  , 0  ,  aa.accudep  ,0 )  ) )
                  fa_accu_dep_add  , 
                  
      decode (dd.style_name, '直接购入',0 , '在建工程转入' , 0  ,decode( aa.accyear || aa.period  , min_year_month.init_year_month ,  
          decode( aa.newasset_flag , 1, aa.accudep , 0 ) , 
          decode ( aa.accyear || aa.period  , macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep')  ,  0 , 
             decode ( aa.newasset_flag  , 1 ,  aa.accudep  , 0  ,  aa.accudep  ,0 )  ) ) )  fa_accu_dep_add_other , 
             
             
      decode (dd.style_name, '直接购入' ,   decode( aa.accyear || aa.period  , min_year_month.init_year_month ,  
          decode( aa.newasset_flag , 1, aa.accudep , 0 ) , 
          decode ( aa.accyear || aa.period  , macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep')  ,  0 , 
                    decode ( aa.newasset_flag  , 1 ,  aa.accudep  , 0  ,  aa.accudep  ,0 )  ) ) , 0 )   fa_accu_dep_add_pur, 
                    
      
      decode (dd.style_name, '在建工程转入' ,   decode( aa.accyear || aa.period  , min_year_month.init_year_month ,  
          decode( aa.newasset_flag , 1, aa.accudep , 0 ) , 
          decode ( aa.accyear || aa.period  , macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep')  ,  0 , 
                    decode ( aa.newasset_flag  , 1 ,  aa.accudep  , 0  ,  aa.accudep  ,0 )  ) ) , 0 )   fa_accu_dep_add_cons , 
                    
                    
                    
       decode( aa.accyear||aa.period  , parameter('begin_year_param') || parameter('begin_month_param') , 0 , 
           decode(  aa.asset_state ,'reduce' ,  aa.localoriginvalue , 0 ) )  fa_value_reduce ,
           
         decode (dd.style_name, '报废' ,   0 ,    decode( aa.accyear||aa.period  , parameter('begin_year_param') || parameter('begin_month_param') , 0 , 
           decode(  aa.asset_state ,'reduce' ,  aa.localoriginvalue , 0 ) )  ) fa_value_reduce_bf , 
           
           decode (dd.style_name, '报废'  , decode( aa.accyear||aa.period  , parameter('begin_year_param') || parameter('begin_month_param') , 0 , 
           decode(  aa.asset_state ,'reduce' ,  aa.localoriginvalue , 0 ) )  , 0 )   fa_value_reduce_other,   
           
           
           
           
         decode( aa.accyear||aa.period  , parameter('begin_year_param') || parameter('begin_month_param') , 0 , 
           decode(  aa.asset_state ,'reduce' ,  aa.accudep , 0 ) )  fa_accu_dep_reduce   , 
           
           
           decode (dd.style_name, '报废' ,   0 ,   decode( aa.accyear||aa.period  , parameter('begin_year_param') || parameter('begin_month_param') , 0 , 
           decode(  aa.asset_state ,'reduce' ,  aa.accudep , 0 ) ) ) fa_accu_dep_reduce_bf , 
           
           decode (dd.style_name, '报废' ,     decode( aa.accyear||aa.period  , parameter('begin_year_param') || parameter('begin_month_param') , 0 , 
           decode(  aa.asset_state ,'reduce' ,  aa.accudep , 0 ) )  , 0 )  fa_accu_dep_reduce_other 
             
           
           
   
                              
  from 
fa_cardhistory aa   inner join  fa_category  bb 
            on ( bb.pk_category = aa.pk_category_old 
                 and aa.pk_category_old = '1001A11000000008I9PW'
                 and bb.dr = 0 
                 and aa.laststate_flag = 'N'
                 and aa.dr = 0 
                 and aa.accyear||aa.period  <=  macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep')
                 and aa.accyear||aa.period  >=  parameter('begin_year_param') || parameter('begin_month_param')
                 and aa.pk_org = 
                     (select xx.PK_FINANCEORG  from ORG_FINANCEORG  xx where xx.dr = 0  and  xx.code = parameter('org_code') ) 
                
                )  inner join fa_card cc   
            on  (  cc.pk_card =  aa.pk_card   and cc.dr = 0  
                   and ( cc.asset_name like parameter('fa_code')  or   cc.asset_name like parameter('fa_code_1')  or 
                         cc.asset_name like parameter('fa_code_2') )

                 )

inner join     pam_addreducestyle dd on ( dd.pk_addreducestyle = cc.PK_ADDREDUCESTYLE and dd.dr = 0  )    

inner join   (
select  min(qqq.accyear || qqq.period) init_year_month , pk_org   from fa_cardhistory qqq 
group by qqq.pk_org 
)  min_year_month    on  ( min_year_month.pk_org = aa.pk_org )           

)