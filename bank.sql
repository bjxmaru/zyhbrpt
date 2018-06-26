select sum(bb.m10012)  bank_cash_end_bal ,    --e6
       sum(bb.m10014)  bank_bank_end_bal ,    --e7
       sum(bb.m10006)  bank_other_bank_end_bal ,    --e8
       sum(bb.m10015)  bank_cash_beg_bal ,    --f6
       sum(bb.m10003)  bank_bank_beg_bal ,    --f7
       sum(bb.m10011)  bank_other_bank_beg_bal ,    --f8
       
from  iufo_measure_data_g7zn7g5q  bb, IUFO_MEASPUB_0011  aa
where
  1=1
  and bb.dr = 0
  and bb.alone_id = aa.alone_id
  and aa.keyword1 in (select  yy.pk_org  from  ORG_RCSMEMBER yy   ,org_financeorg  xx  where  yy.dr =0  and yy.pk_fatherorg = xx.pk_financeorg and xx.dr = 0 and xx.code = parameter('org_code_param') union all select mm.pk_financeorg  pk_org   from org_financeorg mm  where mm.dr = 0 and mm.code = parameter('org_code_param')   )
  and aa.dr = 0
  and aa.ver = 0
  and aa.keyword2 = parameter('year_month_param')   