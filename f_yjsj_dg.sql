select org_code ,org_name , end_bal_zzs , end_bal_yss , end_bal_sds , 
end_bal_grsds , end_bal_cjs , end_bal_jyffj , end_bal_dfjyffj ,end_bal_yhs , 
end_bal_tdzzs ,  end_bal_fcs , end_bal_jgtjjj , end_bal_ccsys , 
end_bal_dkdjsds , end_bal_szys , end_bal_drzjxs , end_bal_ddkjxs , end_bal_qt
from 
(
select cc.code org_code , cc.name org_name  , 
bb.m10019  end_bal_zzs ,   --B5	增值税期末金额	数值	(yjsj01)应交税金	iufo_measure_data_2mgewouk	m10019
bb.m10003  end_bal_yss ,   --B6	营业税期末金额	数值	(yjsj01)应交税金	iufo_measure_data_2mgewouk	m10003
bb.m10027  end_bal_sds , --B7	企业所得税期末金额	数值	(yjsj01)应交税金	iufo_measure_data_2mgewouk	m10027
bb.m10011  end_bal_grsds , --B8	个人所得税期末金额	数值	(yjsj01)应交税金	iufo_measure_data_2mgewouk	m10011
bb.m10035  end_bal_cjs , --B9	城市维护建设税期末金额	数值	(yjsj01)应交税金	iufo_measure_data_2mgewouk	m10035
bb.m10021  end_bal_jyffj , --B10	教育费附加期末金额	数值	(yjsj01)应交税金	iufo_measure_data_2mgewouk	m10021
bb.m10005  end_bal_dfjyffj , --B11	地方教育费附加期末金额	数值	(yjsj01)应交税金	iufo_measure_data_2mgewouk	m10005
bb.m10029  end_bal_yhs , --B12	印花税期末金额	数值	(yjsj01)应交税金	iufo_measure_data_2mgewouk	m10029
bb.m10013  end_bal_tdzzs , --B13	土地使用税期末金额	数值	(yjsj01)应交税金	iufo_measure_data_2mgewouk	m10013   
bb.m10037  end_bal_fcs , --B14	房产税期末金额	数值	(yjsj01)应交税金	iufo_measure_data_2mgewouk	m10037               
bb.m10023  end_bal_jgtjjj , --B15	价格调节基金期末金额	数值	(yjsj01)应交税金	iufo_measure_data_2mgewouk	m10023           
bb.m10007  end_bal_ccsys , --B16	车船使用税期末金额	数值	(yjsj01)应交税金	iufo_measure_data_2mgewouk	m10007   
bb.m10031  end_bal_dkdjsds , --B17	代扣企业所得税期末金额	数值	(yjsj01)应交税金	iufo_measure_data_2mgewouk	m10031
bb.m10015  end_bal_szys , --B18	水资源税期末金额	数值	(yjsj01)应交税金	iufo_measure_data_2mgewouk	m10015
bb.m10001  end_bal_drzjxs , --B19	待认证进项税额期末金额	数值	(yjsj01)应交税金	iufo_measure_data_2mgewouk	m10001
bb.m10025  end_bal_ddkjxs , --B20	待抵扣进项税额期末金额	数值	(yjsj01)应交税金	iufo_measure_data_2mgewouk	m10025
bb.m10009  end_bal_qt  --B21	其他期末金额	数值	(yjsj01)应交税金	iufo_measure_data_2mgewouk	m10009

from  IUFO_MEASPUB_0011  aa

inner join  iufo_measure_data_2mgewouk  bb  
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
bb.m10019  end_bal_zzs ,   --B5	增值税期末金额	数值	(yjsj03)应交税金_合并	iufo_measure_data_biea5vsv	m10019
bb.m10003  end_bal_yss ,   --B6	营业税期末金额	数值	(yjsj03)应交税金_合并	iufo_measure_data_biea5vsv	m10003
bb.m10027  end_bal_sds , --B7	企业所得税期末金额	数值	(yjsj03)应交税金_合并	iufo_measure_data_biea5vsv	m10027
bb.m10011  end_bal_grsds , --B8	个人所得税期末金额	数值	(yjsj03)应交税金_合并iufo_measure_data_biea5vsvm10011
bb.m10035  end_bal_cjs , --B9	城市维护建设税期末金额	数值	(yjsj03)应交税金_合并	iufo_measure_data_biea5vsv	m10035
bb.m10021  end_bal_jyffj , --B10	教育费附加期末金额	数值	(yjsj03)应交税金_合并	iufo_measure_data_biea5vsv	m10021
bb.m10005  end_bal_dfjyffj , --B11	地方教育费附加期末金额	数值	(yjsj03)应交税金_合并	iufo_measure_data_biea5vsv	m10005
bb.m10029  end_bal_yhs , --B12	印花税期末金额	数值	(yjsj03)应交税金_合并	iufo_measure_data_biea5vsv	m10029
bb.m10013  end_bal_tdzzs , --B13	土地使用税期末金额	数值	(yjsj03)应交税金_合并	iufo_measure_data_biea5vsv	m10013
bb.m10037  end_bal_fcs , --B14	房产税期末金额	数值	(yjsj03)应交税金_合并	iufo_measure_data_biea5vsv	m10037     
bb.m10023  end_bal_jgtjjj , --B15	价格调节基金期末金额	数值	(yjsj03)应交税金_合并	iufo_measure_data_biea5vsv	m10023    
bb.m10007  end_bal_ccsys , --B16	车船使用税期末金额	数值	(yjsj03)应交税金_合并	iufo_measure_data_biea5vsv	m10007
bb.m10031  end_bal_dkdjsds , --B17	代扣企业所得税期末金额	数值	(yjsj03)应交税金_合并	iufo_measure_data_biea5vsv	m10031
bb.m10015  end_bal_szys , --B18	水资源税期末金额	数值	(yjsj03)应交税金_合并	iufo_measure_data_biea5vsv	m10015
bb.m10001  end_bal_drzjxs , --B19	待认证进项税额期末金额	数值	(yjsj03)应交税金_合并	iufo_measure_data_biea5vsv	m10001
bb.m10025  end_bal_ddkjxs , --B20	待抵扣进项税额期末金额	数值	(yjsj03)应交税金_合并	iufo_measure_data_biea5vsv	m10025
bb.m10009  end_bal_qt  --B21	其他期末金额	数值	(yjsj03)应交税金_合并	iufo_measure_data_biea5vsv	m10009

from  IUFO_MEASPUB_0011  aa

inner join  iufo_measure_data_biea5vsv  bb  
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

