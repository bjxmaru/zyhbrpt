select  org_code ,org_name , 
end_bal_zengzhishui , 
end_bal_suideshui , 
end_bal_fangchanshui , 
end_bal_other , 
end_bal_dx 
from 
(
select cc.code org_code , cc.name org_name  , 
bb.m10005 end_bal_zengzhishui ,  --B5	可抵扣的增值税及附加税期末余额	数值	(cqldzc01)其他流动资产	iufo_measure_data_inftjxqn	m10005
bb.m10009 end_bal_suideshui ,  --B6	预缴企业所得税期末余额	数值	(cqldzc01)其他流动资产	iufo_measure_data_inftjxqn	m10009
bb.m10003 end_bal_fangchanshui ,  --B7	多交的房产税及土地使用税期末余额	数值	(cqldzc01)其他流动资产	iufo_measure_data_inftjxqn	m10003
bb.m10007 end_bal_other  , --B8	其他期末余额	数值	(cqldzc01)其他流动资产	iufo_measure_data_inftjxqn	m10007
0  end_bal_dx   
from  IUFO_MEASPUB_0011  aa

inner join  iufo_measure_data_inftjxqn  bb  
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
bb.m10007 end_bal_zengzhishui ,  --B5	可抵扣的增值税及附加税期末余额	数值	(cqldzc03)其他流动资产_合并	iufo_measure_data_ab86frt8	m10007
bb.m10011 end_bal_suideshui ,  --B6	预缴企业所得税期末余额	数值	(cqldzc03)其他流动资产_合并	iufo_measure_data_ab86frt8	m10011
bb.m10003 end_bal_fangchanshui ,  --B7	多交的房产税及土地使用税期末余额	数值	(cqldzc03)其他流动资产_合并	iufo_measure_data_ab86frt8	m10003
bb.m10009 end_bal_other  , --B8	其他期末余额	数值	(cqldzc03)其他流动资产_合并	iufo_measure_data_ab86frt8	m10009
bb.m10001   end_bal_dx   --B9	其他流动资产抵销数期末余额	数值	(cqldzc03)其他流动资产_合并	iufo_measure_data_ab86frt8	m10001
from  IUFO_MEASPUB_0011  aa

inner join  iufo_measure_data_ab86frt8  bb  
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