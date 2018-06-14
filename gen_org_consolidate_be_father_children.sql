select  count(children_pk_org)  children_num 
from 
(
select  cc.pk_org  children_pk_org
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

select  dd.pk_org  children_pk_org 
from org_orgs  dd
where 
11=11
and dd.dr =  0 
and dd.code = '1023' 

)  aa

