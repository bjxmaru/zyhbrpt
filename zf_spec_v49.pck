create or replace
package zf_spec is

  --�������DEBUGģʽ
  V_DEBUG_MODE  BOOLEAN   := true; 
  
  --����IUFO��ʼ�����ǰ�����
  V_IUFO_INIT_YEAR       varchar2(4) := '2013' ;
  
  --����ϲ����������
  V_IUFO_CONSDT_TASK_CODE       iufo_hbscheme.code%type  := 1 ;  
  
  --����ϲ�����İ汾
  V_IUFO_CONSDT_VERSON          iufo_hbscheme.Version%type := 50001 ;  
  
  --����ϲ�������ϼ���λ��ת���Զ������
  V_IUFO_CONSDT_NAMETRANS   bd_defdoc.name%type  := 'f_invest_org_corespond' ; 
  
  
  
/*  --�����Զ��嵵�� ��Ͷ����ϸ��Ŀ��Ӧ���̡� �� ��ע�ֶε� ���� 
  --��ϸ��Ŀ�����Ӧ���̱��� 
  V_DEFDOC_MX_KS    varchar2(1)  :=  'A'  ;  
  --��ͬ���̱������   
  V_DEFDOC_KS_TD    varchar2(1)  := 'B' ;    */
 
  --���弯���������� 
  GROUP_ORG_PK  constant  org_group.pk_group%type := '0001991000000000033H' ; 
  
  --���屾λ�ҵ�PK
  BWBPK   CONSTANT BD_CURRTYPE.PK_CURRTYPE%TYPE := 'XXXXXXXXXXXXXXXXXXXX';
  
  --��׼���˲�����
  GL_BOOK_STYLE_NEW_PK   org_setofbook.pk_setofbook%type := '10018910000000000OOF'  ; 
  --��׼���˲�����
  GL_BOOK_STYLE_OLD_pk   org_setofbook.pk_setofbook%type := '10018910000000000OW6'  ; 
  --�����˲�����
  GL_BOOK_STYLE_CONS_PK  org_setofbook.pk_setofbook%type := '10018910000000000P3V'  ;  
  
  
  --��׼���Ŀ��ϵ
  ACCCHART_SYSTEM_NEW_PK     bd_accsystem.pk_accsystem%type  := '10018910000000000706' ; 
  
  --��׼���Ŀ��ϵ
  ACCCHART_SYSTEM_OLD_PK     bd_accsystem.pk_accsystem%type  := '10018910000000000N56' ;
  
  --������Ŀ��ϵ
  ACCCHART_SYSTEM_CON_PK     bd_accsystem.pk_accsystem%type  :='10018910000000000N6A' ; 
  
  --�ϲ�����������ϵ�ṹPK
    PK_REPT_COMBINE_STRU org_reportcombinestru.pk_reportcombinestru%type  
     :='1001A31000000000ZUWF' ; 
     
   --������������ϵ�ṹPK 
    PK_REPT_MANG_STRU     org_reportmanastru.pk_reportmanastru%type 
    :='1001891000000000MN0J' ; 
    
   --�����ط��������Զ�����Ŀ�������
   ARAP_RECLASS_RULE_NAME  VARCHAR2(200)  := 'f_arap_reclass';
   
   --���峤�ڹ�ȨͶ����ϸ��Ŀ��Ӧ�Ŀ��̱���� �Զ�����Ŀ������� 
   INVEST_SUBJ_CORRESPOND  VARCHAR2(200)  := 'f_invest_subj_corespond' ; 
   
   --���峤�ڹ�ȨͶ�ʵĳ�ʼ������Ӧ���Զ����������� 
   INVEST_INIT_AMOUNT                        VARCHAR(200)   :=  'f_init_invest'  ; 
  
   --����һ��PLSQL��¼����,��¼������֯����Ϣ���,������֯����,
   --��֯����,PK,�˲�PK, ��ƿ�Ŀ��PK ,����PK,
   --����������,�����������
   TYPE rcd_org_info IS RECORD
   (INVEST_SUBJ_CORRESPOND
      pk_org          org_orgs.pk_org%type ,   --���ƾ֤�µ�����PK
      org_code        org_orgs.code%type ,     --���ƾ֤�µ��������
      org_name        org_orgs.name%type ,     --���ƾ֤�µ���������
      pk_accchart     bd_accchart.pk_accchart%type,  --�ϲ�����λʹ�õĻ�ƿ�Ŀ��
      pk_accountingbook     ORG_ACCOUNTINGBOOK.Pk_Accountingbook%type ,   --�˲�����
      accounttype     org_setofbook.pk_setofbook%type  ,   --�˲�����
      pk_org_rcsmember  org_rcsmember.pk_rcsmember%type ,   --�ϲ���������PK
      pk_rcs      org_reportcombinestru.pk_reportcombinestru%type , --�ϲ���������ṹ���� 
      pk_org_rmsmember  org_rmsmember.pk_rmsmember%type ,  --����������PK
      pk_rms       org_reportmanastru.pk_reportmanastru%type ,  --��������֯��ϵPK
      pk_group     org_group.pk_group%type   ,   --��������
      pk_accsystem     bd_accsystem.pk_accsystem%type ,    --��Ŀ��ϵ���� 
      accsystem_code  bd_accsystem.code%type    --��Ŀ��ϵ����
   );

   --����һ��rcd_corp_info���͵�Ƕ�ױ�
    TYPE nt_rcd_org_info IS TABLE OF rcd_org_info;
    
   --����һ����Ŀ��������ļ�¼����
   type  rcd_subj_ass_info is record 
   (
       pk_accass  bd_accass.pk_accass%type ,
       pk_accassitem  bd_accassitem.pk_accassitem%type ,
       refnodename  bd_accassitem.refnodename%type  , 
       ref_code     bd_accassitem.code%type   , 
       ref_name     bd_accassitem.name%type 
   ); 
    
   --����һ����Ŀ��������ļ�¼���͵�Ƕ�ױ�����
   type  nt_rcd_subj_ass_info is table of  rcd_subj_ass_info ; 
      
   
   --����һ����Ŀ��Ϣ��¼,��¼һ���ض���Ŀ�������Ϣ
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
    
  --������Ŀ��Ϣ��¼��PLSQL������������
  type  ntx_rcd_subj_info  is table of  rcd_subj_info  index by  pls_integer ;     
    
    --����һ��ƾ֤��ϸ��¼����,�������̵Ĺ�����PK
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
      pk_cust_sup         bd_cust_supplier.pk_cust_sup%TYPE,          --���̻�������
      pk_org              org_orgs.pk_org%TYPE,                         --��֯PK
      self_arap           VARCHAR2 (200) DEFAULT 'ar',                 
      --������ʶ���� , �������Ŀ���,������һ����Ŀ���л��ܲ����̸���ʱ ,˵�� ��¼���е� subjcode�ֶ� ,����ϸ��Ŀ����
      --���ǿ��̵����ı��� ,  �������ڹ�ȨͶ�ʵ���ϸ�б�ʱʹ��  ; ��Ϊ 'subjcode' , ��˵������ϸ��Ŀ���� ,  �����'cust'  ,  ��
      --˵���� ���̵����ı���  
      oppo_arap           VARCHAR2 (200) DEFAULT 'ar',             
      pk_accsubj          bd_account.pk_account%TYPE,                 --��Ŀ����PK
      pk_accasoa          bd_accasoa.pk_accasoa%type ,            --��Ŀ������Ϣ����PK
      pk_accchart         bd_accchart.pk_accchart%type  ,             --��Ŀ��PK 
      pk_accsystem        bd_accsystem.pk_accsystem%type ,       --��Ŀ��ϵ
      pk_aux_fi_org       org_orgs.pk_org%type      --���̸���������Ӧ���ڲ�������֯��PK   
  
   );
   

   --����һ��ƾ֤��ϸ��¼���͵�Ƕ�ױ�
   TYPE nt_voucher_detail_s IS TABLE OF rcd_voucher_detail_s;
   
    --���巵��ƾ֤��ϸ��¼���α�����
    
    
    
    --����ծȨծ����ϸ������ 
    type   rcd_arap_detail   is record (
    value_code    bd_cust_supplier.code%type , 
    value_name  bd_cust_supplier.name%type , 
    or00    gl_detail.localcreditamount%type   ,   ---Ӧ��
    pp00    gl_detail.localcreditamount%type ,   ---Ӧ�� 
    op00     gl_detail.localcreditamount%type ,    --����Ӧ��
    ar00     gl_detail.localcreditamount%type ,    --����Ӧ��
    ap00     gl_detail.localcreditamount%type ,    -- Ԥ��
    pr00    gl_detail.localcreditamount%type ,     -- Ԥ��
    pp01     gl_detail.localcreditamount%type  ,  --Ԥ�տ���
    br00    gl_detail.localcreditamount%type  ,     --Ԥ������
    pr01     gl_detail.localcreditamount%type ,    --�����ʽ�
    bc00    gl_detail.localcreditamount%type ,      --�����ʽ�
    jr00    gl_detail.localcreditamount%type  ,     --Ӧ��Ʊ��
    jp00    gl_detail.localcreditamount%type       --Ӧ��Ʊ��
    ) ; 
    
    type  nt_rcd_arap_detail  is table of   rcd_arap_detail ; 
    
    
  
    
   type  cur_voucher_detail  is ref cursor  return rcd_voucher_detail_s ; 
   
   --����һ����¼,�������ARAP �ط����׼  ;���� ���ڹ�ȨͶ����ϸ��Ŀ��Ӧ���̱���Ķ��չ��� ; 
   --   ����һ����׼�� �Զ�����Ŀ�ĸ�����Ŀ������
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
  
  --����һ��Ƕ�ױ�����,�����洢�ط���Ŀ�Ŀ����Ӧ�Ŀ�Ŀ
  type  nt_reclass_arap_rule  is table of rcd_reclass_arap_rule index by pls_integer ; 
  type  ntx_rcd_defdoc  is table of rcd_defdoc index by pls_integer ;
  type  ntx_rcd_defdoc_hb_org  is table of rcd_defdoc_hb_org index by pls_integer ;
  
  --����64Ϊ���ַ���Ƕ�ױ�
  type ntx_varchar2_64 is table of varchar2(64) index by pls_integer ; 
  
  --�����Ŀ��ϵ�����Լ�¼����صĹ����������� , �Լ��˹��������һ������ 
  type  rcd_subj_system_property  is record ( 
  code_length_1    pls_integer    -- һ����Ŀ�ĳ��� 
 ) ; 
 
  type  ntx_rcd_subj_system_property is  table of  rcd_subj_system_property  index by varchar2(20) ; 
  
  v_ntx_rcd_subj_system_property  ntx_rcd_subj_system_property ;
  

  
  --������Ŀ��Ӧ�Ŀ�Ŀ�����ѯ���ַ���  ��¼���� 
  subtype  typ_chart_sys_rpt_item is varchar2(200) ; 
  subtype  typ_subj_research_para  is varchar2(200) ; 
  type  ntx_subj_para is  table of typ_subj_research_para  index by typ_chart_sys_rpt_item  ; 
  
  subtype typ_invest_rate is  number(20,8) ; 
  subtype typ_invest_date is  varchar2(6) ; 
  
  --Ͷ�ʱ����������ڼ��¼��������������
  type rcd_invest_rate is record (
  beg_date  typ_invest_date ,  --Ͷ�ʿ�ʼ����
  end_date  typ_invest_date ,   --Ͷ�ʽ�������
  invest_rate typ_invest_rate ,    -- Ͷ�ʱ���
  accu_invest_rate  typ_invest_rate
  ) ; 
  
  type ntx_rcd_invest_rate is table of  rcd_invest_rate  index by  pls_integer  ;  
  
  
  --Ͷ�����ݼ�¼ �Լ�������������
  type rcd_invest_info is  record (
  invest_org_pk         org_orgs.pk_org%type ,   --Ͷ�ʵ�λ PK 
  invest_org_code       org_orgs.code%type ,     --Ͷ�ʵ�λ���� 
  invest_org_name       org_orgs.name%type  ,    --Ͷ�ʵ�λ����rcd_invest_info
  invested_org_pk       org_orgs.pk_org%type ,   --��Ͷ�ʵ�λ PK
  invested_org_code     org_orgs.code%type  ,    --��Ͷ�ʵ�λ���� 
  invested_org_name     org_orgs.name%type ,     --��Ͷ�ʵ�λ���� 
  accu_invest_rate      typ_invest_rate   ,      --Ͷ�ʱ���
  assessmode            org_stockinvest.assessmode%type,  --�ɱ����㷽�� 
  v_ntx_rcd_invest_rate    ntx_rcd_invest_rate    --Ͷ�ʱ������� 
  
  ) ; 
  
  type  ntx_rcd_invest_info  is table of  rcd_invest_info  index by pls_integer;   
  
  
  
   --�������ڹ�ȨͶ����ϸ���¼���� 
    type  rcd_invest_detail   is record(
    unit_code  org_orgs.code%type ,     --Ͷ�ʷ���λ����
    value_code  org_orgs.code%type  ,       --��Ͷ�ʵ�λ����
    value_name  org_orgs.name%type ,       ---��Ͷ�ʵ�λ����
    invest_bal   gl_detail.localcreditamount%type ,    --Ͷ��������� 
    invest_revenue  gl_detail.localcreditamount%type ,    --Ͷ�����汾�ڷ����� 
    invest_rate_beg   gl_detail.debitquantity%type ,   --Ͷ�ʱ���  �ڳ�
    invest_rate_end   gl_detail.debitquantity%type ,   --Ͷ�ʱ���  ��ĩ
    beg_date    varchar2(8) ,    --��ʼͶ������
    
    the_date    typ_invest_date  ,   --ÿ�������ڼ�
    curr_date   typ_invest_date  ,   --��ǰ�ڼ� 
    
    --�����Ǳ�Ͷ�ʵ�λ��������Ȩ����Ϣ
    jlr_bq_bd  gl_detail.localcreditamount%type default 0 ,    --������   ��Ͷ�ʷ�
    zbgj_bq_bd gl_detail.localcreditamount%type default 0  ,   --�ʱ��������ڱ䶯���  ��Ͷ�ʷ�
    zxcb_bq_bd gl_detail.localcreditamount%type default 0,     --���еĲ�ȷ�� ���ڱ䶯���  ��Ͷ�ʷ�(���е�����)
    zxcb_bq_bd_r gl_detail.localcreditamount%type default 0,    --ר������ڱ䶯���  ��Ͷ�ʷ�
    lrfp_qt_bq_bd gl_detail.localcreditamount%type default 0,   --�������-�������ڱ䶯���  ��Ͷ�ʷ�
    lrfp_glfp_bq_bd gl_detail.localcreditamount%type default 0, --������� -�������� ���ڱ䶯���  ��Ͷ�ʷ�
    sszb_bq_bd   gl_detail.localcreditamount%type default 0  ,  --ʵ���ʱ�-���ڱ䶯
   
    
    
    diff_yygj_tq_bq_bd gl_detail.localcreditamount%type     ,   --m10319  ������� - ӯ�๫����ȡ����
    diff_fxcb_tq_bd_bd gl_detail.localcreditamount%type  ,   --m10008   ������� - ���մ�����ȡ����
    
    tzsy_bq   gl_detail.localcreditamount%type default 0,      --Ͷ�ʷ�����ȷ�ϵ�Ͷ������ 
    
    syzqy_qc   gl_detail.localcreditamount%type default 0 ,    --������Ȩ��ϼ��ڳ� 
    syzqy_qm   gl_detail.localcreditamount%type default 0 ,    --������Ȩ��ϼ���ĩ
    
    syzqy_qc_should_aft          gl_detail.localcreditamount%type default 0  , --m10233 ������Ȩ��ϼ��ڳ� ������,���߱����  
    ssgd_syzqy_qc_should_aft     gl_detail.localcreditamount%type default 0,   ---- m10215 �����ɶ�Ȩ��ϼ��ڳ� ������,���߱����
    syzqy_qm_should_aft          gl_detail.localcreditamount%type default 0,   ----m10058   ������Ȩ��ϼ���ĩ ������, ���߱����
    ssgd_syzqy_qm_should_aft     gl_detail.localcreditamount%type default 0 ,  ----m10084  �����ɶ�Ȩ��ϼ���ĩ  ������,���߱����
    
    ssgd_qc_should  gl_detail.localcreditamount%type default 0 , --�����ɶ��ڳ�Ӧ�����еķݶ�
    ssgd_qm_should  gl_detail.localcreditamount%type default 0 , --�����ɶ���ĩӦ�����еķݶ�
    
    
    investor_qc_should  gl_detail.localcreditamount%type default 0 , --Ͷ�����ڳ�Ӧ�����еķݶ�
    investor_qm_should  gl_detail.localcreditamount%type default 0 , --Ͷ������ĩӦ�����еķݶ�
    
    
    
     qt_qt_bq_bd gl_detail.localcreditamount%type default 0,  --����-���� ���ڱ䶯    L36
     lrfp_qt_qt_bq_bd gl_detail.localcreditamount%type default 0,  --Ͷ�ʵ��� _�����������_���� _����    K36
     
     
     qt_ldsy_qyfbd_bq_bd gl_detail.localcreditamount%type default 0,  --����-ֱ�Ӽ���������Ȩ������ú���ʧ-Ȩ�淨�±�Ͷ�ʵ�λ����������Ȩ��䶯��Ӱ�� ���ڱ䶯    L15
     qt_ldsy_qt_bq_bd gl_detail.localcreditamount%type default 0,  --����-Ȩֱ�Ӽ���������Ȩ������ú���ʧ-���� ���ڱ䶯    L17
     
    
    
    
    --�����ǳɱ���תȨ�淨�䶯��� ������
    adj_jlr_bq_bd  gl_detail.localcreditamount%type default 0 ,    --Ͷ�ʵ��� _ ������ _ ���� 
    adj_investor_jlr_bq_bd    gl_detail.localcreditamount%type default 0 ,   --Ͷ�������еľ�����
    adj_zbgj_bq_bd gl_detail.localcreditamount%type default 0 ,    --Ͷ�ʵ��� _�ʱ����� _����
    adj_zxcb_bq_bd gl_detail.localcreditamount%type default 0,     --Ͷ�ʵ��� _���� _����
    adj_zxcb_bq_bd_r gl_detail.localcreditamount%type default 0,   --Ͷ�ʵ��� _ר��� _����
    adj_lrfp_qt_bq_bd gl_detail.localcreditamount%type default 0,  --Ͷ�ʵ��� _����������� _����
    
    adj_lrfp_glfp_bq_bd gl_detail.localcreditamount%type default 0,  --Ͷ�ʵ��� _�������-�������� _����
    
     adj_qt_qt_bq_bd gl_detail.localcreditamount%type default 0,  --����-���� ���ڱ䶯    L36
     adj_lrfp_qt_qt_bq_bd gl_detail.localcreditamount%type default 0,  --Ͷ�ʵ��� _�����������_���� _����    K36
     
     
     adj_qt_ldsy_qyfbd_bq_bd gl_detail.localcreditamount%type default 0,  --����-ֱ�Ӽ���������Ȩ������ú���ʧ-Ȩ�淨�±�Ͷ�ʵ�λ����������Ȩ��䶯��Ӱ�� ���ڱ䶯    L15
     adj_qt_ldsy_qt_bq_bd gl_detail.localcreditamount%type default 0,  --����-Ȩֱ�Ӽ���������Ȩ������ú���ʧ-���� ���ڱ䶯    L17
     
  
     adj_ssgd_qt_qt_bq_bd gl_detail.localcreditamount%type default 0,  --�����ɶ�-����-���� ���ڱ䶯    L36
     adj_ssgd_lrfp_qt_qt_bq_bd gl_detail.localcreditamount%type default 0,  --�����ɶ�-Ͷ�ʵ��� _�����������_���� _����    K36
     
     
     adj_ssgd_qt_ldsy_qyfbd_bq_bd gl_detail.localcreditamount%type default 0,  
     --�����ɶ� -����-ֱ�Ӽ���������Ȩ������ú���ʧ-Ȩ�淨�±�Ͷ�ʵ�λ����������Ȩ��䶯��Ӱ�� ���ڱ䶯    L15
     adj_ssgd_qt_ldsy_qt_bq_bd gl_detail.localcreditamount%type default 0,  
     --�����ɶ�-����-Ȩֱ�Ӽ���������Ȩ������ú���ʧ-���� ���ڱ䶯    L17
     
    
    adj_sszb_bq_bd gl_detail.localcreditamount%type default 0,   --ʵ���ʱ� ,  Ͷ�ʷ����еķݶ�
    
    adj_diff_yygj_bq_bd gl_detail.localcreditamount%type default 0,    --ӯ�๫����ȡ����Ͷ�ʷ����еķݶ�
    adj_diff_fxcb_bq_bd gl_detail.localcreditamount%type default 0 ,   --���մ�����ȡ����Ͷ�ʷ����еķݶ�
    
    adj_jlr_sq_lj  gl_detail.localcreditamount%type default 0 ,    --Ͷ�ʵ��� _ ������ _�����ۼ�
    adj_zbgj_sq_lj gl_detail.localcreditamount%type default 0  ,   --Ͷ�ʵ��� _�ʱ����� _�����ۼ�
    adj_zxcb_sq_lj gl_detail.localcreditamount%type default 0,     --Ͷ�ʵ��� _���еĲ�ȷ�� _ �����ۼ�
    
    adj_zxcb_yygj_sq_lj gl_detail.localcreditamount%type default 0,     --Ͷ�ʵ��� _�����е�ӯ�๫������ _ �����ۼ�
    

    --������Ͷ�ʵ��� _�����ɶ�Ȩ�������ϸ������� 
    adj_ssgd_jlr_bq_bd        gl_detail.localcreditamount%type default 0 ,     --�����ɶ������� 
    adj_ssgd_zbgj_bq_bd       gl_detail.localcreditamount%type default 0 ,     --�����ɶ��ʱ������䶯
    adj_ssgd_zxcb_bq_bd       gl_detail.localcreditamount%type default 0 ,     --�����ɶ�������ȷ���ı䶯
    adj_ssgd_lrfp_qt_bq_bd    gl_detail.localcreditamount%type default 0 ,     --�����ɶ��������-���� �䶯
    adj_ssgd_lrfp_glfp_bq_bd  gl_detail.localcreditamount%type default 0 ,     --�����ɶ�������� -��������䶯
    adj_ssgd_zxcb_r_bq_bd     gl_detail.localcreditamount%type default 0 ,     --�����ɶ�ר����䶯
    
    adj_ssgd_sszb_bq_bd       gl_detail.localcreditamount%type default 0 ,     --�����ɶ�ʵ���ʱ��䶯
    adj_ssgd_sszb_bd_other    gl_detail.localcreditamount%type default 0 ,     --Ͷ�ʱ����䶯����������ɶ�������Ͷ��䶯 _���� 
     
    adj_ssgd_diff_yygj_bq_bd gl_detail.localcreditamount%type default 0,    --�����ɶ�ӯ�๫����ȡ����Ͷ�ʷ����еķݶ�
    adj_ssgd_diff_fxcb_bq_bd gl_detail.localcreditamount%type default 0 ,   --�����ɶ����մ�����ȡ����Ͷ�ʷ����еķݶ�
    diff                      gl_detail.localcreditamount%type default 0 ,   --�������ڹ�ȨͶ����������Ȩ��Ĳ��� 
    sy                        gl_detail.localcreditamount%type default 0 ,   --�������
    super_code                org_orgs.code%type   ,     --�ϼ����кϲ�����ĵ�λ���� 
    rpt_version               iufo_hbscheme.version%type default  0  ,   --����İ汾 
    adj_wqr_ceks              gl_detail.localcreditamount%type default 0  ,  --δȷ�ϳ������  
    adj_wqr_ceks_lst_year              gl_detail.localcreditamount%type default 0  ,  --δȷ�ϳ������ �� ����Ľ��
    assessmode        org_stockinvest.assessmode%type     --�ɱ����㷽��
    
    ) ;  
    
    subtype  type_investee_code  is   iufo_keydetail_unit.code%type ; 
    
    --���ڹ�ȨͶ����ϸ��Ƕ�ױ����  ���� 
    
    type  nt_rcd_invest_detail   is table of  rcd_invest_detail  ; 
    
    --�����ȨͶ����ϸ���������� ����
    
    type  ntx_rcd_invest_detail   is table of  rcd_invest_detail index by  pls_integer  ; 
  
    
end zf_spec;
/
create or replace package body zf_spec is

--ʹ�ó���:   ��ʼ����Ŀ��ϵ������ 
--������ 01:      �ڰ����н��г�ʼ��
--������ 02:         
--���� :          bieyifeng
--ʱ�� :          2014-04-29 01:18:58 AM
procedure  p_init_subj_sys_property
is
begin 
      v_ntx_rcd_subj_system_property(zf_spec.ACCCHART_SYSTEM_NEW_PK) .code_length_1  := 4 ; 
      v_ntx_rcd_subj_system_property(zf_spec.ACCCHART_SYSTEM_OLD_PK) .code_length_1  := 4 ; 
      v_ntx_rcd_subj_system_property(zf_spec.ACCCHART_SYSTEM_CON_PK) .code_length_1  := 3 ; 

end ; 

begin
  
     --�Կ�Ŀ��ϵ�����Խ��г�ʼ��  
     p_init_subj_sys_property ;

end zf_spec;
/
