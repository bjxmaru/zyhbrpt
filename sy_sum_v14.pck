create or replace package sy_sum is


 

                           

      


cursor cur_f_arap(     p_end_date          varchar2 default sy_base.V_TMP_CURR_DATE_STR_10,
                            p_org_code          varchar2 default '102',
                            p_arap_class_hb     varchar2 default 'ysfl_zlze_1jkmhb_hz',
                            p_arap_class_dd     varchar2 default 'ysfl_zlze_kmdd_hz' ,
                            p_aux_code_ks       varchar2 DEFAULT '*',
                            p_aux_name_ks       varchar2 DEFAULT '*',
                            p_aux_code_ry       varchar2 DEFAULT '*',
                            p_aux_name_ry       varchar2 DEFAULT '*',
                            p_currency          varchar2 default 'CNY',
                            p_period_length_max number default 2,
                            p_accounting        number default 1  
                           
                     ) 
is
with before_sort as
(
select org_code,  aux_pk ,aux_code ,aux_name  , sum(bal_beg) bal_beg , 
   sum(localdebitamount ) localdebitamount , sum(localcreditamount) localcreditamount , 
   sum(bal) bal , sum(bal_age) bal_age,  sum(bal_diff )  bal_diff ,  
   sum(bal_0) bal_0 ,
   sum(bal_1) bal_1 ,
   sum(bal_2) bal_2, 
   sum(bal_3) bal_3, 
   sum(bal_4) bal_4, 
   sum(bal_5) bal_5,
   sum(bal_6) bal_6, 
   sum(bal_reserve) bal_reserve, 
   sum(bal_reserve_0) bal_reserve_0, 
   sum(bal_reserve_1) bal_reserve_1, 
   sum(bal_reserve_2) bal_reserve_2,
   sum(bal_reserve_3) bal_reserve_3,
   sum(bal_reserve_4) bal_reserve_4,
   sum(bal_reserve_5) bal_reserve_5,
   sum(bal_reserve_6) bal_reserve_6 , 
   not_aux ,related_mark , 
   'N' total_mark ,  0  rate_to_total  , 'N' b_above_1year
   from  
   table(sy_base.f_arap(p_end_date,p_org_code,
                     p_arap_class_hb ,p_arap_class_dd , p_aux_code_ks ,p_aux_name_ks ,p_aux_code_ry ,
                     p_aux_name_ry ,p_currency,p_period_length_max ,p_accounting ))   
   where bal <> 0    or  bal_beg <> 0                                 
   group by org_code ,  aux_pk ,aux_code ,aux_name  , not_aux , related_mark 
   
 )  
 
 select * from before_sort 
 order by  bal desc ; 
   


   type nt_f_arap  is table of cur_f_arap%rowtype ; 

 --&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
 


   

function  f_arap_v1 ( 
                 p_end_date varchar2 default  sy_base.V_TMP_CURR_DATE_STR_10 , 
                 p_org_code varchar2  default '102',    
                 p_arap_class    varchar2  default 'zh1' ,
                 p_aux_code_ks             varchar2 DEFAULT '*',
                 p_aux_name_ks            varchar2 DEFAULT '*',   
                 p_aux_code_ry             varchar2 DEFAULT '*',
                 p_aux_name_ry            varchar2 DEFAULT '*',   
                 p_currency             varchar2  default  'CNY',
                 p_period_length_max    number default 2 , 
                 p_accounting           number default 1   , 
                 p_row_number        number default  100000000 ,
                 p_arap_total_class    varchar2 default 'syzkflpl' ,    --指定应用的报表表样
                 p_orgcon    varchar2 default 'Y' ,
                 p_date_lst_bool  varchar2 default  'Y'    --是否计算上年年同期
                )  
return  nt_f_arap                                               
pipelined  ; 



cursor   cur_f_get_oppo_gldetail_sum (
                 p_org_code             varchar2 default '101' , 
                 p_end_year             varchar2 DEFAULT '2016',
                 p_end_month            varchar2 DEFAULT '10',
                 p_subj_code_reg            varchar2 DEFAULT '^1122.*$',  
				         p_subj_code_exclude_reg  varchar2 default '^a.*$' , 
                 p_oppo_subj_code_reg       varchar2 default  '(^1403.*$)|(^1604.*$)|(^1601.*$)|(^1405.*$)',    
                 p_accur_dir  varchar2  default 'dr' ,    --取借方发生额还是贷方发生额
                 p_accur_positive_minus varchar2  default 'zheng'  ,  --取发生额的正数还是负数
                 p_voucher_type_name_reg     varchar2 default '*'  ,        
                 p_currency             varchar2  default 'CNY',
                 p_period_length_max    number default 3 , 
                 p_accounting           number default 1 ,
                 p_related       varchar2 default '*'  , 
                 p_aux_code      varchar2 default '*' , 
                 p_aux_name      varchar2 default  '*'  , 
                 p_business_content  varchar2 default  'N' ,   --是否按照业务内容进行分类
                 p_cust_sup_class_code   varchar2 default  sy_base.V_GLF_CLASS_CODE 
                  
                 
                    
   )  
is

with base_ as 
(
select  org_pk , org_code ,org_name, org_pk_oppo, org_code_oppo, org_name_oppo , 
local_amount   , 
case  p_business_content 
  
      when 'Y' then 
           
            case 
                when regexp_like(subj_code , '(^1401.*$)|(^1403.*$)|(^1405.*$)' )  then '存货'  
                when regexp_like(subj_code , '^6001.*$' ) then '主营业务收入'  
                when regexp_like(subj_code , '^6051.*$' )  then '其他业务收入'  
                else  '其他'
            end 
      else 
        
            'a'
end  bus_style 
from table(sy_base.f_get_oppo_gldetail( p_org_code  , p_end_year,p_end_month ,
                 p_subj_code_reg ,   p_subj_code_exclude_reg  , p_oppo_subj_code_reg ,    
                 p_accur_dir  ,   p_accur_positive_minus  ,  p_voucher_type_name_reg  ,        
                 p_currency   , p_period_length_max    ,  p_accounting    , p_related , p_aux_code ,p_aux_name , p_cust_sup_class_code )) ), 
sum_ as 

(

select org_pk , org_code ,org_name, org_pk_oppo, org_code_oppo, org_name_oppo , bus_style , 
sum(local_amount) local_amount 
from base_
group by org_pk , org_code ,org_name, org_pk_oppo, org_code_oppo, org_name_oppo , bus_style 
)   
                 

select  'A' || rownum gjz_vm ,  sum_.*  , 0   rate_to_total from  sum_    order by local_amount desc ; 


type nt_f_get_oppo_gldetail_sum  is table of cur_f_get_oppo_gldetail_sum%rowtype; 









--&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
function    f_get_oppo_gldetail_sum (
                 p_org_code             varchar2 default '101' , 
                 p_end_year             varchar2 DEFAULT '2016',
                 p_end_month            varchar2 DEFAULT '10',
                 p_subj_code_reg            varchar2 DEFAULT '^1122.*$',  
                 p_oppo_subj_code_reg       varchar2 default  '(^1403.*$)|(^1604.*$)|(^1601.*$)|(^1405.*$)',    
                 p_accur_dir  varchar2  default 'dr' ,    --取借方发生额还是贷方发生额
                 p_accur_positive_minus varchar2  default 'zheng'  ,  --取发生额的正数还是负数
                 p_voucher_type_name_reg     varchar2 default '*'  ,        
                 p_currency             varchar2  default 'CNY',
                 p_period_length_max    number default 3 , 
                 p_accounting           number default 1 ,
                 p_related       varchar2 default '*'  ,
                 p_subj_code_exclude_reg  varchar2 default '^a.*$'   , 
                 p_total_mark   varchar2 default 'N'  ,     -- 是否输出合计值 
                 p_row_number     number default 5   ,   --输出的行数目
                 p_aux_code      varchar2 default '*' , 
                 p_aux_name      varchar2 default  '*'  , 
                 p_business_content  varchar2 default  'N'  ,    --是否按照业务内容进行分类
                 p_cust_sup_class_code   varchar2 default  sy_base.V_GLF_CLASS_CODE     --客商类别   
              
  )  return nt_f_get_oppo_gldetail_sum 
  pipelined; 


---------------------------------------------------------------------------------------------------------




end sy_sum;
/
create or replace package body sy_sum is




procedure  p_f_arap_v1_aux0( l_total_sum  in out  cur_f_arap%rowtype ) 
  is
  begin 
    
     
        l_total_sum.bal :=       0; 
        l_total_sum.bal_age :=   0; 
        l_total_sum.bal_0:=    0;  
        l_total_sum.bal_1 :=    0;  
        l_total_sum.bal_2 :=    0; 
        l_total_sum.bal_3 :=    0; 
        l_total_sum.bal_4 :=    0; 
        l_total_sum.bal_5 :=    0; 
        l_total_sum.bal_6 :=     0; 
        l_total_sum.bal_diff :=    0; 
        l_total_sum.bal_reserve :=    0; 
        l_total_sum.bal_reserve_0 :=   0; 
        l_total_sum.bal_reserve_1 :=   0; 
        l_total_sum.bal_reserve_2 :=  0; 
        l_total_sum.bal_reserve_3 :=    0; 
        l_total_sum.bal_reserve_4 :=   0; 
        l_total_sum.bal_reserve_5 :=   0;  
        l_total_sum.bal_reserve_6 :=   0; 
        l_total_sum.total_mark := 'Y' ; 
        l_total_sum.b_above_1year := 'N' ; 
 end ; 
 
 
 
 procedure  p_f_arap_v1_aux1(l_rtn in out nocopy  nt_f_arap , 
                             l_total_sum in out  nocopy  cur_f_arap%rowtype ) 
   is
   begin 
     
       for x in 1 ..  l_rtn.count loop 
      
        if(l_rtn(x).not_aux = 'N') then 
            l_rtn(x).bal_reserve_0 := 0  ; 
            l_rtn(x).bal_reserve_1 := round(l_rtn(x).bal_1 * 0.05 ,2)  ; 
            l_rtn(x).bal_reserve_2 :=  round(l_rtn(x).bal_2 * 0.1 ,2)  ; 
            l_rtn(x).bal_reserve_3 :=  round(l_rtn(x).bal_3 * 0.2  ,2) ;
            l_rtn(x).bal_reserve_4 :=  round(l_rtn(x).bal_4 * 0.3 ,2)  ;
            l_rtn(x).bal_reserve_5 :=  round(l_rtn(x).bal_5 * 0.5,2)   ; 
            l_rtn(x).bal_reserve_6 := round(l_rtn(x).bal_6 ,2)  ; 
            l_rtn(x).bal_reserve :=  l_rtn(x).bal_reserve_0  + l_rtn(x).bal_reserve_1  + l_rtn(x).bal_reserve_2  + 
                                     l_rtn(x).bal_reserve_3  + l_rtn(x).bal_reserve_4  + 
                                     l_rtn(x).bal_reserve_5  + l_rtn(x).bal_reserve_6 ;   
    
        end if; 
        
        --都是否存在一年以上账龄的行进行标识
        
        if(   l_rtn(x).bal_age - ( l_rtn(x).bal_0  +l_rtn(x).bal_1)   > 0 ) then 
                l_rtn(x).b_above_1year := 'Y'; 
        
        end if; 
        
        
        --对汇总行进行求值
        
        l_total_sum.bal :=    l_rtn(x).bal +  l_total_sum.bal  ; 
        l_total_sum.bal_age :=    l_rtn(x).bal_age +  l_total_sum.bal_age  ; 
        l_total_sum.bal_0 :=    l_rtn(x).bal_0 +  l_total_sum.bal_0  ; 
        l_total_sum.bal_1 :=    l_rtn(x).bal_1 +  l_total_sum.bal_1  ; 
        l_total_sum.bal_2 :=    l_rtn(x).bal_2 +  l_total_sum.bal_2  ; 
        l_total_sum.bal_3 :=    l_rtn(x).bal_3 +  l_total_sum.bal_3  ; 
        l_total_sum.bal_4 :=    l_rtn(x).bal_4 +  l_total_sum.bal_4  ; 
        l_total_sum.bal_5 :=    l_rtn(x).bal_5 +  l_total_sum.bal_5  ; 
        l_total_sum.bal_6 :=    l_rtn(x).bal_6 +  l_total_sum.bal_6  ;
        l_total_sum.bal_diff :=    l_rtn(x).bal_diff +  l_total_sum.bal_diff  ; 
        l_total_sum.bal_reserve :=    l_rtn(x).bal_reserve +  l_total_sum.bal_reserve  ; 
        l_total_sum.bal_reserve_0 :=    l_rtn(x).bal_reserve_0 +  l_total_sum.bal_reserve_0  ; 
        l_total_sum.bal_reserve_1 :=    l_rtn(x).bal_reserve_1 +  l_total_sum.bal_reserve_1  ; 
        l_total_sum.bal_reserve_2 :=    l_rtn(x).bal_reserve_2 +  l_total_sum.bal_reserve_2  ; 
        l_total_sum.bal_reserve_3 :=    l_rtn(x).bal_reserve_3 +  l_total_sum.bal_reserve_3  ; 
        l_total_sum.bal_reserve_4 :=    l_rtn(x).bal_reserve_4 +  l_total_sum.bal_reserve_4  ; 
        l_total_sum.bal_reserve_5 :=    l_rtn(x).bal_reserve_5 +  l_total_sum.bal_reserve_5  ; 
        l_total_sum.bal_reserve_6 :=    l_rtn(x).bal_reserve_6 +  l_total_sum.bal_reserve_6  ;     
    end loop ; 
    
    
          if(l_total_sum.bal_age - (l_total_sum.bal_1  +l_total_sum.bal_0  )  > 0 ) then 
                 l_total_sum.b_above_1year := 'Y'; 
          
          else 
            
                 l_total_sum.b_above_1year := 'N'; 
          end if; 
    
      
   end ; 


function  f_arap_v1 ( 
                 p_end_date varchar2 default  sy_base.V_TMP_CURR_DATE_STR_10 , 
                 p_org_code varchar2  default '102',
                 p_arap_class    varchar2  default 'zh1' ,
                 p_aux_code_ks             varchar2 DEFAULT '*',
                 p_aux_name_ks            varchar2 DEFAULT '*',   
                 p_aux_code_ry             varchar2 DEFAULT '*',
                 p_aux_name_ry            varchar2 DEFAULT '*',   
                 p_currency             varchar2  default  'CNY',
                 p_period_length_max    number default 2 , 
                 p_accounting           number default 1   , 
                 p_row_number        number default  100000000 ,
                 p_arap_total_class    varchar2 default 'syzkflpl' ,    --指定应用的报表表样
                 p_orgcon    varchar2 default 'Y' ,
                 p_date_lst_bool  varchar2 default  'Y'  --是否计算上年年同期
                )  
return nt_f_arap                                          
pipelined  
is
 l_rtn nt_f_arap := nt_f_arap();
 --去年相同月份的最后一天
 l_end_date_lst  varchar2(10) :=  substr(
  sy_base.f_date_para_get_lst_monthday(substr(p_end_date,1,4)||substr(p_end_date,6,2)||'01' ,-12)  , 1, 10);
  
 l_arap_class_xj_hb  varchar2(64) := 'init' ; --确定向下级函数传递的 arap_class的具体值 
 l_arap_class_xj_dd  varchar2(64) := 'init' ; --确定向下级函数传递的 arap_class的具体值 ,有些情况需要2次查询，然后把2次查询的结果UNION下
 
 
 l_total_row  cur_f_arap%rowtype; 
 
 --是否只输出总合计行
 
 l_only_total_out  varchar2(64)  := 'N' ;  
 
 
 --输出的行数
 l_output_row_num  pls_integer :=  0 ; 
 
 

 
begin 
  
   p_f_arap_v1_aux0(l_total_row) ; 
   

  
   case p_arap_total_class 
     
       when  'syzkflpl'  then   --应收账款分类披露
                  
                  case p_arap_class  
                    
                       when  'zh1'  then  --组合1 , 应收账款非关联方 
                             
                            l_arap_class_xj_hb  := 'ysfl_fglf_1jkmhb_hz' ;   
                            l_arap_class_xj_dd  := 'init' ; 
                            l_only_total_out := 'Y' ; 
                            
                        when  'zh1-mx'  then  --组合1 , 应收账款非关联方 
                             
                            l_arap_class_xj_hb  := 'ysfl_fglf_1jkmhb_hz' ;   
                            l_arap_class_xj_dd  := 'init' ; 
                            l_only_total_out := 'N' ; 
                                 
                       

                        when  'zh2'  then  --组合1 , 应收账款关联方 
                             
                            l_arap_class_xj_hb  := 'ysfl_glf_1jkmhb_hz' ;   
                            l_arap_class_xj_dd  := 'ysfl_glf_kmdd_hz' ; 
                            l_only_total_out := 'Y' ; 
                            
                         when  'zh2-mx'  then  --组合1 , 应收账款关联方 
                             
                            l_arap_class_xj_hb  := 'ysfl_glf_1jkmhb_hz' ;   
                            l_arap_class_xj_dd  := 'ysfl_glf_kmdd_hz' ; 
                            l_only_total_out := 'N' ;      
                            
                            
                            
                            
                            
                        
                        when   'zh3' then --质保金
                           
                            l_arap_class_xj_hb  := 'ysfl_zbj_kmdd_hz' ;   
                            l_arap_class_xj_dd  := 'init' ;
                            l_only_total_out := 'Y' ;  
                            
                        when   'zlqj' then   --账龄区间表
                           
                            l_arap_class_xj_hb  := 'ysfl_zlze_1jkmhb_hz' ;   
                            l_arap_class_xj_dd  := 'ysfl_zlze_kmdd_hz' ; 
                            l_only_total_out := 'Y' ; 
                            
                            
                           when   'zlqj-mx' then   --账龄区间表
                           
                            l_arap_class_xj_hb  := 'ysfl_zlze_1jkmhb_hz' ;   
                            l_arap_class_xj_dd  := 'ysfl_zlze_kmdd_hz' ; 
                            l_only_total_out := 'N' ;    
                            
                            
                            
                        when   'top5'  then     --应收账款前5名
                          
                            l_arap_class_xj_hb  := 'ysfl_zlze_1jkmhb_hz' ;   
                            l_arap_class_xj_dd  := 'ysfl_zlze_kmdd_hz' ; 
                            l_only_total_out := 'N' ; 
                            
                        when    'yshk'  then     --预收中的货款
                          
                            l_arap_class_xj_hb  := 'ysfl_yshk_1jkmhb_hz' ;   
                            l_arap_class_xj_dd  := 'ysfl_yshk_kmdd_hz' ; 
                            l_only_total_out := 'Y' ; 
                            
                         when    'ys'  then     --预收 ,全部
                          
                            l_arap_class_xj_hb  := 'ysfl_ys_1jkmhb_hz' ;   
                            l_arap_class_xj_dd  := 'ysfl_ys_kmdd_hz' ; 
                            l_only_total_out := 'Y' ; 
      
          
                        when    'ystop'  then     --预收中的货款 tOP 系列
                          
                            l_arap_class_xj_hb  := 'ysfl_ystop_1jkmhb_hz' ;   
                            l_arap_class_xj_dd  := 'ysfl_ystop_kmdd_hz' ; 
                            l_only_total_out := 'N' ;
                        
                          
                               
                        else  
                          
                            l_arap_class_xj_hb  := 'init' ;   
                            l_arap_class_xj_dd  := 'init' ;
                            l_only_total_out := 'Y' ;    
                                       
                  end case ; 
                  
                 
       
       when  'qtyspl' then 
         
            
            case p_arap_class  
              
                    when    'zh1'  then     --其他应收款组合1
                          
                            l_arap_class_xj_hb  := 'init' ;   
                            l_arap_class_xj_dd  := 'qtys_zh1_kmdd_hz' ; 
                            l_only_total_out := 'Y' ; 
                            
                    when    'zh2'  then     --其他应收款组合2
                          
                            l_arap_class_xj_hb  := 'init' ;   
                            l_arap_class_xj_dd  := 'qtys_zh2_kmdd_hz' ; 
                            l_only_total_out := 'Y' ; 
                            
                     when    'zh3'  then     --其他应收款组合3
                          
                            l_arap_class_xj_hb  := 'init' ;   
                            l_arap_class_xj_dd  := 'qtys_zh3_kmdd_hz' ; 
                            l_only_total_out := 'Y' ;     
                            
                            
                    when    'zh1_mx'  then     --其他应收款组合1  明细
                          
                            l_arap_class_xj_hb  := 'init' ;   
                            l_arap_class_xj_dd  := 'qtys_zh1_kmdd_hz' ; 
                            l_only_total_out := 'N' ; 
                            
                    when    'zh2_mx'  then     --其他应收款组合2    明细
                          
                            l_arap_class_xj_hb  := 'init' ;   
                            l_arap_class_xj_dd  := 'qtys_zh2_kmdd_hz' ; 
                            l_only_total_out := 'N' ; 
                            
                     when    'zh3_mx'  then     --其他应收款组合3   明细
                          
                            l_arap_class_xj_hb  := 'init' ;   
                            l_arap_class_xj_dd  := 'qtys_zh3_kmdd_hz' ; 
                            l_only_total_out := 'N' ;             
                            
                     when    'zlqj'  then     --账龄期间
                          
                            l_arap_class_xj_hb  := 'init' ;   
                            l_arap_class_xj_dd  := 'qtys_zlqj_kmdd_hz' ; 
                            l_only_total_out := 'Y' ;   
                            
                     when    'mxfl_wlk'  then     --其他应收款明细分类  往来款
                          
                            l_arap_class_xj_hb  := 'init' ;   
                            l_arap_class_xj_dd  := 'qtys_fxfl_wlk_kmdd_hz' ; 
                            l_only_total_out := 'Y' ;    
                            
                     when    'mxfl_bzj'  then     --其他应收款明细分类  保证金
                          
                            l_arap_class_xj_hb  := 'init' ;   
                            l_arap_class_xj_dd  := 'qtys_fxfl_bzj_kmdd_hz' ; 
                            l_only_total_out := 'Y' ;       
                            
                     when    'mxfl_grjk'  then     --其他应收款明细分类  个人借款
                          
                            l_arap_class_xj_hb  := 'init' ;   
                            l_arap_class_xj_dd  := 'qtys_fxfl_grjk_kmdd_hz' ; 
                            l_only_total_out := 'Y' ; 
                            
                     
                     when    'mxfl_qt'  then     --其他应收款明细分类  其他， 从其他应付款转过来
                          
                            l_arap_class_xj_hb  := 'init' ;   
                            l_arap_class_xj_dd  := 'qtys_fxfl_qt_kmdd_hz' ; 
                            l_only_total_out := 'Y' ; 
                                   
                    when    'top5'  then     --其他应收款明细分类   前5大
                          
                            l_arap_class_xj_hb  := 'init' ;   
                            l_arap_class_xj_dd  := 'qtys_top5_kmdd_hz' ; 
                            l_only_total_out := 'N' ;                 
                    
                    
                    
                    when   'qtyfzk_mx_wlk'   then    --其他应付款，明细，往来款
                            l_arap_class_xj_hb  := 'init' ;   
                            l_arap_class_xj_dd  := 'qtys_qtyfzk_mx_wlk_kmdd_hz' ; 
                            l_only_total_out := 'Y' ; 
                            
                     when   'qtyfzk_mx_byj'    then --备用金
                            l_arap_class_xj_hb  := 'init' ;   
                            l_arap_class_xj_dd  := 'qtys_qtyfzk_mx_byj_kmdd_hz' ; 
                            l_only_total_out := 'Y' ;   
                            
                               
                     when   'qtyfzk_mx_bzj'    then --保证金
                            l_arap_class_xj_hb  := 'init' ;   
                            l_arap_class_xj_dd  := 'qtys_qtyfzk_mx_bzj_kmdd_hz' ; 
                            l_only_total_out := 'Y' ;                 
                            
                            
                              
                     when   'qtyfzk_mx_ygbx'   then   -- 代扣员工保险
                            l_arap_class_xj_hb  := 'init' ;   
                            l_arap_class_xj_dd  := 'qtys_qtyfzk_mx_ygbx_kmdd_hz' ; 
                            l_only_total_out := 'Y' ;        
                            
                     when   'qtyfzk_mx_qt'     then -- 总合计
                            l_arap_class_xj_hb  := 'init' ;   
                            l_arap_class_xj_dd  := 'qtys_qtyfzk_mx_qt_kmdd_hz' ; 
                            l_only_total_out := 'Y' ;    
                            
                     when   'qtyfzk_top'     then -- 1年以上的其他应付款   
                            l_arap_class_xj_hb  := 'init' ;   
                            l_arap_class_xj_dd  := 'qtys_qtyfzk_top_kmdd_hz' ; 
                            l_only_total_out := 'N' ;             
                      
                     
                      when   'qtyfzk_glf_qk'     then --  其他应付款， 关联方
                            l_arap_class_xj_hb  := 'init' ;   
                            l_arap_class_xj_dd  := 'qtys_qtyfzk_glf_qk_kmdd_hz' ; 
                            l_only_total_out := 'N' ;             
                      
                      when   'qtyfzk_qtyf_top'     then -- 1年以上的其他应付款   
                            l_arap_class_xj_hb  := 'init' ;   
                            l_arap_class_xj_dd  := 'qtys_qtyfzk_qtyf_top_kmdd_hz' ; 
                            l_only_total_out := 'N' ;              
                            
                                         
                     else  
                          
                            l_arap_class_xj_hb  := 'init' ;   
                            l_arap_class_xj_dd  := 'init' ;
                            l_only_total_out := 'Y' ;    
                                       
             end case ; 
       
    
   
       when  'yfzk' then 
         
            
            case p_arap_class  
              
                    when    'zlmx'  then     --预付账款账龄列示
                          
                            l_arap_class_xj_hb  := 'yfzk_zlmx_kmhb_hz' ;   
                            l_arap_class_xj_dd  := 'yfzk_zlmx_kmdd_hz' ; 
                            l_only_total_out := 'Y' ; 
                            
                    when    'zlmx_mx'  then     --预付账款账龄列示
                          
                            l_arap_class_xj_hb  := 'yfzk_zlmx_kmhb_hz' ;   
                            l_arap_class_xj_dd  := 'yfzk_zlmx_kmdd_hz' ; 
                            l_only_total_out := 'N' ;          
                            
                            
                            
                            
                    when    'top5'  then     --预付账款TOP
                          
                            l_arap_class_xj_hb  := 'yfzk_top5_kmhb_hz' ;   
                            l_arap_class_xj_dd  := 'yfzk_top5_kmdd_hz' ; 
                            l_only_total_out := 'N' ; 
                            
                            
                    when   'yfzk_hk'  then   --应付账款 货款
                      
                            l_arap_class_xj_hb  := 'yfzk_yfzk_hk_kmhb_hz' ;   
                            l_arap_class_xj_dd  := 'init' ; 
                            l_only_total_out := 'Y' ; 
                            
                            
                     when   'yfzk_sbk'  then   --应付账款 设备款
                      
                            l_arap_class_xj_hb  := 'init' ;   
                            l_arap_class_xj_dd  := 'yfzk_yfzk_hk_kmdd_hz' ; 
                            l_only_total_out := 'Y' ;         
                            
                     when   'yfzk_gck'  then   --应付账款 设备款
                      
                            l_arap_class_xj_hb  := 'init' ;   
                            l_arap_class_xj_dd  := 'yfzk_yfzk_gck_kmdd_hz' ; 
                            l_only_total_out := 'Y' ;   
                            
                            
                     when   'yfzk_hj'  then   --应付账款  所有
                      
                            l_arap_class_xj_hb  := 'yfzk_yfzk_hj_kmhb_hz' ;   
                            l_arap_class_xj_dd  := 'yfzk_yfzk_hj_kmdd_hz' ; 
                            l_only_total_out := 'Y' ;           
                                 
                     when   'yfzk_1n'  then   --账龄超过一年的应付账款
                      
                            l_arap_class_xj_hb  := 'yfzk_yfzk_1n_kmhb_hz' ;   
                            l_arap_class_xj_dd  := 'yfzk_yfzk_1n_kmdd_hz' ; 
                            l_only_total_out := 'N' ;    
                            
                     when   'yfzk_top'  then   --应付账款 明细
                      
                            l_arap_class_xj_hb  := 'yfzk_yfzk_top_kmhb_hz' ;   
                            l_arap_class_xj_dd  := 'yfzk_yfzk_top_kmdd_hz' ; 
                            l_only_total_out := 'N' ;    
                                   
                            
                     when   'yfzk_top_glf'  then   --应付账款 明细
                      
                            l_arap_class_xj_hb  := 'yfzk_yfzk_top_glf_kmhb_hz' ;   
                            l_arap_class_xj_dd  := 'yfzk_yfzk_top_glf_kmdd_hz' ; 
                            l_only_total_out := 'N' ;    
                                            
                                         
                     else  
                          
                            l_arap_class_xj_hb  := 'init' ;   
                            l_arap_class_xj_dd  := 'init' ;
                            l_only_total_out := 'Y' ;    
                                       
             end case ; 
             
             
             
             
     when  'glfjy' then 
         
            
            case p_arap_class  
              
                    when    'yszk'  then     --关联方交易， 应收账款
                          
                            l_arap_class_xj_hb  := 'glfjy_ys_kmhb_hz' ;   
                            l_arap_class_xj_dd  := 'glfjy_ys_kmdd_hz' ; 
                            l_only_total_out := 'N' ; 
                            
                    when    'yszk2'  then     --关联方交易， 应收账款
                          
                            l_arap_class_xj_hb  := 'glfjy_ys2_kmhb_hz' ;   
                            l_arap_class_xj_dd  := 'glfjy_ys2_kmdd_hz' ; 
                            l_only_total_out := 'N' ;        
                            
                            
                    when    'yszk_ys'  then     --关联方交易， 预收账款
                          
                            l_arap_class_xj_hb  := 'glfjy_yszk_ys_kmhb_hz' ;   
                            l_arap_class_xj_dd  := 'glfjy_yszk_ys_kmdd_hz' ; 
                            l_only_total_out := 'N' ;          
                    
                    
                    when    'yszk_ys2'  then     --关联方交易， 预收账款
                          
                            l_arap_class_xj_hb  := 'glfjy_yszk2_ys_kmhb_hz' ;   
                            l_arap_class_xj_dd  := 'glfjy_yszk2_ys_kmdd_hz' ; 
                            l_only_total_out := 'N' ;          
                            
                            
                             
                    when    'qtyf'  then     --关联方交易， 其他应付
                          
                            l_arap_class_xj_hb  := 'init' ;   
                            l_arap_class_xj_dd  := 'glfjy_qtyf_kmdd_hz' ; 
                            l_only_total_out := 'N' ;  
                            
                    
                             
                    when    'qtyf2'  then     --关联方交易， 其他应付
                          
                            l_arap_class_xj_hb  := 'init' ;   
                            l_arap_class_xj_dd  := 'glfjy_qtyf2_kmdd_hz' ; 
                            l_only_total_out := 'N' ;   
                            
                            
                               
                    when    'yfzk'  then     --关联方交易， 应付账款
                          
                            l_arap_class_xj_hb  := 'glfjy_yfzk_kmhb_hz' ;   
                            l_arap_class_xj_dd  := 'glfjy_yfzk_kmdd_hz' ; 
                            l_only_total_out := 'N' ;     
                            
                            
                    when    'yfzk2'  then     --关联方交易， 应付账款
                          
                            l_arap_class_xj_hb  := 'glfjy_yfzk2_kmhb_hz' ;   
                            l_arap_class_xj_dd  := 'glfjy_yfzk2_kmdd_hz' ; 
                            l_only_total_out := 'N' ;             
                            
                            
                            
                            
                    when    'yfzk_yf'  then     --关联方交易， 预付账款
                          
                            l_arap_class_xj_hb  := 'glfjy_yfzk_yf_kmhb_hz' ;   
                            l_arap_class_xj_dd  := 'glfjy_yfzk_yf_kmdd_hz' ; 
                            l_only_total_out := 'N' ;            
                                                
                     
                    when    'yfzk_yf2'  then     --关联方交易， 预付账款
                          
                            l_arap_class_xj_hb  := 'glfjy_yfzk_yf2_kmhb_hz' ;   
                            l_arap_class_xj_dd  := 'glfjy_yfzk_yf2_kmdd_hz' ; 
                            l_only_total_out := 'N' ;            
                                                
            
            
             
                    
                   when    'qtys'  then     --关联方交易， 其他应收
                          
                            l_arap_class_xj_hb  := 'init' ;   
                            l_arap_class_xj_dd  := 'glfjy_qtys_kmdd_hz' ; 
                            l_only_total_out := 'N' ;   
                            
                            
                            
                  when    'qtys2'  then     --关联方交易， 其他应收
                          
                            l_arap_class_xj_hb  := 'init' ;   
                            l_arap_class_xj_dd  := 'glfjy_qtys2_kmdd_hz' ; 
                            l_only_total_out := 'N' ;   
                                      
                           
                  
                                         
                     else  
                          
                            l_arap_class_xj_hb  := 'init' ;   
                            l_arap_class_xj_dd  := 'init' ;
                            l_only_total_out := 'Y' ;    
                                       
             end case ;         
             
             
         
   
   
    else 
        
      
            case p_arap_class  
              
                    when    'qt_cqgqtz'  then     --  长期股权投资
                          
                            l_arap_class_xj_hb  := 'init' ;   
                            l_arap_class_xj_dd  := 'zjgc_cqgqtz_kmdd_hz' ; 
                            l_only_total_out := 'N' ; 
                            
                    when    'qt_zjgc'  then     --在建工程
                          
                            l_arap_class_xj_hb  := 'init' ;   
                            l_arap_class_xj_dd  := 'zjgc_zjgc_kmdd_hz' ; 
                            l_only_total_out := 'N' ; 
                            
                            
                    when   'qt_zxyfk'  then   --专项应付款
                      
                            l_arap_class_xj_hb  := 'init' ;   
                            l_arap_class_xj_dd  := 'zjgc_zxyfk_hk_kmdd_hz' ; 
                            l_only_total_out := 'N' ; 
                            
                            
                   
                            
                                         
                     else  
                          
                            l_arap_class_xj_hb  := 'init' ;   
                            l_arap_class_xj_dd  := 'init' ;
                            l_only_total_out := 'Y' ;    
                                       
             end case ; 
   
       end case ; 
       
       
        if (l_arap_class_xj_hb  <> 'init'  or  l_arap_class_xj_dd  <> 'init' )  then 
                  open cur_f_arap(p_end_date,p_org_code,l_arap_class_xj_hb ,l_arap_class_xj_dd,
                            p_aux_code_ks ,p_aux_name_ks ,p_aux_code_ry , p_aux_name_ry,
                            p_currency,p_period_length_max ,p_accounting ) ; 
                  fetch  cur_f_arap bulk collect into l_rtn  ; 
                  close cur_f_arap ;    
                      
         end if;   
         
       --对合计行进行赋值，同时对坏账准备金额进行计算  
       
       if(l_rtn.count >=1 ) then 
           p_f_arap_v1_aux1(l_rtn , l_total_row) ; 
           
       end if; 
       
       --对汇总行中 ， 是否存在一年以上账龄的行进行标识
        
        if(   l_total_row.bal_age -  l_total_row.bal_1   > 0 ) then 
                l_total_row.b_above_1year := 'Y'; 
        
        end if; 
        
     
   
   
      if(l_rtn.count < p_row_number )  then 
                     
                         l_output_row_num := l_rtn.count; 
                     
       else 
                         l_output_row_num := p_row_number; 
                          
      end if;       
       
       
      case  l_only_total_out  
        
            when 'Y' then 
              
                   pipe row ( l_total_row) ; 
                   
                   
            when 'N' then 
              
                  
              
       
                    for x in 1  .. l_output_row_num loop 
                      
                        if(l_total_row.bal = 0 ) then 
                        
                             l_rtn(x).rate_to_total  :=0 ; 
                        else 
                      
                             l_rtn(x).rate_to_total := round(l_rtn(x).bal /   l_total_row.bal, 2)  ;
                             
                        end if;  
                      
                       pipe row ( l_rtn(x)) ; 
                    
                    end loop ; 
                    
             when 'X' then 
               
                    pipe row ( l_total_row) ; 
   
                    
                    for x in 1  .. l_output_row_num  loop 
                      
                      if(l_total_row.bal = 0 ) then 
                        
                             l_rtn(x).rate_to_total  :=0 ; 
                        else 
                      
                             l_rtn(x).rate_to_total := round(l_rtn(x).bal /   l_total_row.bal, 2)  ;
                             
                       end if;  
                      
                       pipe row ( l_rtn(x)) ; 
                    
                    end loop ; 
                    
                    
             else 
               
                    null; 
                    
                    
             end case ; 
      
   return ; 
   
   
   
   
   
   
   exception  
     
             when others then 
               
               
               
                 if(cur_f_arap %isopen ) then 
                 
                 
                           close cur_f_arap ; 
                 
                 end if; 

end ; 
 

--&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

function    f_get_oppo_gldetail_sum (
                 p_org_code             varchar2 default '101' , 
                 p_end_year             varchar2 DEFAULT '2016',
                 p_end_month            varchar2 DEFAULT '10',
                 p_subj_code_reg            varchar2 DEFAULT '^1122.*$',  
                 p_oppo_subj_code_reg       varchar2 default  '(^1403.*$)|(^1604.*$)|(^1601.*$)|(^1405.*$)',    
                 p_accur_dir  varchar2  default 'dr' ,    --取借方发生额还是贷方发生额
                 p_accur_positive_minus varchar2  default 'zheng'  ,  --取发生额的正数还是负数
                 p_voucher_type_name_reg     varchar2 default '*'  ,        
                 p_currency             varchar2  default 'CNY',
                 p_period_length_max    number default 3 , 
                 p_accounting           number default 1 ,
                 p_related       varchar2 default '*' ,
                 p_subj_code_exclude_reg  varchar2 default '^a.*$' , 
                 p_total_mark   varchar2 default 'N'  ,     -- 是否输出合计值 
                 p_row_number     number default 5  ,    --输出的行数目
                 p_aux_code      varchar2 default '*' , 
                 p_aux_name      varchar2 default  '*'  , 
                 p_business_content  varchar2 default  'N'   ,  --是否按照业务内容进行分类
                 p_cust_sup_class_code   varchar2 default  sy_base.V_GLF_CLASS_CODE 
              
  )  return nt_f_get_oppo_gldetail_sum 
  pipelined
  is
  
  l_rtn  nt_f_get_oppo_gldetail_sum := new nt_f_get_oppo_gldetail_sum() ; 
  l_total_row   cur_f_get_oppo_gldetail_sum%rowtype; 
  --输出的行数
  l_output_row_num  pls_integer :=  0 ; 
  begin 
    
     open cur_f_get_oppo_gldetail_sum( p_org_code  , p_end_year,p_end_month ,
                 p_subj_code_reg ,   p_subj_code_exclude_reg  , p_oppo_subj_code_reg ,    
                 p_accur_dir  ,   p_accur_positive_minus  ,  p_voucher_type_name_reg  ,        
                 p_currency   , p_period_length_max    ,  p_accounting    , p_related, p_aux_code, p_aux_name ,p_business_content , p_cust_sup_class_code) ; 
     fetch cur_f_get_oppo_gldetail_sum  bulk collect into l_rtn ; 
     close cur_f_get_oppo_gldetail_sum ;
     
     
     
      
     
     for x in 1 .. l_rtn.count  loop 
        
           l_total_row.local_amount := nvl(l_total_row.local_amount , 0) + l_rtn(x).local_amount; 
         
        
     
     end loop;
     
      
     for x in 1 .. l_rtn.count  loop 
        
           l_total_row.local_amount := nvl(l_total_row.local_amount , 0) ; 
           
           if(  l_total_row.local_amount = 0 ) then  
              
               l_rtn(x).rate_to_total  := 0 ;  
           
           else 
             
               l_rtn(x).rate_to_total :=  round(  l_rtn(x).local_amount / l_total_row.local_amount , 2) ; 
               
           end if; 
     end loop;
     
     if(l_rtn.count < p_row_number )  then 
                     
                         l_output_row_num := l_rtn.count; 
                     
      else 
                         l_output_row_num := p_row_number; 
                          
      end if;       
     
     
     case p_total_mark 
          
          when 'Y' then 
              
             pipe row(l_total_row) ; 
          
          when 'N' then 
             
             for x in 1 .. l_output_row_num  loop  
               
                pipe row( l_rtn(x)) ; 
             
             end loop; 
          
          
          else 
            
             for x in 1 .. l_rtn.count  loop  
               
                pipe row( l_rtn(x)) ; 
             
             end loop; 
             
             pipe row(l_total_row) ; 
          
            
          
      end case ; 
     
     exception 
       
             when  others then 
               
             
                  if( cur_f_get_oppo_gldetail_sum %isopen ) then 
                  
                       close  cur_f_get_oppo_gldetail_sum ; 
                  
                  end if; 
  
  end ; 




--***********************************************************************************************************************************************************************



--------------------------------------------------------------------------------------------------------------
begin

    null; 
end sy_sum;
/
