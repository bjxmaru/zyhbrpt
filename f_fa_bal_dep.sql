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
                         decode(   bb.CATE_NAME , '���ݼ�������' , aa.localoriginvalue , 0 ) )) , 0 ),
           decode( aa.accyear||aa.period  , parameter('begin_year') || parameter('begin_month')  , 
                   decode(aa.newasset_flag ,0 , 0  , 1, 0 , 
                        decode(aa.asset_state , 'reduce' , 0 , 
                                 decode(   bb.CATE_NAME , '���ݼ�������' , aa.localoriginvalue , 0 )    ) )  , 0 )
           ) fa_value_begin_building   ,                    
                                 
                  
    decode(  parameter('begin_year') || parameter('begin_month')  , '201801' ,        
           decode( aa.accyear||aa.period , parameter('begin_year') || parameter('begin_month') , 
                 decode( aa.newasset_flag, 1 , 0,
                      decode( aa.asset_state ,'reduce' , 0, 
                         decode(   bb.CATE_NAME , '�����豸' , aa.localoriginvalue , 0 ) )) , 0 ),
           decode( aa.accyear||aa.period  , parameter('begin_year') || parameter('begin_month')  , 
                   decode(aa.newasset_flag ,0 , 0  , 1, 0 , 
                        decode(aa.asset_state , 'reduce' , 0 , 
                                 decode(   bb.CATE_NAME , '�����豸' , aa.localoriginvalue , 0 )    ) )  , 0 )
           ) fa_value_begin_machine   ,                 
                  
                                 
   decode(  parameter('begin_year') || parameter('begin_month')  , '201801' ,        
           decode( aa.accyear||aa.period , parameter('begin_year') || parameter('begin_month') , 
                 decode( aa.newasset_flag, 1 , 0,
                      decode( aa.asset_state ,'reduce' , 0, 
                         decode(   bb.CATE_NAME , '���乤��' , aa.localoriginvalue , 0 ) )) , 0 ),
           decode( aa.accyear||aa.period  , parameter('begin_year') || parameter('begin_month')  , 
                   decode(aa.newasset_flag ,0 , 0  , 1, 0 , 
                        decode(aa.asset_state , 'reduce' , 0 , 
                                 decode(   bb.CATE_NAME , '���乤��' , aa.localoriginvalue , 0 )    ) )  , 0 )
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
                         decode(   bb.CATE_NAME , '���ݼ�������' , aa.accudep , 0 ) )) , 0 ),
           decode( aa.accyear||aa.period  , parameter('begin_year') || parameter('begin_month')  , 
                   decode(aa.newasset_flag ,0 , 0  , 1, 0 , 
                        decode(aa.asset_state , 'reduce' , 0 , 
                                 decode(   bb.CATE_NAME , '���ݼ�������' , aa.accudep , 0 )    ) )  , 0 )
           ) fa_accu_dep_begin_building   ,                    
                                 
                  
    decode(  parameter('begin_year') || parameter('begin_month')  , '201801' ,        
          decode( aa.accyear||aa.period , parameter('begin_year') || parameter('begin_month') , 
                 decode( aa.newasset_flag, 1 , 0,
                      decode( aa.asset_state ,'reduce' , 0, 
                         decode(   bb.CATE_NAME , '�����豸' , aa.accudep , 0 ) )) , 0 ),
           decode( aa.accyear||aa.period  , parameter('begin_year') || parameter('begin_month')  , 
                   decode(aa.newasset_flag ,0 , 0  , 1, 0 , 
                        decode(aa.asset_state , 'reduce' , 0 , 
                                 decode(   bb.CATE_NAME , '�����豸' , aa.accudep , 0 )    ) )  , 0 )
           ) fa_accu_dep_begin_machine   ,                 
                  
                                 
   decode(  parameter('begin_year') || parameter('begin_month')  , '201801' ,        
          decode( aa.accyear||aa.period , parameter('begin_year') || parameter('begin_month') , 
                 decode( aa.newasset_flag, 1 , 0,
                      decode( aa.asset_state ,'reduce' , 0, 
                         decode(   bb.CATE_NAME , '���乤��' , aa.accudep , 0 ) )) , 0 ),
           decode( aa.accyear||aa.period  , parameter('begin_year') || parameter('begin_month')  , 
                   decode(aa.newasset_flag ,0 , 0  , 1, 0 , 
                        decode(aa.asset_state , 'reduce' , 0 , 
                                 decode(   bb.CATE_NAME , '���乤��' , aa.accudep , 0 )    ) )  , 0 )
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
                          decode(   bb.CATE_NAME , '���ݼ�������' , aa.localoriginvalue , 0 )  )) ,0) ,
           decode( aa.accyear||aa.period  ,macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep') , 
                   decode(aa.newasset_flag ,0 , 0  , 1, 0 , 
                        decode(aa.asset_state , 'reduce' , 0 , 
                               decode(   bb.CATE_NAME , '���ݼ�������' , aa.localoriginvalue , 0 )) )  , 0 )
           ) fa_value_end_building  , 
 
                  
    decode(  macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep') , '201801' ,        
           decode(  aa.accyear||aa.period  , macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep') , decode( aa.newasset_flag, 1 , 0,
                   decode( aa.asset_state ,'reduce' , 0, 
                          decode(   bb.CATE_NAME , '�����豸' , aa.localoriginvalue , 0 )  )) ,0) ,
           decode( aa.accyear||aa.period  ,macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep') , 
                   decode(aa.newasset_flag ,0 , 0  , 1, 0 , 
                        decode(aa.asset_state , 'reduce' , 0 , 
                               decode(   bb.CATE_NAME , '�����豸' , aa.localoriginvalue , 0 )) )  , 0 )
           ) fa_value_end_machine  , 
               
        
                 
                  
   decode(  macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep') , '201801' ,        
          decode(  aa.accyear||aa.period  , macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep') ,  decode( aa.newasset_flag, 1 , 0,
                   decode( aa.asset_state ,'reduce' , 0, 
                          decode(   bb.CATE_NAME , '���乤��' , aa.localoriginvalue , 0 )  )) ,0) ,
           decode( aa.accyear||aa.period  ,macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep') , 
                   decode(aa.newasset_flag ,0 , 0  , 1, 0 , 
                        decode(aa.asset_state , 'reduce' , 0 , 
                               decode(   bb.CATE_NAME , '���乤��' , aa.localoriginvalue , 0 )) )  , 0 )
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
                          decode(   bb.CATE_NAME , '���ݼ�������' , aa.accudep , 0 )  )) ,0),
           decode( aa.accyear||aa.period  ,macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep') , 
                   decode(aa.newasset_flag ,0 , 0  , 1, 0 , 
                        decode(aa.asset_state , 'reduce' , 0 , 
                               decode(   bb.CATE_NAME , '���ݼ�������' , aa.accudep , 0 )) )  , 0 )
           ) fa_accu_dep_end_building  , 
 
                  
    decode(  macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep') , '201801' ,        
         decode(  aa.accyear||aa.period  , macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep') ,   decode( aa.newasset_flag, 1 , 0,
                   decode( aa.asset_state ,'reduce' , 0, 
                          decode(   bb.CATE_NAME , '�����豸' , aa.accudep , 0 )  )) , 0),
           decode( aa.accyear||aa.period  ,macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep') , 
                   decode(aa.newasset_flag ,0 , 0  , 1, 0 , 
                        decode(aa.asset_state , 'reduce' , 0 , 
                               decode(   bb.CATE_NAME , '�����豸' , aa.accudep , 0 )) )  , 0 )
           ) fa_accu_dep_end_machine  , 
               
       
                  
   decode(  macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep') , '201801' ,        
          decode(  aa.accyear||aa.period  , macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep') ,  decode( aa.newasset_flag, 1 , 0,
                   decode( aa.asset_state ,'reduce' , 0, 
                          decode(   bb.CATE_NAME , '���乤��' , aa.accudep , 0 )  )) , 0) ,
           decode( aa.accyear||aa.period  ,macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep') , 
                   decode(aa.newasset_flag ,0 , 0  , 1, 0 , 
                        decode(aa.asset_state , 'reduce' , 0 , 
                               decode(   bb.CATE_NAME , '���乤��' , aa.accudep , 0 )) )  , 0 )
           ) fa_accu_dep_end_vehicle  ,            
                  
                
                  
  decode(aa.accyear || aa.period, parameter('begin_year') || parameter('begin_month') , 0  , aa.depamount ) fa_curr_dep_end , 
  
  
  decode(aa.accyear || aa.period, parameter('begin_year') || parameter('begin_month') , 0  , 
              decode(   bb.CATE_NAME , '���ݼ�������'   , aa.depamount , 0 ) ) fa_curr_dep_end_building , 
  decode(aa.accyear || aa.period, parameter('begin_year') || parameter('begin_month') , 0  , 
              decode(   bb.CATE_NAME , '�����豸'   , aa.depamount , 0 ) ) fa_curr_dep_end_machine , 
  decode(aa.accyear || aa.period, parameter('begin_year') || parameter('begin_month') , 0  , 
              decode(   bb.CATE_NAME , '���乤��'   , aa.depamount , 0 ) ) fa_curr_dep_end_vehicle    , 
              
              
              
  decode( aa.accyear || aa.period  , '201801' ,  
          decode( aa.newasset_flag , 1, aa.localoriginvalue , 0 ) , 
          decode ( aa.accyear || aa.period  , macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep')  ,  0 , 
                    decode ( aa.newasset_flag  , 1 ,  aa.localoriginvalue  , 0  ,  aa.localoriginvalue  ,0 )   ) )  fa_value_add  , 
                    
                    
  decode( aa.accyear || aa.period  , '201801' ,  
          decode( aa.newasset_flag , 1,  decode(   bb.CATE_NAME , '���ݼ�������'   , aa.localoriginvalue , 0 ) , 0 ) , 
          decode ( aa.accyear || aa.period  , macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep')  ,  0 , 
                    decode ( aa.newasset_flag  , 1 ,  
                       decode(   bb.CATE_NAME , '���ݼ�������'   , aa.localoriginvalue , 0 )  , 0  ,   
                              decode(   bb.CATE_NAME , '���ݼ�������'   , aa.localoriginvalue , 0 )  ,0 )   ) )  fa_value_add_building  , 
                              
  decode(dd.style_name, 'ֱ�ӹ���', decode( aa.accyear || aa.period  , '201801' ,  
          decode( aa.newasset_flag , 1,  decode(   bb.CATE_NAME , '���ݼ�������'   , aa.localoriginvalue , 0 ) , 0 ) , 
          decode ( aa.accyear || aa.period  , macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep')  ,  0 , 
                    decode ( aa.newasset_flag  , 1 ,  
                       decode(   bb.CATE_NAME , '���ݼ�������'   , aa.localoriginvalue , 0 )  , 0  ,   
                              decode(   bb.CATE_NAME , '���ݼ�������'   , aa.localoriginvalue , 0 )  ,0 )   ) ), 0) fa_value_add_purchase_building,                    
  
  decode(dd.style_name, '�ڽ�����ת��', decode( aa.accyear || aa.period  , '201801' ,  
          decode( aa.newasset_flag , 1,  decode(   bb.CATE_NAME , '���ݼ�������'   , aa.localoriginvalue , 0 ) , 0 ) , 
          decode ( aa.accyear || aa.period  , macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep')  ,  0 , 
                    decode ( aa.newasset_flag  , 1 ,  
                       decode(   bb.CATE_NAME , '���ݼ�������'   , aa.localoriginvalue , 0 )  , 0  ,   
                              decode(   bb.CATE_NAME , '���ݼ�������'   , aa.localoriginvalue , 0 )  ,0 )   ) ), 0) fa_value_add_cons_building ,                    
                          
  decode(dd.style_name, '�ڽ�����ת��', 0 , 'ֱ�ӹ���' , 0 ,   decode( aa.accyear || aa.period  , '201801' ,  
          decode( aa.newasset_flag , 1,  decode(   bb.CATE_NAME , '���ݼ�������'   , aa.localoriginvalue , 0 ) , 0 ) , 
          decode ( aa.accyear || aa.period  , macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep')  ,  0 , 
                    decode ( aa.newasset_flag  , 1 ,  
                       decode(   bb.CATE_NAME , '���ݼ�������'   , aa.localoriginvalue , 0 )  , 0  ,   
                              decode(   bb.CATE_NAME , '���ݼ�������'   , aa.localoriginvalue , 0 )  ,0 )   ) ))   fa_value_add_other_building , 
  
                              
                              
  decode( aa.accyear || aa.period  , '201801' ,  
          decode( aa.newasset_flag , 1,  decode(   bb.CATE_NAME , '�����豸'   , aa.localoriginvalue , 0 ) , 0 ) , 
          decode ( aa.accyear || aa.period  , macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep')  ,  0 , 
                    decode ( aa.newasset_flag  , 1 ,  
                       decode(   bb.CATE_NAME , '�����豸'   , aa.localoriginvalue , 0 )  , 0  ,   
                              decode(   bb.CATE_NAME , '�����豸'   , aa.localoriginvalue , 0 )  ,0 )   ) )  fa_value_add_machine  , 
                              
                              
                              
  decode(dd.style_name, 'ֱ�ӹ���'  ,decode( aa.accyear || aa.period  , '201801' ,  
          decode( aa.newasset_flag , 1,  decode(   bb.CATE_NAME , '�����豸'   , aa.localoriginvalue , 0 ) , 0 ) , 
          decode ( aa.accyear || aa.period  , macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep')  ,  0 , 
                    decode ( aa.newasset_flag  , 1 ,  
                       decode(   bb.CATE_NAME , '�����豸'   , aa.localoriginvalue , 0 )  , 0  ,   
                              decode(   bb.CATE_NAME , '�����豸'   , aa.localoriginvalue , 0 )  ,0 )   ) )  ,  0  )  fa_value_add_purchase_machine ,
                              
  
  decode(dd.style_name, '�ڽ�����ת��'  ,decode( aa.accyear || aa.period  , '201801' ,  
          decode( aa.newasset_flag , 1,  decode(   bb.CATE_NAME , '�����豸'   , aa.localoriginvalue , 0 ) , 0 ) , 
          decode ( aa.accyear || aa.period  , macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep')  ,  0 , 
                    decode ( aa.newasset_flag  , 1 ,  
                       decode(   bb.CATE_NAME , '�����豸'   , aa.localoriginvalue , 0 )  , 0  ,   
                              decode(   bb.CATE_NAME , '�����豸'   , aa.localoriginvalue , 0 )  ,0 )   ) )  ,  0  )  fa_value_add_cons_mechine ,
                              
  
  
  decode(dd.style_name, '�ڽ�����ת��', 0 , 'ֱ�ӹ���' , 0 , decode( aa.accyear || aa.period  , '201801' ,  
          decode( aa.newasset_flag , 1,  decode(   bb.CATE_NAME , '�����豸'   , aa.localoriginvalue , 0 ) , 0 ) , 
          decode ( aa.accyear || aa.period  , macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep')  ,  0 , 
                    decode ( aa.newasset_flag  , 1 ,  
                       decode(   bb.CATE_NAME , '�����豸'   , aa.localoriginvalue , 0 )  , 0  ,   
                              decode(   bb.CATE_NAME , '�����豸'   , aa.localoriginvalue , 0 )  ,0 )   ) ) )   fa_accu_dep_add_other_machine , 
                    
                              
                              
                                                          
  decode( aa.accyear || aa.period  , '201801' ,  
          decode( aa.newasset_flag , 1,  decode(   bb.CATE_NAME , '���乤��'   , aa.localoriginvalue , 0 ) , 0 ) , 
          decode ( aa.accyear || aa.period  , macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep')  ,  0 , 
                    decode ( aa.newasset_flag  , 1 ,  
                       decode(   bb.CATE_NAME , '���乤��'   , aa.localoriginvalue , 0 )  , 0  ,   
                              decode(   bb.CATE_NAME , '���乤��'   , aa.localoriginvalue , 0 )  ,0 )   ) )  fa_value_add_vehicle  ,    
                              
  
  decode(dd.style_name, 'ֱ�ӹ���' , decode( aa.accyear || aa.period  , '201801' ,  
          decode( aa.newasset_flag , 1,  decode(   bb.CATE_NAME , '���乤��'   , aa.localoriginvalue , 0 ) , 0 ) , 
          decode ( aa.accyear || aa.period  , macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep')  ,  0 , 
                    decode ( aa.newasset_flag  , 1 ,  
                       decode(   bb.CATE_NAME , '���乤��'   , aa.localoriginvalue , 0 )  , 0  ,   
                              decode(   bb.CATE_NAME , '���乤��'   , aa.localoriginvalue , 0 )  ,0 )   ) ),  0)  fa_value_add_purchase_vehicle, 
                             
  decode(dd.style_name, '�ڽ�����ת��' , decode( aa.accyear || aa.period  , '201801' ,  
          decode( aa.newasset_flag , 1,  decode(   bb.CATE_NAME , '���乤��'   , aa.localoriginvalue , 0 ) , 0 ) , 
          decode ( aa.accyear || aa.period  , macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep')  ,  0 , 
                    decode ( aa.newasset_flag  , 1 ,  
                       decode(   bb.CATE_NAME , '���乤��'   , aa.localoriginvalue , 0 )  , 0  ,   
                              decode(   bb.CATE_NAME , '���乤��'   , aa.localoriginvalue , 0 )  ,0 )   ) ) , 0)        fa_value_add_cons_vehicle   ,                    
   
   
  decode(dd.style_name, '�ڽ�����ת��', 0 , 'ֱ�ӹ���' , 0 ,decode( aa.accyear || aa.period  , '201801' ,  
          decode( aa.newasset_flag , 1,  decode(   bb.CATE_NAME , '���乤��'   , aa.localoriginvalue , 0 ) , 0 ) , 
          decode ( aa.accyear || aa.period  , macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep')  ,  0 , 
                    decode ( aa.newasset_flag  , 1 ,  
                       decode(   bb.CATE_NAME , '���乤��'   , aa.localoriginvalue , 0 )  , 0  ,   
                              decode(   bb.CATE_NAME , '���乤��'   , aa.localoriginvalue , 0 )  ,0 )   ) ))  fa_value_add_other_vehicle , 
   
                                                                         
    
  decode ( bb.CATE_NAME , '���ݼ�������' ,  0 ,'�����豸'  ,  0 ,  '���乤��'  , 0 ,   
        decode( aa.accyear || aa.period  , '201801' ,  
          decode( aa.newasset_flag , 1,  aa.localoriginvalue , 0 ) , 
          decode ( aa.accyear || aa.period  , macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep')  ,  0 , 
                    decode ( aa.newasset_flag  , 1 ,  aa.localoriginvalue  , 0  ,   aa.localoriginvalue  ,0 )   ) )  
   )  fa_value_add_other, 
   
   decode(dd.style_name, 'ֱ�ӹ���' , decode ( bb.CATE_NAME , '���ݼ�������' ,  0 ,'�����豸'  ,  0 ,  '���乤��'  , 0 ,   
        decode( aa.accyear || aa.period  , '201801' ,  
          decode( aa.newasset_flag , 1,  aa.localoriginvalue , 0 ) , 
          decode ( aa.accyear || aa.period  , macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep')  ,  0 , 
                    decode ( aa.newasset_flag  , 1 ,  aa.localoriginvalue  , 0  ,   aa.localoriginvalue  ,0 )   ) )  
   ) , 0 ) fa_value_add_purchase_other  , 
   
   
   decode(dd.style_name, '�ڽ�����ת��', decode ( bb.CATE_NAME , '���ݼ�������' ,  0 ,'�����豸'  ,  0 ,  '���乤��'  , 0 ,   
        decode( aa.accyear || aa.period  , '201801' ,  
          decode( aa.newasset_flag , 1,  aa.localoriginvalue , 0 ) , 
          decode ( aa.accyear || aa.period  , macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep')  ,  0 , 
                    decode ( aa.newasset_flag  , 1 ,  aa.localoriginvalue  , 0  ,   aa.localoriginvalue  ,0 )   ) )  
   ) , 0 )   fa_value_add_cons_other , 
   
   
   decode(dd.style_name, '�ڽ�����ת��', 0 , 'ֱ�ӹ���' , 0 , decode ( bb.CATE_NAME , '���ݼ�������' ,  0 ,'�����豸'  ,  0 ,  '���乤��'  , 0 ,   
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
          decode( aa.newasset_flag , 1,  decode(   bb.CATE_NAME , '���ݼ�������'   , aa.accudep , 0 ) , 0 ) , 
          decode ( aa.accyear || aa.period  , macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep')  ,  0 , 
                    decode ( aa.newasset_flag  , 1 ,  
                       decode(   bb.CATE_NAME , '���ݼ�������'   , aa.accudep , 0 )  , 0  ,   
                              decode(   bb.CATE_NAME , '���ݼ�������'   , aa.accudep , 0 )  ,0 )   ) )  fa_accu_dep_add_building  , 
                              
                              
    decode(dd.style_name, 'ֱ�ӹ���' ,  decode( aa.accyear || aa.period  , '201801' ,  
          decode( aa.newasset_flag , 1,  decode(   bb.CATE_NAME , '���ݼ�������'   , aa.accudep , 0 ) , 0 ) , 
          decode ( aa.accyear || aa.period  , macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep')  ,  0 , 
                    decode ( aa.newasset_flag  , 1 ,  
                       decode(   bb.CATE_NAME , '���ݼ�������'   , aa.accudep , 0 )  , 0  ,   
                              decode(   bb.CATE_NAME , '���ݼ�������'   , aa.accudep , 0 )  ,0 )   ) ) , 0)     fa_accu_dep_add_pur_building , 
    
    decode(dd.style_name, '�ڽ�����ת��',  decode( aa.accyear || aa.period  , '201801' ,  
          decode( aa.newasset_flag , 1,  decode(   bb.CATE_NAME , '���ݼ�������'   , aa.accudep , 0 ) , 0 ) , 
          decode ( aa.accyear || aa.period  , macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep')  ,  0 , 
                    decode ( aa.newasset_flag  , 1 ,  
                       decode(   bb.CATE_NAME , '���ݼ�������'   , aa.accudep , 0 )  , 0  ,   
                              decode(   bb.CATE_NAME , '���ݼ�������'   , aa.accudep , 0 )  ,0 )   ) ) ,   0 )  fa_accu_dep_add_cons_building , 
    
    decode(dd.style_name, '�ڽ�����ת��', 0 , 'ֱ�ӹ���' , 0 ,  decode( aa.accyear || aa.period  , '201801' ,  
          decode( aa.newasset_flag , 1,  decode(   bb.CATE_NAME , '���ݼ�������'   , aa.accudep , 0 ) , 0 ) , 
          decode ( aa.accyear || aa.period  , macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep')  ,  0 , 
                    decode ( aa.newasset_flag  , 1 ,  
                       decode(   bb.CATE_NAME , '���ݼ�������'   , aa.accudep , 0 )  , 0  ,   
                              decode(   bb.CATE_NAME , '���ݼ�������'   , aa.accudep , 0 )  ,0 )   ) )) fa_accu_dep_add_other_building , 
                           
                                                         
                              
                              
  decode( aa.accyear || aa.period  , '201801' ,  
          decode( aa.newasset_flag , 1,  decode(   bb.CATE_NAME , '�����豸'   , aa.accudep , 0 ) , 0 ) , 
          decode ( aa.accyear || aa.period  , macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep')  ,  0 , 
                    decode ( aa.newasset_flag  , 1 ,  
                       decode(   bb.CATE_NAME , '�����豸'   , aa.accudep , 0 )  , 0  ,   
                              decode(   bb.CATE_NAME , '�����豸'   , aa.accudep , 0 )  ,0 )   ) )  fa_accu_dep_add_machine  , 
                              
   
   
   decode(dd.style_name, 'ֱ�ӹ���' , decode( aa.accyear || aa.period  , '201801' ,  
          decode( aa.newasset_flag , 1,  decode(   bb.CATE_NAME , '�����豸'   , aa.accudep , 0 ) , 0 ) , 
          decode ( aa.accyear || aa.period  , macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep')  ,  0 , 
                    decode ( aa.newasset_flag  , 1 ,  
                       decode(   bb.CATE_NAME , '�����豸'   , aa.accudep , 0 )  , 0  ,   
                              decode(   bb.CATE_NAME , '�����豸'   , aa.accudep , 0 )  ,0 )   ) )  , 0 )    fa_accu_dep_add_pur_machine ,   
   
   decode(dd.style_name, '�ڽ�����ת��', decode( aa.accyear || aa.period  , '201801' ,  
          decode( aa.newasset_flag , 1,  decode(   bb.CATE_NAME , '�����豸'   , aa.accudep , 0 ) , 0 ) , 
          decode ( aa.accyear || aa.period  , macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep')  ,  0 , 
                    decode ( aa.newasset_flag  , 1 ,  
                       decode(   bb.CATE_NAME , '�����豸'   , aa.accudep , 0 )  , 0  ,   
                              decode(   bb.CATE_NAME , '�����豸'   , aa.accudep , 0 )  ,0 )   ) )  , 0)  fa_accu_dep_add_cons_machine , 
   
   decode(dd.style_name, '�ڽ�����ת��', 0 , 'ֱ�ӹ���' , 0 ,decode( aa.accyear || aa.period  , '201801' ,  
          decode( aa.newasset_flag , 1,  decode(   bb.CATE_NAME , '�����豸'   , aa.accudep , 0 ) , 0 ) , 
          decode ( aa.accyear || aa.period  , macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep')  ,  0 , 
                    decode ( aa.newasset_flag  , 1 ,  
                       decode(   bb.CATE_NAME , '�����豸'   , aa.accudep , 0 )  , 0  ,   
                              decode(   bb.CATE_NAME , '�����豸'   , aa.accudep , 0 )  ,0 )   ) ) )  fa_accu_dep_add_other_machine , 
                          
                              
                              
                                                          
  decode( aa.accyear || aa.period  , '201801' ,  
          decode( aa.newasset_flag , 1,  decode(   bb.CATE_NAME , '���乤��'   , aa.accudep , 0 ) , 0 ) , 
          decode ( aa.accyear || aa.period  , macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep')  ,  0 , 
                    decode ( aa.newasset_flag  , 1 ,  
                       decode(   bb.CATE_NAME , '���乤��'   , aa.accudep , 0 )  , 0  ,   
                              decode(   bb.CATE_NAME , '���乤��'   , aa.accudep , 0 )  ,0 )   ) )  fa_accu_dep_add_vehicle    , 
                              
   
   
  decode(dd.style_name, 'ֱ�ӹ���' , decode( aa.accyear || aa.period  , '201801' ,  
          decode( aa.newasset_flag , 1,  decode(   bb.CATE_NAME , '���乤��'   , aa.accudep , 0 ) , 0 ) , 
          decode ( aa.accyear || aa.period  , macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep')  ,  0 , 
                    decode ( aa.newasset_flag  , 1 ,  
                       decode(   bb.CATE_NAME , '���乤��'   , aa.accudep , 0 )  , 0  ,   
                              decode(   bb.CATE_NAME , '���乤��'   , aa.accudep , 0 )  ,0 )   ) ) , 0 )    fa_accu_dep_add_pur_vehicle ,   
   
   decode(dd.style_name, '�ڽ�����ת��', decode( aa.accyear || aa.period  , '201801' ,  
          decode( aa.newasset_flag , 1,  decode(   bb.CATE_NAME , '���乤��'   , aa.accudep , 0 ) , 0 ) , 
          decode ( aa.accyear || aa.period  , macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep')  ,  0 , 
                    decode ( aa.newasset_flag  , 1 ,  
                       decode(   bb.CATE_NAME , '���乤��'   , aa.accudep , 0 )  , 0  ,   
                              decode(   bb.CATE_NAME , '���乤��'   , aa.accudep , 0 )  ,0 )   ) ) , 0)  fa_accu_dep_add_cons_vehicle , 
   
   decode(dd.style_name, '�ڽ�����ת��', 0 , 'ֱ�ӹ���' , 0 ,decode( aa.accyear || aa.period  , '201801' ,  
          decode( aa.newasset_flag , 1,  decode(   bb.CATE_NAME , '���乤��'   , aa.accudep , 0 ) , 0 ) , 
          decode ( aa.accyear || aa.period  , macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep')  ,  0 , 
                    decode ( aa.newasset_flag  , 1 ,  
                       decode(   bb.CATE_NAME , '���乤��'   , aa.accudep , 0 )  , 0  ,   
                              decode(   bb.CATE_NAME , '���乤��'   , aa.accudep , 0 )  ,0 )   ) ))  fa_accu_dep_add_other_vehicle ,                             
                              
                              
                           
  decode ( bb.CATE_NAME , '���ݼ�������' ,  0 ,'�����豸' , 0 ,  '���乤��', 0 , 
       decode( aa.accyear || aa.period  , '201801' ,  
          decode( aa.newasset_flag , 1,  aa.accudep , 0 ) , 
          decode ( aa.accyear || aa.period  , macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep')  ,  0 , 
                    decode ( aa.newasset_flag  , 1 ,  
                      aa.accudep  , 0  ,  aa.accudep  ,0 )   ) ))   fa_accu_dep_add_other , 
   
   decode(dd.style_name, 'ֱ�ӹ���' ,   decode ( bb.CATE_NAME , '���ݼ�������' ,  0 ,'�����豸' , 0 ,  '���乤��', 0 , 
       decode( aa.accyear || aa.period  , '201801' ,  
          decode( aa.newasset_flag , 1,  aa.accudep , 0 ) , 
          decode ( aa.accyear || aa.period  , macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep')  ,  0 , 
                    decode ( aa.newasset_flag  , 1 ,  
                      aa.accudep  , 0  ,  aa.accudep  ,0 )   ) )) , 0 )    fa_accu_dep_add_pur_other ,   
   
   decode(dd.style_name, '�ڽ�����ת��',   decode ( bb.CATE_NAME , '���ݼ�������' ,  0 ,'�����豸' , 0 ,  '���乤��', 0 , 
       decode( aa.accyear || aa.period  , '201801' ,  
          decode( aa.newasset_flag , 1,  aa.accudep , 0 ) , 
          decode ( aa.accyear || aa.period  , macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep')  ,  0 , 
                    decode ( aa.newasset_flag  , 1 ,  
                      aa.accudep  , 0  ,  aa.accudep  ,0 )   ) )) , 0)  fa_accu_dep_add_cons_other , 
   
   decode(dd.style_name, '�ڽ�����ת��', 0 , 'ֱ�ӹ���' , 0 ,  decode ( bb.CATE_NAME , '���ݼ�������' ,  0 ,'�����豸' , 0 ,  '���乤��', 0 , 
       decode( aa.accyear || aa.period  , '201801' ,  
          decode( aa.newasset_flag , 1,  aa.accudep , 0 ) , 
          decode ( aa.accyear || aa.period  , macro('m_fa_end_year_dep') || macro('m_fa_end_month_dep')  ,  0 , 
                    decode ( aa.newasset_flag  , 1 ,  
                      aa.accudep  , 0  ,  aa.accudep  ,0 )   ) )))  fa_accu_dep_add_other_other 
       
              
                              
from  pam_addreducestyle dd ,  fa_card cc , fa_category bb  , fa_cardhistory  aa  , ORG_FINANCEORG xx
where
  11=11
  and dd.dr = 0 
  and dd.pk_addreducestyle = cc.PK_ADDREDUCESTYLE
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