select org_code ,org_name , 
rev_zy , rev_other, rev_ws, rev_zss, rev_gr ,rev_wg , rev_gf , 
cost_zy , cost_other, cost_ws, cost_zss, cost_gr ,cost_wg , cost_gf  , 
rev_dx , cost_dx  
from 
(
select cc.code org_code , cc.name org_name  , 
bb.m10011 rev_zy,  --B6	主营业务收入	数值	(yysy01)营业收入	iufo_measure_data_x7wy12x2	m10011
bb.m10003 rev_other , --B7	其他业务收入	数值	(yysy01)营业收入	iufo_measure_data_x7wy12x2	m10003
bb.mr0h1u1 rev_ws , --B15	污水处理收入	数值	(yysy01)营业收入	iufo_measure_data_x7wy12x2	mr0h1u1
bb.m9186lf rev_zss , --B16	再生水收入收入	数值	(yysy01)营业收入	iufo_measure_data_x7wy12x2	m9186lf
bb.mjw2rov rev_gr , --B17	供热销售收入	数值	(yysy01)营业收入	iufo_measure_data_x7wy12x2	mjw2rov
bb.mxnf8hu rev_wg , --B18	管网工程费收入及其他收入	数值	(yysy01)营业收入	iufo_measure_data_x7wy12x2	mxnf8hu
bb.m6zvu2n rev_gf , --B19	光伏发电收入收入	数值	(yysy01)营业收入	iufo_measure_data_x7wy12x2	m6zvu2n


bb.m10010  cost_zy ,  --C6	主营业务成本	数值	(yysy01)营业收入	iufo_measure_data_x7wy12x2	m10010
bb.m10002  cost_other ,  --C7	其他业务成本	数值	(yysy01)营业收入	iufo_measure_data_x7wy12x2	m10002
bb.m90l470 cost_ws,  --C15	污水处理成本	数值	(yysy01)营业收入	iufo_measure_data_x7wy12x2	m90l470
bb.mgv0of9 cost_zss,  --C16	再生水收入成本	数值	(yysy01)营业收入	iufo_measure_data_x7wy12x2	mgv0of9
bb.mc2iks6 cost_gr,  --C17	供热销售成本	数值	(yysy01)营业收入	iufo_measure_data_x7wy12x2	mc2iks6
bb.mbci6bt cost_wg , --C18	管网工程费收入及其他成本	数值	(yysy01)营业收入	iufo_measure_data_x7wy12x2	mbci6bt
bb.mgf3hnr cost_gf , --C19	光伏发电收入成本	数值	(yysy01)营业收入	iufo_measure_data_x7wy12x2	mgf3hnr
0 rev_dx , 
0 cost_dx  



from  IUFO_MEASPUB_0011  aa

inner join  iufo_measure_data_x7wy12x2  bb  
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
bb.m10011 rev_zy,  --B6	主营业务收入	数值	(yysr03)营业收入_合并	iufo_measure_data_5khk6mbh	m10011
bb.m10003 rev_other , --B7	其他业务收入	数值	(yysr03)营业收入_合并	iufo_measure_data_5khk6mbh	m10003
bb.ma6nane rev_ws , --B15	污水处理收入	数值	(yysr03)营业收入_合并	iufo_measure_data_5khk6mbh	ma6nane
bb.mmapbip rev_zss , --B16	再生水收入收入	数值	(yysr03)营业收入_合并	iufo_measure_data_5khk6mbh	mmapbip
bb.m3p9ut1 rev_gr , --B17	供热销售收入	数值	(yysr03)营业收入_合并	iufo_measure_data_5khk6mbh	m3p9ut1
bb.m7oqls2 rev_wg , --B18	管网工程费收入及其他收入	数值	(yysr03)营业收入_合并	iufo_measure_data_5khk6mbh	m7oqls2
bb.mifht7b rev_gf , --B19	光伏发电收入收入	数值	(yysr03)营业收入_合并	iufo_measure_data_5khk6mbh	mifht7b

bb.m10010  cost_zy ,  --C6	主营业务成本	数值	(yysr03)营业收入_合并	iufo_measure_data_5khk6mbh	m10010
bb.m10002  cost_other ,  --C7	其他业务成本	数值	(yysr03)营业收入_合并	iufo_measure_data_5khk6mbh	m10002
bb.mkjft76 cost_ws,  --C15	污水处理成本	数值	(yysr03)营业收入_合并	iufo_measure_data_5khk6mbh	mkjft76
bb.mv0edzs cost_zss,  --C16	再生水收入成本	数值	(yysr03)营业收入_合并	iufo_measure_data_5khk6mbh	mv0edzs
bb.mldhsow cost_gr,  --C17	供热销售成本	数值	(yysr03)营业收入_合并	iufo_measure_data_5khk6mbh	mldhsow
bb.mbavvyq cost_wg , --C18	管网工程费收入及其他成本	数值	(yysr03)营业收入_合并	iufo_measure_data_5khk6mbh	mbavvyq
bb.mtahh02 cost_gf , --C19	光伏发电收入成本	数值	(yysr03)营业收入_合并	iufo_measure_data_5khk6mbh	mtahh02

bb.mvczpa5 rev_dx ,  --B8	抵销金额收入	数值	(yysr03)营业收入_合并	iufo_measure_data_5khk6mbh	mvczpa5
bb.m7xqme4 cost_dx   --C8	抵销金额成本	数值	(yysr03)营业收入_合并	iufo_measure_data_5khk6mbh	m7xqme4


from  IUFO_MEASPUB_0011  aa

inner join  iufo_measure_data_5khk6mbh  bb  
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
     
     
