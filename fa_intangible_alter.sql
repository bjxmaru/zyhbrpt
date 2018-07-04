select 

sum(localoriginvalue_alter_add) localoriginvalue_alter_add , 
sum(localoriginvalue_alter_reduce) localoriginvalue_alter_reduce , 
sum(accudep_alter_add) accudep_alter_add , 
sum(accudep_alter_reduce) accudep_alter_reduce 

from 
(
select   jj.asset_code , jj.asset_name ,  hh.pk_card, gg.pk_org ,     
decode(to_number(substr(gg.audittime,6,2))+1 , 13, to_char(to_number(substr(gg.audittime,1,4))+1) ,   substr(gg.audittime,1,4) )  accyear_alter , 
          decode( to_number(substr(gg.audittime,6,2))+1 ,13 ,'01',12,'12',11,'11',10,'10','0'||to_char(to_number(substr(gg.audittime,6,2))+1) )  period_alter , 
  gg.transi_type ,  
          decode(gg.transi_type ,   'HG-06',0 ,
                 decode(ii.item_code , 'localoriginvalue' , 
                 decode(abs(to_number(ii.new_content)-to_number(ii.old_content) ) , to_number(ii.new_content)-to_number(ii.old_content) ,
                            to_number(ii.new_content)-to_number(ii.old_content) ,0   ) , 
                 0  )        
          )  localoriginvalue_alter_add , 

          decode(gg.transi_type ,  'HG-06',0 ,
                 decode(ii.item_code , 'localoriginvalue' , 
                       decode(abs(to_number(ii.new_content)-to_number(ii.old_content) ) , 
                                 to_number(ii.new_content)-to_number(ii.old_content) ,
                                  0 , to_number(ii.old_content)-to_number(ii.new_content)  ) , 
                       0  )        
          )  localoriginvalue_alter_reduce , 
          
           
          decode(gg.transi_type , 'HG-02',0 ,
                 decode(ii.item_code , 'accudep' , 
                 decode(abs(to_number(ii.new_content)-to_number(ii.old_content) ) , to_number(ii.new_content)-to_number(ii.old_content) ,
                            to_number(ii.new_content)-to_number(ii.old_content) ,0   ) , 
                 0  )        
          )  accudep_alter_add , 
          
    
          decode(gg.transi_type , 'HG-02',0 ,
                 decode(ii.item_code , 'accudep' , 
                 decode(abs(to_number(ii.new_content)-to_number(ii.old_content) ) , to_number(ii.new_content)-to_number(ii.old_content) ,
                            0 , to_number(ii.old_content) - to_number(ii.new_content) ) , 
                 0  )        
          )  accudep_alter_reduce 
          
          
         
from  fa_alter gg 
   inner join   fa_alter_b hh  
        on( hh.pk_alter = gg.pk_alter 
            and gg.pk_org = (select pk_org from org_orgs  tt where pk_accperiodscheme  <> '~'  and  code = parameter('org_code'))
            and hh.dr = 0  and  gg.bill_status=3 and gg.dr = 0 
           and substr(gg.audittime ,1,7) between ( parameter('begin_year_param') ||'-'|| parameter('begin_month_param') ) 
                                        and   (parameter('end_year_param') ||'-'|| parameter('end_month_param')  )  
           and gg.transi_type  in( 'HG-02' , 'HG-06' ) 
           and gg.bill_code > 'ZCBD' || parameter('begin_year_param') )
   inner join   fa_altersheet ii
        on ( ii.pk_alter_b = hh.pk_alter_b  and ii.dr = 0  )
        
   inner join   fa_card jj
       on( jj.pk_card = hh.pk_card 
           and jj.dr = 0 
           and (jj.asset_name like parameter('fa_code')  or  jj.asset_name like parameter('fa_code_1') )
       )
       
   inner join    fa_cardhistory  kk 
       on ( kk.pk_card = jj.pk_card 
           and kk.pk_category_old = '1001A11000000008I9PW'
           and kk.laststate_flag = 'N'
           and kk.accyear =  macro('m_fa_end_year_dep') 
           and kk.period =  macro('m_fa_end_month_dep')  
      ) 

      
      )
  