 select children_pk_org  pk_org_list 
 from (
 select  zz.code  children_org_code ,zz.name  children_org_name  ,yy.pk_org children_pk_org    , 
 (select decode( count(pk_org)  , 0 , 'n' , 'y') b_father    from ORG_RCSMEMBER_v  mm 
  where mm.pk_fatherorg  =  yy.pk_org   and    mm.pk_svid =  (select  pk_vid   
                      from org_reportcombinestru_v vv
                      where 
                      substr(vv.venddate , 1, 7)  >  parameter('end_year_param')|| '-'||parameter('end_month_param')
                      and substr(vv.vstartdate , 1,7) <=  parameter('end_year_param')|| '-'||parameter('end_month_param')
                      )  
  
  )  b_father  ,
  'n' b_self 
  from  org_orgs zz ,  ORG_RCSMEMBER_v yy   ,org_financeorg  xx  
  where 1=1 and zz.dr = 0 and zz.pk_org = yy.pk_org 
  and yy.pk_svid =   (select  pk_vid  
        from org_reportcombinestru_v vv
        where 
        substr(vv.venddate , 1, 7)  >   parameter('end_year_param')|| '-'||parameter('end_month_param')
        and substr(vv.vstartdate , 1,7) <= parameter('end_year_param')|| '-'||parameter('end_month_param')
        )
  and yy.dr =0  and yy.pk_fatherorg = xx.pk_financeorg 
  and xx.dr = 0 and xx.code = parameter('org_code_param')
  
  union all 
  
  select mm.code  children_org_code  , mm.name children_org_name ,   mm.pk_financeorg  children_pk_org    , 
  (select decode( count(pk_org)  , 0 , 'n' , 'y') b_father   from ORG_RCSMEMBER_v kk  
  where  kk.pk_fatherorg  = mm.pk_financeorg   and  kk.pk_svid =   (select  pk_vid  
        from org_reportcombinestru_v vv
        where 
        substr(vv.venddate , 1, 7)  >   parameter('end_year_param')|| '-'||parameter('end_month_param')
        and substr(vv.vstartdate , 1,7) <= parameter('end_year_param')|| '-'||parameter('end_month_param')
        )    ) b_father  , 'y' b_self 
  from org_financeorg mm  
  where mm.dr = 0 
  and mm.code = parameter('org_code_param')
  
  
  ) 
  
  
  where b_father = 'y'  and b_self ='n'
  
  
  
  
  
