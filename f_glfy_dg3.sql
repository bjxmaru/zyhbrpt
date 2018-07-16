
select  org_code , org_name  , 
sum(curr) curr,  
sum(last) last , 
sum(curr_dx)  curr_dx , 
sum(last_dx)  last_dx  , 
sum( decode(item , '工资'  ,curr , 0)  )  gongzi , 
sum( decode(item , '福利费'  ,curr , 0)  )  fulifei , 
sum( decode(item , '工会经费'  ,curr , 0)  ) gonghuijingfei , 
sum( decode(item , '职工教育经费'  ,curr , 0)  )  zhigongjiaoyujingfei ,
sum( decode(item , '养老保险金'  ,curr , 0)  )  yanglaobaoxianjin ,
sum( decode(item , '工伤保险金'  ,curr , 0)  )  gongshangbaoxianjin ,
sum( decode(item , '失业保险金'  ,curr , 0)  )  shiyebaoxianjin ,
sum( decode(item , '医疗保险金'  ,curr , 0)  )  yiliaobaoxianjin ,
sum( decode(item , '生育保险金'  ,curr , 0)  )  shengyubaoxianjin ,
sum( decode(item , '住房公积金'  ,curr , 0)  )  zhufanggongjijin ,
sum( decode(item , '办公费'  ,curr , 0)  )  bangongfei ,
sum( decode(item , '降温费'  ,curr , 0)  )  jiangwenfei ,
sum( decode(item , '宣传费'  ,curr , 0)  )  xuanchuanfei ,
sum( decode(item , '董事会费'  ,curr , 0)  )  gongshihuifei ,
sum( decode(item , '咨询费'  ,curr , 0)  )  zixunfei ,
sum( decode(item , '审计费'  ,curr , 0)  )  shenjifei ,
sum( decode(item , '诉讼费'  ,curr , 0)  )  susongfei ,
sum( decode(item , '党务费'  ,curr , 0)  )  dangwufei ,
sum( decode(item , '房产税'  ,curr , 0)  )  fangchanshui ,

sum( decode(item , '土地使用税'  ,curr , 0)  )  tudishiyongshui ,
sum( decode(item , '车船使用税'  ,curr , 0)  )  chechuanshiyongshui ,
sum( decode(item , '印花税'  ,curr , 0)  )  yinhuashui ,
sum( decode(item , '车辆及交通费用'  ,curr , 0)  )  cheliangjijiaotongfeiyong ,
sum( decode(item , '广告费'  ,curr , 0)  )  guanggaofei ,
sum( decode(item , '修理费'  ,curr , 0)  )  xiulifei ,
sum( decode(item , '折旧费'  ,curr , 0)  )  zhejiufei ,
sum( decode(item , '劳动保险费'  ,curr , 0)  )  laodongbaohufei ,
sum( decode(item , '业务招待费'  ,curr , 0)  )  yewuzhaodaifei ,
sum( decode(item , '通讯费'  ,curr , 0)  )  tongxunfei ,
sum( decode(item , '无形资产摊销'  ,curr , 0)  )  wuxingzichantanxiao ,
sum( decode(item , '租赁费'  ,curr , 0)  )  zulinfei ,
sum( decode(item , '会务费'  ,curr , 0)  )  huiwufei ,
sum( decode(item , '水电气费'  ,curr , 0)  )  shuidianqifei ,
sum( decode(item , '差旅费'  ,curr , 0)  )  chailvfei ,
sum( decode(item , '物业费'  ,curr , 0)  )  wuyefei ,
sum( decode(item , '评估费'  ,curr , 0)  )  pinggufei ,
sum( decode(item , '其他'  ,curr , 0)  )  qita ,
sum( decode(item , '证券公告费'  ,curr , 0)  )  zhengjuangonggaofei ,
sum( decode(item , '协会会费及年费'  ,curr , 0)  )  xiehuihuifeijinianfei ,
sum( decode(item , '残疾基金'  ,curr , 0)  )  canjirenjijin ,
sum( decode(item , '残疾人就业保障金'  ,curr , 0)  )  canjirenjiuye ,
sum( decode(item , '职工教登记管理费育经费'  ,curr , 0)  )  dengjiguanlifei ,
sum( decode(item , '辞退福利'  ,curr , 0)  )  cituifuli ,
sum( decode(item , '价格调节基金'  ,curr , 0)  )  jiagetiaojiejijin ,
sum( decode(item , '绿化费'  ,curr , 0)  )  lvhuafei ,
sum( decode(item , '低值易耗品摊销'  ,curr , 0)  )  dizhiyihaopintanxiao ,
sum( decode(item , '装修费'  ,curr , 0)  )  zhuangxiufei ,
sum( decode(item , '其他2'  ,curr , 0)  )  qita2 ,
sum( decode(item , 'curr_dx'  ,curr , 0)  )  curr_dx_sum 
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
     
union all 

select  'dx' item   , cc.code org_code , cc.name org_name  , 
0 curr , 
0 last , 
bb.mj94m8k curr_dx ,  --B23	抵销金额本期发生额B23	数值	(glfy03)管理费用_合并	iufo_measure_data_h3tfgimd	mj94m8k
bb.mced9t8 last_dx ,  --C23	抵销金额上年同期发生额C23	数值	(glfy03)管理费用_合并	iufo_measure_data_h3tfgimd	mced9t8
'dx' item_code 
from  IUFO_MEASPUB_0011  aa

inner join  iufo_measure_data_h3tfgimd  bb  
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


    
 )  group by org_code , org_name 
