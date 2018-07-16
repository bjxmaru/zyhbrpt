select   distinct cc.PROJECT_CODE , cc.PROJECT_NAME  , cc.pk_project   from GL_DETAIL  aa
    inner join  bd_accasoa dd  on ( dd.pk_accasoa=aa.pk_accasoa
                                   and dd.dr = 0 
                                   and aa.dr = 0 
                                   and aa.assid is not null
                                   and aa.discardflagv = 'N'
                                   and aa.periodv between '00' and (substr(parameter('end_date_param'), 6, 2) || 'Z')
                                   and aa.yearv = substr(parameter('end_date_param'), 1, 4)
                                   and aa.PK_ACCOUNTINGBOOK = (select b.PK_ACCOUNTINGBOOK
                                                               from ORG_FINANCEORG a
                                                                 inner join ORG_ACCOUNTINGBOOK b on (a.PK_FINANCEORG = b.PK_RELORG and a.CODE = parameter('org_code_param')))
    )
    inner join bd_account ee  on (  ee.pk_account = dd.pk_account and ee.dr = 0  and ee.code like  '1604%' )
    
    inner join GL_DOCFREE1 bb  on  ( bb.ASSID =aa.ASSID  and bb.dr = 0  )
    
    inner join BD_PROJECT  cc  on (  cc.PK_PROJECT = bb.f10 and cc.dr = 0 )