PL/SQL Developer Report

[SQL]
 select aa.voucher_date voucher_date , aa.voucher_date  business_date , 
  decode(aa.balanorient , 0 , '��' , '��'  )  dir , 
  'CNY' cny , '' hx_number , 'init' zhaiyao , '' pingzhenghao , '' pingzhengleibie, 
  aa.amount  yuanbi_amount, aa.amount  benbi_amount  , '����' aux1 , aa.ks_code  aux_content1 ,  '�����֯' aux2 , '1000' aux_content2
  
  
  -- , '����' aux1 , aa.ks_code  aux_content1  --,  '�����֯' aux2 , '1000' aux_content2
  from zyhb_arap_age_year_month aa 
  where 
  aa.org_code = '1007Z'
  and aa.subj_code = '112202'
  and aa.year_month = '201601'  
  order by  ks_name,  subj_code,  voucher_date ;

[Options]
Connect=False
Username=
Password=2026
Database=
ConnectAs=
LockMode=0
LockedPassword=2661
BkgColor=-16777211
BkgImage=
FormLayout=False
OnlyNBSP=False
LeftMargin=0
TopMargin=0
PageBreak=0
AddSQL=False
HandleTags=True

[Styles]

{Title}
Enabled=True
Name=Report Title
Description=
Style=
HeaderStyle=
Align=0
Break=0
Function=0
Format=

{Param}
Enabled=True
Name=Variables
Description=
Style=
HeaderStyle=
Align=0
Break=0
Function=0
Format=

{Table}
Enabled=True
Name=Tabular Tables
Description=
Style=
HeaderStyle=
Align=0
Break=0
Function=0
Format=

{Form}
Enabled=True
Name=Form Tables
Description=
Style=
HeaderStyle=
Align=0
Break=0
Function=0
Format=

{Field}
Enabled=True
Name=Default Field
Description=
Style=
HeaderStyle=
Align=0
Break=0
Function=0
Format=



[CSS]

