create or replace package zf is

   --定义往来科目重分类规则的PLSQL表变量 
   v_nt_arap_reclass_rule   zf_spec.nt_reclass_arap_rule ; 
   v_ntx_arap_item_list     zf_spec.ntx_varchar2_64 ; 
   
   --定义报表项目对应科目查询字符串
   v_ntx_rcd_subj_search_partern  zf_spec.ntx_subj_para  ; 
   
   ------------------------------------------------------------------------------
   --使用场景:根据单位编码 ,获取组织的账簿信息,科目表
   --参数:  org_code  组织代码
   --       p_group   所属集团
   --返回值:  组织的科目表,账簿等记录类型的嵌套表
   function f_org_info(p_org_code varchar2 , 
                       p_group varchar2 default zf_spec.GROUP_ORG_PK   ) 
   return  zf_spec.rcd_org_info  ;  
   
   ---------------------------------------------------------------------
    function f_subj_info_code_list_grade_1(p_subj_code varchar2 , p_org_code varchar2 , 
                        p_group varchar2 default zf_spec.GROUP_ORG_PK   ) 
   return  zf_spec.ntx_varchar2_64  ; 
   
   
   --------------------------------------------------------------------------
   --使用场景:根据单位编码,集团信息,科目编码,获取科目的信息
   --参数:  subj_code 科目编码
   --       org_code  组织代码
   --       p_group   所属集团
   --返回值:  组织的科目表,账簿等记录类型的嵌套表
   function f_subj_info_single(p_subj_code varchar2 , p_org_code varchar2 , 
                        p_group varchar2 default zf_spec.GROUP_ORG_PK   ) 
   return  zf_spec.ntx_rcd_subj_info  ;
   

--使用场景:根据单位编码,集团信息,科目编码,获取科目的信息
   --参数:  subj_code 科目编码
   --       org_code  组织代码
   --       p_group   所属集团
   --返回值:  组织的科目表,账簿等记录类型的嵌套表
   function f_subj_info_multi(p_subj_code varchar2 , p_org_code varchar2 , 
                        p_group varchar2 default zf_spec.GROUP_ORG_PK   ) 
   return  zf_spec.ntx_rcd_subj_info  ;
  
    ------------对往来科目的重分类标准进行初始化 
    procedure  p_init_reclass_rule  ; 
  
   
    ---------------------------------------------------------------------------------
   --使用场景 :  对客商辅助核算的科目余额进行重分类 , 用在资产负债表中
   --参数
   --      p_end_year  结束年
   --      p_end_month   结束月份
   --      p_unit_code   单位编码
   --      p_subj_code   科目编码
   --      p_consolidate_flag    是否是将下级科目汇总到上级科目中
   --      p_adjust   是否包含调整期 是否包含调整期, Y ,包含, N ,不包含, A 只有调整期

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
   --使用场景 :    求制定科目的期初或期末的余额，或发生额 
   --参数
   --      p_beg_year  开始年
   --      p_end_year  结束年
   --      p_beg_month  开始月份
   --      p_end_month   结束月份
   --      p_unit_code   单位编码
   --      p_subj_code   科目编码
   --      p_aux_style   辅助核算类型
   --      p_aux_code    辅助核算代码
   --      p_aux_name    辅助核算名称
   --      p_accur_bool  是否是求发生额
   --      p_group_name  集团名称
   --      p_consolidate_flag    是否是将下级科目汇总到上级科目中
   --      p_adjust   是否包含调整期 是否包含调整期, Y ,包含, N ,不包含, A 只有调整期
   --      p_special  是否特殊用于,如用于I3_05,按月进行汇总
   --      p_curr         币种    'BWB' ,
   --      p_accounting     是否包含已经记账
   --      p_dir    方向 ,如果是求发生额  , 则制定求发生额的方向
   --使用者 :    IUFO报表中,计算科目余额或发生额使用
   --作者 :    bieyifeng
   --时间  :   20140428
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
                                p_subjcode_regexp               in varchar2  default  'Y'    --科目代码的检索是否用正则表达式
                                )
  return number  ;

---------------------------------------------------------------------------------
   --使用场景 :    求每个科目的期初或期末的余额，或发生额 
   --参数
   --      p_beg_year  开始年
   --      p_end_year  结束年
   --      p_beg_month  开始月份
   --      p_end_month   结束月份
   --      p_unit_code   单位编码
   --      p_subj_code   科目编码
   --      p_aux_style   辅助核算类型
   --      p_aux_code    辅助核算代码
   --      p_aux_name    辅助核算名称
   --      p_accur_bool  是否是求发生额
   --      p_group_name  集团名称
   --      p_consolidate_flag    是否是将下级科目汇总到上级科目中
   --      p_adjust   是否包含调整期 是否包含调整期, Y ,包含, N ,不包含, A 只有调整期
   --      p_special  是否特殊用于,如用于I3_05,按月进行汇总
   --      p_rcd_subj_info    类型,科目信息记录, 
   --      p_rcd_corp_info    组织信息记录类型   
 function f_bal_accur_ex(p_beg_year         IN varchar2 DEFAULT '2014',
                       p_end_year         IN varchar2 DEFAULT '2014',
                       p_beg_month        IN varchar2 DEFAULT '01',
                       p_end_month        IN varchar2 DEFAULT '02',
                       p_unit_code        IN VARCHAR2 DEFAULT '01',
                       p_subj_code        IN VARCHAR2 DEFAULT '100201',
                       p_aux_style        IN VARCHAR2 DEFAULT null,
                       p_aux_code         IN VARCHAR2 DEFAULT '*',
                       p_aux_name         IN VARCHAR2 DEFAULT '*',
                        p_aux_fi_org      in varchar2 default  '~'  ,    --筛选内部客商用
                       p_accur_bool       in varchar2 default 'Y',
                       p_adjust           in varchar2 default 'Y' , 
                       p_consolidate_flag in varchar2 default 'Y' , 
                       p_special          in varchar2 default NULL , 
                       p_curr             in varchar2 default 'BWB',
                       p_accounting       in varchar2 default 'Y' , 
                       p_chart_system    in varchar2 default  '0004' ,
                       p_subjcode_regexp               in varchar2  default  'Y' ,    --科目代码的检索是否用正则表达式
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
   --使用场景 :  对客商辅助核算的科目余额进行重分类列示,用在债权债务明细表中
   --参数
   --      p_end_year  结束年
   --      p_end_month   结束月份
   --      p_unit_code   单位编码
   --      p_subj_code   科目编码
   --      p_consolidate_flag    是否是将下级科目汇总到上级科目中
   --      p_adjust   是否包含调整期 是否包含调整期, Y ,包含, N ,不包含, A 只有调整期

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
   --使用场景 :    求每个科目的期初或期末的余额，或发生额 
   --参数

   --      p_end_year  结束年
   --      p_end_month   结束月份
   --      p_unit_code   单位编码
   --      p_adjust   是否包含调整期 是否包含调整期, Y ,包含, N ,不包含, A 只有调整期
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
  
   --定义常量 ,代表一个无效的值 
   
   v_nothing  constant   varchar2(1)   :=  '#' ; 
   
   
   

   ------------------------------------------------------------------------------
   --使用场景 : 根据单位编码 , 获取组织的账簿信息,科目表
   --参数:  org_code  组织代码
   --       p_group   所属集团
   --返回值:  组织的科目表,账簿等记录类型的嵌套表
   function f_org_info(p_org_code varchar2 , 
                       p_group varchar2 default zf_spec.GROUP_ORG_PK   ) 
   return  zf_spec.rcd_org_info 
   is
   --定义游标,根据报表组织的代码,找到报表组织对应的基本组织的PK 和报表组织的信息
   cursor l_cur_org(p_curr_org_code  varchar2 ,  p_curr_group varchar2  )  
   is
   select  s.code  org_code ,s.name org_name,s.pk_org pk_org , s.pk_group
   from  org_orgs s 
   where nvl(s.dr , 0) = 0
   and s.pk_group = p_curr_group 
   and s.code  =  p_curr_org_code ; 
   
   
    --定义局部记录变量,用于存放游标l_cur_org 的查询结果
   l_recd_org_info   l_cur_org%rowtype ; 
   
   
   --定义游标,根据组织主键,得到组织的账簿信息(主账簿) 
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
   
     --定义局部记录变量,用于存放游标l_cur_book的查询结果
   l_recd_org_book_info   l_cur_book%rowtype ; 
   
   --定义一个局部rcd_org_info类型的记录变量,作为返回值
   l_retn_org_info     zf_spec.rcd_org_info ; 
   
   begin   
       
     --获取组织信息 
     open l_cur_org(p_org_code , p_group )  ; 
        fetch l_cur_org into  l_recd_org_info ;
     close l_cur_org ; 
     
     --把基本的组织信息,从记录变量中复制到返回值
          l_retn_org_info.pk_org := l_recd_org_info.pk_org ; 
          l_retn_org_info.org_code :=l_recd_org_info.org_code ; 
          l_retn_org_info.org_name :=l_recd_org_info.org_name ;
          l_retn_org_info.pk_group := l_recd_org_info.pk_group ; 
          
     
     --获取账簿和科目表的信息
      open l_cur_book(l_recd_org_info.pk_org ,p_group ) ; 
       
          fetch l_cur_book into l_recd_org_book_info  ; 
          
      close  l_cur_book; 
      
      --赋值 账簿信息到 返回值
          l_retn_org_info.pk_accchart :=l_recd_org_book_info.pk_curraccchart ; 
          l_retn_org_info.pk_accountingbook :=l_recd_org_book_info.pk_accountingbook ; 
          l_retn_org_info.accounttype :=l_recd_org_book_info.pk_setofbook ;
          l_retn_org_info.pk_accsystem := l_recd_org_book_info.pk_accsystem ;     
          l_retn_org_info.accsystem_code := l_recd_org_book_info.accsystem_code ;
     
     --返回值
     return  l_retn_org_info ; 
     
     --异常处理
     exception 
       
     --当无查询结果的处理,返回 NULL
     when NO_DATA_FOUND then 
          
          l_retn_org_info  := null; 
          
          return l_retn_org_info ;
          
     --当其他错误时, 暂返回 NULL
     when others then 
       
          l_retn_org_info  := null; 
          
          return l_retn_org_info ; 
 
   end ; 

   ------------------------------------------------------------------------------
   --使用场景:根据单位编码 ,集团信息,科目编码,获取科目的信息
   --参数:  subj_code 科目编码
   --       org_code  组织代码
   --       p_group   所属集团
   --返回值:  组织的科目表,账簿等记录类型的嵌套表
   function f_subj_info_single(p_subj_code varchar2 , p_org_code varchar2 , 
                        p_group varchar2 default zf_spec.GROUP_ORG_PK   ) 
   return  zf_spec.ntx_rcd_subj_info 
   is
   --定义公司信息记录变量,用来存储公司科目表等信息
   l_rcd_org_info  zf_spec.rcd_org_info ; 
   
   --定义科目表信息记录类型变量
   l_rcd_subj_info  zf_spec.rcd_subj_info ; 
  
   
   --定义函数返回值
   l_ntx_rcd_subj_info     zf_spec.ntx_rcd_subj_info ; 
   
   --定义游标,查询科目的基本信息
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
    
   
    
   /*--定义游标变量,查询辅助核算的详细信息
   cursor l_cur_subj_aux(p_cur_pk_accasoa varchar2)  
   is
   select b.pk_accass ,c.pk_accassitem ,c.refnodename ,c.code ,c.name
   from  bd_accassitem c  , bd_accass b  
   where  c.pk_accassitem  = b.pk_entity
   and    b.pk_accasoa  =  p_cur_pk_accasoa ; 
   
   
   --定义嵌套表 类型,用来存储 游标 l_subj_aux的查询结果
   l_tbl_subj_ass_info    zf_spec.nt_rcd_subj_ass_info  := zf_spec.nt_rcd_subj_ass_info(); */
   
   
   --变量,监控 记录是否为NULL , 表示 是否查询取到了值 
   
   l_mark  pls_integer ; 
   
   begin 
    
     
      --获取公司的科目表的信息 
      l_rcd_org_info  := f_org_info(p_org_code , p_group) ;
      
      --获取科目的信息
      
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
               

      
      /*--获取辅助核算的详细信息 
      for rcd in  l_cur_subj_aux(l_rcd_subj_info.pk_accasoa) loop 
        
           l_tbl_subj_ass_info.extend ; 
           l_tbl_subj_ass_info(l_tbl_subj_ass_info.count).pk_accass  :=  rcd.pk_accass ; 
           l_tbl_subj_ass_info(l_tbl_subj_ass_info.count).pk_accassitem  :=  rcd.pk_accassitem ; 
           l_tbl_subj_ass_info(l_tbl_subj_ass_info.count).refnodename  :=  rcd.refnodename ; 
           l_tbl_subj_ass_info(l_tbl_subj_ass_info.count).ref_code  :=  rcd.code ; 
           l_tbl_subj_ass_info(l_tbl_subj_ass_info.count).ref_name  :=  rcd.name ; 
      
      end loop ;
      
      --把辅助核算明细的嵌套表赋值给 记录变量
      l_rcd_subj_info.subj_ass_info  := l_tbl_subj_ass_info ; */
      
      
      --判断  l_rcd_subj_info 是否为空 ,如果为空 ,则进行处理 ,以便 后续程序不出现异常 
     
      
      
      l_ntx_rcd_subj_info(l_ntx_rcd_subj_info.count +1)  := l_rcd_subj_info ; 
      
     
      
      return  l_ntx_rcd_subj_info ; 
      
   end ; 
   
   
   
   ------------------------------------------------------------------------------
   --使用场景:根据单位编码,集团信息,科目编码,获取科目的信息 , 科目多于1个 
   --参数:  subj_code 科目编码 , 编码小于4位
   --       org_code  组织代码
   --       p_group   所属集团
   --返回值:  组织的科目表,账簿等记录类型的嵌套表
   function f_subj_info_code_list_grade_1(p_subj_code varchar2 , p_org_code varchar2 , 
                        p_group varchar2 default zf_spec.GROUP_ORG_PK   ) 
   return  zf_spec.ntx_varchar2_64 
   is
   --定义公司信息记录变量,用来存储公司科目表等信息
   l_rcd_org_info  zf_spec.rcd_org_info ; 
   
   --定义科目表信息记录关联数组类型变量,作为函数返回值
   l_ntx_varchar2_64   zf_spec.ntx_varchar2_64  ; 
   
   
   --定义游标,查询科目的基本信息,取一级科目的编码列表
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
   --使用场景:根据单位编码,集团信息,科目编码,获取科目的信息
   --参数:  subj_code 科目编码
   --       org_code  组织代码
   --       p_group   所属集团
   --返回值:  组织的科目表,账簿等记录类型的嵌套表
   function f_subj_info_multi(p_subj_code varchar2 , p_org_code varchar2 , 
                        p_group varchar2 default zf_spec.GROUP_ORG_PK   ) 
   return  zf_spec.ntx_rcd_subj_info 
   is
  
   --定义科目表变量列表
   l_ntx_varchar2_64   zf_spec.ntx_varchar2_64  ;  
   
   --定义函数返回值
   l_ntx_rcd_subj_info     zf_spec.ntx_rcd_subj_info ; 
   
   
   
   begin 
     
        ---得到科目表的列表 
        l_ntx_varchar2_64  := f_subj_info_code_list_grade_1(p_subj_code ,p_org_code , p_group )  ;  
        
        --调用 f_subj_info_single, 得到返回值
        for i in 1 .. l_ntx_varchar2_64.count  loop
 
                    l_ntx_rcd_subj_info(l_ntx_rcd_subj_info.count+1)  :=  f_subj_info_single( l_ntx_varchar2_64(i) , p_org_code , p_group)(1)  ; 

        end loop;
        
        
        --判断 l_ntx_rcd_subj_info 是否为空 ,如果为空,进行处理 
        
        if(l_ntx_rcd_subj_info.count  =  0 ) then  
        
             l_ntx_rcd_subj_info(l_ntx_rcd_subj_info.count+1).subj_code := v_nothing ; 
             
        end if; 
       
        
       return l_ntx_rcd_subj_info ;
   
   end ; 
   

----------------------------------------------------------------------
--此函数得到币种的PK
  function  f_curr_pk(p_curr  varchar2 )
  return varchar2 
  is
  --作为函数的返回值 
  l_curr_pk   varchar2(20) ; 
  
  --查询币种PK的游标 
  cursor  l_cur(p_cur_curr varchar2)  
  is
  select PK_CURRTYPE  from  BD_CURRTYPE  where  code = upper(p_cur_curr) ; 
  
  begin 
  
     --如果币种为 BWB ,则返回 BWBPK
     if( upper(p_curr) = 'BWB') then 
       
          l_curr_pk := '%' ;
        
     else 
     
          for i  in  l_cur(p_curr) loop  
          
              l_curr_pk  :=  i.PK_CURRTYPE ; 
          
          end loop ; 
     
     end if; 
     
     return  l_curr_pk ; 
     
     --处理异常 ,返回币种的PK 为 BWBPK 
     
     exception  
     
     when others then  
        
           l_curr_pk  := '%' ; 
           
           return  l_curr_pk ; 
  
  end ; 

   
  
  ---------------------------------------------------------------------------------
   --使用场景 :    求每个科目的期初或期末的余额, 不带辅助核算
   --              不带辅助核算的余额的游标变量 ,对科目明细进行汇总 , 
   --              各个明细科目汇总当成一级科目进行计算合计 
   --参数
   --      p_beg_year  开始年
   --      p_end_year  结束年
   --      p_beg_month  开始月份
   --      p_end_month   结束月份
   --      p_unit_code   单位编码
   --      p_subj_code   科目编码
   --      p_aux_style   辅助核算类型
   --      p_aux_code    辅助核算代码
   --      p_aux_name    辅助核算名称
   --      p_accur_bool  是否是求发生额
   --      p_group_name  集团名称
   --      p_consolidate_flag    是否是将下级科目汇总到上级科目中
   --      p_adjust   是否包含调整期 是否包含调整期, Y ,包含, N ,不包含, A 只有调整期
   --      p_special  是否特殊用于,如按月进行汇总
   --      p_rcd_subj_info    类型,科目信息记录, 
   --      p_rcd_corp_info    组织信息记录类型   

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
  
  --定义币种主键 
  l_curr_pk    varchar2(20)   ;
  
  --定义最顶端科目的方向 
  l_cur_super_subj_orient    pls_integer  ;  
  
  --定义凭证明细记录变量
  l_rcd  zf_spec.rcd_voucher_detail_s  ; 
  
  --定义科目信息明细记录
  l_rcd_subj  zf_spec.rcd_subj_info  ; 
  
  --定义查询游标 
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
    
    --得到币种的PK
    l_curr_pk  :=  f_curr_pk(p_curr)  ; 

           
  --确定最顶层科目的方向 
   l_rcd_subj :=  p_rcd_subj_info(1)  ; 
  if( p_rcd_subj_info.count =1 ) then  
                   l_cur_super_subj_orient  :=l_rcd_subj.bal_orient  ; 
                
  else 
                  --如果是一级以上科目,人为规定为 0 ,即资产类科目
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
   --使用场景 :    求每个科目的期初或期末的余额, 不带辅助核算
   --              不带辅助核算的余额的游标变量 ,对科目明细进行汇总 , 
   --              各个明细科目汇总当成一级科目进行计算合计 
   --参数
   --      p_beg_year  开始年
   --      p_end_year  结束年
   --      p_beg_month  开始月份
   --      p_end_month   结束月份
   --      p_unit_code   单位编码
   --      p_subj_code   科目编码
   --      p_aux_style   辅助核算类型
   --      p_aux_code    辅助核算代码
   --      p_aux_name    辅助核算名称
   --      p_accur_bool  是否是求发生额
   --      p_group_name  集团名称
   --      p_consolidate_flag    是否是将下级科目汇总到上级科目中
   --      p_adjust   是否包含调整期 是否包含调整期, Y ,包含, N ,不包含, A 只有调整期
   --      p_special  是否特殊用于,如按月进行汇总
   --      p_rcd_subj_info    类型,科目信息记录, 
   --      p_rcd_corp_info    组织信息记录类型   

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
  
  --定义币种主键 
  l_curr_pk    varchar2(20)   ;
  
  --定义最顶端科目的方向 
  l_cur_super_subj_orient    pls_integer  ;  
  
  --定义凭证明细记录变量
  l_rcd  zf_spec.rcd_voucher_detail_s  ; 
  
  --定义科目信息明细记录
  l_rcd_subj  zf_spec.rcd_subj_info  ; 
  
  --定义查询游标 
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
    
    --得到币种的PK
    l_curr_pk  :=  f_curr_pk(p_curr)  ; 
           
  --确定最顶层科目的方向 
   l_rcd_subj :=  p_rcd_subj_info(1)  ; 
 
   
   
  if( p_rcd_subj_info.count =1 ) then  
                   l_cur_super_subj_orient  :=l_rcd_subj.bal_orient  ; 
                
  else 
                  --如果是一级以上科目,人为规定为 0 ,即资产类科目
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
   --使用场景 :    求每个科目的期初或期末的余额, 不带辅助核算
   --              不带辅助核算的余额的游标变量 ,对科目明细进行汇总 , 
   --              各个明细科目汇总当成一级科目进行计算合计 
   --参数
   --      p_beg_year  开始年
   --      p_end_year  结束年
   --      p_beg_month  开始月份
   --      p_end_month   结束月份
   --      p_unit_code   单位编码
   --      p_subj_code   科目编码
   --      p_aux_style   辅助核算类型
   --      p_aux_code    辅助核算代码
   --      p_aux_name    辅助核算名称
   --      p_accur_bool  是否是求发生额
   --      p_group_name  集团名称
   --      p_consolidate_flag    是否是将下级科目汇总到上级科目中
   --      p_adjust   是否包含调整期 是否包含调整期, Y ,包含, N ,不包含, A 只有调整期
   --      p_special  是否特殊用于,如按月进行汇总
   --      p_rcd_subj_info    类型,科目信息记录, 
   --      p_rcd_corp_info    组织信息记录类型   

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
  
  --定义币种主键 
  l_curr_pk    varchar2(20)   ;
  
  --定义最顶端科目的方向 
  l_cur_super_subj_orient    pls_integer  ;  
  
  --定义凭证明细记录变量
  l_rcd  zf_spec.rcd_voucher_detail_s  ; 
  
  --定义科目信息明细记录
  l_rcd_subj  zf_spec.rcd_subj_info  ; 
  
  --定义查询游标 
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
    
    --得到币种的PK
    l_curr_pk  :=  f_curr_pk(p_curr)  ; 

           
  --确定最顶层科目的方向 
   l_rcd_subj :=  p_rcd_subj_info(1)  ; 
  if( p_rcd_subj_info.count =1 ) then  
                   l_cur_super_subj_orient  :=l_rcd_subj.bal_orient  ; 
                
  else 
                  --如果是一级以上科目,人为规定为 0 ,即资产类科目
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
   --使用场景 :    求每个科目的期初或期末的余额, 不带辅助核算
   --              不带辅助核算的余额的游标变量 ,对科目明细进行汇总 , 
   --              各个明细科目汇总当成一级科目进行计算合计 
   --参数
   --      p_beg_year  开始年
   --      p_end_year  结束年
   --      p_beg_month  开始月份
   --      p_end_month   结束月份
   --      p_unit_code   单位编码
   --      p_subj_code   科目编码
   --      p_aux_style   辅助核算类型
   --      p_aux_code    辅助核算代码
   --      p_aux_name    辅助核算名称
   --      p_accur_bool  是否是求发生额
   --      p_group_name  集团名称
   --      p_consolidate_flag    是否是将下级科目汇总到上级科目中
   --      p_adjust   是否包含调整期 是否包含调整期, Y ,包含, N ,不包含, A 只有调整期
   --      p_special  是否特殊用于,如按月进行汇总
   --      p_rcd_subj_info    类型,科目信息记录, 
   --      p_rcd_corp_info    组织信息记录类型   

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
  
  --定义币种主键 
  l_curr_pk    varchar2(20)   ;
  
  --定义最顶端科目的方向 
  l_cur_super_subj_orient    pls_integer  ;  
  
  --定义凭证明细记录变量
  l_rcd  zf_spec.rcd_voucher_detail_s  ; 
  
  --定义科目信息明细记录
  l_rcd_subj  zf_spec.rcd_subj_info  ; 
  
  --定义查询游标 
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
    
    --得到币种的PK
    l_curr_pk  :=  f_curr_pk(p_curr)  ; 
           
  --确定最顶层科目的方向 
   l_rcd_subj :=  p_rcd_subj_info(1)  ; 
  if( p_rcd_subj_info.count =1 ) then  
                   l_cur_super_subj_orient  :=l_rcd_subj.bal_orient  ; 
                
  else 
                  --如果是一级以上科目,人为规定为 0 ,即资产类科目
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
  
  
  
  
   
  
  
  
  --不带辅助核算的游标变量  , 对明细科目各自合并
  --参数 
      -- 同  f_tb_bal_accur的参数说明

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
  
       --区分计算余额 ,还是计算发生额  
       
       case  upper(p_accur_bool)  
       
         --当计算发生额  和 净发生额  
          when  'Y' THEN  
          
             p_comm_comm_con_n_accur(p_nt_voucher_detail_s , p_beg_year,p_end_year , 
                        p_beg_month , p_end_month,
                        p_unit_code, p_subj_code  , p_rcd_subj_info ,
                        p_rcd_corp_info , p_curr ,  p_period_length_max , p_accounting )  ; 
                        
          
         --当计算余额     
          else 
          
             p_comm_comm_con_n_bal(p_nt_voucher_detail_s , p_end_year , p_end_month,
                        p_unit_code, p_subj_code  , p_rcd_subj_info ,
                        p_rcd_corp_info , p_curr ,  p_period_length_max , p_accounting )  ; 
            
            
        end case ; 
     
  end ;
  
  
  
  
  
  --不带辅助核算的游标变量  , 对明细科目进行合并 到上一级科目 
  --参数 
      -- 同  f_tb_bal_accur的参数说明

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
  
       --区分计算余额 ,还是计算发生额  
       
       case  upper(p_accur_bool)  
       
         --当计算发生额  和 净发生额  
          when  'Y' THEN  
          
             p_comm_comm_con_y_accur(p_nt_voucher_detail_s , p_beg_year,p_end_year , 
                        p_beg_month , p_end_month,
                        p_unit_code, p_subj_code  , p_rcd_subj_info ,
                        p_rcd_corp_info , p_curr ,  p_period_length_max , p_accounting )  ; 
                        
          
         --当计算余额     
          else 
          
             p_comm_comm_con_y_bal(p_nt_voucher_detail_s , p_end_year , p_end_month,
                        p_unit_code, p_subj_code  , p_rcd_subj_info ,
                        p_rcd_corp_info , p_curr ,  p_period_length_max , p_accounting )  ; 
            
            
        end case ; 
     
  end ;
  
  
  
  
  
  
  
  ----------------------------------------------------------------
  --得到不 带辅助核算的余额表的游标  , 普通业务 
  --参数 
  --参见  f_bal_accur; 
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
     
     ----对明细科目,汇总到上一级科目
      if ( upper(p_consolidate_flag)  = 'Y' ) then 
    
             p_comm_comm_con_y(p_nt_voucher_detail_s , p_beg_year , p_end_year , 
             p_beg_month, p_end_month,
                       p_unit_code, p_subj_code,  p_accur_bool , 
                       p_rcd_subj_info , p_rcd_corp_info ,
                       p_curr,    p_period_length_max , 
                       p_accounting  ) ;              
     else  
          
         -------按照明细科目, 分别进行汇总    
         p_comm_comm_con_n(p_nt_voucher_detail_s , p_beg_year , p_end_year , 
                 p_beg_month, p_end_month,
                       p_unit_code, p_subj_code,  p_accur_bool , 
                       p_rcd_subj_info , p_rcd_corp_info ,
                       p_curr,    p_period_length_max , 
                       p_accounting  ) ;              
          
     end if; 
                      

     
     
    end ; 
  
  
 
  
  
  ---------------------------------------------------------------------
  --得到 不带辅助核算的余额表的游标 
  --参数 
  --参见  f_bal_accur; 
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
    
    --根据P_SPECIAL参数进行判断  , 分别走何种业务 
    
    case upper(p_special ) 
    
       --当需要按月和年进行汇总  
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
  
  
  ----存储过程，处理客商替代
  --p_rcd_kstd_nt_voucher 凭证表行记录
  --p_kstd_nt_voucher    客商替代后的凭证明细表， 每个客商一行，按此行进行汇总 
  --p_kstd_doc           客商替代明细档案 
  --p_kstd_mark          客商替代标志
  
  procedure  p_kstd(p_rcd_kstd_nt_voucher  in out   zf_spec.rcd_voucher_detail_s ,   
                    p_kstd_nt_voucher  in out    zf_spec.nt_voucher_detail_s  , 
                    p_kstd_doc         in        zf_spec.ntx_rcd_defdoc ,  
                    p_kstd_mark        in out    pls_integer )
  is
  
  --标示变量  , 说明是否在  p_kstd_nt_voucher 存在满足条件的记录  
  l_mark      pls_integer   :=  0  ;  
  
  
 
  begin 
    
         --遍历 客商替代明细档案， 看是否有 编码等于 凭证行的客商编码 
         for  x  in 1 ..  p_kstd_doc.count  loop  
           
             if (   ( p_rcd_kstd_nt_voucher.value_code  =  p_kstd_doc(x).def_value_code  and 
                  p_rcd_kstd_nt_voucher.org_code   like   p_kstd_doc(x).def_unit_code)  
                    or  
                    (p_rcd_kstd_nt_voucher.value_code  =  p_kstd_doc(x).def_real_value_code )
                 )  then
               
                 --- 说明 在  客商替代明细档案中存在需要替换的客商
                 p_kstd_mark  := 1 ;  
                 
                  
                 --替换掉客商编码和客商名称 
                 p_rcd_kstd_nt_voucher.value_code := p_kstd_doc(x).def_real_value_code ; 
                 p_rcd_kstd_nt_voucher.value_name := p_kstd_doc(x).def_name ; 
                 
                 --把对应的客商对应的财务组织改为非 ~ , 以便生成客商内部往来明细表中包含需要替代的客商
                 p_rcd_kstd_nt_voucher.pk_aux_fi_org  := 'not~' ; 
                 
                 
                 --对需要替换的客商凭证行进行处理 
                 
                 l_mark  :=   0 ;   
               
                 --遍历 凭证表，找相同 VALUE_CODE 的记录 
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
             
             
             
                 --如果凭证表中没有记录匹配，则把此记录插入到凭证表中 
                 if(l_mark =  0  ) then 
                  
                     p_kstd_nt_voucher.extend ; 
                     p_kstd_nt_voucher(p_kstd_nt_voucher.count) := p_rcd_kstd_nt_voucher ;
                 
                 
                 end if;  
                 
                 
                 
                 
                --找到后退出  
                exit;  
             
             end if;  
         
         end loop ;    
  
  
  end ; 
  
  
  
  
  ---------------------------------------------------------------------------------
   --使用场景 :    求每个科目的期初或期末的余额, 不带辅助核算
   --              不带辅助核算的余额的游标变量 ,对科目明细进行汇总 , 
   --              各个明细科目汇总当成一级科目进行计算合计 
   --参数
   --      p_beg_year  开始年
   --      p_end_year  结束年
   --      p_beg_month  开始月份
   --      p_end_month   结束月份
   --      p_unit_code   单位编码
   --      p_subj_code   科目编码
   --      p_aux_style   辅助核算类型
   --      p_aux_code    辅助核算代码
   --      p_aux_name    辅助核算名称
   --      p_accur_bool  是否是求发生额
   --      p_group_name  集团名称
   --      p_consolidate_flag    是否是将下级科目汇总到上级科目中
   --      p_adjust   是否包含调整期 是否包含调整期, Y ,包含, N ,不包含, A 只有调整期
   --      p_special  是否特殊用于,如按月进行汇总
   --      p_rcd_subj_info    类型,科目信息记录, 
   --      p_rcd_corp_info    组织信息记录类型   

  procedure     p_aux_comm_con_y_bal_cust(
                       p_nt_voucher_detail_s   in out   nocopy zf_spec.nt_voucher_detail_s , 
                       p_end_year         IN varchar2 DEFAULT '2012',
                       p_end_month        IN varchar2 DEFAULT '08',
                       p_unit_code        IN VARCHAR2 DEFAULT '01',
                       p_subj_code        IN VARCHAR2 DEFAULT '100201',
                       p_aux_code         IN VARCHAR2 DEFAULT '*',
                       p_aux_name         IN VARCHAR2 DEFAULT '*',   
                       p_aux_fi_org          in  varchar2  ,   --对应财务组织 ,用来筛选内部客商   
                       p_rcd_subj_info    in zf_spec.ntx_rcd_subj_info , 
                       p_rcd_corp_info    in zf_spec.rcd_org_info   ,  
                       p_curr             in varchar2  default 'RMB' ,
                       p_period_length_max  in number default 2 , 
                       p_accounting   in number  default 1 
                   )  
  is
  
  --定义币种主键 
  l_curr_pk    varchar2(20)   ;
  
  --定义最顶端科目的方向 
  l_cur_super_subj_orient    pls_integer  ;  
  
  --定义凭证明细记录变量
  l_rcd  zf_spec.rcd_voucher_detail_s  ; 
  
  --定义科目信息明细记录
  l_rcd_subj  zf_spec.rcd_subj_info  ; 
  
  --定义查询游标 
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
   
  
  --定义客商替代的详细资料          
  l_ntx_def_kstd  zf_spec.ntx_rcd_defdoc ;  
  
  --定义计数器 
  l_count pls_integer;  
  
  
  --定义被替代的客商凭证行 
  l_nt_voucher_detail_kstd   zf_spec.nt_voucher_detail_s  := zf_spec.nt_voucher_detail_s() ; 
  
  --定义标志变量， 用来说明是否此行需要进行客商替换 
  l_kstd_mark  pls_integer  :=     0 ;  

  begin     
  
    --得到币种的PK
    l_curr_pk  :=  f_curr_pk(p_curr)  ; 

           
  --确定最顶层科目的方向 
   l_rcd_subj :=  p_rcd_subj_info(1)  ; 
  if( p_rcd_subj_info.count =1 ) then  
                   l_cur_super_subj_orient  :=l_rcd_subj.bal_orient  ; 
                
  else 
                  --如果是一级以上科目,人为规定为 0 ,即资产类科目
                    l_cur_super_subj_orient  :=  0  ; 
                   /* l_rcd_subj.subj_code  := p_subj_code ; 
                    l_rcd_subj.subj_name  := p_subj_code ; 
                    l_rcd_subj.subj_dispname  := p_subj_code ; */
  end if; 
    
  
  ---得到客商替代的详细资料 
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
        
        --给客商替代变量赋予初始值 
        l_kstd_mark  := 0  ; 
        
        --进行客商替代 
        p_kstd(l_rcd ,  l_nt_voucher_detail_kstd , l_ntx_def_kstd , l_kstd_mark) ;  
        
        
        --处理没有替代的情况 ，替代的情况，放到循环结束后处理 
        if( l_kstd_mark  =  0  ) then  
             p_nt_voucher_detail_s.extend ; 
             p_nt_voucher_detail_s(p_nt_voucher_detail_s.count)  :=  l_rcd ; 
        end if;  
       
    end loop;
    
    --处理替代的情况 
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
  --不带辅助核算的游标变量  , 对明细科目进行合并 到上一级科目 
  --参数 
      -- 同  f_tb_bal_accur的参数说明

  procedure    p_aux_comm_con_y_bal(p_nt_voucher_detail_s   in out   nocopy zf_spec.nt_voucher_detail_s , 
                       p_end_year         IN varchar2 DEFAULT '2012',
                       p_end_month        IN varchar2 DEFAULT '08',
                       p_unit_code        IN VARCHAR2 DEFAULT '01',
                       p_subj_code        IN VARCHAR2 DEFAULT '100201',
                       p_aux_style      in varchar2 default  '客商' , 
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
  
       --区分计算余额 ,还是计算发生额  
       
       case  upper(p_aux_style)  
       
         --计算客商辅助
          when  '客商'  THEN  
          
             p_aux_comm_con_y_bal_cust(p_nt_voucher_detail_s , p_end_year , 
                        p_end_month,
                        p_unit_code, p_subj_code  ,  p_aux_code , p_aux_name , p_aux_fi_org ,   p_rcd_subj_info ,
                        p_rcd_corp_info , p_curr ,  p_period_length_max , p_accounting )  ; 
                        
          
         --当计算余额     
          else 
          
                           null ;  
            
            
        end case ; 
     
  end ;
  
  
  
  --------------------------------------------------------------------------------------------------------------
  
   --使用场景 :    求每个科目的期初或期末的余额, 不带辅助核算
   --              不带辅助核算的余额的游标变量 ,对科目明细进行汇总 , 
   --              各个明细科目汇总当成一级科目进行计算合计 
   --参数
   --      p_beg_year  开始年
   --      p_end_year  结束年
   --      p_beg_month  开始月份
   --      p_end_month   结束月份
   --      p_unit_code   单位编码
   --      p_subj_code   科目编码
   --      p_aux_style   辅助核算类型
   --      p_aux_code    辅助核算代码
   --      p_aux_name    辅助核算名称
   --      p_accur_bool  是否是求发生额
   --      p_group_name  集团名称
   --      p_consolidate_flag    是否是将下级科目汇总到上级科目中
   --      p_adjust   是否包含调整期 是否包含调整期, Y ,包含, N ,不包含, A 只有调整期
   --      p_special  是否特殊用于,如按月进行汇总
   --      p_rcd_subj_info    类型,科目信息记录, 
   --      p_rcd_corp_info    组织信息记录类型   

  procedure     p_aux_comm_con_n_bal_cust(
                       p_nt_voucher_detail_s   in out   nocopy zf_spec.nt_voucher_detail_s , 
                       p_end_year         IN varchar2 DEFAULT '2012',
                       p_end_month        IN varchar2 DEFAULT '08',
                       p_unit_code        IN VARCHAR2 DEFAULT '01',
                       p_subj_code        IN VARCHAR2 DEFAULT '100201',
                       p_aux_code         IN VARCHAR2 DEFAULT '*',
                       p_aux_name         IN VARCHAR2 DEFAULT '*',   
                       p_aux_fi_org          in  varchar2  ,   --对应财务组织 ,用来筛选内部客商   
                       p_rcd_subj_info    in zf_spec.ntx_rcd_subj_info , 
                       p_rcd_corp_info    in zf_spec.rcd_org_info   ,  
                       p_curr             in varchar2  default 'RMB' ,
                       p_period_length_max  in number default 2 , 
                       p_accounting   in number  default 1 
                   )  
  is
  
  --定义币种主键 
  l_curr_pk    varchar2(20)   ;
  
  --定义最顶端科目的方向 
  l_cur_super_subj_orient    pls_integer  ;  
  
  --定义凭证明细记录变量
  l_rcd  zf_spec.rcd_voucher_detail_s  ; 
  
  --定义科目信息明细记录
  l_rcd_subj  zf_spec.rcd_subj_info  ; 
  
  --定义查询游标 
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
          --用作标识作用 , 当计算科目余额,不按照一级科目进行汇总并客商辅助时 ,说明 记录体中的 subjcode字段 ,是明细科目编码
         --还是客商档案的编码 ,  用作长期股权投资的明细列表时使用  ; 如为 'subjcode' , 则说明是明细科目编码 ,  如果是'cust'  ,  则
      --说明是 客商档案的编码  
                   decode( nvl(g.code , 'subjcode' )   , 'subjcode' , 'subjcode' , 'cust' )   arap_self  ,
          --用来在长期股权投资明细表中进行内部客商的筛选           
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
   
  
  --定义客商替代的详细资料          
  l_ntx_def_kstd  zf_spec.ntx_rcd_defdoc ;  
  
  --定义计数器 
  l_count pls_integer;  
  
  
  --定义被替代的客商凭证行 
  l_nt_voucher_detail_kstd   zf_spec.nt_voucher_detail_s  := zf_spec.nt_voucher_detail_s() ; 
  
  --定义标志变量， 用来说明是否此行需要进行客商替换 
  l_kstd_mark  pls_integer  :=     0 ;  
  
  
  
  begin     
  
    --得到币种的PK
    l_curr_pk  :=  f_curr_pk(p_curr)  ; 

           
  --确定最顶层科目的方向 
   l_rcd_subj :=  p_rcd_subj_info(1)  ; 
   
  if( p_rcd_subj_info.count =1 ) then  
  
                   l_cur_super_subj_orient  :=l_rcd_subj.bal_orient  ; 
                
  else 
                  --如果是一级以上科目,人为规定为 0 ,即资产类科目
                    l_cur_super_subj_orient  :=  0  ; 
  
  end if; 
  
  
   ---得到客商替代的详细资料 
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
        
        --给客商替代变量赋予初始值 
        l_kstd_mark  := 0  ; 
        
        --进行客商替代 
        p_kstd(l_rcd ,  l_nt_voucher_detail_kstd , l_ntx_def_kstd , l_kstd_mark) ;  
        
        
        --处理没有替代的情况 ，替代的情况，放到循环结束后处理 
        if( l_kstd_mark  =  0  ) then  
             p_nt_voucher_detail_s.extend ; 
             p_nt_voucher_detail_s(p_nt_voucher_detail_s.count)  :=  l_rcd ; 
        end if;  
        
    
       
    end loop;
    
    --处理替代的情况 
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
  --不带辅助核算的游标变量  , 对明细科目进行合并 到上一级科目 
  --参数 
      -- 同  f_tb_bal_accur的参数说明

  procedure     p_aux_comm_con_n_bal(p_nt_voucher_detail_s   in out   nocopy zf_spec.nt_voucher_detail_s , 
                       p_end_year         IN varchar2 DEFAULT '2012',
                       p_end_month        IN varchar2 DEFAULT '08',
                       p_unit_code        IN VARCHAR2 DEFAULT '01',
                       p_subj_code        IN VARCHAR2 DEFAULT '100201',
                       p_aux_style      in varchar2 default  '客商' , 
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
  
       --区分计算余额 ,还是计算发生额  
       
       case  upper(p_aux_style)  
       
         --计算客商辅助
          when  '客商'  THEN  
          
              p_aux_comm_con_n_bal_cust(p_nt_voucher_detail_s , p_end_year , 
                        p_end_month,
                        p_unit_code, p_subj_code  ,  p_aux_code , p_aux_name , p_aux_fi_org ,   p_rcd_subj_info ,
                        p_rcd_corp_info , p_curr ,  p_period_length_max , p_accounting )  ; 
                        
          
         --当计算余额     
          else 
          
                           null ;  
            
            
        end case ; 
     
  end ;
  
  
  
  -----------------------------------------------------------------------------------------------------------
  
  --不带辅助核算的游标变量  , 对明细科目进行合并 到上一级科目 
  --参数 
      -- 同  f_tb_bal_accur的参数说明

  procedure    p_aux_comm_con_n(p_nt_voucher_detail_s   in out   nocopy zf_spec.nt_voucher_detail_s , 
                      p_beg_year         IN varchar2 DEFAULT '2012',
                       p_end_year         IN varchar2 DEFAULT '2012',
                       p_beg_month        IN varchar2 DEFAULT '01',
                       p_end_month        IN varchar2 DEFAULT '08',
                       p_unit_code        IN VARCHAR2 DEFAULT '01',
                       p_subj_code        IN VARCHAR2 DEFAULT '100201',
                       p_aux_style      in varchar2 default  '客商' , 
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
  
       --区分计算余额 ,还是计算发生额  
       
       case  upper(p_accur_bool)  
       
         --当计算发生额  和 净发生额  
          when  'Y' THEN  
          
             ----暂测试用
            
              if(  p_beg_year = p_beg_month) then  
              
                     null ; 
              
              end if; 
            
              null;  
              
         --当计算余额     
          else 
          
             p_aux_comm_con_n_bal(p_nt_voucher_detail_s , p_end_year , p_end_month,
                        p_unit_code, p_subj_code  ,  p_aux_style, p_aux_code ,p_aux_name, p_aux_fi_org  , 
                        p_rcd_subj_info , p_rcd_corp_info , p_curr ,  p_period_length_max , p_accounting )  ; 
            
        end case ; 
     
  end ;
  
  
  
  
  
  
  ------------------------------------------------------------------------------------------------------------------------

  
  --不带辅助核算的游标变量  , 对明细科目进行合并 到上一级科目 
  --参数 
      -- 同  f_tb_bal_accur的参数说明

  procedure    p_aux_comm_con_y(p_nt_voucher_detail_s   in out   nocopy zf_spec.nt_voucher_detail_s , 
                      p_beg_year         IN varchar2 DEFAULT '2012',
                       p_end_year         IN varchar2 DEFAULT '2012',
                       p_beg_month        IN varchar2 DEFAULT '01',
                       p_end_month        IN varchar2 DEFAULT '08',
                       p_unit_code        IN VARCHAR2 DEFAULT '01',
                       p_subj_code        IN VARCHAR2 DEFAULT '100201',
                       p_aux_style      in varchar2 default  '客商' , 
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
  
       --区分计算余额 ,还是计算发生额  
       
       case  upper(p_accur_bool)  
       
         --当计算发生额  和 净发生额  
          when  'Y' THEN  
          
             ----暂测试用
            if( p_beg_year  = p_beg_month) then 
            
                 null ;  
                 
             end if;
            
           null ;
           
         --当计算余额     
          else 
          
             p_aux_comm_con_y_bal(p_nt_voucher_detail_s , p_end_year , p_end_month,
                        p_unit_code, p_subj_code  ,  p_aux_style, p_aux_code ,p_aux_name, p_aux_fi_org  , 
                        p_rcd_subj_info , p_rcd_corp_info , p_curr ,  p_period_length_max , p_accounting )  ; 
            
        end case ; 
     
  end ;
  
  
  
  ----------------------------------------------------------------
  --得到不 带辅助核算的余额表的游标  , 普通业务 
  --参数 
  --参见  f_bal_accur; 
   procedure    p_aux_comm( p_nt_voucher_detail_s   in out   nocopy zf_spec.nt_voucher_detail_s , 
                       p_beg_year         IN varchar2 DEFAULT '2014',
                       p_end_year         IN varchar2 DEFAULT '2014',
                       p_beg_month        IN varchar2 DEFAULT '01',
                       p_end_month        IN varchar2 DEFAULT '02',
                       p_unit_code        IN VARCHAR2 DEFAULT '01',
                       p_subj_code        IN VARCHAR2 DEFAULT '100201',
                       p_aux_style      in varchar2 default  '客商' , 
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
     
     ----对明细科目,汇总到上一级科目
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
  --得到 不带辅助核算的余额表的游标 
  --参数 
  --参见  f_bal_accur; 
   procedure     p_aux( 
                       p_nt_voucher_detail_s   in out   nocopy zf_spec.nt_voucher_detail_s , 
                       p_beg_year         IN varchar2 DEFAULT '2014',
                       p_end_year         IN varchar2 DEFAULT '2014',
                       p_beg_month        IN varchar2 DEFAULT '01',
                       p_end_month        IN varchar2 DEFAULT '02',
                       p_unit_code        IN VARCHAR2 DEFAULT '01',
                       p_subj_code        IN VARCHAR2 DEFAULT '100201',
                        p_aux_style        in VARCHAR2 default  '客商', 
                       p_aux_code         in varchar2 default  '*' , 
                       p_aux_name         in varchar2 default  '*' , 
                       p_aux_fi_org       in varchar2  default  '~'   ,    --筛选内部客商  
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
    
    --根据P_SPECIAL参数进行判断  , 分别走何种业务 
    
    case upper(p_special ) 
    
       --当需要按月和年进行汇总  
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
   --使用场景 :    求每个科目的期初或期末的余额，或发生额 
   --参数
   --      p_beg_year  开始年
   --      p_end_year  结束年
   --      p_beg_month  开始月份
   --      p_end_month   结束月份
   --      p_unit_code   单位编码
   --      p_subj_code   科目编码
   --      p_aux_style   辅助核算类型
   --      p_aux_code    辅助核算代码
   --      p_aux_name    辅助核算名称
   --      p_accur_bool  是否是求发生额
   --      p_group_name  集团名称
   --      p_consolidate_flag    是否是将下级科目汇总到上级科目中
   --      p_adjust   是否包含调整期 是否包含调整期, Y ,包含, N ,不包含, A 只有调整期
   --      p_special  是否特殊用于,如用于I3_05,按月进行汇总
   --      p_rcd_subj_info    类型,科目信息记录, 
   --      p_rcd_corp_info    组织信息记录类型   
   --       p_subjcode_regexp               in varchar2  default  'Y' ,    --科目代码的检索是否用正则表达式
  function f_bal_accur_ex(p_beg_year         IN varchar2 DEFAULT '2014',
                       p_end_year         IN varchar2 DEFAULT '2014',
                       p_beg_month        IN varchar2 DEFAULT '01',
                       p_end_month        IN varchar2 DEFAULT '02',
                       p_unit_code        IN VARCHAR2 DEFAULT '01',
                       p_subj_code        IN VARCHAR2 DEFAULT '100201',
                       p_aux_style        IN VARCHAR2 DEFAULT null,
                       p_aux_code         IN VARCHAR2 DEFAULT '*',
                       p_aux_name         IN VARCHAR2 DEFAULT '*',
                       p_aux_fi_org      in varchar2 default  '~'  ,    --筛选内部客商用
                       p_accur_bool       in varchar2 default 'Y',
                       p_adjust           in varchar2 default 'Y' , 
                       p_consolidate_flag in varchar2 default 'Y' , 
                       p_special          in varchar2 default NULL , 
                       p_curr             in varchar2 default 'BWB',
                       p_accounting       in varchar2 default 'Y' , 
                       p_chart_system   in varchar2  default  '0004' ,   --科目体系编码
                       p_subjcode_regexp               in varchar2  default  'Y' ,    --科目代码的检索是否用正则表达式
                       p_group            in varchar2 default zf_spec.GROUP_ORG_PK )
    RETURN zf_spec.nt_voucher_detail_s 
    pipelined 
    is
    
    ---定义会计月份字段应该的长度,用于游标查询餐参数,判断是否包含调整期
  l_period_length_max  pls_integer  default  3 ;
  
  --定义是否包含未记账标识 
  l_accounting     pls_integer  default  1  ;   
  
    --定义嵌套表变量,嵌套表记录的变量, 作为返回值; 嵌套表的行计数器
 
    l_tbl   zf_spec.nt_voucher_detail_s := zf_spec.nt_voucher_detail_s();
    
    --定义单位和账簿及科目信息的记录变量,在查询中作为WHERE条件使用

    l_rcd_corp_info    zf_spec.rcd_org_info ; 
    l_ntx_rcd_subj_info  zf_spec.ntx_rcd_subj_info ; 
    
 
    ----定义科目查询字符串的相关处理变量  
    
    l_subjcode_para   bd_account.code%type ; 
    
    begin  
      
    
    
    --确定是否包含未记账的参数 
    if( upper(p_accounting) = 'Y')  then  l_accounting  := 1   ;  else  l_accounting := 2  ;  end if; 
    
    --确定是否包含调整期的参数
    
    if( upper(p_adjust) =  'Y')  then  l_period_length_max := 3  ; else   l_period_length_max := 2  ; end if; 
    
        
     --获取账簿和科目信息
     
     l_rcd_corp_info  := f_org_info(p_unit_code ,p_group ) ; 

      
     if   ( not regexp_like( l_rcd_corp_info.accsystem_code ,p_chart_system  )    )then
     
                 return ; 
      
     end if;
     
     --得到科目的具体信息 
     if( upper(p_subjcode_regexp) = 'Y' ) then 
     
            
     
             l_ntx_rcd_subj_info  := f_subj_info_multi(P_SUBJ_CODE , l_rcd_corp_info.org_code ,  l_rcd_corp_info.pk_group) ;      
     
            
             l_subjcode_para  :=  p_subj_code ;  
     
     else 
              
             
              
             l_ntx_rcd_subj_info  := f_subj_info_single(P_SUBJ_CODE , l_rcd_corp_info.org_code ,  l_rcd_corp_info.pk_group) ; 
       
            
             l_subjcode_para  :=   '^(' || p_subj_code  ||  ')' ; 
    
     end if; 
     
    
   
    
         
                    --判断参数的值,是否带辅助核算,然后走不同的流程 
    
                    case  
                    
                      when ( p_aux_style is null )  then 
                        
                        --不带辅助核算  
                        
                        p_comm(l_tbl , p_beg_year ,
                        p_end_year , p_beg_month , p_end_month ,p_unit_code, 
                        l_subjcode_para , p_accur_bool   ,p_consolidate_flag , 
                        p_special ,l_ntx_rcd_subj_info,l_rcd_corp_info , p_curr, 
                        l_period_length_max ,    l_accounting  )  ; 
                        
                        
                        
                        ---处理带辅助核算的情况
                      
                      else
                        
                    p_aux(l_tbl , p_beg_year ,
                        p_end_year , p_beg_month , p_end_month ,p_unit_code, 
                        l_subjcode_para ,p_aux_style , p_aux_code ,p_aux_name, p_aux_fi_org , 
                         p_accur_bool   ,p_consolidate_flag , 
                        p_special ,l_ntx_rcd_subj_info,l_rcd_corp_info , p_curr, 
                        l_period_length_max ,    l_accounting  )  ; 
                        
                  
                     
                    end case ; 
                
  
  
    --取出查询结果,并通过管道送出

    for i in 1  ..  l_tbl.count   loop
	        pipe row(l_tbl(i)) ; 
    end loop;

  
  
    return ;
 
 
 end ; 
 
 
 
 
 ---------------------------------------------------------------------------------
   --使用场景 :  对客商辅助核算的科目余额进行重分类 , 用在资产负债表中
   --参数
   --      p_end_year  结束年
   --      p_end_month   结束月份
   --      p_unit_code   单位编码
   --      p_subj_code   科目编码
   --      p_consolidate_flag    是否是将下级科目汇总到上级科目中
   --      p_adjust   是否包含调整期 是否包含调整期, Y ,包含, N ,不包含, A 只有调整期

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
    
    --定义函数返回值
    l_number  gl_detail.localcreditamount%type  := 0 ;
    
    --定义变量,存放单位基本信息
    l_rcd_org_info  zf_spec.rcd_org_info ; 
    
    --定义计算重分类余额的查询游标
    
    --正数的查询 
    cursor  l_cur_positive(p_cur_subjcode  varchar2 )   is 
    select  NVL(sum(bal),0) bal  from table(f_bal_accur_ex(p_end_year , p_end_year , 
    p_end_month , p_end_month ,p_unit_code ,  p_cur_subjcode,  '客商' ,
    '*' , '*' , '*', 'N' , p_adjust ,p_consolidate_flag ,NULL,p_curr, p_accounting,'*' , 'N')) 
    where  bal >= 0   ;
    
    --负数的查询 
    cursor  l_cur_negative(p_cur_subjcode  varchar2 )   is 
    select  -NVL(sum(bal),0) bal  from table(f_bal_accur_ex(p_end_year , p_end_year , 
    p_end_month , p_end_month ,p_unit_code ,  p_cur_subjcode,  '客商' ,
    '*' , '*' , '*','N' , p_adjust ,p_consolidate_flag ,NULL,p_curr, p_accounting , '*' ,'N')) 
    where  bal < 0   ;
    
    
    --不要重分类的查询 
    cursor  l_cur_all(p_cur_subjcode  varchar2 )   is 
    select  NVL(sum(bal),0) bal  from table(f_bal_accur_ex(p_end_year , p_end_year , 
    p_end_month , p_end_month ,p_unit_code ,  p_cur_subjcode,  '客商' ,
    '*' , '*' , '*','N' , p_adjust ,p_consolidate_flag ,NULL,p_curr, p_accounting , '*' , 'N'))  ; 
    
    begin 
      
      --对返回值进行初始化
      l_number  := 0 ; 
    
      --获取科目体系PK
      l_rcd_org_info   :=   f_org_info(p_unit_code) ; 
      
      ---遍历重分类规则的联合数组
          
      
      for rcd in 1 ..  v_nt_arap_reclass_rule.count   loop  
        
         --如果参数 p_arap_item 与 联合数组中的记录的 arap 值相同 , 且
         --科目体系结构一致,则进行查询得到科目余额
        
        if (upper(v_nt_arap_reclass_rule(rcd).arap) =  upper(p_arap_item) )  
           and (v_nt_arap_reclass_rule(rcd).acccsystem_code = 
           l_rcd_org_info.accsystem_code)  then 
                
                      --处理余额为正数的科目
                      case v_nt_arap_reclass_rule(rcd).the_sign  
                        
                      when  '+'    then 
                          
                         for  i  in  l_cur_positive(v_nt_arap_reclass_rule(rcd).subj) loop
                               
                             l_number  :=  l_number +  i.bal ; 
                         
                         end loop ; 
                       
                       --处理余额为负数的科目  
                       when  '-'   then 
                       
                          
                           for  i  in  l_cur_negative(v_nt_arap_reclass_rule(rcd).subj) loop
                               
                             l_number  :=  l_number +  i.bal ; 
                         
                           end loop ; 
                           
                           
                        ---处理不重分类的情况 
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
    
    
    --处理异常
    exception  
      
    when others  then 
      
      ---关闭游标 
       if(l_cur_positive%isopen) then  
       
            close l_cur_positive ; 
       end if; 
       
        if(l_cur_negative%isopen) then  
       
            close l_cur_negative ; 
       end if; 
       
       return 0  ;
    
    end ; 
 
 
 ---------------------------------------------------------------------------------
   --使用场景 :  对客商辅助核算的科目余额进行重分类列式,从格式需要行列转换后,才能用到债权债务明细表中
   --参数
   --      p_end_year  结束年
   --      p_end_month   结束月份
   --      p_unit_code   单位编码
   --      p_subj_code   科目编码
   --      p_consolidate_flag    是否是将下级科目汇总到上级科目中
   --      p_adjust   是否包含调整期 是否包含调整期, Y ,包含, N ,不包含, A 只有调整期

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
    
    --定义凭证明细表
    l_tbl   zf_spec.nt_voucher_detail_s  :=  zf_spec.nt_voucher_detail_s();         --用于返回值
    l_tbl_tmp   zf_spec.nt_voucher_detail_s  :=  zf_spec.nt_voucher_detail_s();   --用于中间结果的保存
    l_tbl_init   zf_spec.nt_voucher_detail_s := zf_spec.nt_voucher_detail_s() ;  --嵌套表初始化
    --定义变量,存放单位基本信息
    l_rcd_org_info  zf_spec.rcd_org_info ; 
    
    --定义科目参数变量 
    l_subj_code_para   bd_account.code%type ; 
    
    --定义科目详细信息变量
    l_tbl_subj     zf_spec.ntx_rcd_subj_info    ; 
    
    --定义是否包含未记账平整的参数变量 
    l_accounting  pls_integer;  
    
    --定义是否包含调整期的参数变量 
    l_period_length_max   pls_integer ; 
    
    begin 
      
    --确定是否包含未记账的参数 
    if( upper(p_accounting) = 'Y')  then  l_accounting  := 1   ;  else  l_accounting := 2  ;  end if; 
    
    --确定是否包含调整期的参数
    
    if( upper(p_adjust) =  'Y')  then  l_period_length_max := 3  ; else   l_period_length_max := 2  ; end if; 
    
    
      --获取科目体系PK
      l_rcd_org_info   :=   f_org_info(p_unit_code) ; 
      
      ---遍历重分类规则的联合数组
          
      
     for rcd in 1 ..  v_nt_arap_reclass_rule.count   loop  
        

        if (v_nt_arap_reclass_rule(rcd).acccsystem_code =  l_rcd_org_info.accsystem_code)  then 
            
                --删除嵌套表表中的内容
                --l_tbl_tmp.delete ;
                l_tbl_tmp  := l_tbl_init  ;
                
                
                --获取科目的编码 ( 查询用 )
                l_subj_code_para :=  '^('||v_nt_arap_reclass_rule(rcd).subj||')'  ; 
                
                --获取科目的详细信息
                l_tbl_subj(1)  :=  f_subj_info_single(v_nt_arap_reclass_rule(rcd).subj,p_unit_code)(1) ; 
                
                --调用 p_aux_comm_con_y_bal_cust获取嵌套表内容'
                 
                p_aux_comm(l_tbl_tmp,p_end_year, p_end_year, p_end_month , p_end_month,p_unit_code ,
                l_subj_code_para, '客商' , '*','*','*' ,'N' , p_consolidate,  l_tbl_subj ,l_rcd_org_info,'BWB' , 
                l_period_length_max , l_accounting) ; 
             
              --遍历 l_tbl_tmp  把临时嵌套表中的数据 放入正式嵌套表中
               case   v_nt_arap_reclass_rule(rcd).the_sign 
                 
                     when  '+' then   
                     
                      ---取正数 
                      
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

                      ---取 负数  
                      
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
                        
                      --处理不需要重分类的情况 
                        
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
     
     
     ---嵌套表通过 管道流出 
     for i in 1.. l_tbl.count  loop
       
          pipe row (l_tbl(i) ) ; 
	
      end loop;

     return ; 

    end ; 
 
 
 
  --使用场景 :  对客商辅助核算的科目余额进行重分类列示,用在债权债务明细表中
   --参数
   --      p_end_year  结束年
   --      p_end_month   结束月份
   --      p_unit_code   单位编码
   --      p_subj_code   科目编码
   --      p_consolidate_flag    是否是将下级科目汇总到上级科目中
   --      p_adjust   是否包含调整期 是否包含调整期, Y ,包含, N ,不包含, A 只有调整期

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

    --定义游标变量
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
    
    --定义返回值的嵌套表变量和
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
 
 
 ------------对往来科目的重分类标准进行初始化 
 procedure  p_init_reclass_rule
 is
 --定义查询游标,加载ARAP重分类标准
 cursor  l_cur  is
 select substr(a.code , 1, 2) arap  ,  
 substr(a.name , 1,4) subj  ,a.shortname the_sign , substr(a.memo, 1,4)  acccsystem_code  ,
 substr(a.memo, 6,4)  name_cn 
 from bd_defdoc a 
 where a.pk_defdoclist = (SELECT  a.pk_defdoclist  from  bd_defdoclist a
 where a.code = zf_spec.ARAP_RECLASS_RULE_NAME   )   ; 
 
---查询所有ARAP变量项目
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
   --使用场景 :    求制定科目的期初或期末的余额，或发生额 
   --参数
   --      p_beg_year  开始年
   --      p_end_year  结束年
   --      p_beg_month  开始月份
   --      p_end_month   结束月份
   --      p_unit_code   单位编码
   --      p_subj_code   科目编码
   --      p_aux_style   辅助核算类型
   --      p_aux_code    辅助核算代码
   --      p_aux_name    辅助核算名称
   --      p_accur_bool  是否是求发生额
   --      p_group_name  集团名称
   --      p_consolidate_flag    是否是将下级科目汇总到上级科目中
   --      p_adjust   是否包含调整期 是否包含调整期, Y ,包含, N ,不包含, A 只有调整期
   --      p_special  是否特殊用于,如用于I3_05,按月进行汇总
   --      p_curr         币种    'BWB' ,
   --      p_accounting     是否包含已经记账
   --      p_dir    方向 ,如果是求发生额  , 则制定求发生额的方向
   --使用者 :    IUFO报表中,计算科目余额或发生额使用
   --作者 :    bieyifeng
   --时间  :   20140428
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
                                p_chart_system   in varchar2  default  '0004' ,  --科目体系编码  
                                p_subjcode_regexp               in varchar2  default  'Y'     --科目代码的检索是否用正则表达式
                                )
  return number  
  is
  

  --定义函数的返回值
  l_number  gl_detail.localcreditamount%type  := 0 ;

  --定义查询游标
  cursor l_cur  is
       select  bal_dir , sum(bal)  bal , sum(bal_ori) bal_ori , sum(localdebitamount)   localdebitamount , 
       sum(localcreditamount) localcreditamount , sum(debitamount) debitamount, sum(creditamount) creditamount 
       from  table(f_bal_accur_ex(p_beg_year ,  p_end_year  ,p_beg_month , p_end_month ,  p_unit_code , p_subj_code , 
       null, null, null, null, p_accur_bool  , 
        p_adjust  ,'Y' , NULL , p_curr , p_accounting ,p_chart_system, p_subjcode_regexp   ) )   group by  bal_dir  ; 
  
  --游标行记录变量 
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
        
      --确定函数的返回值
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
--使用场景 : 到的需要计算报表的版本号码
function  f_invest_nt_orgtd 
return zf_spec.ntx_rcd_defdoc_hb_org 
is

l_ntx_rcd_defdoc    zf_spec.ntx_rcd_defdoc_hb_org ; 



/*--根据合并任务代码 ,得到合并报表版本号
cursor l_cur(p_task_name varchar2) is 
select version from  iufo_hbscheme  
where  iufo_hbscheme.dr = 0 and  iufo_hbscheme.name= p_task_name   ; */

--定义从自自定义项目中取值函数 
cursor  l_cur_def_orgtd  is 
           select substr(a.code , 1, instr(a.code , '_')-1)  invested_code  ,   
           substr(a.name , 1 ,  instr(a.name, '_' )-1)  supper_code  , 
           a.shortname    task_name  
           from bd_defdoc a 
           where a.pk_defdoclist = (SELECT  a.pk_defdoclist  from  bd_defdoclist a
           where a.code = zf_spec.V_IUFO_CONSDT_NAMETRANS )  ;  

---定义计数器
l_counter  pls_integer;  

begin 
  
  --获取转换表的内容 
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
   --使用场景 :    被 f_invest_nt调用 ,  用来从NC账上取数， 生成投资收益发生额 
   --参数
   --      p_tbl  长期股权投资明细记录数据
   --      p_end_year  结束年
   --      p_end_month   结束月份
   --      p_unit_code   单位编码
   --      p_adjust   是否包含调整期 是否包含调整期 , Y ,包含, N ,不包含, A 只有调整期
   
   
   ---注意 ：    自定义项目备注的含义  
                 --  A  表示明细科目转换成客商编码
                 --  B  同一客商名称，非内部客商编码转换成内部客商编码
                 --  X  不能使用此标记 
                 
   procedure   p_invest_nt_self_rev(p_tbl     in out  zf_spec.nt_rcd_invest_detail  , 
                       p_end_year         IN varchar2 DEFAULT '2014',
                       p_end_month        IN varchar2 DEFAULT '02',
                       p_unit_code        IN VARCHAR2 DEFAULT '01',
                       p_adjust           in varchar2 default 'Y' ,  
                       p_accounting       in varchar2 default 'Y'  )
    is
       ---定义会计月份字段应该的长度 ,用于游标查询餐参数,判断是否包含调整期
  l_period_length_max  pls_integer  default  3 ;
  
  --定义是否包含未记账标识 
  l_accounting     pls_integer  default  1  ;   
  
    --定义嵌套表变量 ,记录凭证明细 ;
 
    l_tbl   zf_spec.nt_voucher_detail_s := zf_spec.nt_voucher_detail_s();
     
    
    --定义单位和账簿及科目信息的记录变量,在查询中作为 WHERE条件使用

    l_rcd_org_info    zf_spec.rcd_org_info ; 
    l_tbl_subj  zf_spec.ntx_rcd_subj_info ; 
    
    --定义科目检索字符串
    l_subj_code_para   varchar2(200) ; 
    
    --定义长期股权投资明细科目对应内部单位编码的 自定义项目联合数组变量 
    --l_ntx_defdoc    zf_spec.ntx_rcd_defdoc ;  
    
    
    --定义一个临时变量,用作IF判断只用  
    --l_tmp_mark   pls_integer ;  
    
    begin  
      
            --确定是否包含未记账的参数 
          if( upper(p_accounting) = 'Y')  then  l_accounting  := 1   ;  else  l_accounting := 2  ;  end if; 
          
          --确定是否包含调整期的参数
          
          if( upper(p_adjust) =  'Y')  then  l_period_length_max := 3  ; else   l_period_length_max := 2  ; end if; 
          
          
            --获取科目体系PK
            l_rcd_org_info   :=  f_org_info(p_unit_code) ; 
            
            
           --获取长期股权投资明细科目对应内部单位编码的 自定义项目联合数组变量 的值  
            --l_ntx_defdoc   :=    f_invest_nt_inter_unitcode; 
              
            --获取科目的编码 ( 查询用 )
            case   l_rcd_org_info.accsystem_code 
               
                    when  '0005' then       
                  
                      l_subj_code_para :=  '5201'  ; 
                      
                    when  '0004' then 
                      
                      l_subj_code_para :=  '6111'  ; 
                      
                    else 
                       
                       l_subj_code_para :=  'aaaaaaaa'  ;  
                       
             end case ; 
                      
                     
             l_tbl_subj  :=  f_subj_info_single(l_subj_code_para,p_unit_code)  ; 
                      
             --调用 p_aux_comm获取嵌套表内容 '    
                       
             p_aux_comm(l_tbl,p_end_year, p_end_year, p_end_month , 
                        p_end_month,p_unit_code ,
                      '^(' || l_subj_code_para  ||  ')', '客商' ,
                       '*','*','*' ,'N' , 'Y',  l_tbl_subj ,
                      l_rcd_org_info,'BWB' , 
                      l_period_length_max , l_accounting) ; 
               
            --对嵌套表的内容 ,通过管道进行输出
             
             for i in 1..  l_tbl.count  loop
             
                     p_tbl.extend ; 
                                 
                     ---永远是当前日期
                     p_tbl(p_tbl.count).curr_date  :=   p_end_year || p_end_month ; 
                     p_tbl(p_tbl.count).unit_code  := l_tbl(i).org_code ; 
                     p_tbl(p_tbl.count).tzsy_bq    := l_tbl(i).localcreditamount ; 
                     p_tbl(p_tbl.count).value_code    := l_tbl(i).value_code ; 
                     p_tbl(p_tbl.count).value_name    := l_tbl(i).value_name ; 
                     
                     --每期的日期，如果求1~当前日期的话
                     p_tbl(p_tbl.count).the_date    :=  p_end_year || p_end_month ;  
                                             
                      
                         
             end loop;
           
         
      end ; 
    





   ---------------------------------------------------------------------------------
   --使用场景 :    被 f_invest_nt调用 ,  用来从NC账上取数， 生成 长期股权投资的账面余额数据 
   --参数
   --      p_tbl  长期股权投资明细记录数据
   --      p_end_year  结束年
   --      p_end_month   结束月份
   --      p_unit_code   单位编码
   --      p_adjust   是否包含调整期 是否包含调整期 , Y ,包含, N ,不包含, A 只有调整期
   
   
   ---注意 ：    自定义项目备注的含义  
                 --  A  表示明细科目转换成客商编码
                 --  B  同一客商名称，非内部客商编码转换成内部客商编码
                 --  X  不能使用此标记 
                 
   procedure   p_invest_nt_self(p_tbl     in out  zf_spec.nt_rcd_invest_detail  , 
                       p_end_year         IN varchar2 DEFAULT '2014',
                       p_end_month        IN varchar2 DEFAULT '02',
                       p_unit_code        IN VARCHAR2 DEFAULT '01',
                       p_adjust           in varchar2 default 'Y' ,  
                       p_accounting       in varchar2 default 'Y'  )
    is
       ---定义会计月份字段应该的长度 ,用于游标查询餐参数,判断是否包含调整期
  l_period_length_max  pls_integer  default  3 ;
  
  --定义是否包含未记账标识 
  l_accounting     pls_integer  default  1  ;   
  
    --定义嵌套表变量 ,记录凭证明细 ;
 
    l_tbl   zf_spec.nt_voucher_detail_s := zf_spec.nt_voucher_detail_s();
     
    
    --定义单位和账簿及科目信息的记录变量,在查询中作为 WHERE条件使用

    l_rcd_org_info    zf_spec.rcd_org_info ; 
    l_tbl_subj  zf_spec.ntx_rcd_subj_info ; 
    
    --定义科目检索字符串
    l_subj_code_para   varchar2(200) ; 
    
    --定义长期股权投资明细科目对应内部单位编码的 自定义项目联合数组变量 
    --l_ntx_defdoc    zf_spec.ntx_rcd_defdoc ;  
    
    
    --定义一个临时变量,用作IF判断只用  
    --l_tmp_mark   pls_integer ;  
    
    begin  
      
            --确定是否包含未记账的参数 
          if( upper(p_accounting) = 'Y')  then  l_accounting  := 1   ;  else  l_accounting := 2  ;  end if; 
          
          --确定是否包含调整期的参数
          
          if( upper(p_adjust) =  'Y')  then  l_period_length_max := 3  ; else   l_period_length_max := 2  ; end if; 
          
          
            --获取科目体系PK
            l_rcd_org_info   :=  f_org_info(p_unit_code) ; 
            
            
           --获取长期股权投资明细科目对应内部单位编码的 自定义项目联合数组变量 的值  
            --l_ntx_defdoc   :=    f_invest_nt_inter_unitcode; 
              
            --获取科目的编码 ( 查询用 )
            case   l_rcd_org_info.accsystem_code 
               
                    when  '0005' then       
                  
                      l_subj_code_para :=  '1401'  ; 
                      
                    when  '0004' then 
                      
                      l_subj_code_para :=  '1511'  ; 
                      
                    else 
                       
                       l_subj_code_para :=  'aaaaaaaa'  ;  
                       
             end case ; 
                      
                     
             l_tbl_subj  :=  f_subj_info_single(l_subj_code_para,p_unit_code)  ; 
                      
             --调用 p_aux_comm获取嵌套表内容 '    
                       
             p_aux_comm(l_tbl,p_end_year, p_end_year, p_end_month , 
                        p_end_month,p_unit_code ,
                      '^(' || l_subj_code_para  ||  ')', '客商' ,
                       '*','*','*' ,'N' , 'Y',  l_tbl_subj ,
                      l_rcd_org_info,'BWB' , 
                      l_period_length_max , l_accounting) ; 
               
            --对嵌套表的内容 ,通过管道进行输出
             
             for i in 1..  l_tbl.count  loop
             
                     p_tbl.extend ; 
                     
                     ---永远是当前日期
                     p_tbl(p_tbl.count).curr_date  :=   p_end_year || p_end_month ; 
                     p_tbl(p_tbl.count).unit_code    := l_tbl(i).org_code ; 
                     p_tbl(p_tbl.count).invest_bal    := l_tbl(i).bal ; 
                     p_tbl(p_tbl.count).value_code    := l_tbl(i).value_code ; 
                     p_tbl(p_tbl.count).value_name    := l_tbl(i).value_name ; 
                     
                     --每期的日期，如果求1~当前日期的话
                     p_tbl(p_tbl.count).the_date    :=  p_end_year || p_end_month ;  
                                             
                      
                         
             end loop;
           
         
      end ; 
    
 

----------------------------------------------------------------------------
--使用场景: 得到指定投资单位的投资单位( 子公司 ) 列表 
--参数    p_investor     投资方单位编码
--        p_nt_invest_detail   投资明细表嵌套表 
 

procedure  p_get_investee(p_investor  varchar2  ,   
                          p_nt_invest_detail  in out  zf_spec.nt_rcd_invest_detail)
is

--游标 , 得到被投资单位列表  
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


--定义组织替代变量
l_ntx_rcd_defdoc    zf_spec.ntx_rcd_defdoc_hb_org ;

begin 
  
   --得到组织替代变量 
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


 
--使用场景 : 得到投资数据 

procedure  p_get_invest_info( p_rcd_invest_info  in out   zf_spec.rcd_invest_info , 
                              p_investor  varchar2 , p_investee varchar2  )
is

--定义查询游标
cursor  l_cur_invest(p_curr_investor  varchar2 , p_curr_investee varchar2)  is 

--得到原数据
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
--进行汇总,对相同投资日期的数据 , 进行加总 
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

--对加总的结果进行排序 
select invest_org_pk , invest_org_code , invest_org_name , 
invested_org_pk , invested_org_code , invested_org_name , 
invest_date ,invest_rate
from cur_group 
order by  invest_org_pk , invest_org_code , invest_org_name , 
invested_org_pk , invested_org_code , invested_org_name , 
invest_date  ; 


--定义投资比例数据记录变量 
l_ntx_invest_rate    zf_spec.ntx_rcd_invest_rate ; 

--定义计数器变量
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
            
            --把投资单位和被投资单位的信息 写入PLSQL 数组 
            p_rcd_invest_info.invest_org_pk  :=i.invest_org_pk ;
            p_rcd_invest_info.invest_org_code :=i.invest_org_code ;
            p_rcd_invest_info.invest_org_name :=i.invest_org_name ;
            p_rcd_invest_info.invested_org_pk :=i.invested_org_pk ;
            p_rcd_invest_info.invested_org_code :=i.invested_org_code ;
            p_rcd_invest_info.invested_org_name := i.invested_org_name ;
            p_rcd_invest_info.accu_invest_rate := l_ntx_invest_rate(l_count).accu_invest_rate  ;
            
            
            end if; 
            
            
            if(l_count >1) then 
             
                  --计算累计投资比例 
                  l_ntx_invest_rate(l_count).accu_invest_rate := 
                  l_ntx_invest_rate(l_count-1).accu_invest_rate + 
                  l_ntx_invest_rate(l_count).invest_rate  ; 
                  
                  p_rcd_invest_info.accu_invest_rate := 
                  l_ntx_invest_rate(l_count).accu_invest_rate ;
                  
                  
                  --得到上一条投资记录的结束日期
                  l_ntx_invest_rate(l_count-1).end_date := 
                  to_char(to_number(l_ntx_invest_rate(l_count).beg_date) -1 ); 
            
            end if; 
	
    end loop;
  
    --把投资比例数组放到投资记录中
    p_rcd_invest_info.v_ntx_rcd_invest_rate  := l_ntx_invest_rate ; 

end ; 


---------------------------------------------------------------------------
--使用场景 :   得到长期股权投资明细表中的以前年度调整数据
--参数 :  
--         p_investor     投资方
--         p_investee     被投资方
--         p_fi_date      计算年和月份     ,如   201405
procedure p_get_invest_lst_info( p_rcd   in  out  zf_spec.rcd_invest_detail )

is

--定义反映上年 12月31日的变量
l_lst_fi_date   varchar2(10) ; 
 

--投资单位和被投资单位的 PK
l_investor_pk  iufo_keydetail_unit.keyval%type  ; 
l_investee_pk  iufo_keydetail_unit.keyval%type ;  
 


---根据单位编码 , 获取单位 keyval 值 
cursor l_cur_unit_pk(p_cur_unit_code varchar2)
is
select s.keyval   from  iufo_keydetail_unit s 
where s.code = p_cur_unit_code ; 


--使用场景 : 查询成本法转权益法上年所有者权益变动累计金额  
--参数 : 
--               p_cur_investor varchar2  投资单位 PK , 
--               p_cur_investee  varchar2 被投资单位 PK  ,  
--               p_fi_date varchar2       查询日期 , 
--               p_verson  pls_integer    版本   

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
   
   
   
      ---确定去年12月31日的日期 
         
   l_lst_fi_date  := to_char( to_number( substr(p_rcd.curr_date , 1, 4) ) -1 )  ||'-12-31'; 
    

   
   --获得投资单位和被投资的单位的 UNIT_PK 
   
    
   for i in l_cur_unit_pk(p_rcd.unit_code) loop
         
         --投资单位 PK 
         
         l_investor_pk := i.keyval ; 
         
	
   end loop;
   
   for i in l_cur_unit_pk(p_rcd.value_code) loop
         
         --被投资单位的 PK 
        
         l_investee_pk := i.keyval ; 
         
	
   end loop;
   
   ---得到对投资单位的长期股权投资明细信息
   
   
   
    
   for i in l_cur_invest_info(l_investor_pk,l_investee_pk , l_lst_fi_date  , 0)  loop
     
   
       --去年净利润调整 
             p_rcd.adj_jlr_sq_lj := i.adj_jlr_sq_lj  + 
             i.adj_jlr_bq_bd ; 
             
             
       --去年资本公积调整 
              
             p_rcd.adj_zbgj_sq_lj :=i.adj_zbgj_sq_lj +
             i.adj_zbgj_bq_bd ; 
             
        --去年专项储备调整        
             p_rcd.adj_zxcb_sq_lj :=i.adj_zxcb_sq_lj  +
             i.adj_zxcb_bq_bd ; 
             

             
       --上年确认的商誉
             p_rcd.sy  :=  
             nvl( i.sy , 0) ;
             
           --上年的未确认超额亏损
          p_rcd.adj_wqr_ceks_lst_year :=nvl(i.adj_wqr_ceks,0)   ;
          
          ---上年其他变动中的盈余公积变动 
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
--使用场景 : 确定投资单位对被投资单位在制定日期的投资比例
 function  f_invest_rate_curr( p_nxt_invest_rate  zf_spec.ntx_rcd_invest_rate , 
                                              p_fi_time  varchar2)
 return zf_spec.typ_invest_rate  
 is

 --定义函数的返回值  
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

--使用场景:  得到长期股权投资明细表中的对方单位的信息
--参数 :  
--         p_investor     投资方
--         p_investee     被投资方
--         p_fi_date      计算年和月份     ,如   201405
procedure  p_get_invest_investee_info( p_investee  varchar2 , 
                                       p_fi_date   varchar2  , 
                                       p_ntx_rcd_invest_detail  in out zf_spec.ntx_rcd_invest_detail , 
                                       p_verson    iufo_hbscheme.version%type 
                                      )
is 


--日期字符串辅助变量,用来生成每月的最有一天日期
l_lst_date_aux  varchar2(10) ;

--每月的最后一天
l_lst_date  varchar2(10) ; 

--被投资单位的 PK
l_investee_pk  iufo_keydetail_unit.keyval%type ;  

--得到单位的最后一天的日期 

cursor l_cur_lst_date(p_date_str varchar2 ) 
is 
select to_char(last_day(to_date(p_date_str , 'YYYY-MM-DD')  )  , 'YYYY-MM-DD')   lst_date from dual;

---根据单位编码 , 获取单位 keyval 值 
cursor l_cur_unit_pk(p_cur_unit_code varchar2)
is
select s.keyval   from  iufo_keydetail_unit s where s.code = p_cur_unit_code ; 

 
--所有者权益期初 , 期末 金额
--参数 : 
--               p_cur_investee  varchar2 被投资单位 PK  ,  
--               p_fi_date varchar2       查询日期 , 
--               p_verson  pls_integer    版本   

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
  
--专项储备本期变动
--参数 : 
--               p_cur_investee  varchar2 被投资单位 PK  ,  
--               p_fi_date varchar2       查询日期 , 
--               p_verson  pls_integer    版本   

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



--本年利润 
--参数 : 
--               p_cur_investee  varchar2 被投资单位 PK  ,  
--               p_fi_date varchar2       查询日期 , 
--               p_verson  pls_integer    版本   

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



--定义标识变量和统计变量
l_mark pls_integer ; 
l_count pls_integer ; 


begin

   --确定辅助计算日期变量的值， 为当前计算期间的1号
   l_lst_date_aux  :=  
   substr(p_fi_date , 1 , 4) || '-'||substr(p_fi_date, 5,2) || '-' || '01' ; 
   
   
   --得到当前计算期间的最后一天的日期 
   for i in l_cur_lst_date(l_lst_date_aux)  loop
     
       l_lst_date  :=  i.lst_date ; 
       
   end loop;
   
   --获得投资单位和被投资的单位的 UNIT_PK 
   
   
   for i in l_cur_unit_pk(p_investee) loop
         
         --投资单位的 PK 
        
         l_investee_pk := i.keyval ; 
	
   end loop;
   

   
   --得到所有者权益期初和期末值 , 资本公积本期变动 
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
   

   -----所有者权益专项储备本期变动
   
   for i in l_cur_investee_info_zxcb(l_investee_pk , l_lst_date  , p_verson)  loop
     
        --遍历投资明细表 ,  看是否有相同的日期  , 如果有相同的日期 , 则 不用
        --增加投资明细表的行数
        
        l_mark  :=  0 ; 
         
        for j  in 1 ..   p_ntx_rcd_invest_detail.count  loop  
          
             if ( i.the_date  =  p_ntx_rcd_invest_detail(j).the_date)  then
                                 
                   p_ntx_rcd_invest_detail(j).zxcb_bq_bd_r := i.zxcb_bq_bd_r ; 
                   
                   p_ntx_rcd_invest_detail(j).lrfp_qt_qt_bq_bd := i.lrfp_qt_qt_bq_bd ;
                   
                   p_ntx_rcd_invest_detail(j).qt_qt_bq_bd := i.qt_qt_bq_bd ;
                
             
             
                   l_mark  := 1 ; 
                   
                   ---找到匹配项目后，退出LOOP 循环
                   exit ; 
	
             end if;
             
        end loop ; 
        
        --如果没有找到 ， 则在投资明细表中增加一行 
        if ( l_mark = 0 ) then
          
            l_count := p_ntx_rcd_invest_detail.count +1; 
               
           p_ntx_rcd_invest_detail(l_count).zxcb_bq_bd_r := i.zxcb_bq_bd_r ; 
            
           p_ntx_rcd_invest_detail(l_count).lrfp_qt_qt_bq_bd := i.lrfp_qt_qt_bq_bd ;
                   
           p_ntx_rcd_invest_detail(l_count).qt_qt_bq_bd := i.qt_qt_bq_bd ;
           
           
            
            p_ntx_rcd_invest_detail(l_count).the_date :=i.the_date ; 
            p_ntx_rcd_invest_detail(l_count).value_code :=p_investee ; 
	
        end if;         
        
 
        
   end loop ; 
   
   
   -----净利润本期变动
   
   for i in l_cur_investee_info_jlr(l_investee_pk , l_lst_date  , p_verson)  loop
     
        --遍历投资明细表 ,  看是否有相同的日期  , 如果有相同的日期 , 则 不用
        --增加投资明细表的行数
        
        l_mark  :=  0 ; 
         
        for j  in 1 ..   p_ntx_rcd_invest_detail.count  loop  
          
             if ( i.the_date  =  p_ntx_rcd_invest_detail(j).the_date)  then
                                 
                   p_ntx_rcd_invest_detail(j).jlr_bq_bd := i.jlr_bq_bd ; 
             
                    p_ntx_rcd_invest_detail(j).qt_ldsy_qyfbd_bq_bd  := i.qt_ldsy_qyfbd_bq_bd  ; 
              
                    p_ntx_rcd_invest_detail(j).qt_ldsy_qt_bq_bd  := i.qt_ldsy_qt_bq_bd  ; 
             
             
             
              
                   
                   l_mark  := 1 ; 
                   
                   --找到后， 退出LOOP 循环 
                   exit;  
	
             end if;
             
        end loop ; 
        
        
        --如果没有找到 ， 则在投资明细表中增加一行 
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
 
 --使用场景 :  根据本期长期股权投资明细表 , 累计长期股权投资明细列表 ,投资明细 ,
 ---得到本期长期股权投资明细表的其他数据
 --参数 
 ---            p_rcd_invest_detail      本期长期长期股权投资明细表 
 ---            p_ntx_invest_rate        长期股权投资数据 
 --             p_ntx_invest_detail      长期股权投资的1~当月的 明细数据 
 
 procedure  p_invest_nt_deal_data(
                  p_rcd_invest_detail  in out     zf_spec.rcd_invest_detail , 
                  p_ntx_invest_rate        zf_spec.ntx_rcd_invest_rate ,  
                  p_ntx_invest_detail      zf_spec.ntx_rcd_invest_detail 
                  )
is
   --确定投资单位当期享有的投资比例 
   l_invest_rate_curr    zf_spec.typ_invest_rate  ; 
   
   --期初投资比例变量  
   l_invest_rate_lst     zf_spec.typ_invest_rate ; 
   
    --期末投资比例变量  
   l_invest_rate_end     zf_spec.typ_invest_rate ; 
    
   --期初日期 
   l_date_lst_year       zf_spec.typ_invest_date ; 
   
begin 
       
      --得到期初日期
      l_date_lst_year  := 
      to_char(to_number(substr(p_rcd_invest_detail.curr_date,1,4))-1 ) || '12' ; 
      
    

      ---计算期初投资比例的数值 
      l_invest_rate_lst  := f_invest_rate_curr(p_ntx_invest_rate ,
      l_date_lst_year) ; 
      
      
      
      --计算当前投资比例的数值
      l_invest_rate_end  := f_invest_rate_curr(p_ntx_invest_rate ,
      p_rcd_invest_detail.curr_date) ; 
      
      
      
      
      --把投资比例数据放入到 记录变量 
      p_rcd_invest_detail.invest_rate_beg := nvl(l_invest_rate_lst , 1) ; 
      p_rcd_invest_detail.invest_rate_end := nvl(l_invest_rate_end , 1) ; 
      
       
      for i in 1.. p_ntx_invest_detail.count  loop
        
	  
         --确定投资单位当期享有的投资比例 
         l_invest_rate_curr  := 
         f_invest_rate_curr(p_ntx_invest_rate ,p_ntx_invest_detail(i).the_date);
         
         
         --确定当期对被投资单位所有者权益应该享有的份额
         if( i  =  1 ) then  
         
             --净利润中 投资单位享有的份额
             p_rcd_invest_detail.adj_investor_jlr_bq_bd := 
             nvl(p_rcd_invest_detail.adj_investor_jlr_bq_bd , 0)  + 
             round(p_ntx_invest_detail(i).jlr_bq_bd * l_invest_rate_curr , 2) ; 
             
             --资本公积 中 投资单位享有的份额
             p_rcd_invest_detail.adj_zbgj_bq_bd := 
             nvl(p_rcd_invest_detail.adj_zbgj_bq_bd , 0)  + 
             round(p_ntx_invest_detail(i).zbgj_bq_bd * l_invest_rate_curr , 2) ; 
             
              --专项储备中 投资单位享有的份额
             p_rcd_invest_detail.adj_zxcb_bq_bd_r := 
             nvl(p_rcd_invest_detail.adj_zxcb_bq_bd_r , 0)  + 
             round(p_ntx_invest_detail(i).zxcb_bq_bd_r * l_invest_rate_curr , 2) ; 
             
              --利润分配其他 投资单位享有的份额 
            
             p_rcd_invest_detail.adj_lrfp_qt_bq_bd := 
             nvl(p_rcd_invest_detail.adj_lrfp_qt_bq_bd , 0)  + 
             round(nvl(p_ntx_invest_detail(i).lrfp_qt_bq_bd,0) * l_invest_rate_curr , 2) ; 
              
             
              --利润分配 - 对股东的分配  投资单位享有的份额 
            
             p_rcd_invest_detail.adj_lrfp_glfp_bq_bd := 
             nvl(p_rcd_invest_detail.adj_lrfp_glfp_bq_bd , 0)  + 
             round(nvl(p_ntx_invest_detail(i).lrfp_glfp_bq_bd,0) * l_invest_rate_curr , 2) ; 
               
              
             --实收资本变动 , 投资单位享有的份额
             p_rcd_invest_detail.adj_sszb_bq_bd := 
             nvl(p_rcd_invest_detail.adj_sszb_bq_bd , 0)  + 
             round(p_ntx_invest_detail(i).sszb_bq_bd * l_invest_rate_curr , 2) ; 
             
             --利润分配 盈余公积提取 的差额  -  投资单位享有的份额 
            
             p_rcd_invest_detail.adj_diff_yygj_bq_bd := 
             nvl(p_rcd_invest_detail.diff_fxcb_tq_bd_bd , 0)  + 
             round(nvl(p_ntx_invest_detail(i).adj_diff_yygj_bq_bd,0) * l_invest_rate_curr , 2) ; 
             
             
             --利润分配 专项储备提取 的差额  -  投资单位享有的份额 
            
             p_rcd_invest_detail.adj_diff_fxcb_bq_bd := 
             nvl(p_rcd_invest_detail.adj_diff_fxcb_bq_bd , 0)  + 
             round(nvl(p_ntx_invest_detail(i).diff_fxcb_tq_bd_bd,0) * l_invest_rate_curr , 2) ; 
             
             
             --利润分配-其他-其他 的差异  
             p_rcd_invest_detail.adj_lrfp_qt_qt_bq_bd := 
             nvl(p_rcd_invest_detail.adj_lrfp_qt_qt_bq_bd , 0)  + 
             round(nvl(p_ntx_invest_detail(i).adj_lrfp_qt_qt_bq_bd,0) * l_invest_rate_curr , 2) ; 
             
             --其他 - 其他   的差异 
              p_rcd_invest_detail.adj_qt_qt_bq_bd := 
             nvl(p_rcd_invest_detail.adj_qt_qt_bq_bd , 0)  + 
             round(nvl(p_ntx_invest_detail(i).adj_qt_qt_bq_bd,0) * l_invest_rate_curr , 2) ; 
             
             
             --其他  - 利得和损失  -- 权益法下被投资单位其他所有者权益变动的影响  
             p_rcd_invest_detail.adj_qt_ldsy_qyfbd_bq_bd := 
             nvl(p_rcd_invest_detail.adj_qt_ldsy_qyfbd_bq_bd , 0)  + 
             round(nvl(p_ntx_invest_detail(i).adj_qt_ldsy_qyfbd_bq_bd,0) * l_invest_rate_curr , 2) ; 
             
             --其他  - 利得和损失  -- 其他  
             p_rcd_invest_detail.adj_qt_ldsy_qt_bq_bd := 
             nvl(p_rcd_invest_detail.adj_qt_ldsy_qt_bq_bd , 0)  + 
             round(nvl(p_ntx_invest_detail(i).adj_qt_ldsy_qt_bq_bd,0) * l_invest_rate_curr , 2) ; 
             
            
             
             --所有的其他变动对 投资单位享有的份额
             --注意,实收资本不应该加入到其他合计中
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
             --净利润 中 投资单位享有的份额
             p_rcd_invest_detail.adj_investor_jlr_bq_bd := 
             nvl(p_rcd_invest_detail.adj_investor_jlr_bq_bd , 0)  + 
             round(( p_ntx_invest_detail(i).jlr_bq_bd  - 
                     p_ntx_invest_detail(i-1).jlr_bq_bd )  
                     * l_invest_rate_curr  , 2) ; 
             
             ---资本公积中 投资单位享有的份额
             p_rcd_invest_detail.adj_zbgj_bq_bd := 
             nvl(p_rcd_invest_detail.adj_zbgj_bq_bd , 0)  + 
             round(( p_ntx_invest_detail(i).zbgj_bq_bd  - 
                     p_ntx_invest_detail(i-1).zbgj_bq_bd )  
                     * l_invest_rate_curr  , 2) ; 
             
             --专项储备  中 投资单位享有的份额      
             p_rcd_invest_detail.adj_zxcb_bq_bd_r := 
             nvl(p_rcd_invest_detail.adj_zxcb_bq_bd_r , 0)  + 
             round(( p_ntx_invest_detail(i).zxcb_bq_bd_r  - 
                     p_ntx_invest_detail(i-1).zxcb_bq_bd_r )  
                     * l_invest_rate_curr  , 2) ; 
                     
             
             --利润分配其他    
             p_rcd_invest_detail.adj_lrfp_qt_bq_bd := 
             nvl(p_rcd_invest_detail.adj_lrfp_qt_bq_bd , 0)  + 
             round(( p_ntx_invest_detail(i).lrfp_qt_bq_bd -
                     p_ntx_invest_detail(i-1).lrfp_qt_bq_bd )  
                     * l_invest_rate_curr  , 2) ; 
            
         
              --利润分配 --股利分配  
             p_rcd_invest_detail.adj_lrfp_glfp_bq_bd := 
             nvl(p_rcd_invest_detail.adj_lrfp_glfp_bq_bd , 0)  + 
             round(( p_ntx_invest_detail(i).lrfp_glfp_bq_bd -
                     p_ntx_invest_detail(i-1).lrfp_glfp_bq_bd )  
                     * l_invest_rate_curr  , 2) ; 
                     
                     
               --利润分配 --盈余公积差异 
             p_rcd_invest_detail.adj_diff_yygj_bq_bd := 
             nvl(p_rcd_invest_detail.adj_diff_yygj_bq_bd , 0)  + 
             round(( p_ntx_invest_detail(i).diff_yygj_tq_bq_bd -
                     p_ntx_invest_detail(i-1).diff_yygj_tq_bq_bd )  
                     * l_invest_rate_curr  , 2) ;   
                     
                --利润分配 --风险储备差异  
             p_rcd_invest_detail.adj_diff_fxcb_bq_bd := 
             nvl(p_rcd_invest_detail.adj_diff_fxcb_bq_bd , 0)  + 
             round(( p_ntx_invest_detail(i).diff_fxcb_tq_bd_bd -
                     p_ntx_invest_detail(i-1).diff_fxcb_tq_bd_bd )  
                     * l_invest_rate_curr  , 2) ;              
                     

             --实收资本中 , 投资单位享有的份额      
             p_rcd_invest_detail.adj_sszb_bq_bd := 
             nvl(p_rcd_invest_detail.adj_sszb_bq_bd , 0)  + 
             round(( p_ntx_invest_detail(i).sszb_bq_bd  - 
                     p_ntx_invest_detail(i-1).sszb_bq_bd )  
                     * l_invest_rate_curr  , 2) ;  
                     
             
              --利润分配-其他-其他 的差异  
             p_rcd_invest_detail.adj_lrfp_qt_qt_bq_bd := 
             nvl(p_rcd_invest_detail.adj_lrfp_qt_qt_bq_bd , 0)  + 
             round((p_ntx_invest_detail(i).adj_lrfp_qt_qt_bq_bd -
             p_ntx_invest_detail(i-1).adj_lrfp_qt_qt_bq_bd )* l_invest_rate_curr , 2) ; 
             
             --其他 - 其他   的差异 
             p_rcd_invest_detail.adj_qt_qt_bq_bd := 
             nvl(p_rcd_invest_detail.adj_qt_qt_bq_bd , 0)  + 
             round((p_ntx_invest_detail(i).adj_qt_qt_bq_bd -
             p_ntx_invest_detail(i-1).adj_qt_qt_bq_bd) * l_invest_rate_curr , 2) ; 
             
             
             --其他  - 利得和损失  -- 权益法下被投资单位其他所有者权益变动的影响  
             p_rcd_invest_detail.adj_qt_ldsy_qyfbd_bq_bd := 
             nvl(p_rcd_invest_detail.adj_qt_ldsy_qyfbd_bq_bd , 0)  + 
             round((p_ntx_invest_detail(i).adj_qt_ldsy_qyfbd_bq_bd -
             p_ntx_invest_detail(i-1).adj_qt_ldsy_qyfbd_bq_bd ) * l_invest_rate_curr , 2) ; 
             
             --其他  - 利得和损失  -- 其他  
             p_rcd_invest_detail.adj_qt_ldsy_qt_bq_bd := 
             nvl(p_rcd_invest_detail.adj_qt_ldsy_qt_bq_bd , 0)  + 
             round((p_ntx_invest_detail(i).adj_qt_ldsy_qt_bq_bd-
             p_ntx_invest_detail(i-1).adj_qt_ldsy_qt_bq_bd) * l_invest_rate_curr , 2) ; 
                      
             
            /*  -- 其他项目合计  投资单位享有的份额      
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
         
         --处理 当前期间 ,  也即 最有一个期间的数据 
         if(p_ntx_invest_detail(i).the_date =  p_rcd_invest_detail.curr_date ) then 
         
               --所有者权益合计期初  
               
               p_rcd_invest_detail.syzqy_qc := p_ntx_invest_detail(i).syzqy_qc ; 
               p_rcd_invest_detail.syzqy_qc_should_aft := p_ntx_invest_detail(i).syzqy_qc_should_aft ;
               p_rcd_invest_detail.ssgd_syzqy_qc_should_aft := p_ntx_invest_detail(i).ssgd_syzqy_qc_should_aft ;
               
               
               --所有者权益合计期末 
               
               p_rcd_invest_detail.syzqy_qm := p_ntx_invest_detail(i).syzqy_qm ;
               p_rcd_invest_detail.syzqy_qm_should_aft := p_ntx_invest_detail(i).syzqy_qm_should_aft ;
               p_rcd_invest_detail.ssgd_syzqy_qm_should_aft := p_ntx_invest_detail(i).ssgd_syzqy_qm_should_aft ;
               
               --资本公积累计变动 
               
               p_rcd_invest_detail.zbgj_bq_bd := p_ntx_invest_detail(i).zbgj_bq_bd ;
               
               --净利润累计变动 
               
               p_rcd_invest_detail.jlr_bq_bd := p_ntx_invest_detail(i).jlr_bq_bd ; 
               
               --专项储备累计变动 
               
               p_rcd_invest_detail.zxcb_bq_bd_r := p_ntx_invest_detail(i).zxcb_bq_bd_r ; 
               
                --利润分配其他 累计变动 
               
               p_rcd_invest_detail.lrfp_qt_bq_bd := p_ntx_invest_detail(i).lrfp_qt_bq_bd ; 
               
                 --利润分配--股利分配  累计变动 
               
               p_rcd_invest_detail.lrfp_glfp_bq_bd := p_ntx_invest_detail(i).lrfp_glfp_bq_bd ; 
               
               
           
                                                    
               --实收资本累计变动 
               p_rcd_invest_detail.sszb_bq_bd :=   p_ntx_invest_detail(i).sszb_bq_bd ;  
               
                -- 未分配利润 -- 盈余公积提取差异变动 
               p_rcd_invest_detail.diff_yygj_tq_bq_bd :=   p_ntx_invest_detail(i).diff_yygj_tq_bq_bd ;  
               
               --未 分配利润 -- 风险储备提取差异变动 
               p_rcd_invest_detail.diff_fxcb_tq_bd_bd :=   p_ntx_invest_detail(i).diff_fxcb_tq_bd_bd ; 
                                                     
              
                 --利润分配-其他-其他 的差异  
              p_rcd_invest_detail.lrfp_qt_qt_bq_bd := p_ntx_invest_detail(i).adj_lrfp_qt_qt_bq_bd ; 
             
             --其他 - 其他   的差异 
              p_rcd_invest_detail.qt_qt_bq_bd := p_ntx_invest_detail(i).adj_qt_qt_bq_bd ; 
             
             
             --其他  - 利得和损失  -- 权益法下被投资单位其他所有者权益变动的影响  
             p_rcd_invest_detail.qt_ldsy_qyfbd_bq_bd :=p_ntx_invest_detail(i).adj_qt_ldsy_qyfbd_bq_bd ; 
             
             --其他  - 利得和损失  -- 其他  
             p_rcd_invest_detail.qt_ldsy_qt_bq_bd := p_ntx_invest_detail(i).adj_qt_ldsy_qt_bq_bd ; 
         
           
               --其他所有变动的  累计变动 
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
     
      
      --得到期初和期末投资单位和少数股东权益应该享有的所有者权益份额 
      
      --期初 金额 
      
      p_rcd_invest_detail.investor_qc_should := 
      round( (p_rcd_invest_detail.syzqy_qc_should_aft- 
      p_rcd_invest_detail.ssgd_syzqy_qc_should_aft)
      * l_invest_rate_lst   ,2) ; 
      
      p_rcd_invest_detail.ssgd_qc_should := 
      (p_rcd_invest_detail.syzqy_qc_should_aft- 
      p_rcd_invest_detail.ssgd_syzqy_qc_should_aft) -  p_rcd_invest_detail.investor_qc_should  ; 
      
      
      --期末金额 
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
      
      
      
      --净利润变动 中少数股东损益 金额  
      p_rcd_invest_detail.adj_ssgd_jlr_bq_bd := 
      p_rcd_invest_detail.jlr_bq_bd  - p_rcd_invest_detail.adj_investor_jlr_bq_bd ; 
      
      
      --资本公积变动中少数股东 金额 
      p_rcd_invest_detail.adj_ssgd_zbgj_bq_bd := 
      p_rcd_invest_detail.zbgj_bq_bd  - p_rcd_invest_detail.adj_zbgj_bq_bd ; 
      
      --专线储备变动中少数股东 金额  
      p_rcd_invest_detail.adj_ssgd_zxcb_r_bq_bd := 
      p_rcd_invest_detail.zxcb_bq_bd_r  - p_rcd_invest_detail.adj_zxcb_bq_bd_r ; 
      
    
      
      
      --长期股权投资调整中净利润调整金额  
      p_rcd_invest_detail.adj_jlr_bq_bd := 
      p_rcd_invest_detail.adj_investor_jlr_bq_bd  - 
      nvl(p_rcd_invest_detail.tzsy_bq , 0) ;
      
      --利润分配其他变动中,少数股东金额 
      p_rcd_invest_detail.adj_ssgd_lrfp_qt_bq_bd := 
      p_rcd_invest_detail.lrfp_qt_bq_bd  - p_rcd_invest_detail.adj_lrfp_qt_bq_bd ; 
      
       --利润分配-股利分配 中,少数股东金额 
      p_rcd_invest_detail.adj_ssgd_lrfp_glfp_bq_bd := 
      p_rcd_invest_detail.lrfp_glfp_bq_bd  - p_rcd_invest_detail.adj_lrfp_glfp_bq_bd ; 
      
        --利润分配 -盈余公积提取差异  中,少数股东金额 
      p_rcd_invest_detail.adj_ssgd_diff_yygj_bq_bd := 
      p_rcd_invest_detail.diff_yygj_tq_bq_bd  - p_rcd_invest_detail.adj_diff_yygj_bq_bd ; 
      
      
        --利润分配 - 风险储备提取差异中  ,少数股东金额 
      p_rcd_invest_detail.adj_ssgd_diff_fxcb_bq_bd := 
      p_rcd_invest_detail.diff_fxcb_tq_bd_bd  - p_rcd_invest_detail.adj_diff_fxcb_bq_bd ; 
      
      
      
      --实收资本变动中 ,少数股东金额 
      p_rcd_invest_detail.adj_ssgd_sszb_bq_bd := 
      p_rcd_invest_detail.sszb_bq_bd  - p_rcd_invest_detail.adj_sszb_bq_bd ;  
      
      
      
      
      
      
      --其他  --其他 项目变动 ，少数股东金额   
      p_rcd_invest_detail.adj_ssgd_qt_qt_bq_bd := 
      p_rcd_invest_detail.qt_qt_bq_bd  - p_rcd_invest_detail.adj_qt_qt_bq_bd ; 
      
      --未分配利润  -其他  -其他 项目变动， 少数股东金额  
      p_rcd_invest_detail.adj_ssgd_lrfp_qt_qt_bq_bd := 
      p_rcd_invest_detail.lrfp_qt_qt_bq_bd  - p_rcd_invest_detail.adj_lrfp_qt_qt_bq_bd ; 
      
      -- --少数股东 -其他-直接计入所有者权益的利得和损失-权益法下被投资单位其他所有者权益变动的影响 本期变动    L15
      p_rcd_invest_detail.adj_ssgd_qt_ldsy_qyfbd_bq_bd := 
      p_rcd_invest_detail.qt_ldsy_qyfbd_bq_bd  - p_rcd_invest_detail.adj_qt_ldsy_qyfbd_bq_bd ;
      
      
      -- ---少数股东-其他-权直接计入所有者权益的利得和损失-其他 本期变动    L17
      p_rcd_invest_detail.adj_ssgd_qt_ldsy_qt_bq_bd := 
      p_rcd_invest_detail.qt_ldsy_qt_bq_bd  - p_rcd_invest_detail.adj_qt_ldsy_qt_bq_bd ;
      
      
        p_rcd_invest_detail.adj_ssgd_zxcb_bq_bd := p_rcd_invest_detail.ssgd_qm_should - 
        p_rcd_invest_detail.ssgd_qc_should   -  
        p_rcd_invest_detail.adj_ssgd_jlr_bq_bd - 
        p_rcd_invest_detail.adj_ssgd_zbgj_bq_bd - 
        p_rcd_invest_detail.adj_ssgd_sszb_bq_bd   ;
        
        p_rcd_invest_detail.adj_ssgd_sszb_bd_other  :=  0  ; 
      
      
      /*--其他所有变动中,少数股东变动金额合计
      p_rcd_invest_detail.adj_ssgd_zxcb_bq_bd := 
      p_rcd_invest_detail.zxcb_bq_bd  - p_rcd_invest_detail.adj_zxcb_bq_bd ;  */
      
      
      
     /* ---由于投资比例变动 , 确定少数股东权益中应该减少或增加的实收资本金额
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
     
      
      --如果为权益法核算 , 则投资收益 ,资本公积 ,其他等调整金额为  0  
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
     
    --今年年份
    l_curr_year   varchar2(4) ; 

    --定义函数返回值
   
    
    --定义投资明细表 ( 从NC帐目上获取 )
    
    l_tbl   zf_spec.nt_rcd_invest_detail   :=  zf_spec.nt_rcd_invest_detail();   
    
    
    --长期股权投资明细列表变量  
    l_ntx_invest_detail        zf_spec.ntx_rcd_invest_detail ; 
    
    --长期股权投资明细列表变量初始化
    l_ntx_invest_detail_tmp    zf_spec.ntx_rcd_invest_detail ; 
    
    
    --投资比例数据 
    l_rcd_invest_info    zf_spec.rcd_invest_info ; 
    
    
    
    begin  
    
        --今年的年份 
        l_curr_year   :=  to_char( to_number(p_end_year ) + 1   ) ;  
        
      
        --调用 p_invest_nt 得到投资明细数据 
         
        
        p_invest_nt_self(l_tbl , l_curr_year , '00' , p_unit_code , p_adjust , 
        p_accounting ) ;
          
        
        --得到 仅含有被投资单位编码的 投资明细表  
        p_get_investee(p_unit_code , p_tbl_rtn ) ; 
        
        
        --比较 l_tbl_rtn 和 l_tbl 如果在l_tbl中有相同的被投资单位编码 , 则 复制 l_tbl的记录 
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
            
        
        
        
          
          --求被投资单位的所有者权益项目
          
          for  i  in   1  ..  p_tbl_rtn.count  loop  
            
            
                --得到每月被投资单位的所有者权益项目金额 
                l_ntx_invest_detail := l_ntx_invest_detail_tmp ;     
            
          
              /*  --测试用 
                dbms_output.put_line( p_tbl_rtn(i).value_code ) ; 
                dbms_output.put_line( p_tbl_rtn(i).rpt_version ) ;*/
                
                
                p_get_invest_investee_info( p_tbl_rtn(i).value_code  , 
                                            l_curr_year ||'01',  
                                            l_ntx_invest_detail, 
                                            p_tbl_rtn(i).rpt_version ) ; 
                                                          
                
                --得到投资比例数据  
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
   --使用场景 :    求每个科目的期初或期末的余额，或发生额 
   --参数

   --      p_end_year  结束年
   --      p_end_month   结束月份
   --      p_unit_code   单位编码
   --      p_adjust   是否包含调整期 是否包含调整期, Y ,包含 , N ,不包含 ,  A 只有调整期
  procedure  p_invest_nt(
                       p_tbl_rtn   in out   zf_spec.nt_rcd_invest_detail  ,  
                       p_end_year         IN varchar2 DEFAULT '2014',
                       p_end_month        IN varchar2 DEFAULT '02',
                       p_unit_code        IN VARCHAR2 DEFAULT '01',
                       p_adjust           in varchar2 default 'Y' ,  
                       p_accounting       in varchar2 default 'Y'  )

    is
   
    
    
    --定义投资明细表 ( 从NC帐目上获取 )
    
    l_tbl   zf_spec.nt_rcd_invest_detail   :=  zf_spec.nt_rcd_invest_detail(); 
    
    --定义投资收益明细表 (  从NC账目上取数字  ) 
    l_tbl_rev   zf_spec.nt_rcd_invest_detail   :=  zf_spec.nt_rcd_invest_detail();  
    
    --长期股权投资明细记录变量 , 用来作为中间变量 , 进行记录的传递 
    l_rcd_invest_detail   zf_spec.rcd_invest_detail   ;  
    
    --长期股权投资明细列表变量  
    l_ntx_invest_detail   zf_spec.ntx_rcd_invest_detail ; 
    
    --长期股权投资明细列表变量初始化
    l_ntx_invest_detail_tmp    zf_spec.ntx_rcd_invest_detail ; 
    
    
    --投资比例数据 
    l_rcd_invest_info    zf_spec.rcd_invest_info ; 
    
    
    begin  
      
         --调用 p_invest_nt_self 得到投资明细数据 
         
        p_invest_nt_self(l_tbl , p_end_year , p_end_month , p_unit_code , p_adjust , p_accounting ) ;
          
        
        --获得投资收益 
         
        p_invest_nt_self_rev(l_tbl_rev , p_end_year , p_end_month , p_unit_code , p_adjust , p_accounting ) ;
          
        
           --得到 仅含有被投资单位编码的 投资明细表  
        p_get_investee(p_unit_code , p_tbl_rtn ) ; 
        
        
        --比较 l_tbl_rtn 和 l_tbl 如果在l_tbl中有相同的被投资单位编码 , 则 复制 l_tbl的记录 
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
         
         
         
       --比较 l_tbl_rtn 和 l_tbl_rev 
       --如果在l_tbl中有相同的被投资单位编码 , 则 复制 l_tbl_rev的投资收益
        for x in  1 ..  p_tbl_rtn.count loop   
          
               
          
                for i in 1..   l_tbl_rev.count  loop
                      
                      if (p_tbl_rtn(x).super_code = l_tbl_rev(i).value_code  ) then
                        
                           p_tbl_rtn(x).tzsy_bq :=   l_tbl(i).tzsy_bq  ;   
            	
                      end if;
            	
                end loop;
                  
                
         end loop ;  
        
         
          
     
           
          
          --求被投资单位的所有者权益项目
          
          
          for  i  in   1  ..  p_tbl_rtn.count  loop  
            
            
                --得到每月被投资单位的是所有者权益项目金额 
                l_ntx_invest_detail := l_ntx_invest_detail_tmp ; 
                
            
                p_get_invest_investee_info( p_tbl_rtn(i).value_code ,p_tbl_rtn(i).the_date , 
                                            l_ntx_invest_detail  ,p_tbl_rtn(i).rpt_version ) ; 
                                            
        
                
                
                --得到投资比例数据  
                p_get_invest_info(l_rcd_invest_info ,p_tbl_rtn(i).unit_code , 
                p_tbl_rtn(i).value_code) ; 
          
                 
                l_rcd_invest_detail :=  p_tbl_rtn(i) ;
                
                --生成成本法转权益法明细表的数据
                
                p_invest_nt_deal_data(l_rcd_invest_detail , 
                l_rcd_invest_info.v_ntx_rcd_invest_rate , 
                l_ntx_invest_detail) ; 
                
                
                
                p_get_invest_lst_info( l_rcd_invest_detail  ) ; 
                           
                        
                
                p_tbl_rtn(i) :=  l_rcd_invest_detail  ; 
                 
                
          end loop ;    
    
    end ; 
  
  ---------------------------------------------------------------------------------
   --使用场景 :    生成长期股权投资明细表  
   --参数

   --      p_end_year  结束年
   --      p_end_month   结束月份
   --      p_unit_code   单位编码
   --      p_adjust   是否包含调整期 是否包含调整期, Y ,包含 , N ,不包含 ,  A 只有调整期
   function f_invest_nt(
                       p_end_year         IN varchar2 DEFAULT '2014',
                       p_end_month        IN varchar2 DEFAULT '02',
                       p_unit_code        IN VARCHAR2 DEFAULT '01',
                       p_adjust           in varchar2 default 'Y' ,  
                       p_accounting       in varchar2 default 'Y'  )
    RETURN zf_spec.nt_rcd_invest_detail 
    pipelined 
    
    is
    
    --定义函数返回值  
      
    l_tbl_rtn    zf_spec.nt_rcd_invest_detail   :=    zf_spec.nt_rcd_invest_detail(); 
    
    begin 
      
          if (p_end_year = zf_spec.V_IUFO_INIT_YEAR ) then
            
               p_invest_nt_bg( l_tbl_rtn  , p_end_year ,
               p_unit_code , p_adjust   ,  p_accounting   ) ; 
	
          else 
             
               
               p_invest_nt(l_tbl_rtn , p_end_year ,p_end_month  ,

               p_unit_code , p_adjust   ,  p_accounting   ) ; 
               
          
          end if; 
          
          
        
         --把 l_Tbl的数据通过管道流出 
         
          for i in 1.. l_tbl_rtn.count loop
            
          
	                ---l_tbl_rtn(i).value_code  := l_tbl_rtn(i).super_code ; 
                  pipe row (l_tbl_rtn(i)) ; 
                  
          end loop;
          
    return ;      
    
    end ; 





-------------------------------------------------------------
 ---使用场景 :   初始化报表项目科目查询字符串 
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
