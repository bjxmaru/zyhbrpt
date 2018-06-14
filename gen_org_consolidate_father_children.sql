select  org_code,   org_name ,pk_org  , children_org_code,  children_org_name ,  children_pk_org  ,  b_father
from 
(
select aa.code org_code,  aa.name org_name , aa.pk_org  , cc.code children_org_code,  cc.name children_org_name, cc.pk_org  children_pk_org ,'n' b_father
from  org_orgs cc , org_rcsmember bb  , org_orgs aa 
where  
11=11
and cc.pk_org = bb.pk_org
and bb.dr = 0 
and bb.pk_rcs = '1001A1100000000D2S6J'
and bb.pk_fatherorg = aa.pk_org
and aa.dr = 0 
and aa.code = '1023'

union all 

select dd.code org_code,  dd.name org_name , dd.pk_org  , dd.code children_org_code,  dd.name children_org_name , dd.pk_org  children_pk_org  , 'y' b_father
from org_orgs  dd
where 
11=11
and dd.dr =  0 
and dd.code = '1023' 

) 
order by b_father desc , children_org_code 
