select org_code ,org_name , 
gz, tdsys , fz , slsyf , zj , 
zdf , bgf ,shbxj ,zgflf , zjjgfwf , 
qt ,  curr_dx ,  last_dx
from 
(
select cc.code org_code , cc.name org_name  , 
bb.mo09jni gz,  --B5	工资及奖金本期发生额	数值	(glfy01)管理费用	iufo_measure_data_vnsfy5r0	mo09jni
bb.mkcxovc tdsys,  --B6	土地使用税本期发生额	数值	(glfy01)管理费用	iufo_measure_data_vnsfy5r0	mkcxovc
bb.mwjb0r9 fz,  --B7	房租本期发生额	数值	(glfy01)管理费用	iufo_measure_data_vnsfy5r0	mwjb0r9
bb.mro1ceb slsyf,  --B8	车辆使用费本期发生额	数值	(glfy01)管理费用	iufo_measure_data_vnsfy5r0	mro1ceb
bb.mvos6jh zj,  --B9	折旧及摊销本期发生额	数值	(glfy01)管理费用	iufo_measure_data_vnsfy5r0	mvos6jh
bb.mu2z6av zdf,  --B10	业务招待费本期发生额	数值	(glfy01)管理费用	iufo_measure_data_vnsfy5r0	mu2z6av
bb.mv4synr bgf,  --B11	办公费本期发生额	数值	(glfy01)管理费用	iufo_measure_data_vnsfy5r0	mv4synr
bb.me75xra shbxj,  --B12	社会保险金本期发生额	数值	(glfy01)管理费用	iufo_measure_data_vnsfy5r0	me75xra
bb.mey6y3n zgflf,  --B13	职工福利费本期发生额	数值	(glfy01)管理费用	iufo_measure_data_vnsfy5r0	mey6y3n
bb.m11aqso zjjgfwf,  --B14	中介机构服务费本期发生额	数值	(glfy01)管理费用	iufo_measure_data_vnsfy5r0	m11aqso
bb.mnwnng6 qt,  --B15	其他本期发生额	数值	(glfy01)管理费用	iufo_measure_data_vnsfy5r0	mnwnng6
0  curr_dx , 
0  last_dx 


from  IUFO_MEASPUB_0011  aa

inner join  iufo_measure_data_vnsfy5r0  bb  
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
bb.m10023 gz,  --B5	工资及奖金本期发生额	数值	(glfy03)管理费用_合并	iufo_measure_data_h3tfgimd	m10023
bb.m10003 tdsys,  --B6	土地使用税本期发生额	数值	(glfy03)管理费用_合并	iufo_measure_data_h3tfgimd	m10003
bb.m10009 fz,  --B7	房租本期发生额	数值	(glfy03)管理费用_合并	iufo_measure_data_h3tfgimd	m10009
bb.m10015 slsyf,  --B8	车辆使用费本期发生额	数值	(glfy03)管理费用_合并	iufo_measure_data_h3tfgimd	m10015
bb.m10019 zj,  --B9	折旧及摊销本期发生额	数值	(glfy03)管理费用_合并	iufo_measure_data_h3tfgimd	m10019
bb.m10025 zdf,  --B10	业务招待费本期发生额	数值	(glfy03)管理费用_合并	iufo_measure_data_h3tfgimd	m10025
bb.m10005 bgf,  --B11	办公费本期发生额	数值	(glfy03)管理费用_合并	iufo_measure_data_h3tfgimd	m10005
bb.m10011 shbxj,  --B12	社会保险金本期发生额	数值	(glfy03)管理费用_合并	iufo_measure_data_h3tfgimd	m10011
bb.m10017 zgflf,  --B13	职工福利费本期发生额	数值	(glfy03)管理费用_合并	iufo_measure_data_h3tfgimd	m10017
bb.m10021 zjjgfwf,  --B14	中介机构服务费本期发生额	数值	(glfy03)管理费用_合并	iufo_measure_data_h3tfgimd	m10021
bb.m10001 qt,  --B15	其他本期发生额	数值	(glfy03)管理费用_合并	iufo_measure_data_h3tfgimd	m10001
bb.m10007   curr_dx ,  --B16	抵销金额本期发生额	数值	(glfy03)管理费用_合并	iufo_measure_data_h3tfgimd	m10007
0  last_dx 


from  IUFO_MEASPUB_0011  aa

inner join  iufo_measure_data_h3tfgimd  bb  
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
     
     
