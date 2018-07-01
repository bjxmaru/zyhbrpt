select aa.keyword3 org_proj_code ,
bb.m10000 org_name,  --B6	单位名称	字符	(zjgc02)在建工程_底稿	iufo_measure_data_dztuh383	m10000
bb.m10016 proj_name, --C6	工程名称	字符	(zjgc02)在建工程_底稿	iufo_measure_data_dztuh383	m10016
bb.m10009 beg_bal , --F6	余额	数值	(zjgc02)在建工程_底稿	iufo_measure_data_dztuh383	m10009
bb.m10006 beg_capital_amount,  --G6	利息资本化金额	数值	(zjgc02)在建工程_底稿	iufo_measure_data_dztuh383	m10006
bb.m10015 beg_reduce_amount ,  --H6	减值准备	数值	(zjgc02)在建工程_底稿	iufo_measure_data_dztuh383	m10015
bb.m10004 add_amount , --I6	金额	数值	(zjgc02)在建工程_底稿	iufo_measure_data_dztuh383	m10004
bb.m10002 add_capital_amount,  --J6	其中：利息资本化金额	数值	(zjgc02)在建工程_底稿	iufo_measure_data_dztuh383	m10002
bb.m10012 reduce_amount ,  --K6	金额K6	数值	(zjgc02)在建工程_底稿	iufo_measure_data_dztuh383	m10012 
bb.m10014 reduce_fa_amount,  --L6	其中：转增固定资产	数值	(zjgc02)在建工程_底稿	iufo_measure_data_dztuh383	m10014
bb.m10003 end_bal ,  --M6	余额M6	数值	(zjgc02)在建工程_底稿	iufo_measure_data_dztuh383	m10003
bb.m450tkc end_dx_amount , --N6	合并抵销数	数值	(zjgc02)在建工程_底稿	iufo_measure_data_dztuh383	m450tkc
bb.mthaz1g end_dx_bal ,   --O6	抵销后后余额	数值	(zjgc02)在建工程_底稿	iufo_measure_data_dztuh383	mthaz1g
bb.m10001  end_capital_amount,  --P6	利息资本化金额N6	数值	(zjgc02)在建工程_底稿	iufo_measure_data_dztuh383	m10001
bb.m10005  end_reduce_amount , --Q6	减值准备O6	数值	(zjgc02)在建工程_底稿	iufo_measure_data_dztuh383	m10005
bb.m10017  fund_resource ,  --R6	资金来源	字符	(zjgc02)在建工程_底稿	iufo_measure_data_dztuh383	m10017
bb.m10013 last_dx_amount ,  --S6	抵消数	数值	(zjgc02)在建工程_底稿	iufo_measure_data_dztuh383	m10013
bb.m10011 last_dx_bal   --T6	合并数	数值	(zjgc02)在建工程_底稿	iufo_measure_data_dztuh383	m10011
from IUFO_MEASPUB_QPFH aa inner join iufo_measure_data_h97lpn0c   bb   
     on(   bb.alone_id  = aa.alone_id  
           and nvl(bb.dr , 0 ) = 0 
           and nvl(aa.dr , 0) = 0 
           and aa.keyword1 = (select pk_financeorg from org_financeorg where dr = 0 and code = parameter('org_code_param'))
           and aa.keyword2 = parameter('year_month_param')
     )  