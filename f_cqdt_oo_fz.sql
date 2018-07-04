select the_rownum ,    proj_code ,  org_code, org_name,  proj_name ,
end_bal , end_dx_amount , end_dx_bal , end_capital_amount, end_reduce_bal , 
add_amount, add_capital_amount , 
reduce_amount, reduce_fa_amount,  beg_bal, beg_reduce_bal  ,beg_capital_amount 
from 
(
select cc.code||'_'||aa.keyword3  the_rownum ,    aa.keyword3  proj_code,  cc.code org_code , cc.name org_name,  
bb.m10004 beg_bal , --E5	期初余额	数值	(cqdtfy01)长期待摊费用	iufo_measure_data_bk5fjrul	m10004
bb.m10003 bal_add , -- F5	本期增加金额	数值	(cqdtfy01)长期待摊费用	iufo_measure_data_bk5fjrul	m10003
bb.m10002 bal_tx ,  --G5	本期摊销金额	数值	(cqdtfy01)长期待摊费用	iufo_measure_data_bk5fjrul	m10002 
bb.m10001 bal_reduce , --H5	其他减少金额	数值	(cqdtfy01)长期待摊费用	iufo_measure_data_bk5fjrul	m10001 
bb.m10000 end_bal , --I5	期末数	数值	(cqdtfy01)长期待摊费用	iufo_measure_data_bk5fjrul	m10000
0         dx_children  
from IUFO_MEASPUB_80JA aa inner join iufo_measure_data_bk5fjrul   bb   
     on(   bb.alone_id  = aa.alone_id  
           and nvl(bb.dr , 0 ) = 0 
           and nvl(aa.dr , 0) = 0 
           and  aa.keyword1 in ( macro('pk_org_list_macro_single'))
           and aa.keyword2 = parameter('year_month_param')
     )  
inner join org_financeorg  cc  
     on(  cc.pk_financeorg  = aa.keyword1 and cc.dr = 0  )
     
union all 

select  cc.code||'_'||aa.keyword3  the_rownum  ,   aa.keyword3 proj_code ,  cc.code org_code , cc.name org_name,  
bb.m10004 proj_name     ,  --b6
bb.m10010 end_bal ,   --C6	账面余额	数值	(zjgc03)在建工程_合并	iufo_measure_data_sk9wkaek	m10010
bb.mwesjjb end_dx_amount ,    --D6	合并抵销数	数值	(zjgc03)在建工程_合并	iufo_measure_data_sk9wkaek	mwesjjb
bb.m4t2go0 end_dx_bal ,  --E6	抵销后金额	数值	(zjgc03)在建工程_合并	iufo_measure_data_sk9wkaek	m4t2go0
bb.m10003  end_capitcal_amount ,   --D6	期末利息资本化金额	数值	(zjgc03)在建工程_合并	iufo_measure_data_sk9wkaek	m10003
bb.m10002 end_reduce_bal ,  --E6	减值准备	数值	(zjgc03)在建工程_合并	iufo_measure_data_sk9wkaek	m10002
bb.m10000 add_amount ,  --G6	增加	数值	(zjgc03)在建工程_合并	iufo_measure_data_sk9wkaek	m10000
bb.m10009  add_capital_amount,    --H6	本期增加利息资本化金额	数值	(zjgc03)在建工程_合并	iufo_measure_data_sk9wkaek	m10009
bb.m10012 reduce_amount ,   --I6	减少	数值	(zjgc03)在建工程_合并	iufo_measure_data_sk9wkaek	m10012
bb.m10001  reduce_fa_amount,  --J6	本期减少转增固定资产	数值	(zjgc03)在建工程_合并	iufo_measure_data_sk9wkaek	m10001
bb.m10008   beg_bal ,  --K6	账面余额G6	数值	(zjgc03)在建工程_合并	iufo_measure_data_sk9wkaek	m10008
bb.m10007  beg_reduce_bal  , --L6	减值准备H6	数值	(zjgc03)在建工程_合并	iufo_measure_data_sk9wkaek	m10007
bb.muzv83j  beg_capital_amount  --L6	其中:利息资本化金额	数值	(zjgc03)在建工程_合并	iufo_measure_data_sk9wkaek	muzv83j
from IUFO_MEASPUB_QPF4 aa inner join iufo_measure_data_sk9wkaek   bb   
     on(   bb.alone_id  = aa.alone_id  
           and nvl(bb.dr , 0 ) = 0 
           and nvl(aa.dr , 0) = 0 
           and  aa.keyword1 in ( macro('pk_org_list_macro_consolidate'))
           and aa.keyword2 = parameter('year_month_param')
     )  
inner join org_financeorg  cc  
     on(  cc.pk_financeorg  = aa.keyword1 and cc.dr = 0  )
 ) order by   the_rownum
