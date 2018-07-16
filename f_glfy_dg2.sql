select item_code,  item , 
sum(curr) curr,  
sum(last) last
from 
(
select aa.keyword3  item ,  cc.code org_code , cc.name org_name,  
bb.m10001 curr ,  --B20	本期发生额	数值	(glfy01)管理费用	iufo_measure_data_x3xdvncu	m10001
bb.m10000 last ,  --C20	上年同期发生额	数值	(glfy01)管理费用	iufo_measure_data_x3xdvncu	m10000
0 curr_dx , 
0 last_dx , 
bb.m4am97p  item_code --D20	备注	字符	(glfy01)管理费用	iufo_measure_data_x3xdvncu	m4am97p
from IUFO_MEASPUB_9C8C   aa 
     inner join iufo_measure_data_x3xdvncu   bb   
     on(   bb.alone_id  = aa.alone_id  
           and nvl(bb.dr , 0 ) = 0 
           and nvl(aa.dr , 0) = 0 
           and  aa.keyword1 in ( select children_pk_org  pk_org_list from (select  zz.code  children_org_code ,zz.name  children_org_name  ,yy.pk_org children_pk_org    , (select decode( count(pk_org)  , 0 , 'n' , 'y') b_father    from ORG_RCSMEMBER  mm where mm.pk_fatherorg  =  yy.pk_org ) b_father  , 'n' b_self from  org_orgs zz ,  ORG_RCSMEMBER yy   ,org_financeorg  xx  where 1=1 and zz.dr = 0 and zz.pk_org = yy.pk_org   and yy.dr =0  and yy.pk_fatherorg = xx.pk_financeorg  and xx.dr = 0 and xx.code = parameter('org_code_param') union all select mm.code  children_org_code  , mm.name children_org_name ,   mm.pk_financeorg  children_pk_org    , (select decode( count(pk_org)  , 0 , 'n' , 'y') b_father   from ORG_RCSMEMBER kk  where  kk.pk_fatherorg  = mm.pk_financeorg  ) b_father  , 'y' b_self from org_financeorg mm  where mm.dr = 0 and mm.code = parameter('org_code_param')) where b_father = 'n' or  b_self ='y')
           and aa.keyword2 = parameter('year_month_param')
     )  
inner join org_financeorg  cc  
     on(  cc.pk_financeorg  = aa.keyword1 and cc.dr = 0  )
     
union all 

select  aa.keyword3  item ,  cc.code org_code , cc.name org_name,  
bb.m10001 curr ,  --B21	本期发生额	数值	(glfy03)管理费用_合并	iufo_measure_data_p4n57hg5	m10001
bb.m10000 last ,  --C21	上年同期发生额	数值	(glfy03)管理费用_合并	iufo_measure_data_p4n57hg5	m10000
0 curr_dx ,
0 last_dx , 
bb.m35vfvg  item_code --D21	备注	字符	(glfy03)管理费用_合并	iufo_measure_data_p4n57hg5	m35vfvg
from IUFO_MEASPUB_9C8C aa 
     inner join iufo_measure_data_p4n57hg5   bb   
     on(   bb.alone_id  = aa.alone_id  
           and nvl(bb.dr , 0 ) = 0 
           and nvl(aa.dr , 0) = 0 
           and  aa.keyword1 in (   select children_pk_org  pk_org_list from (select  zz.code  children_org_code ,zz.name  children_org_name  ,yy.pk_org children_pk_org    , (select decode( count(pk_org)  , 0 , 'n' , 'y') b_father    from ORG_RCSMEMBER  mm where mm.pk_fatherorg  =  yy.pk_org ) b_father  , 'n' b_self from  org_orgs zz ,  ORG_RCSMEMBER yy   ,org_financeorg  xx  where 1=1 and zz.dr = 0 and zz.pk_org = yy.pk_org   and yy.dr =0  and yy.pk_fatherorg = xx.pk_financeorg and xx.dr = 0 and xx.code = parameter('org_code_param') union all select mm.code  children_org_code  , mm.name children_org_name ,   mm.pk_financeorg  children_pk_org    , (select decode( count(pk_org)  , 0 , 'n' , 'y') b_father   from ORG_RCSMEMBER kk  where  kk.pk_fatherorg  = mm.pk_financeorg  ) b_father  , 'y' b_self from org_financeorg mm  where mm.dr = 0 and mm.code = parameter('org_code_param')) where b_father = 'y'  and b_self ='n')
           and aa.keyword2 = parameter('year_month_param')
     )  
inner join org_financeorg  cc  
     on(  cc.pk_financeorg  = aa.keyword1 and cc.dr = 0  )
     
     
 
 )  group by  item_code ,item  
