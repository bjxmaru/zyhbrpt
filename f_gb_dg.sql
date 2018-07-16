select org_code ,org_name  , 
BEG_BAL  , END_BAL, BAL_HB  
from 
(
select cc.code org_code , cc.name org_name  , 
bb.m10011 beg_bal,  --B6	股份总数期初余额	数值	(gb01)股本	iufo_measure_data_1c4t9kvv	m10011
bb.m10006 end_bal , --G6	股份总数期末余额	数值	(gb01)股本	iufo_measure_data_1c4t9kvv	m10006
0   bal_hb  

from  IUFO_MEASPUB_0011  aa

inner join  iufo_measure_data_1c4t9kvv  bb  
      on(
       
           bb.alone_id  = aa.alone_id  
           and nvl(bb.dr , 0 ) = 0 
           and nvl(aa.dr , 0) = 0 
           and aa.keyword1 in ( 
           select children_pk_org  pk_org_list from (select  zz.code  children_org_code ,zz.name  children_org_name  ,yy.pk_org children_pk_org    , (select decode( count(pk_org)  , 0 , 'n' , 'y') b_father    from ORG_RCSMEMBER  mm where mm.pk_fatherorg  =  yy.pk_org ) b_father  , 'n' b_self from  org_orgs zz ,  ORG_RCSMEMBER yy   ,org_financeorg  xx  where 1=1 and zz.dr = 0 and zz.pk_org = yy.pk_org   and yy.dr =0  and yy.pk_fatherorg = xx.pk_financeorg  and xx.dr = 0 and xx.code = parameter('org_code_param') union all select mm.code  children_org_code  , mm.name children_org_name ,   mm.pk_financeorg  children_pk_org    , (select decode( count(pk_org)  , 0 , 'n' , 'y') b_father   from ORG_RCSMEMBER kk  where  kk.pk_fatherorg  = mm.pk_financeorg  ) b_father  , 'y' b_self from org_financeorg mm  where mm.dr = 0 and mm.code = parameter('org_code_param')) where b_father = 'n' or  b_self ='y'
           )
           and aa.keyword2 = parameter('year_month_param')
      
      )    
inner join org_financeorg  cc  
     on(  cc.pk_financeorg  = aa.keyword1 and cc.dr = 0  )
     
     
union all 

select cc.code org_code , cc.name org_name  , 
bb.m10011 beg_bal,  --B6	股份总数期初余额	数值	(gb03)股本_合并	iufo_measure_data_uhuk6v6b	m10011
bb.m10006 end_bal , --G6	股份总数期末余额	数值	(gb03)股本_合并	iufo_measure_data_uhuk6v6b	m10006
bb.mxtyugw   bal_hb   --H6	股份总数其中：合并抵销数	数值	(gb03)股本_合并	iufo_measure_data_uhuk6v6b	mxtyugw

from  IUFO_MEASPUB_0011  aa

inner join  iufo_measure_data_uhuk6v6b  bb  
      on(
       
           bb.alone_id  = aa.alone_id  
           and nvl(bb.dr , 0 ) = 0 
           and nvl(aa.dr , 0) = 0 
           and aa.keyword1 in ( 
            select children_pk_org  pk_org_list from (select  zz.code  children_org_code ,zz.name  children_org_name  ,yy.pk_org children_pk_org    , (select decode( count(pk_org)  , 0 , 'n' , 'y') b_father    from ORG_RCSMEMBER  mm where mm.pk_fatherorg  =  yy.pk_org ) b_father  , 'n' b_self from  org_orgs zz ,  ORG_RCSMEMBER yy   ,org_financeorg  xx  where 1=1 and zz.dr = 0 and zz.pk_org = yy.pk_org   and yy.dr =0  and yy.pk_fatherorg = xx.pk_financeorg and xx.dr = 0 and xx.code = parameter('org_code_param') union all select mm.code  children_org_code  , mm.name children_org_name ,   mm.pk_financeorg  children_pk_org    , (select decode( count(pk_org)  , 0 , 'n' , 'y') b_father   from ORG_RCSMEMBER kk  where  kk.pk_fatherorg  = mm.pk_financeorg  ) b_father  , 'y' b_self from org_financeorg mm  where mm.dr = 0 and mm.code = parameter('org_code_param')) where b_father = 'y'  and b_self ='n'
           )
           and aa.keyword2 = parameter('year_month_param')
      
      )    
inner join org_financeorg  cc  
     on(  cc.pk_financeorg  = aa.keyword1 and cc.dr = 0  )
     
 )  order by org_name 
     
     
