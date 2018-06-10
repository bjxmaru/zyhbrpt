create or replace
package zf_spec is

  --定义包的DEBUG模式
  V_DEBUG_MODE  BOOLEAN   := true; 
  
  --定义IUFO初始化年度前的年度
  V_IUFO_INIT_YEAR       varchar2(4) := '2013' ;
  
  --定义合并报表的任务
  V_IUFO_CONSDT_TASK_CODE       iufo_hbscheme.code%type  := 1 ;  
  
  --定义合并报表的版本
  V_IUFO_CONSDT_VERSON          iufo_hbscheme.Version%type := 50001 ;  
  
  --定义合并报表的上级单位的转换自定义表名
  V_IUFO_CONSDT_NAMETRANS   bd_defdoc.name%type  := 'f_invest_org_corespond' ; 
  
  
  
/*  --定义自定义档案 ”投资明细科目对应客商“ 中 备注字段的 含义 
  --明细科目编码对应客商编码 
  V_DEFDOC_MX_KS    varchar2(1)  :=  'A'  ;  
  --相同客商编码替代   
  V_DEFDOC_KS_TD    varchar2(1)  := 'B' ;    */
 
  --定义集团主键常量 
  GROUP_ORG_PK  constant  org_group.pk_group%type := '0001991000000000033H' ; 
  
  --定义本位币的PK
  BWBPK   CONSTANT BD_CURRTYPE.PK_CURRTYPE%TYPE := 'XXXXXXXXXXXXXXXXXXXX';
  
  --新准则账簿类型
  GL_BOOK_STYLE_NEW_PK   org_setofbook.pk_setofbook%type := '10018910000000000OOF'  ; 
  --旧准则账簿类型
  GL_BOOK_STYLE_OLD_pk   org_setofbook.pk_setofbook%type := '10018910000000000OW6'  ; 
  --基建账簿类型
  GL_BOOK_STYLE_CONS_PK  org_setofbook.pk_setofbook%type := '10018910000000000P3V'  ;  
  
  
  --新准则科目体系
  ACCCHART_SYSTEM_NEW_PK     bd_accsystem.pk_accsystem%type  := '10018910000000000706' ; 
  
  --旧准则科目体系
  ACCCHART_SYSTEM_OLD_PK     bd_accsystem.pk_accsystem%type  := '10018910000000000N56' ;
  
  --基建科目体系
  ACCCHART_SYSTEM_CON_PK     bd_accsystem.pk_accsystem%type  :='10018910000000000N6A' ; 
  
  --合并报表主体体系结构PK
    PK_REPT_COMBINE_STRU org_reportcombinestru.pk_reportcombinestru%type  
     :='1001A31000000000ZUWF' ; 
     
   --管理报表主体体系结构PK 
    PK_REPT_MANG_STRU     org_reportmanastru.pk_reportmanastru%type 
    :='1001891000000000MN0J' ; 
    
   --定义重分类规则的自定义项目表的名称
   ARAP_RECLASS_RULE_NAME  VARCHAR2(200)  := 'f_arap_reclass';
   
   --定义长期股权投资明细科目对应的客商编码的 自定义项目表的名称 
   INVEST_SUBJ_CORRESPOND  VARCHAR2(200)  := 'f_invest_subj_corespond' ; 
   
   --定义长期股权投资的初始化金额对应的自定义项表的名称 
   INVEST_INIT_AMOUNT                        VARCHAR(200)   :=  'f_init_invest'  ; 
  
   --声明一个PLSQL记录类型,记录财务组织的信息情况,包含组织代码,
   --组织名称,PK,账簿PK, 会计科目表PK ,集团PK,
   --会计主体代码,会计主体名称
   TYPE rcd_org_info IS RECORD
   (INVEST_SUBJ_CORRESPOND
      pk_org          org_orgs.pk_org%type ,   --会计凭证下的主体PK
      org_code        org_orgs.code%type ,     --会计凭证下的主体代码
      org_name        org_orgs.name%type ,     --会计凭证下的主体名称
      pk_accchart     bd_accchart.pk_accchart%type,  --合并报表单位使用的会计科目表
      pk_accountingbook     ORG_ACCOUNTINGBOOK.Pk_Accountingbook%type ,   --账簿主体
      accounttype     org_setofbook.pk_setofbook%type  ,   --账簿类型
      pk_org_rcsmember  org_rcsmember.pk_rcsmember%type ,   --合并报表主体PK
      pk_rcs      org_reportcombinestru.pk_reportcombinestru%type , --合并报表主体结构主键 
      pk_org_rmsmember  org_rmsmember.pk_rmsmember%type ,  --管理报表主体PK
      pk_rms       org_reportmanastru.pk_reportmanastru%type ,  --管理报表组织体系PK
      pk_group     org_group.pk_group%type   ,   --集团主键
      pk_accsystem     bd_accsystem.pk_accsystem%type ,    --科目体系主键 
      accsystem_code  bd_accsystem.code%type    --科目体系代码
   );

   --声明一个rcd_corp_info类型的嵌套表
    TYPE nt_rcd_org_info IS TABLE OF rcd_org_info;
    
   --声明一个科目辅助核算的记录类型
   type  rcd_subj_ass_info is record 
   (
       pk_accass  bd_accass.pk_accass%type ,
       pk_accassitem  bd_accassitem.pk_accassitem%type ,
       refnodename  bd_accassitem.refnodename%type  , 
       ref_code     bd_accassitem.code%type   , 
       ref_name     bd_accassitem.name%type 
   ); 
    
   --声明一个科目辅助核算的记录类型的嵌套表类型
   type  nt_rcd_subj_ass_info is table of  rcd_subj_ass_info ; 
      
   
   --声明一个科目信息记录,记录一个特定科目代码的信息
   TYPE rcd_subj_info IS RECORD
   (
        pk_account  bd_account.pk_account%type ,
        pk_father_account  bd_account.pid%type , 
        acctype_name  bd_acctype.name%type ,
        bal_orient  bd_acctype.balanorient%type , 
        pk_chart     bd_accchart.pk_accchart%type , 
        subj_code   bd_account.code%type , 
        subj_name   bd_accasoa.name%type, 
        subj_dispname  bd_accasoa.dispname%type ,
        pk_accasoa  bd_accasoa.pk_accasoa%type ,
        end_flag    bd_accasoa.endflag%type  , 
        subj_ass_info   nt_rcd_subj_ass_info
    ) ; 
    
  --声明科目信息记录的PLSQL管理数组类型
  type  ntx_rcd_subj_info  is table of  rcd_subj_info  index by  pls_integer ;     
    
    --声明一个凭证明细记录类型,包含客商的管理档案PK
   TYPE rcd_voucher_detail_s IS RECORD
   (
      org_code            org_orgs.code%type ,
      curr                bd_currtype.code%type ,
      subjcode            bd_account.code%type ,  
      subjname            bd_accasoa.name%type ,
      DISPNAME            bd_accasoa.dispname%type ,
      value_code          bd_cust_supplier.code%TYPE,
      value_name          bd_cust_supplier.name%TYPE,
      beg_dir             CHAR (2),
      beg_quan            GL_DETAIL.DEBITQUANTITY%TYPE,
      beg_bal             GL_DETAIL.LOCALDEBITAMOUNT%TYPE,
      beg_ori_bal         GL_DETAIL.DEBITAMOUNT%TYPE,
      debitquantity       GL_DETAIL.DEBITQUANTITY%TYPE,
      creditquantity      GL_DETAIL.CREDITQUANTITY%TYPE,
      localdebitamount    GL_DETAIL.LOCALDEBITAMOUNT%TYPE,
      localcreditamount   GL_DETAIL.LOCALCREDITAMOUNT%TYPE,
      debitamount         GL_DETAIL.DEBITAMOUNT%TYPE,
      creditamount        GL_DETAIL.CREDITAMOUNT%TYPE,
      bal_dir             CHAR (2),
      bal_quan            GL_DETAIL.DEBITQUANTITY%TYPE,
      bal                 GL_DETAIL.LOCALDEBITAMOUNT%TYPE,
      bal_ori             GL_DETAIL.DEBITAMOUNT%TYPE,
      periodv             GL_DETAIL.PERIODV%TYPE DEFAULT NULL,
      yearv               GL_DETAIL.YEARV%TYPE DEFAULT NULL,
      pk_cust_sup         bd_cust_supplier.pk_cust_sup%TYPE,          --客商基本档案
      pk_org              org_orgs.pk_org%TYPE,                         --组织PK
      self_arap           VARCHAR2 (200) DEFAULT 'ar',                 
      --用作标识作用 , 当计算科目余额,不按照一级科目进行汇总并客商辅助时 ,说明 记录体中的 subjcode字段 ,是明细科目编码
      --还是客商档案的编码 ,  用作长期股权投资的明细列表时使用  ; 如为 'subjcode' , 则说明是明细科目编码 ,  如果是'cust'  ,  则
      --说明是 客商档案的编码  
      oppo_arap           VARCHAR2 (200) DEFAULT 'ar',             
      pk_accsubj          bd_account.pk_account%TYPE,                 --科目档案PK
      pk_accasoa          bd_accasoa.pk_accasoa%type ,            --科目附属信息档案PK
      pk_accchart         bd_accchart.pk_accchart%type  ,             --科目表PK 
      pk_accsystem        bd_accsystem.pk_accsystem%type ,       --科目体系
      pk_aux_fi_org       org_orgs.pk_org%type      --客商辅助档案对应的内部财务组织的PK   
  
   );
   

   --声明一个凭证明细记录类型的嵌套表
   TYPE nt_voucher_detail_s IS TABLE OF rcd_voucher_detail_s;
   
    --定义返回凭证明细记录的游标类型
    
    
    
    --声明债权债务明细表类型 
    type   rcd_arap_detail   is record (
    value_code    bd_cust_supplier.code%type , 
    value_name  bd_cust_supplier.name%type , 
    or00    gl_detail.localcreditamount%type   ,   ---应收
    pp00    gl_detail.localcreditamount%type ,   ---应付 
    op00     gl_detail.localcreditamount%type ,    --其他应收
    ar00     gl_detail.localcreditamount%type ,    --其他应付
    ap00     gl_detail.localcreditamount%type ,    -- 预收
    pr00    gl_detail.localcreditamount%type ,     -- 预付
    pp01     gl_detail.localcreditamount%type  ,  --预收款项
    br00    gl_detail.localcreditamount%type  ,     --预付款项
    pr01     gl_detail.localcreditamount%type ,    --拨付资金
    bc00    gl_detail.localcreditamount%type ,      --拨入资金
    jr00    gl_detail.localcreditamount%type  ,     --应收票据
    jp00    gl_detail.localcreditamount%type       --应付票据
    ) ; 
    
    type  nt_rcd_arap_detail  is table of   rcd_arap_detail ; 
    
    
  
    
   type  cur_voucher_detail  is ref cursor  return rcd_voucher_detail_s ; 
   
   --定义一个记录,用来存放ARAP 重分类标准  ;或是 长期股权投资明细科目对应客商编码的对照规则 ; 
   --   或是一个标准的 自定义项目的各个栏目的内容
   type rcd_reclass_arap_rule   is record (
     arap       bd_defdoc.code%type ,
     subj       bd_defdoc.name%type , 
     the_sign     bd_defdoc.shortname%type ,
     acccsystem_code bd_defdoc.memo%type, 
     name_cn    bd_defdoc.memo%type  
   );
   
    type  rcd_defdoc   is record (
     def_unit_code       bd_defdoc.code%type ,
     def_value_code       bd_defdoc.name%type , 
     def_real_value_code  bd_defdoc.shortname%type ,
     def_name      bd_defdoc.memo%type, 
     def_other     bd_defdoc.memo%type  
   );
    
    type  rcd_defdoc_hb_org   is record (
     invested_code        bd_defdoc.code%type ,
     supper_code       bd_defdoc.name%type , 
     task_name  bd_defdoc.shortname%type ,
     hb_verson     iufo_hbscheme.version%type   
     );
  
  --定义一个嵌套表类型,用来存储重分类的科目及对应的科目
  type  nt_reclass_arap_rule  is table of rcd_reclass_arap_rule index by pls_integer ; 
  type  ntx_rcd_defdoc  is table of rcd_defdoc index by pls_integer ;
  type  ntx_rcd_defdoc_hb_org  is table of rcd_defdoc_hb_org index by pls_integer ;
  
  --定义64为的字符串嵌套表
  type ntx_varchar2_64 is table of varchar2(64) index by pls_integer ; 
  
  --定义科目体系的属性记录及相关的关联数组类型 , 以及此关联数组的一个常量 
  type  rcd_subj_system_property  is record ( 
  code_length_1    pls_integer    -- 一级科目的长度 
 ) ; 
 
  type  ntx_rcd_subj_system_property is  table of  rcd_subj_system_property  index by varchar2(20) ; 
  
  v_ntx_rcd_subj_system_property  ntx_rcd_subj_system_property ;
  

  
  --报表项目对应的科目正则查询的字符串  记录类型 
  subtype  typ_chart_sys_rpt_item is varchar2(200) ; 
  subtype  typ_subj_research_para  is varchar2(200) ; 
  type  ntx_subj_para is  table of typ_subj_research_para  index by typ_chart_sys_rpt_item  ; 
  
  subtype typ_invest_rate is  number(20,8) ; 
  subtype typ_invest_date is  varchar2(6) ; 
  
  --投资比例和日期期间记录及联合数组类型
  type rcd_invest_rate is record (
  beg_date  typ_invest_date ,  --投资开始日期
  end_date  typ_invest_date ,   --投资结束日期
  invest_rate typ_invest_rate ,    -- 投资比例
  accu_invest_rate  typ_invest_rate
  ) ; 
  
  type ntx_rcd_invest_rate is table of  rcd_invest_rate  index by  pls_integer  ;  
  
  
  --投资数据记录 以及联合数组类型
  type rcd_invest_info is  record (
  invest_org_pk         org_orgs.pk_org%type ,   --投资单位 PK 
  invest_org_code       org_orgs.code%type ,     --投资单位编码 
  invest_org_name       org_orgs.name%type  ,    --投资单位名称rcd_invest_info
  invested_org_pk       org_orgs.pk_org%type ,   --被投资单位 PK
  invested_org_code     org_orgs.code%type  ,    --被投资单位编码 
  invested_org_name     org_orgs.name%type ,     --被投资单位名称 
  accu_invest_rate      typ_invest_rate   ,      --投资比例
  assessmode            org_stockinvest.assessmode%type,  --成本核算方法 
  v_ntx_rcd_invest_rate    ntx_rcd_invest_rate    --投资比例数据 
  
  ) ; 
  
  type  ntx_rcd_invest_info  is table of  rcd_invest_info  index by pls_integer;   
  
  
  
   --声明长期股权投资明细表记录类型 
    type  rcd_invest_detail   is record(
    unit_code  org_orgs.code%type ,     --投资方单位编码
    value_code  org_orgs.code%type  ,       --被投资单位编码
    value_name  org_orgs.name%type ,       ---被投资单位名称
    invest_bal   gl_detail.localcreditamount%type ,    --投资账面余额 
    invest_revenue  gl_detail.localcreditamount%type ,    --投资收益本期发生额 
    invest_rate_beg   gl_detail.debitquantity%type ,   --投资比例  期初
    invest_rate_end   gl_detail.debitquantity%type ,   --投资比例  期末
    beg_date    varchar2(8) ,    --开始投资日期
    
    the_date    typ_invest_date  ,   --每个计算期间
    curr_date   typ_invest_date  ,   --当前期间 
    
    --以下是被投资单位的所有者权益信息
    jlr_bq_bd  gl_detail.localcreditamount%type default 0 ,    --净利润   被投资方
    zbgj_bq_bd gl_detail.localcreditamount%type default 0  ,   --资本公积本期变动金额  被投资方
    zxcb_bq_bd gl_detail.localcreditamount%type default 0,     --所有的不确定 本期变动金额  被投资方(所有的其他)
    zxcb_bq_bd_r gl_detail.localcreditamount%type default 0,    --专项储备本期变动金额  被投资方
    lrfp_qt_bq_bd gl_detail.localcreditamount%type default 0,   --利润分配-其他本期变动金额  被投资方
    lrfp_glfp_bq_bd gl_detail.localcreditamount%type default 0, --利润分配 -股利分配 本期变动金额  被投资方
    sszb_bq_bd   gl_detail.localcreditamount%type default 0  ,  --实收资本-本期变动
   
    
    
    diff_yygj_tq_bq_bd gl_detail.localcreditamount%type     ,   --m10319  利润分配 - 盈余公积提取差异
    diff_fxcb_tq_bd_bd gl_detail.localcreditamount%type  ,   --m10008   利润分配 - 风险储备提取差异
    
    tzsy_bq   gl_detail.localcreditamount%type default 0,      --投资方账面确认的投资收益 
    
    syzqy_qc   gl_detail.localcreditamount%type default 0 ,    --所有者权益合计期初 
    syzqy_qm   gl_detail.localcreditamount%type default 0 ,    --所有者权益合计期末
    
    syzqy_qc_should_aft          gl_detail.localcreditamount%type default 0  , --m10233 所有者权益合计期初 差错更正,政策变更后  
    ssgd_syzqy_qc_should_aft     gl_detail.localcreditamount%type default 0,   ---- m10215 少数股东权益合计期初 差错更正,政策变更后
    syzqy_qm_should_aft          gl_detail.localcreditamount%type default 0,   ----m10058   所有者权益合计期末 差错更正, 政策变更后
    ssgd_syzqy_qm_should_aft     gl_detail.localcreditamount%type default 0 ,  ----m10084  少数股东权益合计期末  差错更正,政策变更后
    
    ssgd_qc_should  gl_detail.localcreditamount%type default 0 , --少数股东期初应该享有的份额
    ssgd_qm_should  gl_detail.localcreditamount%type default 0 , --少数股东期末应该享有的份额
    
    
    investor_qc_should  gl_detail.localcreditamount%type default 0 , --投资者期初应该享有的份额
    investor_qm_should  gl_detail.localcreditamount%type default 0 , --投资者期末应该享有的份额
    
    
    
     qt_qt_bq_bd gl_detail.localcreditamount%type default 0,  --其他-其他 本期变动    L36
     lrfp_qt_qt_bq_bd gl_detail.localcreditamount%type default 0,  --投资调整 _利润分配其他_其他 _本期    K36
     
     
     qt_ldsy_qyfbd_bq_bd gl_detail.localcreditamount%type default 0,  --其他-直接计入所有者权益的利得和损失-权益法下被投资单位其他所有者权益变动的影响 本期变动    L15
     qt_ldsy_qt_bq_bd gl_detail.localcreditamount%type default 0,  --其他-权直接计入所有者权益的利得和损失-其他 本期变动    L17
     
    
    
    
    --以下是成本法转权益法变动表的 行数据
    adj_jlr_bq_bd  gl_detail.localcreditamount%type default 0 ,    --投资调整 _ 净利润 _ 本期 
    adj_investor_jlr_bq_bd    gl_detail.localcreditamount%type default 0 ,   --投资者享有的净利润
    adj_zbgj_bq_bd gl_detail.localcreditamount%type default 0 ,    --投资调整 _资本公积 _本期
    adj_zxcb_bq_bd gl_detail.localcreditamount%type default 0,     --投资调整 _其他 _本期
    adj_zxcb_bq_bd_r gl_detail.localcreditamount%type default 0,   --投资调整 _专项储备 _本期
    adj_lrfp_qt_bq_bd gl_detail.localcreditamount%type default 0,  --投资调整 _利润分配其他 _本期
    
    adj_lrfp_glfp_bq_bd gl_detail.localcreditamount%type default 0,  --投资调整 _利润分配-股利分配 _本期
    
     adj_qt_qt_bq_bd gl_detail.localcreditamount%type default 0,  --其他-其他 本期变动    L36
     adj_lrfp_qt_qt_bq_bd gl_detail.localcreditamount%type default 0,  --投资调整 _利润分配其他_其他 _本期    K36
     
     
     adj_qt_ldsy_qyfbd_bq_bd gl_detail.localcreditamount%type default 0,  --其他-直接计入所有者权益的利得和损失-权益法下被投资单位其他所有者权益变动的影响 本期变动    L15
     adj_qt_ldsy_qt_bq_bd gl_detail.localcreditamount%type default 0,  --其他-权直接计入所有者权益的利得和损失-其他 本期变动    L17
     
  
     adj_ssgd_qt_qt_bq_bd gl_detail.localcreditamount%type default 0,  --少数股东-其他-其他 本期变动    L36
     adj_ssgd_lrfp_qt_qt_bq_bd gl_detail.localcreditamount%type default 0,  --少数股东-投资调整 _利润分配其他_其他 _本期    K36
     
     
     adj_ssgd_qt_ldsy_qyfbd_bq_bd gl_detail.localcreditamount%type default 0,  
     --少数股东 -其他-直接计入所有者权益的利得和损失-权益法下被投资单位其他所有者权益变动的影响 本期变动    L15
     adj_ssgd_qt_ldsy_qt_bq_bd gl_detail.localcreditamount%type default 0,  
     --少数股东-其他-权直接计入所有者权益的利得和损失-其他 本期变动    L17
     
    
    adj_sszb_bq_bd gl_detail.localcreditamount%type default 0,   --实收资本 ,  投资方享有的份额
    
    adj_diff_yygj_bq_bd gl_detail.localcreditamount%type default 0,    --盈余公积提取差异投资方享有的份额
    adj_diff_fxcb_bq_bd gl_detail.localcreditamount%type default 0 ,   --风险储备提取差异投资方享有的份额
    
    adj_jlr_sq_lj  gl_detail.localcreditamount%type default 0 ,    --投资调整 _ 净利润 _上期累计
    adj_zbgj_sq_lj gl_detail.localcreditamount%type default 0  ,   --投资调整 _资本公积 _上期累计
    adj_zxcb_sq_lj gl_detail.localcreditamount%type default 0,     --投资调整 _所有的不确定 _ 上期累计
    
    adj_zxcb_yygj_sq_lj gl_detail.localcreditamount%type default 0,     --投资调整 _其他中的盈余公积调整 _ 上期累计
    

    --以下是投资抵消 _少数股东权益计算明细表的数据 
    adj_ssgd_jlr_bq_bd        gl_detail.localcreditamount%type default 0 ,     --少数股东净利润 
    adj_ssgd_zbgj_bq_bd       gl_detail.localcreditamount%type default 0 ,     --少数股东资本公积变动
    adj_ssgd_zxcb_bq_bd       gl_detail.localcreditamount%type default 0 ,     --少数股东其他不确定的变动
    adj_ssgd_lrfp_qt_bq_bd    gl_detail.localcreditamount%type default 0 ,     --少数股东利润分配-其他 变动
    adj_ssgd_lrfp_glfp_bq_bd  gl_detail.localcreditamount%type default 0 ,     --少数股东利润分配 -股利分配变动
    adj_ssgd_zxcb_r_bq_bd     gl_detail.localcreditamount%type default 0 ,     --少数股东专项储备变动
    
    adj_ssgd_sszb_bq_bd       gl_detail.localcreditamount%type default 0 ,     --少数股东实收资本变动
    adj_ssgd_sszb_bd_other    gl_detail.localcreditamount%type default 0 ,     --投资比例变动引起的少数股东所有者投入变动 _其他 
     
    adj_ssgd_diff_yygj_bq_bd gl_detail.localcreditamount%type default 0,    --少数股东盈余公积提取差异投资方享有的份额
    adj_ssgd_diff_fxcb_bq_bd gl_detail.localcreditamount%type default 0 ,   --少数股东风险储备提取差异投资方享有的份额
    diff                      gl_detail.localcreditamount%type default 0 ,   --调整后长期股权投资与所有者权益的差异 
    sy                        gl_detail.localcreditamount%type default 0 ,   --商誉金额
    super_code                org_orgs.code%type   ,     --上级具有合并报表的单位编码 
    rpt_version               iufo_hbscheme.version%type default  0  ,   --报表的版本 
    adj_wqr_ceks              gl_detail.localcreditamount%type default 0  ,  --未确认超额亏损  
    adj_wqr_ceks_lst_year              gl_detail.localcreditamount%type default 0  ,  --未确认超额亏损 ， 上年的金额
    assessmode        org_stockinvest.assessmode%type     --成本核算方法
    
    ) ;  
    
    subtype  type_investee_code  is   iufo_keydetail_unit.code%type ; 
    
    --长期股权投资明细表嵌套表变量  类型 
    
    type  nt_rcd_invest_detail   is table of  rcd_invest_detail  ; 
    
    --定义股权投资明细表联合数组 类型
    
    type  ntx_rcd_invest_detail   is table of  rcd_invest_detail index by  pls_integer  ; 
  
    
end zf_spec;
/
create or replace package body zf_spec is

--使用场景:   初始化科目体系的属性 
--调用者 01:      在包体中进行初始化
--调用者 02:         
--作者 :          bieyifeng
--时间 :          2014-04-29 01:18:58 AM
procedure  p_init_subj_sys_property
is
begin 
      v_ntx_rcd_subj_system_property(zf_spec.ACCCHART_SYSTEM_NEW_PK) .code_length_1  := 4 ; 
      v_ntx_rcd_subj_system_property(zf_spec.ACCCHART_SYSTEM_OLD_PK) .code_length_1  := 4 ; 
      v_ntx_rcd_subj_system_property(zf_spec.ACCCHART_SYSTEM_CON_PK) .code_length_1  := 3 ; 

end ; 

begin
  
     --对科目体系的属性进行初始化  
     p_init_subj_sys_property ;

end zf_spec;
/
