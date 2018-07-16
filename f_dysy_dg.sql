select org_code ,org_name  , 
BEG_BAL , ADD_BAL ,REDUCE_BAL , END_BAL, BAL_HB  
from 
(
select cc.code org_code , cc.name org_name  , 
bb.m10004 beg_bal,  --B5	政府补助期初余额	数值	(dysy01)递延收益	iufo_measure_data_2a19tqa0	m10004
bb.m10003 add_bal , --C5	政府补助本期增加	数值	(dysy01)递延收益	iufo_measure_data_2a19tqa0	m10003
bb.m10002 reduce_bal ,  --D5	政府补助本期减少	数值	(dysy01)递延收益	iufo_measure_data_2a19tqa0	m10002
bb.m10001 end_bal , --E5	政府补助期末余额	数值	(dysy01)递延收益	iufo_measure_data_2a19tqa0	m10001
0   bal_hb  

from  IUFO_MEASPUB_0011  aa

inner join  iufo_measure_data_2a19tqa0  bb  
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
bb.m10005 beg_bal,  --B5	政府补助期初余额	数值	(dysy03)递延收益_合并	iufo_measure_data_fxgoo9ec	m10005
bb.m10004 add_bal , --C5	政府补助本期增加	数值	(dysy03)递延收益_合并	iufo_measure_data_fxgoo9ec	m10004
bb.m10003 reduce_bal ,  --D5	政府补助本期减少	数值	(dysy03)递延收益_合并	iufo_measure_data_fxgoo9ec	m10003
bb.m10002 end_bal , --E5	政府补助期末余额	数值	(dysy03)递延收益_合并	iufo_measure_data_fxgoo9ec	m10002
bb.m10001   bal_hb    --F5	政府补助其中:合并抵销数	数值	(dysy03)递延收益_合并	iufo_measure_data_fxgoo9ec	m10001

from  IUFO_MEASPUB_0011  aa

inner join  iufo_measure_data_fxgoo9ec  bb  
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
     
     
