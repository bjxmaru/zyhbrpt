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


