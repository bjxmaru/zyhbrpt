select 
sum(beg_bal_lz) beg_bal_lz ,
sum(beg_bal_ct) beg_bal_ct , 
sum(beg_bal_oneyear) beg_bal_oneyear ,
sum(add_lz) add_lz , 
sum(add_ct) add_ct , 
sum(add_oneyear) add_oneyear ,
sum(reduce_lz) reduce_lz, 
sum(reduce_ct) reduce_ct ,
sum(reduce_oneyear) reduce_oneyear, 
sum(bal_lz) bal_lz , 
sum(bal_ct) bal_ct, 
sum(bal_oneyear) bal_oneyear,
sum(beg_bal_lz_yl) beg_bal_lz_yl ,
sum(beg_bal_lz_sy) beg_bal_lz_sy ,
sum(add_lz_yl) add_lz_yl, 
sum(add_lz_sy) add_lz_sy, 
sum(reduce_lz_yl) reduce_lz_yl, 
sum(reduce_lz_sy) reduce_lz_sy, 
sum(bal_lz_yl) bal_lz_yl, 
sum(bal_lz_sy) bal_lz_sy, 
sum(beg_bal_gz) beg_bal_gz, 
sum(beg_bal_flf) beg_bal_flf, 
sum(beg_bal_sb) beg_bal_sb, 
sum(beg_bal_yiliao) beg_bal_yiliao ,
sum(beg_bal_yanglao) beg_bal_yanglao, 
sum(beg_bal_shiye) beg_bal_shiye, 
sum(beg_bal_gs) beg_bal_gs , 
sum(beg_bal_sy) beg_bal_sy, 
sum(beg_bal_zfgjj) beg_bal_zfgjj, 
sum(beg_bal_ghjf) beg_bal_ghjf ,
sum(add_gz) add_gz  ,
sum(add_flf) add_flf, 
sum(add_sb) add_sb, 
sum(add_yiliao) add_yiliao, 
sum(add_yanglao) add_yanglao,
sum(add_shiye) add_shiye ,
sum(add_gs) add_gs , 
sum(add_sy) add_sy, 
sum(add_zfgjj) add_zfgjj , 
sum(add_ghjf) add_ghjf, 
sum(reduce_gz) reduce_gz, 
sum(reduce_flf)  reduce_flf, 
sum(reduce_sb)  reduce_sb, 
sum(reduce_yiliao) reduce_yiliao ,
sum(reduce_yanglao) reduce_yanglao, 
sum(reduce_shiye) reduce_shiye, 
sum(reduce_gs) reduce_gs, 
sum(reduce_sy) reduce_sy, 
sum(reduce_zfgjj) reduce_zfgjj, 
sum(reduce_ghjf) reduce_ghjf ,
sum(bal_gz) bal_gz, 
sum(bal_flf) bal_flf ,
sum(bal_sb) bal_sb ,
sum(bal_yiliao) bal_yiliao ,
sum(bal_yanglao) bal_yanglao ,
sum(bal_shiye) bal_shiye ,
sum(bal_gs) bal_gs ,
sum(bal_sy) bal_sy, 
sum(bal_zfgjj) bal_zfgjj, 
sum(bal_ghjf) bal_ghjf , 
sum(dx) dx  
from 
(
select cc.code org_code , cc.name org_name,  
bb.m10011  beg_bal_lz , --B8	离职后福利-设定提存计划期初余额	数值	(yfzgxc01)应付职工薪酬	iufo_measure_data_wg6pazhg	m10011
bb.m10075  beg_bal_ct , --B9	辞退福利期初余额	数值	(yfzgxc01)应付职工薪酬	iufo_measure_data_wg6pazhg	m10075
bb.m10063  beg_bal_oneyear,    --B10	一年内到期的其他福利期初余额	数值	(yfzgxc01)应付职工薪酬	iufo_measure_data_wg6pazhg	m10063
bb.m10010  add_lz ,  --C8	离职后福利-设定提存计划本期增加	数值	(yfzgxc01)应付职工薪酬	iufo_measure_data_wg6pazhg	m10010
bb.m10074  add_ct ,   --C9	辞退福利本期增加	数值	(yfzgxc01)应付职工薪酬	iufo_measure_data_wg6pazhg	m10074
bb.m10062  add_oneyear ,  --C10	一年内到期的其他福利本期增加	数值	(yfzgxc01)应付职工薪酬	iufo_measure_data_wg6pazhg	m10062
bb.m10009  reduce_lz ,  --D8	离职后福利-设定提存计划本期减少	数值	(yfzgxc01)应付职工薪酬	iufo_measure_data_wg6pazhg	m10009
bb.m10073  reduce_ct , --D9	辞退福利本期减少	数值	(yfzgxc01)应付职工薪酬	iufo_measure_data_wg6pazhg	m10073
bb.m10061  reduce_oneyear ,    --D10	一年内到期的其他福利本期减少	数值	(yfzgxc01)应付职工薪酬	iufo_measure_data_wg6pazhg	m10061
bb.m10008  bal_lz , --E8	离职后福利-设定提存计划期末余额	数值	(yfzgxc01)应付职工薪酬	iufo_measure_data_wg6pazhg	m10008
bb.m10072  bal_ct , --  E9	辞退福利期末余额	数值	(yfzgxc01)应付职工薪酬	iufo_measure_data_wg6pazhg	m10072
bb.m10060  bal_oneyear , --E10	一年内到期的其他福利期末余额	数值	(yfzgxc01)应付职工薪酬	iufo_measure_data_wg6pazhg	m10060
 
bb.m10059  beg_bal_lz_yl, --B31	基本养老保险期初余额	数值	(yfzgxc01)应付职工薪酬	iufo_measure_data_wg6pazhg	m10059
bb.m10039  beg_bal_lz_sy, --B32	失业保险费期初余额	数值	(yfzgxc01)应付职工薪酬	iufo_measure_data_wg6pazhg	m10039
bb.m10058  add_lz_yl, --C31	基本养老保险本期增加	数值	(yfzgxc01)应付职工薪酬	iufo_measure_data_wg6pazhg	m10058
bb.m10038  add_lz_sy, --C32	失业保险费本期增加	数值	(yfzgxc01)应付职工薪酬	iufo_measure_data_wg6pazhg	m10038
bb.m10057  reduce_lz_yl, --D31	基本养老保险本期减少	数值	(yfzgxc01)应付职工薪酬	iufo_measure_data_wg6pazhg	m10057
bb.m10037  reduce_lz_sy, --D32	失业保险费本期减少	数值	(yfzgxc01)应付职工薪酬	iufo_measure_data_wg6pazhg	m10037
bb.m10056  bal_lz_yl, --E31	基本养老保险期末余额	数值	(yfzgxc01)应付职工薪酬	iufo_measure_data_wg6pazhg	m10056
bb.m10036  bal_lz_sy , --E32	失业保险费期末余额	数值	(yfzgxc01)应付职工薪酬	iufo_measure_data_wg6pazhg	m10036

 
bb.m10047 beg_bal_gz, --B16	工资、奖金、津贴和补贴期初余额	数值	(yfzgxc01)应付职工薪酬	iufo_measure_data_wg6pazhg	m10047
bb.m10031 beg_bal_flf , --B17	职工福利费期初余额	数值	(yfzgxc01)应付职工薪酬	iufo_measure_data_wg6pazhg	m10031
bb.m10015 beg_bal_sb , --B18	社会保险费期初余额	数值	(yfzgxc01)应付职工薪酬	iufo_measure_data_wg6pazhg	m10015
bb.m10003 beg_bal_yiliao ,  --B19	其中：医疗保险费期初余额	数值	(yfzgxc01)应付职工薪酬	iufo_measure_data_wg6pazhg	m10003
bb.m10067 beg_bal_yanglao , --B20	基本养老保险费期初余额	数值	(yfzgxc01)应付职工薪酬	iufo_measure_data_wg6pazhg	m10067
bb.m10051 beg_bal_shiye , --B21	失业保险期初余额	数值	(yfzgxc01)应付职工薪酬	iufo_measure_data_wg6pazhg	m10051
bb.m10035 beg_bal_gs , --B22	工伤保险费期初余额	数值	(yfzgxc01)应付职工薪酬	iufo_measure_data_wg6pazhg	m10035
bb.m10019 beg_bal_sy , --B23	生育保险费期初余额	数值	(yfzgxc01)应付职工薪酬	iufo_measure_data_wg6pazhg	m10019
bb.m10007 beg_bal_zfgjj,--B24	住房公积金期初余额	数值	(yfzgxc01)应付职工薪酬	iufo_measure_data_wg6pazhg	m10007
bb.m10071 beg_bal_ghjf , --B25	工会经费和职工教育经费期初余额	数值	(yfzgxc01)应付职工薪酬	iufo_measure_data_wg6pazhg	m10071
bb.m10046 add_gz , --C16	工资、奖金、津贴和补贴本期增加	数值	(yfzgxc01)应付职工薪酬	iufo_measure_data_wg6pazhg	m10046
bb.m10030 add_flf , --C17	职工福利费本期增加	数值	(yfzgxc01)应付职工薪酬	iufo_measure_data_wg6pazhg	m10030
bb.m10014 add_sb , --C18	社会保险费本期增加	数值	(yfzgxc01)应付职工薪酬	iufo_measure_data_wg6pazhg	m10014
bb.m10002 add_yiliao , --C19	其中：医疗保险费本期增加	数值	(yfzgxc01)应付职工薪酬	iufo_measure_data_wg6pazhg	m10002
bb.m10066 add_yanglao , --C20	基本养老保险费本期增加	数值	(yfzgxc01)应付职工薪酬	iufo_measure_data_wg6pazhg	m10066
bb.m10050 add_shiye , --C21	失业保险本期增加	数值	(yfzgxc01)应付职工薪酬	iufo_measure_data_wg6pazhg	m10050
bb.m10034 add_gs , --C22	工伤保险费本期增加	数值	(yfzgxc01)应付职工薪酬	iufo_measure_data_wg6pazhg	m10034
bb.m10018 add_sy , --C23	生育保险费本期增加	数值	(yfzgxc01)应付职工薪酬	iufo_measure_data_wg6pazhg	m10018
bb.m10006 add_zfgjj , --C24	住房公积金本期增加	数值	(yfzgxc01)应付职工薪酬	iufo_measure_data_wg6pazhg	m10006
bb.m10070 add_ghjf , --C25	工会经费和职工教育经费本期增加	数值	(yfzgxc01)应付职工薪酬	iufo_measure_data_wg6pazhg	m10070
bb.m10045 reduce_gz , --D16	工资、奖金、津贴和补贴本期减少	数值	(yfzgxc01)应付职工薪酬	iufo_measure_data_wg6pazhg	m10045
bb.m10029 reduce_flf , --D17	职工福利费本期减少	数值	(yfzgxc01)应付职工薪酬	iufo_measure_data_wg6pazhg	m10029
bb.m10013 reduce_sb , --D18	社会保险费本期减少	数值	(yfzgxc01)应付职工薪酬	iufo_measure_data_wg6pazhg	m10013
bb.m10001 reduce_yiliao , --D19	其中：医疗保险费本期减少	数值	(yfzgxc01)应付职工薪酬	iufo_measure_data_wg6pazhg	m10001
bb.m10065 reduce_yanglao , --D20	基本养老保险费本期减少	数值	(yfzgxc01)应付职工薪酬	iufo_measure_data_wg6pazhg	m10065
bb.m10049 reduce_shiye , --D21	失业保险本期减少	数值	(yfzgxc01)应付职工薪酬	iufo_measure_data_wg6pazhg	m10049
bb.m10033 reduce_gs , --D22	工伤保险费本期减少	数值	(yfzgxc01)应付职工薪酬	iufo_measure_data_wg6pazhg	m10033
bb.m10017 reduce_sy , --D23	生育保险费本期减少	数值	(yfzgxc01)应付职工薪酬	iufo_measure_data_wg6pazhg	m10017
bb.m10005 reduce_zfgjj , --D24	住房公积金本期减少	数值	(yfzgxc01)应付职工薪酬	iufo_measure_data_wg6pazhg	m10005
bb.m10069 reduce_ghjf , --D25	工会经费和职工教育经费本期减少	数值	(yfzgxc01)应付职工薪酬	iufo_measure_data_wg6pazhg	m10069
bb.m10044 bal_gz , --E16	工资、奖金、津贴和补贴期末余额	数值	(yfzgxc01)应付职工薪酬	iufo_measure_data_wg6pazhg	m10044
bb.m10028 bal_flf , --E17	职工福利费期末余额	数值	(yfzgxc01)应付职工薪酬	iufo_measure_data_wg6pazhg	m10028
bb.m10012 bal_sb , --E18	社会保险费期末余额	数值	(yfzgxc01)应付职工薪酬	iufo_measure_data_wg6pazhg	m10012
bb.m10000 bal_yiliao , --E19	其中：医疗保险费期末余额	数值	(yfzgxc01)应付职工薪酬	iufo_measure_data_wg6pazhg	m10000
bb.m10064 bal_yanglao , --E20	基本养老保险费期末余额	数值	(yfzgxc01)应付职工薪酬	iufo_measure_data_wg6pazhg	m10064
bb.m10048 bal_shiye , --E21	失业保险期末余额	数值	(yfzgxc01)应付职工薪酬	iufo_measure_data_wg6pazhg	m10048
bb.m10032 bal_gs , --E22	工伤保险费期末余额	数值	(yfzgxc01)应付职工薪酬	iufo_measure_data_wg6pazhg	m10032
bb.m10016 bal_sy , --E23	生育保险费期末余额	数值	(yfzgxc01)应付职工薪酬	iufo_measure_data_wg6pazhg	m10016
bb.m10004 bal_zfgjj , --E24	住房公积金期末余额	数值	(yfzgxc01)应付职工薪酬	iufo_measure_data_wg6pazhg	m10004
bb.m10068 bal_ghjf , --E25	工会经费和职工教育经费期末余额	数值	(yfzgxc01)应付职工薪酬	iufo_measure_data_wg6pazhg	m10068
0 dx 

from  IUFO_MEASPUB_0011  aa

inner join  iufo_measure_data_wg6pazhg  bb  
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
bb.m10011  beg_bal_lz , --B8	离职后福利-设定提存计划期初余额	数值	(yfzgxc03)应付职工薪酬_合并	iufo_measure_data_czpl6794	m10011
bb.m10075  beg_bal_ct , --B9	辞退福利期初余额	数值	(yfzgxc03)应付职工薪酬_合并	iufo_measure_data_czpl6794	m10075
bb.m10063  beg_bal_oneyear,    --B10	一年内到期的其他福利期初余额	数值	(yfzgxc03)应付职工薪酬_合并	iufo_measure_data_czpl6794	m10063
bb.m10010  add_lz ,  --C8	离职后福利-设定提存计划本期增加	数值	(yfzgxc03)应付职工薪酬_合并	iufo_measure_data_czpl6794	m10010
bb.m10074  add_ct ,   --C9	辞退福利本期增加	数值	(yfzgxc03)应付职工薪酬_合并	iufo_measure_data_czpl6794	m10074
bb.m10062  add_oneyear ,  --C10	一年内到期的其他福利本期增加	数值	(yfzgxc03)应付职工薪酬_合并	iufo_measure_data_czpl6794	m10062
bb.m10009  reduce_lz ,  --D8	离职后福利-设定提存计划本期减少	数值	(yfzgxc03)应付职工薪酬_合并	iufo_measure_data_czpl6794	m10009
bb.m10073  reduce_ct , --D9	辞退福利本期减少	数值	(yfzgxc03)应付职工薪酬_合并	iufo_measure_data_czpl6794	m10073
bb.m10061  reduce_oneyear ,    --D10	一年内到期的其他福利本期减少	数值	(yfzgxc03)应付职工薪酬_合并	iufo_measure_data_czpl6794	m10061
bb.m10008  bal_lz , --E8	离职后福利-设定提存计划期末余额	数值	(yfzgxc03)应付职工薪酬_合并	iufo_measure_data_czpl6794	m10008
bb.m10072  bal_ct , --  E9	辞退福利期末余额	数值	(yfzgxc03)应付职工薪酬_合并	iufo_measure_data_czpl6794	m10072
bb.m10060  bal_oneyear , --E10	一年内到期的其他福利期末余额	数值	(yfzgxc03)应付职工薪酬_合并	iufo_measure_data_czpl6794	m10060
 
bb.m10059  beg_bal_lz_yl, --B32	基本养老保险期初余额	数值	(yfzgxc03)应付职工薪酬_合并	iufo_measure_data_czpl6794	m10059
bb.m10039  beg_bal_lz_sy, --B33	失业保险费期初余额	数值	(yfzgxc03)应付职工薪酬_合并	iufo_measure_data_czpl6794	m10039
bb.m10058  add_lz_yl, --C32	基本养老保险本期增加	数值	(yfzgxc03)应付职工薪酬_合并	iufo_measure_data_czpl6794	m10058
bb.m10038  add_lz_sy, --C33	失业保险费本期增加	数值	(yfzgxc03)应付职工薪酬_合并	iufo_measure_data_czpl6794	m10038
bb.m10057  reduce_lz_yl, --D31	基本养老保险本期减少	数值	(yfzgxc01)应付职工薪酬	iufo_measure_data_wg6pazhg	m10057
bb.m10037  reduce_lz_sy, --D32	失业保险费本期减少	数值	(yfzgxc01)应付职工薪酬	iufo_measure_data_wg6pazhg	m10037
bb.m10056  bal_lz_yl, --E32	基本养老保险期末余额	数值	(yfzgxc03)应付职工薪酬_合并	iufo_measure_data_czpl6794	m10056
bb.m10036  bal_lz_sy , --E33	失业保险费期末余额	数值	(yfzgxc03)应付职工薪酬_合并	iufo_measure_data_czpl6794	m10036

 
bb.m10047 beg_bal_gz, --B16	工资、奖金、津贴和补贴期初余额	数值	(yfzgxc03)应付职工薪酬_合并	iufo_measure_data_czpl6794	m10047
bb.m10031 beg_bal_flf , --B17	职工福利费期初余额	数值	(yfzgxc03)应付职工薪酬_合并	iufo_measure_data_czpl6794	m10031
bb.m10015 beg_bal_sb , --B18	社会保险费期初余额	数值	(yfzgxc03)应付职工薪酬_合并	iufo_measure_data_czpl6794	m10015
bb.m10003 beg_bal_yiliao ,  --B19	其中：医疗保险费期初余额	数值	(yfzgxc03)应付职工薪酬_合并	iufo_measure_data_czpl6794	m10003
bb.m10067 beg_bal_yanglao , --B20	基本养老保险费期初余额	数值	(yfzgxc03)应付职工薪酬_合并	iufo_measure_data_czpl6794	m10067
bb.m10051 beg_bal_shiye , --B21	失业保险期初余额	数值	(yfzgxc03)应付职工薪酬_合并	iufo_measure_data_czpl6794	m10051
bb.m10035 beg_bal_gs , --B22	工伤保险费期初余额	数值	(yfzgxc03)应付职工薪酬_合并	iufo_measure_data_czpl6794	m10035
bb.m10019 beg_bal_sy , --B23	生育保险费期初余额	数值	(yfzgxc03)应付职工薪酬_合并	iufo_measure_data_czpl6794	m10019
bb.m10007 beg_bal_zfgjj,--B24	住房公积金期初余额	数值	(yfzgxc03)应付职工薪酬_合并	iufo_measure_data_czpl6794	m10007
bb.m10071 beg_bal_ghjf , --B25	工会经费和职工教育经费期初余额	数值	(yfzgxc03)应付职工薪酬_合并	iufo_measure_data_czpl6794	m10071
bb.m10046 add_gz , --C16	工资、奖金、津贴和补贴本期增加	数值	(yfzgxc03)应付职工薪酬_合并	iufo_measure_data_czpl6794	m10046
bb.m10030 add_flf , --C17	职工福利费本期增加	数值	(yfzgxc03)应付职工薪酬_合并	iufo_measure_data_czpl6794	m10030
bb.m10014 add_sb , --C18	社会保险费本期增加	数值	(yfzgxc03)应付职工薪酬_合并	iufo_measure_data_czpl6794	m10014
bb.m10002 add_yiliao , --C19	其中：医疗保险费本期增加	数值	(yfzgxc03)应付职工薪酬_合并	iufo_measure_data_czpl6794	m10002
bb.m10066 add_yanglao , --C20	基本养老保险费本期增加	数值	(yfzgxc03)应付职工薪酬_合并	iufo_measure_data_czpl6794	m10066
bb.m10050 add_shiye , --C21	失业保险本期增加	数值	(yfzgxc03)应付职工薪酬_合并	iufo_measure_data_czpl6794	m10050
bb.m10034 add_gs , --C22	工伤保险费本期增加	数值	(yfzgxc03)应付职工薪酬_合并	iufo_measure_data_czpl6794	m10034
bb.m10018 add_sy , --C23	生育保险费本期增加	数值	(yfzgxc03)应付职工薪酬_合并	iufo_measure_data_czpl6794	m10018
bb.m10006 add_zfgjj , --C24	住房公积金本期增加	数值	(yfzgxc03)应付职工薪酬_合并	iufo_measure_data_czpl6794	m10006
bb.m10070 add_ghjf , --C25	工会经费和职工教育经费本期增加	数值	(yfzgxc03)应付职工薪酬_合并	iufo_measure_data_czpl6794	m10070
bb.m10045 reduce_gz , --D16	工资、奖金、津贴和补贴本期减少	数值	(yfzgxc03)应付职工薪酬_合并	iufo_measure_data_czpl6794	m10045
bb.m10029 reduce_flf , --D17	职工福利费本期减少	数值	(yfzgxc03)应付职工薪酬_合并	iufo_measure_data_czpl6794	m10029
bb.m10013 reduce_sb , --D18	社会保险费本期减少	数值	(yfzgxc03)应付职工薪酬_合并	iufo_measure_data_czpl6794	m10013
bb.m10001 reduce_yiliao , --D19	其中：医疗保险费本期减少	数值	(yfzgxc03)应付职工薪酬_合并	iufo_measure_data_czpl6794	m10001
bb.m10065 reduce_yanglao , --D20	基本养老保险费本期减少	数值	(yfzgxc03)应付职工薪酬_合并	iufo_measure_data_czpl6794	m10065
bb.m10049 reduce_shiye , --D21	失业保险本期减少	数值	(yfzgxc03)应付职工薪酬_合并	iufo_measure_data_czpl6794	m10049
bb.m10033 reduce_gs , --D22	工伤保险费本期减少	数值	(yfzgxc03)应付职工薪酬_合并	iufo_measure_data_czpl6794	m10033
bb.m10017 reduce_sy , --D23	生育保险费本期减少	数值	(yfzgxc03)应付职工薪酬_合并	iufo_measure_data_czpl6794	m10017
bb.m10005 reduce_zfgjj , --D24	住房公积金本期减少	数值	(yfzgxc03)应付职工薪酬_合并	iufo_measure_data_czpl6794	m10005
bb.m10069 reduce_ghjf , --D25	工会经费和职工教育经费本期减少	数值	(yfzgxc03)应付职工薪酬_合并	iufo_measure_data_czpl6794	m10069
bb.m10044 bal_gz , --E16	工资、奖金、津贴和补贴期末余额	数值	(yfzgxc03)应付职工薪酬_合并	iufo_measure_data_czpl6794	m10044
bb.m10028 bal_flf , --E17	职工福利费期末余额	数值	(yfzgxc03)应付职工薪酬_合并	iufo_measure_data_czpl6794	m10028
bb.m10012 bal_sb , --E18	社会保险费期末余额	数值	(yfzgxc03)应付职工薪酬_合并	iufo_measure_data_czpl6794	m10012
bb.m10000 bal_yiliao , --E19	其中：医疗保险费期末余额	数值	(yfzgxc03)应付职工薪酬_合并	iufo_measure_data_czpl6794	m10000
bb.m10064 bal_yanglao , --E20	基本养老保险费期末余额	数值	(yfzgxc03)应付职工薪酬_合并	iufo_measure_data_czpl6794	m10064
bb.m10048 bal_shiye , --E21	失业保险期末余额	数值	(yfzgxc03)应付职工薪酬_合并	iufo_measure_data_czpl6794	m10048
bb.m10032 bal_gs , --E22	工伤保险费期末余额	数值	(yfzgxc03)应付职工薪酬_合并	iufo_measure_data_czpl6794	m10032
bb.m10016 bal_sy , --E23	生育保险费期末余额	数值	(yfzgxc03)应付职工薪酬_合并	iufo_measure_data_czpl6794	m10016
bb.m10004 bal_zfgjj , --E24	住房公积金期末余额	数值	(yfzgxc03)应付职工薪酬_合并	iufo_measure_data_czpl6794	m10004
bb.m10068 bal_ghjf , --E25	工会经费和职工教育经费期末余额	数值	(yfzgxc03)应付职工薪酬_合并	iufo_measure_data_czpl6794	m10068
bb.mx9dkxh  dx  --E26	合并抵销数期末余额	数值	(yfzgxc03)应付职工薪酬_合并	iufo_measure_data_czpl6794	mx9dkxh
from  IUFO_MEASPUB_0011  aa

inner join  iufo_measure_data_czpl6794  bb  
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

