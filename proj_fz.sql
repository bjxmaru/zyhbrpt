select rownum the_rownum  , proj_code ,  org_code, org_name,  proj_name ,
end_bal , end_capital_amount, end_reduce_bal , add_amount, add_capital_amount , 
reduce_amount, reduce_fa_amount,  beg_bal, beg_reduce_bal 
from 
(
select keyword3  proj_code ,  org_code, org_name,  proj_name ,
end_bal , end_capital_amount, end_reduce_bal , add_amount, add_capital_amount , 
reduce_amount, reduce_fa_amount,  beg_bal, beg_reduce_bal 
from 
(
select   aa.keyword3 ,  cc.code org_code , cc.name org_name,  
bb.mn4wef0 proj_name     ,  --b6
bb.m10003 end_bal ,   --c6
bb.m317d6y end_capital_amount,  --D6	��ĩ��Ϣ�ʱ������	��ֵ	(zjgc01)�ڽ�����	iufo_measure_data_h97lpn0c	
bb.m10006  end_reduce_bal ,   --E6	��ֵ׼��	��ֵ	(zjgc01)�ڽ�����	iufo_measure_data_h97lpn0c	m10006
bb.m5s480d add_amount ,   --G6	����	��ֵ	(zjgc01)�ڽ�����	iufo_measure_data_h97lpn0c	m5s480d
bb.mbgiug8  add_capital_amount,  --H6	����������Ϣ�ʱ������	��ֵ	(zjgc01)�ڽ�����	iufo_measure_data_h97lpn0c	mbgiug8
bb.mm11ca8  reduce_amount,  --I6	����	��ֵ	(zjgc01)�ڽ�����	iufo_measure_data_h97lpn0c	mm11ca8
bb.mosdnkz  reduce_fa_amount , --J6	���ڼ���ת���̶��ʲ�	��ֵ	(zjgc01)�ڽ�����	iufo_measure_data_h97lpn0c	mosdnkz
bb.m10000  beg_bal  ,  --K6	�������G6	��ֵ	(zjgc01)�ڽ�����	iufo_measure_data_h97lpn0c	m10000
bb.m10004  beg_reduce_bal    --L6	��ֵ׼��H6	��ֵ	(zjgc01)�ڽ�����	iufo_measure_data_h97lpn0c	m10004
from IUFO_MEASPUB_QPF4 aa inner join iufo_measure_data_h97lpn0c   bb   
     on(   bb.alone_id  = aa.alone_id  
           and nvl(bb.dr , 0 ) = 0 
           and nvl(aa.dr , 0) = 0 
           and  aa.keyword1 in ( macro('pk_org_list_macro_single'))
           and aa.keyword2 = parameter('year_month_param')
     )  
inner join org_financeorg  cc  
     on(  cc.pk_financeorg  = aa.keyword1 and cc.dr = 0  )
     
union all 

select   aa.keyword3 ,  cc.code org_code , cc.name org_name,  
bb.m10004 proj_name     ,  --b6
bb.m10010 end_bal ,   --C6	�������	��ֵ	(zjgc03)�ڽ�����_�ϲ�	iufo_measure_data_sk9wkaek	m10010
bb.m10003  end_capitcal_amount ,   --D6	��ĩ��Ϣ�ʱ������	��ֵ	(zjgc03)�ڽ�����_�ϲ�	iufo_measure_data_sk9wkaek	m10003
bb.m10002 end_reduce_bal ,  --E6	��ֵ׼��	��ֵ	(zjgc03)�ڽ�����_�ϲ�	iufo_measure_data_sk9wkaek	m10002
bb.m10000 add_amount ,  --G6	����	��ֵ	(zjgc03)�ڽ�����_�ϲ�	iufo_measure_data_sk9wkaek	m10000
bb.m10009  add_capital_amount,    --H6	����������Ϣ�ʱ������	��ֵ	(zjgc03)�ڽ�����_�ϲ�	iufo_measure_data_sk9wkaek	m10009
bb.m10012 reduce_amount ,   --I6	����	��ֵ	(zjgc03)�ڽ�����_�ϲ�	iufo_measure_data_sk9wkaek	m10012
bb.m10001  reduce_fa_amount,  --J6	���ڼ���ת���̶��ʲ�	��ֵ	(zjgc03)�ڽ�����_�ϲ�	iufo_measure_data_sk9wkaek	m10001
bb.m10008   beg_bal ,  --K6	�������G6	��ֵ	(zjgc03)�ڽ�����_�ϲ�	iufo_measure_data_sk9wkaek	m10008
bb.m10007  beg_reduce_bal --L6	��ֵ׼��H6	��ֵ	(zjgc03)�ڽ�����_�ϲ�	iufo_measure_data_sk9wkaek	m10007
from IUFO_MEASPUB_QPF4 aa inner join iufo_measure_data_sk9wkaek   bb   
     on(   bb.alone_id  = aa.alone_id  
           and nvl(bb.dr , 0 ) = 0 
           and nvl(aa.dr , 0) = 0 
           and  aa.keyword1 in ( macro('pk_org_list_macro_consolidate'))
           and aa.keyword2 = parameter('year_month_param')
     )  
inner join org_financeorg  cc  
     on(  cc.pk_financeorg  = aa.keyword1 and cc.dr = 0  )
 ) order by    org_code , keyword3 
)