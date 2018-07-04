select 
*

from 
(
select cc.code org_code ,cc.name org_name ,  
bb.m10001  end_bal_cd  , --E5	银行承兑汇票_期末	数值	(yspj01)应收票据	iufo_measure_data_ldc69sve	m10001
bb.m10000  end_bal_other , -- E6	应收票据_其他_期末	数值	(yspj01)应收票据	iufo_measure_data_ldc69sve	m10000
bb.m10003  beg_bal_cd ,  --F5	银行承兑汇票_期初	数值	(yspj01)应收票据	iufo_measure_data_ldc69sve	m10003
bb.m10002  beg_bal_other --F6	应收票据_其他_期初	数值	(yspj01)应收票据	iufo_measure_data_ldc69sve	m10002

from  IUFO_MEASPUB_0011  aa


inner join  iufo_measure_data_ldc69sve  bb  
      on(
       
           bb.alone_id  = aa.alone_id  
           and nvl(bb.dr , 0 ) = 0 
           and nvl(aa.dr , 0) = 0 
           and aa.keyword1 in (

select children_pk_org  pk_org_list from (select  zz.code  children_org_code ,zz.name  children_org_name  ,yy.pk_org children_pk_org    , (select decode( count(pk_org)  , 0 , 'n' , 'y') b_father    from ORG_RCSMEMBER  mm where mm.pk_fatherorg  =  yy.pk_org ) b_father  , 'n' b_self from  org_orgs zz ,  ORG_RCSMEMBER yy   ,org_financeorg  xx  where 1=1 and zz.dr = 0 and zz.pk_org = yy.pk_org   and yy.dr =0  and yy.pk_fatherorg = xx.pk_financeorg  and xx.dr = 0 and xx.code = parameter('org_code_param') union all select mm.code  children_org_code  , mm.name children_org_name ,   mm.pk_financeorg  children_pk_org    , (select decode( count(pk_org)  , 0 , 'n' , 'y') b_father   from ORG_RCSMEMBER kk  where  kk.pk_fatherorg  = mm.pk_financeorg  ) b_father  , 'y' b_self from org_financeorg mm  where mm.dr = 0 and mm.code = parameter('org_code_param')) where  b_father = 'n'   or  b_self ='y'


)
           and aa.keyword2 = parameter('year_month_param')
      
      )    
inner join org_financeorg  cc  
     on(  cc.pk_financeorg  = aa.keyword1 and cc.dr = 0  )
     
     
union all 

select cc.code org_code ,cc.name org_name ,  
bb.m10002  end_bal_cd  , --E5	应收票据_银行承兑汇票_合并_期末	数值	(yspj03)应收票据_合并	iufo_measure_data_a1chyfpt	m10002
bb.m10001  end_bal_other , -- E6	应收票据_其他_合并_期末	数值	(yspj03)应收票据_合并	iufo_measure_data_a1chyfpt	m10001
bb.m10004  beg_bal_cd ,  --F5	应收票据_银行承兑汇票_合并_期初	数值	(yspj03)应收票据_合并	iufo_measure_data_a1chyfpt	m10004
bb.m10005  beg_bal_other --F6	应收票据_其他_合并_期初	数值	(yspj03)应收票据_合并	iufo_measure_data_a1chyfpt	m10005
       
from  IUFO_MEASPUB_0011  aa

inner join  iufo_measure_data_a1chyfpt  bb  
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

) order by org_code 
