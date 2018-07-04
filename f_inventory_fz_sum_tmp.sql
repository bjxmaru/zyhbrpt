select 
sum(beg_bal_ycl) beg_bal_ycl , 
sum(beg_bal_dzyhp) beg_bal_dzyhp , 
sum(beg_bal_sccb) beg_bal_sccb , 
sum(beg_bal_zzfy) beg_bal_zzfy , 
sum(beg_bal_clcg) beg_bal_clcg , 
sum(bal_add_ycl) bal_add_ycl , 
sum(bal_add_dzyhp) bal_add_dzyhp , 
sum(bal_add_sccb) bal_add_sccb , 
sum(bal_add_zzfy) bal_add_zzfy , 
sum(bal_add_clcg) bal_add_clcg , 
sum(bal_reduce_ycl) bal_reduce_ycl , 
sum(bal_reduce_dzyhp) bal_reduce_dzyhp ,
sum(bal_reduce_sccb) bal_reduce_sccb , 
sum(bal_reduce_zzfy) bal_reduce_zzfy , 
sum(bal_reduce_clcg) bal_reduce_clcg , 
sum(end_bal_ycl) end_bal_ycl , 
sum(end_bal_dzyhp) end_bal_dzyhp , 
sum(end_bal_sccb) end_bal_sccb ,
sum(end_bal_zzfy) end_bal_zzfy ,
sum(end_bal_clcg)end_bal_clcg , 
sum(beg_bal_dx) beg_bal_dx ,
sum(end_bal_dx) end_bal_dx

from 
(
select cc.code org_code ,cc.name org_name ,  
bb.mxmv94v beg_bal_ycl , -- D6	原材料账面余额	数值	(ch01)存货	iufo_measure_data_chq22izl	mxmv94v
bb.mgog23i beg_bal_dzyhp,  --D7	低值易耗品账面余额	数值	(ch01)存货	iufo_measure_data_chq22izl	mgog23i
bb.mhufnoc beg_bal_sccb , --D12	生产成本账面余额	数值	(ch01)存货	iufo_measure_data_chq22izl	mhufnoc
bb.mpzpwkh beg_bal_zzfy, --D13	制造费用账面余额	数值	(ch01)存货	iufo_measure_data_chq22izl	mpzpwkh
bb.my9mlsr beg_bal_clcg ,--D14	材料采购账面余额	数值	(ch01)存货	iufo_measure_data_chq22izl	my9mlsr
bb.mfyq0h2 bal_add_ycl , --G6	原材料账面	数值	(ch01)存货	iufo_measure_data_chq22izl	mfyq0h2
bb.mtmvir1 bal_add_dzyhp , -- G7	低值易耗品账面	数值	(ch01)存货	iufo_measure_data_chq22izl	mtmvir1
bb.mn073iv bal_add_sccb ,  --G12	生产成本账面	数值	(ch01)存货	iufo_measure_data_chq22izl	mn073iv 
bb.mo0pdgs bal_add_zzfy ,  --G13	制造费用账面	数值	(ch01)存货	iufo_measure_data_chq22izl	mo0pdgs
bb.mu2yezs bal_add_clcg ,  --G14	材料采购账面	数值	(ch01)存货	iufo_measure_data_chq22izl	mu2yezs
bb.mi89gbp bal_reduce_ycl ,  --I6	原材料账面I6	数值	(ch01)存货	iufo_measure_data_chq22izl	mi89gbp 
bb.mnnuahm bal_reduce_dzyhp ,  --I7	低值易耗品账面I7	数值	(ch01)存货	iufo_measure_data_chq22izl	mnnuahm
bb.m9q829h bal_reduce_sccb ,  --I12	生产成本账面I12	数值	(ch01)存货	iufo_measure_data_chq22izl	m9q829h
bb.mdh1ibh bal_reduce_zzfy ,  --I13	制造费用账面I13	数值	(ch01)存货	iufo_measure_data_chq22izl	mdh1ibh
bb.mh89g4c bal_reduce_clcg ,  --I14	材料采购账面I14	数值	(ch01)存货	iufo_measure_data_chq22izl	mh89g4c
bb.mxudt50 end_bal_ycl ,  --K6	原材料账面余额K6	数值	(ch01)存货	iufo_measure_data_chq22izl	mxudt50
bb.m65g6n9 end_bal_dzyhp ,  --K7	低值易耗品账面余额K7	数值	(ch01)存货	iufo_measure_data_chq22izl	m65g6n9
bb.mo753w9 end_bal_sccb ,  --K12	生产成本账面余额K12	数值	(ch01)存货	iufo_measure_data_chq22izl	mo753w9 
bb.mpba7fj end_bal_zzfy ,  --K13	制造费用账面余额K13	数值	(ch01)存货	iufo_measure_data_chq22izl	mpba7fj
bb.m1haj8b end_bal_clcg  ,  --K14	材料采购账面余额K14	数值	(ch01)存货	iufo_measure_data_chq22izl	m1haj
0  beg_bal_dx ,
0  end_bal_dx 
from  IUFO_MEASPUB_0011  aa


inner join  iufo_measure_data_chq22izl  bb  
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
bb.m10037 beg_bal_ycl , -- D6	原材料账面余额	数值	(ch03)存货_合并	iufo_measure_data_30qeyige	m10037
bb.m10023 beg_bal_dzyhp,  --D7	低值易耗品账面余额	数值	(ch03)存货_合并	iufo_measure_data_30qeyige	m10023
bb.m10040 beg_bal_sccb , --D12	生产成本账面余额	数值	(ch03)存货_合并	iufo_measure_data_30qeyige	m10040
bb.m10097 beg_bal_zzfy, --D13	制造费用账面余额	数值	(ch03)存货_合并	iufo_measure_data_30qeyige	m10097
bb.m10081 beg_bal_clcg ,--D14	材料采购账面余额	数值	(ch03)存货_合并	iufo_measure_data_30qeyige	m10081

bb.m10032 bal_add_ycl , --G6	原材料账面	数值	(ch03)存货_合并	iufo_measure_data_30qeyige	m10032
bb.m10005 bal_add_dzyhp , -- G7	低值易耗品账面	数值	(ch03)存货_合并	iufo_measure_data_30qeyige	m10005
bb.m10069 bal_add_sccb ,  --G12	生产成本账面	数值	(ch03)存货_合并	iufo_measure_data_30qeyige	m10069
bb.m10044 bal_add_zzfy ,  --G13	制造费用账面	数值	(ch03)存货_合并	iufo_measure_data_30qeyige	m10044
bb.m10034 bal_add_clcg ,  --G14	材料采购账面	数值	(ch03)存货_合并	iufo_measure_data_30qeyige	m10034
bb.m10013 bal_reduce_ycl ,  --I6	原材料账面I6	数值	(ch03)存货_合并	iufo_measure_data_30qeyige	m10013
bb.m10028 bal_reduce_dzyhp ,  --I7	低值易耗品账面I7	数值	(ch03)存货_合并	iufo_measure_data_30qeyige	m10028
bb.m10020 bal_reduce_sccb ,  --I12	生产成本账面I12	数值	(ch03)存货_合并	iufo_measure_data_30qeyige	m10020
bb.m10042 bal_reduce_zzfy ,  --I13	制造费用账面I13	数值	(ch03)存货_合并	iufo_measure_data_30qeyige	m10042
bb.m10015 bal_reduce_clcg ,  --I14	材料采购账面I14	数值	(ch03)存货_合并	iufo_measure_data_30qeyige	m10015
bb.m10068 end_bal_ycl ,  --K6	原材料账面余额K6	数值	(ch03)存货_合并	iufo_measure_data_30qeyige	m10068
bb.m10091 end_bal_dzyhp ,  --K7	低值易耗品账面余额K7	数值	(ch03)存货_合并	iufo_measure_data_30qeyige	m10091
bb.m10012 end_bal_sccb ,  --K12	生产成本账面余额K12	数值	(ch03)存货_合并	iufo_measure_data_30qeyige	m10012
bb.m10053 end_bal_zzfy ,  --K13	制造费用账面余额K13	数值	(ch03)存货_合并	iufo_measure_data_30qeyige	m10053
bb.m10079 end_bal_clcg  ,  --K14	材料采购账面余额K14	数值	(ch03)存货_合并	iufo_measure_data_30qeyige	m10079
bb.mvc4wi1  beg_bal_dx ,--D15	合并抵销账面余额	数值	(ch03)存货_合并	iufo_measure_data_30qeyige	mvc4wi1
bb.moly1ar  end_bal_dx   --K15	合并抵销账面余额K15	数值	(ch03)存货_合并	iufo_measure_data_30qeyige	moly1ar
       
from  IUFO_MEASPUB_0011  aa

inner join  iufo_measure_data_30qeyige  bb  
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
