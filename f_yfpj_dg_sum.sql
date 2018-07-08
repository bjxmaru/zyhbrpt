select
 sum(end_bal_cd) end_bal_cd , 
 sum(end_bal_other) end_bal_other  , 
 sum(beg_bal_cd ) beg_bal_cd,  
 sum(beg_bal_other) beg_bal_other 
from 
(
select cc.code org_code , cc.name org_name  , 
bb.m10001  end_bal_cd ,   --B5	银行承兑汇票期末金额	数值	(yfpj01)应付票据	iufo_measure_data_oxu5of00	m10001
bb.m10005  end_bal_other ,  --B6	其他期末金额	数值	(yfpj01)应付票据	iufo_measure_data_oxu5of00	m10005 

bb.m10000  beg_bal_cd ,    --C5	银行承兑汇票期初金额	数值	(yfpj01)应付票据	iufo_measure_data_oxu5of00	m10000 

bb.m10004  beg_bal_other    --C6	其他期初金额	数值	(yfpj01)应付票据	iufo_measure_data_oxu5of00	m10004

from  IUFO_MEASPUB_0011  aa

inner join  iufo_measure_data_oxu5of00  bb  
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
bb.m10001  end_bal_cd ,   --B5	银行承兑汇票期末金额	数值	(yfpj03)应付票据_合并	iufo_measure_data_mi18vfgi	m10001
bb.m10005  end_bal_other ,  --B6	其他期末金额	数值	(yfpj03)应付票据_合并	iufo_measure_data_mi18vfgi	m10005

bb.m10000  beg_bal_cd ,    --C5	银行承兑汇票期初金额	数值	(yfpj03)应付票据_合并	iufo_measure_data_mi18vfgi	m10000

bb.m10004  beg_bal_other    --C6	其他期初金额	数值	(yfpj03)应付票据_合并	iufo_measure_data_mi18vfgi	m10004

from  IUFO_MEASPUB_0011  aa

inner join  iufo_measure_data_mi18vfgi  bb  
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

