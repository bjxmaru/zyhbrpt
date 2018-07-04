select 
sum(end_bal_cash) end_bal_cash , 
sum(end_bal_bank) end_bal_bank ,
sum(end_bal_bank_other) end_bal_bank_other , 
sum(end_bal_cash_equivalent) end_bal_cash_equivalent , 
sum(end_bal_debenture) end_bal_debenture , 
sum(beg_bal_cash) beg_bal_cash ,
sum(beg_bal_bank) beg_bal_bank , 
sum(beg_bal_bank_other) beg_bal_bank_other , 
sum(beg_bal_cash_equivalent) beg_bal_cash_equivalent , 
sum(beg_bal_debenture) beg_bal_debenture
from 
(
select cc.code org_code , cc.name org_name  , 
bb.m10012 end_bal_cash ,  --E6	库存现金_期末_附注	数值	(hbzj01)货币资金	iufo_measure_data_g7zn7g5q	m10012
bb.m10014 end_bal_bank ,        --E7	银行存款_期末_附注	数值	(hbzj01)货币资金	iufo_measure_data_g7zn7g5q	m10014  
bb.m10006 end_bal_bank_other,      --E8	其他货币资金_期末_附注	数值	(hbzj01)货币资金	iufo_measure_data_g7zn7g5q	m10006   
bb.m10005 end_bal_cash_equivalent, --E9	现金等价物_期末_附注	数值	(hbzj01)货币资金	iufo_measure_data_g7zn7g5q	m10005
bb.m10002 end_bal_debenture,  --E10	三个月内到期的债券投资_期末_附注	数值	(hbzj01)货币资金	iufo_measure_data_g7zn7g5q	m10002

bb.m10015 beg_bal_cash ,      --F6	库存现金_期初_附注	数值	(hbzj01)货币资金	iufo_measure_data_g7zn7g5q	m10015
bb.m10003 beg_bal_bank,   --F7	银行存款_期初_附注	数值	(hbzj01)货币资金	iufo_measure_data_g7zn7g5q	m10003
bb.m10011 beg_bal_bank_other,  --F8	其他货币资金_期初_附注	数值	(hbzj01)货币资金	iufo_measure_data_g7zn7g5q	m10011
bb.m10001 beg_bal_cash_equivalent ,  --F9	现金等价物_期初_附注	数值	(hbzj01)货币资金	iufo_measure_data_g7zn7g5q	m10001
bb.m10008 beg_bal_debenture   --F10	三个月内到期的债券投资_期初_附注	数值	(hbzj01)货币资金	iufo_measure_data_g7zn7g5q	m10008

from  IUFO_MEASPUB_0011  aa

inner join  iufo_measure_data_g7zn7g5q  bb  
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


select cc.code org_code , cc.name org_name, 
bb.m10007 end_bal_cash ,  --E6	库存现金_合并期末_附注	数值	(hbzj03)货币资金_合并	iufo_measure_data_n0fdxt8b	m10007                  
bb.m10008 end_bal_bank ,    --E7	银行存款_合并_期末_附注	数值	(hbzj03)货币资金_合并	iufo_measure_data_n0fdxt8b	m10008  
bb.m10000 end_bal_bank_other,    --E8	其他货币资金_合并_期末_附注	数值	(hbzj03)货币资金_合并	iufo_measure_data_n0fdxt8b	m10000
bb.m10014  end_bal_cash_equivalent,   --E9	现金等价物_合并_期末_附注	数值	(hbzj03)货币资金_合并	iufo_measure_data_n0fdxt8b	m10014
bb.m10013  end_bal_debenture  ,   --E10	三个月内到期的债券投资_合并_期末_附注	数值	(hbzj03)货币资金_合并	iufo_measure_data_n0fdxt8b	m10013

bb.m10009 beg_bal_cash, --F6	库存现金_合并_期初_附注	数值	(hbzj03)货币资金_合并	iufo_measure_data_n0fdxt8b	m10009
bb.m10002 beg_bal_bank,  --F7	银行存款_合并期初_附注	数值	(hbzj03)货币资金_合并	iufo_measure_data_n0fdxt8b	m10002
bb.m10006 beg_bal_bank_other,  --F8	其他货币资金_合并_期初_附注	数值	(hbzj03)货币资金_合并	iufo_measure_data_n0fdxt8b	m10006
bb.m10012 beg_bal_cash_equivalent ,  --F9	现金等价物_合并_期初_附注	数值	(hbzj03)货币资金_合并	iufo_measure_data_n0fdxt8b	m10012
bb.m10001 beg_bal_debenture   --F10	三个月内到期的债券投资_合并_期初_附注	数值	(hbzj03)货币资金_合并	iufo_measure_data_n0fdxt8b	m10001
from  IUFO_MEASPUB_0011  aa

inner join  iufo_measure_data_n0fdxt8b  bb  
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


)