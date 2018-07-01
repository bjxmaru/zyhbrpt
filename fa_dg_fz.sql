select cc.code org_code , cc.name org_name,  
       bb.m10134  fa_beg_bal_building,
       bb.m10033  fa_val_add_pur_building,
       bb.m10035  fa_val_add_cons_building,
       bb.m10141  fa_val_add_hb_building,
       bb.m10055  fa_val_add_other_building,
       bb.m10036  fa_val_add_dd_building,
       bb.m10044  fa_val_red_bf_building,
       bb.m10104  fa_val_red_qt_building,
       bb.m10098  fa_val_red_dd_building,
       
       bb.m10100  fa_accu_beg_bal_building,
       bb.m10045  fa_accu_add_jt_building,
       bb.msi7myi fa_accu_add_pur_building ,     --B22	购买等增加房屋及建筑物	数值	(gdzc01)固定资产	iufo_measure_data_mhbwibih	msi7myi
       bb.m10023  fa_accu_add_dd_building , 
       bb.m10126  fa_accu_red_bf_building , 
       bb.m10007  fa_accu_red_other_building , 
       bb.m10110  fa_accu_red_dd_building  ,
       bb.m10057  fa_jzzb_beg_bal_building  ,
       bb.m10028  fa_jzzb_add_jt_building  , 
       bb.m10027  fa_jzzb_add_dd_building  , 
       bb.m10088  fa_jzzb_red_bf_building  , 
       bb.m10112  fa_jzzb_red_dd_building  , 
  
       bb.m10146  fa_beg_bal_machine ,    --c6
       bb.m10010  fa_bal_add_pur_machine  ,  --c8
       bb.m10071  fa_bal_add_cons_machine  ,  --c9
       bb.m10105  fa_bal_add_hb_machine  ,  --c10
       bb.m10086  fa_bal_add_other_machine  ,  --c11
       bb.m10029  fa_bal_add_dd_machine  ,  --c12
       
       bb.m10073  fa_bal_red_bf_machine  ,  --c14
       bb.m10039  fa_bal_red_other_machine  ,  --c15
       bb.m10002  fa_bal_red_dd_machine  ,  --c16
       
       bb.m10024  fa_accu_beg_bal_machine  ,  --c19
       bb.m10046  fa_accu_add_jt_machine  ,  --c21
       bb.mno382p fa_accu_add_pur_machine  ,  --C22	购买等增加机器设备	数值	(gdzc01)固定资产	iufo_measure_data_mhbwibih	mno382p
       bb.m10152  fa_accu_add_dd_machine  ,  --c22
       bb.m10116  fa_accu_red_bf_machine  ,  --c24
       bb.m10111  fa_accu_red_other_machine  ,  --c25
       bb.m10014  fa_accu_red_dd_machine  ,  --c26
       bb.m10004  fa_jzzb_beg_bal_machine  ,  --c29
       bb.m10123  fa_jzzb_add_jt_machine  ,  --c31
       bb.m10135  fa_jzzb_add_other_machine  ,  --c32
       bb.m10120  fa_jzzb_red_bf_machine  ,  --c34
       bb.m10082  fa_jzzb_red_other_machine  ,  --c35
       
       bb.m10084  fa_beg_bal_vehicle ,  --d6
       
       bb.m10087  fa_bal_add_pur_vehicle  ,  --d8
       bb.m10093  fa_bal_add_cons_vehicle  ,  --d9
       bb.m10131  fa_bal_add_hb_vehicle  ,  --d10
       bb.m10041  fa_bal_add_other_vehicle  ,  --d11
       bb.m10103  fa_bal_add_dd_vehicle  ,  --d12
        
       bb.m10000  fa_bal_red_bf_vehicle  ,  --d14
       bb.m10069  fa_bal_red_other_vehicle  ,  --d15
       bb.m10079  fa_bal_red_dd_vehicle  ,  --d16
        
        
        bb.m10070  fa_accu_beg_bal_vehicle  ,  --d19
        bb.m10017  fa_accu_add_jt_vehicle  ,  --d21
        bb.mkucuwl   fa_accu_add_pur_vehicle ,     --D22	购买等增加运输工具	数值	(gdzc01)固定资产	iufo_measure_data_mhbwibih	mkucuwl
        bb.m10127  fa_accu_add_dd_vehicle  ,  --d22

        bb.m10139  fa_accu_red_bf_vehicle  ,  --d24
        bb.m10097  fa_accu_red_other_vehicle  ,  --d25
        bb.m10050  fa_accu_red_dd_vehicle  ,  --d26
        
        
        bb.m10117  fa_jzzb_beg_bal_vehicle  ,  --d29
        bb.m10054  fa_jzzb_add_jt_vehicle  ,  --d31
        bb.m10149  fa_jzzb_add_dd_vehicle  ,  --d32
         
        bb.m10125  fa_jzzb_red_bf_vehicle  ,  --d34
        bb.m10078  fa_jzzb_red_dd_vehicle  ,  --d35
        
        bb.m10077  fa_bal_beg_other  ,  --e6
        bb.m10056  fa_bal_add_pur_other  ,  --e8
        bb.m10143  fa_bal_add_cons_other  ,  --e9
        bb.m10043  fa_bal_add_hb_other  ,  --e10
        bb.m10119  fa_bal_add_other_other  ,  --e11
        bb.m10076  fa_bal_add_dd_other  ,  --e12
        bb.m10059  fa_bal_red_bf_other  ,  --e14
        bb.m10038  fa_bal_red_other_other  ,  --e15
        bb.m10094  fa_bal_red_dd_other  ,  --e16
         
         
        bb.m10089  fa_accu_beg_bal_other  ,  --e19
        bb.m10052  fa_accu_add_jt_other  ,  --e21
        bb.mjej4mp fa_accu_add_pur_other ,     --E22	购买等增加电子设备及其他数gdzc01)固定资产	iufo_measure_data_mhbwibih	mjej4mp
        bb.m10048  fa_accu_add_dd_other  ,  --e22
         
        bb.m10065  fa_accu_red_bf_other  ,  --e24
         
        bb.m10096  fa_accu_red_other_other  ,  --e25
         
        bb.m10034  fa_accu_red_dd_other  ,  --e26
         
        bb.m10099  fa_jzzb_beg_bal_other  ,  --e29
         
        bb.m10016  fa_jzzb_add_jt_other  ,  --e31
        bb.m10058 fa_jzzb_add_dd_other  ,  --e32
         
         
        bb.m10095  fa_jzzb_red_bf_other  , --e34
        bb.m10129  fa_jzzb_red_dd_other    --e35
       
        
       
from  IUFO_MEASPUB_0011  aa

inner join  iufo_measure_data_mhbwibih  bb  
      on(
       
           bb.alone_id  = aa.alone_id  
           and nvl(bb.dr , 0 ) = 0 
           and nvl(aa.dr , 0) = 0 
           and aa.keyword1 in ( macro('pk_org_list_macro_single'))
           and aa.keyword2 = parameter('year_month_param')
      
      )    
inner join org_financeorg  cc  
     on(  cc.pk_financeorg  = aa.keyword1 and cc.dr = 0  )


select cc.code org_code , cc.name org_name,  
       bb.m10134  fa_beg_bal_building,
       bb.m10033  fa_val_add_pur_building,
       bb.m10035  fa_val_add_cons_building,
       bb.m10141  fa_val_add_hb_building,
       bb.m10055  fa_val_add_other_building,
       bb.m10036  fa_val_add_dd_building,
       bb.m10044  fa_val_red_bf_building,
       bb.m10104  fa_val_red_qt_building,
       bb.m10098  fa_val_red_dd_building,
       
       bb.m10100  fa_accu_beg_bal_building,
       bb.m10045  fa_accu_add_jt_building,
       bb.msi7myi fa_accu_add_pur_building ,     --B22	购买等增加房屋及建筑物	数值	(gdzc01)固定资产	iufo_measure_data_mhbwibih	msi7myi
       bb.m10023  fa_accu_add_dd_building , 
       bb.m10126  fa_accu_red_bf_building , 
       bb.m10007  fa_accu_red_other_building , 
       bb.m10110  fa_accu_red_dd_building  ,
       bb.m10057  fa_jzzb_beg_bal_building  ,
       bb.m10028  fa_jzzb_add_jt_building  , 
       bb.m10027  fa_jzzb_add_dd_building  , 
       bb.m10088  fa_jzzb_red_bf_building  , 
       bb.m10112  fa_jzzb_red_dd_building  , 
  
       bb.m10146  fa_beg_bal_machine ,    --c6
       bb.m10010  fa_bal_add_pur_machine  ,  --c8
       bb.m10071  fa_bal_add_cons_machine  ,  --c9
       bb.m10105  fa_bal_add_hb_machine  ,  --c10
       bb.m10086  fa_bal_add_other_machine  ,  --c11
       bb.m10029  fa_bal_add_dd_machine  ,  --c12
       
       bb.m10073  fa_bal_red_bf_machine  ,  --c14
       bb.m10039  fa_bal_red_other_machine  ,  --c15
       bb.m10002  fa_bal_red_dd_machine  ,  --c16
       
       bb.m10024  fa_accu_beg_bal_machine  ,  --c19
       bb.m10046  fa_accu_add_jt_machine  ,  --c21
       bb.mno382p fa_accu_add_pur_machine  ,  --C22	购买等增加机器设备	数值	(gdzc01)固定资产	iufo_measure_data_mhbwibih	mno382p
       bb.m10152  fa_accu_add_dd_machine  ,  --c22
       bb.m10116  fa_accu_red_bf_machine  ,  --c24
       bb.m10111  fa_accu_red_other_machine  ,  --c25
       bb.m10014  fa_accu_red_dd_machine  ,  --c26
       bb.m10004  fa_jzzb_beg_bal_machine  ,  --c29
       bb.m10123  fa_jzzb_add_jt_machine  ,  --c31
       bb.m10135  fa_jzzb_add_other_machine  ,  --c32
       bb.m10120  fa_jzzb_red_bf_machine  ,  --c34
       bb.m10082  fa_jzzb_red_other_machine  ,  --c35
       
       bb.m10084  fa_beg_bal_vehicle ,  --d6
       
       bb.m10087  fa_bal_add_pur_vehicle  ,  --d8
       bb.m10093  fa_bal_add_cons_vehicle  ,  --d9
       bb.m10131  fa_bal_add_hb_vehicle  ,  --d10
       bb.m10041  fa_bal_add_other_vehicle  ,  --d11
       bb.m10103  fa_bal_add_dd_vehicle  ,  --d12
        
       bb.m10000  fa_bal_red_bf_vehicle  ,  --d14
       bb.m10069  fa_bal_red_other_vehicle  ,  --d15
       bb.m10079  fa_bal_red_dd_vehicle  ,  --d16
        
        
        bb.m10070  fa_accu_beg_bal_vehicle  ,  --d19
        bb.m10017  fa_accu_add_jt_vehicle  ,  --d21
        bb.mkucuwl   fa_accu_add_pur_vehicle ,     --D22	购买等增加运输工具	数值	(gdzc01)固定资产	iufo_measure_data_mhbwibih	mkucuwl
        bb.m10127  fa_accu_add_dd_vehicle  ,  --d22

        bb.m10139  fa_accu_red_bf_vehicle  ,  --d24
        bb.m10097  fa_accu_red_other_vehicle  ,  --d25
        bb.m10050  fa_accu_red_dd_vehicle  ,  --d26
        
        
        bb.m10117  fa_jzzb_beg_bal_vehicle  ,  --d29
        bb.m10054  fa_jzzb_add_jt_vehicle  ,  --d31
        bb.m10149  fa_jzzb_add_dd_vehicle  ,  --d32
         
        bb.m10125  fa_jzzb_red_bf_vehicle  ,  --d34
        bb.m10078  fa_jzzb_red_dd_vehicle  ,  --d35
        
        bb.m10077  fa_bal_beg_other  ,  --e6
        bb.m10056  fa_bal_add_pur_other  ,  --e8
        bb.m10143  fa_bal_add_cons_other  ,  --e9
        bb.m10043  fa_bal_add_hb_other  ,  --e10
        bb.m10119  fa_bal_add_other_other  ,  --e11
        bb.m10076  fa_bal_add_dd_other  ,  --e12
        bb.m10059  fa_bal_red_bf_other  ,  --e14
        bb.m10038  fa_bal_red_other_other  ,  --e15
        bb.m10094  fa_bal_red_dd_other  ,  --e16
         
         
        bb.m10089  fa_accu_beg_bal_other  ,  --e19
        bb.m10052  fa_accu_add_jt_other  ,  --e21
        bb.mjej4mp fa_accu_add_pur_other ,     --E22	购买等增加电子设备及其他数gdzc01)固定资产	iufo_measure_data_mhbwibih	mjej4mp
        bb.m10048  fa_accu_add_dd_other  ,  --e22
         
        bb.m10065  fa_accu_red_bf_other  ,  --e24
         
        bb.m10096  fa_accu_red_other_other  ,  --e25
         
        bb.m10034  fa_accu_red_dd_other  ,  --e26
         
        bb.m10099  fa_jzzb_beg_bal_other  ,  --e29
         
        bb.m10016  fa_jzzb_add_jt_other  ,  --e31
        bb.m10058 fa_jzzb_add_dd_other  ,  --e32
         
         
        bb.m10095  fa_jzzb_red_bf_other  , --e34
        bb.m10129  fa_jzzb_red_dd_other     --e35
                    
       
from  IUFO_MEASPUB_0011  aa

inner join  iufo_measure_data_mhbwibih  bb  
      on(
       
           bb.alone_id  = aa.alone_id  
           and nvl(bb.dr , 0 ) = 0 
           and nvl(aa.dr , 0) = 0 
           and aa.keyword1 in ( macro('pk_org_list_macro_single'))
           and aa.keyword2 = parameter('year_month_param')
      
      )    
inner join org_financeorg  cc  
     on(  cc.pk_financeorg  = aa.keyword1 and cc.dr = 0  )
     
     
union all 


select cc.code org_code , cc.name org_name, 
 
       bb.m10078  fa_beg_bal_building, --B6	年初_房屋及建筑物_余额(gdzc03)固定资产_合并	iufo_measure_data_gd5m9yvf	m10078
       bb.m10045  fa_val_add_pur_building, --B8	本年增加_房屋及建筑物_余额_购买	数值	(gdzc03)固定资产_合并	iufo_measure_data_gd5m9yvf	m10045 
       bb.m10001  fa_val_add_cons_building, --B9	本年增加_房屋及建筑物_余额_在建工程	数值	(gdzc03)固定资产_合并	iufo_measure_data_gd5m9yvf	m10001 
       bb.m10007  fa_val_add_hb_building, --B10	本年增加_房屋及建筑物_余额_企业合并	数值	(gdzc03)固定资产_合并	iufo_measure_data_gd5m9yvf	m10007 
       bb.m10040  fa_val_add_other_building, --B11	本年增加_房屋及建筑物_余额_其他	数值	(gdzc03)固定资产_合并	iufo_measure_data_gd5m9yvf	m10040 
       bb.m10092  fa_val_add_dd_building, --B12	本年增加_房屋及建筑物_余额_待定	数值	(gdzc03)固定资产_合并	iufo_measure_data_gd5m9yvf	m10092
       bb.m10017  fa_val_red_bf_building, --B14	本年减少_房屋及建筑物_余额_报废	数值	(gdzc03)固定资产_合并	iufo_measure_data_gd5m9yvf	m10017
       bb.m10063  fa_val_red_qt_building,--B15	本年减少_房屋及建筑物_余额_其他	数值	(gdzc03)固定资产_合并	iufo_measure_data_gd5m9yvf	m10063
       bb.m10127  fa_val_red_dd_building,--B16	本年减少_房屋及建筑物_余额_待定	数值	(gdzc03)固定资产_合并	iufo_measure_data_gd5m9yvf	m10127
       
       bb.m10151  fa_accu_beg_bal_building,--B19	年初_房屋及建筑物_折旧	数值	(gdzc03)固定资产_合并	iufo_measure_data_gd5m9yvf	m10151
       bb.m10041  fa_accu_add_jt_building, --B21	本年增加_房屋及建筑物_折旧_计提	数值	(gdzc03)固定资产_合并	iufo_measure_data_gd5m9yvf	m10041
       bb.mc6gb4o fa_accu_add_pur_building ,     --B22	增加(购买,在建工程转固等方式)房屋及建筑物	数值	(gdzc03)固定资产_合并	iufo_measure_data_gd5m9yvf	mc6gb4o
       bb.m10049  fa_accu_add_dd_building , --B23	本年增加_房屋及建筑物_折旧_待定	数值	(gdzc03)固定资产_合并	iufo_measure_data_gd5m9yvf	m10049
       bb.m10016  fa_accu_red_bf_building ,  --B25	本年减少_房屋及建筑物_折旧_报废	数值	(gdzc03)固定资产_合并	iufo_measure_data_gd5m9yvf	m10016
       bb.m10125  fa_accu_red_other_building , --B26	本年减少_房屋及建筑物_折旧_其他	数值	(gdzc03)固定资产_合并	iufo_measure_data_gd5m9yvf	m10125
       bb.m10072  fa_accu_red_dd_building  , --B27	本年减少_房屋及建筑物_折旧_待定	数值	(gdzc03)固定资产_合并	iufo_measure_data_gd5m9yvf	m10072
       bb.m10121  fa_jzzb_beg_bal_building  ,--B30	年初_房屋及建筑物_减值准备	数值	(gdzc03)固定资产_合并	iufo_measure_data_gd5m9yvf	m10121
       bb.m10010  fa_jzzb_add_jt_building  , --B32	本年增加_房屋及建筑物_减值准备_计提	数值	(gdzc03)固定资产_合并	iufo_measure_data_gd5m9yvf	m10010
       bb.m10039  fa_jzzb_add_dd_building  , --B33	本年增加_房屋及建筑物_减值准备_待定	数值	(gdzc03)固定资产_合并	iufo_measure_data_gd5m9yvf	m10039
       bb.m10075  fa_jzzb_red_bf_building  , --B35	本年减少_房屋及建筑物_减值准备_报废	数值	(gdzc03)固定资产_合并	iufo_measure_data_gd5m9yvf	m10075
       bb.m10048  fa_jzzb_red_dd_building  , --B36	本年减少_房屋及建筑物_减值准备_待定	数值	(gdzc03)固定资产_合并	iufo_measure_data_gd5m9yvf	m10048
  
       bb.m10031  fa_beg_bal_machine ,    --C6	年初_机器设备_余额	数值	(gdzc03)固定资产_合并	iufo_measure_data_gd5m9yvf	m10031
       bb.m10093  fa_bal_add_pur_machine  ,  --C8	本年增加_机器设备_余额_购买	数值	(gdzc03)固定资产_合并	iufo_measure_data_gd5m9yvf	m10093
       bb.m10153  fa_bal_add_cons_machine  ,  --C9	本年增加_机器设备_余额_在建工程	数值	(gdzc03)固定资产_合并	iufo_measure_data_gd5m9yvf	m10153
       bb.m10079  fa_bal_add_hb_machine  ,  --C10	本年增加_机器设备_余额_企业合并	数值	(gdzc03)固定资产_合并	iufo_measure_data_gd5m9yvf	m10079
       bb.m10122  fa_bal_add_other_machine  ,  --C11	本年增加_机器设备_余额_其他	数值	(gdzc03)固定资产_合并	iufo_measure_data_gd5m9yvf	m10122
       bb.m10141  fa_bal_add_dd_machine  ,  --C12	本年增加_机器设备_余额_待定	数值	(gdzc03)固定资产_合并	iufo_measure_data_gd5m9yvf	m10141
       
       bb.m10022  fa_bal_red_bf_machine  ,  --C14	本年减少_机器设备_余额_报废	数值	(gdzc03)固定资产_合并	iufo_measure_data_gd5m9yvf	m10022
       bb.m10142  fa_bal_red_other_machine  ,  --C15	本年减少_机器设备_余额_其他	数值	(gdzc03)固定资产_合并	iufo_measure_data_gd5m9yvf	m10142
       bb.m10083  fa_bal_red_dd_machine  ,  --C16	本年减少_机器设备_余额_待定	数值	(gdzc03)固定资产_合并	iufo_measure_data_gd5m9yvf	m10083
       
       bb.m10138  fa_accu_beg_bal_machine  ,  --C19	年初_机器设备_折旧	数值	(gdzc03)固定资产_合并	iufo_measure_data_gd5m9yvf	m10138
       bb.m10137  fa_accu_add_jt_machine  ,  --C21	本年增加_机器设备_折旧_计提	数值	(gdzc03)固定资产_合并	iufo_measure_data_gd5m9yvf	m10137
       bb.m5q44u6 fa_accu_add_pur_machine  ,  --C22	增加(购买,在建工程转固等方式)机器设备	数值	(gdzc03)固定资产_合并	iufo_measure_data_gd5m9yvf	m5q44u6
       bb.m10101  fa_accu_add_dd_machine  ,  --C23	本年增加_机器设备_折旧_待定	数值	(gdzc03)固定资产_合并	iufo_measure_data_gd5m9yvf	m10101
       bb.m10086  fa_accu_red_bf_machine  ,  --C25	本年减少_机器设备_折旧_报废	数值	(gdzc03)固定资产_合并	iufo_measure_data_gd5m9yvf	m10086
       bb.m10118  fa_accu_red_other_machine  ,  --C26	本年减少_机器设备_折旧_其他	数值	(gdzc03)固定资产_合并	iufo_measure_data_gd5m9yvf	m10118
       bb.m10069  fa_accu_red_dd_machine  ,  --C27	本年减少_机器设备_折旧_待定	数值	(gdzc03)固定资产_合并	iufo_measure_data_gd5m9yvf	m10069
       bb.m10112  fa_jzzb_beg_bal_machine  ,  --C30	年初_机器设备_减值准备	数值	(gdzc03)固定资产_合并	iufo_measure_data_gd5m9yvf	m10112
       bb.m10145  fa_jzzb_add_jt_machine  ,  --C32	本年增加_机器设备_减值准备_计提	数值	(gdzc03)固定资产_合并	iufo_measure_data_gd5m9yvf	m10145
       bb.m10132  fa_jzzb_add_other_machine  ,  --C33	本年增加_机器设备_减值准备_待定	数值	(gdzc03)固定资产_合并	iufo_measure_data_gd5m9yvf	m10132
       bb.m10004  fa_jzzb_red_bf_machine  ,  --C35	本年减少_机器设备_减值准备_报废	数值	(gdzc03)固定资产_合并	iufo_measure_data_gd5m9yvf	m10004
       bb.m10117  fa_jzzb_red_other_machine  ,  --C36	本年减少_机器设备_减值准备_待定	数值	(gdzc03)固定资产_合并	iufo_measure_data_gd5m9yvf	m10117
       
       bb.m10113  fa_beg_bal_vehicle ,  --D6	年初_运输工具_余额	数值	(gdzc03)固定资产_合并	iufo_measure_data_gd5m9yvf	m10113
       
       bb.m10058  fa_bal_add_pur_vehicle  ,  --d8 D8	本年增加_运输工具_余额_购买	数值	(gdzc03)固定资产_合并	iufo_measure_data_gd5m9yvf	m10058
       bb.m10028  fa_bal_add_cons_vehicle  ,  --d9 D9	本年增加_运输工具_余额_在建工程	数值	(gdzc03)固定资产_合并	iufo_measure_data_gd5m9yvf	m10028
       bb.m10091  fa_bal_add_hb_vehicle  ,  --d10 D10	本年增加_运输工具_余额_企业合并	数值	(gdzc03)固定资产_合并	iufo_measure_data_gd5m9yvf	m10091
       bb.m10029  fa_bal_add_other_vehicle  ,  --D11	本年增加_运输工具_余额_其他	数值	(gdzc03)固定资产_合并	iufo_measure_data_gd5m9yvf	m10029 
       bb.m10149  fa_bal_add_dd_vehicle  ,  --D12	本年增加_运输工具_余额_待定	数值	(gdzc03)固定资产_合并	iufo_measure_data_gd5m9yvf	m10149
        
       bb.m10002  fa_bal_red_bf_vehicle  ,  --D14	本年减少_运输工具_余额_报废	数值	(gdzc03)固定资产_合并	iufo_measure_data_gd5m9yvf	m10002
       bb.m10062  fa_bal_red_other_vehicle  ,  --D15	本年减少_运输工具_余额_其他	数值	(gdzc03)固定资产_合并	iufo_measure_data_gd5m9yvf	m10062
       bb.m10095  fa_bal_red_dd_vehicle  ,  --D16	本年减少_运输工具_余额_待定	数值	(gdzc03)固定资产_合并	iufo_measure_data_gd5m9yvf	m10095
        
        
        bb.m10018  fa_accu_beg_bal_vehicle  ,  --D19	年初_运输工具_折旧	数值	(gdzc03)固定资产_合并	iufo_measure_data_gd5m9yvf	m10018
        bb.m10128  fa_accu_add_jt_vehicle  ,  --D21	本年增加_运输工具_折旧_计提	数值	(gdzc03)固定资产_合并	iufo_measure_data_gd5m9yvf	m10128
        bb.m5h0epw   fa_accu_add_pur_vehicle ,--D22	增加(购买,在建工程转固等方式)运输工具	数值	(gdzc03)固定资产_合并	iufo_measure_data_gd5m9yvf	m5h0epw
        bb.m10047  fa_accu_add_dd_vehicle  ,  --D23	本年增加_运输工具_折旧_待定	数值	(gdzc03)固定资产_合并	iufo_measure_data_gd5m9yvf	m10047

        bb.m10143  fa_accu_red_bf_vehicle  ,  --D25	本年减少_运输工具_折旧_报废	数值	(gdzc03)固定资产_合并	iufo_measure_data_gd5m9yvf	m10143
        bb.m10036  fa_accu_red_other_vehicle  ,  --D26	本年减少_运输工具_折旧_其他	数值	(gdzc03)固定资产_合并	iufo_measure_data_gd5m9yvf	m10036
        bb.m10090  fa_accu_red_dd_vehicle  ,  --D27	本年减少_运输工具_折旧_待定	数值	(gdzc03)固定资产_合并	iufo_measure_data_gd5m9yvf	m10090
        
        
        bb.m10038  fa_jzzb_beg_bal_vehicle  ,  --D30	年初_运输工具_减值准备	数值	(gdzc03)固定资产_合并	iufo_measure_data_gd5m9yvf	m10038
        bb.m10076  fa_jzzb_add_jt_vehicle  ,  --D32	本年增加_运输工具_减值准备_计提	数值	(gdzc03)固定资产_合并	iufo_measure_data_gd5m9yvf	m10076
        bb.m10081  fa_jzzb_add_dd_vehicle  ,  --D33	本年增加_运输工具_减值准备_待定	数值	(gdzc03)固定资产_合并	iufo_measure_data_gd5m9yvf	m10081
         
        bb.m10102  fa_jzzb_red_bf_vehicle  ,  --D35	本年减少_运输工具_减值准备_报废	数值	(gdzc03)固定资产_合并	iufo_measure_data_gd5m9yvf	m10102
        bb.m10068  fa_jzzb_red_dd_vehicle  ,  --D36	本年减少_运输工具_减值准备_待定	数值	(gdzc03)固定资产_合并	iufo_measure_data_gd5m9yvf	m10068
        
        bb.m10131  fa_bal_beg_other  ,  --E6	年初_电子设备_余额	数值	(gdzc03)固定资产_合并	iufo_measure_data_gd5m9yvf	m10131
        bb.m10065  fa_bal_add_pur_other  ,  --E8	本年增加_电子设备_余额_购买	数值	(gdzc03)固定资产_合并	iufo_measure_data_gd5m9yvf	m10065
        bb.m10073  fa_bal_add_cons_other  ,  --E9	本年增加_电子设备_余额_在建工程	数值	(gdzc03)固定资产_合并	iufo_measure_data_gd5m9yvf	m10073
        bb.m10087  fa_bal_add_hb_other  ,  --E10	本年增加_电子设备_余额_企业合并	数值	(gdzc03)固定资产_合并	iufo_measure_data_gd5m9yvf	m10087
        bb.m10032  fa_bal_add_other_other  ,  --E11	本年增加_电子设备_余额_其他	数值	(gdzc03)固定资产_合并	iufo_measure_data_gd5m9yvf	m10032
        bb.m10096  fa_bal_add_dd_other  ,  --E12	本年增加_电子设备_余额_待定	数值	(gdzc03)固定资产_合并	iufo_measure_data_gd5m9yvf	m10096
        bb.m10005  fa_bal_red_bf_other  ,  --E14	本年减少_电子设备_余额_报废	数值	(gdzc03)固定资产_合并	iufo_measure_data_gd5m9yvf	m10005
        bb.m10135  fa_bal_red_other_other  ,  --E15	本年减少_电子设备_余额_其他	数值	(gdzc03)固定资产_合并	iufo_measure_data_gd5m9yvf	m10135
        bb.m10077  fa_bal_red_dd_other  ,  --E16	本年减少_电子设备_余额_待定	数值	(gdzc03)固定资产_合并	iufo_measure_data_gd5m9yvf	m10077
         
         
        bb.m10020  fa_accu_beg_bal_other  ,  --E19	年初_电子设备_折旧	数值	(gdzc03)固定资产_合并	iufo_measure_data_gd5m9yvf	m10020
        bb.m10003  fa_accu_add_jt_other  ,  --E21	本年增加_电子设备_折旧_计提	数值	(gdzc03)固定资产_合并	iufo_measure_data_gd5m9yvf	m10003
        bb.m5ptvjv fa_accu_add_pur_other ,     --E22	增加(购买,在建工程转固等方式)电子设备及其他	数值	(gdzc03)固定资产_合并	iufo_measure_data_gd5m9yvf	m5ptvjv
        bb.m10051  fa_accu_add_dd_other  ,  --E23	本年增加_电子设备_折旧_待定	数值	(gdzc03)固定资产_合并	iufo_measure_data_gd5m9yvf	m10051
         
        bb.m10150  fa_accu_red_bf_other  ,  --E25	本年减少_电子设备_折旧_报废	数值	(gdzc03)固定资产_合并	iufo_measure_data_gd5m9yvf	m10150
         
        bb.m10025  fa_accu_red_other_other  ,  --E26	本年减少_电子设备_折旧_其他	数值	(gdzc03)固定资产_合并	iufo_measure_data_gd5m9yvf	m10025
         
        bb.m10023  fa_accu_red_dd_other  ,  --E27	本年减少_电子设备_折旧_待定	数值	(gdzc03)固定资产_合并	iufo_measure_data_gd5m9yvf	m10023
         
        bb.m10082  fa_jzzb_beg_bal_other  ,  --E30	年初_电子设备_减值准备	数值	(gdzc03)固定资产_合并	iufo_measure_data_gd5m9yvf	m10082
         
        bb.m10084  fa_jzzb_add_jt_other  ,  --E32	本年增加_电子设备_减值准备_计提	数值	(gdzc03)固定资产_合并	iufo_measure_data_gd5m9yvf	m10084
        bb.m10030 fa_jzzb_add_dd_other  ,  --E33	本年增加_电子设备_减值准备_待定	数值	(gdzc03)固定资产_合并	iufo_measure_data_gd5m9yvf	m10030
         
         
        bb.m10104  fa_jzzb_red_bf_other  , --E35	本年减少_电子设备_减值准备_报废	数值	(gdzc03)固定资产_合并	iufo_measure_data_gd5m9yvf	m10104
        bb.m10130  fa_jzzb_red_dd_other     --E36	本年减少_电子设备_减值准备_待定	数值	(gdzc03)固定资产_合并	iufo_measure_data_gd5m9yvf	m10130
                    
       
from  IUFO_MEASPUB_0011  aa

inner join  iufo_measure_data_gd5m9yvf  bb  
      on(
       
           bb.alone_id  = aa.alone_id  
           and nvl(bb.dr , 0 ) = 0 
           and nvl(aa.dr , 0) = 0 
           and aa.keyword1 in ( macro('pk_org_list_macro_consolidate'))
           and aa.keyword2 = parameter('year_month_param')
      
      )    
inner join org_financeorg  cc  
     on(  cc.pk_financeorg  = aa.keyword1 and cc.dr = 0  )


