select org_code ,org_name , 
lxzc , lxsr , sxf , qt ,  
curr_dx_lxzc, curr_dx_lxsr  ,  
last_dx_lxzc, last_dx_lxsr
from 
(
select cc.code org_code , cc.name org_name  , 
bb.m10003 lxzc,  --B5	利息支出本期发生额	数值	(cwfy01)财务费用	iufo_measure_data_ipqsoy8v	m10003
bb.m10007 lxsr,  --B6	减：利息收入本期发生额	数值	(cwfy01)财务费用	iufo_measure_data_ipqsoy8v	m10007
bb.m10005 sxf,  --B7	手续费本期发生额	数值	(cwfy01)财务费用	iufo_measure_data_ipqsoy8v	m10005
bb.mixp7kx qt,  --B8	B8	数值	(cwfy01)财务费用	iufo_measure_data_ipqsoy8v	mixp7kx
0  curr_dx_lxzc , 
0  curr_dx_lxsr, 
0  last_dx_lxzc ,
0  last_dx_lxsr 

from  IUFO_MEASPUB_0011  aa

inner join  iufo_measure_data_ipqsoy8v  bb  
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
bb.m10007 lxzc,  --B5	利息支出本期发生额	数值	(cwfy03)财务费用_合并	iufo_measure_data_nr2yziwm	m10007
bb.m10011 lxsr,  --B6	减：利息收入本期发生额	数值	(cwfy03)财务费用_合并	iufo_measure_data_nr2yziwm	m10011
bb.m10003 sxf,  --B7	手续费本期发生额	数值	(cwfy03)财务费用_合并	iufo_measure_data_nr2yziwm	m10003
bb.m10009 qt,  --B8	其他本期发生额	数值	(cwfy03)财务费用_合并	iufo_measure_data_nr2yziwm	m10009
bb.mdrghh7  curr_dx_lxzc ,  --B10	利息支出抵销本期发生额	数值	(cwfy03)财务费用_合并	iufo_measure_data_nr2yziwm	mdrghh7
bb.mx2kcs1  curr_dx_lxsr ,  --B11	利息收入抵销本期发生额	数值	(cwfy03)财务费用_合并	iufo_measure_data_nr2yziwm	mx2kcs1
bb.mpbhg1o  last_dx_lxzc ,  --C10	利息支出抵销上年同期发生额	数值	(cwfy03)财务费用_合并	iufo_measure_data_nr2yziwm	mpbhg1o
bb.mrqihmf  last_dx_lxsy    --C11	利息收入抵销上年同期发生额	数值	(cwfy03)财务费用_合并	iufo_measure_data_nr2yziwm	mrqihmf 

from  IUFO_MEASPUB_0011  aa

inner join  iufo_measure_data_nr2yziwm  bb  
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
     
 )  order by org_code 
     
     
