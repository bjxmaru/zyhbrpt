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
     sum(fa_curr_dep_end) - sum(fa_curr_dep_end_machine) - sum(fa_curr_dep_end_building) - sum(fa_curr_dep_end_vehicle)   fa_curr_dep_end_other   , 

    sum(fa_value_add) fa_value_add  ,
     sum(fa_accu_dep_add) fa_accu_dep_add   , 
     sum(fa_value_add_purchase_machine) fa_value_add_purchase_machine,
     sum(fa_value_add_purchase_building) fa_value_add_purchase_building,
     sum(fa_value_add_purchase_vehicle) fa_value_add_purchase_vehicle,
     sum(fa_value_add_purchase_other) fa_value_add_purchase_other , 

     sum(fa_value_add_cons_machine)  fa_value_add_cons_machine  ,  
     sum(fa_value_add_cons_building)  fa_value_add_cons_building  ,  
     sum(fa_value_add_cons_vehicle)  fa_value_add_cons_vehicle  , 
     sum(fa_value_add_cons_other)  fa_value_add_cons_other  , 

    sum(fa_value_add_other_machine)  fa_value_add_other_machine  ,  
     sum(fa_value_add_other_building)  fa_value_add_other_building  ,  
     sum(fa_value_add_other_vehicle)  fa_value_add_other_vehicle  , 
     sum(fa_value_add_other_other)  fa_value_add_other_other , 

sum(fa_accu_dep_add_pur_machine) fa_accu_dep_add_pur_machine , 
     sum(fa_accu_dep_add_pur_building) fa_accu_dep_add_pur_building , 
     sum(fa_accu_dep_add_pur_vehicle) fa_accu_dep_add_pur_vehicle , 
     sum(fa_accu_dep_add_pur_other) fa_accu_dep_add_pur_other  , 
 sum(fa_accu_dep_add_cons_machine)  fa_accu_dep_add_cons_machine,
     sum(fa_accu_dep_add_cons_building) fa_accu_dep_add_cons_building,
     sum(fa_accu_dep_add_cons_vehicle) fa_accu_dep_add_cons_vehicle,
     sum(fa_accu_dep_add_cons_other) fa_accu_dep_add_cons_other ,

sum(fa_accu_dep_add_other_machine)  fa_accu_dep_add_other_machine,
     sum(fa_accu_dep_add_other_building) fa_accu_dep_add_other_building,
     sum(fa_accu_dep_add_other_vehicle) fa_accu_dep_add_other_vehicle,
     sum(fa_accu_dep_add_other_other) fa_accu_dep_add_other_other ,


   sum(fa_value_reduce) fa_value_reduce ,
     sum(fa_accu_dep_reduce)fa_accu_dep_reduce , 

     sum(fa_value_red_useless_machine)  fa_value_red_useless_machine ,
     sum(fa_value_red_useless_building)  fa_value_red_useless_building , 
     sum(fa_value_red_useless_vehicle)  fa_value_red_useless_vehicle , 
     sum(fa_value_red_useless_other)  fa_value_red_useless_other , 

     
     sum(fa_value_red_other_machine) fa_value_red_other_machine,
     sum(fa_value_red_other_building) fa_value_red_other_building,
     sum(fa_value_red_other_vehicle) fa_value_red_other_vehicle,
     sum(fa_value_red_other_other) fa_value_red_other_other, 
     
     
     
     sum(fa_accu_dep_red_ul_machine) fa_accu_dep_red_ul_machine , 
     sum(fa_accu_dep_red_ul_building) fa_accu_dep_red_ul_building ,
     sum(fa_accu_dep_red_ul_vehicle) fa_accu_dep_red_ul_vehicle ,
     sum(fa_accu_dep_red_ul_other) fa_accu_dep_red_ul_other ,
     

     
     sum(fa_accu_dep_red_other_machine) fa_accu_dep_red_other_machine, 
     sum(fa_accu_dep_red_other_building) fa_accu_dep_red_other_building, 
     sum(fa_accu_dep_red_other_vehicle) fa_accu_dep_red_other_vehicle, 
     sum(fa_accu_dep_red_other_other) fa_accu_dep_red_other_other
     
     
     

  

 
                 


from 
(
select   cc.ASSET_CODE,cc.ASSET_NAME , 

      
  decode(  parameter('begin_year_param') || parameter('begin_month_param')  , '201801' ,        
           decode( aa.accyear||aa.period , parameter('begin_year_param') || parameter('begin_month_param') , 
                 decode( aa.newasset_flag, 1 , 0,
                      decode( aa.asset_state ,'reduce' , 0, aa.localoriginvalue)) , 0 ),
           decode( aa.accyear||aa.period  , parameter('begin_year_param') || parameter('begin_month_param')  , 
                   decode(aa.newasset_flag ,0 , 0  , 1, 0 , 
                        decode(aa.asset_state , 'reduce' , 0 , aa.localoriginvalue) )  , 0 )
           ) fa_value_begin   ,    
           
                  
  decode(  parameter('begin_year_param') || parameter('begin_month_param')  , '201801' ,        
            decode( aa.accyear||aa.period , parameter('begin_year_param') || parameter('begin_month_param') , 
                 decode( aa.newasset_flag, 1 , 0,
                      decode( aa.asset_state ,'reduce' , 0, 
                         decode(   bb.CATE_NAME , '房屋及建筑物' , aa.localoriginvalue , 0 ) )) , 0 ),
           decode( aa.accyear||aa.period  , parameter('begin_year_param') || parameter('begin_month_param')  , 
                   decode(aa.newasset_flag ,0 , 0  , 1, 0 , 
                        decode(aa.asset_state , 'reduce' , 0 , 
                                 decode(   bb.CATE_NAME , '房屋及建筑物' , aa.localoriginvalue , 0 )    ) )  , 0 )
           ) fa_value_begin_building   ,                    
                                 
                  
    decode(  parameter('begin_year_param') || parameter('begin_month_param')  , '201801' ,        
           decode( aa.accyear||aa.period , parameter('begin_year_param') || parameter('begin_month_param') , 
                 decode( aa.newasset_flag, 1 , 0,
                      decode( aa.asset_state ,'reduce' , 0, 
                         decode(   bb.CATE_NAME , '机器设备' , aa.localoriginvalue , 0 ) )) , 0 ),
           decode( aa.accyear||aa.period  , parameter('begin_year_param') || parameter('begin_month_param')  , 
                   decode(aa.newasset_flag ,0 , 0  , 1, 0 , 
                        decode(aa.asset_state , 'reduce' , 0 , 
                                 decode(   bb.CATE_NAME , '机器设备' , aa.localoriginvalue , 0 )    ) )  , 0 )
           ) fa_value_begin_machine   ,                 
                  
                                 
   decode(  parameter('begin_year_param') || parameter('begin_month_param')  , '201801' ,        
           decode( aa.accyear||aa.period , parameter('begin_year_param') || parameter('begin_month_param') , 
                 decode( aa.newasset_flag, 1 , 0,
                      decode( aa.asset_state ,'reduce' , 0, 
                         decode(   bb.CATE_NAME , '运输工具' , aa.localoriginvalue , 0 ) )) , 0 ),
           decode( aa.accyear||aa.period  , parameter('begin_year_param') || parameter('begin_month_param')  , 
                   decode(aa.newasset_flag ,0 , 0  , 1, 0 , 
                        decode(aa.asset_state , 'reduce' , 0 , 
                                 decode(   bb.CATE_NAME , '运输工具' , aa.localoriginvalue , 0 )    ) )  , 0 )
           ) fa_value_begin_vehicle   ,                 
                  
                  
         
            
  decode(  parameter('begin_year_param') || parameter('begin_month_param')  , '201801' ,        
           decode( aa.accyear||aa.period , parameter('begin_year_param') || parameter('begin_month_param') , 
                 decode( aa.newasset_flag, 1 , 0,
                      decode( aa.asset_state ,'reduce' , 0, aa.accudep)) , 0 ),
           decode( aa.accyear||aa.period  , parameter('begin_year_param') || parameter('begin_month_param')  , 
                   decode(aa.newasset_flag ,0 , 0  , 1, 0 , 
                        decode(aa.asset_state , 'reduce' , 0 , aa.accudep) )  , 0 )
           ) fa_accu_dep_begin   ,         
           
           
           
    decode(  parameter('begin_year_param') || parameter('begin_month_param')  , '201801' ,        
          decode( aa.accyear||aa.period , parameter('begin_year_param') || parameter('begin_month_param') , 
                 decode( aa.newasset_flag, 1 , 0,
                      decode( aa.asset_state ,'reduce' , 0, 
                         decode(   bb.CATE_NAME , '房屋及建筑物' , aa.accudep , 0 ) )) , 0 ),
           decode( aa.accyear||aa.period  , parameter('begin_year_param') || parameter('begin_month_param')  , 
                   decode(aa.newasset_flag ,0 , 0  , 1, 0 , 
                        decode(aa.asset_state , 'reduce' , 0 , 
                                 decode(   bb.CATE_NAME , '房屋及建筑物' , aa.accudep , 0 )    ) )  , 0 )
           ) fa_accu_dep_begin_building   ,                    
                                 
                  
    decode(  parameter('begin_year_param') || parameter('begin_month_param')  , '201801' ,        
          decode( aa.accyear||aa.period , parameter('begin_year_param') || parameter('begin_month_param') , 
                 decode( aa.newasset_flag, 1 , 0,
                      decode( aa.asset_state ,'reduce' , 0, 
                         decode(   bb.CATE_NAME , '机器设备' , aa.accudep , 0 ) )) , 0 ),
           decode( aa.accyear||aa.period  , parameter('begin_year_param') || parameter('begin_month_param')  , 
                   decode(aa.newasset_flag ,0 , 0  , 1, 0 , 
                        decode(aa.asset_state , 'reduce' , 0 , 
                                 decode(   bb.CATE_NAME , '机器设备' , aa.accudep , 0 )    ) )  , 0 )
           ) fa_accu_dep_begin_machine   ,                 
                  
                                 
   decode(  parameter('begin_year_param') || parameter('begin_month_param')  , '201801' ,        
          decode( aa.accyear||aa.period , parameter('begin_year_param') || parameter('begin_month_param') , 
                 decode( aa.newasset_flag, 1 , 0,
                      decode( aa.asset_state ,'reduce' , 0, 
                         decode(   bb.CATE_NAME , '运输工具' , aa.accudep , 0 ) )) , 0 ),
           decode( aa.accyear||aa.period  , parameter('begin_year_param') || parameter('begin_month_param')  , 
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
                  
                
                  
  decode(aa.accyear || aa.period, parameter('begin_year_param') || parameter('begin_month_param') , 0  , aa.depamount ) fa_curr_dep_end , 
  
  
  decode(aa.accyear || aa.period, parameter('begin_year_param') || parameter('begin_month_param') , 0  , 
              decode(   bb.CATE_NAME , '房屋及建筑物'   , aa.depamount , 0 ) ) fa_curr_dep_end_building , 
  decode(aa.accyear || aa.period, parameter('begin_year_param') || parameter('begin_month_param') , 0  , 
              decode(   bb.CATE_NAME , '机器设备'   , aa.depamount , 0 ) ) fa_curr_dep_end_machine , 
  decode(aa.accyear || aa.period, parameter('begin_year_param') || parameter('begin_month_param') , 0  , 
              decode(   bb.CATE_NAME , '运输工具'   , aa.depamount , 0 ) ) fa_curr_dep_end_vehicle    , 
              
              
              
  decode( aa.accyear || aa.period  , '201801' ,  
          decode( aa.newasset_flag , 1, aa.localoriginvalue , 0 ) , 
          decode ( aa.accyear || aa.period  , macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep')  ,  0 , 
                    decode ( aa.newasset_flag  , 1 ,  aa.localoriginvalue  , 0  ,  aa.localoriginvalue  ,0 )   ) )  fa_value_add  , 
                    
                    
  decode( aa.accyear || aa.period  , '201801' ,  
          decode( aa.newasset_flag , 1,  decode(   bb.CATE_NAME , '房屋及建筑物'   , aa.localoriginvalue , 0 ) , 0 ) , 
          decode ( aa.accyear || aa.period  , macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep')  ,  0 , 
                    decode ( aa.newasset_flag  , 1 ,  
                       decode(   bb.CATE_NAME , '房屋及建筑物'   , aa.localoriginvalue , 0 )  , 0  ,   
                              decode(   bb.CATE_NAME , '房屋及建筑物'   , aa.localoriginvalue , 0 )  ,0 )   ) )  fa_value_add_building  , 
                              
  decode(dd.style_name, '直接购入', decode( aa.accyear || aa.period  , '201801' ,  
          decode( aa.newasset_flag , 1,  decode(   bb.CATE_NAME , '房屋及建筑物'   , aa.localoriginvalue , 0 ) , 0 ) , 
          decode ( aa.accyear || aa.period  , macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep')  ,  0 , 
                    decode ( aa.newasset_flag  , 1 ,  
                       decode(   bb.CATE_NAME , '房屋及建筑物'   , aa.localoriginvalue , 0 )  , 0  ,   
                              decode(   bb.CATE_NAME , '房屋及建筑物'   , aa.localoriginvalue , 0 )  ,0 )   ) ), 0) fa_value_add_purchase_building,                    
  
  decode(dd.style_name, '在建工程转入', decode( aa.accyear || aa.period  , '201801' ,  
          decode( aa.newasset_flag , 1,  decode(   bb.CATE_NAME , '房屋及建筑物'   , aa.localoriginvalue , 0 ) , 0 ) , 
          decode ( aa.accyear || aa.period  , macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep')  ,  0 , 
                    decode ( aa.newasset_flag  , 1 ,  
                       decode(   bb.CATE_NAME , '房屋及建筑物'   , aa.localoriginvalue , 0 )  , 0  ,   
                              decode(   bb.CATE_NAME , '房屋及建筑物'   , aa.localoriginvalue , 0 )  ,0 )   ) ), 0) fa_value_add_cons_building ,                    
                          
  decode(dd.style_name, '在建工程转入', 0 , '直接购入' , 0 ,   decode( aa.accyear || aa.period  , '201801' ,  
          decode( aa.newasset_flag , 1,  decode(   bb.CATE_NAME , '房屋及建筑物'   , aa.localoriginvalue , 0 ) , 0 ) , 
          decode ( aa.accyear || aa.period  , macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep')  ,  0 , 
                    decode ( aa.newasset_flag  , 1 ,  
                       decode(   bb.CATE_NAME , '房屋及建筑物'   , aa.localoriginvalue , 0 )  , 0  ,   
                              decode(   bb.CATE_NAME , '房屋及建筑物'   , aa.localoriginvalue , 0 )  ,0 )   ) ))   fa_value_add_other_building , 
  
                              
                              
  decode( aa.accyear || aa.period  , '201801' ,  
          decode( aa.newasset_flag , 1,  decode(   bb.CATE_NAME , '机器设备'   , aa.localoriginvalue , 0 ) , 0 ) , 
          decode ( aa.accyear || aa.period  , macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep')  ,  0 , 
                    decode ( aa.newasset_flag  , 1 ,  
                       decode(   bb.CATE_NAME , '机器设备'   , aa.localoriginvalue , 0 )  , 0  ,   
                              decode(   bb.CATE_NAME , '机器设备'   , aa.localoriginvalue , 0 )  ,0 )   ) )  fa_value_add_machine  , 
                              
                              
                              
  decode(dd.style_name, '直接购入'  ,decode( aa.accyear || aa.period  , '201801' ,  
          decode( aa.newasset_flag , 1,  decode(   bb.CATE_NAME , '机器设备'   , aa.localoriginvalue , 0 ) , 0 ) , 
          decode ( aa.accyear || aa.period  , macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep')  ,  0 , 
                    decode ( aa.newasset_flag  , 1 ,  
                       decode(   bb.CATE_NAME , '机器设备'   , aa.localoriginvalue , 0 )  , 0  ,   
                              decode(   bb.CATE_NAME , '机器设备'   , aa.localoriginvalue , 0 )  ,0 )   ) )  ,  0  )  fa_value_add_purchase_machine ,
                              
  
  decode(dd.style_name, '在建工程转入'  ,decode( aa.accyear || aa.period  , '201801' ,  
          decode( aa.newasset_flag , 1,  decode(   bb.CATE_NAME , '机器设备'   , aa.localoriginvalue , 0 ) , 0 ) , 
          decode ( aa.accyear || aa.period  , macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep')  ,  0 , 
                    decode ( aa.newasset_flag  , 1 ,  
                       decode(   bb.CATE_NAME , '机器设备'   , aa.localoriginvalue , 0 )  , 0  ,   
                              decode(   bb.CATE_NAME , '机器设备'   , aa.localoriginvalue , 0 )  ,0 )   ) )  ,  0  )  fa_value_add_cons_machine ,
                              
  
  
  decode(dd.style_name, '在建工程转入', 0 , '直接购入' , 0 , decode( aa.accyear || aa.period  , '201801' ,  
          decode( aa.newasset_flag , 1,  decode(   bb.CATE_NAME , '机器设备'   , aa.localoriginvalue , 0 ) , 0 ) , 
          decode ( aa.accyear || aa.period  , macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep')  ,  0 , 
                    decode ( aa.newasset_flag  , 1 ,  
                       decode(   bb.CATE_NAME , '机器设备'   , aa.localoriginvalue , 0 )  , 0  ,   
                              decode(   bb.CATE_NAME , '机器设备'   , aa.localoriginvalue , 0 )  ,0 )   ) ) )   fa_value_add_other_machine , 
                    
                              
                              
                                                          
  decode( aa.accyear || aa.period  , '201801' ,  
          decode( aa.newasset_flag , 1,  decode(   bb.CATE_NAME , '运输工具'   , aa.localoriginvalue , 0 ) , 0 ) , 
          decode ( aa.accyear || aa.period  , macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep')  ,  0 , 
                    decode ( aa.newasset_flag  , 1 ,  
                       decode(   bb.CATE_NAME , '运输工具'   , aa.localoriginvalue , 0 )  , 0  ,   
                              decode(   bb.CATE_NAME , '运输工具'   , aa.localoriginvalue , 0 )  ,0 )   ) )  fa_value_add_vehicle  ,    
                              
  
  decode(dd.style_name, '直接购入' , decode( aa.accyear || aa.period  , '201801' ,  
          decode( aa.newasset_flag , 1,  decode(   bb.CATE_NAME , '运输工具'   , aa.localoriginvalue , 0 ) , 0 ) , 
          decode ( aa.accyear || aa.period  , macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep')  ,  0 , 
                    decode ( aa.newasset_flag  , 1 ,  
                       decode(   bb.CATE_NAME , '运输工具'   , aa.localoriginvalue , 0 )  , 0  ,   
                              decode(   bb.CATE_NAME , '运输工具'   , aa.localoriginvalue , 0 )  ,0 )   ) ),  0)  fa_value_add_purchase_vehicle, 
                             
  decode(dd.style_name, '在建工程转入' , decode( aa.accyear || aa.period  , '201801' ,  
          decode( aa.newasset_flag , 1,  decode(   bb.CATE_NAME , '运输工具'   , aa.localoriginvalue , 0 ) , 0 ) , 
          decode ( aa.accyear || aa.period  , macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep')  ,  0 , 
                    decode ( aa.newasset_flag  , 1 ,  
                       decode(   bb.CATE_NAME , '运输工具'   , aa.localoriginvalue , 0 )  , 0  ,   
                              decode(   bb.CATE_NAME , '运输工具'   , aa.localoriginvalue , 0 )  ,0 )   ) ) , 0)        fa_value_add_cons_vehicle   ,                    
   
   
  decode(dd.style_name, '在建工程转入', 0 , '直接购入' , 0 ,decode( aa.accyear || aa.period  , '201801' ,  
          decode( aa.newasset_flag , 1,  decode(   bb.CATE_NAME , '运输工具'   , aa.localoriginvalue , 0 ) , 0 ) , 
          decode ( aa.accyear || aa.period  , macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep')  ,  0 , 
                    decode ( aa.newasset_flag  , 1 ,  
                       decode(   bb.CATE_NAME , '运输工具'   , aa.localoriginvalue , 0 )  , 0  ,   
                              decode(   bb.CATE_NAME , '运输工具'   , aa.localoriginvalue , 0 )  ,0 )   ) ))  fa_value_add_other_vehicle , 
   
                                                                         
    
  decode ( bb.CATE_NAME , '房屋及建筑物' ,  0 ,'机器设备'  ,  0 ,  '运输工具'  , 0 ,   
        decode( aa.accyear || aa.period  , '201801' ,  
          decode( aa.newasset_flag , 1,  aa.localoriginvalue , 0 ) , 
          decode ( aa.accyear || aa.period  , macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep')  ,  0 , 
                    decode ( aa.newasset_flag  , 1 ,  aa.localoriginvalue  , 0  ,   aa.localoriginvalue  ,0 )   ) )  
   )  fa_value_add_other, 
   
   decode(dd.style_name, '直接购入' , decode ( bb.CATE_NAME , '房屋及建筑物' ,  0 ,'机器设备'  ,  0 ,  '运输工具'  , 0 ,   
        decode( aa.accyear || aa.period  , '201801' ,  
          decode( aa.newasset_flag , 1,  aa.localoriginvalue , 0 ) , 
          decode ( aa.accyear || aa.period  , macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep')  ,  0 , 
                    decode ( aa.newasset_flag  , 1 ,  aa.localoriginvalue  , 0  ,   aa.localoriginvalue  ,0 )   ) )  
   ) , 0 ) fa_value_add_purchase_other  , 
   
   
   decode(dd.style_name, '在建工程转入', decode ( bb.CATE_NAME , '房屋及建筑物' ,  0 ,'机器设备'  ,  0 ,  '运输工具'  , 0 ,   
        decode( aa.accyear || aa.period  , '201801' ,  
          decode( aa.newasset_flag , 1,  aa.localoriginvalue , 0 ) , 
          decode ( aa.accyear || aa.period  , macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep')  ,  0 , 
                    decode ( aa.newasset_flag  , 1 ,  aa.localoriginvalue  , 0  ,   aa.localoriginvalue  ,0 )   ) )  
   ) , 0 )   fa_value_add_cons_other , 
   
   
   decode(dd.style_name, '在建工程转入', 0 , '直接购入' , 0 , decode ( bb.CATE_NAME , '房屋及建筑物' ,  0 ,'机器设备'  ,  0 ,  '运输工具'  , 0 ,   
        decode( aa.accyear || aa.period  , '201801' ,  
          decode( aa.newasset_flag , 1,  aa.localoriginvalue , 0 ) , 
          decode ( aa.accyear || aa.period  , macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep')  ,  0 , 
                    decode ( aa.newasset_flag  , 1 ,  aa.localoriginvalue  , 0  ,   aa.localoriginvalue  ,0 )   ) )  
   ))  fa_value_add_other_other  , 
   
   
   
    
           
   decode( aa.accyear || aa.period  , '201801' ,  
          decode( aa.newasset_flag , 1, aa.accudep , 0 ) , 
          decode ( aa.accyear || aa.period  , macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep')  ,  0 , 
                    decode ( aa.newasset_flag  , 1 ,  aa.accudep  , 0  ,  aa.accudep  ,0 )   ) )  fa_accu_dep_add    ,   
                                       
                     
              
   decode( aa.accyear || aa.period  , '201801' ,  
          decode( aa.newasset_flag , 1,  decode(   bb.CATE_NAME , '房屋及建筑物'   , aa.accudep , 0 ) , 0 ) , 
          decode ( aa.accyear || aa.period  , macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep')  ,  0 , 
                    decode ( aa.newasset_flag  , 1 ,  
                       decode(   bb.CATE_NAME , '房屋及建筑物'   , aa.accudep , 0 )  , 0  ,   
                              decode(   bb.CATE_NAME , '房屋及建筑物'   , aa.accudep , 0 )  ,0 )   ) )  fa_accu_dep_add_building  , 
                              
                              
    decode(dd.style_name, '直接购入' ,  decode( aa.accyear || aa.period  , '201801' ,  
          decode( aa.newasset_flag , 1,  decode(   bb.CATE_NAME , '房屋及建筑物'   , aa.accudep , 0 ) , 0 ) , 
          decode ( aa.accyear || aa.period  , macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep')  ,  0 , 
                    decode ( aa.newasset_flag  , 1 ,  
                       decode(   bb.CATE_NAME , '房屋及建筑物'   , aa.accudep , 0 )  , 0  ,   
                              decode(   bb.CATE_NAME , '房屋及建筑物'   , aa.accudep , 0 )  ,0 )   ) ) , 0)     fa_accu_dep_add_pur_building , 
    
    decode(dd.style_name, '在建工程转入',  decode( aa.accyear || aa.period  , '201801' ,  
          decode( aa.newasset_flag , 1,  decode(   bb.CATE_NAME , '房屋及建筑物'   , aa.accudep , 0 ) , 0 ) , 
          decode ( aa.accyear || aa.period  , macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep')  ,  0 , 
                    decode ( aa.newasset_flag  , 1 ,  
                       decode(   bb.CATE_NAME , '房屋及建筑物'   , aa.accudep , 0 )  , 0  ,   
                              decode(   bb.CATE_NAME , '房屋及建筑物'   , aa.accudep , 0 )  ,0 )   ) ) ,   0 )  fa_accu_dep_add_cons_building , 
    
    decode(dd.style_name, '在建工程转入', 0 , '直接购入' , 0 ,  decode( aa.accyear || aa.period  , '201801' ,  
          decode( aa.newasset_flag , 1,  decode(   bb.CATE_NAME , '房屋及建筑物'   , aa.accudep , 0 ) , 0 ) , 
          decode ( aa.accyear || aa.period  , macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep')  ,  0 , 
                    decode ( aa.newasset_flag  , 1 ,  
                       decode(   bb.CATE_NAME , '房屋及建筑物'   , aa.accudep , 0 )  , 0  ,   
                              decode(   bb.CATE_NAME , '房屋及建筑物'   , aa.accudep , 0 )  ,0 )   ) )) fa_accu_dep_add_other_building , 
                           
                                                         
                              
                              
  decode( aa.accyear || aa.period  , '201801' ,  
          decode( aa.newasset_flag , 1,  decode(   bb.CATE_NAME , '机器设备'   , aa.accudep , 0 ) , 0 ) , 
          decode ( aa.accyear || aa.period  , macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep')  ,  0 , 
                    decode ( aa.newasset_flag  , 1 ,  
                       decode(   bb.CATE_NAME , '机器设备'   , aa.accudep , 0 )  , 0  ,   
                              decode(   bb.CATE_NAME , '机器设备'   , aa.accudep , 0 )  ,0 )   ) )  fa_accu_dep_add_machine  , 
                              
   
   
   decode(dd.style_name, '直接购入' , decode( aa.accyear || aa.period  , '201801' ,  
          decode( aa.newasset_flag , 1,  decode(   bb.CATE_NAME , '机器设备'   , aa.accudep , 0 ) , 0 ) , 
          decode ( aa.accyear || aa.period  , macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep')  ,  0 , 
                    decode ( aa.newasset_flag  , 1 ,  
                       decode(   bb.CATE_NAME , '机器设备'   , aa.accudep , 0 )  , 0  ,   
                              decode(   bb.CATE_NAME , '机器设备'   , aa.accudep , 0 )  ,0 )   ) )  , 0 )    fa_accu_dep_add_pur_machine ,   
   
   decode(dd.style_name, '在建工程转入', decode( aa.accyear || aa.period  , '201801' ,  
          decode( aa.newasset_flag , 1,  decode(   bb.CATE_NAME , '机器设备'   , aa.accudep , 0 ) , 0 ) , 
          decode ( aa.accyear || aa.period  , macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep')  ,  0 , 
                    decode ( aa.newasset_flag  , 1 ,  
                       decode(   bb.CATE_NAME , '机器设备'   , aa.accudep , 0 )  , 0  ,   
                              decode(   bb.CATE_NAME , '机器设备'   , aa.accudep , 0 )  ,0 )   ) )  , 0)  fa_accu_dep_add_cons_machine , 
   
   decode(dd.style_name, '在建工程转入', 0 , '直接购入' , 0 ,decode( aa.accyear || aa.period  , '201801' ,  
          decode( aa.newasset_flag , 1,  decode(   bb.CATE_NAME , '机器设备'   , aa.accudep , 0 ) , 0 ) , 
          decode ( aa.accyear || aa.period  , macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep')  ,  0 , 
                    decode ( aa.newasset_flag  , 1 ,  
                       decode(   bb.CATE_NAME , '机器设备'   , aa.accudep , 0 )  , 0  ,   
                              decode(   bb.CATE_NAME , '机器设备'   , aa.accudep , 0 )  ,0 )   ) ) )  fa_accu_dep_add_other_machine , 
                          
                              
                              
                                                          
  decode( aa.accyear || aa.period  , '201801' ,  
          decode( aa.newasset_flag , 1,  decode(   bb.CATE_NAME , '运输工具'   , aa.accudep , 0 ) , 0 ) , 
          decode ( aa.accyear || aa.period  , macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep')  ,  0 , 
                    decode ( aa.newasset_flag  , 1 ,  
                       decode(   bb.CATE_NAME , '运输工具'   , aa.accudep , 0 )  , 0  ,   
                              decode(   bb.CATE_NAME , '运输工具'   , aa.accudep , 0 )  ,0 )   ) )  fa_accu_dep_add_vehicle    , 
                              
   
   
  decode(dd.style_name, '直接购入' , decode( aa.accyear || aa.period  , '201801' ,  
          decode( aa.newasset_flag , 1,  decode(   bb.CATE_NAME , '运输工具'   , aa.accudep , 0 ) , 0 ) , 
          decode ( aa.accyear || aa.period  , macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep')  ,  0 , 
                    decode ( aa.newasset_flag  , 1 ,  
                       decode(   bb.CATE_NAME , '运输工具'   , aa.accudep , 0 )  , 0  ,   
                              decode(   bb.CATE_NAME , '运输工具'   , aa.accudep , 0 )  ,0 )   ) ) , 0 )    fa_accu_dep_add_pur_vehicle ,   
   
   decode(dd.style_name, '在建工程转入', decode( aa.accyear || aa.period  , '201801' ,  
          decode( aa.newasset_flag , 1,  decode(   bb.CATE_NAME , '运输工具'   , aa.accudep , 0 ) , 0 ) , 
          decode ( aa.accyear || aa.period  , macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep')  ,  0 , 
                    decode ( aa.newasset_flag  , 1 ,  
                       decode(   bb.CATE_NAME , '运输工具'   , aa.accudep , 0 )  , 0  ,   
                              decode(   bb.CATE_NAME , '运输工具'   , aa.accudep , 0 )  ,0 )   ) ) , 0)  fa_accu_dep_add_cons_vehicle , 
   
   decode(dd.style_name, '在建工程转入', 0 , '直接购入' , 0 ,decode( aa.accyear || aa.period  , '201801' ,  
          decode( aa.newasset_flag , 1,  decode(   bb.CATE_NAME , '运输工具'   , aa.accudep , 0 ) , 0 ) , 
          decode ( aa.accyear || aa.period  , macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep')  ,  0 , 
                    decode ( aa.newasset_flag  , 1 ,  
                       decode(   bb.CATE_NAME , '运输工具'   , aa.accudep , 0 )  , 0  ,   
                              decode(   bb.CATE_NAME , '运输工具'   , aa.accudep , 0 )  ,0 )   ) ))  fa_accu_dep_add_other_vehicle ,                             
                              
                              
                           
  decode ( bb.CATE_NAME , '房屋及建筑物' ,  0 ,'机器设备' , 0 ,  '运输工具', 0 , 
       decode( aa.accyear || aa.period  , '201801' ,  
          decode( aa.newasset_flag , 1,  aa.accudep , 0 ) , 
          decode ( aa.accyear || aa.period  , macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep')  ,  0 , 
                    decode ( aa.newasset_flag  , 1 ,  
                      aa.accudep  , 0  ,  aa.accudep  ,0 )   ) ))   fa_accu_dep_add_other , 
   
   decode(dd.style_name, '直接购入' ,   decode ( bb.CATE_NAME , '房屋及建筑物' ,  0 ,'机器设备' , 0 ,  '运输工具', 0 , 
       decode( aa.accyear || aa.period  , '201801' ,  
          decode( aa.newasset_flag , 1,  aa.accudep , 0 ) , 
          decode ( aa.accyear || aa.period  , macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep')  ,  0 , 
                    decode ( aa.newasset_flag  , 1 ,  
                      aa.accudep  , 0  ,  aa.accudep  ,0 )   ) )) , 0 )    fa_accu_dep_add_pur_other ,   
   
   decode(dd.style_name, '在建工程转入',   decode ( bb.CATE_NAME , '房屋及建筑物' ,  0 ,'机器设备' , 0 ,  '运输工具', 0 , 
       decode( aa.accyear || aa.period  , '201801' ,  
          decode( aa.newasset_flag , 1,  aa.accudep , 0 ) , 
          decode ( aa.accyear || aa.period  , macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep')  ,  0 , 
                    decode ( aa.newasset_flag  , 1 ,  
                      aa.accudep  , 0  ,  aa.accudep  ,0 )   ) )) , 0)  fa_accu_dep_add_cons_other , 
   
   decode(dd.style_name, '在建工程转入', 0 , '直接购入' , 0 ,  decode ( bb.CATE_NAME , '房屋及建筑物' ,  0 ,'机器设备' , 0 ,  '运输工具', 0 , 
       decode( aa.accyear || aa.period  , '201801' ,  
          decode( aa.newasset_flag , 1,  aa.accudep , 0 ) , 
          decode ( aa.accyear || aa.period  , macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep')  ,  0 , 
                    decode ( aa.newasset_flag  , 1 ,  
                      aa.accudep  , 0  ,  aa.accudep  ,0 )   ) )))  fa_accu_dep_add_other_other  ,


decode( aa.accyear||aa.period  , parameter('begin_year_param') || parameter('begin_month_param') , 0 , 
           decode(  aa.asset_state ,'reduce' ,  aa.localoriginvalue , 0 ) )     fa_value_reduce ,


  decode( nvl(ff.style_name,'~')  , '报废' ,decode( aa.accyear||aa.period  , parameter('begin_year_param') || parameter('begin_month_param') , 0 , 
           decode(  aa.asset_state ,'reduce' , 
              decode(   bb.CATE_NAME , '运输工具'   , aa.localoriginvalue , 0 ) , 0 ) )  , 0 ) fa_value_red_useless_vehicle  , 
   
   
   decode( nvl(ff.style_name,'~')  , '报废' ,decode( aa.accyear||aa.period  , parameter('begin_year_param') || parameter('begin_month_param') , 0 , 
           decode(  aa.asset_state ,'reduce' , 
              decode(   bb.CATE_NAME , '机器设备'   , aa.localoriginvalue , 0 ) , 0 ) )  , 0 ) fa_value_red_useless_machine  , 
   
   
   decode( nvl(ff.style_name,'~')  , '报废' ,decode( aa.accyear||aa.period  , parameter('begin_year_param') || parameter('begin_month_param') , 0 , 
           decode(  aa.asset_state ,'reduce' , 
              decode(   bb.CATE_NAME , '房屋及建筑物'   , aa.localoriginvalue , 0 ) , 0 ) )  , 0 ) fa_value_red_useless_building  , 
              
   decode( nvl(ff.style_name,'~')  , '报废' ,decode( aa.accyear||aa.period  , parameter('begin_year_param') || parameter('begin_month_param') , 0 , 
           decode(  aa.asset_state ,'reduce' , 
              decode(   bb.CATE_NAME , '房屋及建筑物' , 0 ,'运输工具', 0 , '机器设备' ,0,  aa.localoriginvalue ) , 0 ) )  , 0 ) fa_value_red_useless_other  ,            
              
              
           
      decode( nvl(ff.style_name,'~')  , '报废' ,0 ,'~' , 0 ,  decode( aa.accyear||aa.period  , parameter('begin_year_param') || parameter('begin_month_param') , 0 , 
           decode(  aa.asset_state ,'reduce' , 
              decode(   bb.CATE_NAME , '运输工具'   , aa.localoriginvalue , 0 ) , 0 ) )  ) fa_value_red_other_vehicle  , 
   
   
   decode( nvl(ff.style_name,'~')  , '报废' , 0 , '~' ,0 , decode( aa.accyear||aa.period  , parameter('begin_year_param') || parameter('begin_month_param') , 0 , 
           decode(  aa.asset_state ,'reduce' , 
              decode(   bb.CATE_NAME , '机器设备'   , aa.localoriginvalue , 0 ) , 0 ) ) ) fa_value_red_other_machine  , 
   
   
   decode( nvl(ff.style_name,'~')  , '报废' , 0 , '~' , 0 ,decode( aa.accyear||aa.period  , parameter('begin_year_param') || parameter('begin_month_param') , 0 , 
           decode(  aa.asset_state ,'reduce' , 
              decode(   bb.CATE_NAME , '房屋及建筑物'   , aa.localoriginvalue , 0 ) , 0 ) ) ) fa_value_red_other_building  , 
              
   decode( nvl(ff.style_name,'~')  , '报废' , 0 , '~', 0 , decode( aa.accyear||aa.period  , parameter('begin_year_param') || parameter('begin_month_param') , 0 , 
           decode(  aa.asset_state ,'reduce' , 
              decode(   bb.CATE_NAME , '房屋及建筑物' , 0 ,'运输工具', 0 , '机器设备' ,0,  aa.localoriginvalue  ) , 0 ) ) ) fa_value_red_other_other , 

 decode( aa.accyear||aa.period  ,parameter('begin_year_param') || parameter('begin_month_param'), 0 , 
           decode(  aa.asset_state ,'reduce' ,  aa.accudep , 0 ) )     fa_accu_dep_reduce    , 
           
           
    decode( nvl(ff.style_name,'~')  , '报废' ,decode( aa.accyear||aa.period  , parameter('begin_year_param') || parameter('begin_month_param') , 0 ,
					decode(  aa.asset_state ,'reduce' ,
					decode(   bb.CATE_NAME , '运输工具'   ,  aa.accudep , 0 ) , 0 ) )  , 0 ) fa_accu_dep_red_ul_vehicle  ,
					
					
		 decode( nvl(ff.style_name,'~')  , '报废' ,decode( aa.accyear||aa.period  , parameter('begin_year_param') || parameter('begin_month_param') , 0 ,
					decode(  aa.asset_state ,'reduce' ,
					decode(   bb.CATE_NAME , '房屋及建筑物'   ,  aa.accudep , 0 ) , 0 ) )  , 0 ) fa_accu_dep_red_ul_building  ,		
					
					
		 decode( nvl(ff.style_name,'~')  , '报废' ,decode( aa.accyear||aa.period  , parameter('begin_year_param') || parameter('begin_month_param') , 0 ,
					decode(  aa.asset_state ,'reduce' ,
					decode(   bb.CATE_NAME , '机器设备'   ,  aa.accudep , 0 ) , 0 ) )  , 0 ) fa_accu_dep_red_ul_machine  ,						       
           
       
       decode( nvl(ff.style_name,'~')  , '报废' ,decode( aa.accyear||aa.period  , parameter('begin_year_param') || parameter('begin_month_param') , 0 ,
					decode(  aa.asset_state ,'reduce' ,
					decode(   bb.CATE_NAME , '机器设备'   , 0 , '房屋及建筑物' ,0 , '运输工具', 0 ,    aa.accudep ) , 0 ) )  , 0 ) fa_accu_dep_red_ul_other , 	
					
							      
           
   decode( nvl(ff.style_name,'~')  , '报废' , 0 , '~', 0 , decode( aa.accyear||aa.period  , parameter('begin_year_param') || parameter('begin_month_param') , 0 ,
					decode(  aa.asset_state ,'reduce' ,
					decode(   bb.CATE_NAME , '运输工具'   ,  aa.accudep , 0 ) , 0 ) )   ) fa_accu_dep_red_other_vehicle  ,
					
					
		 decode( nvl(ff.style_name,'~')  , '报废' , 0 , '~', 0 , decode( aa.accyear||aa.period  , parameter('begin_year_param') || parameter('begin_month_param') , 0 ,
					decode(  aa.asset_state ,'reduce' ,
					decode(   bb.CATE_NAME , '房屋及建筑物'   ,  aa.accudep , 0 ) , 0 ) )   ) fa_accu_dep_red_other_building  ,		
					
					
		 decode( nvl(ff.style_name,'~')  , '报废' , 0, '~' , 0 , decode( aa.accyear||aa.period  , parameter('begin_year_param') || parameter('begin_month_param') , 0 ,
					decode(  aa.asset_state ,'reduce' ,
					decode(   bb.CATE_NAME , '机器设备'   ,  aa.accudep , 0 ) , 0 ) )  ) fa_accu_dep_red_other_machine  ,						       
           
       
       decode( nvl(ff.style_name,'~')  , '报废' ,  0 , '~' , 0  , decode( aa.accyear||aa.period  , parameter('begin_year_param') || parameter('begin_month_param') , 0 ,
					decode(  aa.asset_state ,'reduce' ,
					decode(   bb.CATE_NAME , '机器设备'   , 0 , '房屋及建筑物' ,0 , '运输工具', 0 ,    aa.accudep ) , 0 ) )  ) fa_accu_dep_red_other_other  


   
              
                              
  from 
fa_cardhistory aa   inner join  fa_category  bb 
				    on ( bb.pk_category = aa.pk_category_old 
				         and bb.dr = 0 
				         and aa.laststate_flag = 'N'
				         and aa.dr = 0 
				         and aa.accyear||aa.period  <=  macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep')
				         and aa.accyear||aa.period  >=  parameter('begin_year_param') || parameter('begin_month_param')
				         and aa.pk_org = 
				             (select xx.PK_FINANCEORG  from ORG_FINANCEORG  xx where xx.dr = 0  and  xx.code = parameter('org_code') ) 
				        
                )  inner join fa_card cc   
            on  (  cc.pk_card =  aa.pk_card   and cc.dr = 0   and cc.asset_code like  parameter('fa_code') ) 

inner join     pam_addreducestyle dd on ( dd.pk_addreducestyle = cc.PK_ADDREDUCESTYLE and dd.dr = 0  ) 

left join fa_reduce_b  ee
           on  ( aa.pk_card = ee.pk_card    and ee.dr = 0 )
left join pam_addreducestyle ff 
           on (  ee.pk_reducestyle = ff.pk_addreducestyle    and ff.dr =0)

)

