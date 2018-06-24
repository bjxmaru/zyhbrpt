select 
     sum(fa_value_begin) fa_value_begin ,  
     sum(fa_value_begin_machine) fa_value_begin_machine ,
     sum(fa_value_begin_building) fa_value_begin_building ,
     sum(fa_value_begin_vehicle) fa_value_begin_vehicle ,
     sum(fa_value_begin) - sum(fa_value_begin_machine) - sum(fa_value_begin_building) -  sum(fa_value_begin_vehicle) as  fa_value_begin_other , 
     sum(fa_accu_dep_begin) fa_accu_dep_begin , 
     sum(fa_accu_dep_begin_machine) fa_accu_dep_begin_machine ,
     sum(fa_accu_dep_begin_building) fa_accu_dep_begin_building ,
     sum(fa_accu_dep_begin_vehicle) fa_accu_dep_begin_vehicle ,
     sum(fa_accu_dep_begin) -sum(fa_accu_dep_begin_machine)  -  sum(fa_accu_dep_begin_building)  -sum(fa_accu_dep_begin_vehicle)   fa_accu_dep_begin_other ,
     sum(fa_value_end) fa_value_end  , 
     sum(fa_value_end_machine) fa_value_end_machine ,
     sum(fa_value_end_building) fa_value_end_building ,
     sum(fa_value_end_vehicle) fa_value_end_vehicle ,
     sum(fa_value_end) - sum(fa_value_end_machine) -sum(fa_value_end_building) - sum(fa_value_end_vehicle)   fa_value_end_other ,
     sum(fa_accu_dep_end) fa_accu_dep_end  ,
     sum(fa_accu_dep_end_machine) fa_accu_dep_end_machine ,
     sum(fa_accu_dep_end_building) fa_accu_dep_end_building ,
     sum(fa_accu_dep_end_vehicle) fa_accu_dep_end_vehicle ,
     sum(fa_accu_dep_end) - sum(fa_accu_dep_end_machine) - sum(fa_accu_dep_end_building) - sum(fa_accu_dep_end_vehicle)  fa_accu_dep_end_other   , 
     sum(fa_curr_dep_end)  fa_curr_dep_end , 
     sum(fa_curr_dep_end_machine) fa_curr_dep_end_machine ,
     sum(fa_curr_dep_end_building) fa_curr_dep_end_building ,
     sum(fa_curr_dep_end_vehicle) fa_curr_dep_end_vehicle ,
     sum(fa_curr_dep_end) - sum(fa_curr_dep_end_machine) - sum(fa_curr_dep_end_building) - sum(fa_curr_dep_end_vehicle)   fa_curr_dep_end_other    
from 
(
select   cc.ASSET_CODE,cc.ASSET_NAME , 

      
  decode(  parameter('begin_year') || parameter('begin_month')  , '201801' ,        
           decode( aa.accyear||aa.period , parameter('begin_year') || parameter('begin_month') , 
                 decode( aa.newasset_flag, 1 , 0,
                      decode( aa.asset_state ,'reduce' , 0, aa.localoriginvalue)) , 0 ),
           decode( aa.accyear||aa.period  , parameter('begin_year') || parameter('begin_month')  , 
                   decode(aa.newasset_flag ,0 , 0  , 1, 0 , 
                        decode(aa.asset_state , 'reduce' , 0 , aa.localoriginvalue) )  , 0 )
           ) fa_value_begin   ,    
           
                  
  decode(  parameter('begin_year') || parameter('begin_month')  , '201801' ,        
            decode( aa.accyear||aa.period , parameter('begin_year') || parameter('begin_month') , 
                 decode( aa.newasset_flag, 1 , 0,
                      decode( aa.asset_state ,'reduce' , 0, 
                         decode(   bb.CATE_NAME , '房屋及建筑物' , aa.localoriginvalue , 0 ) )) , 0 ),
           decode( aa.accyear||aa.period  , parameter('begin_year') || parameter('begin_month')  , 
                   decode(aa.newasset_flag ,0 , 0  , 1, 0 , 
                        decode(aa.asset_state , 'reduce' , 0 , 
                                 decode(   bb.CATE_NAME , '房屋及建筑物' , aa.localoriginvalue , 0 )    ) )  , 0 )
           ) fa_value_begin_building   ,                    
                                 
                  
    decode(  parameter('begin_year') || parameter('begin_month')  , '201801' ,        
           decode( aa.accyear||aa.period , parameter('begin_year') || parameter('begin_month') , 
                 decode( aa.newasset_flag, 1 , 0,
                      decode( aa.asset_state ,'reduce' , 0, 
                         decode(   bb.CATE_NAME , '机器设备' , aa.localoriginvalue , 0 ) )) , 0 ),
           decode( aa.accyear||aa.period  , parameter('begin_year') || parameter('begin_month')  , 
                   decode(aa.newasset_flag ,0 , 0  , 1, 0 , 
                        decode(aa.asset_state , 'reduce' , 0 , 
                                 decode(   bb.CATE_NAME , '机器设备' , aa.localoriginvalue , 0 )    ) )  , 0 )
           ) fa_value_begin_machine   ,                 
                  
                                 
   decode(  parameter('begin_year') || parameter('begin_month')  , '201801' ,        
           decode( aa.accyear||aa.period , parameter('begin_year') || parameter('begin_month') , 
                 decode( aa.newasset_flag, 1 , 0,
                      decode( aa.asset_state ,'reduce' , 0, 
                         decode(   bb.CATE_NAME , '运输工具' , aa.localoriginvalue , 0 ) )) , 0 ),
           decode( aa.accyear||aa.period  , parameter('begin_year') || parameter('begin_month')  , 
                   decode(aa.newasset_flag ,0 , 0  , 1, 0 , 
                        decode(aa.asset_state , 'reduce' , 0 , 
                                 decode(   bb.CATE_NAME , '运输工具' , aa.localoriginvalue , 0 )    ) )  , 0 )
           ) fa_value_begin_vehicle   ,                 
                  
                  
         
            
  decode(  parameter('begin_year') || parameter('begin_month')  , '201801' ,        
           decode( aa.accyear||aa.period , parameter('begin_year') || parameter('begin_month') , 
                 decode( aa.newasset_flag, 1 , 0,
                      decode( aa.asset_state ,'reduce' , 0, aa.accudep)) , 0 ),
           decode( aa.accyear||aa.period  , parameter('begin_year') || parameter('begin_month')  , 
                   decode(aa.newasset_flag ,0 , 0  , 1, 0 , 
                        decode(aa.asset_state , 'reduce' , 0 , aa.accudep) )  , 0 )
           ) fa_accu_dep_begin   ,         
           
           
           
    decode(  parameter('begin_year') || parameter('begin_month')  , '201801' ,        
          decode( aa.accyear||aa.period , parameter('begin_year') || parameter('begin_month') , 
                 decode( aa.newasset_flag, 1 , 0,
                      decode( aa.asset_state ,'reduce' , 0, 
                         decode(   bb.CATE_NAME , '房屋及建筑物' , aa.accudep , 0 ) )) , 0 ),
           decode( aa.accyear||aa.period  , parameter('begin_year') || parameter('begin_month')  , 
                   decode(aa.newasset_flag ,0 , 0  , 1, 0 , 
                        decode(aa.asset_state , 'reduce' , 0 , 
                                 decode(   bb.CATE_NAME , '房屋及建筑物' , aa.accudep , 0 )    ) )  , 0 )
           ) fa_accu_dep_begin_building   ,                    
                                 
                  
    decode(  parameter('begin_year') || parameter('begin_month')  , '201801' ,        
          decode( aa.accyear||aa.period , parameter('begin_year') || parameter('begin_month') , 
                 decode( aa.newasset_flag, 1 , 0,
                      decode( aa.asset_state ,'reduce' , 0, 
                         decode(   bb.CATE_NAME , '机器设备' , aa.accudep , 0 ) )) , 0 ),
           decode( aa.accyear||aa.period  , parameter('begin_year') || parameter('begin_month')  , 
                   decode(aa.newasset_flag ,0 , 0  , 1, 0 , 
                        decode(aa.asset_state , 'reduce' , 0 , 
                                 decode(   bb.CATE_NAME , '机器设备' , aa.accudep , 0 )    ) )  , 0 )
           ) fa_accu_dep_begin_machine   ,                 
                  
                                 
   decode(  parameter('begin_year') || parameter('begin_month')  , '201801' ,        
          decode( aa.accyear||aa.period , parameter('begin_year') || parameter('begin_month') , 
                 decode( aa.newasset_flag, 1 , 0,
                      decode( aa.asset_state ,'reduce' , 0, 
                         decode(   bb.CATE_NAME , '运输工具' , aa.accudep , 0 ) )) , 0 ),
           decode( aa.accyear||aa.period  , parameter('begin_year') || parameter('begin_month')  , 
                   decode(aa.newasset_flag ,0 , 0  , 1, 0 , 
                        decode(aa.asset_state , 'reduce' , 0 , 
                                 decode(   bb.CATE_NAME , '运输工具' , aa.accudep , 0 )    ) )  , 0 )
           ) fa_accu_dep_begin_vehicle   ,                    
                  


   decode(  macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep') , '201801' ,    
       
        decode(  aa.accyear||aa.period  , macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep') ,  decode( aa.newasset_flag, 1 , 0,
                   decode( aa.asset_state ,'reduce' , 0, aa.localoriginvalue))  , 0) ,
           decode( aa.accyear||aa.period  ,macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep') , 
                   decode(aa.newasset_flag ,0 , 0  , 1, 0 , 
                        decode(aa.asset_state , 'reduce' , 0 , aa.localoriginvalue) )  , 0 )
           ) fa_value_end  ,         
            
                  
  
    decode(  macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep') , '201801' ,        
          decode(  aa.accyear||aa.period  , macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep') ,  decode( aa.newasset_flag, 1 , 0,
                   decode( aa.asset_state ,'reduce' , 0, 
                          decode(   bb.CATE_NAME , '房屋及建筑物' , aa.localoriginvalue , 0 )  )) ,0) ,
           decode( aa.accyear||aa.period  ,macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep') , 
                   decode(aa.newasset_flag ,0 , 0  , 1, 0 , 
                        decode(aa.asset_state , 'reduce' , 0 , 
                               decode(   bb.CATE_NAME , '房屋及建筑物' , aa.localoriginvalue , 0 )) )  , 0 )
           ) fa_value_end_building  , 
 
                  
    decode(  macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep') , '201801' ,        
           decode(  aa.accyear||aa.period  , macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep') , decode( aa.newasset_flag, 1 , 0,
                   decode( aa.asset_state ,'reduce' , 0, 
                          decode(   bb.CATE_NAME , '机器设备' , aa.localoriginvalue , 0 )  )) ,0) ,
           decode( aa.accyear||aa.period  ,macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep') , 
                   decode(aa.newasset_flag ,0 , 0  , 1, 0 , 
                        decode(aa.asset_state , 'reduce' , 0 , 
                               decode(   bb.CATE_NAME , '机器设备' , aa.localoriginvalue , 0 )) )  , 0 )
           ) fa_value_end_machine  , 
               
        
                 
                  
   decode(  macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep') , '201801' ,        
          decode(  aa.accyear||aa.period  , macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep') ,  decode( aa.newasset_flag, 1 , 0,
                   decode( aa.asset_state ,'reduce' , 0, 
                          decode(   bb.CATE_NAME , '运输工具' , aa.localoriginvalue , 0 )  )) ,0) ,
           decode( aa.accyear||aa.period  ,macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep') , 
                   decode(aa.newasset_flag ,0 , 0  , 1, 0 , 
                        decode(aa.asset_state , 'reduce' , 0 , 
                               decode(   bb.CATE_NAME , '运输工具' , aa.localoriginvalue , 0 )) )  , 0 )
           ) fa_value_end_vehicle  ,            
                  
                  
                  
              
            
   decode(  macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep') , '201801' ,        
          decode(  aa.accyear||aa.period  , macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep') ,  decode( aa.newasset_flag, 1 , 0,
                   decode( aa.asset_state ,'reduce' , 0, aa.accudep)) ,0) ,
           decode( aa.accyear||aa.period  ,macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep') , 
                   decode(aa.newasset_flag ,0 , 0  , 1, 0 , 
                        decode(aa.asset_state , 'reduce' , 0 , aa.accudep) )  , 0 )
           ) fa_accu_dep_end  ,                 
            


   decode(  macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep') , '201801' ,        
          decode(  aa.accyear||aa.period  , macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep') ,  decode( aa.newasset_flag, 1 , 0,
                   decode( aa.asset_state ,'reduce' , 0, 
                          decode(   bb.CATE_NAME , '房屋及建筑物' , aa.accudep , 0 )  )) ,0),
           decode( aa.accyear||aa.period  ,macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep') , 
                   decode(aa.newasset_flag ,0 , 0  , 1, 0 , 
                        decode(aa.asset_state , 'reduce' , 0 , 
                               decode(   bb.CATE_NAME , '房屋及建筑物' , aa.accudep , 0 )) )  , 0 )
           ) fa_accu_dep_end_building  , 
 
                  
    decode(  macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep') , '201801' ,        
         decode(  aa.accyear||aa.period  , macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep') ,   decode( aa.newasset_flag, 1 , 0,
                   decode( aa.asset_state ,'reduce' , 0, 
                          decode(   bb.CATE_NAME , '机器设备' , aa.accudep , 0 )  )) , 0),
           decode( aa.accyear||aa.period  ,macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep') , 
                   decode(aa.newasset_flag ,0 , 0  , 1, 0 , 
                        decode(aa.asset_state , 'reduce' , 0 , 
                               decode(   bb.CATE_NAME , '机器设备' , aa.accudep , 0 )) )  , 0 )
           ) fa_accu_dep_end_machine  , 
               
       
                  
   decode(  macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep') , '201801' ,        
          decode(  aa.accyear||aa.period  , macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep') ,  decode( aa.newasset_flag, 1 , 0,
                   decode( aa.asset_state ,'reduce' , 0, 
                          decode(   bb.CATE_NAME , '运输工具' , aa.accudep , 0 )  )) , 0) ,
           decode( aa.accyear||aa.period  ,macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep') , 
                   decode(aa.newasset_flag ,0 , 0  , 1, 0 , 
                        decode(aa.asset_state , 'reduce' , 0 , 
                               decode(   bb.CATE_NAME , '运输工具' , aa.accudep , 0 )) )  , 0 )
           ) fa_accu_dep_end_vehicle  ,            
                  
                
                  
  decode(aa.accyear || aa.period, parameter('begin_year') || parameter('begin_month') , 0  , aa.depamount ) fa_curr_dep_end , 
  
  
  decode(aa.accyear || aa.period, parameter('begin_year') || parameter('begin_month') , 0  , 
              decode(   bb.CATE_NAME , '房屋及建筑物'   , aa.depamount , 0 ) ) fa_curr_dep_end_building , 
  decode(aa.accyear || aa.period, parameter('begin_year') || parameter('begin_month') , 0  , 
              decode(   bb.CATE_NAME , '机器设备'   , aa.depamount , 0 ) ) fa_curr_dep_end_machine , 
  decode(aa.accyear || aa.period, parameter('begin_year') || parameter('begin_month') , 0  , 
              decode(   bb.CATE_NAME , '运输工具'   , aa.depamount , 0 ) ) fa_curr_dep_end_vehicle  
              
              
              
              
   
                                 
                                 
from fa_card cc , fa_category bb  , fa_cardhistory  aa  , ORG_FINANCEORG xx
where
  11=11
  and cc.dr = 0
  and cc.asset_code like  parameter('fa_code')
  and cc.pk_card =  aa.pk_card
  and bb.dr = 0
  and bb.pk_category = aa.pk_category_old
  and aa.laststate_flag = 'N'
  and aa.dr = 0
  and aa.accyear||aa.period  <=  macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep')
  and aa.accyear||aa.period  >=  parameter('begin_year') || parameter('begin_month')
  and aa.pk_org = xx.PK_FINANCEORG
  and xx.dr = 0
  and xx.CODE  like parameter('org_code')

)
