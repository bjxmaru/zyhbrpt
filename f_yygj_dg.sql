select org_code ,org_name  , 
BEG_BAL_FD, BEG_BAL_OTHER , ADD_FD , ADD_OTHER, REDUCE_FD , REDUCE_OTHER,  END_BAL_FD , END_BAL_OTHER , 
BEG_BAL_HB , BAL_HB
from 
(
select cc.code org_code , cc.name org_name  , 
bb.m10007 beg_bal_fd,  --B5	法定盈余公积期初余额	数值	(yygj01)盈余公积	iufo_measure_data_qvh0n4xw	m10007
bb.m10011 beg_bal_other , --B6	其他期初余额	数值	(yygj01)盈余公积	iufo_measure_data_qvh0n4xw	m10011
0  beg_bal_hb , 
bb.m10006 add_fd , --C5	法定盈余公积本期增加	数值	(yygj01)盈余公积	iufo_measure_data_qvh0n4xw	m10006
bb.m10010 add_other , --C6	其他本期增加	数值	(yygj01)盈余公积	iufo_measure_data_qvh0n4xw	m10010
bb.m10005 reduce_fd , --D5	法定盈余公积本期减少	数值	(yygj01)盈余公积	iufo_measure_data_qvh0n4xw	m10005
bb.m10009 reduce_other , --D6	其他本期减少	数值	(yygj01)盈余公积	iufo_measure_data_qvh0n4xw	m10009
bb.m10004 end_bal_fd , --E5	法定盈余公积期末余额	数值	(yygj01)盈余公积	iufo_measure_data_qvh0n4xw	m10004
bb.m10008 end_bal_other , --E6	其他期末余额	数值	(yygj01)盈余公积	iufo_measure_data_qvh0n4xw	m10008
0  bal_hb 


from  IUFO_MEASPUB_0011  aa

inner join  iufo_measure_data_qvh0n4xw  bb  
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
bb.m10007 beg_bal_fd,  --B5	法定盈余公积期初余额	数值	(yygj03)盈余公积_合并	iufo_measure_data_c2o64bmi	m10007
bb.m10015 beg_bal_other , --B6	其他期初余额	数值	(yygj03)盈余公积_合并	iufo_measure_data_c2o64bmi	m10015
bb.m10003  beg_bal_hb , --B7	合并抵销数期初余额	数值	(yygj03)盈余公积_合并	iufo_measure_data_c2o64bmi	m10003
bb.m10006 add_fd , --C5	法定盈余公积本期增加	数值	(yygj03)盈余公积_合并	iufo_measure_data_c2o64bmi	m10006
bb.m10014 add_other , --C6	其他本期增加	数值	(yygj03)盈余公积_合并	iufo_measure_data_c2o64bmi	m10014
bb.m10005 reduce_fd , --D5	法定盈余公积本期减少	数值	(yygj03)盈余公积_合并	iufo_measure_data_c2o64bmi	m10005
bb.m10013 reduce_other , --D6	其他本期减少	数值	(yygj03)盈余公积_合并	iufo_measure_data_c2o64bmi	m10013
bb.m10004 end_bal_fd , --E5	法定盈余公积期末余额	数值	(yygj03)盈余公积_合并	iufo_measure_data_c2o64bmi	m10004
bb.m10012 end_bal_other , --E6	其他期末余额	数值	(yygj03)盈余公积_合并	iufo_measure_data_c2o64bmi	m10012
bb.m10000  bal_hb   --E7	合并抵销数期末余额	数值	(yygj03)盈余公积_合并	iufo_measure_data_c2o64bmi	m10000

from  IUFO_MEASPUB_0011  aa

inner join  iufo_measure_data_c2o64bmi  bb  
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
     
     
