select org_code ,org_name , 
cjs,   dfjyffj , jyffj , ccsys , fcs , tdsys ,yhs ,  curr_dx , last_dx
from 
(
select cc.code org_code , cc.name org_name  , 
bb.m10001 cjs,  --B6	城市维护建设税本期发生额	数值	(yysjjfj01)营业税金及附加	iufo_measure_data_1yy9ystr	m10001
bb.m10005 dfjyffj,  --B7	地方教育费附加本期发生额	数值	(yysjjfj01)营业税金及附加	iufo_measure_data_1yy9ystr	m10005
bb.m10009 jyffj,  --B8	教育费附加本期发生额	数值	(yysjjfj01)营业税金及附加	iufo_measure_data_1yy9ystr	m10009
bb.m10013 ccsys,  --B9	车船使用税本期发生额	数值	(yysjjfj01)营业税金及附加	iufo_measure_data_1yy9ystr	m10013
bb.m10017 fcs,  --B10	房产税本期发生额	数值	(yysjjfj01)营业税金及附加	iufo_measure_data_1yy9ystr	m10017
bb.m10003 tdsys,  --B11	土地使用税本期发生额	数值	(yysjjfj01)营业税金及附加	iufo_measure_data_1yy9ystr	m10003
bb.m10007 yhs,  --B12	印花税本期发生额	数值	(yysjjfj01)营业税金及附加	iufo_measure_data_1yy9ystr	m10007
0 curr_dx , 
0 last_dx  



from  IUFO_MEASPUB_0011  aa

inner join  iufo_measure_data_1yy9ystr  bb  
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
bb.m10001 cjs,  --B6	城市维护建设税本期发生额	数值	(yysjjfj03)营业税金及附加_合并	iufo_measure_data_alzmekft	m10001
bb.m10005 dfjyffj,  --B7	地方教育费附加本期发生额	数值	(yysjjfj03)营业税金及附加_合并	iufo_measure_data_alzmekft	m10005
bb.m10009 jyffj,  --B8	教育费附加本期发生额	数值	(yysjjfj03)营业税金及附加_合并	iufo_measure_data_alzmekft	m10009
bb.m10013 ccsys,  --B9	车船使用税本期发生额	数值	(yysjjfj03)营业税金及附加_合并	iufo_measure_data_alzmekft	m10013
bb.m10019 fcs,  --B10	房产税本期发生额	数值	(yysjjfj03)营业税金及附加_合并	iufo_measure_data_alzmekft	m10019
bb.m10003 tdsys,  --B11	土地使用税本期发生额	数值	(yysjjfj03)营业税金及附加_合并	iufo_measure_data_alzmekft	m10003
bb.m10007 yhs,  --B12	印花税本期发生额	数值	(yysjjfj03)营业税金及附加_合并	iufo_measure_data_alzmekft	m10007
bb.m10011 curr_dx , --B13	合并抵销数本期发生额	数值	(yysjjfj03)营业税金及附加_合并	iufo_measure_data_alzmekft	m10011, 
0 last_dx  


from  IUFO_MEASPUB_0011  aa

inner join  iufo_measure_data_alzmekft  bb  
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
     
     
