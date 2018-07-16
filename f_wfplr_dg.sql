select org_code ,org_name  , 
BEG_BAL_TZQ, BEG_BAL_TZ , BEG_BAL_TZH  , ADD_JLR ,  REDUCE_YYGJ , REDUCE_YFGL  , END_BAL , 
BEG_BAL_HB , BAL_HB
from 
(
select cc.code org_code , cc.name org_name  , 
bb.m10007 beg_bal_tzq,  --B5	调整前上期末未分配利润本年	数值	(wfplr01)未分配利润	iufo_measure_data_ez5hjs4v	m10007
bb.m10013 beg_bal_tz , --B6	调整期初未分配利润合计数（调增+，调减-）本年	数值	(wfplr01)未分配利润	iufo_measure_data_ez5hjs4v	m10013
bb.m10003 beg_bal_tzh , --B7	调整后期初未分配利润本年	数值	(wfplr01)未分配利润	iufo_measure_data_ez5hjs4v	m10003
0  beg_bal_hb , 
bb.m10009 add_jlr , --B8	加：本期归属于母公司股东的净利润本年	数值	(wfplr01)未分配利润	iufo_measure_data_ez5hjs4v	m10009
bb.m10001 reduce_yygj , --B9	减：提取法定盈余公积本年	数值	(wfplr01)未分配利润	iufo_measure_data_ez5hjs4v	m10001
bb.m10005 reduce_yfgl , --B10	应付普通股股利本年	数值	(wfplr01)未分配利润	iufo_measure_data_ez5hjs4v	m10005
bb.m10012 end_bal , --B11	期末未分配利润本年	数值	(wfplr01)未分配利润	iufo_measure_data_ez5hjs4v	m10012
0  bal_hb 


from  IUFO_MEASPUB_0011  aa

inner join  iufo_measure_data_ez5hjs4v  bb  
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
bb.m10019 beg_bal_tzq,  --B5	调整前上期末未分配利润本年	数值	(wfplr03)未分配利润_合并	iufo_measure_data_20d4r11e	m10019
bb.m10003 beg_bal_tz , --B6	调整期初未分配利润合计数（调增+，调减-）本年	数值	(wfplr03)未分配利润_合并	iufo_measure_data_20d4r11e	m10003
bb.m10007 beg_bal_tzh , --B7	调整后期初未分配利润本年	数值	(wfplr03)未分配利润_合并	iufo_measure_data_20d4r11e	m10007
bb.m10011 beg_bal_hb ,  --B8	期初未分配利润抵销数本年	数值	(wfplr03)未分配利润_合并	iufo_measure_data_20d4r11e	m10011 , 

bb.m10021 add_jlr , --B10	加：本期归属于母公司股东的净利润本年	数值	(wfplr03)未分配利润_合并	iufo_measure_data_20d4r11e	m10021
bb.m10005 reduce_yygj , --B11	减：提取法定盈余公积本年	数值	(wfplr03)未分配利润_合并	iufo_measure_data_20d4r11e	m10005
bb.m10009 reduce_yfgl , --B12	应付普通股股利本年	数值	(wfplr03)未分配利润_合并	iufo_measure_data_20d4r11e	m10009
bb.m10013 end_bal , --B13	期末未分配利润本年	数值	(wfplr03)未分配利润_合并	iufo_measure_data_20d4r11e	m10013
bb.m10017 bal_hb   --B14	期末未分配利润抵销数本年	数值	(wfplr03)未分配利润_合并	iufo_measure_data_20d4r11e	m10017

from  IUFO_MEASPUB_0011  aa

inner join  iufo_measure_data_20d4r11e  bb  
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
     
     
