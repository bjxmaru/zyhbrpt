select the_rownum ,    proj_code ,  org_code, org_name,
beg_bal ,bal_add, bal_tx , bal_reduce , end_bal ,  dx_children , dx_self , dx_self_children  
from 
(
select cc.code||'_'||aa.keyword3  the_rownum ,    
bb.myw9pib  proj_code,  --E5	项目名称	字符	(cqdtfy01)长期待摊费用	iufo_measure_data_bk5fjrul	myw9pib
cc.code org_code , cc.name org_name,  
bb.m10004 beg_bal , --E5	期初余额	数值	(cqdtfy01)长期待摊费用	iufo_measure_data_bk5fjrul	m10004
bb.m10003 bal_add , -- F5	本期增加金额	数值	(cqdtfy01)长期待摊费用	iufo_measure_data_bk5fjrul	m10003
bb.m10002 bal_tx ,  --G5	本期摊销金额	数值	(cqdtfy01)长期待摊费用	iufo_measure_data_bk5fjrul	m10002 
bb.m10001 bal_reduce , --H5	其他减少金额	数值	(cqdtfy01)长期待摊费用	iufo_measure_data_bk5fjrul	m10001 
bb.m10000 end_bal , --I5	期末数	数值	(cqdtfy01)长期待摊费用	iufo_measure_data_bk5fjrul	m10000
0    dx_children  , 
0    dx_self, 
0    dx_seft_children
from IUFO_MEASPUB_80JA aa inner join iufo_measure_data_bk5fjrul   bb   
     on(   bb.alone_id  = aa.alone_id  
           and nvl(bb.dr , 0 ) = 0 
           and nvl(aa.dr , 0) = 0 
           and  aa.keyword1 in ( select children_pk_org  pk_org_list from (select  zz.code  children_org_code ,zz.name  children_org_name  ,yy.pk_org children_pk_org    , (select decode( count(pk_org)  , 0 , 'n' , 'y') b_father    from ORG_RCSMEMBER  mm where mm.pk_fatherorg  =  yy.pk_org ) b_father  , 'n' b_self from  org_orgs zz ,  ORG_RCSMEMBER yy   ,org_financeorg  xx  where 1=1 and zz.dr = 0 and zz.pk_org = yy.pk_org   and yy.dr =0  and yy.pk_fatherorg = xx.pk_financeorg  and xx.dr = 0 and xx.code = parameter('org_code_param') union all select mm.code  children_org_code  , mm.name children_org_name ,   mm.pk_financeorg  children_pk_org    , (select decode( count(pk_org)  , 0 , 'n' , 'y') b_father   from ORG_RCSMEMBER kk  where  kk.pk_fatherorg  = mm.pk_financeorg  ) b_father  , 'y' b_self from org_financeorg mm  where mm.dr = 0 and mm.code = parameter('org_code_param')) where  b_father = 'n'   or  b_self ='y')
           and aa.keyword2 = parameter('year_month_param')
     )  
inner join org_financeorg  cc  
     on(  cc.pk_financeorg  = aa.keyword1 and cc.dr = 0  )
     
union all 

select aa.keyword3  the_rownum  ,   
bb.m10002 proj_code ,  --B5	费用项目名称	字符	(cqdtfy03)长期待摊费用_合并 iufo_measure_data_itdi0m0p	m10002,
cc.code org_code , cc.name org_name, 
bb.m10001 beg_bal , --C5	期初余额	数值	(cqdtfy03)长期待摊费用_合并	iufo_measure_data_itdi0m0p  m10001
bb.m10000 bal_add , -- D5	本期增加金额	数值	(cqdtfy03)长期待摊费用_合并	iufo_measure_data_itdi0m0p	m10000
bb.m10006 bal_tx ,  --E5	本期摊销金额	数值	(cqdtfy03)长期待摊费用_合并	iufo_measure_data_itdi0m0p	m10006
bb.m10005 bal_reduce , --F5	其他减少金额	数值	(cqdtfy03)长期待摊费用_合并	iufo_measure_data_itdi0m0p	m10005 
bb.m10004 end_bal , --G5	期末数	数值	(cqdtfy03)长期待摊费用_合并	iufo_measure_data_itdi0m0p	m10004
bb.m10003 dx_children , --H5	备注:期末余额中的抵销数	数值	(cqdtfy03)长期待摊费用_合并	iufo_measure_data_itdi0m0p	m10003
bb.mbfr3os dx_self  ,  --H5	其中:下级单位抵销数	数值	(cqdtfy03)长期待摊费用_合并	iufo_measure_data_itdi0m0p	mbfr3os
bb.m10003  +  bb.mbfr3os  dx_seft_children 
from  IUFO_MEASPUB_80KR aa inner join iufo_measure_data_itdi0m0p   bb   
     on(   bb.alone_id  = aa.alone_id  
           and nvl(bb.dr , 0 ) = 0 
           and nvl(aa.dr , 0) = 0 
           and  aa.keyword1 in (   select children_pk_org  pk_org_list from (select  zz.code  children_org_code ,zz.name  children_org_name  ,yy.pk_org children_pk_org    , (select decode( count(pk_org)  , 0 , 'n' , 'y') b_father    from ORG_RCSMEMBER  mm where mm.pk_fatherorg  =  yy.pk_org ) b_father  , 'n' b_self from  org_orgs zz ,  ORG_RCSMEMBER yy   ,org_financeorg  xx  where 1=1 and zz.dr = 0 and zz.pk_org = yy.pk_org   and yy.dr =0  and yy.pk_fatherorg = xx.pk_financeorg and xx.dr = 0 and xx.code = parameter('org_code_param') union all select mm.code  children_org_code  , mm.name children_org_name ,   mm.pk_financeorg  children_pk_org    , (select decode( count(pk_org)  , 0 , 'n' , 'y') b_father   from ORG_RCSMEMBER kk  where  kk.pk_fatherorg  = mm.pk_financeorg  ) b_father  , 'y' b_self from org_financeorg mm  where mm.dr = 0 and mm.code = parameter('org_code_param')) where b_father = 'y'  and b_self ='n') 
           and aa.keyword2 = parameter('year_month_param')
     )  
inner join org_financeorg  cc  
     on(  cc.pk_financeorg  = aa.keyword1 and cc.dr = 0  )
 ) order by   the_rownum

