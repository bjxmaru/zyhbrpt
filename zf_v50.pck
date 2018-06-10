create or replace package zf is

   --����������Ŀ�ط�������PLSQL����� 
   v_nt_arap_reclass_rule   zf_spec.nt_reclass_arap_rule ; 
   v_ntx_arap_item_list     zf_spec.ntx_varchar2_64 ; 
   
   --���屨����Ŀ��Ӧ��Ŀ��ѯ�ַ���
   v_ntx_rcd_subj_search_partern  zf_spec.ntx_subj_para  ; 
   
   ------------------------------------------------------------------------------
   --ʹ�ó���:���ݵ�λ���� ,��ȡ��֯���˲���Ϣ,��Ŀ��
   --����:  org_code  ��֯����
   --       p_group   ��������
   --����ֵ:  ��֯�Ŀ�Ŀ��,�˲��ȼ�¼���͵�Ƕ�ױ�
   function f_org_info(p_org_code varchar2 , 
                       p_group varchar2 default zf_spec.GROUP_ORG_PK   ) 
   return  zf_spec.rcd_org_info  ;  
   
   ---------------------------------------------------------------------
    function f_subj_info_code_list_grade_1(p_subj_code varchar2 , p_org_code varchar2 , 
                        p_group varchar2 default zf_spec.GROUP_ORG_PK   ) 
   return  zf_spec.ntx_varchar2_64  ; 
   
   
   --------------------------------------------------------------------------
   --ʹ�ó���:���ݵ�λ����,������Ϣ,��Ŀ����,��ȡ��Ŀ����Ϣ
   --����:  subj_code ��Ŀ����
   --       org_code  ��֯����
   --       p_group   ��������
   --����ֵ:  ��֯�Ŀ�Ŀ��,�˲��ȼ�¼���͵�Ƕ�ױ�
   function f_subj_info_single(p_subj_code varchar2 , p_org_code varchar2 , 
                        p_group varchar2 default zf_spec.GROUP_ORG_PK   ) 
   return  zf_spec.ntx_rcd_subj_info  ;
   

--ʹ�ó���:���ݵ�λ����,������Ϣ,��Ŀ����,��ȡ��Ŀ����Ϣ
   --����:  subj_code ��Ŀ����
   --       org_code  ��֯����
   --       p_group   ��������
   --����ֵ:  ��֯�Ŀ�Ŀ��,�˲��ȼ�¼���͵�Ƕ�ױ�
   function f_subj_info_multi(p_subj_code varchar2 , p_org_code varchar2 , 
                        p_group varchar2 default zf_spec.GROUP_ORG_PK   ) 
   return  zf_spec.ntx_rcd_subj_info  ;
  
    ------------��������Ŀ���ط����׼���г�ʼ�� 
    procedure  p_init_reclass_rule  ; 
  
   
    ---------------------------------------------------------------------------------
   --ʹ�ó��� :  �Կ��̸�������Ŀ�Ŀ�������ط��� , �����ʲ���ծ����
   --����
   --      p_end_year  ������
   --      p_end_month   �����·�
   --      p_unit_code   ��λ����
   --      p_subj_code   ��Ŀ����
   --      p_consolidate_flag    �Ƿ��ǽ��¼���Ŀ���ܵ��ϼ���Ŀ��
   --      p_adjust   �Ƿ���������� �Ƿ����������, Y ,����, N ,������, A ֻ�е�����

  function f_arap_reclass_trail_bal( p_end_year  IN varchar2 DEFAULT '2014',
                       p_end_month        IN varchar2 DEFAULT '02',
                       p_unit_code        IN VARCHAR2 DEFAULT '01',
                       p_arap_item        IN VARCHAR2 DEFAULT 'ar',
                       p_adjust           in varchar2 default 'Y' , 
                       p_consolidate_flag in varchar2 default 'Y' , 
                       p_curr             in varchar2 default 'BWB',
                       p_accounting       in varchar2 default 'Y' ,
                       p_acc_chart_code   in varchar2 default '0004'
                      )
    RETURN  number ; 
    
   
 
 
 ---------------------------------------------------------------------------------
   --ʹ�ó��� :    ���ƶ���Ŀ���ڳ�����ĩ���������� 
   --����
   --      p_beg_year  ��ʼ��
   --      p_end_year  ������
   --      p_beg_month  ��ʼ�·�
   --      p_end_month   �����·�
   --      p_unit_code   ��λ����
   --      p_subj_code   ��Ŀ����
   --      p_aux_style   ������������
   --      p_aux_code    �����������
   --      p_aux_name    ������������
   --      p_accur_bool  �Ƿ���������
   --      p_group_name  ��������
   --      p_consolidate_flag    �Ƿ��ǽ��¼���Ŀ���ܵ��ϼ���Ŀ��
   --      p_adjust   �Ƿ���������� �Ƿ����������, Y ,����, N ,������, A ֻ�е�����
   --      p_special  �Ƿ���������,������I3_05,���½��л���
   --      p_curr         ����    'BWB' ,
   --      p_accounting     �Ƿ�����Ѿ�����
   --      p_dir    ���� ,�����������  , ���ƶ�������ķ���
   --ʹ���� :    IUFO������,�����Ŀ��������ʹ��
   --���� :    bieyifeng
   --ʱ��  :   20140428
   function f_bal_iufo(p_beg_year  varchar2 default '2014' ,
                                p_end_year varchar2 default '2014' ,  
                                p_beg_month varchar2 default '01' , 
                                p_end_month  varchar2 default '04' , 
                                p_unit_code  varchar2  default '107001' ,
                                p_subj_code varchar2  default '1001' , 
                                p_accur_bool  varchar2  default  'Y',
                                p_dir     varchar2 default  'cr'  ,
                                p_adjust   varchar2 default 'Y', 
                                p_curr      varchar2  default  'BWB', 
                                p_accounting  varchar2 default  'Y' , 
                                p_bal_dir   varchar2 default  'dr' ,
                                p_chart_system  varchar2 default  '0004' , 
                                p_subjcode_regexp               in varchar2  default  'Y'    --��Ŀ����ļ����Ƿ���������ʽ
                                )
  return number  ;

---------------------------------------------------------------------------------
   --ʹ�ó��� :    ��ÿ����Ŀ���ڳ�����ĩ���������� 
   --����
   --      p_beg_year  ��ʼ��
   --      p_end_year  ������
   --      p_beg_month  ��ʼ�·�
   --      p_end_month   �����·�
   --      p_unit_code   ��λ����
   --      p_subj_code   ��Ŀ����
   --      p_aux_style   ������������
   --      p_aux_code    �����������
   --      p_aux_name    ������������
   --      p_accur_bool  �Ƿ���������
   --      p_group_name  ��������
   --      p_consolidate_flag    �Ƿ��ǽ��¼���Ŀ���ܵ��ϼ���Ŀ��
   --      p_adjust   �Ƿ���������� �Ƿ����������, Y ,����, N ,������, A ֻ�е�����
   --      p_special  �Ƿ���������,������I3_05,���½��л���
   --      p_rcd_subj_info    ����,��Ŀ��Ϣ��¼, 
   --      p_rcd_corp_info    ��֯��Ϣ��¼����   
 function f_bal_accur_ex(p_beg_year         IN varchar2 DEFAULT '2014',
                       p_end_year         IN varchar2 DEFAULT '2014',
                       p_beg_month        IN varchar2 DEFAULT '01',
                       p_end_month        IN varchar2 DEFAULT '02',
                       p_unit_code        IN VARCHAR2 DEFAULT '01',
                       p_subj_code        IN VARCHAR2 DEFAULT '100201',
                       p_aux_style        IN VARCHAR2 DEFAULT null,
                       p_aux_code         IN VARCHAR2 DEFAULT '*',
                       p_aux_name         IN VARCHAR2 DEFAULT '*',
                        p_aux_fi_org      in varchar2 default  '~'  ,    --ɸѡ�ڲ�������
                       p_accur_bool       in varchar2 default 'Y',
                       p_adjust           in varchar2 default 'Y' , 
                       p_consolidate_flag in varchar2 default 'Y' , 
                       p_special          in varchar2 default NULL , 
                       p_curr             in varchar2 default 'BWB',
                       p_accounting       in varchar2 default 'Y' , 
                       p_chart_system    in varchar2 default  '0004' ,
                       p_subjcode_regexp               in varchar2  default  'Y' ,    --��Ŀ����ļ����Ƿ���������ʽ
                       p_group            in varchar2 default zf_spec.GROUP_ORG_PK )
    RETURN zf_spec.nt_voucher_detail_s 
    pipelined  ; 
  
 
 ----------------------------------------------------------------------------------------------
 function f_arap_reclass_nt( p_end_year  IN varchar2 DEFAULT '2014',
                       p_end_month        IN varchar2 DEFAULT '02',
                       p_unit_code        IN VARCHAR2 DEFAULT '01',
                       p_adjust           in varchar2 default 'Y' , 
                       p_consolidate   in varchar2  default 'Y', 
                       p_accounting       in varchar2 default 'Y'  ,
                       p_aux_fi_org        in varchar2 default  '~' 
    )
    
    RETURN  zf_spec.nt_voucher_detail_s 
    pipelined  ; 
    
    
  ---------------------------------------------------------------------------------
   --ʹ�ó��� :  �Կ��̸�������Ŀ�Ŀ�������ط�����ʾ,����ծȨծ����ϸ����
   --����
   --      p_end_year  ������
   --      p_end_month   �����·�
   --      p_unit_code   ��λ����
   --      p_subj_code   ��Ŀ����
   --      p_consolidate_flag    �Ƿ��ǽ��¼���Ŀ���ܵ��ϼ���Ŀ��
   --      p_adjust   �Ƿ���������� �Ƿ����������, Y ,����, N ,������, A ֻ�е�����

 function f_arap_reclass_list( p_end_year  IN varchar2 DEFAULT '2014',
                       p_end_month        IN varchar2 DEFAULT '02',
                       p_unit_code        IN VARCHAR2 DEFAULT '01',
                       p_adjust           in varchar2 default 'Y' , 
                       p_consolidate    in varchar2 default  'Y' , 
                       p_accounting       in varchar2 default 'Y'  ,
                       p_aux_fi_org        in varchar2 default  '~' 
    )
    
    RETURN zf_spec.nt_rcd_arap_detail 
    pipelined   ; 
 
     ---------------------------------------------------------------------------------
   --ʹ�ó��� :    ��ÿ����Ŀ���ڳ�����ĩ���������� 
   --����

   --      p_end_year  ������
   --      p_end_month   �����·�
   --      p_unit_code   ��λ����
   --      p_adjust   �Ƿ���������� �Ƿ����������, Y ,����, N ,������, A ֻ�е�����
  function f_invest_nt(
                       p_end_year         IN varchar2 DEFAULT '2014',
                       p_end_month        IN varchar2 DEFAULT '02',
                       p_unit_code        IN VARCHAR2 DEFAULT '01',
                       p_adjust           in varchar2 default 'Y' ,  
                       p_accounting       in varchar2 default 'Y'  )
    RETURN zf_spec.nt_rcd_invest_detail 
    pipelined    ; 
  

end zf;
/
create or replace package body zf is
  
   --���峣�� ,����һ����Ч��ֵ 
   
   v_nothing  constant   varchar2(1)   :=  '#' ; 
   
   
   

   ------------------------------------------------------------------------------
   --ʹ�ó��� : ���ݵ�λ���� , ��ȡ��֯���˲���Ϣ,��Ŀ��
   --����:  org_code  ��֯����
   --       p_group   ��������
   --����ֵ:  ��֯�Ŀ�Ŀ��,�˲��ȼ�¼���͵�Ƕ�ױ�
   function f_org_info(p_org_code varchar2 , 
                       p_group varchar2 default zf_spec.GROUP_ORG_PK   ) 
   return  zf_spec.rcd_org_info 
   is
   --�����α�,���ݱ�����֯�Ĵ���,�ҵ�������֯��Ӧ�Ļ�����֯��PK �ͱ�����֯����Ϣ
   cursor l_cur_org(p_curr_org_code  varchar2 ,  p_curr_group varchar2  )  
   is
   select  s.code  org_code ,s.name org_name,s.pk_org pk_org , s.pk_group
   from  org_orgs s 
   where nvl(s.dr , 0) = 0
   and s.pk_group = p_curr_group 
   and s.code  =  p_curr_org_code ; 
   
   
    --����ֲ���¼����,���ڴ���α�l_cur_org �Ĳ�ѯ���
   l_recd_org_info   l_cur_org%rowtype ; 
   
   
   --�����α�,������֯����,�õ���֯���˲���Ϣ(���˲�) 
   cursor l_cur_book(p_curr_org_pk  varchar2 , 
                     p_curr_group varchar2 default zf_spec.GROUP_ORG_PK ) is 
   select s.pk_accountingbook , s.pk_setofbook , s.pk_curraccchart , 
   y.pk_accsystem , y.code  accsystem_code
   from  bd_accsystem y , bd_accchart x   ,  org_accountingbook S 
   where 
   y.pk_accsystem  = x.pk_accsystem
   and x.pk_accchart = s.pk_curraccchart 
   and s.accounttype = 1 
   and s.pk_group = p_curr_group 
   and nvl(s.dr,0) = 0  
   and s.pk_relorg = p_curr_org_pk  ; 
   
     --����ֲ���¼����,���ڴ���α�l_cur_book�Ĳ�ѯ���
   l_recd_org_book_info   l_cur_book%rowtype ; 
   
   --����һ���ֲ�rcd_org_info���͵ļ�¼����,��Ϊ����ֵ
   l_retn_org_info     zf_spec.rcd_org_info ; 
   
   begin   
       
     --��ȡ��֯��Ϣ 
     open l_cur_org(p_org_code , p_group )  ; 
        fetch l_cur_org into  l_recd_org_info ;
     close l_cur_org ; 
     
     --�ѻ�������֯��Ϣ,�Ӽ�¼�����и��Ƶ�����ֵ
          l_retn_org_info.pk_org := l_recd_org_info.pk_org ; 
          l_retn_org_info.org_code :=l_recd_org_info.org_code ; 
          l_retn_org_info.org_name :=l_recd_org_info.org_name ;
          l_retn_org_info.pk_group := l_recd_org_info.pk_group ; 
          
     
     --��ȡ�˲��Ϳ�Ŀ�����Ϣ
      open l_cur_book(l_recd_org_info.pk_org ,p_group ) ; 
       
          fetch l_cur_book into l_recd_org_book_info  ; 
          
      close  l_cur_book; 
      
      --��ֵ �˲���Ϣ�� ����ֵ
          l_retn_org_info.pk_accchart :=l_recd_org_book_info.pk_curraccchart ; 
          l_retn_org_info.pk_accountingbook :=l_recd_org_book_info.pk_accountingbook ; 
          l_retn_org_info.accounttype :=l_recd_org_book_info.pk_setofbook ;
          l_retn_org_info.pk_accsystem := l_recd_org_book_info.pk_accsystem ;     
          l_retn_org_info.accsystem_code := l_recd_org_book_info.accsystem_code ;
     
     --����ֵ
     return  l_retn_org_info ; 
     
     --�쳣����
     exception 
       
     --���޲�ѯ����Ĵ���,���� NULL
     when NO_DATA_FOUND then 
          
          l_retn_org_info  := null; 
          
          return l_retn_org_info ;
          
     --����������ʱ, �ݷ��� NULL
     when others then 
       
          l_retn_org_info  := null; 
          
          return l_retn_org_info ; 
 
   end ; 

   ------------------------------------------------------------------------------
   --ʹ�ó���:���ݵ�λ���� ,������Ϣ,��Ŀ����,��ȡ��Ŀ����Ϣ
   --����:  subj_code ��Ŀ����
   --       org_code  ��֯����
   --       p_group   ��������
   --����ֵ:  ��֯�Ŀ�Ŀ��,�˲��ȼ�¼���͵�Ƕ�ױ�
   function f_subj_info_single(p_subj_code varchar2 , p_org_code varchar2 , 
                        p_group varchar2 default zf_spec.GROUP_ORG_PK   ) 
   return  zf_spec.ntx_rcd_subj_info 
   is
   --���幫˾��Ϣ��¼����,�����洢��˾��Ŀ�����Ϣ
   l_rcd_org_info  zf_spec.rcd_org_info ; 
   
   --�����Ŀ����Ϣ��¼���ͱ���
   l_rcd_subj_info  zf_spec.rcd_subj_info ; 
  
   
   --���庯������ֵ
   l_ntx_rcd_subj_info     zf_spec.ntx_rcd_subj_info ; 
   
   --�����α�,��ѯ��Ŀ�Ļ�����Ϣ
   cursor  l_cur_subj(  p_cur_subj_code varchar2 , p_cur_accchart varchar2    )
   is
    select  a.pk_account , a.pid pk_father_account, 
    c.balanorient bal_orient , c.name acctype_name ,  
    a.code subj_code  , b.name  subj_name ,
    b.dispname subj_dispname , b.pk_accasoa , b.endflag
    from  bd_acctype c , bd_accasoa b , bd_account a
    where   
    c.pk_acctype = a.pk_acctype
    and  b.pk_accchart = p_cur_accchart
    and b.pk_account = a.pk_account 
    and a.code  =  p_cur_subj_code ;  
    
   
    
   /*--�����α����,��ѯ�����������ϸ��Ϣ
   cursor l_cur_subj_aux(p_cur_pk_accasoa varchar2)  
   is
   select b.pk_accass ,c.pk_accassitem ,c.refnodename ,c.code ,c.name
   from  bd_accassitem c  , bd_accass b  
   where  c.pk_accassitem  = b.pk_entity
   and    b.pk_accasoa  =  p_cur_pk_accasoa ; 
   
   
   --����Ƕ�ױ� ����,�����洢 �α� l_subj_aux�Ĳ�ѯ���
   l_tbl_subj_ass_info    zf_spec.nt_rcd_subj_ass_info  := zf_spec.nt_rcd_subj_ass_info(); */
   
   
   --����,��� ��¼�Ƿ�ΪNULL , ��ʾ �Ƿ��ѯȡ����ֵ 
   
   l_mark  pls_integer ; 
   
   begin 
    
     
      --��ȡ��˾�Ŀ�Ŀ�����Ϣ 
      l_rcd_org_info  := f_org_info(p_org_code , p_group) ;
      
      --��ȡ��Ŀ����Ϣ
      
             l_mark  :=   0   ; 
             for rcd in  l_cur_subj(p_subj_code , l_rcd_org_info.pk_accchart ) loop
                   l_rcd_subj_info.pk_ACCOUNT := rcd.pk_account ;
                   l_rcd_subj_info.pk_father_account :=rcd.pk_father_account ; 
                   l_rcd_subj_info.bal_orient := rcd.bal_orient ; 
                   l_rcd_subj_info.acctype_name := rcd.acctype_name ; 
                   l_rcd_subj_info.pk_chart := l_rcd_org_info.pk_accchart ; 
                   l_rcd_subj_info.pk_accasoa := rcd.pk_accasoa ; 
                   l_rcd_subj_info.subj_code := rcd.subj_code ; 
                   l_rcd_subj_info.subj_name := rcd.subj_name ;
                   l_rcd_subj_info.subj_dispname := rcd.subj_dispname ; 
                   l_rcd_subj_info.end_flag := rcd.endflag ; 
                   
                   l_mark :=  l_mark + 1 ;  
                   
               end loop ; 
               
               
        
      if (l_mark = 0  )  then
        
             l_rcd_subj_info.subj_code  := v_nothing ; 
	
      end if;         
               

      
      /*--��ȡ�����������ϸ��Ϣ 
      for rcd in  l_cur_subj_aux(l_rcd_subj_info.pk_accasoa) loop 
        
           l_tbl_subj_ass_info.extend ; 
           l_tbl_subj_ass_info(l_tbl_subj_ass_info.count).pk_accass  :=  rcd.pk_accass ; 
           l_tbl_subj_ass_info(l_tbl_subj_ass_info.count).pk_accassitem  :=  rcd.pk_accassitem ; 
           l_tbl_subj_ass_info(l_tbl_subj_ass_info.count).refnodename  :=  rcd.refnodename ; 
           l_tbl_subj_ass_info(l_tbl_subj_ass_info.count).ref_code  :=  rcd.code ; 
           l_tbl_subj_ass_info(l_tbl_subj_ass_info.count).ref_name  :=  rcd.name ; 
      
      end loop ;
      
      --�Ѹ���������ϸ��Ƕ�ױ�ֵ�� ��¼����
      l_rcd_subj_info.subj_ass_info  := l_tbl_subj_ass_info ; */
      
      
      --�ж�  l_rcd_subj_info �Ƿ�Ϊ�� ,���Ϊ�� ,����д��� ,�Ա� �������򲻳����쳣 
     
      
      
      l_ntx_rcd_subj_info(l_ntx_rcd_subj_info.count +1)  := l_rcd_subj_info ; 
      
     
      
      return  l_ntx_rcd_subj_info ; 
      
   end ; 
   
   
   
   ------------------------------------------------------------------------------
   --ʹ�ó���:���ݵ�λ����,������Ϣ,��Ŀ����,��ȡ��Ŀ����Ϣ , ��Ŀ����1�� 
   --����:  subj_code ��Ŀ���� , ����С��4λ
   --       org_code  ��֯����
   --       p_group   ��������
   --����ֵ:  ��֯�Ŀ�Ŀ��,�˲��ȼ�¼���͵�Ƕ�ױ�
   function f_subj_info_code_list_grade_1(p_subj_code varchar2 , p_org_code varchar2 , 
                        p_group varchar2 default zf_spec.GROUP_ORG_PK   ) 
   return  zf_spec.ntx_varchar2_64 
   is
   --���幫˾��Ϣ��¼����,�����洢��˾��Ŀ�����Ϣ
   l_rcd_org_info  zf_spec.rcd_org_info ; 
   
   --�����Ŀ����Ϣ��¼�����������ͱ���,��Ϊ��������ֵ
   l_ntx_varchar2_64   zf_spec.ntx_varchar2_64  ; 
   
   
   --�����α�,��ѯ��Ŀ�Ļ�����Ϣ,ȡһ����Ŀ�ı����б�
   cursor  l_cur_subj_less_4(  p_cur_subj_code varchar2 , p_cur_accchart varchar2  )
   is  
    with  code_list as 
    (
    select   a.code  acc_code  ,  length(a.code)  the_length 
    from   bd_accasoa b , bd_account a
    where   
    b.pk_accchart = p_cur_accchart
    and b.pk_account = a.pk_account 
    and regexp_like( a.code  ,   p_cur_subj_code )   
    )  
    select  acc_code from   code_list 
    where   the_length   = ( select min(the_length)  from  code_list )     ;
    
    
   begin 
      
         l_rcd_org_info   :=  f_org_info(p_org_code , p_group) ;
          
         for i in l_cur_subj_less_4(p_subj_code  ,l_rcd_org_info.pk_accchart )   loop
           
                     l_ntx_varchar2_64(l_ntx_varchar2_64.count+1)  :=  i.acc_code ;  
         
         end  loop ; 
         
         return  l_ntx_varchar2_64 ; 
  
   end ; 
   
   
   ------------------------------------------------------------------------------
   --ʹ�ó���:���ݵ�λ����,������Ϣ,��Ŀ����,��ȡ��Ŀ����Ϣ
   --����:  subj_code ��Ŀ����
   --       org_code  ��֯����
   --       p_group   ��������
   --����ֵ:  ��֯�Ŀ�Ŀ��,�˲��ȼ�¼���͵�Ƕ�ױ�
   function f_subj_info_multi(p_subj_code varchar2 , p_org_code varchar2 , 
                        p_group varchar2 default zf_spec.GROUP_ORG_PK   ) 
   return  zf_spec.ntx_rcd_subj_info 
   is
  
   --�����Ŀ������б�
   l_ntx_varchar2_64   zf_spec.ntx_varchar2_64  ;  
   
   --���庯������ֵ
   l_ntx_rcd_subj_info     zf_spec.ntx_rcd_subj_info ; 
   
   
   
   begin 
     
        ---�õ���Ŀ����б� 
        l_ntx_varchar2_64  := f_subj_info_code_list_grade_1(p_subj_code ,p_org_code , p_group )  ;  
        
        --���� f_subj_info_single, �õ�����ֵ
        for i in 1 .. l_ntx_varchar2_64.count  loop
 
                    l_ntx_rcd_subj_info(l_ntx_rcd_subj_info.count+1)  :=  f_subj_info_single( l_ntx_varchar2_64(i) , p_org_code , p_group)(1)  ; 

        end loop;
        
        
        --�ж� l_ntx_rcd_subj_info �Ƿ�Ϊ�� ,���Ϊ��,���д��� 
        
        if(l_ntx_rcd_subj_info.count  =  0 ) then  
        
             l_ntx_rcd_subj_info(l_ntx_rcd_subj_info.count+1).subj_code := v_nothing ; 
             
        end if; 
       
        
       return l_ntx_rcd_subj_info ;
   
   end ; 
   

----------------------------------------------------------------------
--�˺����õ����ֵ�PK
  function  f_curr_pk(p_curr  varchar2 )
  return varchar2 
  is
  --��Ϊ�����ķ���ֵ 
  l_curr_pk   varchar2(20) ; 
  
  --��ѯ����PK���α� 
  cursor  l_cur(p_cur_curr varchar2)  
  is
  select PK_CURRTYPE  from  BD_CURRTYPE  where  code = upper(p_cur_curr) ; 
  
  begin 
  
     --�������Ϊ BWB ,�򷵻� BWBPK
     if( upper(p_curr) = 'BWB') then 
       
          l_curr_pk := '%' ;
        
     else 
     
          for i  in  l_cur(p_curr) loop  
          
              l_curr_pk  :=  i.PK_CURRTYPE ; 
          
          end loop ; 
     
     end if; 
     
     return  l_curr_pk ; 
     
     --�����쳣 ,���ر��ֵ�PK Ϊ BWBPK 
     
     exception  
     
     when others then  
        
           l_curr_pk  := '%' ; 
           
           return  l_curr_pk ; 
  
  end ; 

   
  
  ---------------------------------------------------------------------------------
   --ʹ�ó��� :    ��ÿ����Ŀ���ڳ�����ĩ�����, ������������
   --              ������������������α���� ,�Կ�Ŀ��ϸ���л��� , 
   --              ������ϸ��Ŀ���ܵ���һ����Ŀ���м���ϼ� 
   --����
   --      p_beg_year  ��ʼ��
   --      p_end_year  ������
   --      p_beg_month  ��ʼ�·�
   --      p_end_month   �����·�
   --      p_unit_code   ��λ����
   --      p_subj_code   ��Ŀ����
   --      p_aux_style   ������������
   --      p_aux_code    �����������
   --      p_aux_name    ������������
   --      p_accur_bool  �Ƿ���������
   --      p_group_name  ��������
   --      p_consolidate_flag    �Ƿ��ǽ��¼���Ŀ���ܵ��ϼ���Ŀ��
   --      p_adjust   �Ƿ���������� �Ƿ����������, Y ,����, N ,������, A ֻ�е�����
   --      p_special  �Ƿ���������,�簴�½��л���
   --      p_rcd_subj_info    ����,��Ŀ��Ϣ��¼, 
   --      p_rcd_corp_info    ��֯��Ϣ��¼����   

  procedure     p_comm_comm_con_y_bal(
                       p_nt_voucher_detail_s   in out   nocopy zf_spec.nt_voucher_detail_s , 
                       p_end_year         IN varchar2 DEFAULT '2012',
                       p_end_month        IN varchar2 DEFAULT '08',
                       p_unit_code        IN VARCHAR2 DEFAULT '01',
                       p_subj_code        IN VARCHAR2 DEFAULT '100201',
                       p_rcd_subj_info    in zf_spec.ntx_rcd_subj_info , 
                       p_rcd_corp_info    in zf_spec.rcd_org_info   ,  
                       p_curr             in varchar2  default 'RMB' ,
                       p_period_length_max  in number default 2 , 
                       p_accounting   in number  default 1  ) 
  is
  
  --����������� 
  l_curr_pk    varchar2(20)   ;
  
  --������˿�Ŀ�ķ��� 
  l_cur_super_subj_orient    pls_integer  ;  
  
  --����ƾ֤��ϸ��¼����
  l_rcd  zf_spec.rcd_voucher_detail_s  ; 
  
  --�����Ŀ��Ϣ��ϸ��¼
  l_rcd_subj  zf_spec.rcd_subj_info  ; 
  
  --�����ѯ�α� 
  cursor l_cur ( p_cur_super_subj_orient   in  number  , 
                       p_cur_end_year         IN varchar2 DEFAULT '2012',
                       p_cur_end_month        IN varchar2 DEFAULT '08',
                       p_cur_subj_code        IN VARCHAR2 DEFAULT '100201',
                       p_cur_currency             in varchar2  default 'RMB',
                       p_cur_period_length_max  in number default 2 , 
                       p_cur_accounting   in number  , 
                       p_cur_accountingbook  in varchar2 
                       )  
  is 
    select   decode(p_cur_super_subj_orient , 0  , 'dr' , 'cr')  beg_dir , 
                  0 beg_quan ,0 beg_bal ,0 beg_ori_bal, 
                  NVL(sum(a.debitquantity),0) debitquantity , 
                  NVL(sum(a.creditquantity),0)  creditquantity ,
                  NVL(sum(a.localdebitamount),0) localdebitamount ,
                  NVL(sum(a.localcreditamount ),0) localcreditamount ,  
                  NVL(sum(a.debitamount),0) debitamount , 
                  NVL(sum(a.creditamount),0) creditamount ,
                  decode(p_cur_super_subj_orient , 0, 'dr', 'cr') bal_dir,
                  decode(p_cur_super_subj_orient , 0, 
                  NVL(sum(a.debitquantity),0) - NVL(sum(a.creditquantity),0) , 
                  NVL(sum(a.creditquantity),0) -NVL(sum(a.debitquantity),0) )bal_quan , 
                  decode(p_cur_super_subj_orient , 0,
                  NVL(sum(a.localdebitamount),0)-NVL(sum(a.localcreditamount),0) , 
                  NVL(sum(a.localcreditamount),0)-NVL(sum(a.localdebitamount),0)) bal , 
                  decode(p_cur_super_subj_orient , 0, 
                  NVL(sum(a.debitamount),0) - NVL(sum(a.creditamount),0), 
                  NVL(sum(a.creditamount),0) - NVL(sum(a.debitamount),0)) bal_ori    
                 from    bd_acctype e  , bd_accasoa d  , bd_account c , gl_voucher b , gl_detail a
                  where
                  e.pk_acctype = c.pk_acctype    
                  and     c.dr  = 0 
                  and     regexp_like(c.code  ,   p_cur_subj_code  )
                  and     c.pk_account = d.pk_account 
                  and     d.dr  = 0  
                  and     d.pk_accasoa = a.pk_accasoa
                  and     b.tempsaveflag = 'N'
                  and     b.discardflag = 'N'
                  and     b.pk_voucher = a.pk_voucher 
                  and     a.discardflagv =  'N'
                  and     a.dr = 0 
                  and     length(a.adjustperiod)   <=   p_cur_period_length_max
                  and     decode( nvl(b.tallydate , 'Y')  , 'Y' , 1 ,2) >= p_cur_accounting  
                  and     a.pk_currtype  like   p_cur_currency 
                  and     a.periodv between  '00' and p_cur_end_month 
                  and     a.yearv =  p_cur_end_year 
                  and     a.pk_accountingbook  =  p_cur_accountingbook   ; 
 
 
  begin     
    
    --�õ����ֵ�PK
    l_curr_pk  :=  f_curr_pk(p_curr)  ; 

           
  --ȷ������Ŀ�ķ��� 
   l_rcd_subj :=  p_rcd_subj_info(1)  ; 
  if( p_rcd_subj_info.count =1 ) then  
                   l_cur_super_subj_orient  :=l_rcd_subj.bal_orient  ; 
                
  else 
                  --�����һ�����Ͽ�Ŀ,��Ϊ�涨Ϊ 0 ,���ʲ����Ŀ
                    l_cur_super_subj_orient  :=  0  ; 
                    l_rcd_subj.subj_code  := p_subj_code ; 
                    l_rcd_subj.subj_name  := p_subj_code ; 
                    l_rcd_subj.subj_dispname  := p_subj_code ; 
  end if; 
    
    for i in l_cur(l_cur_super_subj_orient     , 
                       p_end_year     ,
                       p_end_month  ,
                       p_subj_code    ,
                       l_curr_pk  ,
                       p_period_length_max  , 
                       p_accounting    , 
                       p_rcd_corp_info.pk_accountingbook  ) loop
	        
        l_rcd.org_code  := p_unit_code  ; 
        l_rcd.curr   :=  p_curr ; 
        l_rcd.subjcode  := p_rcd_subj_info(1).subj_code  ; 
        l_rcd.subjname  :=   p_rcd_subj_info(1) .subj_name ; 
        l_rcd.DISPNAME := p_rcd_subj_info(1).subj_code  ; 
        l_rcd.value_code  :=  null ; 
        l_rcd.value_name  := null; 
        l_rcd.beg_dir :=  i.beg_dir ; 
        l_rcd.beg_quan :=  i.beg_quan ; 
        l_rcd.beg_bal  :=  i.beg_bal ; 
        l_rcd.beg_ori_bal  := i.beg_ori_bal; 
        l_rcd.debitquantity  := i.debitquantity ; 
        l_rcd.creditquantity  := i.creditquantity ; 
        l_rcd.localdebitamount   := i.localdebitamount  ; 
        l_rcd.localcreditamount  := i.localcreditamount   ; 
        l_rcd.debitamount   := i.debitamount ; 
        l_rcd.creditamount   :=  i.creditamount ; 
        l_rcd.bal_dir   := i.bal_dir ; 
        l_rcd.bal_quan   := i.bal_quan ; 
        l_rcd.bal   := i.bal ; 
        l_rcd.bal_ori     := i.bal_ori ; 
        l_rcd.periodv    := p_end_month; 
        l_rcd.yearv  := p_end_year; 
        l_rcd.pk_cust_sup  :=  null ; 
        l_rcd.pk_org   :=  p_rcd_corp_info.pk_org ; 
        l_rcd.self_arap :=   null ; 
        l_rcd.oppo_arap  :=  null ; 
        l_rcd.pk_accsubj :=    p_rcd_subj_info(1).subj_code ; 
        l_rcd.pk_accasoa  :=  p_rcd_subj_info(1).subj_name ;
        l_rcd.pk_accchart  := p_rcd_corp_info.pk_accchart; 
        l_rcd.pk_accsystem  :=  p_rcd_corp_info.pk_accsystem ; 
        p_nt_voucher_detail_s.extend ; 
        p_nt_voucher_detail_s(p_nt_voucher_detail_s.count)  :=  l_rcd ; 
       
    end loop;
  
     
     exception  
     
     when  others  then 
      
      
      if(l_Cur%isopen) then 
       
          close  l_cur ; 
       
       end if;  
       
  
  end ;
  
  
  ---------------------------------------------------------------------------------
   --ʹ�ó��� :    ��ÿ����Ŀ���ڳ�����ĩ�����, ������������
   --              ������������������α���� ,�Կ�Ŀ��ϸ���л��� , 
   --              ������ϸ��Ŀ���ܵ���һ����Ŀ���м���ϼ� 
   --����
   --      p_beg_year  ��ʼ��
   --      p_end_year  ������
   --      p_beg_month  ��ʼ�·�
   --      p_end_month   �����·�
   --      p_unit_code   ��λ����
   --      p_subj_code   ��Ŀ����
   --      p_aux_style   ������������
   --      p_aux_code    �����������
   --      p_aux_name    ������������
   --      p_accur_bool  �Ƿ���������
   --      p_group_name  ��������
   --      p_consolidate_flag    �Ƿ��ǽ��¼���Ŀ���ܵ��ϼ���Ŀ��
   --      p_adjust   �Ƿ���������� �Ƿ����������, Y ,����, N ,������, A ֻ�е�����
   --      p_special  �Ƿ���������,�簴�½��л���
   --      p_rcd_subj_info    ����,��Ŀ��Ϣ��¼, 
   --      p_rcd_corp_info    ��֯��Ϣ��¼����   

  procedure     p_comm_comm_con_y_accur(
                       p_nt_voucher_detail_s   in out   nocopy zf_spec.nt_voucher_detail_s , 
                       p_beg_year        in varchar2  default '2014', 
                       p_end_year         IN varchar2 DEFAULT '2014',
                       p_beg_month     in varchar2  default '01' , 
                       p_end_month        IN varchar2 DEFAULT '08',
                       p_unit_code        IN VARCHAR2 DEFAULT '01',
                       p_subj_code        IN VARCHAR2 DEFAULT '100201',
                       p_rcd_subj_info    in zf_spec.ntx_rcd_subj_info , 
                       p_rcd_corp_info    in zf_spec.rcd_org_info   ,  
                       p_curr             in varchar2  default 'RMB' ,
                       p_period_length_max  in number default 2 , 
                       p_accounting   in number  default 1  ) 
  is
  
  --����������� 
  l_curr_pk    varchar2(20)   ;
  
  --������˿�Ŀ�ķ��� 
  l_cur_super_subj_orient    pls_integer  ;  
  
  --����ƾ֤��ϸ��¼����
  l_rcd  zf_spec.rcd_voucher_detail_s  ; 
  
  --�����Ŀ��Ϣ��ϸ��¼
  l_rcd_subj  zf_spec.rcd_subj_info  ; 
  
  --�����ѯ�α� 
  cursor l_cur ( p_cur_super_subj_orient   in  number  , 
                       p_cur_beg_year   in  varchar2 default  '2014' , 
                       p_cur_end_year         IN varchar2 DEFAULT '2012',
                       p_cur_beg_month      in varchar2  default  '2012' , 
                       p_cur_end_month        IN varchar2 DEFAULT '08',
                       p_cur_subj_code        IN VARCHAR2 DEFAULT '100201',
                       p_cur_currency         in varchar2  default 'RMB' , 
                       p_cur_period_length_max  in number default 2 , 
                       p_cur_accounting   in number  , 
                       p_cur_accountingbook  in varchar2 
                       )  
  is 
    select   decode(p_cur_super_subj_orient , 0  , 'dr' , 'cr')  beg_dir , 
                  0 beg_quan ,0 beg_bal ,0 beg_ori_bal, 
                  NVL(sum(a.debitquantity),0) debitquantity , 
                  NVL(sum(a.creditquantity),0)  creditquantity ,
                  NVL(sum(a.localdebitamount),0) localdebitamount ,
                  NVL(sum(a.localcreditamount ),0) localcreditamount ,  
                  NVL(sum(a.debitamount),0) debitamount , 
                  NVL(sum(a.creditamount),0) creditamount ,
                  decode(p_cur_super_subj_orient , 0, 'dr', 'cr') bal_dir,
                  decode(p_cur_super_subj_orient , 0, 
                  NVL(sum(a.debitquantity),0) - NVL(sum(a.creditquantity),0) , 
                  NVL(sum(a.creditquantity),0) -NVL(sum(a.debitquantity),0) )bal_quan , 
                  decode(p_cur_super_subj_orient , 0,
                  NVL(sum(a.localdebitamount),0)-NVL(sum(a.localcreditamount),0) , 
                  NVL(sum(a.localcreditamount),0)-NVL(sum(a.localdebitamount),0)) bal , 
                  decode(p_cur_super_subj_orient , 0, 
                  NVL(sum(a.debitamount),0) - NVL(sum(a.creditamount),0), 
                  NVL(sum(a.creditamount),0) - NVL(sum(a.debitamount),0)) bal_ori    
                 from    bd_acctype e  , bd_accasoa d  , bd_account c , gl_voucher b , gl_detail a
                  where
                  e.pk_acctype = c.pk_acctype    
                  and     c.dr  = 0 
                  and     regexp_like(c.code  ,   p_cur_subj_code  )
                  and     c.pk_account = d.pk_account
                  and     d.dr = 0 
                  and     d.pk_accasoa = a.pk_accasoa
                  and     b.tempsaveflag = 'N' 
                  and     b.discardflag = 'N'
                  and     b.pk_voucher = a.pk_voucher 
                  and     a.periodv  <> '00'
                  and     a.discardflagv =  'N'
                  and     a.dr = 0 
                  and     length(a.adjustperiod)   <=   p_cur_period_length_max
                  and     decode( nvl(b.tallydate , 'Y')  , 'Y' , 1 ,2) >= p_cur_accounting  
                  and     a.pk_currtype  like   p_cur_currency 
                  and     a.yearv||a.periodv between p_cur_beg_year || p_cur_beg_month  
                           and  p_cur_end_year || p_cur_end_month 
                  and     a.yearv between  p_beg_year  and p_end_year  
                  and     a.pk_accountingbook  =  p_cur_accountingbook   ; 
 
 
  begin     
    
    --�õ����ֵ�PK
    l_curr_pk  :=  f_curr_pk(p_curr)  ; 
           
  --ȷ������Ŀ�ķ��� 
   l_rcd_subj :=  p_rcd_subj_info(1)  ; 
 
   
   
  if( p_rcd_subj_info.count =1 ) then  
                   l_cur_super_subj_orient  :=l_rcd_subj.bal_orient  ; 
                
  else 
                  --�����һ�����Ͽ�Ŀ,��Ϊ�涨Ϊ 0 ,���ʲ����Ŀ
                    l_cur_super_subj_orient  :=  0  ; 
                    l_rcd_subj.subj_code  := p_subj_code ; 
                    l_rcd_subj.subj_name  := p_subj_code ; 
                    l_rcd_subj.subj_dispname  := p_subj_code ; 
  end if; 
    
    for i in l_cur(l_cur_super_subj_orient     , 
                       p_beg_year , 
                       p_end_year     ,
                       p_beg_month , 
                       p_end_month  ,
                       p_subj_code    ,
                       l_curr_pk  ,
                       p_period_length_max  , 
                       p_accounting    , 
                       p_rcd_corp_info.pk_accountingbook  ) loop
	        
        l_rcd.org_code  := p_unit_code  ; 
        l_rcd.curr   :=  p_curr ; 
        l_rcd.subjcode  := p_rcd_subj_info(1).subj_code  ; 
        l_rcd.subjname  :=   p_rcd_subj_info(1).subj_name ; 
        l_rcd.DISPNAME := p_rcd_subj_info(1).subj_dispname ; 
        l_rcd.value_code  :=  null ; 
        l_rcd.value_name  := null; 
        l_rcd.beg_dir :=  i.beg_dir ; 
        l_rcd.beg_quan :=  i.beg_quan ; 
        l_rcd.beg_bal  :=  i.beg_bal ; 
        l_rcd.beg_ori_bal  := i.beg_ori_bal; 
        l_rcd.debitquantity  := i.debitquantity ; 
        l_rcd.creditquantity  := i.creditquantity ; 
        l_rcd.localdebitamount   := i.localdebitamount  ; 
        l_rcd.localcreditamount  := i.localcreditamount   ; 
        l_rcd.debitamount   := i.debitamount ; 
        l_rcd.creditamount   :=  i.creditamount ; 
        l_rcd.bal_dir   := i.bal_dir ; 
        l_rcd.bal_quan   := i.bal_quan ; 
        l_rcd.bal   := i.bal ; 
        l_rcd.bal_ori     := i.bal_ori ; 
        l_rcd.periodv    := p_end_month; 
        l_rcd.yearv  := p_end_year; 
        l_rcd.pk_cust_sup  :=  null ; 
        l_rcd.pk_org   :=  p_rcd_corp_info.pk_org ; 
        l_rcd.self_arap :=   null ; 
        l_rcd.oppo_arap  :=  null ; 
        l_rcd.pk_accsubj :=    p_rcd_subj_info(1).subj_code ; 
        l_rcd.pk_accasoa  :=  p_rcd_subj_info(1).subj_name ;
        l_rcd.pk_accchart  := p_rcd_corp_info.pk_accchart; 
        l_rcd.pk_accsystem  :=  p_rcd_corp_info.pk_accsystem ; 
        p_nt_voucher_detail_s.extend ; 
        p_nt_voucher_detail_s(p_nt_voucher_detail_s.count)  :=  l_rcd ; 
       
    end loop;
  
     
     exception  
     
     when  others  then 
      
      
      if(l_Cur%isopen) then 
       
          close  l_cur ; 
       
       end if;  
       
  
  end ;
  
 
  
  ---------------------------------------------------------------------------------
   --ʹ�ó��� :    ��ÿ����Ŀ���ڳ�����ĩ�����, ������������
   --              ������������������α���� ,�Կ�Ŀ��ϸ���л��� , 
   --              ������ϸ��Ŀ���ܵ���һ����Ŀ���м���ϼ� 
   --����
   --      p_beg_year  ��ʼ��
   --      p_end_year  ������
   --      p_beg_month  ��ʼ�·�
   --      p_end_month   �����·�
   --      p_unit_code   ��λ����
   --      p_subj_code   ��Ŀ����
   --      p_aux_style   ������������
   --      p_aux_code    �����������
   --      p_aux_name    ������������
   --      p_accur_bool  �Ƿ���������
   --      p_group_name  ��������
   --      p_consolidate_flag    �Ƿ��ǽ��¼���Ŀ���ܵ��ϼ���Ŀ��
   --      p_adjust   �Ƿ���������� �Ƿ����������, Y ,����, N ,������, A ֻ�е�����
   --      p_special  �Ƿ���������,�簴�½��л���
   --      p_rcd_subj_info    ����,��Ŀ��Ϣ��¼, 
   --      p_rcd_corp_info    ��֯��Ϣ��¼����   

  procedure     p_comm_comm_con_n_bal(
                       p_nt_voucher_detail_s   in out   nocopy zf_spec.nt_voucher_detail_s , 
                       p_end_year         IN varchar2 DEFAULT '2012',
                       p_end_month        IN varchar2 DEFAULT '08',
                       p_unit_code        IN VARCHAR2 DEFAULT '01',
                       p_subj_code        IN VARCHAR2 DEFAULT '100201',
                       p_rcd_subj_info    in zf_spec.ntx_rcd_subj_info , 
                       p_rcd_corp_info    in zf_spec.rcd_org_info   ,  
                       p_curr             in varchar2  default 'RMB' ,
                       p_period_length_max  in number default 2 , 
                       p_accounting   in number  default 1  ) 
  is
  
  --����������� 
  l_curr_pk    varchar2(20)   ;
  
  --������˿�Ŀ�ķ��� 
  l_cur_super_subj_orient    pls_integer  ;  
  
  --����ƾ֤��ϸ��¼����
  l_rcd  zf_spec.rcd_voucher_detail_s  ; 
  
  --�����Ŀ��Ϣ��ϸ��¼
  l_rcd_subj  zf_spec.rcd_subj_info  ; 
  
  --�����ѯ�α� 
  cursor l_cur ( p_cur_super_subj_orient   in  number  , 
                       p_cur_end_year         IN varchar2 DEFAULT '2012',
                       p_cur_end_month        IN varchar2 DEFAULT '08',
                       p_cur_subj_code        IN VARCHAR2 DEFAULT '100201',
                       p_cur_currency             in varchar2  default 'RMB',
                       p_cur_period_length_max  in number default 2 , 
                       p_cur_accounting   in number  , 
                       p_cur_accountingbook  in varchar2 
                       )  
  is 
    select     c.code  subj_code , d.name  subj_name , d.dispname subj_disp_name , 
                 decode(p_cur_super_subj_orient , 0  , 'dr' , 'cr')  beg_dir , 
                  0 beg_quan ,0 beg_bal ,0 beg_ori_bal, 
                  NVL(sum(a.debitquantity),0) debitquantity , 
                  NVL(sum(a.creditquantity),0)  creditquantity ,
                  NVL(sum(a.localdebitamount),0) localdebitamount ,
                  NVL(sum(a.localcreditamount ),0) localcreditamount ,  
                  NVL(sum(a.debitamount),0) debitamount , 
                  NVL(sum(a.creditamount),0) creditamount ,
                  decode(p_cur_super_subj_orient , 0, 'dr', 'cr') bal_dir,
                  decode(p_cur_super_subj_orient , 0, 
                  NVL(sum(a.debitquantity),0) - NVL(sum(a.creditquantity),0) , 
                  NVL(sum(a.creditquantity),0) -NVL(sum(a.debitquantity),0) )bal_quan , 
                  decode(p_cur_super_subj_orient , 0,
                  NVL(sum(a.localdebitamount),0)-NVL(sum(a.localcreditamount),0) , 
                  NVL(sum(a.localcreditamount),0)-NVL(sum(a.localdebitamount),0)) bal , 
                  decode(p_cur_super_subj_orient , 0, 
                  NVL(sum(a.debitamount),0) - NVL(sum(a.creditamount),0), 
                  NVL(sum(a.creditamount),0) - NVL(sum(a.debitamount),0)) bal_ori    
                 from    bd_acctype e  , bd_accasoa d  , 
                 bd_account c , gl_voucher b , gl_detail a
                  where
                  e.pk_acctype = c.pk_acctype 
                  and     c.dr  = 0 
                  and     regexp_like(c.code  ,   p_cur_subj_code  )
                  and     c.pk_account = d.pk_account
                  and     d.dr = 0 
                  and     d.pk_accasoa = a.pk_accasoa 
                  and     b.tempsaveflag = 'N' 
                  and     b.discardflag = 'N'
                  and     b.pk_voucher = a.pk_voucher 
                  and     a.discardflagv =  'N'
                  and     a.dr = 0 
                  and     length(a.adjustperiod)   <=   p_cur_period_length_max
                  and     decode( nvl(b.tallydate , 'Y')  , 'Y' , 1 ,2) >= p_cur_accounting  
                  and     a.pk_currtype  like   p_cur_currency 
                  and     a.periodv between  '00' and p_cur_end_month 
                  and     a.yearv =  p_cur_end_year 
                  and     a.pk_accountingbook  =  p_cur_accountingbook  
                  group  by  c.code ,  d.name , d.dispname ; 
 
 
  begin     
    
    --�õ����ֵ�PK
    l_curr_pk  :=  f_curr_pk(p_curr)  ; 

           
  --ȷ������Ŀ�ķ��� 
   l_rcd_subj :=  p_rcd_subj_info(1)  ; 
  if( p_rcd_subj_info.count =1 ) then  
                   l_cur_super_subj_orient  :=l_rcd_subj.bal_orient  ; 
                
  else 
                  --�����һ�����Ͽ�Ŀ,��Ϊ�涨Ϊ 0 ,���ʲ����Ŀ
                    l_cur_super_subj_orient  :=  0  ; 
                    l_rcd_subj.subj_code  := p_subj_code ; 
                    l_rcd_subj.subj_name  := p_subj_code ; 
                    l_rcd_subj.subj_dispname  := p_subj_code ; 
  end if; 
    
    for i in l_cur(l_cur_super_subj_orient     , 
                       p_end_year     ,
                       p_end_month  ,
                       p_subj_code    ,
                       l_curr_pk  ,
                       p_period_length_max  , 
                       p_accounting    , 
                       p_rcd_corp_info.pk_accountingbook  ) loop
	        
        l_rcd.org_code  := p_unit_code  ; 
        l_rcd.curr   :=  p_curr ; 
        l_rcd.subjcode  :=  i.subj_code ; 
        l_rcd.subjname  :=  i.subj_name ;  
        l_rcd.DISPNAME :=   i.subj_disp_name ; 
        l_rcd.value_code  :=  null ; 
        l_rcd.value_name  := null; 
        l_rcd.beg_dir :=  i.beg_dir ; 
        l_rcd.beg_quan :=  i.beg_quan ; 
        l_rcd.beg_bal  :=  i.beg_bal ; 
        l_rcd.beg_ori_bal  := i.beg_ori_bal; 
        l_rcd.debitquantity  := i.debitquantity ; 
        l_rcd.creditquantity  := i.creditquantity ; 
        l_rcd.localdebitamount   := i.localdebitamount  ; 
        l_rcd.localcreditamount  := i.localcreditamount   ; 
        l_rcd.debitamount   := i.debitamount ; 
        l_rcd.creditamount   :=  i.creditamount ; 
        l_rcd.bal_dir   := i.bal_dir ; 
        l_rcd.bal_quan   := i.bal_quan ; 
        l_rcd.bal   := i.bal ; 
        l_rcd.bal_ori     := i.bal_ori ; 
        l_rcd.periodv    := p_end_month; 
        l_rcd.yearv  := p_end_year; 
        l_rcd.pk_cust_sup  :=  null ; 
        l_rcd.pk_org   :=  p_rcd_corp_info.pk_org ; 
        l_rcd.self_arap :=   null ; 
        l_rcd.oppo_arap  :=  null ; 
        l_rcd.pk_accsubj :=    p_rcd_subj_info(1).subj_code ; 
        l_rcd.pk_accasoa  :=  p_rcd_subj_info(1).subj_name ;
        l_rcd.pk_accchart  := p_rcd_corp_info.pk_accchart; 
        l_rcd.pk_accsystem  :=  p_rcd_corp_info.pk_accsystem ; 
        p_nt_voucher_detail_s.extend ; 
        p_nt_voucher_detail_s(p_nt_voucher_detail_s.count)  :=  l_rcd ; 
       
    end loop;
  
     
     exception  
     
     when  others  then 
      
      
      if(l_Cur%isopen) then 
       
          close  l_cur ; 
       
       end if;  
       
  
  end ;
  
  
  ---------------------------------------------------------------------------------
   --ʹ�ó��� :    ��ÿ����Ŀ���ڳ�����ĩ�����, ������������
   --              ������������������α���� ,�Կ�Ŀ��ϸ���л��� , 
   --              ������ϸ��Ŀ���ܵ���һ����Ŀ���м���ϼ� 
   --����
   --      p_beg_year  ��ʼ��
   --      p_end_year  ������
   --      p_beg_month  ��ʼ�·�
   --      p_end_month   �����·�
   --      p_unit_code   ��λ����
   --      p_subj_code   ��Ŀ����
   --      p_aux_style   ������������
   --      p_aux_code    �����������
   --      p_aux_name    ������������
   --      p_accur_bool  �Ƿ���������
   --      p_group_name  ��������
   --      p_consolidate_flag    �Ƿ��ǽ��¼���Ŀ���ܵ��ϼ���Ŀ��
   --      p_adjust   �Ƿ���������� �Ƿ����������, Y ,����, N ,������, A ֻ�е�����
   --      p_special  �Ƿ���������,�簴�½��л���
   --      p_rcd_subj_info    ����,��Ŀ��Ϣ��¼, 
   --      p_rcd_corp_info    ��֯��Ϣ��¼����   

  procedure     p_comm_comm_con_n_accur(
                       p_nt_voucher_detail_s   in out   nocopy zf_spec.nt_voucher_detail_s , 
                       p_beg_year        in varchar2  default '2014', 
                       p_end_year         IN varchar2 DEFAULT '2014',
                       p_beg_month     in varchar2  default '01' , 
                       p_end_month        IN varchar2 DEFAULT '08',
                       p_unit_code        IN VARCHAR2 DEFAULT '01',
                       p_subj_code        IN VARCHAR2 DEFAULT '100201',
                       p_rcd_subj_info    in zf_spec.ntx_rcd_subj_info , 
                       p_rcd_corp_info    in zf_spec.rcd_org_info   ,  
                       p_curr             in varchar2  default 'RMB' ,
                       p_period_length_max  in number default 2 , 
                       p_accounting   in number  default 1  ) 
  is
  
  --����������� 
  l_curr_pk    varchar2(20)   ;
  
  --������˿�Ŀ�ķ��� 
  l_cur_super_subj_orient    pls_integer  ;  
  
  --����ƾ֤��ϸ��¼����
  l_rcd  zf_spec.rcd_voucher_detail_s  ; 
  
  --�����Ŀ��Ϣ��ϸ��¼
  l_rcd_subj  zf_spec.rcd_subj_info  ; 
  
  --�����ѯ�α� 
  cursor l_cur ( p_cur_super_subj_orient   in  number  , 
                       p_cur_beg_year   in  varchar2 default  '2014' , 
                       p_cur_end_year         IN varchar2 DEFAULT '2012',
                       p_cur_beg_month      in varchar2  default  '2012' , 
                       p_cur_end_month        IN varchar2 DEFAULT '08',
                       p_cur_subj_code        IN VARCHAR2 DEFAULT '100201',
                       p_cur_currency             in varchar2  default 'RMB',
                       p_cur_period_length_max  in number default 2 , 
                       p_cur_accounting   in number  , 
                       p_cur_accountingbook  in varchar2 
                       )  
  is 
    select     c.code  subj_code , d.name  subj_name , d.dispname subj_disp_name , 
                 decode(p_cur_super_subj_orient , 0  , 'dr' , 'cr')  beg_dir , 
                  0 beg_quan ,0 beg_bal ,0 beg_ori_bal, 
                  NVL(sum(a.debitquantity),0) debitquantity , 
                  NVL(sum(a.creditquantity),0)  creditquantity ,
                  NVL(sum(a.localdebitamount),0) localdebitamount ,
                  NVL(sum(a.localcreditamount ),0) localcreditamount ,  
                  NVL(sum(a.debitamount),0) debitamount , 
                  NVL(sum(a.creditamount),0) creditamount ,
                  decode(p_cur_super_subj_orient , 0, 'dr', 'cr') bal_dir,
                  decode(p_cur_super_subj_orient , 0, 
                  NVL(sum(a.debitquantity),0) - NVL(sum(a.creditquantity),0) , 
                  NVL(sum(a.creditquantity),0) -NVL(sum(a.debitquantity),0) )bal_quan , 
                  decode(p_cur_super_subj_orient , 0,
                  NVL(sum(a.localdebitamount),0)-NVL(sum(a.localcreditamount),0) , 
                  NVL(sum(a.localcreditamount),0)-NVL(sum(a.localdebitamount),0)) bal , 
                  decode(p_cur_super_subj_orient , 0, 
                  NVL(sum(a.debitamount),0) - NVL(sum(a.creditamount),0), 
                  NVL(sum(a.creditamount),0) - NVL(sum(a.debitamount),0)) bal_ori    
                 from    bd_acctype e  , bd_accasoa d  , 
                 bd_account c , gl_voucher b , gl_detail a
                  where
                  e.pk_acctype = c.pk_acctype    
                  and     c.dr  = 0 
                  and     regexp_like(c.code  ,   p_cur_subj_code  )
                  and     c.pk_account = d.pk_account
                  and     d.dr = 0  
                  and     d.pk_accasoa = a.pk_accasoa
                  and     b.tempsaveflag = 'N'
                  and     b.discardflag = 'N'
                  and     b.pk_voucher = a.pk_voucher 
                  and     a.periodv  <> '00'
                  and     a.discardflagv =  'N'
                  and     a.dr = 0 
                  and     length(a.adjustperiod)   <=   p_cur_period_length_max
                  and     decode( nvl(b.tallydate , 'Y')  , 'Y' , 1 ,2) >= p_cur_accounting  
                  and     a.pk_currtype  like   p_cur_currency 
                  and     a.yearv||a.periodv between p_cur_beg_year || p_cur_beg_month  
                           and  p_cur_end_year || p_cur_end_month 
                  and     a.yearv between  p_beg_year  and p_end_year  
                  and     a.pk_accountingbook  =  p_cur_accountingbook  
                  group by   c.code , d.name , d.dispname  ; 
 
 
  begin     
    
    --�õ����ֵ�PK
    l_curr_pk  :=  f_curr_pk(p_curr)  ; 
           
  --ȷ������Ŀ�ķ��� 
   l_rcd_subj :=  p_rcd_subj_info(1)  ; 
  if( p_rcd_subj_info.count =1 ) then  
                   l_cur_super_subj_orient  :=l_rcd_subj.bal_orient  ; 
                
  else 
                  --�����һ�����Ͽ�Ŀ,��Ϊ�涨Ϊ 0 ,���ʲ����Ŀ
                    l_cur_super_subj_orient  :=  0  ; 
                    l_rcd_subj.subj_code  := p_subj_code ; 
                    l_rcd_subj.subj_name  := p_subj_code ; 
                    l_rcd_subj.subj_dispname  := p_subj_code ; 
  end if; 
    
    for i in l_cur(l_cur_super_subj_orient     , 
                       p_beg_year , 
                       p_end_year     ,
                       p_beg_month , 
                       p_end_month  ,
                       p_subj_code    ,
                       l_curr_pk  ,
                       p_period_length_max  , 
                       p_accounting    , 
                       p_rcd_corp_info.pk_accountingbook  ) loop
	        
        l_rcd.org_code  := p_unit_code  ; 
        l_rcd.curr   :=  p_curr ; 
        l_rcd.subjcode  := i.subj_code ; 
        l_rcd.subjname  :=  i.subj_name ; 
        l_rcd.DISPNAME := i.subj_disp_name ; 
        l_rcd.value_code  :=  null ; 
        l_rcd.value_name  := null; 
        l_rcd.beg_dir :=  i.beg_dir ; 
        l_rcd.beg_quan :=  i.beg_quan ; 
        l_rcd.beg_bal  :=  i.beg_bal ; 
        l_rcd.beg_ori_bal  := i.beg_ori_bal; 
        l_rcd.debitquantity  := i.debitquantity ; 
        l_rcd.creditquantity  := i.creditquantity ; 
        l_rcd.localdebitamount   := i.localdebitamount  ; 
        l_rcd.localcreditamount  := i.localcreditamount   ; 
        l_rcd.debitamount   := i.debitamount ; 
        l_rcd.creditamount   :=  i.creditamount ; 
        l_rcd.bal_dir   := i.bal_dir ; 
        l_rcd.bal_quan   := i.bal_quan ; 
        l_rcd.bal   := i.bal ; 
        l_rcd.bal_ori     := i.bal_ori ; 
        l_rcd.periodv    := p_end_month; 
        l_rcd.yearv  := p_end_year; 
        l_rcd.pk_cust_sup  :=  null ; 
        l_rcd.pk_org   :=  p_rcd_corp_info.pk_org ; 
        l_rcd.self_arap :=   null ; 
        l_rcd.oppo_arap  :=  null ; 
        l_rcd.pk_accsubj :=    p_rcd_subj_info(1).subj_code ; 
        l_rcd.pk_accasoa  :=  p_rcd_subj_info(1).subj_name ;
        l_rcd.pk_accchart  := p_rcd_corp_info.pk_accchart; 
        l_rcd.pk_accsystem  :=  p_rcd_corp_info.pk_accsystem ; 
        p_nt_voucher_detail_s.extend ; 
        p_nt_voucher_detail_s(p_nt_voucher_detail_s.count)  :=  l_rcd ; 
       
    end loop;
  
     
     exception  
     
     when  others  then 
      
      
      if(l_Cur%isopen) then 
       
          close  l_cur ; 
       
       end if;  
       
  
  end ;
  
  
  
  
   
  
  
  
  --��������������α����  , ����ϸ��Ŀ���Ժϲ�
  --���� 
      -- ͬ  f_tb_bal_accur�Ĳ���˵��

  procedure    p_comm_comm_con_n(p_nt_voucher_detail_s   in out   nocopy zf_spec.nt_voucher_detail_s , 
                      p_beg_year         IN varchar2 DEFAULT '2012',
                       p_end_year         IN varchar2 DEFAULT '2012',
                       p_beg_month        IN varchar2 DEFAULT '01',
                       p_end_month        IN varchar2 DEFAULT '08',
                       p_unit_code        IN VARCHAR2 DEFAULT '01',
                       p_subj_code        IN VARCHAR2 DEFAULT '100201',
                       p_accur_bool       in varchar2 default 'Y',
                       p_rcd_subj_info    in zf_spec.ntx_rcd_subj_info, 
                       p_rcd_corp_info    in zf_spec.rcd_org_info  , 
                       p_curr             in varchar2 default 'BWB' ,
                       p_period_length_max  in number default 2 , 
                       p_accounting   in  NUMBER  )
  is
  begin 
  
       --���ּ������ ,���Ǽ��㷢����  
       
       case  upper(p_accur_bool)  
       
         --�����㷢����  �� ��������  
          when  'Y' THEN  
          
             p_comm_comm_con_n_accur(p_nt_voucher_detail_s , p_beg_year,p_end_year , 
                        p_beg_month , p_end_month,
                        p_unit_code, p_subj_code  , p_rcd_subj_info ,
                        p_rcd_corp_info , p_curr ,  p_period_length_max , p_accounting )  ; 
                        
          
         --���������     
          else 
          
             p_comm_comm_con_n_bal(p_nt_voucher_detail_s , p_end_year , p_end_month,
                        p_unit_code, p_subj_code  , p_rcd_subj_info ,
                        p_rcd_corp_info , p_curr ,  p_period_length_max , p_accounting )  ; 
            
            
        end case ; 
     
  end ;
  
  
  
  
  
  --��������������α����  , ����ϸ��Ŀ���кϲ� ����һ����Ŀ 
  --���� 
      -- ͬ  f_tb_bal_accur�Ĳ���˵��

  procedure    p_comm_comm_con_y(p_nt_voucher_detail_s   in out   nocopy zf_spec.nt_voucher_detail_s , 
                      p_beg_year         IN varchar2 DEFAULT '2012',
                       p_end_year         IN varchar2 DEFAULT '2012',
                       p_beg_month        IN varchar2 DEFAULT '01',
                       p_end_month        IN varchar2 DEFAULT '08',
                       p_unit_code        IN VARCHAR2 DEFAULT '01',
                       p_subj_code        IN VARCHAR2 DEFAULT '100201',
                       p_accur_bool       in varchar2 default 'Y',
                       p_rcd_subj_info    in zf_spec.ntx_rcd_subj_info, 
                       p_rcd_corp_info    in zf_spec.rcd_org_info  , 
                       p_curr             in varchar2 default 'BWB' ,
                       p_period_length_max  in number default 2 , 
                       p_accounting   in  NUMBER  )
  is
  begin 
  
       --���ּ������ ,���Ǽ��㷢����  
       
       case  upper(p_accur_bool)  
       
         --�����㷢����  �� ��������  
          when  'Y' THEN  
          
             p_comm_comm_con_y_accur(p_nt_voucher_detail_s , p_beg_year,p_end_year , 
                        p_beg_month , p_end_month,
                        p_unit_code, p_subj_code  , p_rcd_subj_info ,
                        p_rcd_corp_info , p_curr ,  p_period_length_max , p_accounting )  ; 
                        
          
         --���������     
          else 
          
             p_comm_comm_con_y_bal(p_nt_voucher_detail_s , p_end_year , p_end_month,
                        p_unit_code, p_subj_code  , p_rcd_subj_info ,
                        p_rcd_corp_info , p_curr ,  p_period_length_max , p_accounting )  ; 
            
            
        end case ; 
     
  end ;
  
  
  
  
  
  
  
  ----------------------------------------------------------------
  --�õ��� �����������������α�  , ��ͨҵ�� 
  --���� 
  --�μ�  f_bal_accur; 
   procedure    p_comm_comm( p_nt_voucher_detail_s   in out   nocopy zf_spec.nt_voucher_detail_s , 
                       p_beg_year         IN varchar2 DEFAULT '2014',
                       p_end_year         IN varchar2 DEFAULT '2014',
                       p_beg_month        IN varchar2 DEFAULT '01',
                       p_end_month        IN varchar2 DEFAULT '02',
                       p_unit_code        IN VARCHAR2 DEFAULT '01',
                       p_subj_code        IN VARCHAR2 DEFAULT '100201',
                       p_accur_bool       in varchar2 default 'Y' ,
                       p_consolidate_flag in varchar2 default 'Y' , 
                       p_rcd_subj_info    in zf_spec.ntx_rcd_subj_info , 
                       p_rcd_corp_info    in zf_spec.rcd_org_info , 
                       p_curr             in varchar2 default 'BWB',
                       p_period_length_max  in number default 2 , 
                       p_accounting   in number  )
    is
    
    begin 
     
     ----����ϸ��Ŀ,���ܵ���һ����Ŀ
      if ( upper(p_consolidate_flag)  = 'Y' ) then 
    
             p_comm_comm_con_y(p_nt_voucher_detail_s , p_beg_year , p_end_year , 
             p_beg_month, p_end_month,
                       p_unit_code, p_subj_code,  p_accur_bool , 
                       p_rcd_subj_info , p_rcd_corp_info ,
                       p_curr,    p_period_length_max , 
                       p_accounting  ) ;              
     else  
          
         -------������ϸ��Ŀ, �ֱ���л���    
         p_comm_comm_con_n(p_nt_voucher_detail_s , p_beg_year , p_end_year , 
                 p_beg_month, p_end_month,
                       p_unit_code, p_subj_code,  p_accur_bool , 
                       p_rcd_subj_info , p_rcd_corp_info ,
                       p_curr,    p_period_length_max , 
                       p_accounting  ) ;              
          
     end if; 
                      

     
     
    end ; 
  
  
 
  
  
  ---------------------------------------------------------------------
  --�õ� �������������������α� 
  --���� 
  --�μ�  f_bal_accur; 
   procedure     p_comm( 
                       p_nt_voucher_detail_s   in out   nocopy zf_spec.nt_voucher_detail_s , 
                       p_beg_year         IN varchar2 DEFAULT '2014',
                       p_end_year         IN varchar2 DEFAULT '2014',
                       p_beg_month        IN varchar2 DEFAULT '01',
                       p_end_month        IN varchar2 DEFAULT '02',
                       p_unit_code        IN VARCHAR2 DEFAULT '01',
                       p_subj_code        IN VARCHAR2 DEFAULT '100201',
                       p_accur_bool       in varchar2 default 'Y' ,
                       p_consolidate_flag in varchar2 default 'Y' , 
                       p_special          in varchar2  , 
                       p_rcd_subj_info    in zf_spec.ntx_rcd_subj_info , 
                       p_rcd_corp_info    in zf_spec.rcd_org_info  , 
                       p_curr             in varchar2 default 'BWB' ,
                       p_period_length_max  in number default 2 , 
                       p_accounting   in  number ) 
    is

    begin  
    
    --����P_SPECIAL���������ж�  , �ֱ��ߺ���ҵ�� 
    
    case upper(p_special ) 
    
       --����Ҫ���º�����л���  
        when   'I305' then  
                       
            null; 
        
        else 
                       p_comm_comm(p_nt_voucher_detail_s , p_beg_year , p_end_year , p_beg_month,
                       p_end_month, p_unit_code, p_subj_code , 
                       p_accur_bool  ,p_consolidate_flag , 
                       p_rcd_subj_info ,  p_rcd_corp_info ,
                       p_curr , 
                       p_period_length_max , 
                       p_accounting  ) ; 
        
       end case ; 

  
  end ;
  
  
  ----�洢���̣�����������
  --p_rcd_kstd_nt_voucher ƾ֤���м�¼
  --p_kstd_nt_voucher    ����������ƾ֤��ϸ�� ÿ������һ�У������н��л��� 
  --p_kstd_doc           ���������ϸ���� 
  --p_kstd_mark          ���������־
  
  procedure  p_kstd(p_rcd_kstd_nt_voucher  in out   zf_spec.rcd_voucher_detail_s ,   
                    p_kstd_nt_voucher  in out    zf_spec.nt_voucher_detail_s  , 
                    p_kstd_doc         in        zf_spec.ntx_rcd_defdoc ,  
                    p_kstd_mark        in out    pls_integer )
  is
  
  --��ʾ����  , ˵���Ƿ���  p_kstd_nt_voucher �������������ļ�¼  
  l_mark      pls_integer   :=  0  ;  
  
  
 
  begin 
    
         --���� ���������ϸ������ ���Ƿ��� ������� ƾ֤�еĿ��̱��� 
         for  x  in 1 ..  p_kstd_doc.count  loop  
           
             if (   ( p_rcd_kstd_nt_voucher.value_code  =  p_kstd_doc(x).def_value_code  and 
                  p_rcd_kstd_nt_voucher.org_code   like   p_kstd_doc(x).def_unit_code)  
                    or  
                    (p_rcd_kstd_nt_voucher.value_code  =  p_kstd_doc(x).def_real_value_code )
                 )  then
               
                 --- ˵�� ��  ���������ϸ�����д�����Ҫ�滻�Ŀ���
                 p_kstd_mark  := 1 ;  
                 
                  
                 --�滻�����̱���Ϳ������� 
                 p_rcd_kstd_nt_voucher.value_code := p_kstd_doc(x).def_real_value_code ; 
                 p_rcd_kstd_nt_voucher.value_name := p_kstd_doc(x).def_name ; 
                 
                 --�Ѷ�Ӧ�Ŀ��̶�Ӧ�Ĳ�����֯��Ϊ�� ~ , �Ա����ɿ����ڲ�������ϸ���а�����Ҫ����Ŀ���
                 p_rcd_kstd_nt_voucher.pk_aux_fi_org  := 'not~' ; 
                 
                 
                 --����Ҫ�滻�Ŀ���ƾ֤�н��д��� 
                 
                 l_mark  :=   0 ;   
               
                 --���� ƾ֤������ͬ VALUE_CODE �ļ�¼ 
                 for y  in  1 .. p_kstd_nt_voucher.count   loop  
                   
                       if (  p_rcd_kstd_nt_voucher.value_code  =  p_kstd_nt_voucher(y).value_code 
                             and  p_rcd_kstd_nt_voucher.subjcode  =  p_kstd_nt_voucher(y).subjcode ) then 
                         
                                   p_kstd_nt_voucher(y).debitquantity  := p_rcd_kstd_nt_voucher.debitquantity 
                                      +p_kstd_nt_voucher(y).debitquantity    ;  
                                   p_kstd_nt_voucher(y).creditquantity := p_rcd_kstd_nt_voucher.creditquantity
                                      + p_kstd_nt_voucher(y).creditquantity    ; 
                                   p_kstd_nt_voucher(y).localdebitamount  := p_rcd_kstd_nt_voucher.localdebitamount
                                      +p_kstd_nt_voucher(y).localdebitamount   ; 
                                   p_kstd_nt_voucher(y).localcreditamount  := p_rcd_kstd_nt_voucher.localcreditamount 
                                      +p_kstd_nt_voucher(y).localcreditamount  ; 
                                   p_kstd_nt_voucher(y).debitamount   := p_rcd_kstd_nt_voucher.debitamount 
                                      + p_kstd_nt_voucher(y).debitamount ; 
                                   p_kstd_nt_voucher(y).creditamount   :=  p_rcd_kstd_nt_voucher.creditamount 
                                      +p_kstd_nt_voucher(y).creditamount ; 
                                   
                                   
                                   if ( p_rcd_kstd_nt_voucher.bal_dir  =  p_kstd_nt_voucher(y).bal_dir  ) then 
                                     
                                         p_kstd_nt_voucher(y).bal_quan   :=  p_rcd_kstd_nt_voucher.bal_quan +
                                          p_kstd_nt_voucher(y).bal_quan   ;  
                                         p_kstd_nt_voucher(y).bal     :=  p_rcd_kstd_nt_voucher.bal  +
                                          p_kstd_nt_voucher(y).bal;  
                                         p_kstd_nt_voucher(y).bal_ori    := p_rcd_kstd_nt_voucher.bal_ori +
                                          p_kstd_nt_voucher(y).bal_ori ;  
                                   
                                   
                                   else  
                                     
                                         p_kstd_nt_voucher(y).bal_quan   := - p_rcd_kstd_nt_voucher.bal_quan +
                                          p_kstd_nt_voucher(y).bal_quan   ;  
                                         p_kstd_nt_voucher(y).bal     := - p_rcd_kstd_nt_voucher.bal +
                                          p_kstd_nt_voucher(y).bal;  
                                         p_kstd_nt_voucher(y).bal_ori    := -p_rcd_kstd_nt_voucher.bal_ori +
                                          p_kstd_nt_voucher(y).bal_ori ;  
                                   
                                   end  if;  
                                   
                                  if ( p_rcd_kstd_nt_voucher.beg_dir  =  p_kstd_nt_voucher(y).beg_dir  ) then 
                                     
                                         p_kstd_nt_voucher(y).beg_quan   :=   p_rcd_kstd_nt_voucher.beg_quan +
                                              p_kstd_nt_voucher(y).beg_quan  ;  
                                         p_kstd_nt_voucher(y).beg_bal     :=   p_rcd_kstd_nt_voucher.beg_bal +
                                             p_kstd_nt_voucher(y).beg_bal   ;  
                                         p_kstd_nt_voucher(y).beg_ori_bal    :=  p_rcd_kstd_nt_voucher.beg_ori_bal +
                                            p_kstd_nt_voucher(y).beg_ori_bal  ;  
                                   
                                   
                                   else  
                                     
                                         p_kstd_nt_voucher(y).beg_quan   :=  - p_rcd_kstd_nt_voucher.beg_quan +
                                              p_kstd_nt_voucher(y).beg_quan  ;  
                                         p_kstd_nt_voucher(y).beg_bal     :=  - p_rcd_kstd_nt_voucher.beg_bal +
                                             p_kstd_nt_voucher(y).beg_bal   ;  
                                         p_kstd_nt_voucher(y).beg_ori_bal    := - p_rcd_kstd_nt_voucher.beg_ori_bal +
                                            p_kstd_nt_voucher(y).beg_ori_bal  ;  
                                   
                                   
                                   end  if;  
                           
                             
                           l_mark  := 1 ; 
                       
                       end if; 
                       
                       
                       
                 
                 end loop ; 
             
             
             
                 --���ƾ֤����û�м�¼ƥ�䣬��Ѵ˼�¼���뵽ƾ֤���� 
                 if(l_mark =  0  ) then 
                  
                     p_kstd_nt_voucher.extend ; 
                     p_kstd_nt_voucher(p_kstd_nt_voucher.count) := p_rcd_kstd_nt_voucher ;
                 
                 
                 end if;  
                 
                 
                 
                 
                --�ҵ����˳�  
                exit;  
             
             end if;  
         
         end loop ;    
  
  
  end ; 
  
  
  
  
  ---------------------------------------------------------------------------------
   --ʹ�ó��� :    ��ÿ����Ŀ���ڳ�����ĩ�����, ������������
   --              ������������������α���� ,�Կ�Ŀ��ϸ���л��� , 
   --              ������ϸ��Ŀ���ܵ���һ����Ŀ���м���ϼ� 
   --����
   --      p_beg_year  ��ʼ��
   --      p_end_year  ������
   --      p_beg_month  ��ʼ�·�
   --      p_end_month   �����·�
   --      p_unit_code   ��λ����
   --      p_subj_code   ��Ŀ����
   --      p_aux_style   ������������
   --      p_aux_code    �����������
   --      p_aux_name    ������������
   --      p_accur_bool  �Ƿ���������
   --      p_group_name  ��������
   --      p_consolidate_flag    �Ƿ��ǽ��¼���Ŀ���ܵ��ϼ���Ŀ��
   --      p_adjust   �Ƿ���������� �Ƿ����������, Y ,����, N ,������, A ֻ�е�����
   --      p_special  �Ƿ���������,�簴�½��л���
   --      p_rcd_subj_info    ����,��Ŀ��Ϣ��¼, 
   --      p_rcd_corp_info    ��֯��Ϣ��¼����   

  procedure     p_aux_comm_con_y_bal_cust(
                       p_nt_voucher_detail_s   in out   nocopy zf_spec.nt_voucher_detail_s , 
                       p_end_year         IN varchar2 DEFAULT '2012',
                       p_end_month        IN varchar2 DEFAULT '08',
                       p_unit_code        IN VARCHAR2 DEFAULT '01',
                       p_subj_code        IN VARCHAR2 DEFAULT '100201',
                       p_aux_code         IN VARCHAR2 DEFAULT '*',
                       p_aux_name         IN VARCHAR2 DEFAULT '*',   
                       p_aux_fi_org          in  varchar2  ,   --��Ӧ������֯ ,����ɸѡ�ڲ�����   
                       p_rcd_subj_info    in zf_spec.ntx_rcd_subj_info , 
                       p_rcd_corp_info    in zf_spec.rcd_org_info   ,  
                       p_curr             in varchar2  default 'RMB' ,
                       p_period_length_max  in number default 2 , 
                       p_accounting   in number  default 1 
                   )  
  is
  
  --����������� 
  l_curr_pk    varchar2(20)   ;
  
  --������˿�Ŀ�ķ��� 
  l_cur_super_subj_orient    pls_integer  ;  
  
  --����ƾ֤��ϸ��¼����
  l_rcd  zf_spec.rcd_voucher_detail_s  ; 
  
  --�����Ŀ��Ϣ��ϸ��¼
  l_rcd_subj  zf_spec.rcd_subj_info  ; 
  
  --�����ѯ�α� 
  cursor l_cur ( p_cur_super_subj_orient   in  number  , 
                       p_cur_end_year         IN varchar2 DEFAULT '2012',
                       p_cur_end_month        IN varchar2 DEFAULT '08',
                       p_cur_subj_code        IN VARCHAR2 DEFAULT '100201',
                       p_cur_aux_code         IN VARCHAR2 DEFAULT '*',
                       p_cur_aux_name         IN VARCHAR2 DEFAULT '*',   
                       p_cur_aux_fi_org               in varchar2  default   '~'  ,
                       p_cur_currency             in varchar2  default 'RMB',
                       p_cur_period_length_max  in number default 2 , 
                       p_cur_accounting   in number  , 
                       p_cur_accountingbook  in varchar2 
                )  
  is 
   with the_amount as  
   ( select       nvl(g.code , c.code)  value_code, 
                  nvl(g.name , d.dispname )  value_name, 
                  nvl(g.pk_financeorg ,'~')  pk_aux_fi_org , 
                  a.debitquantity, 
                  a.creditquantity   ,
                  a.localdebitamount   ,
                  a.localcreditamount   ,  
                  a.debitamount  , 
                  a.creditamount  
                  from       bd_cust_supplier g , gl_docfree1 f,
                             bd_acctype e  , bd_accasoa d  , bd_account c , gl_voucher b , gl_detail a
                  where
                  regexp_like(nvl(g.code,'null') , p_cur_aux_code)
                  and     regexp_like(nvl(g.name, 'null') ,  p_cur_aux_name)
                  and     nvl(g.pk_financeorg ,'~')   not  like  p_cur_aux_fi_org   
                  and     nvl(g.dr ,0) =  0 
                  and     g.pk_cust_sup (+)=  f.f4 
                  and     nvl(f.dr , 0) =  0   
                  and     f.assid (+)=  a.assid 
                  and     e.dr = 0 
                  and     e.pk_acctype = c.pk_acctype  
                  and     c.dr  = 0 
                  and     regexp_like(c.code  ,   p_cur_subj_code  )
                  and     c.pk_account = d.pk_account 
                  and     d.dr = 0 
                  and     d.pk_accasoa = a.pk_accasoa
                  and     b.tempsaveflag = 'N' 
                  and     b.dr  =  0 
                  and     b.discardflag = 'N'
                  and     b.pk_voucher = a.pk_voucher 
                  and     a.discardflagv =  'N'
                  and     a.dr = 0 
                  and     length(a.adjustperiod)   <=   p_cur_period_length_max
                  and     decode( nvl(b.tallydate , 'Y')  , 'Y' , 1 ,2) >= p_cur_accounting  
                  and     a.pk_currtype  like   p_cur_currency 
                  and     a.periodv between  '00' and p_cur_end_month 
                  and     a.yearv =  p_cur_end_year 
                  and     a.pk_accountingbook  =  p_cur_accountingbook  
          )          
            select  value_code , value_name , pk_aux_fi_org , 
            decode(p_cur_super_subj_orient , 0  , 'dr' , 'cr')  beg_dir , 
            0 beg_quan ,0 beg_bal ,0 beg_ori_bal, 
            NVL(sum(debitquantity),0) debitquantity , 
            NVL(sum(creditquantity),0)  creditquantity ,
            NVL(sum(localdebitamount),0) localdebitamount ,
            NVL(sum(localcreditamount ),0) localcreditamount ,  
            NVL(sum(debitamount),0) debitamount , 
            NVL(sum(creditamount),0) creditamount ,
            decode(p_cur_super_subj_orient , 0, 'dr', 'cr') bal_dir,
            decode(p_cur_super_subj_orient , 0, 
            NVL(sum(debitquantity),0) - NVL(sum(creditquantity),0) , 
            NVL(sum(creditquantity),0) -NVL(sum(debitquantity),0) )bal_quan , 
            decode(p_cur_super_subj_orient , 0,
            NVL(sum(localdebitamount),0)-NVL(sum(localcreditamount),0) , 
            NVL(sum(localcreditamount),0)-NVL(sum(localdebitamount),0)) bal , 
            decode(p_cur_super_subj_orient , 0, 
            NVL(sum(debitamount),0) - NVL(sum(creditamount),0), 
            NVL(sum(creditamount),0) - NVL(sum(debitamount),0)) bal_ori          
            from    the_amount   
            group by value_code  , value_name , pk_aux_fi_org   ; 
            
            
  cursor  l_cur_def_kstd  is 
           select decode(substr(a.code , 1, 1) , '*' , '%'  , a.code)  def_unit_code  ,   
           nvl(substr(a.name, 1, instr(a.name,'_')-1) , 'null')   def_value_code  , 
           a.shortname    def_real_value_code   ,  a.memo  def_name 
           from bd_defdoc a 
           where a.pk_defdoclist = (SELECT  a.pk_defdoclist  from  bd_defdoclist a
           where a.code = zf_spec.INVEST_SUBJ_CORRESPOND )  ;           
   
  
  --��������������ϸ����          
  l_ntx_def_kstd  zf_spec.ntx_rcd_defdoc ;  
  
  --��������� 
  l_count pls_integer;  
  
  
  --���屻����Ŀ���ƾ֤�� 
  l_nt_voucher_detail_kstd   zf_spec.nt_voucher_detail_s  := zf_spec.nt_voucher_detail_s() ; 
  
  --�����־������ ����˵���Ƿ������Ҫ���п����滻 
  l_kstd_mark  pls_integer  :=     0 ;  

  begin     
  
    --�õ����ֵ�PK
    l_curr_pk  :=  f_curr_pk(p_curr)  ; 

           
  --ȷ������Ŀ�ķ��� 
   l_rcd_subj :=  p_rcd_subj_info(1)  ; 
  if( p_rcd_subj_info.count =1 ) then  
                   l_cur_super_subj_orient  :=l_rcd_subj.bal_orient  ; 
                
  else 
                  --�����һ�����Ͽ�Ŀ,��Ϊ�涨Ϊ 0 ,���ʲ����Ŀ
                    l_cur_super_subj_orient  :=  0  ; 
                   /* l_rcd_subj.subj_code  := p_subj_code ; 
                    l_rcd_subj.subj_name  := p_subj_code ; 
                    l_rcd_subj.subj_dispname  := p_subj_code ; */
  end if; 
    
  
  ---�õ������������ϸ���� 
  l_count :=  1 ;  
  
  for  rcd  in  l_cur_def_kstd loop  
      
       l_ntx_def_kstd(l_count).def_unit_code  :=rcd.def_unit_code ; 
       l_ntx_def_kstd(l_count).def_value_code  :=rcd.def_value_code ; 
       l_ntx_def_kstd(l_count).def_real_value_code  :=rcd.def_real_value_code ; 
       l_ntx_def_kstd(l_count).def_name  :=rcd.def_name ; 
       
       l_count := l_count +1 ;   
  
  end loop ; 
  
  
  
    for i in l_cur(l_cur_super_subj_orient     , 
                       p_end_year     ,
                       p_end_month  ,
                       p_subj_code    ,
                       p_aux_code , 
                       p_aux_name,
                       p_aux_fi_org,
                       l_curr_pk  ,
                       p_period_length_max  , 
                       p_accounting    , 
                       p_rcd_corp_info.pk_accountingbook  ) loop
    
        l_rcd.org_code  := p_unit_code  ; 
        l_rcd.curr   :=  p_curr ; 
        l_rcd.subjcode  := p_rcd_subj_info(1).subj_code ; 
        l_rcd.subjname  := p_rcd_subj_info(1).subj_name ; 
        l_rcd.DISPNAME  := p_rcd_subj_info(1).subj_dispname ; 
        l_rcd.value_code  :=  i.value_code ; 
        l_rcd.value_name  := i.value_name ; 
        l_rcd.beg_dir :=  i.beg_dir ; 
        l_rcd.beg_quan :=  i.beg_quan ; 
        l_rcd.beg_bal  :=  i.beg_bal ; 
        l_rcd.beg_ori_bal  := i.beg_ori_bal; 
        l_rcd.debitquantity  := i.debitquantity ; 
        l_rcd.creditquantity  := i.creditquantity ; 
        l_rcd.localdebitamount   := i.localdebitamount  ; 
        l_rcd.localcreditamount  := i.localcreditamount   ; 
        l_rcd.debitamount   := i.debitamount ; 
        l_rcd.creditamount   :=  i.creditamount ; 
        l_rcd.bal_dir   := i.bal_dir ; 
        l_rcd.bal_quan   := i.bal_quan ; 
        l_rcd.bal   := i.bal ; 
        l_rcd.bal_ori     := i.bal_ori ; 
        l_rcd.periodv    := p_end_month; 
        l_rcd.yearv  := p_end_year; 
        l_rcd.pk_cust_sup  :=  null ; 
        l_rcd.pk_org   :=  p_rcd_corp_info.pk_org ; 
        l_rcd.self_arap :=   null ; 
        l_rcd.oppo_arap  :=  null ; 
        l_rcd.pk_accsubj :=    p_rcd_subj_info(1).pk_account ; 
        l_rcd.pk_accasoa  :=  p_rcd_subj_info(1).pk_accasoa ;
        l_rcd.pk_accchart  := p_rcd_corp_info.pk_accchart; 
        l_rcd.pk_accsystem  :=  p_rcd_corp_info.pk_accsystem ; 
        l_rcd.pk_aux_fi_org := i.pk_aux_fi_org  ; 
        
        --������������������ʼֵ 
        l_kstd_mark  := 0  ; 
        
        --���п������ 
        p_kstd(l_rcd ,  l_nt_voucher_detail_kstd , l_ntx_def_kstd , l_kstd_mark) ;  
        
        
        --����û���������� �������������ŵ�ѭ���������� 
        if( l_kstd_mark  =  0  ) then  
             p_nt_voucher_detail_s.extend ; 
             p_nt_voucher_detail_s(p_nt_voucher_detail_s.count)  :=  l_rcd ; 
        end if;  
       
    end loop;
    
    --������������ 
    for x  in 1 ..  l_nt_voucher_detail_kstd.count  loop  
          p_nt_voucher_detail_s.extend ; 
          p_nt_voucher_detail_s(p_nt_voucher_detail_s.count)  :=  l_nt_voucher_detail_kstd(x) ; 
       
    end loop ;  
    
   
    exception  
     
     when  others  then 
      
      
      if(l_Cur%isopen) then 
       
          close  l_cur ; 
       
       end if;  
       
  
  end ;
  
  

  
  ---------------------------------------------------------------------------------------------------------
  --��������������α����  , ����ϸ��Ŀ���кϲ� ����һ����Ŀ 
  --���� 
      -- ͬ  f_tb_bal_accur�Ĳ���˵��

  procedure    p_aux_comm_con_y_bal(p_nt_voucher_detail_s   in out   nocopy zf_spec.nt_voucher_detail_s , 
                       p_end_year         IN varchar2 DEFAULT '2012',
                       p_end_month        IN varchar2 DEFAULT '08',
                       p_unit_code        IN VARCHAR2 DEFAULT '01',
                       p_subj_code        IN VARCHAR2 DEFAULT '100201',
                       p_aux_style      in varchar2 default  '����' , 
                       p_aux_code     in varchar2  default  '*' , 
                       p_aux_name    in varchar2 default '*' ,  
                       p_aux_fi_org    in varchar2 default  '~' , 
                       p_rcd_subj_info    in zf_spec.ntx_rcd_subj_info, 
                       p_rcd_corp_info    in zf_spec.rcd_org_info  , 
                       p_curr             in varchar2 default 'BWB' ,
                       p_period_length_max  in number default 2 , 
                       p_accounting   in  NUMBER  )
  is
  begin 
  
       --���ּ������ ,���Ǽ��㷢����  
       
       case  upper(p_aux_style)  
       
         --������̸���
          when  '����'  THEN  
          
             p_aux_comm_con_y_bal_cust(p_nt_voucher_detail_s , p_end_year , 
                        p_end_month,
                        p_unit_code, p_subj_code  ,  p_aux_code , p_aux_name , p_aux_fi_org ,   p_rcd_subj_info ,
                        p_rcd_corp_info , p_curr ,  p_period_length_max , p_accounting )  ; 
                        
          
         --���������     
          else 
          
                           null ;  
            
            
        end case ; 
     
  end ;
  
  
  
  --------------------------------------------------------------------------------------------------------------
  
   --ʹ�ó��� :    ��ÿ����Ŀ���ڳ�����ĩ�����, ������������
   --              ������������������α���� ,�Կ�Ŀ��ϸ���л��� , 
   --              ������ϸ��Ŀ���ܵ���һ����Ŀ���м���ϼ� 
   --����
   --      p_beg_year  ��ʼ��
   --      p_end_year  ������
   --      p_beg_month  ��ʼ�·�
   --      p_end_month   �����·�
   --      p_unit_code   ��λ����
   --      p_subj_code   ��Ŀ����
   --      p_aux_style   ������������
   --      p_aux_code    �����������
   --      p_aux_name    ������������
   --      p_accur_bool  �Ƿ���������
   --      p_group_name  ��������
   --      p_consolidate_flag    �Ƿ��ǽ��¼���Ŀ���ܵ��ϼ���Ŀ��
   --      p_adjust   �Ƿ���������� �Ƿ����������, Y ,����, N ,������, A ֻ�е�����
   --      p_special  �Ƿ���������,�簴�½��л���
   --      p_rcd_subj_info    ����,��Ŀ��Ϣ��¼, 
   --      p_rcd_corp_info    ��֯��Ϣ��¼����   

  procedure     p_aux_comm_con_n_bal_cust(
                       p_nt_voucher_detail_s   in out   nocopy zf_spec.nt_voucher_detail_s , 
                       p_end_year         IN varchar2 DEFAULT '2012',
                       p_end_month        IN varchar2 DEFAULT '08',
                       p_unit_code        IN VARCHAR2 DEFAULT '01',
                       p_subj_code        IN VARCHAR2 DEFAULT '100201',
                       p_aux_code         IN VARCHAR2 DEFAULT '*',
                       p_aux_name         IN VARCHAR2 DEFAULT '*',   
                       p_aux_fi_org          in  varchar2  ,   --��Ӧ������֯ ,����ɸѡ�ڲ�����   
                       p_rcd_subj_info    in zf_spec.ntx_rcd_subj_info , 
                       p_rcd_corp_info    in zf_spec.rcd_org_info   ,  
                       p_curr             in varchar2  default 'RMB' ,
                       p_period_length_max  in number default 2 , 
                       p_accounting   in number  default 1 
                   )  
  is
  
  --����������� 
  l_curr_pk    varchar2(20)   ;
  
  --������˿�Ŀ�ķ��� 
  l_cur_super_subj_orient    pls_integer  ;  
  
  --����ƾ֤��ϸ��¼����
  l_rcd  zf_spec.rcd_voucher_detail_s  ; 
  
  --�����Ŀ��Ϣ��ϸ��¼
  l_rcd_subj  zf_spec.rcd_subj_info  ; 
  
  --�����ѯ�α� 
  cursor l_cur ( p_cur_super_subj_orient   in  number  , 
                       p_cur_end_year         IN varchar2 DEFAULT '2012',
                       p_cur_end_month        IN varchar2 DEFAULT '08',
                       p_cur_subj_code        IN VARCHAR2 DEFAULT '100201',
                       p_cur_aux_code         IN VARCHAR2 DEFAULT '*',
                       p_cur_aux_name         IN VARCHAR2 DEFAULT '*',   
                       p_cur_aux_fi_org               in varchar2  default   '~'  ,
                       p_cur_currency             in varchar2  default 'RMB',
                       p_cur_period_length_max  in number default 2 , 
                       p_cur_accounting   in number  , 
                       p_cur_accountingbook  in varchar2 
                       )  
  is 
   with the_amount as  
   ( select        nvl(g.code , c.code)  value_code, 
                   nvl(g.name , d.dispname )  value_name, 
                   c.code  subjcode ,  
                   d.name  subjname , 
                   d.dispname  dispname ,
          --������ʶ���� , �������Ŀ���,������һ����Ŀ���л��ܲ����̸���ʱ ,˵�� ��¼���е� subjcode�ֶ� ,����ϸ��Ŀ����
         --���ǿ��̵����ı��� ,  �������ڹ�ȨͶ�ʵ���ϸ�б�ʱʹ��  ; ��Ϊ 'subjcode' , ��˵������ϸ��Ŀ���� ,  �����'cust'  ,  ��
      --˵���� ���̵����ı���  
                   decode( nvl(g.code , 'subjcode' )   , 'subjcode' , 'subjcode' , 'cust' )   arap_self  ,
          --�����ڳ��ڹ�ȨͶ����ϸ���н����ڲ����̵�ɸѡ           
                  nvl(g.pk_financeorg , '~')  pk_aux_fi_org ,
                  a.debitquantity, 
                  a.creditquantity   ,
                  a.localdebitamount   ,
                  a.localcreditamount   ,  
                  a.debitamount  , 
                  a.creditamount  
                 from     bd_cust_supplier g , gl_docfree1 f,
                          bd_acctype e  , bd_accasoa d  , bd_account c , gl_voucher b , gl_detail a
                  where
                  regexp_like(nvl(g.code,'null') , p_cur_aux_code)
                  and  regexp_like(nvl(g.name, 'null') ,  p_cur_aux_name)
                  and     nvl(g.pk_financeorg ,'~')   not  like  p_cur_aux_fi_org   
                  and     nvl(g.dr ,0) =  0 
                  and     g.pk_cust_sup (+)=  f.f4 
                  and     nvl(f.dr , 0) =  0   
                  and     f.assid (+)=  a.assid 
                  and     e.dr = 0 
                  and     e.pk_acctype = c.pk_acctype    
                  and     c.dr  = 0 
                  and     regexp_like(c.code  ,   p_cur_subj_code  )
                  and     c.pk_account = d.pk_account 
                  and     d.dr = 0 
                  and     d.pk_accasoa = a.pk_accasoa
                  and     b.tempsaveflag = 'N'
                  and     b.dr  =  0 
                  and     b.discardflag = 'N'
                  and     b.pk_voucher = a.pk_voucher 
                  and     a.discardflagv =  'N'
                  and     a.dr = 0 
                  and     length(a.adjustperiod)   <=   p_cur_period_length_max
                  and     decode( nvl(b.tallydate , 'Y')  , 'Y' , 1 ,2) >= p_cur_accounting  
                  and     a.pk_currtype  like   p_cur_currency 
                  and     a.periodv between  '00' and p_cur_end_month 
                  and     a.yearv =  p_cur_end_year 
                  and     a.pk_accountingbook  =  p_cur_accountingbook  
          )          
           select  value_code , value_name , subjcode , subjname  , dispname , arap_self  , 
            pk_aux_fi_org ,
            decode(p_cur_super_subj_orient , 0  , 'dr' , 'cr')  beg_dir , 
            0 beg_quan ,0 beg_bal ,0 beg_ori_bal,
            NVL(sum(debitquantity),0) debitquantity , 
            NVL(sum(creditquantity),0)  creditquantity ,
            NVL(sum(localdebitamount),0) localdebitamount ,
            NVL(sum(localcreditamount ),0) localcreditamount ,  
            NVL(sum(debitamount),0) debitamount , 
            NVL(sum(creditamount),0) creditamount ,
            decode(p_cur_super_subj_orient , 0, 'dr', 'cr') bal_dir,
            decode(p_cur_super_subj_orient , 0, 
            NVL(sum(debitquantity),0) - NVL(sum(creditquantity),0) , 
            NVL(sum(creditquantity),0) -NVL(sum(debitquantity),0) )bal_quan , 
            decode(p_cur_super_subj_orient , 0,
            NVL(sum(localdebitamount),0)-NVL(sum(localcreditamount),0) , 
            NVL(sum(localcreditamount),0)-NVL(sum(localdebitamount),0)) bal , 
            decode(p_cur_super_subj_orient , 0, 
            NVL(sum(debitamount),0) - NVL(sum(creditamount),0), 
            NVL(sum(creditamount),0) - NVL(sum(debitamount),0)) bal_ori          
            from    the_amount 
            group by value_code  , value_name  ,subjcode , subjname , dispname,arap_self,pk_aux_fi_org   ; 

  
  cursor  l_cur_def_kstd  is 
           select decode(substr(a.code , 1, 1) , '*' , '%'  , a.code)  def_unit_code  ,   
           nvl(substr(a.name, 1, instr(a.name,'_')-1) , 'null')  def_value_code   , 
           a.shortname    def_real_value_code   ,  a.memo  def_name 
           from bd_defdoc a 
           where a.pk_defdoclist = (SELECT  a.pk_defdoclist  from  bd_defdoclist a
           where a.code = zf_spec.INVEST_SUBJ_CORRESPOND )  ;            
   
  
  --��������������ϸ����          
  l_ntx_def_kstd  zf_spec.ntx_rcd_defdoc ;  
  
  --��������� 
  l_count pls_integer;  
  
  
  --���屻����Ŀ���ƾ֤�� 
  l_nt_voucher_detail_kstd   zf_spec.nt_voucher_detail_s  := zf_spec.nt_voucher_detail_s() ; 
  
  --�����־������ ����˵���Ƿ������Ҫ���п����滻 
  l_kstd_mark  pls_integer  :=     0 ;  
  
  
  
  begin     
  
    --�õ����ֵ�PK
    l_curr_pk  :=  f_curr_pk(p_curr)  ; 

           
  --ȷ������Ŀ�ķ��� 
   l_rcd_subj :=  p_rcd_subj_info(1)  ; 
   
  if( p_rcd_subj_info.count =1 ) then  
  
                   l_cur_super_subj_orient  :=l_rcd_subj.bal_orient  ; 
                
  else 
                  --�����һ�����Ͽ�Ŀ,��Ϊ�涨Ϊ 0 ,���ʲ����Ŀ
                    l_cur_super_subj_orient  :=  0  ; 
  
  end if; 
  
  
   ---�õ������������ϸ���� 
  l_count :=  1 ;  
  
  for  rcd  in  l_cur_def_kstd loop  
      
       l_ntx_def_kstd(l_count).def_unit_code  :=rcd.def_unit_code ; 
       l_ntx_def_kstd(l_count).def_value_code  :=rcd.def_value_code ; 
       l_ntx_def_kstd(l_count).def_real_value_code  :=rcd.def_real_value_code ; 
       l_ntx_def_kstd(l_count).def_name  :=rcd.def_name ; 
       
       l_count := l_count +1 ;   
  
  end loop ; 
  
  
    
    for i in l_cur(l_cur_super_subj_orient     , 
                       p_end_year     ,
                       p_end_month  ,
                       p_subj_code    ,
                       p_aux_code , 
                       p_aux_name,
                       p_aux_fi_org,
                       l_curr_pk  ,
                       p_period_length_max  , 
                       p_accounting    , 
                       p_rcd_corp_info.pk_accountingbook  ) loop
    
        l_rcd.org_code  := p_unit_code  ; 
        l_rcd.curr   :=  p_curr ; 
        l_rcd.subjcode  :=  i.subjcode  ;    
        l_rcd.subjname  :=    i.subjname ; 
        l_rcd.DISPNAME :=  i.dispname ; 
        l_rcd.value_code  :=  i.value_code ; 
        l_rcd.value_name  := i.value_name ; 
        l_rcd.beg_dir :=  i.beg_dir ; 
        l_rcd.beg_quan :=  i.beg_quan ; 
        l_rcd.beg_bal  :=  i.beg_bal ; 
        l_rcd.beg_ori_bal  := i.beg_ori_bal; 
        l_rcd.debitquantity  := i.debitquantity ; 
        l_rcd.creditquantity  := i.creditquantity ; 
        l_rcd.localdebitamount   := i.localdebitamount  ; 
        l_rcd.localcreditamount  := i.localcreditamount   ; 
        l_rcd.debitamount   := i.debitamount ; 
        l_rcd.creditamount   :=  i.creditamount ; 
        l_rcd.bal_dir   := i.bal_dir ; 
        l_rcd.bal_quan   := i.bal_quan ; 
        l_rcd.bal   := i.bal ; 
        l_rcd.bal_ori     := i.bal_ori ; 
        l_rcd.periodv    := p_end_month; 
        l_rcd.yearv  := p_end_year; 
        l_rcd.pk_cust_sup  :=  null ; 
        l_rcd.pk_org   :=  p_rcd_corp_info.pk_org ; 
        l_rcd.self_arap :=   i.arap_self   ; 
        l_rcd.oppo_arap  :=  null ; 
        l_rcd.pk_accsubj :=    p_rcd_subj_info(1).pk_account ; 
        l_rcd.pk_accasoa  :=  p_rcd_subj_info(1).pk_accasoa ;
        l_rcd.pk_accchart  := p_rcd_corp_info.pk_accchart; 
        l_rcd.pk_accsystem  :=  p_rcd_corp_info.pk_accsystem ; 
        l_rcd.pk_aux_fi_org  :=  i.pk_aux_fi_org  ; 
        
        --������������������ʼֵ 
        l_kstd_mark  := 0  ; 
        
        --���п������ 
        p_kstd(l_rcd ,  l_nt_voucher_detail_kstd , l_ntx_def_kstd , l_kstd_mark) ;  
        
        
        --����û���������� �������������ŵ�ѭ���������� 
        if( l_kstd_mark  =  0  ) then  
             p_nt_voucher_detail_s.extend ; 
             p_nt_voucher_detail_s(p_nt_voucher_detail_s.count)  :=  l_rcd ; 
        end if;  
        
    
       
    end loop;
    
    --������������ 
    for x  in 1 ..  l_nt_voucher_detail_kstd.count  loop  
          p_nt_voucher_detail_s.extend ; 
          p_nt_voucher_detail_s(p_nt_voucher_detail_s.count)  :=  l_nt_voucher_detail_kstd(x) ; 
       
    end loop ;  
    
    
   
     exception  
     
     when  others  then 
      
      
      if(l_Cur%isopen) then 
       
          close  l_cur ; 
       
       end if;  
       
  
  end ;
  
  ---------------------------------------------------------------------------------------------------
  --��������������α����  , ����ϸ��Ŀ���кϲ� ����һ����Ŀ 
  --���� 
      -- ͬ  f_tb_bal_accur�Ĳ���˵��

  procedure     p_aux_comm_con_n_bal(p_nt_voucher_detail_s   in out   nocopy zf_spec.nt_voucher_detail_s , 
                       p_end_year         IN varchar2 DEFAULT '2012',
                       p_end_month        IN varchar2 DEFAULT '08',
                       p_unit_code        IN VARCHAR2 DEFAULT '01',
                       p_subj_code        IN VARCHAR2 DEFAULT '100201',
                       p_aux_style      in varchar2 default  '����' , 
                       p_aux_code     in varchar2  default  '*' , 
                       p_aux_name    in varchar2 default '*' ,  
                       p_aux_fi_org    in varchar2 default  '~' , 
                       p_rcd_subj_info    in zf_spec.ntx_rcd_subj_info, 
                       p_rcd_corp_info    in zf_spec.rcd_org_info  , 
                       p_curr             in varchar2 default 'BWB' ,
                       p_period_length_max  in number default 2 , 
                       p_accounting   in  NUMBER  )
  is
  begin 
  
       --���ּ������ ,���Ǽ��㷢����  
       
       case  upper(p_aux_style)  
       
         --������̸���
          when  '����'  THEN  
          
              p_aux_comm_con_n_bal_cust(p_nt_voucher_detail_s , p_end_year , 
                        p_end_month,
                        p_unit_code, p_subj_code  ,  p_aux_code , p_aux_name , p_aux_fi_org ,   p_rcd_subj_info ,
                        p_rcd_corp_info , p_curr ,  p_period_length_max , p_accounting )  ; 
                        
          
         --���������     
          else 
          
                           null ;  
            
            
        end case ; 
     
  end ;
  
  
  
  -----------------------------------------------------------------------------------------------------------
  
  --��������������α����  , ����ϸ��Ŀ���кϲ� ����һ����Ŀ 
  --���� 
      -- ͬ  f_tb_bal_accur�Ĳ���˵��

  procedure    p_aux_comm_con_n(p_nt_voucher_detail_s   in out   nocopy zf_spec.nt_voucher_detail_s , 
                      p_beg_year         IN varchar2 DEFAULT '2012',
                       p_end_year         IN varchar2 DEFAULT '2012',
                       p_beg_month        IN varchar2 DEFAULT '01',
                       p_end_month        IN varchar2 DEFAULT '08',
                       p_unit_code        IN VARCHAR2 DEFAULT '01',
                       p_subj_code        IN VARCHAR2 DEFAULT '100201',
                       p_aux_style      in varchar2 default  '����' , 
                       p_aux_code     in varchar2  default  '*' , 
                       p_aux_name    in varchar2 default '*' ,  
                       p_aux_fi_org    in varchar2 default  '~' , 
                       p_accur_bool       in varchar2 default 'Y',
                       p_rcd_subj_info    in zf_spec.ntx_rcd_subj_info, 
                       p_rcd_corp_info    in zf_spec.rcd_org_info  , 
                       p_curr             in varchar2 default 'BWB' ,
                       p_period_length_max  in number default 2 , 
                       p_accounting   in  NUMBER  )
  is
  begin 
  
       --���ּ������ ,���Ǽ��㷢����  
       
       case  upper(p_accur_bool)  
       
         --�����㷢����  �� ��������  
          when  'Y' THEN  
          
             ----�ݲ�����
            
              if(  p_beg_year = p_beg_month) then  
              
                     null ; 
              
              end if; 
            
              null;  
              
         --���������     
          else 
          
             p_aux_comm_con_n_bal(p_nt_voucher_detail_s , p_end_year , p_end_month,
                        p_unit_code, p_subj_code  ,  p_aux_style, p_aux_code ,p_aux_name, p_aux_fi_org  , 
                        p_rcd_subj_info , p_rcd_corp_info , p_curr ,  p_period_length_max , p_accounting )  ; 
            
        end case ; 
     
  end ;
  
  
  
  
  
  
  ------------------------------------------------------------------------------------------------------------------------

  
  --��������������α����  , ����ϸ��Ŀ���кϲ� ����һ����Ŀ 
  --���� 
      -- ͬ  f_tb_bal_accur�Ĳ���˵��

  procedure    p_aux_comm_con_y(p_nt_voucher_detail_s   in out   nocopy zf_spec.nt_voucher_detail_s , 
                      p_beg_year         IN varchar2 DEFAULT '2012',
                       p_end_year         IN varchar2 DEFAULT '2012',
                       p_beg_month        IN varchar2 DEFAULT '01',
                       p_end_month        IN varchar2 DEFAULT '08',
                       p_unit_code        IN VARCHAR2 DEFAULT '01',
                       p_subj_code        IN VARCHAR2 DEFAULT '100201',
                       p_aux_style      in varchar2 default  '����' , 
                       p_aux_code     in varchar2  default  '*' , 
                       p_aux_name    in varchar2 default '*' ,  
                       p_aux_fi_org    in varchar2 default  '~' , 
                       p_accur_bool       in varchar2 default 'Y',
                       p_rcd_subj_info    in zf_spec.ntx_rcd_subj_info, 
                       p_rcd_corp_info    in zf_spec.rcd_org_info  , 
                       p_curr             in varchar2 default 'BWB' ,
                       p_period_length_max  in number default 2 , 
                       p_accounting   in  NUMBER  )
  is
  begin 
  
       --���ּ������ ,���Ǽ��㷢����  
       
       case  upper(p_accur_bool)  
       
         --�����㷢����  �� ��������  
          when  'Y' THEN  
          
             ----�ݲ�����
            if( p_beg_year  = p_beg_month) then 
            
                 null ;  
                 
             end if;
            
           null ;
           
         --���������     
          else 
          
             p_aux_comm_con_y_bal(p_nt_voucher_detail_s , p_end_year , p_end_month,
                        p_unit_code, p_subj_code  ,  p_aux_style, p_aux_code ,p_aux_name, p_aux_fi_org  , 
                        p_rcd_subj_info , p_rcd_corp_info , p_curr ,  p_period_length_max , p_accounting )  ; 
            
        end case ; 
     
  end ;
  
  
  
  ----------------------------------------------------------------
  --�õ��� �����������������α�  , ��ͨҵ�� 
  --���� 
  --�μ�  f_bal_accur; 
   procedure    p_aux_comm( p_nt_voucher_detail_s   in out   nocopy zf_spec.nt_voucher_detail_s , 
                       p_beg_year         IN varchar2 DEFAULT '2014',
                       p_end_year         IN varchar2 DEFAULT '2014',
                       p_beg_month        IN varchar2 DEFAULT '01',
                       p_end_month        IN varchar2 DEFAULT '02',
                       p_unit_code        IN VARCHAR2 DEFAULT '01',
                       p_subj_code        IN VARCHAR2 DEFAULT '100201',
                       p_aux_style      in varchar2 default  '����' , 
                       p_aux_code     in varchar2  default  '*' , 
                       p_aux_name    in varchar2 default '*' ,  
                       p_aux_fi_org    in varchar2 default  '~' , 
                       p_accur_bool       in varchar2 default 'Y' ,
                       p_consolidate_flag in varchar2 default 'Y' , 
                       p_rcd_subj_info    in zf_spec.ntx_rcd_subj_info , 
                       p_rcd_corp_info    in zf_spec.rcd_org_info , 
                       p_curr             in varchar2 default 'BWB',
                       p_period_length_max  in number default 2 , 
                       p_accounting   in number  )
    is
    
    begin 
     
     ----����ϸ��Ŀ,���ܵ���һ����Ŀ
      if ( upper(p_consolidate_flag)  = 'Y' ) then 
        
         
    
             p_aux_comm_con_y(p_nt_voucher_detail_s , p_beg_year , p_end_year , 
             p_beg_month, p_end_month,
                       p_unit_code, p_subj_code  ,  p_aux_style, p_aux_code ,p_aux_name, p_aux_fi_org ,  p_accur_bool  , 
                       p_rcd_subj_info , p_rcd_corp_info ,
                       p_curr,    p_period_length_max , 
                       p_accounting  ) ;      
               
 
           
                               
     else  
          
             p_aux_comm_con_n(p_nt_voucher_detail_s , p_beg_year , p_end_year , 
             p_beg_month, p_end_month,
                       p_unit_code, p_subj_code  ,  p_aux_style, p_aux_code ,p_aux_name, p_aux_fi_org ,  p_accur_bool  , 
                       p_rcd_subj_info , p_rcd_corp_info ,
                       p_curr,    p_period_length_max , 
                       p_accounting  ) ;      
                        
     end if; 
                      
  
    end ; 
  
  
  
  
  
  ---------------------------------------------------------------------
  --�õ� �������������������α� 
  --���� 
  --�μ�  f_bal_accur; 
   procedure     p_aux( 
                       p_nt_voucher_detail_s   in out   nocopy zf_spec.nt_voucher_detail_s , 
                       p_beg_year         IN varchar2 DEFAULT '2014',
                       p_end_year         IN varchar2 DEFAULT '2014',
                       p_beg_month        IN varchar2 DEFAULT '01',
                       p_end_month        IN varchar2 DEFAULT '02',
                       p_unit_code        IN VARCHAR2 DEFAULT '01',
                       p_subj_code        IN VARCHAR2 DEFAULT '100201',
                        p_aux_style        in VARCHAR2 default  '����', 
                       p_aux_code         in varchar2 default  '*' , 
                       p_aux_name         in varchar2 default  '*' , 
                       p_aux_fi_org       in varchar2  default  '~'   ,    --ɸѡ�ڲ�����  
                       p_accur_bool       in varchar2 default 'Y' ,
                       p_consolidate_flag in varchar2 default 'Y' , 
                       p_special          in varchar2  , 
                       p_rcd_subj_info    in zf_spec.ntx_rcd_subj_info , 
                       p_rcd_corp_info    in zf_spec.rcd_org_info  , 
                       p_curr             in varchar2 default 'BWB' ,
                       p_period_length_max  in number default 2 , 
                       p_accounting   in  number ) 
    is

    begin  
    
    --����P_SPECIAL���������ж�  , �ֱ��ߺ���ҵ�� 
    
    case upper(p_special ) 
    
       --����Ҫ���º�����л���  
        when   'I305' then  
                       
            null; 
        
        else 
                    
                      p_aux_comm(p_nt_voucher_detail_s , p_beg_year , p_end_year , 
                      p_beg_month, p_end_month,
                       p_unit_code, p_subj_code  ,  p_aux_style, p_aux_code ,p_aux_name, p_aux_fi_org ,  p_accur_bool  , 
                       p_consolidate_flag , p_rcd_subj_info , p_rcd_corp_info ,
                       p_curr,    p_period_length_max , 
                       p_accounting  ) ;                
                      
        
       end case ; 

  
  end ;
  
  
  
 
  ---------------------------------------------------------------------------------
   --ʹ�ó��� :    ��ÿ����Ŀ���ڳ�����ĩ���������� 
   --����
   --      p_beg_year  ��ʼ��
   --      p_end_year  ������
   --      p_beg_month  ��ʼ�·�
   --      p_end_month   �����·�
   --      p_unit_code   ��λ����
   --      p_subj_code   ��Ŀ����
   --      p_aux_style   ������������
   --      p_aux_code    �����������
   --      p_aux_name    ������������
   --      p_accur_bool  �Ƿ���������
   --      p_group_name  ��������
   --      p_consolidate_flag    �Ƿ��ǽ��¼���Ŀ���ܵ��ϼ���Ŀ��
   --      p_adjust   �Ƿ���������� �Ƿ����������, Y ,����, N ,������, A ֻ�е�����
   --      p_special  �Ƿ���������,������I3_05,���½��л���
   --      p_rcd_subj_info    ����,��Ŀ��Ϣ��¼, 
   --      p_rcd_corp_info    ��֯��Ϣ��¼����   
   --       p_subjcode_regexp               in varchar2  default  'Y' ,    --��Ŀ����ļ����Ƿ���������ʽ
  function f_bal_accur_ex(p_beg_year         IN varchar2 DEFAULT '2014',
                       p_end_year         IN varchar2 DEFAULT '2014',
                       p_beg_month        IN varchar2 DEFAULT '01',
                       p_end_month        IN varchar2 DEFAULT '02',
                       p_unit_code        IN VARCHAR2 DEFAULT '01',
                       p_subj_code        IN VARCHAR2 DEFAULT '100201',
                       p_aux_style        IN VARCHAR2 DEFAULT null,
                       p_aux_code         IN VARCHAR2 DEFAULT '*',
                       p_aux_name         IN VARCHAR2 DEFAULT '*',
                       p_aux_fi_org      in varchar2 default  '~'  ,    --ɸѡ�ڲ�������
                       p_accur_bool       in varchar2 default 'Y',
                       p_adjust           in varchar2 default 'Y' , 
                       p_consolidate_flag in varchar2 default 'Y' , 
                       p_special          in varchar2 default NULL , 
                       p_curr             in varchar2 default 'BWB',
                       p_accounting       in varchar2 default 'Y' , 
                       p_chart_system   in varchar2  default  '0004' ,   --��Ŀ��ϵ����
                       p_subjcode_regexp               in varchar2  default  'Y' ,    --��Ŀ����ļ����Ƿ���������ʽ
                       p_group            in varchar2 default zf_spec.GROUP_ORG_PK )
    RETURN zf_spec.nt_voucher_detail_s 
    pipelined 
    is
    
    ---�������·��ֶ�Ӧ�õĳ���,�����α��ѯ�Ͳ���,�ж��Ƿ����������
  l_period_length_max  pls_integer  default  3 ;
  
  --�����Ƿ����δ���˱�ʶ 
  l_accounting     pls_integer  default  1  ;   
  
    --����Ƕ�ױ����,Ƕ�ױ��¼�ı���, ��Ϊ����ֵ; Ƕ�ױ���м�����
 
    l_tbl   zf_spec.nt_voucher_detail_s := zf_spec.nt_voucher_detail_s();
    
    --���嵥λ���˲�����Ŀ��Ϣ�ļ�¼����,�ڲ�ѯ����ΪWHERE����ʹ��

    l_rcd_corp_info    zf_spec.rcd_org_info ; 
    l_ntx_rcd_subj_info  zf_spec.ntx_rcd_subj_info ; 
    
 
    ----�����Ŀ��ѯ�ַ�������ش������  
    
    l_subjcode_para   bd_account.code%type ; 
    
    begin  
      
    
    
    --ȷ���Ƿ����δ���˵Ĳ��� 
    if( upper(p_accounting) = 'Y')  then  l_accounting  := 1   ;  else  l_accounting := 2  ;  end if; 
    
    --ȷ���Ƿ���������ڵĲ���
    
    if( upper(p_adjust) =  'Y')  then  l_period_length_max := 3  ; else   l_period_length_max := 2  ; end if; 
    
        
     --��ȡ�˲��Ϳ�Ŀ��Ϣ
     
     l_rcd_corp_info  := f_org_info(p_unit_code ,p_group ) ; 

      
     if   ( not regexp_like( l_rcd_corp_info.accsystem_code ,p_chart_system  )    )then
     
                 return ; 
      
     end if;
     
     --�õ���Ŀ�ľ�����Ϣ 
     if( upper(p_subjcode_regexp) = 'Y' ) then 
     
            
     
             l_ntx_rcd_subj_info  := f_subj_info_multi(P_SUBJ_CODE , l_rcd_corp_info.org_code ,  l_rcd_corp_info.pk_group) ;      
     
            
             l_subjcode_para  :=  p_subj_code ;  
     
     else 
              
             
              
             l_ntx_rcd_subj_info  := f_subj_info_single(P_SUBJ_CODE , l_rcd_corp_info.org_code ,  l_rcd_corp_info.pk_group) ; 
       
            
             l_subjcode_para  :=   '^(' || p_subj_code  ||  ')' ; 
    
     end if; 
     
    
   
    
         
                    --�жϲ�����ֵ,�Ƿ����������,Ȼ���߲�ͬ������ 
    
                    case  
                    
                      when ( p_aux_style is null )  then 
                        
                        --������������  
                        
                        p_comm(l_tbl , p_beg_year ,
                        p_end_year , p_beg_month , p_end_month ,p_unit_code, 
                        l_subjcode_para , p_accur_bool   ,p_consolidate_flag , 
                        p_special ,l_ntx_rcd_subj_info,l_rcd_corp_info , p_curr, 
                        l_period_length_max ,    l_accounting  )  ; 
                        
                        
                        
                        ---�����������������
                      
                      else
                        
                    p_aux(l_tbl , p_beg_year ,
                        p_end_year , p_beg_month , p_end_month ,p_unit_code, 
                        l_subjcode_para ,p_aux_style , p_aux_code ,p_aux_name, p_aux_fi_org , 
                         p_accur_bool   ,p_consolidate_flag , 
                        p_special ,l_ntx_rcd_subj_info,l_rcd_corp_info , p_curr, 
                        l_period_length_max ,    l_accounting  )  ; 
                        
                  
                     
                    end case ; 
                
  
  
    --ȡ����ѯ���,��ͨ���ܵ��ͳ�

    for i in 1  ..  l_tbl.count   loop
	        pipe row(l_tbl(i)) ; 
    end loop;

  
  
    return ;
 
 
 end ; 
 
 
 
 
 ---------------------------------------------------------------------------------
   --ʹ�ó��� :  �Կ��̸�������Ŀ�Ŀ�������ط��� , �����ʲ���ծ����
   --����
   --      p_end_year  ������
   --      p_end_month   �����·�
   --      p_unit_code   ��λ����
   --      p_subj_code   ��Ŀ����
   --      p_consolidate_flag    �Ƿ��ǽ��¼���Ŀ���ܵ��ϼ���Ŀ��
   --      p_adjust   �Ƿ���������� �Ƿ����������, Y ,����, N ,������, A ֻ�е�����

  function f_arap_reclass_trail_bal( p_end_year  IN varchar2 DEFAULT '2014',
                       p_end_month        IN varchar2 DEFAULT '02',
                       p_unit_code        IN VARCHAR2 DEFAULT '01',
                       p_arap_item        IN VARCHAR2 DEFAULT 'ar',
                       p_adjust           in varchar2 default 'Y' , 
                       p_consolidate_flag in varchar2 default 'Y' , 
                       p_curr             in varchar2 default 'BWB',
                       p_accounting       in varchar2 default 'Y'  ,
                       p_acc_chart_code   in varchar2 default '0004' 
                       )
    RETURN  number
    is
    
    --���庯������ֵ
    l_number  gl_detail.localcreditamount%type  := 0 ;
    
    --�������,��ŵ�λ������Ϣ
    l_rcd_org_info  zf_spec.rcd_org_info ; 
    
    --��������ط������Ĳ�ѯ�α�
    
    --�����Ĳ�ѯ 
    cursor  l_cur_positive(p_cur_subjcode  varchar2 )   is 
    select  NVL(sum(bal),0) bal  from table(f_bal_accur_ex(p_end_year , p_end_year , 
    p_end_month , p_end_month ,p_unit_code ,  p_cur_subjcode,  '����' ,
    '*' , '*' , '*', 'N' , p_adjust ,p_consolidate_flag ,NULL,p_curr, p_accounting,'*' , 'N')) 
    where  bal >= 0   ;
    
    --�����Ĳ�ѯ 
    cursor  l_cur_negative(p_cur_subjcode  varchar2 )   is 
    select  -NVL(sum(bal),0) bal  from table(f_bal_accur_ex(p_end_year , p_end_year , 
    p_end_month , p_end_month ,p_unit_code ,  p_cur_subjcode,  '����' ,
    '*' , '*' , '*','N' , p_adjust ,p_consolidate_flag ,NULL,p_curr, p_accounting , '*' ,'N')) 
    where  bal < 0   ;
    
    
    --��Ҫ�ط���Ĳ�ѯ 
    cursor  l_cur_all(p_cur_subjcode  varchar2 )   is 
    select  NVL(sum(bal),0) bal  from table(f_bal_accur_ex(p_end_year , p_end_year , 
    p_end_month , p_end_month ,p_unit_code ,  p_cur_subjcode,  '����' ,
    '*' , '*' , '*','N' , p_adjust ,p_consolidate_flag ,NULL,p_curr, p_accounting , '*' , 'N'))  ; 
    
    begin 
      
      --�Է���ֵ���г�ʼ��
      l_number  := 0 ; 
    
      --��ȡ��Ŀ��ϵPK
      l_rcd_org_info   :=   f_org_info(p_unit_code) ; 
      
      ---�����ط���������������
          
      
      for rcd in 1 ..  v_nt_arap_reclass_rule.count   loop  
        
         --������� p_arap_item �� ���������еļ�¼�� arap ֵ��ͬ , ��
         --��Ŀ��ϵ�ṹһ��,����в�ѯ�õ���Ŀ���
        
        if (upper(v_nt_arap_reclass_rule(rcd).arap) =  upper(p_arap_item) )  
           and (v_nt_arap_reclass_rule(rcd).acccsystem_code = 
           l_rcd_org_info.accsystem_code)  then 
                
                      --�������Ϊ�����Ŀ�Ŀ
                      case v_nt_arap_reclass_rule(rcd).the_sign  
                        
                      when  '+'    then 
                          
                         for  i  in  l_cur_positive(v_nt_arap_reclass_rule(rcd).subj) loop
                               
                             l_number  :=  l_number +  i.bal ; 
                         
                         end loop ; 
                       
                       --�������Ϊ�����Ŀ�Ŀ  
                       when  '-'   then 
                       
                          
                           for  i  in  l_cur_negative(v_nt_arap_reclass_rule(rcd).subj) loop
                               
                             l_number  :=  l_number +  i.bal ; 
                         
                           end loop ; 
                           
                           
                        ---�����ط������� 
                         else 
                          
                           for  i  in  l_cur_all(v_nt_arap_reclass_rule(rcd).subj) loop
                               
                             l_number  :=  l_number +  i.bal ; 
                         
                            end loop ; 
                  
                    end case  ;
         
          end if; 
      
      end loop ; 
      
      if( l_rcd_org_info.accsystem_code <> p_acc_chart_code and 
           (upper(p_arap_item) = 'PR' or  upper(p_arap_item) = 'PP')
         ) then  
      
             l_number  := 0  ;
        
      end if; 
    
      return l_number;  
    
    
    --�����쳣
    exception  
      
    when others  then 
      
      ---�ر��α� 
       if(l_cur_positive%isopen) then  
       
            close l_cur_positive ; 
       end if; 
       
        if(l_cur_negative%isopen) then  
       
            close l_cur_negative ; 
       end if; 
       
       return 0  ;
    
    end ; 
 
 
 ---------------------------------------------------------------------------------
   --ʹ�ó��� :  �Կ��̸�������Ŀ�Ŀ�������ط�����ʽ,�Ӹ�ʽ��Ҫ����ת����,�����õ�ծȨծ����ϸ����
   --����
   --      p_end_year  ������
   --      p_end_month   �����·�
   --      p_unit_code   ��λ����
   --      p_subj_code   ��Ŀ����
   --      p_consolidate_flag    �Ƿ��ǽ��¼���Ŀ���ܵ��ϼ���Ŀ��
   --      p_adjust   �Ƿ���������� �Ƿ����������, Y ,����, N ,������, A ֻ�е�����

  function f_arap_reclass_nt( p_end_year  IN varchar2 DEFAULT '2014',
                       p_end_month        IN varchar2 DEFAULT '02',
                       p_unit_code        IN VARCHAR2 DEFAULT '01',
                       p_adjust           in varchar2 default 'Y' ,
                       p_consolidate   in varchar2  default 'Y', 
                       p_accounting       in varchar2 default 'Y'  ,
                       p_aux_fi_org        in varchar2 default  '~'  
    )
    
    RETURN  zf_spec.nt_voucher_detail_s 
    pipelined 
    
    is
    
    --����ƾ֤��ϸ��
    l_tbl   zf_spec.nt_voucher_detail_s  :=  zf_spec.nt_voucher_detail_s();         --���ڷ���ֵ
    l_tbl_tmp   zf_spec.nt_voucher_detail_s  :=  zf_spec.nt_voucher_detail_s();   --�����м����ı���
    l_tbl_init   zf_spec.nt_voucher_detail_s := zf_spec.nt_voucher_detail_s() ;  --Ƕ�ױ��ʼ��
    --�������,��ŵ�λ������Ϣ
    l_rcd_org_info  zf_spec.rcd_org_info ; 
    
    --�����Ŀ�������� 
    l_subj_code_para   bd_account.code%type ; 
    
    --�����Ŀ��ϸ��Ϣ����
    l_tbl_subj     zf_spec.ntx_rcd_subj_info    ; 
    
    --�����Ƿ����δ����ƽ���Ĳ������� 
    l_accounting  pls_integer;  
    
    --�����Ƿ���������ڵĲ������� 
    l_period_length_max   pls_integer ; 
    
    begin 
      
    --ȷ���Ƿ����δ���˵Ĳ��� 
    if( upper(p_accounting) = 'Y')  then  l_accounting  := 1   ;  else  l_accounting := 2  ;  end if; 
    
    --ȷ���Ƿ���������ڵĲ���
    
    if( upper(p_adjust) =  'Y')  then  l_period_length_max := 3  ; else   l_period_length_max := 2  ; end if; 
    
    
      --��ȡ��Ŀ��ϵPK
      l_rcd_org_info   :=   f_org_info(p_unit_code) ; 
      
      ---�����ط���������������
          
      
     for rcd in 1 ..  v_nt_arap_reclass_rule.count   loop  
        

        if (v_nt_arap_reclass_rule(rcd).acccsystem_code =  l_rcd_org_info.accsystem_code)  then 
            
                --ɾ��Ƕ�ױ���е�����
                --l_tbl_tmp.delete ;
                l_tbl_tmp  := l_tbl_init  ;
                
                
                --��ȡ��Ŀ�ı��� ( ��ѯ�� )
                l_subj_code_para :=  '^('||v_nt_arap_reclass_rule(rcd).subj||')'  ; 
                
                --��ȡ��Ŀ����ϸ��Ϣ
                l_tbl_subj(1)  :=  f_subj_info_single(v_nt_arap_reclass_rule(rcd).subj,p_unit_code)(1) ; 
                
                --���� p_aux_comm_con_y_bal_cust��ȡǶ�ױ�����'
                 
                p_aux_comm(l_tbl_tmp,p_end_year, p_end_year, p_end_month , p_end_month,p_unit_code ,
                l_subj_code_para, '����' , '*','*','*' ,'N' , p_consolidate,  l_tbl_subj ,l_rcd_org_info,'BWB' , 
                l_period_length_max , l_accounting) ; 
             
              --���� l_tbl_tmp  ����ʱǶ�ױ��е����� ������ʽǶ�ױ���
               case   v_nt_arap_reclass_rule(rcd).the_sign 
                 
                     when  '+' then   
                     
                      ---ȡ���� 
                      
                                for i in 1.. l_tbl_tmp.count  loop
                                  
                                         if (l_tbl_tmp(i).bal >0  and  
                                         substr(l_tbl_tmp(i).pk_aux_fi_org , 1,1)  <>  p_aux_fi_org    )   then
                                           
                                                   l_tbl.extend ; 
                                                   l_tbl(l_tbl.count).value_code :=    l_tbl_tmp(i).value_code ; 
                                                   l_tbl(l_tbl.count).value_name :=   l_tbl_tmp(i).value_name ; 
                                                   l_tbl(l_tbl.count).bal :=   l_tbl_tmp(i).bal ; 
                                                   l_tbl(l_tbl.count).subjcode   :=   v_nt_arap_reclass_rule(rcd).name_cn ;
                                                   
                                                   
                                         end if;
                                
	
                                  end loop;

                      ---ȡ ����  
                      
                      when  '-' then  
                        
                                for i in 1.. l_tbl_tmp.count  loop
                      
                                   if (l_tbl_tmp(i).bal <0  and   
                                     substr(l_tbl_tmp(i).pk_aux_fi_org , 1,1)  <>  p_aux_fi_org )   then
                                           
                                                   l_tbl.extend ; 
                                                   l_tbl(l_tbl.count).value_code :=    l_tbl_tmp(i).value_code ; 
                                                   l_tbl(l_tbl.count).value_name :=   l_tbl_tmp(i).value_name ; 
                                                   l_tbl(l_tbl.count).bal :=   -l_tbl_tmp(i).bal ; 
                                                   l_tbl(l_tbl.count).subjcode   :=   v_nt_arap_reclass_rule(rcd).name_cn ;
                                                   
                      
                                    end if;
                                    
                                 end loop ; 
                                         
                      else 
                        
                      --������Ҫ�ط������� 
                        
                                for i in 1.. l_tbl_tmp.count  loop
                                                   
                                                   if( l_tbl_tmp(i).bal <> 0  and 
                                                       substr(l_tbl_tmp(i).pk_aux_fi_org , 1,1)  <>  p_aux_fi_org ) then 
                                                   l_tbl.extend ; 
                                                   l_tbl(l_tbl.count).value_code :=    l_tbl_tmp(i).value_code ; 
                                                   l_tbl(l_tbl.count).value_name :=   l_tbl_tmp(i).value_name ; 
                                                   l_tbl(l_tbl.count).bal :=   l_tbl_tmp(i).bal ; 
                                                   l_tbl(l_tbl.count).subjcode   :=   v_nt_arap_reclass_rule(rcd).name_cn ;
                                                   
                                                
                                                   end if;
                                  end loop;
                  
                  end case ;  
          
          end if ; 
          
      
      end loop ; 
     
     
     ---Ƕ�ױ�ͨ�� �ܵ����� 
     for i in 1.. l_tbl.count  loop
       
          pipe row (l_tbl(i) ) ; 
	
      end loop;

     return ; 

    end ; 
 
 
 
  --ʹ�ó��� :  �Կ��̸�������Ŀ�Ŀ�������ط�����ʾ,����ծȨծ����ϸ����
   --����
   --      p_end_year  ������
   --      p_end_month   �����·�
   --      p_unit_code   ��λ����
   --      p_subj_code   ��Ŀ����
   --      p_consolidate_flag    �Ƿ��ǽ��¼���Ŀ���ܵ��ϼ���Ŀ��
   --      p_adjust   �Ƿ���������� �Ƿ����������, Y ,����, N ,������, A ֻ�е�����

  function f_arap_reclass_list( p_end_year  IN varchar2 DEFAULT '2014',
                       p_end_month        IN varchar2 DEFAULT '02',
                       p_unit_code        IN VARCHAR2 DEFAULT '01',
                       p_adjust           in varchar2 default 'Y' , 
                       p_consolidate      in varchar2 default  'Y' , 
                       p_accounting       in varchar2 default 'Y'  ,
                       p_aux_fi_org       in varchar2 default  '~'  
    )
    
    RETURN  zf_spec.nt_rcd_arap_detail 
    pipelined 
    is

    --�����α����
    cursor l_cur(p_curr_end_year  IN varchar2 DEFAULT '2014',
                       p_curr_end_month        IN varchar2 DEFAULT '02',
                       p_curr_unit_code        IN VARCHAR2 DEFAULT '01',
                       p_curr_adjust           in varchar2 default 'Y' , 
                       p_curr_consolidate    in varchar2 default  'Y' , 
                       p_curr_accounting       in varchar2 default 'Y'  ,
                       p_curr_aux_fi_org        in varchar2 default  '~' )   is 
    with befor_sum as (
    select value_code , value_name , decode(subjcode,'or00',bal,0) or00,decode(subjcode,'pp00',bal,0) pp00,
    decode(subjcode,'op00',bal,0) op00,decode(subjcode,'ar00',bal,0) ar00,decode(subjcode,'ap00',bal,0) ap00,
    decode(subjcode,'pr00',bal,0) pr00,decode(subjcode,'pp01',bal,0) pp01,decode(subjcode,'br00',bal,0) br00,
    decode(subjcode,'pr01',bal,0) pr01,decode(subjcode,'bc00',bal,0) bc00  , 
    decode(subjcode,'jr00',bal,0) jr00,decode(subjcode,'jp00',bal,0) jp00 
    from 
    table(f_arap_reclass_nt(p_curr_end_year ,p_curr_end_month , p_curr_unit_code ,p_curr_adjust,
    p_curr_consolidate ,p_curr_accounting ,p_curr_aux_fi_org))  ) 
    select value_code,value_name, sum(or00) or00,sum(pp00) pp00,sum(op00) op00,sum(ar00) ar00,
    sum(ap00) ap00,sum(pr00) pr00,sum(pp01) pp01,sum(br00) br00,sum(pr01) pr01,sum(bc00) bc00  , 
    sum(jr00) jr00,sum(jp00) jp00  
    from  befor_sum  group by   value_code , value_name  ; 
    
    --���巵��ֵ��Ƕ�ױ������
    l_tbl     zf_spec.nt_rcd_arap_detail    := zf_spec.nt_rcd_arap_detail(); 
    
    begin 
    
       for i in  l_cur(p_end_year , p_end_month , p_unit_code , p_adjust , p_consolidate , p_accounting, p_aux_fi_org)     loop  
	     
              l_tbl.extend ; 
              
              l_tbl(l_tbl.count) := i;
       
       end loop;
       
       for i in 1.. l_tbl.count loop
           
                 
                 pipe row(l_tbl(i)) ; 
                         
    
       end loop;
    
       return    ; 
       
       exception   
         
       when others then 
         
           if( l_cur %isopen)   then 
           
                     close  l_cur ; 
            
           end if; 
       
    
    end  ; 
 
 
 ------------��������Ŀ���ط����׼���г�ʼ�� 
 procedure  p_init_reclass_rule
 is
 --�����ѯ�α�,����ARAP�ط����׼
 cursor  l_cur  is
 select substr(a.code , 1, 2) arap  ,  
 substr(a.name , 1,4) subj  ,a.shortname the_sign , substr(a.memo, 1,4)  acccsystem_code  ,
 substr(a.memo, 6,4)  name_cn 
 from bd_defdoc a 
 where a.pk_defdoclist = (SELECT  a.pk_defdoclist  from  bd_defdoclist a
 where a.code = zf_spec.ARAP_RECLASS_RULE_NAME   )   ; 
 
---��ѯ����ARAP������Ŀ
cursor l_cur_arap_item  is
select  distinct  substr(a.memo, 6,4)     arap_item    from bd_defdoc a 
 where a.pk_defdoclist = (SELECT  a.pk_defdoclist  from  bd_defdoclist a
 where a.code = zf_spec.ARAP_RECLASS_RULE_NAME   )  ;  

 
 begin 

     for rcd in  l_cur loop  
          
         v_nt_arap_reclass_rule(v_nt_arap_reclass_rule.count+1) := rcd ;  
     
     end loop ; 
     
     for rcd in  l_cur_arap_item loop  
        
          v_ntx_arap_item_list(v_ntx_arap_item_list.count+1)  :=  rcd.arap_item  ; 
     
     end loop ; 
	

 
 end ; 
 
 
  
 

 
 ---------------------------------------------------------------------------------
   --ʹ�ó��� :    ���ƶ���Ŀ���ڳ�����ĩ���������� 
   --����
   --      p_beg_year  ��ʼ��
   --      p_end_year  ������
   --      p_beg_month  ��ʼ�·�
   --      p_end_month   �����·�
   --      p_unit_code   ��λ����
   --      p_subj_code   ��Ŀ����
   --      p_aux_style   ������������
   --      p_aux_code    �����������
   --      p_aux_name    ������������
   --      p_accur_bool  �Ƿ���������
   --      p_group_name  ��������
   --      p_consolidate_flag    �Ƿ��ǽ��¼���Ŀ���ܵ��ϼ���Ŀ��
   --      p_adjust   �Ƿ���������� �Ƿ����������, Y ,����, N ,������, A ֻ�е�����
   --      p_special  �Ƿ���������,������I3_05,���½��л���
   --      p_curr         ����    'BWB' ,
   --      p_accounting     �Ƿ�����Ѿ�����
   --      p_dir    ���� ,�����������  , ���ƶ�������ķ���
   --ʹ���� :    IUFO������,�����Ŀ��������ʹ��
   --���� :    bieyifeng
   --ʱ��  :   20140428
   function f_bal_iufo(p_beg_year  varchar2 default '2014' ,
                                p_end_year varchar2 default '2014' ,  
                                p_beg_month varchar2 default '01' , 
                                p_end_month  varchar2 default '04' , 
                                p_unit_code  varchar2  default '107001' ,
                                p_subj_code varchar2  default '1001' , 
                                p_accur_bool  varchar2  default  'Y',
                                p_dir     varchar2 default  'cr'  ,
                                p_adjust   varchar2 default 'Y', 
                                p_curr      varchar2  default  'BWB', 
                                p_accounting  varchar2 default  'Y' , 
                                p_bal_dir   varchar2 default  'dr' ,
                                p_chart_system   in varchar2  default  '0004' ,  --��Ŀ��ϵ����  
                                p_subjcode_regexp               in varchar2  default  'Y'     --��Ŀ����ļ����Ƿ���������ʽ
                                )
  return number  
  is
  

  --���庯���ķ���ֵ
  l_number  gl_detail.localcreditamount%type  := 0 ;

  --�����ѯ�α�
  cursor l_cur  is
       select  bal_dir , sum(bal)  bal , sum(bal_ori) bal_ori , sum(localdebitamount)   localdebitamount , 
       sum(localcreditamount) localcreditamount , sum(debitamount) debitamount, sum(creditamount) creditamount 
       from  table(f_bal_accur_ex(p_beg_year ,  p_end_year  ,p_beg_month , p_end_month ,  p_unit_code , p_subj_code , 
       null, null, null, null, p_accur_bool  , 
        p_adjust  ,'Y' , NULL , p_curr , p_accounting ,p_chart_system, p_subjcode_regexp   ) )   group by  bal_dir  ; 
  
  --�α��м�¼���� 
  l_rcd    l_cur%rowtype; 
 
  begin 
       
      for rec in  l_cur  loop  
        
            l_rcd  := rec; 
           
       end loop ; 
     
       if(  l_rcd.bal_dir  is not null ) then 
       
           if( upper(p_bal_dir ) <>  upper(l_rcd.bal_dir)  ) then  
                 l_rcd.bal  := - l_rcd.bal ; 
                 l_rcd.bal_ori := -l_rcd.bal_ori;
            end if  ;
            
        end if; 
        
      --ȷ�������ķ���ֵ
      case upper(p_accur_bool)  
          
         when  'Y'    then  
              
               case   upper(p_dir)  
                 
                    when  'DR'  then 
                             l_number :=   NVL(l_rcd.localdebitamount , 0) ; 
                    when  'CR' then 
                             l_number :=  NVL(l_rcd.localcreditamount , 0) ; 
                     when  'NET' then 
                             l_number :=    NVL(l_rcd.bal  , 0)  ; 
                     else 
                              l_number :=   NVL(l_rcd.localdebitamount , 0) ; 
                end case ; 
                  
         else 
           
                l_number :=  NVL(l_rcd.bal , 0)  ; 
                 
           
       end case ; 
       
       return  l_number ; 
      
      exception  
        
      when others  then  
        
            if (l_cur%isopen)     then
                    
                  close  l_cur ; 
	
              end if;
        
        return  0   ;
      
  
  end ; 
 
 
---------------------------------------------------------------------
--ʹ�ó��� : ������Ҫ���㱨��İ汾����
function  f_invest_nt_orgtd 
return zf_spec.ntx_rcd_defdoc_hb_org 
is

l_ntx_rcd_defdoc    zf_spec.ntx_rcd_defdoc_hb_org ; 



/*--���ݺϲ�������� ,�õ��ϲ�����汾��
cursor l_cur(p_task_name varchar2) is 
select version from  iufo_hbscheme  
where  iufo_hbscheme.dr = 0 and  iufo_hbscheme.name= p_task_name   ; */

--��������Զ�����Ŀ��ȡֵ���� 
cursor  l_cur_def_orgtd  is 
           select substr(a.code , 1, instr(a.code , '_')-1)  invested_code  ,   
           substr(a.name , 1 ,  instr(a.name, '_' )-1)  supper_code  , 
           a.shortname    task_name  
           from bd_defdoc a 
           where a.pk_defdoclist = (SELECT  a.pk_defdoclist  from  bd_defdoclist a
           where a.code = zf_spec.V_IUFO_CONSDT_NAMETRANS )  ;  

---���������
l_counter  pls_integer;  

begin 
  
  --��ȡת��������� 
  l_counter  :=  1 ;  
  
  for x in  l_cur_def_orgtd  loop 
        
         l_ntx_rcd_defdoc(l_counter).invested_code := x.invested_code ; 
         l_ntx_rcd_defdoc(l_counter).supper_code := x.supper_code ;
         l_ntx_rcd_defdoc(l_counter).task_name := x.task_name ;
         l_ntx_rcd_defdoc(l_counter).hb_verson := zf_spec.V_IUFO_CONSDT_VERSON;
         l_counter := l_counter +1; 
         
  end loop ; 
  
 
     
  return  l_ntx_rcd_defdoc ; 
  
end ; 


 
   ---------------------------------------------------------------------------------
   --ʹ�ó��� :    �� f_invest_nt���� ,  ������NC����ȡ���� ����Ͷ�����淢���� 
   --����
   --      p_tbl  ���ڹ�ȨͶ����ϸ��¼����
   --      p_end_year  ������
   --      p_end_month   �����·�
   --      p_unit_code   ��λ����
   --      p_adjust   �Ƿ���������� �Ƿ���������� , Y ,����, N ,������, A ֻ�е�����
   
   
   ---ע�� ��    �Զ�����Ŀ��ע�ĺ���  
                 --  A  ��ʾ��ϸ��Ŀת���ɿ��̱���
                 --  B  ͬһ�������ƣ����ڲ����̱���ת�����ڲ����̱���
                 --  X  ����ʹ�ô˱�� 
                 
   procedure   p_invest_nt_self_rev(p_tbl     in out  zf_spec.nt_rcd_invest_detail  , 
                       p_end_year         IN varchar2 DEFAULT '2014',
                       p_end_month        IN varchar2 DEFAULT '02',
                       p_unit_code        IN VARCHAR2 DEFAULT '01',
                       p_adjust           in varchar2 default 'Y' ,  
                       p_accounting       in varchar2 default 'Y'  )
    is
       ---�������·��ֶ�Ӧ�õĳ��� ,�����α��ѯ�Ͳ���,�ж��Ƿ����������
  l_period_length_max  pls_integer  default  3 ;
  
  --�����Ƿ����δ���˱�ʶ 
  l_accounting     pls_integer  default  1  ;   
  
    --����Ƕ�ױ���� ,��¼ƾ֤��ϸ ;
 
    l_tbl   zf_spec.nt_voucher_detail_s := zf_spec.nt_voucher_detail_s();
     
    
    --���嵥λ���˲�����Ŀ��Ϣ�ļ�¼����,�ڲ�ѯ����Ϊ WHERE����ʹ��

    l_rcd_org_info    zf_spec.rcd_org_info ; 
    l_tbl_subj  zf_spec.ntx_rcd_subj_info ; 
    
    --�����Ŀ�����ַ���
    l_subj_code_para   varchar2(200) ; 
    
    --���峤�ڹ�ȨͶ����ϸ��Ŀ��Ӧ�ڲ���λ����� �Զ�����Ŀ����������� 
    --l_ntx_defdoc    zf_spec.ntx_rcd_defdoc ;  
    
    
    --����һ����ʱ����,����IF�ж�ֻ��  
    --l_tmp_mark   pls_integer ;  
    
    begin  
      
            --ȷ���Ƿ����δ���˵Ĳ��� 
          if( upper(p_accounting) = 'Y')  then  l_accounting  := 1   ;  else  l_accounting := 2  ;  end if; 
          
          --ȷ���Ƿ���������ڵĲ���
          
          if( upper(p_adjust) =  'Y')  then  l_period_length_max := 3  ; else   l_period_length_max := 2  ; end if; 
          
          
            --��ȡ��Ŀ��ϵPK
            l_rcd_org_info   :=  f_org_info(p_unit_code) ; 
            
            
           --��ȡ���ڹ�ȨͶ����ϸ��Ŀ��Ӧ�ڲ���λ����� �Զ�����Ŀ����������� ��ֵ  
            --l_ntx_defdoc   :=    f_invest_nt_inter_unitcode; 
              
            --��ȡ��Ŀ�ı��� ( ��ѯ�� )
            case   l_rcd_org_info.accsystem_code 
               
                    when  '0005' then       
                  
                      l_subj_code_para :=  '5201'  ; 
                      
                    when  '0004' then 
                      
                      l_subj_code_para :=  '6111'  ; 
                      
                    else 
                       
                       l_subj_code_para :=  'aaaaaaaa'  ;  
                       
             end case ; 
                      
                     
             l_tbl_subj  :=  f_subj_info_single(l_subj_code_para,p_unit_code)  ; 
                      
             --���� p_aux_comm��ȡǶ�ױ����� '    
                       
             p_aux_comm(l_tbl,p_end_year, p_end_year, p_end_month , 
                        p_end_month,p_unit_code ,
                      '^(' || l_subj_code_para  ||  ')', '����' ,
                       '*','*','*' ,'N' , 'Y',  l_tbl_subj ,
                      l_rcd_org_info,'BWB' , 
                      l_period_length_max , l_accounting) ; 
               
            --��Ƕ�ױ������ ,ͨ���ܵ��������
             
             for i in 1..  l_tbl.count  loop
             
                     p_tbl.extend ; 
                                 
                     ---��Զ�ǵ�ǰ����
                     p_tbl(p_tbl.count).curr_date  :=   p_end_year || p_end_month ; 
                     p_tbl(p_tbl.count).unit_code  := l_tbl(i).org_code ; 
                     p_tbl(p_tbl.count).tzsy_bq    := l_tbl(i).localcreditamount ; 
                     p_tbl(p_tbl.count).value_code    := l_tbl(i).value_code ; 
                     p_tbl(p_tbl.count).value_name    := l_tbl(i).value_name ; 
                     
                     --ÿ�ڵ����ڣ������1~��ǰ���ڵĻ�
                     p_tbl(p_tbl.count).the_date    :=  p_end_year || p_end_month ;  
                                             
                      
                         
             end loop;
           
         
      end ; 
    





   ---------------------------------------------------------------------------------
   --ʹ�ó��� :    �� f_invest_nt���� ,  ������NC����ȡ���� ���� ���ڹ�ȨͶ�ʵ������������ 
   --����
   --      p_tbl  ���ڹ�ȨͶ����ϸ��¼����
   --      p_end_year  ������
   --      p_end_month   �����·�
   --      p_unit_code   ��λ����
   --      p_adjust   �Ƿ���������� �Ƿ���������� , Y ,����, N ,������, A ֻ�е�����
   
   
   ---ע�� ��    �Զ�����Ŀ��ע�ĺ���  
                 --  A  ��ʾ��ϸ��Ŀת���ɿ��̱���
                 --  B  ͬһ�������ƣ����ڲ����̱���ת�����ڲ����̱���
                 --  X  ����ʹ�ô˱�� 
                 
   procedure   p_invest_nt_self(p_tbl     in out  zf_spec.nt_rcd_invest_detail  , 
                       p_end_year         IN varchar2 DEFAULT '2014',
                       p_end_month        IN varchar2 DEFAULT '02',
                       p_unit_code        IN VARCHAR2 DEFAULT '01',
                       p_adjust           in varchar2 default 'Y' ,  
                       p_accounting       in varchar2 default 'Y'  )
    is
       ---�������·��ֶ�Ӧ�õĳ��� ,�����α��ѯ�Ͳ���,�ж��Ƿ����������
  l_period_length_max  pls_integer  default  3 ;
  
  --�����Ƿ����δ���˱�ʶ 
  l_accounting     pls_integer  default  1  ;   
  
    --����Ƕ�ױ���� ,��¼ƾ֤��ϸ ;
 
    l_tbl   zf_spec.nt_voucher_detail_s := zf_spec.nt_voucher_detail_s();
     
    
    --���嵥λ���˲�����Ŀ��Ϣ�ļ�¼����,�ڲ�ѯ����Ϊ WHERE����ʹ��

    l_rcd_org_info    zf_spec.rcd_org_info ; 
    l_tbl_subj  zf_spec.ntx_rcd_subj_info ; 
    
    --�����Ŀ�����ַ���
    l_subj_code_para   varchar2(200) ; 
    
    --���峤�ڹ�ȨͶ����ϸ��Ŀ��Ӧ�ڲ���λ����� �Զ�����Ŀ����������� 
    --l_ntx_defdoc    zf_spec.ntx_rcd_defdoc ;  
    
    
    --����һ����ʱ����,����IF�ж�ֻ��  
    --l_tmp_mark   pls_integer ;  
    
    begin  
      
            --ȷ���Ƿ����δ���˵Ĳ��� 
          if( upper(p_accounting) = 'Y')  then  l_accounting  := 1   ;  else  l_accounting := 2  ;  end if; 
          
          --ȷ���Ƿ���������ڵĲ���
          
          if( upper(p_adjust) =  'Y')  then  l_period_length_max := 3  ; else   l_period_length_max := 2  ; end if; 
          
          
            --��ȡ��Ŀ��ϵPK
            l_rcd_org_info   :=  f_org_info(p_unit_code) ; 
            
            
           --��ȡ���ڹ�ȨͶ����ϸ��Ŀ��Ӧ�ڲ���λ����� �Զ�����Ŀ����������� ��ֵ  
            --l_ntx_defdoc   :=    f_invest_nt_inter_unitcode; 
              
            --��ȡ��Ŀ�ı��� ( ��ѯ�� )
            case   l_rcd_org_info.accsystem_code 
               
                    when  '0005' then       
                  
                      l_subj_code_para :=  '1401'  ; 
                      
                    when  '0004' then 
                      
                      l_subj_code_para :=  '1511'  ; 
                      
                    else 
                       
                       l_subj_code_para :=  'aaaaaaaa'  ;  
                       
             end case ; 
                      
                     
             l_tbl_subj  :=  f_subj_info_single(l_subj_code_para,p_unit_code)  ; 
                      
             --���� p_aux_comm��ȡǶ�ױ����� '    
                       
             p_aux_comm(l_tbl,p_end_year, p_end_year, p_end_month , 
                        p_end_month,p_unit_code ,
                      '^(' || l_subj_code_para  ||  ')', '����' ,
                       '*','*','*' ,'N' , 'Y',  l_tbl_subj ,
                      l_rcd_org_info,'BWB' , 
                      l_period_length_max , l_accounting) ; 
               
            --��Ƕ�ױ������ ,ͨ���ܵ��������
             
             for i in 1..  l_tbl.count  loop
             
                     p_tbl.extend ; 
                     
                     ---��Զ�ǵ�ǰ����
                     p_tbl(p_tbl.count).curr_date  :=   p_end_year || p_end_month ; 
                     p_tbl(p_tbl.count).unit_code    := l_tbl(i).org_code ; 
                     p_tbl(p_tbl.count).invest_bal    := l_tbl(i).bal ; 
                     p_tbl(p_tbl.count).value_code    := l_tbl(i).value_code ; 
                     p_tbl(p_tbl.count).value_name    := l_tbl(i).value_name ; 
                     
                     --ÿ�ڵ����ڣ������1~��ǰ���ڵĻ�
                     p_tbl(p_tbl.count).the_date    :=  p_end_year || p_end_month ;  
                                             
                      
                         
             end loop;
           
         
      end ; 
    
 

----------------------------------------------------------------------------
--ʹ�ó���: �õ�ָ��Ͷ�ʵ�λ��Ͷ�ʵ�λ( �ӹ�˾ ) �б� 
--����    p_investor     Ͷ�ʷ���λ����
--        p_nt_invest_detail   Ͷ����ϸ��Ƕ�ױ� 
 

procedure  p_get_investee(p_investor  varchar2  ,   
                          p_nt_invest_detail  in out  zf_spec.nt_rcd_invest_detail)
is

--�α� , �õ���Ͷ�ʵ�λ�б�  
cursor  l_cur(p_cur_investor  varchar2 )  
is
Select a.investor invest_org_pk , b.code invest_org_code ,  b.name invest_org_name  ,
a.investee invested_org_pk, c.code invested_org_code ,  
c.name  invested_org_name   , a.assessmode  
from       
org_orgs  c  ,  org_orgs  b  , 
(select distinct t.investor , t.investee ,t.assessmode   from org_stockinvest t 
 where t.dr = 0  ) a 
where  c.pk_org  =  a.investee 
and   b.code  =    p_cur_investor 
and   b.pk_org  =  a.investor ; 


--������֯�������
l_ntx_rcd_defdoc    zf_spec.ntx_rcd_defdoc_hb_org ;

begin 
  
   --�õ���֯������� 
   l_ntx_rcd_defdoc   := f_invest_nt_orgtd ;
   
   for i in l_cur(p_investor)   loop
     
        p_nt_invest_detail.extend ; 
        p_nt_invest_detail(p_nt_invest_detail.count).unit_code    := i.invest_org_code ; 
        p_nt_invest_detail(p_nt_invest_detail.count).value_code   := i.invested_org_code ;
        p_nt_invest_detail(p_nt_invest_detail.count).value_name   := i.invested_org_name ;
   
        p_nt_invest_detail(p_nt_invest_detail.count).assessmode  :=  i.assessmode ; 
        p_nt_invest_detail(p_nt_invest_detail.count).invest_bal    := 0; 
       
        p_nt_invest_detail(p_nt_invest_detail.count).super_code := i.invested_org_code ;
	      p_nt_invest_detail(p_nt_invest_detail.count).rpt_version := 0  ;
        
        for x  in 1 .. l_ntx_rcd_defdoc.count   loop
          
            if(  p_nt_invest_detail(p_nt_invest_detail.count).unit_code  = 
                 l_ntx_rcd_defdoc(x).invested_code  and 
                  p_nt_invest_detail(p_nt_invest_detail.count).value_code  = 
                 l_ntx_rcd_defdoc(x).supper_code ) then 
                 
                   p_nt_invest_detail(p_nt_invest_detail.count).super_code := 
                   l_ntx_rcd_defdoc(x).task_name ; 
                   
                   p_nt_invest_detail(p_nt_invest_detail.count).rpt_version :=
                   l_ntx_rcd_defdoc(x).hb_verson  ; 
                   
                   exit; 
            end if; 
        
        end loop ; 


   end loop;

end ; 


 
--ʹ�ó��� : �õ�Ͷ������ 

procedure  p_get_invest_info( p_rcd_invest_info  in out   zf_spec.rcd_invest_info , 
                              p_investor  varchar2 , p_investee varchar2  )
is

--�����ѯ�α�
cursor  l_cur_invest(p_curr_investor  varchar2 , p_curr_investee varchar2)  is 

--�õ�ԭ����
with  bf_group  as 
(
Select a.investor invest_org_pk , b.code invest_org_code ,  b.name invest_org_name  ,
a.investee invested_org_pk, c.code invested_org_code ,  c.name  invested_org_name , 
substr(a.investdate, 1, 4)||substr(a.investdate,6 , 2)  invest_date,
a.investproportion/100 invest_rate 
from 
org_orgs  c  ,  org_orgs  b  , org_stockinvest a 
where   a.dr = 0  
and b.code  =  p_curr_investor  
and b.pk_org  =  a.investor 
and   c.code =  p_curr_investee 
and   c.pk_org  =  a.investee 
) ,
--���л���,����ͬͶ�����ڵ����� , ���м��� 
cur_group  as 
(
select 
invest_org_pk , invest_org_code , invest_org_name , 
invested_org_pk , invested_org_code , invested_org_name , 
invest_date , sum(invest_rate) invest_rate
from bf_group 
group by invest_org_pk , invest_org_code , invest_org_name , 
invested_org_pk , invested_org_code , invested_org_name , 
invest_date
)  

--�Լ��ܵĽ���������� 
select invest_org_pk , invest_org_code , invest_org_name , 
invested_org_pk , invested_org_code , invested_org_name , 
invest_date ,invest_rate
from cur_group 
order by  invest_org_pk , invest_org_code , invest_org_name , 
invested_org_pk , invested_org_code , invested_org_name , 
invest_date  ; 


--����Ͷ�ʱ������ݼ�¼���� 
l_ntx_invest_rate    zf_spec.ntx_rcd_invest_rate ; 

--�������������
l_count  pls_integer ; 

begin 
   
    l_count :=0 ; 
  
    for i in l_cur_invest(p_investor , p_investee) loop
         
            l_count  :=  l_count +1 ; 
            
            l_ntx_invest_rate(l_count).beg_date :=  i.invest_date ; 
            l_ntx_invest_rate(l_count).end_date :=  '999912' ; 
            l_ntx_invest_rate(l_count).invest_rate := i.invest_rate ; 
            l_ntx_invest_rate(l_count).accu_invest_rate := i.invest_rate ; 
            
            
            if(l_count =1 ) then
            
            --��Ͷ�ʵ�λ�ͱ�Ͷ�ʵ�λ����Ϣ д��PLSQL ���� 
            p_rcd_invest_info.invest_org_pk  :=i.invest_org_pk ;
            p_rcd_invest_info.invest_org_code :=i.invest_org_code ;
            p_rcd_invest_info.invest_org_name :=i.invest_org_name ;
            p_rcd_invest_info.invested_org_pk :=i.invested_org_pk ;
            p_rcd_invest_info.invested_org_code :=i.invested_org_code ;
            p_rcd_invest_info.invested_org_name := i.invested_org_name ;
            p_rcd_invest_info.accu_invest_rate := l_ntx_invest_rate(l_count).accu_invest_rate  ;
            
            
            end if; 
            
            
            if(l_count >1) then 
             
                  --�����ۼ�Ͷ�ʱ��� 
                  l_ntx_invest_rate(l_count).accu_invest_rate := 
                  l_ntx_invest_rate(l_count-1).accu_invest_rate + 
                  l_ntx_invest_rate(l_count).invest_rate  ; 
                  
                  p_rcd_invest_info.accu_invest_rate := 
                  l_ntx_invest_rate(l_count).accu_invest_rate ;
                  
                  
                  --�õ���һ��Ͷ�ʼ�¼�Ľ�������
                  l_ntx_invest_rate(l_count-1).end_date := 
                  to_char(to_number(l_ntx_invest_rate(l_count).beg_date) -1 ); 
            
            end if; 
	
    end loop;
  
    --��Ͷ�ʱ�������ŵ�Ͷ�ʼ�¼��
    p_rcd_invest_info.v_ntx_rcd_invest_rate  := l_ntx_invest_rate ; 

end ; 


---------------------------------------------------------------------------
--ʹ�ó��� :   �õ����ڹ�ȨͶ����ϸ���е���ǰ��ȵ�������
--���� :  
--         p_investor     Ͷ�ʷ�
--         p_investee     ��Ͷ�ʷ�
--         p_fi_date      ��������·�     ,��   201405
procedure p_get_invest_lst_info( p_rcd   in  out  zf_spec.rcd_invest_detail )

is

--���巴ӳ���� 12��31�յı���
l_lst_fi_date   varchar2(10) ; 
 

--Ͷ�ʵ�λ�ͱ�Ͷ�ʵ�λ�� PK
l_investor_pk  iufo_keydetail_unit.keyval%type  ; 
l_investee_pk  iufo_keydetail_unit.keyval%type ;  
 


---���ݵ�λ���� , ��ȡ��λ keyval ֵ 
cursor l_cur_unit_pk(p_cur_unit_code varchar2)
is
select s.keyval   from  iufo_keydetail_unit s 
where s.code = p_cur_unit_code ; 


--ʹ�ó��� : ��ѯ�ɱ���תȨ�淨����������Ȩ��䶯�ۼƽ��  
--���� : 
--               p_cur_investor varchar2  Ͷ�ʵ�λ PK , 
--               p_cur_investee  varchar2 ��Ͷ�ʵ�λ PK  ,  
--               p_fi_date varchar2       ��ѯ���� , 
--               p_verson  pls_integer    �汾   

cursor l_cur_invest_info( p_cur_investor varchar2 , 
              p_cur_investee  varchar2 ,  
              p_cur_fi_date varchar2 , 
              p_cur_verson  pls_integer )
is
select nvl(m1slijm ,0)  adj_jlr_sq_lj ,  
       nvl(ml2ipf6 ,0)  adj_zbgj_sq_lj  , 
       nvl(m1tm5ek ,0)  adj_zxcb_sq_lj  , 
       nvl(m7a9vqx , 0) adj_jlr_bq_bd, 
       nvl(m0g87ih , 0) adj_zbgj_bq_bd , 
       nvl(mqgrvm5, 0)  adj_zxcb_bq_bd , 
       nvl(mwcgby5 , 0)  sy , 
       nvl(m6d3x0h , 0)  adj_wqr_ceks , 
       nvl(mu773x9, 0 )  adj_yygj_sq_lj , 
       nvl(ma6e8fu, 0) adj_yygj_bq ,
       substr(b.keyword2, 1, 4) ||substr(b.keyword2,6,2)   the_date 
from  iufo_measure_data_4uotmh79 a ,  iufo_measpub_0005  b
where a.alone_id = b.alone_id
and   b.keyword3   = p_cur_investee 
and   b.keyword2   = p_cur_fi_date
and   b.keyword1   = p_cur_investor 
and   b.ver = p_cur_verson  ; 

begin 
   
   
   
      ---ȷ��ȥ��12��31�յ����� 
         
   l_lst_fi_date  := to_char( to_number( substr(p_rcd.curr_date , 1, 4) ) -1 )  ||'-12-31'; 
    

   
   --���Ͷ�ʵ�λ�ͱ�Ͷ�ʵĵ�λ�� UNIT_PK 
   
    
   for i in l_cur_unit_pk(p_rcd.unit_code) loop
         
         --Ͷ�ʵ�λ PK 
         
         l_investor_pk := i.keyval ; 
         
	
   end loop;
   
   for i in l_cur_unit_pk(p_rcd.value_code) loop
         
         --��Ͷ�ʵ�λ�� PK 
        
         l_investee_pk := i.keyval ; 
         
	
   end loop;
   
   ---�õ���Ͷ�ʵ�λ�ĳ��ڹ�ȨͶ����ϸ��Ϣ
   
   
   
    
   for i in l_cur_invest_info(l_investor_pk,l_investee_pk , l_lst_fi_date  , 0)  loop
     
   
       --ȥ�꾻������� 
             p_rcd.adj_jlr_sq_lj := i.adj_jlr_sq_lj  + 
             i.adj_jlr_bq_bd ; 
             
             
       --ȥ���ʱ��������� 
              
             p_rcd.adj_zbgj_sq_lj :=i.adj_zbgj_sq_lj +
             i.adj_zbgj_bq_bd ; 
             
        --ȥ��ר�������        
             p_rcd.adj_zxcb_sq_lj :=i.adj_zxcb_sq_lj  +
             i.adj_zxcb_bq_bd ; 
             

             
       --����ȷ�ϵ�����
             p_rcd.sy  :=  
             nvl( i.sy , 0) ;
             
           --�����δȷ�ϳ������
          p_rcd.adj_wqr_ceks_lst_year :=nvl(i.adj_wqr_ceks,0)   ;
          
          ---���������䶯�е�ӯ�๫���䶯 
          p_rcd.adj_zxcb_yygj_sq_lj :=i.adj_yygj_sq_lj + i.adj_yygj_bq  ; 
             
           
             
     
          if ( p_rcd.assessmode = 1 )  then 
            
                p_rcd.adj_jlr_sq_lj  := 0 ; 
                p_rcd.adj_zbgj_sq_lj := 0 ; 
                p_rcd.adj_zxcb_sq_lj := 0 ; 
                p_rcd.adj_wqr_ceks_lst_year  := 0 ;
          end if; 
     
     
    end loop;
 
   
   exception  
     
   when others  then 
     
       if(l_cur_invest_info%isopen) then 
       
           close   l_cur_invest_info ; 
           
       end if; 
   
   
   
end ; 


-------------------------------------------------------------------------------------------
--ʹ�ó��� : ȷ��Ͷ�ʵ�λ�Ա�Ͷ�ʵ�λ���ƶ����ڵ�Ͷ�ʱ���
 function  f_invest_rate_curr( p_nxt_invest_rate  zf_spec.ntx_rcd_invest_rate , 
                                              p_fi_time  varchar2)
 return zf_spec.typ_invest_rate  
 is

 --���庯���ķ���ֵ  
 l_rtn  zf_spec.typ_invest_rate ;
 
 begin 
   
       for i in 1.. p_nxt_invest_rate.count  loop
         
            if( p_fi_time >=   p_nxt_invest_rate(i).beg_date and 
                p_fi_time <=   p_nxt_invest_rate(i).end_date  ) then
                
            l_rtn  :=  p_nxt_invest_rate(i).accu_invest_rate  ; 
            
            exit ; 
            
            end if; 
	
       end loop;
   
       return nvl(l_rtn, 1) ;  
 
 end ;
 
 




----------------------------------------------------------------------------------------------------------------------------

--ʹ�ó���:  �õ����ڹ�ȨͶ����ϸ���еĶԷ���λ����Ϣ
--���� :  
--         p_investor     Ͷ�ʷ�
--         p_investee     ��Ͷ�ʷ�
--         p_fi_date      ��������·�     ,��   201405
procedure  p_get_invest_investee_info( p_investee  varchar2 , 
                                       p_fi_date   varchar2  , 
                                       p_ntx_rcd_invest_detail  in out zf_spec.ntx_rcd_invest_detail , 
                                       p_verson    iufo_hbscheme.version%type 
                                      )
is 


--�����ַ�����������,��������ÿ�µ�����һ������
l_lst_date_aux  varchar2(10) ;

--ÿ�µ����һ��
l_lst_date  varchar2(10) ; 

--��Ͷ�ʵ�λ�� PK
l_investee_pk  iufo_keydetail_unit.keyval%type ;  

--�õ���λ�����һ������� 

cursor l_cur_lst_date(p_date_str varchar2 ) 
is 
select to_char(last_day(to_date(p_date_str , 'YYYY-MM-DD')  )  , 'YYYY-MM-DD')   lst_date from dual;

---���ݵ�λ���� , ��ȡ��λ keyval ֵ 
cursor l_cur_unit_pk(p_cur_unit_code varchar2)
is
select s.keyval   from  iufo_keydetail_unit s where s.code = p_cur_unit_code ; 

 
--������Ȩ���ڳ� , ��ĩ ���
--���� : 
--               p_cur_investee  varchar2 ��Ͷ�ʵ�λ PK  ,  
--               p_fi_date varchar2       ��ѯ���� , 
--               p_verson  pls_integer    �汾   

cursor l_cur_investee_info_comm(p_cur_investee  varchar2 ,  
              p_cur_fi_date varchar2 , 
              p_verson  pls_integer )
is
select m10076 syzqy_qc ,  m10058  syzqy_qm   , 
m10294 zbgj_err_adj  , m10244 zbgj_proc_adj , m10236 yygj_proc_adj , 
m10060 wfplr_proc_adj ,  m10003 wfplr_err_adj   ,  
m10223  syzqy_qc_should_aft , 
m10215  ssgd_syzqy_qc_should_aft ,
m10058  syzqy_qm_should_aft , 
m10084  ssgd_syzqy_qm_should_aft , 
m10050  yygjhj_bq_bd , 
m10109  fxzbhj_bq_bd , 
m10301  yygj_tq_bq_bd , 
m10343  fxcb_tq_bq_bd , 
m10319  lrfp_yygj_tq_bq_bd , 
m10008  lrfp_fxcb_tq_bd_bd , 
m10140  lrfp_qt_bq_bd   , 
m10216  lrfp_glfp_bq_bd ,
(m10082  + m10035  )  zbgj_bq_bd , 
m10234  sszb_bq_bd , 

substr(b.keyword2, 1, 4) ||substr(b.keyword2,6,2)   the_date  
from  iufo_measure_data_23r9smne a ,  IUFO_MEASPUB_0007  b
where a.alone_id = b.alone_id
and   b.keyword2   between   substr(p_cur_fi_date, 1,4) ||'-01-01' and  p_cur_fi_date 
and   b.keyword1   = p_cur_investee 
and   b.ver = p_verson  
order by b.keyword2 ; 
  
--ר������ڱ䶯
--���� : 
--               p_cur_investee  varchar2 ��Ͷ�ʵ�λ PK  ,  
--               p_fi_date varchar2       ��ѯ���� , 
--               p_verson  pls_integer    �汾   

cursor l_cur_investee_info_zxcb(p_cur_investee  varchar2 ,  
              p_cur_fi_date varchar2 , 
              p_verson  pls_integer )
is
select   m10043 yygj_err_adj , 
mql9dmb  jlrhj_bq_bd  , 
(msixmnv  + mmoc7cv)  zxcb_bq_bd_r ,
mpwoyt6 lrfp_qt_qt_bq_bd ,
monb644 qt_qt_bq_bd ,
substr(b.keyword2, 1, 4) ||substr(b.keyword2,6,2)   the_date  
from  iufo_measure_data_ql236acb a ,  IUFO_MEASPUB_0007  b
where a.alone_id = b.alone_id
and   b.keyword2   between   substr(p_cur_fi_date, 1,4) ||'-01-01' and  p_cur_fi_date 
and   b.keyword1   = p_cur_investee 
and   b.ver = p_verson 
order by   b.keyword2 ; 



--�������� 
--���� : 
--               p_cur_investee  varchar2 ��Ͷ�ʵ�λ PK  ,  
--               p_fi_date varchar2       ��ѯ���� , 
--               p_verson  pls_integer    �汾   

cursor l_cur_investee_info_jlr(p_cur_investee  varchar2 ,  
              p_cur_fi_date varchar2 , 
              p_verson  pls_integer )
is
select   a.mdconyr  jlr_bq_bd  , 
m10034   wfpli_bq_un_bd_k31 , 
m10061  qt_ldsy_qyfbd_bq_bd ,
m10031  qt_ldsy_qt_bq_bd ,
substr(b.keyword2, 1, 4) ||substr(b.keyword2,6,2)   the_date  
from  iufo_measure_data_0e8nybho a ,  IUFO_MEASPUB_0007  b 
where a.alone_id = b.alone_id
and   b.keyword2    between   substr(p_cur_fi_date, 1,4) ||'-01-01' and  p_cur_fi_date 
and   b.keyword1   = p_cur_investee 
and   b.ver = p_verson  
order by  b.keyword2 ; 



--�����ʶ������ͳ�Ʊ���
l_mark pls_integer ; 
l_count pls_integer ; 


begin

   --ȷ�������������ڱ�����ֵ�� Ϊ��ǰ�����ڼ��1��
   l_lst_date_aux  :=  
   substr(p_fi_date , 1 , 4) || '-'||substr(p_fi_date, 5,2) || '-' || '01' ; 
   
   
   --�õ���ǰ�����ڼ�����һ������� 
   for i in l_cur_lst_date(l_lst_date_aux)  loop
     
       l_lst_date  :=  i.lst_date ; 
       
   end loop;
   
   --���Ͷ�ʵ�λ�ͱ�Ͷ�ʵĵ�λ�� UNIT_PK 
   
   
   for i in l_cur_unit_pk(p_investee) loop
         
         --Ͷ�ʵ�λ�� PK 
        
         l_investee_pk := i.keyval ; 
	
   end loop;
   

   
   --�õ�������Ȩ���ڳ�����ĩֵ , �ʱ��������ڱ䶯 
   l_count :=  0 ; 
   
   for i in l_cur_investee_info_comm(l_investee_pk , l_lst_date  , p_verson)  loop
     
        l_count := l_count +1; 
        
        p_ntx_rcd_invest_detail(l_count).syzqy_qc :=i.syzqy_qc ;  
        p_ntx_rcd_invest_detail(l_count).syzqy_qm :=i.syzqy_qm ;
        p_ntx_rcd_invest_detail(l_count).zbgj_bq_bd :=i.zbgj_bq_bd ; 
        p_ntx_rcd_invest_detail(l_count).lrfp_qt_bq_bd :=i.lrfp_qt_bq_bd  ; 
        p_ntx_rcd_invest_detail(l_count).lrfp_glfp_bq_bd :=i.lrfp_glfp_bq_bd  ;
        p_ntx_rcd_invest_detail(l_count).sszb_bq_bd  := i.sszb_bq_bd ; 
        p_ntx_rcd_invest_detail(l_count).the_date :=i.the_date ; 
        p_ntx_rcd_invest_detail(l_count).value_code :=p_investee ; 
        
        p_ntx_rcd_invest_detail(l_count).syzqy_qc_should_aft  
        := i.syzqy_qc_should_aft ; 
        p_ntx_rcd_invest_detail(l_count).ssgd_syzqy_qc_should_aft 
        :=i.ssgd_syzqy_qc_should_aft ; 
        p_ntx_rcd_invest_detail(l_count).syzqy_qm_should_aft 
        := i.syzqy_qm_should_aft ; 
        p_ntx_rcd_invest_detail(l_count).ssgd_syzqy_qm_should_aft 
        := i.ssgd_syzqy_qm_should_aft ; 
        
        
        p_ntx_rcd_invest_detail(l_count).diff_yygj_tq_bq_bd :=  i.lrfp_yygj_tq_bq_bd +
        i.yygj_tq_bq_bd ;
        p_ntx_rcd_invest_detail(l_count).diff_fxcb_tq_bd_bd :=  i.lrfp_fxcb_tq_bd_bd +
        i.fxcb_tq_bq_bd ;
     
        
   end loop;
   

   -----������Ȩ��ר������ڱ䶯
   
   for i in l_cur_investee_info_zxcb(l_investee_pk , l_lst_date  , p_verson)  loop
     
        --����Ͷ����ϸ�� ,  ���Ƿ�����ͬ������  , �������ͬ������ , �� ����
        --����Ͷ����ϸ�������
        
        l_mark  :=  0 ; 
         
        for j  in 1 ..   p_ntx_rcd_invest_detail.count  loop  
          
             if ( i.the_date  =  p_ntx_rcd_invest_detail(j).the_date)  then
                                 
                   p_ntx_rcd_invest_detail(j).zxcb_bq_bd_r := i.zxcb_bq_bd_r ; 
                   
                   p_ntx_rcd_invest_detail(j).lrfp_qt_qt_bq_bd := i.lrfp_qt_qt_bq_bd ;
                   
                   p_ntx_rcd_invest_detail(j).qt_qt_bq_bd := i.qt_qt_bq_bd ;
                
             
             
                   l_mark  := 1 ; 
                   
                   ---�ҵ�ƥ����Ŀ���˳�LOOP ѭ��
                   exit ; 
	
             end if;
             
        end loop ; 
        
        --���û���ҵ� �� ����Ͷ����ϸ��������һ�� 
        if ( l_mark = 0 ) then
          
            l_count := p_ntx_rcd_invest_detail.count +1; 
               
           p_ntx_rcd_invest_detail(l_count).zxcb_bq_bd_r := i.zxcb_bq_bd_r ; 
            
           p_ntx_rcd_invest_detail(l_count).lrfp_qt_qt_bq_bd := i.lrfp_qt_qt_bq_bd ;
                   
           p_ntx_rcd_invest_detail(l_count).qt_qt_bq_bd := i.qt_qt_bq_bd ;
           
           
            
            p_ntx_rcd_invest_detail(l_count).the_date :=i.the_date ; 
            p_ntx_rcd_invest_detail(l_count).value_code :=p_investee ; 
	
        end if;         
        
 
        
   end loop ; 
   
   
   -----�������ڱ䶯
   
   for i in l_cur_investee_info_jlr(l_investee_pk , l_lst_date  , p_verson)  loop
     
        --����Ͷ����ϸ�� ,  ���Ƿ�����ͬ������  , �������ͬ������ , �� ����
        --����Ͷ����ϸ�������
        
        l_mark  :=  0 ; 
         
        for j  in 1 ..   p_ntx_rcd_invest_detail.count  loop  
          
             if ( i.the_date  =  p_ntx_rcd_invest_detail(j).the_date)  then
                                 
                   p_ntx_rcd_invest_detail(j).jlr_bq_bd := i.jlr_bq_bd ; 
             
                    p_ntx_rcd_invest_detail(j).qt_ldsy_qyfbd_bq_bd  := i.qt_ldsy_qyfbd_bq_bd  ; 
              
                    p_ntx_rcd_invest_detail(j).qt_ldsy_qt_bq_bd  := i.qt_ldsy_qt_bq_bd  ; 
             
             
             
              
                   
                   l_mark  := 1 ; 
                   
                   --�ҵ��� �˳�LOOP ѭ�� 
                   exit;  
	
             end if;
             
        end loop ; 
        
        
        --���û���ҵ� �� ����Ͷ����ϸ��������һ�� 
        if ( l_mark = 0 ) then
          
            l_count := p_ntx_rcd_invest_detail.count +1;
               
            p_ntx_rcd_invest_detail(l_count).jlr_bq_bd := 
            i.jlr_bq_bd ;
            
            
            p_ntx_rcd_invest_detail(l_count).qt_ldsy_qyfbd_bq_bd := 
            i.qt_ldsy_qyfbd_bq_bd ;
            
            p_ntx_rcd_invest_detail(l_count).qt_ldsy_qt_bq_bd := 
            i.qt_ldsy_qt_bq_bd;
            
            p_ntx_rcd_invest_detail(l_count).the_date   :=i.the_date ; 
            p_ntx_rcd_invest_detail(l_count).value_code :=p_investee ; 
	
        end if;           
      
   end loop ; 
      
   exception  
     
   when others  then 
     
       if(l_cur_investee_info_comm%isopen) then 
       
           close   l_cur_investee_info_comm ; 
           
       end if; 
       
        if(l_cur_investee_info_zxcb%isopen) then 
       
           close   l_cur_investee_info_zxcb ; 
           
       end if; 
       
        if(l_cur_investee_info_jlr%isopen) then 
       
           close   l_cur_investee_info_jlr ; 
           
       end if; 
       
   
end ; 


--------------------------------------------------------------------------
 
 --ʹ�ó��� :  ���ݱ��ڳ��ڹ�ȨͶ����ϸ�� , �ۼƳ��ڹ�ȨͶ����ϸ�б� ,Ͷ����ϸ ,
 ---�õ����ڳ��ڹ�ȨͶ����ϸ�����������
 --���� 
 ---            p_rcd_invest_detail      ���ڳ��ڳ��ڹ�ȨͶ����ϸ�� 
 ---            p_ntx_invest_rate        ���ڹ�ȨͶ������ 
 --             p_ntx_invest_detail      ���ڹ�ȨͶ�ʵ�1~���µ� ��ϸ���� 
 
 procedure  p_invest_nt_deal_data(
                  p_rcd_invest_detail  in out     zf_spec.rcd_invest_detail , 
                  p_ntx_invest_rate        zf_spec.ntx_rcd_invest_rate ,  
                  p_ntx_invest_detail      zf_spec.ntx_rcd_invest_detail 
                  )
is
   --ȷ��Ͷ�ʵ�λ�������е�Ͷ�ʱ��� 
   l_invest_rate_curr    zf_spec.typ_invest_rate  ; 
   
   --�ڳ�Ͷ�ʱ�������  
   l_invest_rate_lst     zf_spec.typ_invest_rate ; 
   
    --��ĩͶ�ʱ�������  
   l_invest_rate_end     zf_spec.typ_invest_rate ; 
    
   --�ڳ����� 
   l_date_lst_year       zf_spec.typ_invest_date ; 
   
begin 
       
      --�õ��ڳ�����
      l_date_lst_year  := 
      to_char(to_number(substr(p_rcd_invest_detail.curr_date,1,4))-1 ) || '12' ; 
      
    

      ---�����ڳ�Ͷ�ʱ�������ֵ 
      l_invest_rate_lst  := f_invest_rate_curr(p_ntx_invest_rate ,
      l_date_lst_year) ; 
      
      
      
      --���㵱ǰͶ�ʱ�������ֵ
      l_invest_rate_end  := f_invest_rate_curr(p_ntx_invest_rate ,
      p_rcd_invest_detail.curr_date) ; 
      
      
      
      
      --��Ͷ�ʱ������ݷ��뵽 ��¼���� 
      p_rcd_invest_detail.invest_rate_beg := nvl(l_invest_rate_lst , 1) ; 
      p_rcd_invest_detail.invest_rate_end := nvl(l_invest_rate_end , 1) ; 
      
       
      for i in 1.. p_ntx_invest_detail.count  loop
        
	  
         --ȷ��Ͷ�ʵ�λ�������е�Ͷ�ʱ��� 
         l_invest_rate_curr  := 
         f_invest_rate_curr(p_ntx_invest_rate ,p_ntx_invest_detail(i).the_date);
         
         
         --ȷ�����ڶԱ�Ͷ�ʵ�λ������Ȩ��Ӧ�����еķݶ�
         if( i  =  1 ) then  
         
             --�������� Ͷ�ʵ�λ���еķݶ�
             p_rcd_invest_detail.adj_investor_jlr_bq_bd := 
             nvl(p_rcd_invest_detail.adj_investor_jlr_bq_bd , 0)  + 
             round(p_ntx_invest_detail(i).jlr_bq_bd * l_invest_rate_curr , 2) ; 
             
             --�ʱ����� �� Ͷ�ʵ�λ���еķݶ�
             p_rcd_invest_detail.adj_zbgj_bq_bd := 
             nvl(p_rcd_invest_detail.adj_zbgj_bq_bd , 0)  + 
             round(p_ntx_invest_detail(i).zbgj_bq_bd * l_invest_rate_curr , 2) ; 
             
              --ר����� Ͷ�ʵ�λ���еķݶ�
             p_rcd_invest_detail.adj_zxcb_bq_bd_r := 
             nvl(p_rcd_invest_detail.adj_zxcb_bq_bd_r , 0)  + 
             round(p_ntx_invest_detail(i).zxcb_bq_bd_r * l_invest_rate_curr , 2) ; 
             
              --����������� Ͷ�ʵ�λ���еķݶ� 
            
             p_rcd_invest_detail.adj_lrfp_qt_bq_bd := 
             nvl(p_rcd_invest_detail.adj_lrfp_qt_bq_bd , 0)  + 
             round(nvl(p_ntx_invest_detail(i).lrfp_qt_bq_bd,0) * l_invest_rate_curr , 2) ; 
              
             
              --������� - �Թɶ��ķ���  Ͷ�ʵ�λ���еķݶ� 
            
             p_rcd_invest_detail.adj_lrfp_glfp_bq_bd := 
             nvl(p_rcd_invest_detail.adj_lrfp_glfp_bq_bd , 0)  + 
             round(nvl(p_ntx_invest_detail(i).lrfp_glfp_bq_bd,0) * l_invest_rate_curr , 2) ; 
               
              
             --ʵ���ʱ��䶯 , Ͷ�ʵ�λ���еķݶ�
             p_rcd_invest_detail.adj_sszb_bq_bd := 
             nvl(p_rcd_invest_detail.adj_sszb_bq_bd , 0)  + 
             round(p_ntx_invest_detail(i).sszb_bq_bd * l_invest_rate_curr , 2) ; 
             
             --������� ӯ�๫����ȡ �Ĳ��  -  Ͷ�ʵ�λ���еķݶ� 
            
             p_rcd_invest_detail.adj_diff_yygj_bq_bd := 
             nvl(p_rcd_invest_detail.diff_fxcb_tq_bd_bd , 0)  + 
             round(nvl(p_ntx_invest_detail(i).adj_diff_yygj_bq_bd,0) * l_invest_rate_curr , 2) ; 
             
             
             --������� ר�����ȡ �Ĳ��  -  Ͷ�ʵ�λ���еķݶ� 
            
             p_rcd_invest_detail.adj_diff_fxcb_bq_bd := 
             nvl(p_rcd_invest_detail.adj_diff_fxcb_bq_bd , 0)  + 
             round(nvl(p_ntx_invest_detail(i).diff_fxcb_tq_bd_bd,0) * l_invest_rate_curr , 2) ; 
             
             
             --�������-����-���� �Ĳ���  
             p_rcd_invest_detail.adj_lrfp_qt_qt_bq_bd := 
             nvl(p_rcd_invest_detail.adj_lrfp_qt_qt_bq_bd , 0)  + 
             round(nvl(p_ntx_invest_detail(i).adj_lrfp_qt_qt_bq_bd,0) * l_invest_rate_curr , 2) ; 
             
             --���� - ����   �Ĳ��� 
              p_rcd_invest_detail.adj_qt_qt_bq_bd := 
             nvl(p_rcd_invest_detail.adj_qt_qt_bq_bd , 0)  + 
             round(nvl(p_ntx_invest_detail(i).adj_qt_qt_bq_bd,0) * l_invest_rate_curr , 2) ; 
             
             
             --����  - ���ú���ʧ  -- Ȩ�淨�±�Ͷ�ʵ�λ����������Ȩ��䶯��Ӱ��  
             p_rcd_invest_detail.adj_qt_ldsy_qyfbd_bq_bd := 
             nvl(p_rcd_invest_detail.adj_qt_ldsy_qyfbd_bq_bd , 0)  + 
             round(nvl(p_ntx_invest_detail(i).adj_qt_ldsy_qyfbd_bq_bd,0) * l_invest_rate_curr , 2) ; 
             
             --����  - ���ú���ʧ  -- ����  
             p_rcd_invest_detail.adj_qt_ldsy_qt_bq_bd := 
             nvl(p_rcd_invest_detail.adj_qt_ldsy_qt_bq_bd , 0)  + 
             round(nvl(p_ntx_invest_detail(i).adj_qt_ldsy_qt_bq_bd,0) * l_invest_rate_curr , 2) ; 
             
            
             
             --���е������䶯�� Ͷ�ʵ�λ���еķݶ�
             --ע��,ʵ���ʱ���Ӧ�ü��뵽�����ϼ���
             p_rcd_invest_detail.adj_zxcb_bq_bd := p_rcd_invest_detail.adj_zxcb_bq_bd_r + 
                                                   p_rcd_invest_detail.adj_lrfp_qt_bq_bd +
                                                   p_rcd_invest_detail.adj_lrfp_glfp_bq_bd +
                                                   p_rcd_invest_detail.adj_diff_yygj_bq_bd +
                                                   p_rcd_invest_detail.adj_diff_fxcb_bq_bd + 
                                                   p_rcd_invest_detail.adj_lrfp_qt_qt_bq_bd + 
                                                   p_rcd_invest_detail.adj_qt_qt_bq_bd + 
                                                   p_rcd_invest_detail.adj_qt_ldsy_qyfbd_bq_bd  + 
                                                   p_rcd_invest_detail.adj_qt_ldsy_qt_bq_bd  ; 
                       
        
         else 
             --������ �� Ͷ�ʵ�λ���еķݶ�
             p_rcd_invest_detail.adj_investor_jlr_bq_bd := 
             nvl(p_rcd_invest_detail.adj_investor_jlr_bq_bd , 0)  + 
             round(( p_ntx_invest_detail(i).jlr_bq_bd  - 
                     p_ntx_invest_detail(i-1).jlr_bq_bd )  
                     * l_invest_rate_curr  , 2) ; 
             
             ---�ʱ������� Ͷ�ʵ�λ���еķݶ�
             p_rcd_invest_detail.adj_zbgj_bq_bd := 
             nvl(p_rcd_invest_detail.adj_zbgj_bq_bd , 0)  + 
             round(( p_ntx_invest_detail(i).zbgj_bq_bd  - 
                     p_ntx_invest_detail(i-1).zbgj_bq_bd )  
                     * l_invest_rate_curr  , 2) ; 
             
             --ר���  �� Ͷ�ʵ�λ���еķݶ�      
             p_rcd_invest_detail.adj_zxcb_bq_bd_r := 
             nvl(p_rcd_invest_detail.adj_zxcb_bq_bd_r , 0)  + 
             round(( p_ntx_invest_detail(i).zxcb_bq_bd_r  - 
                     p_ntx_invest_detail(i-1).zxcb_bq_bd_r )  
                     * l_invest_rate_curr  , 2) ; 
                     
             
             --�����������    
             p_rcd_invest_detail.adj_lrfp_qt_bq_bd := 
             nvl(p_rcd_invest_detail.adj_lrfp_qt_bq_bd , 0)  + 
             round(( p_ntx_invest_detail(i).lrfp_qt_bq_bd -
                     p_ntx_invest_detail(i-1).lrfp_qt_bq_bd )  
                     * l_invest_rate_curr  , 2) ; 
            
         
              --������� --��������  
             p_rcd_invest_detail.adj_lrfp_glfp_bq_bd := 
             nvl(p_rcd_invest_detail.adj_lrfp_glfp_bq_bd , 0)  + 
             round(( p_ntx_invest_detail(i).lrfp_glfp_bq_bd -
                     p_ntx_invest_detail(i-1).lrfp_glfp_bq_bd )  
                     * l_invest_rate_curr  , 2) ; 
                     
                     
               --������� --ӯ�๫������ 
             p_rcd_invest_detail.adj_diff_yygj_bq_bd := 
             nvl(p_rcd_invest_detail.adj_diff_yygj_bq_bd , 0)  + 
             round(( p_ntx_invest_detail(i).diff_yygj_tq_bq_bd -
                     p_ntx_invest_detail(i-1).diff_yygj_tq_bq_bd )  
                     * l_invest_rate_curr  , 2) ;   
                     
                --������� --���մ�������  
             p_rcd_invest_detail.adj_diff_fxcb_bq_bd := 
             nvl(p_rcd_invest_detail.adj_diff_fxcb_bq_bd , 0)  + 
             round(( p_ntx_invest_detail(i).diff_fxcb_tq_bd_bd -
                     p_ntx_invest_detail(i-1).diff_fxcb_tq_bd_bd )  
                     * l_invest_rate_curr  , 2) ;              
                     

             --ʵ���ʱ��� , Ͷ�ʵ�λ���еķݶ�      
             p_rcd_invest_detail.adj_sszb_bq_bd := 
             nvl(p_rcd_invest_detail.adj_sszb_bq_bd , 0)  + 
             round(( p_ntx_invest_detail(i).sszb_bq_bd  - 
                     p_ntx_invest_detail(i-1).sszb_bq_bd )  
                     * l_invest_rate_curr  , 2) ;  
                     
             
              --�������-����-���� �Ĳ���  
             p_rcd_invest_detail.adj_lrfp_qt_qt_bq_bd := 
             nvl(p_rcd_invest_detail.adj_lrfp_qt_qt_bq_bd , 0)  + 
             round((p_ntx_invest_detail(i).adj_lrfp_qt_qt_bq_bd -
             p_ntx_invest_detail(i-1).adj_lrfp_qt_qt_bq_bd )* l_invest_rate_curr , 2) ; 
             
             --���� - ����   �Ĳ��� 
             p_rcd_invest_detail.adj_qt_qt_bq_bd := 
             nvl(p_rcd_invest_detail.adj_qt_qt_bq_bd , 0)  + 
             round((p_ntx_invest_detail(i).adj_qt_qt_bq_bd -
             p_ntx_invest_detail(i-1).adj_qt_qt_bq_bd) * l_invest_rate_curr , 2) ; 
             
             
             --����  - ���ú���ʧ  -- Ȩ�淨�±�Ͷ�ʵ�λ����������Ȩ��䶯��Ӱ��  
             p_rcd_invest_detail.adj_qt_ldsy_qyfbd_bq_bd := 
             nvl(p_rcd_invest_detail.adj_qt_ldsy_qyfbd_bq_bd , 0)  + 
             round((p_ntx_invest_detail(i).adj_qt_ldsy_qyfbd_bq_bd -
             p_ntx_invest_detail(i-1).adj_qt_ldsy_qyfbd_bq_bd ) * l_invest_rate_curr , 2) ; 
             
             --����  - ���ú���ʧ  -- ����  
             p_rcd_invest_detail.adj_qt_ldsy_qt_bq_bd := 
             nvl(p_rcd_invest_detail.adj_qt_ldsy_qt_bq_bd , 0)  + 
             round((p_ntx_invest_detail(i).adj_qt_ldsy_qt_bq_bd-
             p_ntx_invest_detail(i-1).adj_qt_ldsy_qt_bq_bd) * l_invest_rate_curr , 2) ; 
                      
             
            /*  -- ������Ŀ�ϼ�  Ͷ�ʵ�λ���еķݶ�      
             p_rcd_invest_detail.adj_zxcb_bq_bd :=  
             p_rcd_invest_detail.adj_zxcb_bq_bd_r +
             p_rcd_invest_detail.adj_lrfp_qt_bq_bd+
             p_rcd_invest_detail.adj_lrfp_glfp_bq_bd +
             p_rcd_invest_detail.adj_diff_yygj_bq_bd +
             p_rcd_invest_detail.adj_diff_fxcb_bq_bd +
             p_rcd_invest_detail.adj_lrfp_qt_qt_bq_bd + 
             p_rcd_invest_detail.adj_qt_qt_bq_bd + 
             p_rcd_invest_detail.adj_qt_ldsy_qyfbd_bq_bd  + 
             p_rcd_invest_detail.adj_qt_ldsy_qt_bq_bd  ; */
                 
         
         end if; 
         
         --���� ��ǰ�ڼ� ,  Ҳ�� ����һ���ڼ������ 
         if(p_ntx_invest_detail(i).the_date =  p_rcd_invest_detail.curr_date ) then 
         
               --������Ȩ��ϼ��ڳ�  
               
               p_rcd_invest_detail.syzqy_qc := p_ntx_invest_detail(i).syzqy_qc ; 
               p_rcd_invest_detail.syzqy_qc_should_aft := p_ntx_invest_detail(i).syzqy_qc_should_aft ;
               p_rcd_invest_detail.ssgd_syzqy_qc_should_aft := p_ntx_invest_detail(i).ssgd_syzqy_qc_should_aft ;
               
               
               --������Ȩ��ϼ���ĩ 
               
               p_rcd_invest_detail.syzqy_qm := p_ntx_invest_detail(i).syzqy_qm ;
               p_rcd_invest_detail.syzqy_qm_should_aft := p_ntx_invest_detail(i).syzqy_qm_should_aft ;
               p_rcd_invest_detail.ssgd_syzqy_qm_should_aft := p_ntx_invest_detail(i).ssgd_syzqy_qm_should_aft ;
               
               --�ʱ������ۼƱ䶯 
               
               p_rcd_invest_detail.zbgj_bq_bd := p_ntx_invest_detail(i).zbgj_bq_bd ;
               
               --�������ۼƱ䶯 
               
               p_rcd_invest_detail.jlr_bq_bd := p_ntx_invest_detail(i).jlr_bq_bd ; 
               
               --ר����ۼƱ䶯 
               
               p_rcd_invest_detail.zxcb_bq_bd_r := p_ntx_invest_detail(i).zxcb_bq_bd_r ; 
               
                --����������� �ۼƱ䶯 
               
               p_rcd_invest_detail.lrfp_qt_bq_bd := p_ntx_invest_detail(i).lrfp_qt_bq_bd ; 
               
                 --�������--��������  �ۼƱ䶯 
               
               p_rcd_invest_detail.lrfp_glfp_bq_bd := p_ntx_invest_detail(i).lrfp_glfp_bq_bd ; 
               
               
           
                                                    
               --ʵ���ʱ��ۼƱ䶯 
               p_rcd_invest_detail.sszb_bq_bd :=   p_ntx_invest_detail(i).sszb_bq_bd ;  
               
                -- δ�������� -- ӯ�๫����ȡ����䶯 
               p_rcd_invest_detail.diff_yygj_tq_bq_bd :=   p_ntx_invest_detail(i).diff_yygj_tq_bq_bd ;  
               
               --δ �������� -- ���մ�����ȡ����䶯 
               p_rcd_invest_detail.diff_fxcb_tq_bd_bd :=   p_ntx_invest_detail(i).diff_fxcb_tq_bd_bd ; 
                                                     
              
                 --�������-����-���� �Ĳ���  
              p_rcd_invest_detail.lrfp_qt_qt_bq_bd := p_ntx_invest_detail(i).adj_lrfp_qt_qt_bq_bd ; 
             
             --���� - ����   �Ĳ��� 
              p_rcd_invest_detail.qt_qt_bq_bd := p_ntx_invest_detail(i).adj_qt_qt_bq_bd ; 
             
             
             --����  - ���ú���ʧ  -- Ȩ�淨�±�Ͷ�ʵ�λ����������Ȩ��䶯��Ӱ��  
             p_rcd_invest_detail.qt_ldsy_qyfbd_bq_bd :=p_ntx_invest_detail(i).adj_qt_ldsy_qyfbd_bq_bd ; 
             
             --����  - ���ú���ʧ  -- ����  
             p_rcd_invest_detail.qt_ldsy_qt_bq_bd := p_ntx_invest_detail(i).adj_qt_ldsy_qt_bq_bd ; 
         
           
               --�������б䶯��  �ۼƱ䶯 
           /*    
             p_rcd_invest_detail.zxcb_bq_bd :=    p_rcd_invest_detail.zxcb_bq_bd_r + 
                                                    p_rcd_invest_detail.lrfp_qt_bq_bd + 
                                                    p_rcd_invest_detail.lrfp_glfp_bq_bd +
                                                    p_rcd_invest_detail.diff_yygj_tq_bq_bd +
                                                    p_rcd_invest_detail.diff_fxcb_tq_bd_bd  + 
                                                    p_rcd_invest_detail.lrfp_qt_qt_bq_bd  + 
                                                    p_rcd_invest_detail.qt_qt_bq_bd  + 
                                                    p_rcd_invest_detail.qt_ldsy_qyfbd_bq_bd  + 
                                                    p_rcd_invest_detail.qt_ldsy_qt_bq_bd ; */ 
         
         
         end if; 
      
      
      end loop;
     
      
      --�õ��ڳ�����ĩͶ�ʵ�λ�������ɶ�Ȩ��Ӧ�����е�������Ȩ��ݶ� 
      
      --�ڳ� ��� 
      
      p_rcd_invest_detail.investor_qc_should := 
      round( (p_rcd_invest_detail.syzqy_qc_should_aft- 
      p_rcd_invest_detail.ssgd_syzqy_qc_should_aft)
      * l_invest_rate_lst   ,2) ; 
      
      p_rcd_invest_detail.ssgd_qc_should := 
      (p_rcd_invest_detail.syzqy_qc_should_aft- 
      p_rcd_invest_detail.ssgd_syzqy_qc_should_aft) -  p_rcd_invest_detail.investor_qc_should  ; 
      
      
      --��ĩ��� 
      p_rcd_invest_detail.investor_qm_should := 
      round( ( p_rcd_invest_detail.syzqy_qm_should_aft  - 
        p_rcd_invest_detail.ssgd_syzqy_qm_should_aft)
      * l_invest_rate_curr   ,2) ; 
      
      p_rcd_invest_detail.ssgd_qm_should := 
      (p_rcd_invest_detail.syzqy_qm_should_aft  - 
        p_rcd_invest_detail.ssgd_syzqy_qm_should_aft) - 
        p_rcd_invest_detail.investor_qm_should  ; 
      
      
      
       p_rcd_invest_detail.adj_zxcb_bq_bd     :=  p_rcd_invest_detail.investor_qm_should  - 
       p_rcd_invest_detail.investor_qc_should  -p_rcd_invest_detail.adj_investor_jlr_bq_bd -
        p_rcd_invest_detail.adj_zbgj_bq_bd  -p_rcd_invest_detail.adj_sszb_bq_bd   ;  
      
      
      
      --������䶯 �������ɶ����� ���  
      p_rcd_invest_detail.adj_ssgd_jlr_bq_bd := 
      p_rcd_invest_detail.jlr_bq_bd  - p_rcd_invest_detail.adj_investor_jlr_bq_bd ; 
      
      
      --�ʱ������䶯�������ɶ� ��� 
      p_rcd_invest_detail.adj_ssgd_zbgj_bq_bd := 
      p_rcd_invest_detail.zbgj_bq_bd  - p_rcd_invest_detail.adj_zbgj_bq_bd ; 
      
      --ר�ߴ����䶯�������ɶ� ���  
      p_rcd_invest_detail.adj_ssgd_zxcb_r_bq_bd := 
      p_rcd_invest_detail.zxcb_bq_bd_r  - p_rcd_invest_detail.adj_zxcb_bq_bd_r ; 
      
    
      
      
      --���ڹ�ȨͶ�ʵ����о�����������  
      p_rcd_invest_detail.adj_jlr_bq_bd := 
      p_rcd_invest_detail.adj_investor_jlr_bq_bd  - 
      nvl(p_rcd_invest_detail.tzsy_bq , 0) ;
      
      --������������䶯��,�����ɶ���� 
      p_rcd_invest_detail.adj_ssgd_lrfp_qt_bq_bd := 
      p_rcd_invest_detail.lrfp_qt_bq_bd  - p_rcd_invest_detail.adj_lrfp_qt_bq_bd ; 
      
       --�������-�������� ��,�����ɶ���� 
      p_rcd_invest_detail.adj_ssgd_lrfp_glfp_bq_bd := 
      p_rcd_invest_detail.lrfp_glfp_bq_bd  - p_rcd_invest_detail.adj_lrfp_glfp_bq_bd ; 
      
        --������� -ӯ�๫����ȡ����  ��,�����ɶ���� 
      p_rcd_invest_detail.adj_ssgd_diff_yygj_bq_bd := 
      p_rcd_invest_detail.diff_yygj_tq_bq_bd  - p_rcd_invest_detail.adj_diff_yygj_bq_bd ; 
      
      
        --������� - ���մ�����ȡ������  ,�����ɶ���� 
      p_rcd_invest_detail.adj_ssgd_diff_fxcb_bq_bd := 
      p_rcd_invest_detail.diff_fxcb_tq_bd_bd  - p_rcd_invest_detail.adj_diff_fxcb_bq_bd ; 
      
      
      
      --ʵ���ʱ��䶯�� ,�����ɶ���� 
      p_rcd_invest_detail.adj_ssgd_sszb_bq_bd := 
      p_rcd_invest_detail.sszb_bq_bd  - p_rcd_invest_detail.adj_sszb_bq_bd ;  
      
      
      
      
      
      
      --����  --���� ��Ŀ�䶯 �������ɶ����   
      p_rcd_invest_detail.adj_ssgd_qt_qt_bq_bd := 
      p_rcd_invest_detail.qt_qt_bq_bd  - p_rcd_invest_detail.adj_qt_qt_bq_bd ; 
      
      --δ��������  -����  -���� ��Ŀ�䶯�� �����ɶ����  
      p_rcd_invest_detail.adj_ssgd_lrfp_qt_qt_bq_bd := 
      p_rcd_invest_detail.lrfp_qt_qt_bq_bd  - p_rcd_invest_detail.adj_lrfp_qt_qt_bq_bd ; 
      
      -- --�����ɶ� -����-ֱ�Ӽ���������Ȩ������ú���ʧ-Ȩ�淨�±�Ͷ�ʵ�λ����������Ȩ��䶯��Ӱ�� ���ڱ䶯    L15
      p_rcd_invest_detail.adj_ssgd_qt_ldsy_qyfbd_bq_bd := 
      p_rcd_invest_detail.qt_ldsy_qyfbd_bq_bd  - p_rcd_invest_detail.adj_qt_ldsy_qyfbd_bq_bd ;
      
      
      -- ---�����ɶ�-����-Ȩֱ�Ӽ���������Ȩ������ú���ʧ-���� ���ڱ䶯    L17
      p_rcd_invest_detail.adj_ssgd_qt_ldsy_qt_bq_bd := 
      p_rcd_invest_detail.qt_ldsy_qt_bq_bd  - p_rcd_invest_detail.adj_qt_ldsy_qt_bq_bd ;
      
      
        p_rcd_invest_detail.adj_ssgd_zxcb_bq_bd := p_rcd_invest_detail.ssgd_qm_should - 
        p_rcd_invest_detail.ssgd_qc_should   -  
        p_rcd_invest_detail.adj_ssgd_jlr_bq_bd - 
        p_rcd_invest_detail.adj_ssgd_zbgj_bq_bd - 
        p_rcd_invest_detail.adj_ssgd_sszb_bq_bd   ;
        
        p_rcd_invest_detail.adj_ssgd_sszb_bd_other  :=  0  ; 
      
      
      /*--�������б䶯��,�����ɶ��䶯���ϼ�
      p_rcd_invest_detail.adj_ssgd_zxcb_bq_bd := 
      p_rcd_invest_detail.zxcb_bq_bd  - p_rcd_invest_detail.adj_zxcb_bq_bd ;  */
      
      
      
     /* ---����Ͷ�ʱ����䶯 , ȷ�������ɶ�Ȩ����Ӧ�ü��ٻ����ӵ�ʵ���ʱ����
      p_rcd_invest_detail.adj_ssgd_sszb_bd_other  := 
      p_rcd_invest_detail.ssgd_qm_should -
      p_rcd_invest_detail.ssgd_qc_should -
      p_rcd_invest_detail.adj_ssgd_sszb_bq_bd - 
      p_rcd_invest_detail.adj_ssgd_zbgj_bq_bd - 
      p_rcd_invest_detail.adj_ssgd_jlr_bq_bd -
      p_rcd_invest_detail.adj_ssgd_zxcb_r_bq_bd -
      p_rcd_invest_detail.adj_ssgd_zxcb_bq_bd  ; */
      
    /*  if(abs(p_rcd_invest_detail.adj_ssgd_sszb_bd_other  )  <10) then 
      
                p_rcd_invest_detail.adj_ssgd_sszb_bd_other := 0  ; 
               
                p_rcd_invest_detail.adj_ssgd_zxcb_bq_bd  := 
                p_rcd_invest_detail.ssgd_qm_should -
                p_rcd_invest_detail.ssgd_qc_should -
                p_rcd_invest_detail.adj_ssgd_sszb_bq_bd - 
                p_rcd_invest_detail.adj_ssgd_zbgj_bq_bd - 
                p_rcd_invest_detail.adj_ssgd_jlr_bq_bd -
                p_rcd_invest_detail.adj_ssgd_zxcb_r_bq_bd ; 
      end if ; */
     
      
      --���ΪȨ�淨���� , ��Ͷ������ ,�ʱ����� ,�����ȵ������Ϊ  0  
      if(p_rcd_invest_detail.assessmode = 1 ) then 
            
            p_rcd_invest_detail.adj_jlr_bq_bd := 0 ;  
            p_rcd_invest_detaiL.adj_investor_jlr_bq_bd := 0 ; 
            p_rcd_invest_detail.adj_zbgj_bq_bd := 0 ; 
            p_rcd_invest_detail.adj_zxcb_bq_bd := 0  ;  
            p_rcd_invest_detail.adj_zxcb_bq_bd_r := 0  ;
            p_rcd_invest_detail.adj_lrfp_qt_bq_bd := 0 ; 
            p_rcd_invest_detail.adj_lrfp_glfp_bq_bd := 0 ;
            p_rcd_invest_detail.adj_sszb_bq_bd := 0  ;   
      
      end if; 
       

end ; 
 

---------------------------------------------------------------------------------- 


procedure   p_invest_nt_bg( 
                       p_tbl_rtn      in out     zf_spec.nt_rcd_invest_detail , 
                       p_end_year         IN varchar2 DEFAULT '2014',
                       p_unit_code        IN VARCHAR2 DEFAULT '01',
                       p_adjust           in varchar2 default 'Y' ,  
                       p_accounting       in varchar2 default 'Y'  )

is 
     
    --�������
    l_curr_year   varchar2(4) ; 

    --���庯������ֵ
   
    
    --����Ͷ����ϸ�� ( ��NC��Ŀ�ϻ�ȡ )
    
    l_tbl   zf_spec.nt_rcd_invest_detail   :=  zf_spec.nt_rcd_invest_detail();   
    
    
    --���ڹ�ȨͶ����ϸ�б����  
    l_ntx_invest_detail        zf_spec.ntx_rcd_invest_detail ; 
    
    --���ڹ�ȨͶ����ϸ�б������ʼ��
    l_ntx_invest_detail_tmp    zf_spec.ntx_rcd_invest_detail ; 
    
    
    --Ͷ�ʱ������� 
    l_rcd_invest_info    zf_spec.rcd_invest_info ; 
    
    
    
    begin  
    
        --�������� 
        l_curr_year   :=  to_char( to_number(p_end_year ) + 1   ) ;  
        
      
        --���� p_invest_nt �õ�Ͷ����ϸ���� 
         
        
        p_invest_nt_self(l_tbl , l_curr_year , '00' , p_unit_code , p_adjust , 
        p_accounting ) ;
          
        
        --�õ� �����б�Ͷ�ʵ�λ����� Ͷ����ϸ��  
        p_get_investee(p_unit_code , p_tbl_rtn ) ; 
        
        
        --�Ƚ� l_tbl_rtn �� l_tbl �����l_tbl������ͬ�ı�Ͷ�ʵ�λ���� , �� ���� l_tbl�ļ�¼ 
        for x in  1 ..  p_tbl_rtn.count loop    
          
                for i in 1..   l_tbl.count  loop
                      
                      if (p_tbl_rtn(x).super_code = l_tbl(i).value_code  ) then
                        
                           l_tbl(i).value_code := p_tbl_rtn(x).value_code ; 
                           l_tbl(i).super_code := p_tbl_rtn(x).super_code ; 
                           l_tbl(i).rpt_version  := p_tbl_rtn(x).rpt_version ; 
                           l_tbl(i).assessmode := p_tbl_rtn(x).assessmode ;  
                           p_tbl_rtn(x) :=   l_tbl(i)  ;   
                          
            	
                      end if;
            	
                end loop;
                
        p_tbl_rtn(x).the_date :=  p_end_year ||  '12' ;                 
        p_tbl_rtn(x).curr_date  :=   p_end_year || '12' ;       
                
        end loop ;  
            
        
        
        
          
          --��Ͷ�ʵ�λ��������Ȩ����Ŀ
          
          for  i  in   1  ..  p_tbl_rtn.count  loop  
            
            
                --�õ�ÿ�±�Ͷ�ʵ�λ��������Ȩ����Ŀ��� 
                l_ntx_invest_detail := l_ntx_invest_detail_tmp ;     
            
          
              /*  --������ 
                dbms_output.put_line( p_tbl_rtn(i).value_code ) ; 
                dbms_output.put_line( p_tbl_rtn(i).rpt_version ) ;*/
                
                
                p_get_invest_investee_info( p_tbl_rtn(i).value_code  , 
                                            l_curr_year ||'01',  
                                            l_ntx_invest_detail, 
                                            p_tbl_rtn(i).rpt_version ) ; 
                                                          
                
                --�õ�Ͷ�ʱ�������  
                p_get_invest_info(l_rcd_invest_info ,p_tbl_rtn(i).unit_code , 
                p_tbl_rtn(i).value_code) ; 
                
          
                p_tbl_rtn(i).invest_rate_end  :=   
                f_invest_rate_curr( l_rcd_invest_info.v_ntx_rcd_invest_rate , 
                p_end_year || '12' ) ; 
                
                
                
                
                if( l_ntx_invest_detail.count  >0) then 
                
                    p_tbl_rtn(i).syzqy_qm_should_aft   := 
                    l_ntx_invest_detail(1).syzqy_qc_should_aft -
                    l_ntx_invest_detail(1).ssgd_syzqy_qc_should_aft ; 
                
                 p_tbl_rtn(i).investor_qm_should   := 
                 round(  p_tbl_rtn(i).syzqy_qm_should_aft *
                   p_tbl_rtn(i).invest_rate_end , 2) ; 
                
                   p_tbl_rtn(i).ssgd_qm_should   :=  
                   p_tbl_rtn(i).syzqy_qm_should_aft -  p_tbl_rtn(i).investor_qm_should ; 
                   
               else 
                 
                  p_tbl_rtn(i).syzqy_qm_should_aft   := 0 ; 
                
                
                  p_tbl_rtn(i).investor_qm_should   := 0 ; 
                
               
               end if; 
                   
               
                 
                
          end loop ; 
         
           
    
end ; 
    



---------------------------------------------------------------------------------
   --ʹ�ó��� :    ��ÿ����Ŀ���ڳ�����ĩ���������� 
   --����

   --      p_end_year  ������
   --      p_end_month   �����·�
   --      p_unit_code   ��λ����
   --      p_adjust   �Ƿ���������� �Ƿ����������, Y ,���� , N ,������ ,  A ֻ�е�����
  procedure  p_invest_nt(
                       p_tbl_rtn   in out   zf_spec.nt_rcd_invest_detail  ,  
                       p_end_year         IN varchar2 DEFAULT '2014',
                       p_end_month        IN varchar2 DEFAULT '02',
                       p_unit_code        IN VARCHAR2 DEFAULT '01',
                       p_adjust           in varchar2 default 'Y' ,  
                       p_accounting       in varchar2 default 'Y'  )

    is
   
    
    
    --����Ͷ����ϸ�� ( ��NC��Ŀ�ϻ�ȡ )
    
    l_tbl   zf_spec.nt_rcd_invest_detail   :=  zf_spec.nt_rcd_invest_detail(); 
    
    --����Ͷ��������ϸ�� (  ��NC��Ŀ��ȡ����  ) 
    l_tbl_rev   zf_spec.nt_rcd_invest_detail   :=  zf_spec.nt_rcd_invest_detail();  
    
    --���ڹ�ȨͶ����ϸ��¼���� , ������Ϊ�м���� , ���м�¼�Ĵ��� 
    l_rcd_invest_detail   zf_spec.rcd_invest_detail   ;  
    
    --���ڹ�ȨͶ����ϸ�б����  
    l_ntx_invest_detail   zf_spec.ntx_rcd_invest_detail ; 
    
    --���ڹ�ȨͶ����ϸ�б������ʼ��
    l_ntx_invest_detail_tmp    zf_spec.ntx_rcd_invest_detail ; 
    
    
    --Ͷ�ʱ������� 
    l_rcd_invest_info    zf_spec.rcd_invest_info ; 
    
    
    begin  
      
         --���� p_invest_nt_self �õ�Ͷ����ϸ���� 
         
        p_invest_nt_self(l_tbl , p_end_year , p_end_month , p_unit_code , p_adjust , p_accounting ) ;
          
        
        --���Ͷ������ 
         
        p_invest_nt_self_rev(l_tbl_rev , p_end_year , p_end_month , p_unit_code , p_adjust , p_accounting ) ;
          
        
           --�õ� �����б�Ͷ�ʵ�λ����� Ͷ����ϸ��  
        p_get_investee(p_unit_code , p_tbl_rtn ) ; 
        
        
        --�Ƚ� l_tbl_rtn �� l_tbl �����l_tbl������ͬ�ı�Ͷ�ʵ�λ���� , �� ���� l_tbl�ļ�¼ 
        for x in  1 ..  p_tbl_rtn.count loop   
          
                for i in 1..   l_tbl.count  loop
                      
                      if (p_tbl_rtn(x).super_code = l_tbl(i).value_code  ) then
                           l_tbl(i).value_code := p_tbl_rtn(x).value_code ; 
                           l_tbl(i).super_code := p_tbl_rtn(x).super_code ; 
                           l_tbl(i).rpt_version  := p_tbl_rtn(x).rpt_version ; 
                           l_tbl(i).assessmode := p_tbl_rtn(x).assessmode ;  
                           p_tbl_rtn(x) :=   l_tbl(i)  ;   
            	
                      end if;
            	
                end loop;
                
                
                
                  p_tbl_rtn(x).the_date := p_end_year || p_end_month;
                  p_tbl_rtn(x).curr_date  := p_end_year || p_end_month ; 
               
                
         end loop ;  
         
         
         
       --�Ƚ� l_tbl_rtn �� l_tbl_rev 
       --�����l_tbl������ͬ�ı�Ͷ�ʵ�λ���� , �� ���� l_tbl_rev��Ͷ������
        for x in  1 ..  p_tbl_rtn.count loop   
          
               
          
                for i in 1..   l_tbl_rev.count  loop
                      
                      if (p_tbl_rtn(x).super_code = l_tbl_rev(i).value_code  ) then
                        
                           p_tbl_rtn(x).tzsy_bq :=   l_tbl(i).tzsy_bq  ;   
            	
                      end if;
            	
                end loop;
                  
                
         end loop ;  
        
         
          
     
           
          
          --��Ͷ�ʵ�λ��������Ȩ����Ŀ
          
          
          for  i  in   1  ..  p_tbl_rtn.count  loop  
            
            
                --�õ�ÿ�±�Ͷ�ʵ�λ����������Ȩ����Ŀ��� 
                l_ntx_invest_detail := l_ntx_invest_detail_tmp ; 
                
            
                p_get_invest_investee_info( p_tbl_rtn(i).value_code ,p_tbl_rtn(i).the_date , 
                                            l_ntx_invest_detail  ,p_tbl_rtn(i).rpt_version ) ; 
                                            
        
                
                
                --�õ�Ͷ�ʱ�������  
                p_get_invest_info(l_rcd_invest_info ,p_tbl_rtn(i).unit_code , 
                p_tbl_rtn(i).value_code) ; 
          
                 
                l_rcd_invest_detail :=  p_tbl_rtn(i) ;
                
                --���ɳɱ���תȨ�淨��ϸ�������
                
                p_invest_nt_deal_data(l_rcd_invest_detail , 
                l_rcd_invest_info.v_ntx_rcd_invest_rate , 
                l_ntx_invest_detail) ; 
                
                
                
                p_get_invest_lst_info( l_rcd_invest_detail  ) ; 
                           
                        
                
                p_tbl_rtn(i) :=  l_rcd_invest_detail  ; 
                 
                
          end loop ;    
    
    end ; 
  
  ---------------------------------------------------------------------------------
   --ʹ�ó��� :    ���ɳ��ڹ�ȨͶ����ϸ��  
   --����

   --      p_end_year  ������
   --      p_end_month   �����·�
   --      p_unit_code   ��λ����
   --      p_adjust   �Ƿ���������� �Ƿ����������, Y ,���� , N ,������ ,  A ֻ�е�����
   function f_invest_nt(
                       p_end_year         IN varchar2 DEFAULT '2014',
                       p_end_month        IN varchar2 DEFAULT '02',
                       p_unit_code        IN VARCHAR2 DEFAULT '01',
                       p_adjust           in varchar2 default 'Y' ,  
                       p_accounting       in varchar2 default 'Y'  )
    RETURN zf_spec.nt_rcd_invest_detail 
    pipelined 
    
    is
    
    --���庯������ֵ  
      
    l_tbl_rtn    zf_spec.nt_rcd_invest_detail   :=    zf_spec.nt_rcd_invest_detail(); 
    
    begin 
      
          if (p_end_year = zf_spec.V_IUFO_INIT_YEAR ) then
            
               p_invest_nt_bg( l_tbl_rtn  , p_end_year ,
               p_unit_code , p_adjust   ,  p_accounting   ) ; 
	
          else 
             
               
               p_invest_nt(l_tbl_rtn , p_end_year ,p_end_month  ,

               p_unit_code , p_adjust   ,  p_accounting   ) ; 
               
          
          end if; 
          
          
        
         --�� l_Tbl������ͨ���ܵ����� 
         
          for i in 1.. l_tbl_rtn.count loop
            
          
	                ---l_tbl_rtn(i).value_code  := l_tbl_rtn(i).super_code ; 
                  pipe row (l_tbl_rtn(i)) ; 
                  
          end loop;
          
    return ;      
    
    end ; 





-------------------------------------------------------------
 ---ʹ�ó��� :   ��ʼ��������Ŀ��Ŀ��ѯ�ַ��� 
 procedure  p_init_subj_search_partern
 is
 begin 
   
    v_ntx_rcd_subj_search_partern('0004'||'_'||'sszb') := '4001' ; 
    v_ntx_rcd_subj_search_partern('0004'||'_'||'zbgj') := '4002' ; 
    v_ntx_rcd_subj_search_partern('0004'||'_'||'yygj') := '4101' ; 
    v_ntx_rcd_subj_search_partern('0004'||'_'||'bnlr') := '4103' ; 
    v_ntx_rcd_subj_search_partern('0004'||'_'||'lrfp') := '4104' ; 
    v_ntx_rcd_subj_search_partern('0004'||'_'||'zxcb') := '4301' ; 
    v_ntx_rcd_subj_search_partern('0005'||'_'||'sszb') := '3101' ; 
    v_ntx_rcd_subj_search_partern('0005'||'_'||'zbgj') := '3111' ; 
    v_ntx_rcd_subj_search_partern('0005'||'_'||'yygj') := '3121' ; 
    v_ntx_rcd_subj_search_partern('0005'||'_'||'bnlr') := '3131' ; 
    v_ntx_rcd_subj_search_partern('0005'||'_'||'lrfp') := '3141' ; 
    v_ntx_rcd_subj_search_partern('0005'||'_'||'zxcb') := '####' ; 
 end ; 


--------------------------------------------------------------





---------------------------------------------------------
begin
 
     p_init_reclass_rule ;
     
     p_init_subj_search_partern ;  
     
end zf;
/
