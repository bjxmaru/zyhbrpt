select pk_org ,  hb_proj_code , hb_proj_name , 
sum(DEBITAMOUNT) DEBITAMOUNT  , 
sum(CREDITAMOUNT) CREDITAMOUNT 
from 
(
SELECT  cc.code hb_proj_code , cc.name hb_proj_name , 
bb.CREDITAMOUNT , bb.DEBITAMOUNT  ,bb.PK_MEASURE  , aa.pk_org 
FROM   iufo_vouch_head  aa
inner join iufo_vouch_body  bb 
on (bb.pk_vouchhead = aa.pk_vouchhead  
    and  nvl( bb.dr , 0) = 0 
    and  nvl( aa.dr , 0) = 0 
    and  aa.ERRORSTATE = 'N'
    and  aa.CANCELSTATE ='N'
    and  aa.PK_ADJSCHEME = '1001A1100000000DKYPC'
    and  aa.PK_HBSCHEME = '1001A1100000000DKYPR' 
    and  substr(aa.input_date , 1, 7) = parameter('year_month_param')
    and  aa.pk_org = (select distinct  pk_financeorg from org_financeorg  where  dr = 0 and code = parameter('org_code_param') )
)
inner join  ufoc_project cc  
on (cc.pk_project = bb.PK_MEASURE 
    and nvl(cc.dr , 0) = 0 
)
) group by pk_org ,  hb_proj_code , hb_proj_name