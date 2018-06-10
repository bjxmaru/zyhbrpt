create or replace package sy_base is

  -- Author  : BJX
  -- Created : 2016/4/21 0:14:27
  -- Purpose : sy report attach plsql query

  --Ӧ�յ���������
  V_BILLTYPE_YS constant varchar2(2) := 'ys';

  --Ӧ������������
  V_BILLTYPE_YF constant varchar2(2) := 'yf';

  --�ݹ�Ӧ�յ���������
  V_BILLTYPE_WQRYS constant varchar2(2) := 'zs';

  --�տ��������
  V_BILLTYPE_SK constant varchar2(2) := 'sk';

  --�����������
  V_BILLTYPE_FK constant varchar2(2) := 'fk';

  --19λ�����ַ�����ʽ
  V_DATE_FORMAT_19 constant varchar2(21) := 'yyyy-mm-dd hh24:mi:ss';

  --10λ�����ַ�����ʽ
  V_DATE_FORMAT_10 constant varchar2(10) := 'yyyy-mm-dd';

  --�����õ�ǰ�����ַ���
  V_TMP_CURR_DATE_STR    constant varchar2(19) := '2016-10-31 23:56:56';
  V_TMP_CURR_DATE_STR_10 constant varchar2(19) := '2016-10-31';
  V_TMP_BEGIN_DATE_STR   constant varchar2(19) := '2016-01-01 01:01:01';
  --������Ĭ�ϵ�λ����
  V_TMP_ORG_CODE constant varchar2(200) := '101';

  --����ұ�������
  V_RMB_PK constant varchar2(20) := '1002Z0100000000001K1';

  --102��λ�˲�����
  V_102_FIBOOK_PK constant varchar2(20) := '1001A1100000000003WZ';
  --102��λ��֯����
  V_102_ORG_PK constant varchar2(20) := '0001A1100000000035BS';
  
  
  V_ZERO number(28,8)  := 0 ; 
  

  --64���ַ� 
  V_STR_64 constant varchar2(64) := 'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA';
  
  --V_STR_64    constant varchar2(32)  := 'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA';
  
  
  --���������̷������  
  V_GLF_CLASS_CODE    constant varchar2(64) := '00' ; 
  
  type ntx_number  is table of number(28,8 ) index  by pls_integer; 
  type ntx_integer  is table of pls_integer index  by pls_integer; 
  
  
  --��������£��õ��·ݵ����һ�����һ��ʱ�̵�����
  function f_date_para_get_lst_monthday(p_year  varchar2 default '2016',
                                        p_month varchar2 default '06',
                                        p_grap  pls_integer default 0)
    return varchar2;

  --ʹ�ó��� : ���ݵ�λ���� , ��ȡ��֯���˲���Ϣ,��Ŀ��
  --����:  org_code  ��֯����
  --����ֵ:  ��֯�Ŀ�Ŀ��,�˲��ȼ�¼���͵�Ƕ�ױ�

  cursor cur_org(p_org_code varchar2) is
    select d.pk_accsystem      accsystem_pk,
           d.code              accsystem_code,
           d.name              accsystem_name,
           c.pk_accchart       accchart_pk,
           c.code              accchart_code,
           c.name              accchart_name,
           b.pk_accountingbook fibook_pk,
           b.code              fibook_code,
           b.name              fibook_name,
           a.pk_org            org_pk,
           a.code              org_code,
           a.name              org_name
      from bd_accsystem d, bd_accchart c, org_accountingbook b, org_orgs a
     where 1 = 1
       and d.pk_accsystem = c.pk_accsystem
       and c.pk_accchart = b.pk_curraccchart
       and b.pk_relorg = a.pk_org
       and a.dr = 0
       and a.code = p_org_code;

  type ty_nt_org is table of cur_org%rowtype;

  function f_org(p_org_code varchar2 default '101') return ty_nt_org
    pipelined;

  --******************************************************************************************
  --ʹ�ó���:���ݵ�λ����,��Ŀ����,��ȡ��Ŀ����Ϣ  
  --����:  subj_code ��Ŀ���� 
  --       p_org_code ��λ����
  cursor cur_subj_info(p_subj_code varchar2, p_org_code varchar2) is
    select e.balanorient bal_orient,
           e.name acctype_name,
           d.code subj_code,
           length(d.code) the_length,
           d.pk_account,
           d.pid pk_father_account,
           c.name subj_name,
           c.dispname subj_dispname,
           c.pk_accasoa,
           c.endflag,
           c.pk_accchart,
           b.pk_accountingbook fibook_pk,
           b.code fibook_code,
           b.name fibook_name,
           a.pk_org org_pk,
           a.code org_code,
           a.name org_name
      from bd_acctype         e,
           bd_account         d,
           bd_accasoa         c,
           org_accountingbook b,
           org_orgs           a
     where 1 = 1
       and e.pk_acctype = d.pk_acctype
       and regexp_like(d.code, p_subj_code)
       and d.pk_account = c.pk_account
       and c.pk_accchart = b.pk_curraccchart
       and b.pk_relorg = a.pk_org
       and a.dr = 0
       and a.code like p_org_code
     order by length(d.code) asc;

  type nt_subj_info is table of cur_subj_info%rowtype;

  function f_subj_info(p_subj_code varchar2, p_org_code varchar2)
    return nt_subj_info
    pipelined;

  --******************************************************************************************
  --ʹ�ó���:���ݵ�λ����,��Ŀ����,��ȡ��Ŀ����Ϣ  
  --����:  subj_code ��Ŀ���� 
  --       p_org_code ��λ����
  --�����֯�Ŀ�Ŀ��ϸ�嵥

  cursor cur_subj_info_dzz(p_subj_code varchar2, p_org_code varchar2) is
    select e.balanorient bal_orient,
           e.name acctype_name,
           d.code subj_code,
           length(d.code) the_length,
           d.pk_account,
           d.pid pk_father_account,
           c.name subj_name,
           c.dispname subj_dispname,
           c.pk_accasoa,
           c.endflag,
           c.pk_accchart,
           b.pk_accountingbook fibook_pk,
           b.code fibook_code,
           b.name fibook_name,
           a.pk_org org_pk,
           a.code org_code,
           a.name org_name
      from bd_acctype         e,
           bd_account         d,
           bd_accasoa         c,
           org_accountingbook b,
           org_orgs           a
     where 1 = 1
       and e.pk_acctype = d.pk_acctype
       and regexp_like(d.code, p_subj_code)
       and d.pk_account = c.pk_account
       and c.pk_accchart = b.pk_curraccchart
       and b.pk_relorg = a.pk_org
       and a.dr = 0
       and regexp_like(a.code, p_org_code)
     order by length(d.code) asc;

  type nt_subj_info_dzz is table of cur_subj_info_dzz%rowtype;

  --************************************************************************************************************************
  --ʹ�ó��� �� �ӽ��Ǽǲ���ȡ��   
  --���гжһ�Ʊ��֤��
  cursor cur_loanregist(p_org_pk    varchar2 default '0001A1100000000035AY', --��֯
                        p_loan_type varchar2 default 'yc', -- ��ʽ
                        p_end_date  varchar2 default sy_base.V_TMP_CURR_DATE_STR --��������
                        ) is
    select a.pk_org,
           sum(a.fmoney) fmoney,
           0 gl_bal,
           0 diff,
           '~' pk_account,
           '~' pk_accasoa
      from sydq_loanregist a
     where 1 = 1
       and a.dr = 0
       and a.duedate >= p_end_date
       and a.loantype like p_loan_type
       and a.pk_org = p_org_pk
     group by a.pk_org;

  type nt_loanregist is table of cur_loanregist%rowtype;

  function f_loanregist(p_org_code  varchar2 default '101', --��֯
                        p_loan_type varchar2 default 'yc', -- ��ʽ
                        p_end_year  varchar2 default substr(V_TMP_CURR_DATE_STR,
                                                            1,
                                                            4),
                        p_end_month varchar2 default substr(V_TMP_CURR_DATE_STR,
                                                            6,
                                                            2))
    return nt_loanregist
    pipelined;

  --************************************************************************************************************************
  --ʹ�ó��� �� �ӱ����Ǽǲ���ȡ�� 
  cursor cur_guarregist(p_org_pk    varchar2 default '0001A1100000000035AY', --��֯
                        p_guar_type varchar2 default 'LY', -- ��ʽ  
                        p_end_date  varchar2 default sy_base.V_TMP_CURR_DATE_STR --��������
                        ) is
    select a.pk_org,
           sum(a.fmoney) fmoney,
           0 gl_bal,
           0 diff,
           '~' pk_account,
           '~' pk_accasoa
      from sydq_guarregist a
     where 1 = 1
       and a.dr = 0
       and a.dduedate >= p_end_date
       and a.billtype like p_guar_type
       and a.pk_org = p_org_pk
     group by a.pk_org;

  type nt_guarregist is table of cur_guarregist%rowtype;

  function f_guarregist(p_org_code  varchar2 default '101', --��֯
                        p_guar_type varchar2 default 'LY', -- ��ʽ
                        p_end_year  varchar2 default substr(V_TMP_CURR_DATE_STR,
                                                            1,
                                                            4),
                        p_end_month varchar2 default substr(V_TMP_CURR_DATE_STR,
                                                            6,
                                                            2))
    return nt_guarregist
    pipelined;

  --************************************************************************************************************************
  --ʹ�ó��� �� ��Ʊ�ݵǼǲ���ȡ�� 
  cursor cur_billregist(p_org_pk     varchar2 default '0001A1100000000035AY', --��֯
                        p_vouch_type varchar2 default 'YCYS', -- Ʊ������
                        p_end_date   varchar2 default sy_base.V_TMP_CURR_DATE_STR --��������
                        ) is
    select a.pk_org,
           sum(a.fmoney) fmoney,
           0 gl_bal,
           0 diff,
           '~' pk_account,
           '~' pk_accasoa
      from sydq_billregist a
     where 1 = 1
       and a.dr = 0
       and a.dduedate >= p_end_date
       and a.cvouchtype like p_vouch_type
       and a.pk_org = p_org_pk
     group by a.pk_org;

  type nt_billregist is table of cur_billregist%rowtype;

  function f_billregist(p_org_code   varchar2 default '101', --��֯
                        p_vouch_type varchar2 default 'YCYS', -- Ʊ������
                        p_end_year   varchar2 default substr(V_TMP_CURR_DATE_STR,
                                                             1,
                                                             4),
                        p_end_month  varchar2 default substr(V_TMP_CURR_DATE_STR,
                                                             6,
                                                             2))
    return nt_billregist
    pipelined;







  cursor cur_cashflow(p_end_date          varchar2 default '2016-06-30',
                      p_org_code          varchar2 default '*',
                      p_cashflow_item     varchar2 default '*',
                      p_subj_code         varchar2 default '*',
                      p_subj_exclude_code varchar2 default 'aabbcc',
                      p_accounting        number default 1,
                      p_period_length_max number default 2,
                      p_dir               number default 0,
                      p_currency_pk       varchar2 default V_RMB_PK,
                      p_beg_month         varchar2 default '07') is
    with orgbook_info as
     (
      
      select b.pk_accountingbook fibook_pk,
              b.code              fibook_code,
              b.name              fibook_name,
              a.pk_org            org_pk,
              a.code              org_code,
              a.name              org_name
        from org_accountingbook b, org_orgs a
       where 1 = 1
         and b.pk_relorg = a.pk_org
         and a.dr = 0
         and regexp_like(a.code, p_org_code)
      
      ),
    
    base_ as
     (select k.code cashflow_code,
             k.name cashflow_name,
             j.moneymain cashflow_money,
             xx.org_code org_code,
             c.code subj_code,
             d.name subj_name,
             d.dispname disp_name,
             h.balanorient,
             decode(a.periodv, '00', 0, a.localdebitamount) localdebitamount,
             decode(a.periodv, '00', 0, a.localcreditamount) localcreditamount,
             decode(h.balanorient, p_dir, '+', '-') bal_filter_dir_bz
      
        from bd_cashflow     k,
             gl_cashflowcase j,
             bd_acctype      h,
             bd_account      c,
             bd_accasoa      d,
             gl_voucher      b,
             gl_detail       a,
             orgbook_info    xx
       where 1 = 1
         and regexp_like(k.code, p_cashflow_item)
         and k.dr = 0
         and k.pk_cashflow = j.pk_cashflow
         and p_currency_pk = p_currency_pk
         and j.dr = 0
         and j.pk_detail = a.pk_detail
         and h.dr = 0
         and h.pk_acctype = c.pk_acctype
         and not regexp_like(c.code, p_subj_exclude_code)
         and c.dr = 0
         and regexp_like(c.code, p_subj_code)
         and c.pk_account = d.pk_account
         and d.dr = 0
         and d.pk_accasoa = a.pk_accasoa
         and b.tempsaveflag = 'N'
         and b.dr = 0
         and b.discardflag = 'N'
         and b.pk_voucher = a.pk_voucher
         and a.discardflagv = 'N'
         and a.dr = 0
         and length(a.adjustperiod) <= p_period_length_max
         and decode(nvl(b.tallydate, 'Y'), 'Y', 1, 2) >= p_accounting
         and a.pk_currtype = p_currency_pk
         and a.periodv >= p_beg_month
         and a.periodv between '00' and (substr(p_end_date, 6, 2) || 'Z')
         and a.yearv = substr(p_end_date, 1, 4)
         and a.pk_accountingbook = xx.fibook_pk),
    
    base_sum as
     (
      
      select cashflow_code,
              cashflow_name,
              org_code,
              subj_code,
              disp_name,
              sum(cashflow_money) cashflow_money
        from base_
       group by cashflow_code, cashflow_name, org_code, subj_code, disp_name
      
      )
    
    select * from base_sum;

  type nt_cur_cashflow is table of cur_cashflow%rowtype;

 cursor cur_cashflow_total(p_end_date          varchar2 default '2016-06-30',
                            p_org_code          varchar2 default '*',
                            p_cashflow_item     varchar2 default '*',
                            p_accounting        number default 1,
                            p_period_length_max number default 2,
                            p_currency_pk       varchar2 default V_RMB_PK,
                            p_beg_month         varchar2 default '07') is
    with orgbook_info as
     (
      
      select b.pk_accountingbook fibook_pk,
              b.code              fibook_code,
              b.name              fibook_name,
              a.pk_org            org_pk,
              a.code              org_code,
              a.name              org_name
        from org_accountingbook b, org_orgs a
       where 1 = 1
         and b.pk_relorg = a.pk_org
         and a.dr = 0
         and regexp_like(a.code, p_org_code)
      
      ),
    
    base_ as
     (select k.code      cashflow_code,
             k.name      cashflow_name,
             j.moneymain cashflow_money,
             xx.org_code org_code
        from bd_cashflow     k,
             gl_cashflowcase j,
             gl_voucher      b,
             gl_detail       a,
             orgbook_info    xx
       where 1 = 1
         and regexp_like(k.code, p_cashflow_item)
         and k.dr = 0
         and k.pk_cashflow = j.pk_cashflow
         and p_currency_pk = p_currency_pk
         and j.dr = 0
         and j.pk_detail = a.pk_detail
         and b.tempsaveflag = 'N'
         and b.dr = 0
         and b.discardflag = 'N'
         and b.pk_voucher = a.pk_voucher
         and a.discardflagv = 'N'
         and a.dr = 0
         and length(a.adjustperiod) <= p_period_length_max
         and decode(nvl(b.tallydate, 'Y'), 'Y', 1, 2) >= p_accounting
         and a.pk_currtype = p_currency_pk
         and a.periodv >= p_beg_month
         and a.periodv between '00' and (substr(p_end_date, 6, 2) || 'Z')
         and a.yearv = substr(p_end_date, 1, 4)
         and a.pk_accountingbook = xx.fibook_pk),
    
    base_sum as
     (
      
      select cashflow_code,
              cashflow_name,
              org_code,
              sum(cashflow_money) cashflow_money
        from base_
       group by cashflow_code, cashflow_name, org_code
      
      )
    
    select * from base_sum;

  type nt_cur_cashflow_total is table of cur_cashflow_total%rowtype;

  function f_cashflow(p_end_date          varchar2 default '2016-06-30',
                      p_org_code          varchar2 default '*',
                      p_cashflow_item     varchar2 default '*',
                      p_subj_code         varchar2 default '*',
                      p_accounting        number default 1,
                      p_period_length_max number default 2,
                      p_currency          varchar2 default 'CNY',
                      p_beg_month         varchar2 default '01',
                      p_subj_exclude_code varchar2 default 'aabbcc',
                      p_dir               number default 0)
    return nt_cur_cashflow
    pipelined;

 

  ----$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

  function f_cashflow_total(p_end_date          varchar2 default '2016-06-30',
                            p_org_code          varchar2 default '*',
                            p_cashflow_item     varchar2 default '*',
                            p_accounting        number default 1,
                            p_period_length_max number default 3,
                            p_currency          varchar2 default 'CNY',
                            p_beg_month         varchar2 default '01')
    return nt_cur_cashflow_total
    pipelined;

--&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

 
    cursor cur_gldetail_self(p_beg_date_19           varchar2 default V_TMP_BEGIN_DATE_STR,
                                     p_end_date_19           varchar2 default V_TMP_CURR_DATE_STR,
                                     p_subj_code_reg         varchar2 DEFAULT '^1231.*$',
                                     p_subj_code_exclude_reg  varchar2 default '^a.*$' , 
                                     p_org_code              varchar2 default sy_base.V_TMP_ORG_CODE,
                                     p_accur_dir             varchar2 default 'dr', --ȡ�跽������Ǵ���������
                                     p_accur_positive_minus  varchar2 default 'zheng', --ȡ��������������Ǹ���
                                     p_voucher_type_name_reg varchar2 default 'ת��ƾ֤',
                                     p_currency_pk           varchar2 default '1002Z0100000000001K1',
                                     p_period_length_max     number default 3,
                                     p_accounting            number default 1,
                                     p_related               varchar2 default '*'  , 
                                     aux_code                varchar2 default '*' , 
                                     aux_name                varchar2 default  '*' , 
                                     p_cust_sup_class_code   varchar2 default  V_GLF_CLASS_CODE 
                                     ) is
  
    with org_info as
     (
      
      select b.pk_accountingbook fibook_pk ,
              a.code org_code  , 
              a.name  org_name, 
              a.pk_org  org_pk 
        from org_accountingbook b, org_orgs a
       where 1 = 1
         and b.pk_relorg = a.pk_org
         and a.dr = 0
         and regexp_like(a.code, p_org_code)
      
      ),
      
        glf_info as 
      (
      SELECT aa.pk_cust_sup , aa.code  aux_code , aa.name aux_name , nvl(bb.code,'~') cust_class_code , nvl(bb.name,'~') cust_class_name, 
nvl(cc.code,'~') sup_class_code , nvl(cc.name,'~') sup_class_name, 
aa.pk_financeorg 
FROM   bd_supplierclass cc , bd_custclass  bb  , bd_cust_supplier aa
where   
1=1
and    (  nvl(cc.code,'~') =V_GLF_CLASS_CODE  or nvl(bb.code,'~') = V_GLF_CLASS_CODE )
and   cc.pk_supplierclass (+) = aa.pk_supplierclass
and   bb.pk_custclass (+) =aa.pk_custclass 


) ,

    
    base_ as
     (select m.org_pk ,  
             m.org_code , 
             m.org_name, 
             c.code  subj_code,
             d.name subj_name , 
             d.dispname  disp_name, 
             a.explanation  explanation , 
             d.pk_accasoa  pk_accasoa , 
             nvl(a.oppositesubj, 'a') oppositesubj,
             f.name voucher_type_name,
             decode(a.localdebitamount, 0, 'cr', 'dr') accur_dir,
             decode(a.localdebitamount,
                    0,
                    a.localcreditamount,
                    a.localdebitamount) local_amount,
             case
               when decode(a.localdebitamount,
                           0,
                           a.localcreditamount,
                           a.localdebitamount) >= 0 then
                'zheng'
               else
                'fu'
             end accur_positive_minus,
             a.pk_voucher,
             a.yearv,
             a.periodv , 
             a.nov voucher_num,
             a.pk_currtype ,
             nvl(h.pk_cust_sup, '~ ') cust_sup_pk,
             nvl(h.code, ' ~') cust_sup_code,
             nvl(h.name, '~ ') cust_sup_name , 
             nvl(i.pk_psndoc, '~ ') psn_doc_pk,
             nvl(i.code, ' ~') psn_doc_code,
             nvl(i.name, '~ ') psn_doc_name 
           
    
        from 
             bd_psndoc        i,
             bd_cust_supplier h,
             gl_docfree1      g,
             bd_vouchertype   f,
             bd_acctype       e,
             bd_accasoa       d,
             org_info         m,
             bd_account       c,
             gl_voucher       b,
             gl_detail        a
       where 
        
           i.pk_psndoc(+) = g.f2 
         and  h.pk_cust_sup(+) =
             substr(g.f13 || g.f14,
                    decode(instr(g.f13 || g.f14, 'NN/A'), 1, 5, 1),
                    20)
         and nvl(g.dr, 0) = 0
         and g.assid(+) = a.assid
         and regexp_like(f.name, p_voucher_type_name_reg)
         and f.pk_vouchertype = a.pk_vouchertypev
         and e.dr = 0
         and e.pk_acctype = c.pk_acctype
         and c.dr = 0
         and not regexp_like (c.code , p_subj_code_exclude_reg)
         and regexp_like(c.code, p_subj_code_reg)
         and c.pk_account = d.pk_account
         and d.dr = 0
         and d.pk_accasoa = a.pk_accasoa
         and b.tempsaveflag = 'N'
         and b.dr = 0
         and b.discardflag = 'N'
         and b.pk_voucher = a.pk_voucher
         and a.discardflagv = 'N'
         and a.dr = 0
         and length(a.adjustperiod) <= p_period_length_max
         and decode(nvl(b.tallydate, 'Y'), 'Y', 1, 2) >= p_accounting
         and a.pk_currtype = p_currency_pk
         and a.periodv <= substr(p_end_date_19, 6, 2) || 'Z'
         and a.periodv >= '01'
         and a.yearv = substr(p_end_date_19, 1, 4)
         and a.pk_accountingbook = m.fibook_pk
         and a.prepareddatev <= p_end_date_19
         and a.prepareddatev >= p_beg_date_19) , 
    
   join_glf as 
   (
      select base_.* , 
      case 
            when 
                 nvl(glf_info.pk_cust_sup, 'X') = 'X' then  'N'    
            else 
               'Y' 
        end related_mark 
              
       from  glf_info  , base_ 
      where glf_info.pk_cust_sup(+) = base_.cust_sup_pk
      
   
   ) 
 
    
    select   org_pk, org_code, org_name, 
             cust_sup_pk org_pk_oppo ,  
             cust_sup_code org_code_oppo ,   
             cust_sup_name  org_name_oppo ,  
             subj_code, subj_name, disp_name, explanation , 
             pk_accasoa , 
             oppositesubj,
       voucher_type_name ,
             accur_dir,
             local_amount,
             accur_positive_minus,
             pk_voucher,
             yearv,
             periodv , 
             voucher_num,
             pk_currtype,
             cust_sup_pk,
             cust_sup_code,
             cust_sup_name ,
             psn_doc_pk,
             psn_doc_code,
             psn_doc_name ,
             related_mark
      from join_glf
     where  
    regexp_like(cust_sup_code , aux_code)
     and regexp_like(cust_sup_name , aux_name)
     and regexp_like(accur_positive_minus, p_accur_positive_minus)
     and regexp_like(accur_dir, p_accur_dir)
   and regexp_like(related_mark, p_related) ;

    type nt_gldetail_self is table of cur_gldetail_self%rowtype;
  
   cursor cur_gldetail_by_voucher(voucher_pk  varchar2,
                                  currency_pk varchar2 default V_RMB_PK ) is
    with base_ as
     (select 'a' org_pk , 'a' org_code, 'a' org_name, 
             'a' org_pk_oppo , 'a' org_code_oppo, 'a' org_name_oppo, 
             c.code subjcode,
             d.name subj_name,
             d.dispname disp_name, 
             a.explanation  explanation , 
             d.pk_accasoa , 
             nvl(a.oppositesubj, 'a') oppositesubj,
             f.name voucher_type_name,
             decode(a.localdebitamount, 0, 'cr', 'dr') accur_dir,
             decode(a.localdebitamount,
                    0,
                    a.localcreditamount,
                    a.localdebitamount) local_amount,
             case
               when decode(a.localdebitamount,
                           0,
                           a.localcreditamount,
                           a.localdebitamount) >= 0 then
                'zheng'
               else
                'fu'
             end accur_positive_minus, 
             a.pk_voucher ,   
             a.yearv,
             a.periodv , 
             a.nov voucher_num,  
             a.pk_currtype ,             
             nvl(h.pk_cust_sup, c.pk_account) cust_sup_pk,
             nvl(h.code, c.code) cust_sup_code,
             nvl(h.name, d.dispname) cust_sup_name,
             nvl(i.pk_psndoc, c.pk_account) psn_doc_pk,
             nvl(i.code, c.code) psn_doc_code,
             nvl(i.name, d.dispname) psn_doc_name ,
             'X' related_mark 
        from bd_psndoc        i,
             bd_cust_supplier h,
             gl_docfree1      g,
             bd_vouchertype   f,
             bd_acctype       e,
             bd_accasoa       d,
             bd_account       c,
             gl_detail        a
       where 
         i.pk_psndoc(+) = g.f2
         and h.pk_cust_sup(+) =
             substr(g.f13 || g.f14,
                    decode(instr(g.f13 || g.f14, 'NN/A'), 1, 5, 1),
                    20)
         and nvl(g.dr, 0) = 0
         and g.assid(+) = a.assid
         and f.pk_vouchertype = a.pk_vouchertypev
         and e.pk_acctype = c.pk_acctype
         and c.pk_account = d.pk_account
         and d.pk_accasoa = a.pk_accasoa
         and a.pk_currtype = currency_pk
         and a.pk_voucher = voucher_pk) 

    select * from base_;
  
  
  
  
  function f_gldetail_self(p_beg_date_19           varchar2 default V_TMP_BEGIN_DATE_STR,
                                     p_end_date_19           varchar2 default V_TMP_CURR_DATE_STR,
                                     p_subj_code_reg         varchar2 DEFAULT '^1122.*$',
                                     p_subj_code_exclude_reg  varchar2 default '^a.*$' , 
                                     p_org_code              varchar2 default sy_base.V_TMP_ORG_CODE,
                                     p_accur_dir             varchar2 default 'dr', --ȡ�跽������Ǵ���������
                                     p_accur_positive_minus  varchar2 default 'zheng', --ȡ��������������Ǹ���
                                     p_voucher_type_name_reg varchar2 default 'ת��ƾ֤',
                                     p_currency_pk           varchar2 default '1002Z0100000000001K1',
                                     p_period_length_max     number default 3,
                                     p_accounting            number default 1,
                                     p_related               varchar2 default '*'   , 
                                      p_cust_sup_class_code   varchar2 default  V_GLF_CLASS_CODE 
                                     ) 
return nt_gldetail_self
pipelined ;
  



function f_gldetail_by_voucher(  voucher_pk  varchar2,
                                  currency_pk varchar2 default V_RMB_PK) 
 return  nt_gldetail_self 
 pipelined  ; 
 
 
 
 
 --***************************************************************************************************************************************************
  function  f_get_oppo_gldetail (
                 p_org_code             varchar2 default '101' , 
                 p_end_year             varchar2 DEFAULT '2016',
                 p_end_month            varchar2 DEFAULT '10',
                 p_subj_code_reg            varchar2 DEFAULT '^1122.*$',  
				         p_subj_code_exclude_reg  varchar2 default '^a.*$' , 
                 p_oppo_subj_code_reg       varchar2 default  '(^1403.*$)|(^1604.*$)|(^1601.*$)|(^1405.*$)',    
                 p_accur_dir  varchar2  default 'dr' ,    --ȡ�跽������Ǵ���������
                 p_accur_positive_minus varchar2  default 'zheng'  ,  --ȡ��������������Ǹ���
                 p_voucher_type_name_reg     varchar2 default '*'  ,        
                 p_currency             varchar2  default 'CNY',
                 p_period_length_max    number default 3 , 
                 p_accounting           number default 1 ,
                 p_related       varchar2 default '*' , 
                  p_aux_code      varchar2 default '*' , 
                 p_aux_name      varchar2 default  '*'   , 
                    p_cust_sup_class_code   varchar2 default  V_GLF_CLASS_CODE 
   )  
   return   nt_gldetail_self 
   pipelined  ; 
 
 
 
 --&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
 
 
  cursor cur_arap_dd         ( p_org_code            varchar2 default sy_base.V_TMP_ORG_CODE , 
                              p_end_date          varchar2 default V_TMP_CURR_DATE_STR_10,
                              p_subj_code         varchar2 DEFAULT '^(1122).*$',
                              p_subj_exclude_code varchar2 default '^1122002.*$',
                              p_related           varchar2  default 'X' ,   --�Ƿ���˹�����
                              p_dir               number default 1,
                              p_psn_subj_list     varchar2 default 'a',
                              p_aux_code_ks       varchar2 DEFAULT '*',
                              p_aux_name_ks       varchar2 DEFAULT '*',
                              p_aux_code_ry       varchar2 DEFAULT '*',
                              p_aux_name_ry       varchar2 DEFAULT '*',
                              p_currency_pk       varchar2 default V_RMB_PK,
                              p_period_length_max number default 2,
                              p_accounting        number default 1,
                              p_perious_date_0    date default add_months(to_date(V_TMP_CURR_DATE_STR,
                                                                                  V_DATE_FORMAT_19),
                                                                          -6 * 1),
                              p_perious_date_1    date default add_months(to_date(V_TMP_CURR_DATE_STR,
                                                                                  V_DATE_FORMAT_19),
                                                                          -12 * 1),
                              p_perious_date_2    date default add_months(to_date(V_TMP_CURR_DATE_STR,
                                                                                  V_DATE_FORMAT_19),
                                                                          -12 * 2),
                              p_perious_date_3    date default add_months(to_date(V_TMP_CURR_DATE_STR,
                                                                                  V_DATE_FORMAT_19),
                                                                          -12 * 3),
                              p_perious_date_4    date default add_months(to_date(V_TMP_CURR_DATE_STR,
                                                                                  V_DATE_FORMAT_19),
                                                                          -12 * 4),
                              p_perious_date_5    date default add_months(to_date(V_TMP_CURR_DATE_STR,
                                                                                  V_DATE_FORMAT_19),
                                                                          -12 * 5) , 
                              p_cust_sup_class_code   varchar2 default '00'
                           
                              ) is
    with orgbook_info as
     (
      
      select b.pk_accountingbook fibook_pk,
              b.code              fibook_code,
              b.name              fibook_name,
              a.pk_org            org_pk,
              a.code              org_code,
              a.name              org_name
        from org_accountingbook b, org_orgs a
         where 1 = 1
         and b.pk_relorg = a.pk_org
         and a.dr = 0
         and regexp_like(a.code, p_org_code)
      
      ),
      
      glf_info as 
      (
      SELECT aa.pk_cust_sup , aa.code  aux_code , aa.name aux_name , nvl(bb.code,'~') cust_class_code , nvl(bb.name,'~') cust_class_name, 
nvl(cc.code,'~') sup_class_code , nvl(cc.name,'~') sup_class_name, 
aa.pk_financeorg 
FROM   bd_supplierclass cc , bd_custclass  bb  , bd_cust_supplier aa
where   
1=1
and    (  nvl(cc.code,'~') =V_GLF_CLASS_CODE  or nvl(bb.code,'~') = V_GLF_CLASS_CODE )
and   cc.pk_supplierclass (+) = aa.pk_supplierclass
and   bb.pk_custclass (+) =aa.pk_custclass ) , 
    
    gl_ as
     (select xx.org_code org_code,
             c.code subj_code,
             d.name subj_name,
             d.dispname disp_name,
             h.balanorient,
             decode(a.periodv, '00', 0, a.localdebitamount) localdebitamount,
             decode(a.periodv, '00', 0, a.localcreditamount) localcreditamount,
             decode(h.balanorient,
                    0,
                    localdebitamount - localcreditamount,
                    localcreditamount - localdebitamount) bal,
             
             decode(a.periodv,
                    '00',
                    decode(h.balanorient,
                           0,
                           localdebitamount - localcreditamount,
                           localcreditamount - localdebitamount),
                    0) bal_beg,
             
             decode(h.balanorient, p_dir, '+', '-') bal_filter_dir_bz,
             case
               when instr(c.code || ',', p_psn_subj_list) = 0 then
               
                decode(nvl(g.pk_cust_sup, '~'),
                       '~',
                       decode(nvl(m.pk_defdoc, '~'),
                              '~',
                              nvl(k.pk_cust_sup, c.pk_account),
                              m.pk_defdoc),
                       g.pk_cust_sup)
               else
                nvl(i.pk_psndoc, a.pk_account)
             
             end aux_pk,
             
             case
               when instr(c.code || ',', p_psn_subj_list) = 0 then
               
                decode(nvl(g.code, '~'),
                       '~',
                       decode(nvl(m.code, '~'),
                              '~',
                              nvl(k.code, c.code),
                              m.code),
                       g.code)
             
               else
                nvl(i.code, c.code)
             end aux_code,
             
             case
               when instr(c.code || ',', p_psn_subj_list) = 0 then
               
                decode(nvl(g.name, '~'),
                       '~',
                       decode(nvl(m.name, '~'),
                              '~',
                              nvl(k.name, d.dispname),
                              m.name),
                       g.name)
               else
                nvl(i.name, d.dispname)
             end aux_name  
        from 
         
             bd_defdoc        m,
             bd_cust_supplier k,
             bd_psndoc        i,
             bd_cust_supplier g,
             gl_docfree1      f,
             bd_acctype       h,
             bd_account       c,
             bd_accasoa       d,
             gl_voucher       b,
             gl_detail        a,
             orgbook_info     xx
       where 
 
        m.pk_defdoc(+) =
             substr(f.f21 || f.f22,
                    decode(instr(f.f21 || f.f22, 'NN/A'), 1, 5, 1),
                    20)
         and regexp_like(nvl(k.code, '~'), p_aux_code_ks)
         and regexp_like(nvl(k.name, '~'), p_aux_name_ks)
         and k.pk_cust_sup(+) = f.f4
         and regexp_like(nvl(i.code, '~'), p_aux_code_ry)
         and regexp_like(nvl(i.name, '~'), p_aux_name_ry)
         and i.pk_psndoc(+) = f.f2
         and regexp_like(nvl(g.code, '~'), p_aux_code_ks)
         and regexp_like(nvl(g.name, '~'), p_aux_name_ks)
         and nvl(g.dr, 0) = 0
         and g.pk_cust_sup(+) =
             substr(f.f13 || f.f14,
                    decode(instr(f.f13 || f.f14, 'NN/A'), 1, 5, 1),
                    20)
         and nvl(f.dr, 0) = 0
         and f.assid(+) = a.assid
         and h.dr = 0
         and h.pk_acctype = c.pk_acctype
         and not regexp_like(c.code, p_subj_exclude_code)
         and c.dr = 0
         and regexp_like(c.code, p_subj_code)
         and c.pk_account = d.pk_account
         and d.dr = 0
         and d.pk_accasoa = a.pk_accasoa
         and b.tempsaveflag = 'N'
         and b.dr = 0
         and b.discardflag = 'N'
         and b.pk_voucher = a.pk_voucher
         and a.assid is not null
         and a.discardflagv = 'N'
         and a.dr = 0
         and length(a.adjustperiod) <= p_period_length_max
         and decode(nvl(b.tallydate, 'Y'), 'Y', 1, 2) >= p_accounting
         and a.pk_currtype = p_currency_pk
         and a.periodv between '00' and (substr(p_end_date, 6, 2) || 'Z')
         and a.yearv = substr(p_end_date, 1, 4)
         and a.pk_accountingbook = xx.fibook_pk
      
      ),
      
      
       gl_verify_log_info as (
          
     
          select  tt.pk_verifydetail  pk_verifydetail_from_log0 ,
                  sum(tt.verifylocaldebitamount) verifylocaldebitamount , 
                  sum(tt.verifylocalcreditamount)  verifylocalcreditamount      
                  
          from   gl_verify_log tt 
          where   tt.byvoucherdate <= p_end_date || ' 23:59:59'
          and tt.dr = 0 
          group by tt.pk_verifydetail 
     
     )  , 
     
  
    gl_verify as
     (
      
      select xx.org_code,
              ccc.code subj_code,
              bbb.name subj_name,
              bbb.dispname disp_name,
              aaa.balancelocaldebitamount,
              aaa.balancelocalcreditamount,
              decode(ggg.balanorient,
                     0,
                     aaa.localdebitamount -  aaa.localcreditamount - (nvl(fff.verifylocaldebitamount,0)- nvl(fff.verifylocalcreditamount,0)) ,
                     aaa.localcreditamount - aaa.localdebitamount  - (nvl(fff.verifylocalcreditamount,0) - nvl(fff.verifylocaldebitamount,0) )) bal,
              decode(ggg.balanorient, p_dir, '+', '-') bal_filter_dir_bz,
             
              case
                when instr(ccc.code || ',', p_psn_subj_list) = 0 then
                 nvl(eee.pk_cust_sup, ccc.pk_account)
                else
                 nvl(fff.pk_psndoc, ccc.pk_account)
              end aux_pk,
              
              case
                when instr(ccc.code || ',', p_psn_subj_list) = 0 then
                 nvl(eee.code, ccc.code)
                else
                 nvl(fff.code, ccc.code)
              end aux_code,
              
              case
                when instr(ccc.code || ',', p_psn_subj_list) = 0 then
                 nvl(eee.name, bbb.dispname)
                else
                 nvl(fff.name, bbb.dispname)
              end aux_name,
                          
              case
               when to_date(aaa.prepareddate, V_DATE_FORMAT_19) >
                     p_perious_date_0 then
                 decode(ggg.balanorient,
                        0,
                        aaa.localdebitamount -  aaa.localcreditamount - (nvl(fff.verifylocaldebitamount,0)- nvl(fff.verifylocalcreditamount,0)) ,
                        aaa.localcreditamount - aaa.localdebitamount  - (nvl(fff.verifylocalcreditamount,0) - nvl(fff.verifylocaldebitamount,0) ))
                else
                 0
              end bal_0,
              
              case 
                when 
                  to_date(aaa.prepareddate, V_DATE_FORMAT_19) <= p_perious_date_0
                  and 
                  to_date(aaa.prepareddate, V_DATE_FORMAT_19) >
                     p_perious_date_1 then
                 decode(ggg.balanorient,
                        0,
                        aaa.localdebitamount -  aaa.localcreditamount - (nvl(fff.verifylocaldebitamount,0)- nvl(fff.verifylocalcreditamount,0)) ,
                        aaa.localcreditamount - aaa.localdebitamount  - (nvl(fff.verifylocalcreditamount,0) - nvl(fff.verifylocaldebitamount,0) ))
                else
                 0
              end bal_1,
              
              case
                when to_date(aaa.prepareddate, V_DATE_FORMAT_19) <=
                     p_perious_date_1 and
                     to_date(aaa.prepareddate, V_DATE_FORMAT_19) >
                     p_perious_date_2 then
                 decode(ggg.balanorient,
                        0,
                    aaa.localdebitamount -  aaa.localcreditamount - (nvl(fff.verifylocaldebitamount,0)- nvl(fff.verifylocalcreditamount,0)) ,
                        aaa.localcreditamount - aaa.localdebitamount  - (nvl(fff.verifylocalcreditamount,0) - nvl(fff.verifylocaldebitamount,0) ))
                else
                 0
              end bal_2,
              case
                when to_date(aaa.prepareddate, V_DATE_FORMAT_19) <=
                     p_perious_date_2 and
                     to_date(aaa.prepareddate, V_DATE_FORMAT_19) >
                     p_perious_date_3 then
                 decode(ggg.balanorient,
                        0,
                       aaa.localdebitamount -  aaa.localcreditamount - (nvl(fff.verifylocaldebitamount,0)- nvl(fff.verifylocalcreditamount,0)) ,
                        aaa.localcreditamount - aaa.localdebitamount  - (nvl(fff.verifylocalcreditamount,0) - nvl(fff.verifylocaldebitamount,0) ))
                else
                 0
              end bal_3,
              case
                when to_date(aaa.prepareddate, V_DATE_FORMAT_19) <=
                     p_perious_date_3 and
                     to_date(aaa.prepareddate, V_DATE_FORMAT_19) >
                     p_perious_date_4 then
                 decode(ggg.balanorient,
                        0,
                      aaa.localdebitamount -  aaa.localcreditamount - (nvl(fff.verifylocaldebitamount,0)- nvl(fff.verifylocalcreditamount,0)) ,
                        aaa.localcreditamount - aaa.localdebitamount  - (nvl(fff.verifylocalcreditamount,0) - nvl(fff.verifylocaldebitamount,0) ))
                else
                 0
              end bal_4,
              case
                when to_date(aaa.prepareddate, V_DATE_FORMAT_19) <=
                     p_perious_date_4 and
                     to_date(aaa.prepareddate, V_DATE_FORMAT_19) >
                     p_perious_date_5 then
                 decode(ggg.balanorient,
                        0,
                        aaa.localdebitamount -  aaa.localcreditamount - (nvl(fff.verifylocaldebitamount,0)- nvl(fff.verifylocalcreditamount,0)) ,
                        aaa.localcreditamount - aaa.localdebitamount  - (nvl(fff.verifylocalcreditamount,0) - nvl(fff.verifylocaldebitamount,0) ))
                else
                 0
              end bal_5,
              case
                when to_date(aaa.prepareddate, V_DATE_FORMAT_19) <= p_perious_date_5 then
                 decode(ggg.balanorient,
                        0,
                        aaa.localdebitamount -  aaa.localcreditamount - (nvl(fff.verifylocaldebitamount,0)- nvl(fff.verifylocalcreditamount,0)) ,
                        aaa.localcreditamount - aaa.localdebitamount  - (nvl(fff.verifylocalcreditamount,0) - nvl(fff.verifylocaldebitamount,0) ))
                else
                 0
              end bal_6  
            
        from 
              bd_psndoc        fff,
              bd_cust_supplier eee,
              gl_docfree1      ddd,
              bd_acctype       ggg,
              bd_account       ccc,
              bd_accasoa       bbb,
              gl_verify_log_info fff, 
              gl_verifydetail  aaa,
              orgbook_info     xx
       where 
         regexp_like(nvl(fff.code, '~'), p_aux_code_ry)
         and regexp_like(nvl(fff.name, '~'), p_aux_name_ry)
         and fff.pk_psndoc(+) = ddd.f2
         and regexp_like(nvl(eee.code, '~'), p_aux_code_ks)
         and regexp_like(nvl(eee.name, '~'), p_aux_name_ks)
         and eee.pk_cust_sup =
             substr(ddd.f13 || ddd.f14,
                    decode(instr(ddd.f13 || ddd.f14, 'NN/A'), 1, 5, 1),
                    20)
         and ggg.pk_acctype = ccc.pk_acctype
         and ddd.assid = aaa.assid
         and not regexp_like(ccc.code, p_subj_exclude_code)
         and regexp_like(ccc.code, p_subj_code)
         and ccc.pk_account = bbb.pk_account
         and bbb.pk_accasoa = aaa.pk_accasoa
         and fff.pk_verifydetail_from_log0(+) = aaa.pk_verifydetail  
         and aaa.dr = 0
         and aaa.prepareddate <= p_end_date || ' 23:59:59'
         and aaa.pk_accountingbook = xx.fibook_pk
      
      ),
  
    tmp_union_01 as
     (select org_code,
             subj_code,
             subj_name,
             disp_name,
             bal_filter_dir_bz,
             aux_pk,
             aux_code,
             aux_name,
             bal,
             decode( decode(aux_code, subj_code, 'Y', 'N'), 'Y',  bal ,  0) bal_age,
             decode( decode(aux_code, subj_code, 'Y', 'N'), 'Y',  bal ,  0) bal_0,
             0                 bal_1,
             0                 bal_2,
             0                 bal_3,
             0                 bal_4,
             0                 bal_5,
             0                 bal_6,
             localdebitamount,
             localcreditamount,
             bal_beg,
             decode(aux_code, subj_code, 'Y', 'N') not_aux 

        from  gl_

      
      union all
      
      select org_code,
             subj_code,
             subj_name,
             disp_name,
             bal_filter_dir_bz,
             aux_pk,
             aux_code,
             aux_name,
             0                 bal,
             bal               bal_age,
             bal_0,
             bal_1,
             bal_2,
             bal_3,
             bal_4,
             bal_5,
             bal_6,
             0                 localdebitamount,
             0                 localcreditamount,
             0                 bal_beg,
             'N'  not_aux 
        from gl_verify
        ),
    
    sum_tmp_union_01 as
     (select org_code,
             subj_code,
             subj_name,
             disp_name,
             bal_filter_dir_bz,
             aux_pk,
             aux_code,
             aux_name,
             sum(bal) bal,
             sum(bal_age) bal_age,
             sum(bal) - sum(bal_age) bal_diff,
             sum(bal_0) bal_0 , 
             sum(bal_1) bal_1,
             sum(bal_2) bal_2,
             sum(bal_3) bal_3,
             sum(bal_4) bal_4,
             sum(bal_5) bal_5,
             sum(bal_6) bal_6,
             sum(localdebitamount) localdebitamount,
             sum(localcreditamount) localcreditamount,
             sum(bal_beg) bal_beg,
             case bal_filter_dir_bz
               when '+' then
                case
                  when sum(bal) >= 0 then
                   'Y+'
                  else
                   'N'
                end
               when '-' then
                case
                  when sum(bal) <= 0 then
                   'Y-'
                  else
                   'N'
                end
             end selected_mark,
             not_aux 
      
        from tmp_union_01
       group by org_code,
                subj_code,
                subj_name,
                disp_name,
                bal_filter_dir_bz,
                aux_pk,
                aux_code,
                aux_name,
                not_aux 
                  ) , 
                  
    join_glf as 
    (
    
      select sum_tmp_union_01.* , 
         case 
            when 
                 nvl(glf_info.pk_cust_sup, 'X') = 'X' then  'N'    
            else 
               'Y' 
        end related_mark 
              
       from glf_info  , sum_tmp_union_01 
       where glf_info.pk_cust_sup (+)=sum_tmp_union_01.aux_pk 
    
    
    )            
                  
                  
    
    select   org_code,
             subj_code,
             subj_name,
             disp_name,
             aux_pk,
             aux_code,
             aux_name,
             decode(selected_mark, 'Y+', bal_beg, -bal_beg) bal_beg,
             decode(selected_mark, 'Y+', localdebitamount, -localdebitamount) localdebitamount,
             decode(selected_mark, 'Y+', localcreditamount, -localcreditamount) localcreditamount,
             decode(selected_mark, 'Y+', bal, -bal) bal,
             decode(selected_mark, 'Y+', bal_age, -bal_age) bal_age,
             decode(selected_mark, 'Y+', bal_diff, -bal_diff) bal_diff,
             decode(selected_mark, 'Y+', bal_0, -bal_0) bal_0,
             decode(selected_mark, 'Y+', bal_1, -bal_1) bal_1,
             decode(selected_mark, 'Y+', bal_2, -bal_2) bal_2,
             decode(selected_mark, 'Y+', bal_3, -bal_3) bal_3,
             decode(selected_mark, 'Y+', bal_4, -bal_4) bal_4,
             decode(selected_mark, 'Y+', bal_5, -bal_5) bal_5,
             decode(selected_mark, 'Y+', bal_6, -bal_6) bal_6,
             0 bal_reserve  ,  0  bal_reserve_0, 0  bal_reserve_1, 0 bal_reserve_2,
             0  bal_reserve_3, 0 bal_reserve_4,
             0 bal_reserve_5, 0 bal_reserve_6 ,
             not_aux , related_mark 
        from join_glf 
       where selected_mark <> 'N'  and related_mark like p_related; 
      
   
  

  type nt_arap is table of cur_arap_dd%rowtype;
  
  
  
   cursor cur_arap_hb(p_org_code            varchar2 default sy_base.V_TMP_ORG_CODE , 
                            p_end_date          varchar2 default V_TMP_CURR_DATE_STR_10,
                            p_subj_code         varchar2 DEFAULT '^(1122).*$',
                            p_subj_exclude_code varchar2 default '^1122002.*$',
                            p_related           varchar2  default 'X' ,   --�Ƿ���˹�����
                            p_dir               number default 1,
                            p_psn_subj_list     varchar2 default 'a',
                            p_aux_code_ks       varchar2 DEFAULT '*',
                            p_aux_name_ks       varchar2 DEFAULT '*',
                            p_aux_code_ry       varchar2 DEFAULT '*',
                            p_aux_name_ry       varchar2 DEFAULT '*',
                            p_currency_pk       varchar2 default V_RMB_PK,
                            p_period_length_max number default 2,
                            p_accounting        number default 1,
                            p_perious_date_0    date default add_months(to_date(V_TMP_CURR_DATE_STR,
                                                                                V_DATE_FORMAT_19),
                                                                        -6 * 1),
                            p_perious_date_1    date default add_months(to_date(V_TMP_CURR_DATE_STR,
                                                                                V_DATE_FORMAT_19),
                                                                        -12 * 1),
                            p_perious_date_2    date default add_months(to_date(V_TMP_CURR_DATE_STR,
                                                                                V_DATE_FORMAT_19),
                                                                        -12 * 2),
                            p_perious_date_3    date default add_months(to_date(V_TMP_CURR_DATE_STR,
                                                                                V_DATE_FORMAT_19),
                                                                        -12 * 3),
                            p_perious_date_4    date default add_months(to_date(V_TMP_CURR_DATE_STR,
                                                                                V_DATE_FORMAT_19),
                                                                        -12 * 4),
                            p_perious_date_5    date default add_months(to_date(V_TMP_CURR_DATE_STR,
                                                                                V_DATE_FORMAT_19),
                                                                        -12 * 5) ,  
                            
                            p_cust_sup_class_code   varchar2 default '00'
                           
                          
                            ) is
    with orgbook_info as
     (
      
      select b.pk_accountingbook fibook_pk,
              b.code              fibook_code,
              b.name              fibook_name,
              a.pk_org            org_pk,
              a.code              org_code,
              a.name              org_name
        from org_accountingbook b, org_orgs a
       where 1 = 1
         and b.pk_relorg = a.pk_org
         and a.dr = 0
         and regexp_like(a.code, p_org_code)
      
      ),
      
      glf_info as 
      (
      SELECT aa.pk_cust_sup , aa.code  aux_code , aa.name aux_name , nvl(bb.code,'~') cust_class_code , nvl(bb.name,'~') cust_class_name, 
nvl(cc.code,'~') sup_class_code , nvl(cc.name,'~') sup_class_name, 
aa.pk_financeorg 
FROM   bd_supplierclass cc , bd_custclass  bb  , bd_cust_supplier aa
where   
1=1
and    (  nvl(cc.code,'~') =V_GLF_CLASS_CODE  or nvl(bb.code,'~') = V_GLF_CLASS_CODE )
and   cc.pk_supplierclass (+) = aa.pk_supplierclass
and   bb.pk_custclass (+) =aa.pk_custclass ) , 

     
    
    base_ as
     (select org_code,
             
             substr(c.code, 1, 4) subj_code_1j,
             
             h.balanorient,
             a.localdebitamount,
             a.localcreditamount,
             decode(h.balanorient,
                    0,
                    localdebitamount - localcreditamount,
                    localcreditamount - localdebitamount) bal,
             decode(a.periodv,
                    '00',
                    decode(h.balanorient,
                           0,
                           localdebitamount - localcreditamount,
                           localcreditamount - localdebitamount),
                    0) bal_beg,
             decode(h.balanorient, p_dir, '+', '-') bal_filter_dir_bz,
             g.pk_cust_sup aux_pk,
             g.code aux_code,
             g.name aux_name 
        from
             bd_cust_supplier g,
             gl_docfree1      f,
             bd_acctype       h,
             bd_account       c,
             bd_accasoa       d,
             gl_voucher       b,
             gl_detail        a,
             orgbook_info     xx
       where 

         regexp_like(nvl(g.code, '~'), p_aux_code_ks)
         and regexp_like(nvl(g.name, '~'), p_aux_name_ks)
         and nvl(g.dr, 0) = 0
         and g.pk_cust_sup(+) =
             substr(f.f13 || f.f14,
                    decode(instr(f.f13 || f.f14, 'NN/A'), 1, 5, 1),
                    20)
         and nvl(f.dr, 0) = 0
         and f.assid(+) = a.assid
         and h.dr = 0
         and h.pk_acctype = c.pk_acctype
         and not regexp_like(c.code, p_subj_exclude_code)
         and c.dr = 0
         and regexp_like(c.code, p_subj_code)
         and c.pk_account = d.pk_account
         and d.dr = 0
         and d.pk_accasoa = a.pk_accasoa
         and b.tempsaveflag = 'N'
         and b.dr = 0
         and b.discardflag = 'N'
         and b.pk_voucher = a.pk_voucher
         and a.assid is not null
         and a.discardflagv = 'N'
         and a.dr = 0
         and length(a.adjustperiod) <= p_period_length_max
         and decode(nvl(b.tallydate, 'Y'), 'Y', 1, 2) >= p_accounting
         and a.pk_currtype = p_currency_pk
         and a.periodv between '00' and (substr(p_end_date, 6, 2) || 'Z')
         and a.yearv = substr(p_end_date, 1, 4)
         and a.pk_accountingbook = xx.fibook_pk

      ),
      
      
     gl_verify_log_info as (
          
     
          select  tt.pk_verifydetail  pk_verifydetail_from_log0 ,
                  sum(tt.verifylocaldebitamount) verifylocaldebitamount , 
                  sum(tt.verifylocalcreditamount)  verifylocalcreditamount      
                  
          from   gl_verify_log tt 
          where   tt.byvoucherdate <= p_end_date || ' 23:59:59'
          and tt.dr = 0 
          group by tt.pk_verifydetail 
     
     )  , 
     
     
  
    
    
    gl_verify as
     (
      
      select xx.org_code,
              substr(ccc.code, 1, 4) subj_code_1j,
              decode(ggg.balanorient,
                     0,
                     aaa.localdebitamount -  aaa.localcreditamount - (nvl(fff.verifylocaldebitamount,0)- nvl(fff.verifylocalcreditamount,0)) ,
                     aaa.localcreditamount - aaa.localdebitamount  - (nvl(fff.verifylocalcreditamount,0) - nvl(fff.verifylocaldebitamount,0) )) bal,
              decode(ggg.balanorient, p_dir, '+', '-') bal_filter_dir_bz,
              eee.pk_cust_sup aux_pk,
              eee.code aux_code,
              eee.name aux_name,
              
             case
               when to_date(aaa.prepareddate, V_DATE_FORMAT_19) >
                     p_perious_date_0 then
                 decode(ggg.balanorient,
                        0,
                        aaa.localdebitamount -  aaa.localcreditamount - (nvl(fff.verifylocaldebitamount,0)- nvl(fff.verifylocalcreditamount,0)) ,
                        aaa.localcreditamount - aaa.localdebitamount  - (nvl(fff.verifylocalcreditamount,0) - nvl(fff.verifylocaldebitamount,0) ))
                else
                 0
              end bal_0,
              
              case 
                when 
                  to_date(aaa.prepareddate, V_DATE_FORMAT_19) <= p_perious_date_0
                  and 
                  to_date(aaa.prepareddate, V_DATE_FORMAT_19) >
                     p_perious_date_1 then
                 decode(ggg.balanorient,
                        0,
                        aaa.localdebitamount -  aaa.localcreditamount - (nvl(fff.verifylocaldebitamount,0)- nvl(fff.verifylocalcreditamount,0)) ,
                        aaa.localcreditamount - aaa.localdebitamount  - (nvl(fff.verifylocalcreditamount,0) - nvl(fff.verifylocaldebitamount,0) ))
                else
                 0
              end bal_1,
              
              case
                when to_date(aaa.prepareddate, V_DATE_FORMAT_19) <=
                     p_perious_date_1 and
                     to_date(aaa.prepareddate, V_DATE_FORMAT_19) >
                     p_perious_date_2 then
                 decode(ggg.balanorient,
                        0,
                    aaa.localdebitamount -  aaa.localcreditamount - (nvl(fff.verifylocaldebitamount,0)- nvl(fff.verifylocalcreditamount,0)) ,
                        aaa.localcreditamount - aaa.localdebitamount  - (nvl(fff.verifylocalcreditamount,0) - nvl(fff.verifylocaldebitamount,0) ))
                else
                 0
              end bal_2,
              case
                when to_date(aaa.prepareddate, V_DATE_FORMAT_19) <=
                     p_perious_date_2 and
                     to_date(aaa.prepareddate, V_DATE_FORMAT_19) >
                     p_perious_date_3 then
                 decode(ggg.balanorient,
                        0,
                       aaa.localdebitamount -  aaa.localcreditamount - (nvl(fff.verifylocaldebitamount,0)- nvl(fff.verifylocalcreditamount,0)) ,
                        aaa.localcreditamount - aaa.localdebitamount  - (nvl(fff.verifylocalcreditamount,0) - nvl(fff.verifylocaldebitamount,0) ))
                else
                 0
              end bal_3,
              case
                when to_date(aaa.prepareddate, V_DATE_FORMAT_19) <=
                     p_perious_date_3 and
                     to_date(aaa.prepareddate, V_DATE_FORMAT_19) >
                     p_perious_date_4 then
                 decode(ggg.balanorient,
                        0,
                      aaa.localdebitamount -  aaa.localcreditamount - (nvl(fff.verifylocaldebitamount,0)- nvl(fff.verifylocalcreditamount,0)) ,
                        aaa.localcreditamount - aaa.localdebitamount  - (nvl(fff.verifylocalcreditamount,0) - nvl(fff.verifylocaldebitamount,0) ))
                else
                 0
              end bal_4,
              case
                when to_date(aaa.prepareddate, V_DATE_FORMAT_19) <=
                     p_perious_date_4 and
                     to_date(aaa.prepareddate, V_DATE_FORMAT_19) >
                     p_perious_date_5 then
                 decode(ggg.balanorient,
                        0,
                        aaa.localdebitamount -  aaa.localcreditamount - (nvl(fff.verifylocaldebitamount,0)- nvl(fff.verifylocalcreditamount,0)) ,
                        aaa.localcreditamount - aaa.localdebitamount  - (nvl(fff.verifylocalcreditamount,0) - nvl(fff.verifylocaldebitamount,0) ))
                else
                 0
              end bal_5,
              case
                when to_date(aaa.prepareddate, V_DATE_FORMAT_19) <= p_perious_date_5 then
                 decode(ggg.balanorient,
                        0,
                        aaa.localdebitamount -  aaa.localcreditamount - (nvl(fff.verifylocaldebitamount,0)- nvl(fff.verifylocalcreditamount,0)) ,
                        aaa.localcreditamount - aaa.localdebitamount  - (nvl(fff.verifylocalcreditamount,0) - nvl(fff.verifylocaldebitamount,0) ))
                else
                 0
              end bal_6  
              
             
        from  
              bd_cust_supplier eee,
              gl_docfree1      ddd,
              bd_acctype       ggg,
              bd_account       ccc,
              bd_accasoa       bbb,
              gl_verify_log_info  fff,
              gl_verifydetail  aaa,
              orgbook_info     xx
       where 
         regexp_like(nvl(eee.code, '~'), p_aux_code_ks)
         and regexp_like(nvl(eee.name, '~'), p_aux_name_ks)
         and eee.pk_cust_sup =
             substr(ddd.f13 || ddd.f14,
                    decode(instr(ddd.f13 || ddd.f14, 'NN/A'), 1, 5, 1),
                    20)
         and ggg.pk_acctype = ccc.pk_acctype
         and ddd.assid = aaa.assid
         and not regexp_like(ccc.code, p_subj_exclude_code)
         and regexp_like(ccc.code, p_subj_code)
         and ccc.pk_account = bbb.pk_account
         and bbb.pk_accasoa = aaa.pk_accasoa 
         and fff.pk_verifydetail_from_log0(+) = aaa.pk_verifydetail  
         and aaa.dr = 0
         and aaa.prepareddate <= p_end_date || ' 23:59:59'
         and aaa.pk_accountingbook = xx.fibook_pk
      
      ),
    
    union_tmp_01 as
     (
      
      select  org_code,
              subj_code_1j,
              bal_filter_dir_bz,
              aux_pk,
              aux_code,
              aux_name,
              bal,
              0                 bal_age,
              0                 bal_0 , 
              0                 bal_1,
              0                 bal_2,
              0                 bal_3,
              0                 bal_4,
              0                 bal_5,
              0                 bal_6 , 
        localdebitamount , 
        localcreditamount , 
        bal_beg 
        from base_

      
      union all
      
      select org_code,
              subj_code_1j,
              bal_filter_dir_bz,
              aux_pk,
              aux_code,
              aux_name,
              0                 bal,
              bal               bal_age,
              bal_0,
              bal_1,
              bal_2,
              bal_3,
              bal_4,
              bal_5,
              bal_6 , 
        0 localdebitamount , 
        0 localcreditamount , 
        0 bal_beg 
        from gl_verify

      
      ),
      
      
    
    sum_tmp_union_01 as
     (
      
      select  org_code,
              subj_code_1j,
              bal_filter_dir_bz,
              aux_pk,
              aux_code,
              aux_name,
        sum(localdebitamount) localdebitamount,
        sum(localcreditamount) localcreditamount,
        sum(bal_beg) bal_beg,
              sum(bal) bal,
              sum(bal_age) bal_age,
              sum(bal) - sum(bal_age) bal_diff,
              sum(bal_0) bal_0 , 
              sum(bal_1) bal_1,
              sum(bal_2) bal_2,
              sum(bal_3) bal_3,
              sum(bal_4) bal_4,
              sum(bal_5) bal_5,
              sum(bal_6) bal_6,
              case bal_filter_dir_bz
                when '+' then
                 case
                   when sum(bal) >= 0 then
                    'Y+'
                   else
                    'N'
                 end
                when '-' then
                 case
                   when sum(bal) <= 0 then
                    'Y-'
                   else
                    'N'
                 end
              end selected_mark 
        from union_tmp_01
       group by org_code,
                 subj_code_1j,
                 bal_filter_dir_bz,
                 aux_pk,
                 aux_code,
                 aux_name 
                 )  , 
                 
     join_glf as 
     (
        select sum_tmp_union_01.* ,
        case 
            when 
                 nvl(glf_info.pk_cust_sup, 'X') = 'X' then  'N'    
            else 
               'Y' 
        end related_mark 
              
        from 
         glf_info , sum_tmp_union_01 
        where 
        glf_info.pk_cust_sup(+) = sum_tmp_union_01.aux_pk
     
     )
  
     select org_code,
           subj_code_1j  subj_code , 
       'a'  subj_name, 
       'a'  disp_name, 
             aux_pk,
             aux_code,
             aux_name,
       decode(selected_mark, 'Y+', bal_beg, -bal_beg) bal_beg,
             decode(selected_mark, 'Y+', localdebitamount, -localdebitamount) localdebitamount,
             decode(selected_mark, 'Y+', localcreditamount, -localcreditamount) localcreditamount,
             decode(selected_mark, 'Y+', bal, -bal) bal,
             decode(selected_mark, 'Y+', bal_age, -bal_age) bal_age,
             decode(selected_mark, 'Y+', bal_diff, -bal_diff) bal_diff,
             decode(selected_mark, 'Y+', bal_0, -bal_0) bal_0,
             decode(selected_mark, 'Y+', bal_1, -bal_1) bal_1,
             decode(selected_mark, 'Y+', bal_2, -bal_2) bal_2,
             decode(selected_mark, 'Y+', bal_3, -bal_3) bal_3,
             decode(selected_mark, 'Y+', bal_4, -bal_4) bal_4,
             decode(selected_mark, 'Y+', bal_5, -bal_5) bal_5,
             decode(selected_mark, 'Y+', bal_6, -bal_6) bal_6 , 
       0 bal_reserve  , 0  bal_reserve_0, 0  bal_reserve_1, 0 bal_reserve_2,
         0  bal_reserve_3, 0 bal_reserve_4,
         0 bal_reserve_5, 0 bal_reserve_6  , 
        'N' not_aux   ,  related_mark 
        from join_glf
       where selected_mark <> 'N'  and related_mark like p_related ;
     
  
  
  ---*************************************************************************************************************************************
  function f_arap(p_end_date          varchar2 default V_TMP_CURR_DATE_STR_10,
                              p_org_code          varchar2 default '102',
                              p_arap_class_hb        varchar2 default 'ar_fglf',
                              p_arap_class_dd     varchar2 default 'ap_fglf',
                              p_aux_code_ks       varchar2 DEFAULT '*',
                              p_aux_name_ks       varchar2 DEFAULT '*',
                              p_aux_code_ry       varchar2 DEFAULT '*',
                              p_aux_name_ry       varchar2 DEFAULT '*',
                              p_currency          varchar2 default 'CNY',
                              p_period_length_max number default 2,
                              p_accounting        number default 1 , 
                              p_cust_sup_class_code  varchar2 default SY_BASE.V_GLF_CLASS_CODE 
                              ) return nt_arap
    pipelined ; 
  
  
 
 
 
 
    
end sy_base;
/
create or replace package body sy_base is

  --ʹ�ó�����
  --�����������ƣ����ر��ֵ�����
  cursor cur_currency_pk(p_currency_name varchar2) is
    select PK_CURRTYPE
      from BD_CURRTYPE
     where code = upper(p_currency_name);

  --��������£��õ��·ݵ����һ�����һ��ʱ�̵�����
  function f_date_para_get_lst_monthday(p_year  varchar2 default '2016',
                                        p_month varchar2 default '06',
                                        p_grap  pls_integer default 0)
    return varchar2 is
    l_sql    varchar2(1024) := 'select  to_char(last_day(add_months(to_date(:1,''yyyyMMdd''), :2)) ,''yyyy-MM-dd'' ) diff_date from dual ';
    l_tmp    varchar2(10);
    l_return varchar2(19);
  begin
  
    execute immediate l_sql
      into l_tmp
      using p_year || p_month || '01', p_grap;
    l_return := l_tmp || ' 23:59:59';
    return l_return;
  
  exception
  
    when others then
    
      return sy_base.V_TMP_CURR_DATE_STR;
    
  end;

  --ʹ�ó��� : ���ݵ�λ���� , ��ȡ��֯���˲���Ϣ,��Ŀ��
  --����:  org_code  ��֯����
  --����ֵ:  ��֯�Ŀ�Ŀ��,�˲��ȼ�¼���͵�Ƕ�ױ�
  function f_org(p_org_code varchar2 default '101') return ty_nt_org
    pipelined is
    l_nt_org ty_nt_org := ty_nt_org();
    l_org    sy_base.cur_org%rowtype;
  begin
  
    if (p_org_code = '%') then
      l_org.fibook_pk := '%';
      l_org.org_pk    := '%';
      l_org.org_code  := '%';
      l_org.org_name  := '%';
      l_nt_org.extend;
      l_nt_org(1) := l_org;
    else
    
      open cur_org(p_org_code);
      fetch cur_org bulk collect
        into l_nt_org;
      close cur_org;
    
    end if;
  
    for x in 1 .. l_nt_org.count loop
      pipe row(l_nt_org(x));
    end loop;
    return;
  end;

  --ʹ�ó��� : ���ݵ�λ���� , ��ȡ��֯���˲���Ϣ,��Ŀ��ȼ�¼
  --����:  org_code  ��֯����
  --����ֵ:  ��֯�Ŀ�Ŀ��,�˲��ȼ�¼����
  function f_org_rec(p_org_code varchar2 default '101')
    return cur_org%rowtype is
    l_org cur_org%rowtype;
  begin
  
    if (p_org_code = '%') then
      l_org.fibook_pk := '%';
      l_org.org_pk    := '%';
      l_org.org_code  := '%';
      l_org.org_name  := '%';
    else
    
      for x in cur_org(p_org_code) loop
        if (cur_org%rowcount = 1) then
          l_org := x;
        end if;
        exit;
      end loop;
    
      if (cur_org%isopen) then
        close cur_org;
      end if;
    
    end if;
  
    return l_org;
  end;

  --*******************************************************************************************
  function f_subj_info(p_subj_code varchar2, p_org_code varchar2)
    return nt_subj_info
    pipelined is
    l_rtn nt_subj_info := new nt_subj_info();
  begin
    open cur_subj_info(p_subj_code, p_org_code);
    fetch cur_subj_info bulk collect
      into l_rtn;
    close cur_subj_info;
  
    for x in 1 .. l_rtn.count loop
      pipe row(l_rtn(x));
    end loop;
  
    return;
  end;

  --*****************************************************************************************************************
  --ʹ�ó��� �� �ӽ��Ǽǲ���ȡ�� 
  function f_loanregist(p_org_code  varchar2 default '101', --��֯
                        p_loan_type varchar2 default 'yc', -- ��ʽ
                        p_end_year  varchar2 default substr(V_TMP_CURR_DATE_STR,
                                                            1,
                                                            4),
                        p_end_month varchar2 default substr(V_TMP_CURR_DATE_STR,
                                                            6,
                                                            2))
    return nt_loanregist
    pipelined is
    l_rec_org  cur_org%rowtype;
    l_tbl_rtn  nt_loanregist := new nt_loanregist();
    l_end_date varchar2(19) := sy_base.f_date_para_get_lst_monthday(p_end_year,
                                                                    substr(p_end_month,
                                                                           1,
                                                                           2),
                                                                    0);
  begin
    l_rec_org := f_org_rec(p_org_code);
    open cur_loanregist(l_rec_org.org_pk, p_loan_type, l_end_date);
    fetch cur_loanregist bulk collect
      into l_tbl_rtn;
    close cur_loanregist;
  
    for x in 1 .. l_tbl_rtn.count loop
      pipe row(l_tbl_rtn(x));
    end loop;
    return;
  end;

  --***********************************************************************************************************************8
  --ʹ�ó��� �� �ӱ����Ǽǲ���ȡ�� 
  function f_guarregist(p_org_code  varchar2 default '101', --��֯
                        p_guar_type varchar2 default 'LY', -- ��ʽ
                        p_end_year  varchar2 default substr(V_TMP_CURR_DATE_STR,
                                                            1,
                                                            4),
                        p_end_month varchar2 default substr(V_TMP_CURR_DATE_STR,
                                                            6,
                                                            2))
    return nt_guarregist
    pipelined is
    l_rec_org  cur_org%rowtype;
    l_tbl_rtn  nt_guarregist := new nt_guarregist();
    l_end_date varchar2(19) := sy_base.f_date_para_get_lst_monthday(p_end_year,
                                                                    substr(p_end_month,
                                                                           1,
                                                                           2),
                                                                    0);
  begin
    l_rec_org := f_org_rec(p_org_code);
    open cur_guarregist(l_rec_org.org_pk, p_guar_type, l_end_date);
    fetch cur_guarregist bulk collect
      into l_tbl_rtn;
    close cur_guarregist;
  
    for x in 1 .. l_tbl_rtn.count loop
      pipe row(l_tbl_rtn(x));
    end loop;
    return;
  end;

  --***********************************************************************************************************************8
  --ʹ�ó��� �� ��Ʊ�ݵǼǲ���ȡ�� 
  function f_billregist(p_org_code   varchar2 default '101', --��֯
                        p_vouch_type varchar2 default 'YCYS', -- Ʊ������
                        p_end_year   varchar2 default substr(V_TMP_CURR_DATE_STR,
                                                             1,
                                                             4),
                        p_end_month  varchar2 default substr(V_TMP_CURR_DATE_STR,
                                                             6,
                                                             2))
    return nt_billregist
    pipelined is
    l_rec_org  cur_org%rowtype;
    l_tbl_rtn  nt_billregist := new nt_billregist();
    l_end_date varchar2(19) := sy_base.f_date_para_get_lst_monthday(p_end_year,
                                                                    substr(p_end_month,
                                                                           1,
                                                                           2),
                                                                    0);
  begin
    l_rec_org := f_org_rec(p_org_code);
    open cur_billregist(l_rec_org.org_pk, p_vouch_type, l_end_date);
    fetch cur_billregist bulk collect
      into l_tbl_rtn;
    close cur_billregist;
  
    for x in 1 .. l_tbl_rtn.count loop
      pipe row(l_tbl_rtn(x));
    end loop;
    return;
  end;


  --�ж��ַ����Ƿ��� ��Ŀ NTǶ�ױ���
  procedure p_aux_str_single_nt_match(p_str              varchar2,
                                      p_nt_subj_info_dzz nt_subj_info_dzz,
                                      p_find_mark        in out nocopy boolean) is
  
  begin
  
    p_find_mark := false;
  
    if (p_str is null) then
    
      return;
    
    end if;
  
    --����  ��Ŀ��ϸǶ�ױ��ҷ���PK�Ŀ�Ŀ��Ϣ������ҵ��� �����ҵ���־ ,�˳�����ѭ��
  
    for y in 1 .. p_nt_subj_info_dzz.count loop
    
      if (p_str = p_nt_subj_info_dzz(y).pk_accasoa) then
      
        p_find_mark := true;
      
        exit;
      
      end if;
    
    end loop;
  
  end;


  --���ݶԷ���Ŀ��ƾ֤�еĿ�Ŀ��Ϣ�� �Աȿ�ĿǶ�ױ����ƾ֤�п�Ŀ��Ϣ�ڿ�ĿǶ�ױ����У���ѡ�д�ƾ֤��
  --���ѡ�еĶԷ���Ŀ��ƾ֤�еķ������� ԭƾ֤�еĽ�������17%���ң����������෴��������ѡ�жԷ���Ŀƾ֤��

  procedure p_gldetail_oppo_aux_2(p_source_gl_detail_row cur_gldetail_self%rowtype,
                    p_nt_gl_detail         nt_gldetail_self,
                    p_nt_oppo_subj_info    nt_subj_info_dzz,
                    p_tbl_rtn              in out nocopy nt_gldetail_self) is
  
    l_find_mark boolean := false;
  
    l_last_mark boolean := false;
    
    
    l_ntx_integer     ntx_integer ; 
    
    l_tmp_number_total   number(28,8 )   := 0 ; 
    
    l_tmp_number_total_last number(28,8) :=  0 ; 
    
    l_count pls_integer  := 0;  
    
    l_small_amount_total_mark boolean := false;  
  begin
  
    --���� �Է�ƾ֤�У��ж�ƾ֤�еĿ�Ŀ��Ϣ�Ƿ��� ��ĿǶ�ױ���
  
    for x in 1 .. p_nt_gl_detail.count loop
    
      l_last_mark := false;
    
      p_aux_str_single_nt_match(p_nt_gl_detail(x).pk_accasoa,
                                p_nt_oppo_subj_info,
                                l_find_mark);
    
      if (l_find_mark) then
      
      
          
            if (abs(p_nt_gl_detail(x).local_amount) <=
               abs(p_source_gl_detail_row.local_amount) * 1.2 and
               
               abs(p_nt_gl_detail(x).local_amount) >=
               abs(p_source_gl_detail_row.local_amount) / 1.2 
               
               and  p_nt_gl_detail(x).local_amount * p_source_gl_detail_row.local_amount >= 0  )   then --�ж��Ƿ����һ�� ����Ϊ������Ϊ��
              
            
                l_last_mark := true;
              
           else if (   abs(p_nt_gl_detail(x).local_amount) <
               abs(p_source_gl_detail_row.local_amount) / 1.2  and 
               p_nt_gl_detail(x).local_amount * p_source_gl_detail_row.local_amount >= 0  ) then 

                 

                  l_tmp_number_total := l_tmp_number_total +  p_nt_gl_detail(x).local_amount ; 
                  
                  
                  if( abs(l_tmp_number_total)   <=     abs(p_source_gl_detail_row.local_amount) * 1.2 ) then    --�ӵ�  �Է�ƾ֤�н���1.2����ʱ���Ժ���оͲ�Ҫ����   
                  
                        l_tmp_number_total_last :=  l_tmp_number_total  ; 
                        l_count := l_count +1 ; 
                        
                        l_ntx_integer(l_count) :=   x ;   
                        
                        l_small_amount_total_mark :=true; 
                  
                  
                   
                  
                  end if; 
             else 
               
                null;      
            
            end if;
          
         end if; 
      
        if (l_last_mark) then
        
          p_tbl_rtn.extend;
          p_tbl_rtn(p_tbl_rtn.count) := p_nt_gl_detail(x);
          l_small_amount_total_mark :=false;       --������ �Խ���С���н��л��ܺ���  �Է�ƾ֤�еĽ��  ���бȽ�
        
          exit;
        
        end if;
        
  
      
      end if;
    
    end loop;
    
    if(l_small_amount_total_mark ) then    --����Щ����С���е��ܽ������������Ƿ��� �Է�ƾ֤ �еĽ�� ������� 
        
          if(    abs(l_tmp_number_total_last )  >=  abs(p_source_gl_detail_row.local_amount) / 1.2    ) then 
          
                     for   j   in  1  .. l_count loop 
                          p_tbl_rtn.extend;
                          p_tbl_rtn(p_tbl_rtn.count) := p_nt_gl_detail( l_ntx_integer(j));
                     
                     end loop;  
          
          end if; 
    
    
    end if; 
    
  
  end;
  
  
 
   ---����ƾ֤ID���ҵ����е�ƾ֤����Ϣ

  procedure p_gldetail_oppo_aux_1(p_nt_source_gldetail_row cur_gldetail_self%rowtype,
                    p_nt_gl_detail           in out nocopy nt_gldetail_self) is
    l_count pls_integer;
  begin
    l_count        := 0;
    p_nt_gl_detail := nt_gldetail_self();
    for z in cur_gldetail_by_voucher(p_nt_source_gldetail_row.pk_voucher,
                                     p_nt_source_gldetail_row.pk_currtype) loop
      p_nt_gl_detail.extend;
      l_count := l_count + 1;
      p_nt_gl_detail(l_count) := z;
      p_nt_gl_detail(l_count).org_code := p_nt_source_gldetail_row.org_code; 
      p_nt_gl_detail(l_count).org_pk := p_nt_source_gldetail_row.org_pk; 
      p_nt_gl_detail(l_count).org_name := p_nt_source_gldetail_row.org_name; 
      p_nt_gl_detail(l_count).org_pk_oppo := p_nt_source_gldetail_row.org_pk_oppo;  
      p_nt_gl_detail(l_count).org_code_oppo := p_nt_source_gldetail_row.org_code_oppo; 
      p_nt_gl_detail(l_count).org_name_oppo := p_nt_source_gldetail_row.org_name_oppo;   
    
    end loop;
  
  end;
  
  
  

  --�����ԣ��ָ���ַ������ж� ÿ���ָ��С�ַ����Ƿ���   NTǶ�ױ���
  procedure p_aux_str_nt_match(p_str_by_comma     varchar2,
                               p_nt_subj_info_dzz nt_subj_info_dzz,
                               p_find_mark        in out nocopy boolean) is
    l_find_mark_oppo_subj_list_str boolean := false;
    l_oppo_subj_list_str           gl_detail.oppositesubj%type;
    l_oppo_subj_list               gl_detail.oppositesubj%type;
  begin
  
    p_find_mark := false;
  
    if (p_str_by_comma is null) then
    
      return;
    
    end if;
  
    l_oppo_subj_list_str := p_str_by_comma;
  
    --ÿ�δ� l_oppo_subj_list_str ȡ��20���ַ��� ʣ�µģ���ȥ��ʼ�� ����������l_oppo_subj_list_str
    --���½��и�ֵ ��ֱ���Ҳ���  ����������Ϊֹ�� �˳�ѭ��
    --����ҵ���־λTURE����Ҳ�˳�ѭ��
  
    loop
    
      l_oppo_subj_list := substr(l_oppo_subj_list_str, 1, 20);
    
      --����  ��Ŀ��ϸǶ�ױ��ҷ���PK�Ŀ�Ŀ��Ϣ������ҵ��� �����ҵ���־ ,�˳�����ѭ��
    
      for y in 1 .. p_nt_subj_info_dzz.count loop
      
        if (l_oppo_subj_list = p_nt_subj_info_dzz(y).pk_accasoa) then
        
          l_find_mark_oppo_subj_list_str := true;
        
          exit;
        
        end if;
      
      end loop;
    
      if (l_find_mark_oppo_subj_list_str) then
      
        p_find_mark := true;
      
        exit;
      
      end if;
    
      if (instr(l_oppo_subj_list_str, ',') = 0) then
      
        exit;
      
      end if;
    
      l_oppo_subj_list_str := substr(l_oppo_subj_list_str,
                                     instr(l_oppo_subj_list_str, ',') + 1);
    
    end loop;
  
  end;


  
   ---���ݶԷ���Ŀ�б��ַ������ڶԷ���ĿǶ�ױ��в��ҷ������������������ҵ������ƾ֤����Ϣ������
  procedure p_gldetail_oppo_aux_0(p_nt_source_gl_detail          nt_gldetail_self,
                    p_nt_source_gl_detail_filtered in out nocopy nt_gldetail_self,
                    p_nt_subj_info_dzz             nt_subj_info_dzz) is
    l_count     pls_integer;
    l_find_mark boolean := false;
  begin
    l_count := 0;
  
    for x in 1 .. p_nt_source_gl_detail.count loop
    
      l_find_mark := false;
    
      p_aux_str_nt_match(p_nt_source_gl_detail(x).oppositesubj,
                         p_nt_subj_info_dzz,
                         l_find_mark);
    
      if (l_find_mark) then
      
        p_nt_source_gl_detail_filtered.extend;
        l_count := l_count + 1;
        p_nt_source_gl_detail_filtered(l_count) := p_nt_source_gl_detail(x);
      
      end if;
    
    end loop;
  
  end;


  
--&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
     
   procedure  p_zlhx_aux ( p_zlb  in out    ntx_number  )
     is
    
     begin
         
          for x in 1 ..  p_zlb.count loop 
             
              if(p_zlb(x) < 0 ) then 
              
                  for  y in 1  .. p_zlb.count  loop 
                    
                       if(   (x <> y)   AND   (p_zlb(y) > 0)  ) then 
                       
                              if(   abs(  p_zlb(y)  )   >=    abs( p_zlb(x) )  ) then 
                              
                                     p_zlb(y)   :=  p_zlb(y)   +   p_zlb(x)   ; 
                                     p_zlb(x)   := 0 ; 
                                     
                              else 
                                      
                                     p_zlb(x)  :=     p_zlb(x)  + p_zlb(y)    ; 
                                     p_zlb(y) :=  0 ; 
                                      
                              
                              end if;  
                       
                            
                             
                       end if; 
                       
                       if(  p_zlb(x)  = 0 ) then 
                       
                             exit; 
                       
                       end  if; 
                  
                  end loop ; 
              
               end if; 
          
          end loop; 
     
     end ; 
     
     
     
     
     
    procedure  p_zlhx(p_nt_zlb  in out nocopy  nt_arap) 
      
    is
    
    l_ntx_number  ntx_number; 
    
    begin 
      
        
       for x  in 1  ..  p_nt_zlb.count loop
         
            l_ntx_number(1) := p_nt_zlb(x).bal_0 ;
            l_ntx_number(2) := p_nt_zlb(x).bal_1 ; 
            l_ntx_number(3) :=p_nt_zlb(x).bal_2; 
            l_ntx_number(4) :=p_nt_zlb(x).bal_3; 
            l_ntx_number(5) :=p_nt_zlb(x).bal_4; 
            l_ntx_number(6) :=p_nt_zlb(x).bal_5; 
            l_ntx_number(7) :=p_nt_zlb(x).bal_6; 
            
            p_zlhx_aux(l_ntx_number) ; 
            
            p_nt_zlb(x).bal_0 := l_ntx_number(1) ; 
            p_nt_zlb(x).bal_1 := l_ntx_number(2) ; 
            p_nt_zlb(x).bal_2 := l_ntx_number(3) ; 
            p_nt_zlb(x).bal_3 := l_ntx_number(4) ; 
            p_nt_zlb(x).bal_4 := l_ntx_number(5) ; 
            p_nt_zlb(x).bal_5 := l_ntx_number(6) ; 
            p_nt_zlb(x).bal_6 := l_ntx_number(7) ; 

       end loop; 
    
    end ;    

     
     



  function f_cashflow(p_end_date          varchar2 default '2016-06-30',
                      p_org_code          varchar2 default '*',
                      p_cashflow_item     varchar2 default '*',
                      p_subj_code         varchar2 default '*',
                      p_accounting        number default 1,
                      p_period_length_max number default 2,
                      p_currency          varchar2 default 'CNY',
                      p_beg_month         varchar2 default '01',
                      p_subj_exclude_code varchar2 default 'aabbcc',
                      p_dir               number default 0)
    return nt_cur_cashflow
    pipelined is
    l_tbl         nt_cur_cashflow := nt_cur_cashflow();
    l_currency_pk varchar2(20);
  begin
  
    for y in cur_currency_pk(p_currency) loop
    
      l_currency_pk := y.PK_CURRTYPE;
    
    end loop;
  
    open cur_cashflow(p_end_date,
                      p_org_code,
                      p_cashflow_item,
                      p_subj_code,
                      p_subj_exclude_code,
                      p_accounting,
                      p_period_length_max,
                      p_dir,
                      l_currency_pk,
                      p_beg_month);
    fetch cur_cashflow bulk collect
      into l_tbl;
    close cur_cashflow;
  
    for x in 1 .. l_tbl.count loop
    
      pipe row(l_tbl(x));
    end loop;
  
  end;

  ----$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

  function f_cashflow_total(p_end_date          varchar2 default '2016-06-30',
                            p_org_code          varchar2 default '*',
                            p_cashflow_item     varchar2 default '*',
                            p_accounting        number default 1,
                            p_period_length_max number default 3,
                            p_currency          varchar2 default 'CNY',
                            p_beg_month         varchar2 default '01')
    return nt_cur_cashflow_total
    pipelined is
    l_tbl         nt_cur_cashflow_total := nt_cur_cashflow_total();
    l_currency_pk varchar2(20);
  begin
  
    for y in cur_currency_pk(p_currency) loop
    
      l_currency_pk := y.PK_CURRTYPE;
    
    end loop;
  
    open cur_cashflow_total(p_end_date,
                            p_org_code,
                            p_cashflow_item,
                            p_accounting,
                            p_period_length_max,
                            l_currency_pk,
                            p_beg_month);
    fetch cur_cashflow_total bulk collect
      into l_tbl;
    close cur_cashflow_total;
  
    for x in 1 .. l_tbl.count loop
    
      pipe row(l_tbl(x));
    end loop;
  
  end;





 function f_gldetail_self(p_beg_date_19           varchar2 default V_TMP_BEGIN_DATE_STR,
                                     p_end_date_19           varchar2 default V_TMP_CURR_DATE_STR,
                                     p_subj_code_reg         varchar2 DEFAULT '^1122.*$',
                                     p_subj_code_exclude_reg  varchar2 default '^a.*$' , 
                                     p_org_code              varchar2 default sy_base.V_TMP_ORG_CODE,
                                     p_accur_dir             varchar2 default 'dr', --ȡ�跽������Ǵ���������
                                     p_accur_positive_minus  varchar2 default 'zheng', --ȡ��������������Ǹ���
                                     p_voucher_type_name_reg varchar2 default 'ת��ƾ֤',
                                     p_currency_pk           varchar2 default '1002Z0100000000001K1',
                                     p_period_length_max     number default 3,
                                     p_accounting            number default 1,
                                     p_related               varchar2 default '*'   , 
                                     p_cust_sup_class_code   varchar2 default  V_GLF_CLASS_CODE 
                                     ) 
return nt_gldetail_self
pipelined 
is
l_rtn   nt_gldetail_self  := new nt_gldetail_self() ; 
begin 
  
    open cur_gldetail_self(p_beg_date_19    ,
                                     p_end_date_19          ,
                                     p_subj_code_reg        ,
                                     p_subj_code_exclude_reg   , 
                                     p_org_code             ,
                                     p_accur_dir          ,
                                     p_accur_positive_minus ,
                                     p_voucher_type_name_reg ,
                                     p_currency_pk          ,
                                     p_period_length_max     ,
                                     p_accounting      ,
                                     p_related   , 
                                     p_cust_sup_class_code
                                        ) ; 
    fetch cur_gldetail_self bulk collect into l_rtn ; 
    
    close cur_gldetail_self ; 
    
    for x in 1 .. l_rtn.count loop 
      
        pipe row(l_rtn(x)) ; 
    end loop; 
   
   return; 
end ; 





--&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

 function f_gldetail_by_voucher(  voucher_pk  varchar2,
                                  currency_pk varchar2 default V_RMB_PK) 
 return  nt_gldetail_self 
 pipelined 
 is
 l_rtn   nt_gldetail_self   :=  new nt_gldetail_self() ; 
 begin 
   
   open cur_gldetail_by_voucher( voucher_pk , currency_pk ) ; 
   fetch cur_gldetail_by_voucher bulk collect into l_rtn ; 
   close cur_gldetail_by_voucher ; 
   
   for x in 1 .. l_rtn.count loop 
     
       pipe row (l_rtn(x) ) ; 
   
   end loop; 
   
   return ; 
   
   exception 
            when others then 
              
             
            if( cur_gldetail_by_voucher  % isopen ) then 
                 
                        close cur_gldetail_by_voucher  ; 
              
              end if; 
              
 end ; 





--***************************************************************************************************************************************************
  function  f_get_oppo_gldetail (
                 p_org_code             varchar2 default '101' , 
                 p_end_year             varchar2 DEFAULT '2016',
                 p_end_month            varchar2 DEFAULT '10',
                 p_subj_code_reg            varchar2 DEFAULT '^1122.*$',  
				         p_subj_code_exclude_reg  varchar2 default '^a.*$' , 
                 p_oppo_subj_code_reg       varchar2 default  '(^1403.*$)|(^1604.*$)|(^1601.*$)|(^1405.*$)',    
                 p_accur_dir  varchar2  default 'dr' ,    --ȡ�跽������Ǵ���������
                 p_accur_positive_minus varchar2  default 'zheng'  ,  --ȡ��������������Ǹ���
                 p_voucher_type_name_reg     varchar2 default '*'  ,        
                 p_currency             varchar2  default 'CNY',
                 p_period_length_max    number default 3 , 
                 p_accounting           number default 1 ,
                 p_related       varchar2 default '*'   , 
                 p_aux_code      varchar2 default '*' , 
                 p_aux_name      varchar2 default  '*'  , 
                 p_cust_sup_class_code   varchar2 default  V_GLF_CLASS_CODE 
            
   )  
   return   nt_gldetail_self 
   pipelined 
   is
   --���ڴ��ָ����Ŀ��ƾ֤��ϸ���б�
   l_nt_source_gldetail_bef   nt_gldetail_self := new nt_gldetail_self() ; 
   l_nt_source_gldetail       nt_gldetail_self := new nt_gldetail_self() ; 
   
   --��������ֵ
   l_tbl_rtn   nt_gldetail_self  := new   nt_gldetail_self() ;
   
   l_currency_pk  varchar2(20) ; 
   l_org_rec  sy_base.cur_org%rowtype ;
   
   l_nt_oppo_subj_info   nt_subj_info_dzz  :=new nt_subj_info_dzz() ; 
   
   

   ---�����ݴ��Ÿ���ƾ֤voucher_pk��ѯ�õ���ƾ֤��ϸ��
   l_nt_gl_detail   nt_gldetail_self   ;
  
   l_count  pls_integer :=  0 ; 
   
   
   l_end_date_19  varchar2(19) :=   f_date_para_get_lst_monthday(p_year => p_end_year , p_month => p_end_month, p_grap => 0) ;
   l_beg_date_19  varchar2(19) :=   p_end_year || '-01-01 01:01:01'  ; 
   

   

   begin 
          
      open cur_currency_pk(p_currency) ; 
      fetch cur_currency_pk into  l_currency_pk ; 
      close cur_currency_pk ; 
      
      open  cur_org ( p_org_code); 
      fetch cur_org  into l_org_rec;
      close cur_org ; 
      
      
      --�õ��Է���Ŀ�б�
     l_count := 0 ; 
     for x  in  cur_subj_info_dzz(p_oppo_subj_code_reg , p_org_code)  loop 
            l_nt_oppo_subj_info.extend;  
            l_count := l_count +1 ; 
            l_nt_oppo_subj_info(l_count)  :=  x ; 
     end loop ; 
     
     --�Է���Ŀ�б�Ϊ�գ����˳�����
     if(l_count = 0) then 
     
         return ; 
     
     end if; 
     
     
     
      --�õ�����������ƾ֤�С���ϸ

      open cur_gldetail_self(
                 l_beg_date_19       , 
                 l_end_date_19       , 
                 p_subj_code_reg     , 
				         p_subj_code_exclude_reg ,
                 p_org_code,
                 p_accur_dir  ,
                 p_accur_positive_minus ,
                 p_voucher_type_name_reg    , 
                 l_currency_pk   ,
                 p_period_length_max   , 
                 p_accounting   ,
                 p_related , 
                 p_aux_code , 
                 p_aux_name , 
                 p_cust_sup_class_code
       )     ;
       fetch  cur_gldetail_self bulk collect into l_nt_source_gldetail_bef ; 
       close cur_gldetail_self; 
       
       --����ƾ֤�У�ֻ���¶Է���Ŀ�ڿ�ĿǶ�ױ��е�ƾ֤��
       p_gldetail_oppo_aux_0(l_nt_source_gldetail_bef , l_nt_source_gldetail , l_nt_oppo_subj_info) ; 
       
       
       
       for x in  1 ..  l_nt_source_gldetail.count loop  
               
             
        
           
           -- 1   ���� ƾ֤�������õ� ƾ֤��������    �� �����һ�� ��ѭ��
           
                     l_nt_gl_detail := null; 
                     p_gldetail_oppo_aux_1(  l_nt_source_gldetail(x) , l_nt_gl_detail  ) ;
           
           
           -- 2  ��ƾ֤���������У������жϱ��еĿ�Ŀ���ԣ��Ƿ���ƾ֤�б��еĿ�Ŀ����һ�� �� ����Ƿ�������  �� ����ڶ�����ѭ��
           
                    
                    
                     p_gldetail_oppo_aux_2(l_nt_source_gldetail(x),
                             l_nt_gl_detail , 
                             l_nt_oppo_subj_info , 
                             l_tbl_rtn ) ; 
                        
           
           
           --3  �����2���ҵ��ˣ� �� �˳��ڶ����� ѭ�������»ص���һ����ѭ��  �� 
           
           
           
           
       
     
       end loop ; 
       
       
       for  xx in 1 .. l_tbl_rtn.count loop 
         
            pipe row(l_tbl_rtn(xx)) ; 
            
       end loop; 
       
       return ;
       
       
       exception 
         
          when others then 
            
              if( cur_gldetail_self  % isopen ) then 
                 
                        close cur_gldetail_self  ; 
              
              end if; 
              
          
              
   
   end ;  




---*************************************************************************************************************************************
  function f_arap(p_end_date  varchar2 default V_TMP_CURR_DATE_STR_10,
                              p_org_code          varchar2 default '102',
                              p_arap_class_hb        varchar2 default 'ar_fglf',
                              p_arap_class_dd     varchar2 default 'ap_fglf',
                              p_aux_code_ks       varchar2 DEFAULT '*',
                              p_aux_name_ks       varchar2 DEFAULT '*',
                              p_aux_code_ry       varchar2 DEFAULT '*',
                              p_aux_name_ry       varchar2 DEFAULT '*',
                              p_currency          varchar2 default 'CNY',
                              p_period_length_max number default 2,
                              p_accounting        number default 1, 
                              p_cust_sup_class_code  varchar2 default SY_BASE.V_GLF_CLASS_CODE 
                              ) return nt_arap
    pipelined is
    l_rtn_1 nt_arap := nt_arap();
    
    l_rtn_2  nt_arap := nt_arap(); 

    l_currency_pk varchar2(20);
  
    --��������Ŀ�Ŀ���뷽��
    l_subj_code_1       varchar2(200);
    l_subj_code_2       varchar2(200);
    --�������Ŀ�Ŀ���뷽��
    l_subj_exclude_code_1       varchar2(200);
    l_subj_exclude_code_2       varchar2(200);
  
    --ȷ�����������ʲ��͸�ծ��������Ȩ�������
    l_dir_1   bd_acctype.balanorient%type;
    l_dir_2   bd_acctype.balanorient%type;
    --���˹�����                                                                          
    l_glf_filter_1 varchar2(1) := 'X';
    l_glf_filter_2 varchar2(1) := 'X';
  
    ---������Ա�����������ȡ���Ŀ�Ŀ�б���,���зָ�
    l_psn_subj_list_1       varchar2(2000);
    l_psn_subj_list_2       varchar2(2000);
  
    --�����ѯ���ڣ�����ǰ�� 1��ǰ��2��ǰ��3��ǰ��4��ǰ��5��ǰ�����ڱ����������������
    l_now_date       date;
    l_perious_date_0 date;
    l_perious_date_1 date;
    l_perious_date_2 date;
    l_perious_date_3 date;
    l_perious_date_4 date;
    l_perious_date_5 date;
  
  
    --��¼��������������ܵĺϼ�ֵ
    --l_total_sum sy_base.cur_arap_dd%rowtype;
    
    
    --���������������
    --l_zlb    ntx_number; 
    
  
  begin
  
    for x in cur_currency_pk(p_currency) loop
    
      l_currency_pk := x.PK_CURRTYPE;
    
    end loop;
  
    case
    
      when p_arap_class_hb = 'ysfl_fglf_1jkmhb_hz' then     --Ӧ���˿���࣬ �ǹ����� 
        l_subj_code_1           := '(^1122.*$)|(^2203.*$)';
        l_subj_exclude_code_1     := '^1122002.*$';
        l_dir_1                   := 0;
        l_glf_filter_1          := 'N';
        l_psn_subj_list_1         := 'a';
        
        
      when p_arap_class_hb = 'ysfl_glf_1jkmhb_hz' then     --Ӧ���˿���࣬ ������ 
        l_subj_code_1           := '(^1122.*$)|(^2203.*$)';
        l_subj_exclude_code_1     := '^1122002.*$';
        l_dir_1                   := 0;
        l_glf_filter_1          := 'Y';
        l_psn_subj_list_1         := 'a';
        
      when p_arap_class_hb = 'ysfl_zlze_1jkmhb_hz' then     --Ӧ���˿������������࣬ ������ 
        l_subj_code_1           := '(^1122.*$)|(^2203.*$)';
        l_subj_exclude_code_1     := '^1122002.*$';
        l_dir_1                   := 0;
        l_glf_filter_1          := '%';
        l_psn_subj_list_1         := 'a';
       
    
      when p_arap_class_hb = 'glfjy_ys_kmhb_hz' then     --���������ף� Ӧ���˿�
        l_subj_code_1           := '^1122.*$';
        l_subj_exclude_code_1     := '^1122002.*$';
        l_dir_1                   := 0;
        l_glf_filter_1          := 'Y';
        l_psn_subj_list_1         := 'a';
        
        
        when p_arap_class_hb = 'glfjy_ys2_kmhb_hz' then     --���������ף� Ӧ���˿�  , �����˹�����
        l_subj_code_1           := '^1122.*$';
        l_subj_exclude_code_1     := '^1122002.*$';
        l_dir_1                   := 0;
        l_glf_filter_1          := '%';
        l_psn_subj_list_1         := 'a';
        
       
        

      when p_arap_class_hb = 'ysfl_yshk_1jkmhb_hz' then     --Ԥ�� �˿��еĻ���
        l_subj_code_1           := '^1122.*$';
        l_subj_exclude_code_1     := '^1122002.*$';
        l_dir_1                   := 1;
        l_glf_filter_1          := '%';
        l_psn_subj_list_1         := 'a';
        
      when p_arap_class_hb = 'ysfl_ys_1jkmhb_hz' then     --Ԥ�� �˿��е�ȫ��
        l_subj_code_1           := '^1122.*$';
        l_subj_exclude_code_1     := '^1122002.*$';
        l_dir_1                   := 1;
        l_glf_filter_1          := '%';
        l_psn_subj_list_1         := 'a';   
        
        
       when p_arap_class_hb = 'ysfl_ystop_1jkmhb_hz' then     --Ԥ�� �˿�  TOP
        l_subj_code_1           := '^1122.*$';
        l_subj_exclude_code_1     := '^1122002.*$';
        l_dir_1                   := 1;
        l_glf_filter_1          := '%';
        l_psn_subj_list_1         := 'a';   
        
        
        when p_arap_class_hb = 'glfjy_yszk_ys_kmhb_hz' then     --���������ף�Ԥ���˿�
        l_subj_code_1           := '^1122.*$';
        l_subj_exclude_code_1     := '^1122002.*$';
        l_dir_1                   := 1;
        l_glf_filter_1          := 'Y';
        l_psn_subj_list_1         := 'a';   
        
        
        
        when p_arap_class_hb = 'glfjy_yszk_ys2_kmhb_hz' then     --���������ף�Ԥ���˿� �� �����˹�����     
        l_subj_code_1           := '^1122.*$';
        l_subj_exclude_code_1     := '^1122002.*$';
        l_dir_1                   := 1;
        l_glf_filter_1          := '%';
        l_psn_subj_list_1         := 'a';   
         
        
        
      
      when p_arap_class_hb = 'yfzk_zlmx_kmhb_hz' then     -- Ԥ���˿�������
        l_subj_code_1           := '(^2202001.*$)|(^2202005.*$)';
        l_subj_exclude_code_1     := '^a.*$';
        l_dir_1                   := 0;
        l_glf_filter_1          := '%';
        l_psn_subj_list_1         := 'a';   
        

        
        
         
      when p_arap_class_hb = 'yfzk_top5_kmhb_hz' then     -- Ԥ���˿ top5
        l_subj_code_1           := '(^2202001.*$)|(^2202005.*$)';
        l_subj_exclude_code_1     := '^a.*$';
        l_dir_1                   := 0;
        l_glf_filter_1          := '%';
        l_psn_subj_list_1         := 'a';   
        
        
       when p_arap_class_hb = 'glfjy_yfzk_yf_kmhb_hz' then     -- ���������ף� Ԥ���˿�
        l_subj_code_1           := '(^2202001.*$)|(^2202005.*$)';
        l_subj_exclude_code_1     := '^a.*$';
        l_dir_1                   := 0;
        l_glf_filter_1          := 'Y';
        l_psn_subj_list_1         := 'a';     
        
        
       when p_arap_class_hb = 'glfjy_yfzk_yf2_kmhb_hz' then     -- ���������ף� Ԥ���˿� , �����˹�����
        l_subj_code_1           := '(^2202001.*$)|(^2202005.*$)';
        l_subj_exclude_code_1     := '^a.*$';
        l_dir_1                   := 0;
        l_glf_filter_1          := '%';
        l_psn_subj_list_1         := 'a';     
        
        
        
        
    
        when p_arap_class_hb = 'yfzk_yfzk_hk_kmhb_hz' then     -- Ӧ���˿ ����
        l_subj_code_1           := '(^2202001.*$)|(^2202005.*$)';
        l_subj_exclude_code_1     := '^a.*$';
        l_dir_1                   := 1;
        l_glf_filter_1          := '%';
        l_psn_subj_list_1         := 'a';   
        
       when p_arap_class_hb = 'yfzk_yfzk_hj_kmhb_hz' then     --Ӧ���˿  �ϼ�
        l_subj_code_1           := '(^2202001.*$)|(^2202005.*$)';
        l_subj_exclude_code_1     := '^a.*$';
        l_dir_1                   := 1;
        l_glf_filter_1          := '%';
        l_psn_subj_list_1         := 'a';    
        
        
       when p_arap_class_hb = 'yfzk_yfzk_1n_kmhb_hz' then     --Ӧ���˿  �ϼ�
        l_subj_code_1           := '(^2202001.*$)|(^2202005.*$)';
        l_subj_exclude_code_1     := '^a.*$';
        l_dir_1                   := 1;
        l_glf_filter_1          := '%';
        l_psn_subj_list_1         := 'a';       
        
        
       when p_arap_class_hb = 'yfzk_yfzk_top_kmhb_hz' then     --Ӧ���˿  TOP5
        l_subj_code_1           := '(^2202001.*$)|(^2202005.*$)';
        l_subj_exclude_code_1     := '^a.*$';
        l_dir_1                   := 1;
        l_glf_filter_1          := '%';
        l_psn_subj_list_1         := 'a';       
        
       when p_arap_class_hb = 'yfzk_yfzk_top_glf_kmhb_hz' then     --Ӧ���˿  TOP5  ������
        l_subj_code_1           := '(^2202001.*$)|(^2202005.*$)';
        l_subj_exclude_code_1     := '^a.*$';
        l_dir_1                   := 1;
        l_glf_filter_1          := 'Y';
        l_psn_subj_list_1         := 'a'; 
        
        
       when p_arap_class_hb = 'glfjy_yfzk_kmhb_hz' then     --���������ף� Ӧ���˿�
        l_subj_code_1           := '(^2202001.*$)|(^2202005.*$)';
        l_subj_exclude_code_1     := '^a.*$';
        l_dir_1                   := 1;
        l_glf_filter_1          := 'Y';
        l_psn_subj_list_1         := 'a';   
        
        
        
       when p_arap_class_hb = 'glfjy_yfzk2_kmhb_hz' then     --���������ף� Ӧ���˿� �� �����˹�����
        l_subj_code_1           := '(^2202001.*$)|(^2202005.*$)';
        l_subj_exclude_code_1     := '^a.*$';
        l_dir_1                   := 1;
        l_glf_filter_1          := '%';
        l_psn_subj_list_1         := 'a';   
              
         

      else 
	  
	    null; 
		
    end case;
    
    
     case
    
        when p_arap_class_dd = 'ysfl_zbj_kmdd_hz' then     --Ӧ���˿���࣬ �ǹ��������ʱ���
        l_subj_code_2           := '^1122002.*$';
        l_subj_exclude_code_2     := '^a.*$';
        l_dir_2                   := 0;
        l_glf_filter_2          := 'N';
        l_psn_subj_list_2         := 'a';
          
          
        when p_arap_class_dd = 'ysfl_glf_kmdd_hz' then     --Ӧ���˿���࣬ ������ , �ʱ���
        l_subj_code_2           := '^1122002.*$';
        l_subj_exclude_code_2     := '^a.*$';
        l_dir_2                   := 0;
        l_glf_filter_2          := 'Y';
        l_psn_subj_list_2         := 'a';
        
        when p_arap_class_dd = 'ysfl_zlze_kmdd_hz' then     --Ӧ���˿���࣬ ������ , �ʱ���
        l_subj_code_2           := '^1122002.*$';
        l_subj_exclude_code_2     := '^a.*$';
        l_dir_2                   := 0;
        l_glf_filter_2          := '%';
        l_psn_subj_list_2         := 'a';
        
       
     
        when p_arap_class_dd = 'glfjy_ys_kmdd_hz' then     --���������ף� Ӧ���˿�
        l_subj_code_2           := '(^1122002.*$)|(^2203.*$)';
        l_subj_exclude_code_2     := '^a.*$';
        l_dir_2                   := 0;
        l_glf_filter_2          := 'Y';
        l_psn_subj_list_2         := 'a';
        
        
        when p_arap_class_dd = 'glfjy_ys2_kmdd_hz' then     --���������ף� Ӧ���˿� �� �����˹�����
        l_subj_code_2           := '(^1122002.*$)|(^2203.*$)';
        l_subj_exclude_code_2     := '^a.*$';
        l_dir_2                   := 0;
        l_glf_filter_2          := '%';
        l_psn_subj_list_2         := 'a';
      
        
        
          when p_arap_class_dd = 'ysfl_yshk_kmdd_hz' then     --Ԥ���˿��еĻ���
        l_subj_code_2           := '^2203.*$';
        l_subj_exclude_code_2     := '^a.*$';
        l_dir_2                   := 1;
        l_glf_filter_2          := '%';
        l_psn_subj_list_2         := 'a';  
          
       
       when p_arap_class_dd = 'ysfl_ys_kmdd_hz' then     --Ԥ���˿��еĻ��� �� ȫ��
        l_subj_code_2           := '(^1122002.*$)|(^2203.*$)';
        l_subj_exclude_code_2     := '^a.*$';
        l_dir_2                   := 1;
        l_glf_filter_2          := '%';
        l_psn_subj_list_2         := 'a';  
        
        
        
     
        
        
        
        
       when p_arap_class_dd = 'ysfl_ystop_kmdd_hz' then     --Ԥ���˿� ,topϵ��
        l_subj_code_2           := '(^1122002.*$)|(^2203.*$)';
        l_subj_exclude_code_2     := '^a.*$';
        l_dir_2                   := 1;
        l_glf_filter_2          := '%';
        l_psn_subj_list_2         := 'a';  
        
        
       when p_arap_class_dd = 'glfjy_yszk_ys_kmdd_hz' then     --���������ף�Ԥ���˿�
        l_subj_code_2           := '(^1122002.*$)|(^2203.*$)';
        l_subj_exclude_code_2     := '^a.*$';
        l_dir_2                   := 1;
        l_glf_filter_2          := 'Y';
        l_psn_subj_list_2         := 'a';  
        
        
        
       when p_arap_class_dd = 'glfjy_yszk_ys2_kmdd_hz' then     --���������ף�Ԥ���˿� �� �����˹�����
        l_subj_code_2           := '(^1122002.*$)|(^2203.*$)';
        l_subj_exclude_code_2     := '^a.*$';
        l_dir_2                   := 1;
        l_glf_filter_2          := '%';
        l_psn_subj_list_2         := 'a';  
        
        
        
        
        
       when p_arap_class_dd= 'qtys_zh1_kmdd_hz'  then      --����Ӧ�տ����1  ������
         
            l_subj_code_2           := '(^1221.*$)|(^2241.*$)';
            l_subj_exclude_code_2     := '^a.*$';     --������Ͷ�걣֤��
            l_dir_2                   := 0;
            l_glf_filter_2          := 'Y';
            l_psn_subj_list_2         := 'a';  
        
          
      when p_arap_class_dd= 'qtys_zh2_kmdd_hz'  then      --����Ӧ�տ����2    ����������
         
            l_subj_code_2           := '(^1221.*$)|(^2241.*$)';
            l_subj_exclude_code_2     := '^1221002.*$';     --������Ͷ�걣֤��
            l_dir_2                   := 0;
            l_glf_filter_2          := 'N';
            l_psn_subj_list_2         := 'a';  
            
            
       when p_arap_class_dd= 'qtys_zh3_kmdd_hz'  then      --����Ӧ�տ����3   Ͷ�걣֤��
         
            l_subj_code_2           := '^1221002.*$';
            l_subj_exclude_code_2     := '^a.*$';     --������Ͷ�걣֤��
            l_dir_2                   := 0;
            l_glf_filter_2          := 'N';
            l_psn_subj_list_2         := 'a';  
                  
     
      when p_arap_class_dd= 'qtys_zlqj_kmdd_hz'  then      --����Ӧ�տ����3   �����ڼ�
         
            l_subj_code_2           := '(^1221.*$)|(^2241.*$)';
            l_subj_exclude_code_2     := '^a.*$';     --������Ͷ�걣֤��
            l_dir_2                   := 0;
            l_glf_filter_2          := '%';
            l_psn_subj_list_2         := 'a';  
                  
      when p_arap_class_dd= 'qtys_fxfl_wlk_kmdd_hz'  then      --����Ӧ�տ���ϸ �� ������
         
            l_subj_code_2           := '(^1221003.*$)|(^2241007.*$)';
            l_subj_exclude_code_2     := '^a.*$';    
            l_dir_2                   := 0;
            l_glf_filter_2          := '%';
            l_psn_subj_list_2         := 'a';  
                  
    
     when p_arap_class_dd= 'qtys_fxfl_bzj_kmdd_hz'  then      --����Ӧ�տ���ϸ �� ��֤��
         
            l_subj_code_2           := '^1221002.*$';
            l_subj_exclude_code_2     := '^a.*$';    
            l_dir_2                   := 0;
            l_glf_filter_2          := '%';
            l_psn_subj_list_2         := 'a';  
                  
     
     when p_arap_class_dd= 'qtys_fxfl_grjk_kmdd_hz'  then      --����Ӧ�տ���ϸ �� ���˽��
         
            l_subj_code_2           := '^1221001.*$';
            l_subj_exclude_code_2     := '^a.*$';    
            l_dir_2                   := 0;
            l_glf_filter_2          := '%';
            l_psn_subj_list_2         := 'a';  
                           
     when p_arap_class_dd= 'qtys_fxfl_qt_kmdd_hz'  then      --����Ӧ�տ���ϸ �� �������� ����Ӧ�����ط������
         
            l_subj_code_2           := '(^2241.*$)|(^1221.*$)';
            l_subj_exclude_code_2     := '^a.*$';    
            l_dir_2                   := 0;
            l_glf_filter_2          := '%';
            l_psn_subj_list_2         := 'a';  
                           
     when p_arap_class_dd= 'qtys_top5_kmdd_hz'  then      --����Ӧ�տ���ϸ �� ǰ5��
         
            l_subj_code_2           := '(^1221.*$)|(^2241.*$)';
            l_subj_exclude_code_2     := '^a.*$';    
            l_dir_2                   := 0;
            l_glf_filter_2          := '%';
            l_psn_subj_list_2         := 'a';  
            
            
            
     when p_arap_class_dd= 'glfjy_qtys_kmdd_hz'  then      --���������ף�   ����Ӧ�տ�
         
            l_subj_code_2           := '(^1221.*$)|(^2241.*$)';
            l_subj_exclude_code_2     := '^a.*$';    
            l_dir_2                   := 0;
            l_glf_filter_2          := 'Y';
            l_psn_subj_list_2         := 'a';  
                     
            
     when p_arap_class_dd= 'glfjy_qtys2_kmdd_hz'  then      --���������ף�   ����Ӧ�տ� �� �����˹�����
         
            l_subj_code_2           := '(^1221.*$)|(^2241.*$)';
            l_subj_exclude_code_2     := '^a.*$';    
            l_dir_2                   := 0;
            l_glf_filter_2          := '%';
            l_psn_subj_list_2         := 'a';  
                             
            
                           
    
    when p_arap_class_dd= 'qtys_qtyfzk_mx_wlk_kmdd_hz'  then      --����Ӧ��� ������
         
            l_subj_code_2           := '(^1221003.*$)|(^2241007.*$)';
            l_subj_exclude_code_2     := '^a.*$';    
            l_dir_2                   := 1;
            l_glf_filter_2          := '%';
            l_psn_subj_list_2         := 'a';  
            
            
     when p_arap_class_dd= 'qtys_qtyfzk_mx_byj_kmdd_hz'  then      --����Ӧ��� ���ý�
         
            l_subj_code_2           := '^1221001.*$';
            l_subj_exclude_code_2     := '^a.*$';    
            l_dir_2                   := 1;
            l_glf_filter_2          := '%';
            l_psn_subj_list_2         := 'a';  
            
            
     when p_arap_class_dd= 'qtys_qtyfzk_mx_bzj_kmdd_hz'  then      --����Ӧ��� ��֤��
         
            l_subj_code_2           := '^1221002.*$';
            l_subj_exclude_code_2     := '^a.*$';    
            l_dir_2                   := 1;
            l_glf_filter_2          := '%';
            l_psn_subj_list_2         := 'a';         
            
                           
    
     when p_arap_class_dd= 'qtys_qtyfzk_mx_ygbx_kmdd_hz'  then      --����Ӧ��� ����
         
            l_subj_code_2           := '(^2241003.*$)|(^2241004.*$)|(^2241005.*$)|(^2241006.*$)';
            l_subj_exclude_code_2     := '^a.*$';    
            l_dir_2                   := 1;
            l_glf_filter_2          := '%';
            l_psn_subj_list_2         := 'a';   
    
      when p_arap_class_dd= 'qtys_qtyfzk_mx_qt_kmdd_hz'  then      --����Ӧ��� �����ϼ�
         
            l_subj_code_2           := '(^1221.*$)|(^2241.*$)';
            l_subj_exclude_code_2     := '^a.*$';    
            l_dir_2                   := 1;
            l_glf_filter_2          := '%';
            l_psn_subj_list_2         := 'a';   
            
            
        when p_arap_class_dd= 'qtys_qtyfzk_top_kmdd_hz'  then      --����Ӧ��� TOP
         
            l_subj_code_2           := '(^1221.*$)|(^2241.*$)';
            l_subj_exclude_code_2     := '^a.*$';    
            l_dir_2                   := 1;
            l_glf_filter_2          := '%';
            l_psn_subj_list_2         := 'a';
            
         when p_arap_class_dd= 'qtys_qtyfzk_glf_qk_kmdd_hz'  then      --����Ӧ���� �� �������� 
         
            l_subj_code_2           := '(^1221.*$)|(^2241.*$)';
            l_subj_exclude_code_2     := '^a.*$';    
            l_dir_2                   := 1;
            l_glf_filter_2          := 'Y';
            l_psn_subj_list_2         := 'a';
                  
            
          when p_arap_class_dd= 'qtys_qtyfzk_qtyf_top_kmdd_hz'  then      --����Ӧ��� �����ϼ�
         
            l_subj_code_2           := '(^1221.*$)|(^2241.*$)';
            l_subj_exclude_code_2     := '^a.*$';    
            l_dir_2                   := 1;
            l_glf_filter_2          := '%';
            l_psn_subj_list_2         := 'a';    
            
            
            when p_arap_class_dd= 'glfjy_qtyf_kmdd_hz'  then      --���������ף� ����Ӧ����
         
            l_subj_code_2           := '(^1221.*$)|(^2241.*$)';
            l_subj_exclude_code_2     := '^a.*$';    
            l_dir_2                   := 1;
            l_glf_filter_2          := 'Y';
            l_psn_subj_list_2         := 'a';    
            
            
            
              when p_arap_class_dd= 'glfjy_qtyf2_kmdd_hz'  then      --���������ף� ����Ӧ���� �� �����˹�����
         
            l_subj_code_2           := '(^1221.*$)|(^2241.*$)';
            l_subj_exclude_code_2     := '^a.*$';    
            l_dir_2                   := 1;
            l_glf_filter_2          := '%';
            l_psn_subj_list_2         := 'a';    
    
    
          when p_arap_class_dd= 'yfzk_zlmx_kmdd_hz'  then      --Ԥ���˿�  ��������
         
            l_subj_code_2           := '(^2202.*$)|(^1123.*$)';
            l_subj_exclude_code_2     := '(^2202001.*$)|(^2202005.*$)';    
            l_dir_2                   := 0;
            l_glf_filter_2          := '%';
            l_psn_subj_list_2         := 'a';   
       
    
    
          when p_arap_class_dd= 'yfzk_top5_kmdd_hz'  then      --Ԥ���˿�  ǰ5��
         
            l_subj_code_2           := '(^2202.*$)|(^1123.*$)';
            l_subj_exclude_code_2     := '(^2202001.*$)|(^2202005.*$)';    
            l_dir_2                   := 0;
            l_glf_filter_2          := '%';
            l_psn_subj_list_2         := 'a';    
            
            
            
            
            when p_arap_class_dd= 'glfjy_yfzk_yf_kmdd_hz'  then      --���������ף� Ԥ���˿� 
         
            l_subj_code_2           := '(^2202.*$)|(^1123.*$)';
            l_subj_exclude_code_2     := '(^2202001.*$)|(^2202005.*$)';    
            l_dir_2                   := 0;
            l_glf_filter_2          := 'Y';
            l_psn_subj_list_2         := 'a';    
            
            
            
            when p_arap_class_dd= 'glfjy_yfzk_yf2_kmdd_hz'  then      --���������ף� Ԥ���˿�  �� �����˹�����
         
            l_subj_code_2           := '(^2202.*$)|(^1123.*$)';
            l_subj_exclude_code_2     := '(^2202001.*$)|(^2202005.*$)';    
            l_dir_2                   := 0;
            l_glf_filter_2          := '%';
            l_psn_subj_list_2         := 'a';     
            
       
            
          when p_arap_class_dd= 'yfzk_yfzk_sbk_kmdd_hz'  then      --Ӧ���˿�  �豸��
         
            l_subj_code_2           := '(^2202002.*$)|(^1123002.*$)';
            l_subj_exclude_code_2     := '^a.*$';    
            l_dir_2                   := 1;
            l_glf_filter_2          := '%';
            l_psn_subj_list_2         := 'a';        
            
            
          when p_arap_class_dd= 'yfzk_yfzk_gck_kmdd_hz'  then      --Ӧ���˿�  ���̿�
         
            l_subj_code_2           := '(^2202003.*$)|(^1123001.*$)';
            l_subj_exclude_code_2     := '^a.*$';    
            l_dir_2                   := 1;
            l_glf_filter_2          := '%';
            l_psn_subj_list_2         := 'a';          
            
            
           when p_arap_class_dd= 'yfzk_yfzk_hj_kmdd_hz'  then      --Ӧ���˿�  �ܵĺϼ�
         
            l_subj_code_2           := '(^2202.*$)|(^1123.*$)';
            l_subj_exclude_code_2     := '(^2202001.*$)|(^2202005.*$)';    
            l_dir_2                   := 1;
            l_glf_filter_2          := '%';
            l_psn_subj_list_2         := 'a';  
            
          
           when p_arap_class_dd= 'yfzk_yfzk_1n_kmdd_hz'  then      --Ӧ���˿�  ���䳬��һ��
         
            l_subj_code_2           := '(^2202.*$)|(^1123.*$)';
            l_subj_exclude_code_2     := '(^2202001.*$)|(^2202005.*$)';    
            l_dir_2                   := 1;
            l_glf_filter_2          := '%';
            l_psn_subj_list_2         := 'a';  
            
            
           when p_arap_class_dd= 'yfzk_yfzk_top_kmdd_hz'  then      --Ӧ���˿�  TOP
         
            l_subj_code_2           := '(^2202.*$)|(^1123.*$)';
            l_subj_exclude_code_2     := '(^2202001.*$)|(^2202005.*$)';    
            l_dir_2                   := 1;
            l_glf_filter_2          := '%';
            l_psn_subj_list_2         := 'a'; 
            
            
            when p_arap_class_dd= 'yfzk_yfzk_top_glf_kmdd_hz'  then      --Ӧ���˿�  TOP  ������
         
            l_subj_code_2           := '(^2202.*$)|(^1123.*$)';
            l_subj_exclude_code_2     := '(^2202001.*$)|(^2202005.*$)';    
            l_dir_2                   := 1;
            l_glf_filter_2          := 'Y';
            l_psn_subj_list_2         := 'a'; 
            
            
           when p_arap_class_dd= 'glfjy_yfzk_kmdd_hz'  then      -- ���������ף� Ӧ���˿�  
         
            l_subj_code_2           := '(^2202.*$)|(^1123.*$)';
            l_subj_exclude_code_2     := '(^2202001.*$)|(^2202005.*$)';    
            l_dir_2                   := 1;
            l_glf_filter_2          := 'Y';
            l_psn_subj_list_2         := 'a';     
            
            
            
            
           when p_arap_class_dd= 'glfjy_yfzk2_kmdd_hz'  then      -- ���������ף� Ӧ���˿�   �������˹�����
         
            l_subj_code_2           := '(^2202.*$)|(^1123.*$)';
            l_subj_exclude_code_2     := '(^2202001.*$)|(^2202005.*$)';    
            l_dir_2                   := 1;
            l_glf_filter_2          := '%';
            l_psn_subj_list_2         := 'a';     
            
            
            
            
          when p_arap_class_dd= 'zjgc_cqgqtz_kmdd_hz'  then     
         
            l_subj_code_2           := '^1511.*$';
            l_subj_exclude_code_2     := '^a.*$';    
            l_dir_2                   := 0;
            l_glf_filter_2          := '%';
            l_psn_subj_list_2         := 'a';    
            
            
          when p_arap_class_dd= 'zjgc_zjgc_kmdd_hz'  then      
         
            l_subj_code_2           := '^1604.*$';
            l_subj_exclude_code_2     := '^a.*$';    
            l_dir_2                   := 0;
            l_glf_filter_2          := '%';
            l_psn_subj_list_2         := 'a';    
                
         when p_arap_class_dd= 'zjgc_zxyfk_kmdd_hz'  then      
         
            l_subj_code_2           := '^2711.*$';
            l_subj_exclude_code_2     := '^a.*$';    
            l_dir_2                   := 0;
            l_glf_filter_2          := '%';
            l_psn_subj_list_2         := 'a';    
            
            
            
            
            
                           
      
      else 
	  
    
    
	    null; 
		
    end case;
  
  
 
    --�����ڱ�����ֵ
  
    l_now_date       := to_date(p_end_date || ' 23:59:59', V_DATE_FORMAT_19);
    l_perious_date_0 := add_months(l_now_date, -6 * 1);
    l_perious_date_1 := add_months(l_now_date, -12 * 1);
    l_perious_date_2 := add_months(l_now_date, -12 * 2);
    l_perious_date_3 := add_months(l_now_date, -12 * 3);
    l_perious_date_4 := add_months(l_now_date, -12 * 4);
    l_perious_date_5 := add_months(l_now_date, -12 * 5);
    
    
    
    if( p_arap_class_hb <> 'init' ) then 
       --�õ�������ϸ��
            open cur_arap_hb( p_org_code,
	                            p_end_date,
                              l_subj_code_1,
                              l_subj_exclude_code_1,
                              l_glf_filter_1 , 
                              l_dir_1,
                              l_psn_subj_list_1,
                              p_aux_code_ks,
                              p_aux_name_ks,
                              p_aux_code_ry,
                              p_aux_name_ry,
                              l_currency_pk,
                              p_period_length_max,
                              p_accounting,
                              l_perious_date_0,
                              l_perious_date_1,
                              l_perious_date_2,
                              l_perious_date_3,
                              l_perious_date_4,
                              l_perious_date_5,
                              p_cust_sup_class_code  
                             );
  
        fetch cur_arap_hb bulk collect
          into l_rtn_1;
  
    close cur_arap_hb;
    
    
    p_zlhx(l_rtn_1)  ; 
    
    
    end if; 
    
    
    if( p_arap_class_dd <> 'init' ) then 
    
          open cur_arap_dd( p_org_code,
	                          p_end_date,
                              l_subj_code_2,
                              l_subj_exclude_code_2,
                              l_glf_filter_2 , 
                              l_dir_2,
                              l_psn_subj_list_2,
                              p_aux_code_ks,
                              p_aux_name_ks,
                              p_aux_code_ry,
                              p_aux_name_ry,
                              l_currency_pk,
                              p_period_length_max,
                              p_accounting,
                              l_perious_date_0,
                              l_perious_date_1,
                              l_perious_date_2,
                              l_perious_date_3,
                              l_perious_date_4,
                              l_perious_date_5 ,
                              p_cust_sup_class_code  
                             );
  
        fetch cur_arap_dd bulk collect
          into l_rtn_2;
  
    close cur_arap_dd;
    
    
    end if; 
    
  
    
    
    
  
    for x in 1 .. l_rtn_1.count loop
      
      pipe row(l_rtn_1(x));
    
    end loop;
    
    
     
    for x in 1 .. l_rtn_2.count loop
      
      pipe row(l_rtn_2(x));
    
    end loop;
  
    
    
  
    return;
	
  
    exception 
      
          when others  then 
             
              if( cur_arap_dd  %isopen )  then 
              
              
                   close  cur_arap_dd ; 
                   
              end if; 
              
              
              if( cur_arap_hb  %isopen )  then 
              
              
                   close  cur_arap_hb ; 
                   
              end if; 
             
	 
	 
  end;


begin

  null;

end sy_base;
/
