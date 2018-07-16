select 
sum(end_bal_bz) end_bal_bz , 
sum(end_bal_xy) end_bal_xy , 
sum(beg_bal_bz) beg_bal_bz , 
sum(end_bal_xy) end_bal_xy , 
sum(end_bal_oneyear) end_bal_oneyear  , 
sum(beg_bal_oneyear) beg_bal_oneyear ,
sum(end_bal_hb) end_bal_hb, 
sum(beg_bal_hb) beg_bal_hb , 
sum(end_bal) end_bal , 
sum(beg_bal) beg_bal 
from 
(
select cc.code org_code , cc.name org_name  , 
bb.m10003 end_bal_bz ,   --B5	保证借款期末金额	数值	(cqjk01)长期借款	iufo_measure_data_x8alt8ge	m10003
bb.m10007 end_bal_xy ,   --B6	信用借款期末金额	数值	(cqjk01)长期借款	iufo_measure_data_x8alt8ge	m10007
bb.m10001 beg_bal_bz ,   --C5	保证借款期初金额	数值	(cqjk01)长期借款	iufo_measure_data_x8alt8ge	m10001
bb.m10006 beg_bal_xy ,   --C6	信用借款期初金额	数值	(cqjk01)长期借款	iufo_measure_data_x8alt8ge	m10006
bb.m10005 end_bal_oneyear , --B7	减：一年内到期的长期借款期末金额	数值	(cqjk01)长期借款	iufo_measure_data_x8alt8ge	m10005
bb.m10004 beg_bal_oneyear , --C7	减：一年内到期的长期借款期初金额	数值	(cqjk01)长期借款	iufo_measure_data_x8alt8ge	m10004
0 end_bal_hb , 
0 beg_bal_hb , 
bb.mvxhywz end_bal ,  --B5	长期借款期末金额	数值	(cqjk01)长期借款	iufo_measure_data_x8alt8ge	mvxhywz 
bb.mleh6hc beg_bal --C5	长期借款期初金额	数值	(cqjk01)长期借款	iufo_measure_data_x8alt8ge	mleh6hc
from  IUFO_MEASPUB_0011  aa

inner join  iufo_measure_data_x8alt8ge  bb  
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
bb.m10003 end_bal_bz ,   --B5	保证借款期末金额	数值	(cqjk03)长期借款_合并	iufo_measure_data_idpgby5m	m10003
bb.m10007 end_bal_xy ,   --B6	信用借款期末金额	数值	(cqjk03)长期借款_合并	iufo_measure_data_idpgby5m	m10007
bb.m10001 beg_bal_bz ,   --C5	保证借款期初金额	数值	(cqjk03)长期借款_合并	iufo_measure_data_idpgby5m	m10001
bb.m10006 beg_bal_xy ,   --C6	信用借款期初金额	数值	(cqjk03)长期借款_合并	iufo_measure_data_idpgby5m	m10006
bb.m10005 end_bal_oneyear , --B7	减：一年内到期的长期借款期末金额	数值	(cqjk03)长期借款_合并	iufo_measure_data_idpgby5m	m10005
bb.m10004 beg_bal_oneyear , --C7	减：一年内到期的长期借款期初金额	数值	(cqjk03)长期借款_合并	iufo_measure_data_idpgby5m	m10004
bb.m1hv25x end_bal_hb , --B8	期末合并抵销数期末金额	数值	(cqjk03)长期借款_合并	iufo_measure_data_idpgby5m	m1hv25x
bb.mwrwrss beg_bal_hb ,--C8	期末合并抵销数期初金额	数值	(cqjk03)长期借款_合并	iufo_measure_data_idpgby5m	mwrwrss
bb.mbjlc0b end_bal , --B5	长期借款期末金额	数值	(cqjk03)长期借款_合并	iufo_measure_data_idpgby5m	mbjlc0b 
bb.m60aj60 beg_bal --C5	长期借款期初金额	数值	(cqjk03)长期借款_合并	iufo_measure_data_idpgby5m	m60aj60
from  IUFO_MEASPUB_0011  aa

inner join  iufo_measure_data_idpgby5m  bb  
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

