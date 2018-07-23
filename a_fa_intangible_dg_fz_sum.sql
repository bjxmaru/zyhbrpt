select 
sum(beg_bal_land) beg_bal_land , 
sum(bal_land_add_pur) bal_land_add_pur , 
sum(bal_land_add_cons) bal_land_add_cons , 
sum(bal_LAND_ADD_alter) bal_LAND_ADD_alter , 
sum(bal_land_add_other) bal_land_add_other , 
sum(bal_land_reduce_bf) bal_land_reduce_bf ,
sum(bal_land_reduce_alter) bal_land_reduce_alter ,
sum(bal_land_reduce_other) bal_land_reduce_other ,
sum(dep_beg_bal_land) dep_beg_bal_land,
sum(dep_bal_land_add_jt) dep_bal_land_add_jt ,
sum(dep_bal_land_add_pur) dep_bal_land_add_pur , 
sum(dep_bal_land_add_cons) dep_bal_land_add_cons ,
sum(dep_bal_land_add_alter) dep_bal_land_add_alter , 
sum(dep_bal_land_add_other) dep_bal_land_add_other ,
sum(dep_bal_land_reduce_bf) dep_bal_land_reduce_bf , 
sum(dep_bal_land_reduce_alter) dep_bal_land_reduce_alter  ,
sum(dep_bal_land_reduce_other) dep_bal_land_reduce_other , 
sum(imp_beg_bal_land) imp_beg_bal_land ,
sum(imp_bal_land_add_jt) imp_bal_land_add_jt , 
sum(imp_bal_land_add_alter) imp_bal_land_add_alter , 
sum(imp_bal_land_add_other) imp_bal_land_add_other , 
sum(imp_bal_land_reduce_bf) imp_bal_land_reduce_bf , 
sum(imp_bal_land_reduce_alter) imp_bal_land_reduce_alter , 
sum(imp_bal_land_reduce_other) imp_bal_land_reduce_other , 
sum(beg_bal_soft) beg_bal_soft , 
sum(bal_soft_add_pur) bal_soft_add_pur  ,
sum(bal_soft_add_cons) bal_soft_add_cons , 
sum(bal_soft_add_alter) bal_soft_add_alter ,
sum(bal_soft_add_other) bal_soft_add_other ,
sum(bal_soft_reduce_bf) bal_soft_reduce_bf , 
sum(bal_soft_reduce_alter) bal_soft_reduce_alter , 
sum(bal_soft_reduce_other) bal_soft_reduce_other , 
sum(dep_beg_bal_soft) dep_beg_bal_soft , 
sum(dep_bal_soft_add_jt) dep_bal_soft_add_jt ,
sum(dep_bal_soft_add_pur) dep_bal_soft_add_pur , 
sum(dep_bal_soft_add_cons) dep_bal_soft_add_cons ,
sum(dep_bal_soft_add_alter) dep_bal_soft_add_alter ,
sum(dep_bal_soft_add_other) dep_bal_soft_add_other ,
sum(dep_bal_soft_reduce_bf) dep_bal_soft_reduce_bf ,
sum(dep_bal_soft_reduce_alter) dep_bal_soft_reduce_alter ,
sum(dep_bal_soft_reduce_other) dep_bal_soft_reduce_other ,
sum(imp_beg_bal_soft) imp_beg_bal_soft , 
sum(imp_bal_soft_add_jt) imp_bal_soft_add_jt ,
sum(imp_bal_soft_add_alter) imp_bal_soft_add_alter ,
sum(imp_bal_soft_add_other) imp_bal_soft_add_other,
sum(imp_bal_soft_reduce_bf) imp_bal_soft_reduce_bf ,
sum(imp_bal_soft_reduce_alter) imp_bal_soft_reduce_alter ,
sum(imp_bal_soft_reduce_other) imp_bal_soft_reduce_other ,
sum(beg_bal_aut) beg_bal_aut ,
sum(bal_aut_add_pur) bal_aut_add_pur ,
sum(bal_aut_add_cons) bal_aut_add_cons ,
sum(bal_aut_add_alter) bal_aut_add_alter ,
sum(bal_aut_add_other) bal_aut_add_other ,
sum(bal_aut_reduce_bf) bal_aut_reduce_bf ,
sum(bal_aut_reduce_alter) bal_aut_reduce_alter ,
sum(bal_aut_reduce_other) bal_aut_reduce_other ,
sum(dep_beg_bal_aut) dep_beg_bal_aut , 
sum(dep_aut_add_jt) dep_aut_add_jt , 
sum(dep_aut_add_pur) dep_aut_add_pur ,
sum(dep_aut_add_cons) dep_aut_add_cons , 
sum(dep_aut_add_alter) dep_aut_add_alter ,
sum(dep_aut_add_other) dep_aut_add_other ,
sum(dep_aut_reduce_bf) dep_aut_reduce_bf , 
sum(dep_aut_reduce_alter) dep_aut_reduce_alter , 
sum(dep_aut_reduce_other) dep_aut_reduce_other , 
sum(imp_beg_bal_aut) imp_beg_bal_aut , 
sum(imp_bal_aut_add_jt) imp_bal_aut_add_jt , 
sum(imp_bal_aut_add_alter) imp_bal_aut_add_alter ,
sum(imp_bal_aut_add_other) imp_bal_aut_add_other ,
sum(imp_bal_aut_reduce_bf) imp_bal_aut_reduce_bf , 
sum(imp_bal_aut_reduce_alter) imp_bal_aut_reduce_alter ,
sum(imp_bal_aut_reduce_other) imp_bal_aut_reduce_other , 
sum(beg_bal_other) beg_bal_other ,
sum(bal_other_add_pur) bal_other_add_pur ,
sum(bal_other_add_cons) bal_other_add_cons ,
sum(bal_other_add_alter) bal_other_add_alter , 
sum(bal_other_add_other) bal_other_add_other , 
sum(bal_other_reduce_bf) bal_other_reduce_bf ,
sum(bal_other_reduce_alter) bal_other_reduce_alter ,
sum(bal_other_reduce_other) bal_other_reduce_other , 
sum(dep_beg_bal_other) dep_beg_bal_other , 
sum(dep_bal_other_add_jt) dep_bal_other_add_jt ,
sum(dep_bal_other_add_pur) dep_bal_other_add_pur ,
sum(dep_bal_other_add_cons) dep_bal_other_add_cons , 
sum(dep_bal_other_add_alter) dep_bal_other_add_alter ,
sum(dep_bal_other_add_other) dep_bal_other_add_other ,
sum(dep_bal_other_reduce_bf) dep_bal_other_reduce_bf , 
sum(dep_bal_other_reduce_alter) dep_bal_other_reduce_alter  ,
sum(dep_bal_other_reduce_other) dep_bal_other_reduce_other , 
sum(imp_beg_bal_other) imp_beg_bal_other , 
sum(imp_bal_other_add_jt) imp_bal_other_add_jt , 
sum(imp_bal_other_add_alter) imp_bal_other_add_alter , 
sum(imp_bal_other_add_other) imp_bal_other_add_other , 
sum(imp_bal_other_reduce_bf) imp_bal_other_reduce_bf , 
sum(imp_bal_other_reduce_alter) imp_bal_other_reduce_alter , 
sum(imp_bal_other_reduce_other) imp_bal_other_reduce_other ,
sum(bal_land_dx) bal_land_dx , 
sum(bal_soft_dx) bal_soft_dx , 
sum(bal_aut_dx) bal_aut_dx, 
sum(bal_other_dx) bal_other_dx , 
sum(dep_bal_land_dx) dep_bal_land_dx , 
sum(dep_bal_soft_dx)  dep_bal_soft_dx, 
sum(dep_bal_aut_dx) dep_bal_aut_dx, 
sum(dep_bal_other_dx) dep_bal_other_dx, 
sum(imp_bal_land_dx) imp_bal_land_dx, 
sum(imp_bal_soft_dx ) imp_bal_soft_dx, 
sum(imp_bal_aut_dx) imp_bal_aut_dx, 
sum(imp_bal_other_dx) imp_bal_other_dx 

from 
(
select cc.code org_code ,cc.name org_name ,  
bb.m10039  beg_bal_land , --B6	期初余额土地使用权	数值	(wxzc01)无形资产	iufo_measure_data_n3nl7yf0	m10039
bb.m10038  bal_land_add_pur,   --B8	购置土地使用权	数值	(wxzc01)无形资产	iufo_measure_data_n3nl7yf0	m10038
bb.m10047  bal_land_add_cons , --B9	在建工程转入土地使用权	数值	(wxzc01)无形资产	iufo_measure_data_n3nl7yf0	m10047
bb.mqx24bc bal_LAND_ADD_alter ,    --B10	变动土地使用权	数值	(wxzc01)无形资产	iufo_measure_data_n3nl7yf0	mqx24bc
bb.ma6a3xd bal_land_add_other ,  --B11	其他土地使用权	数值	(wxzc01)无形资产	iufo_measure_data_n3nl7yf0	ma6a3xd
bb.m10036  bal_land_reduce_bf,   --B13	处置土地使用权	数值	(wxzc01)无形资产	iufo_measure_data_n3nl7yf0	m10036
bb.mk31pip bal_land_reduce_alter ,  --B14	变动土地使用权B14	数值	(wxzc01)无形资产	iufo_measure_data_n3nl7yf0	mk31pip
bb.mapl1tp bal_land_reduce_other ,   --B15	其他土地使用权B15	数值	(wxzc01)无形资产	iufo_measure_data_n3nl7yf0	mapl1tp
0  bal_land_dx , 
bb.m10012  dep_beg_bal_land ,   --B18	期初余额土地使用权B14	数值	(wxzc01)无形资产	iufo_measure_data_n3nl7yf0	m10012
bb.m10033  dep_bal_land_add_jt ,   --B20	计提土地使用权	数值	(wxzc01)无形资产	iufo_measure_data_n3nl7yf0	m10033
bb.muqjvqi dep_bal_land_add_pur,   --B21	购置土地使用权B21	数值	(wxzc01)无形资产	iufo_measure_data_n3nl7yf0	muqjvqi
bb.mjoopbd dep_bal_land_add_cons,  --B22	在建工程转入土地使用权B22	数值	(wxzc01)无形资产	iufo_measure_data_n3nl7yf0	mjoopbd 

bb.m6tlpi7 dep_bal_land_add_alter ,   --B23	变动土地使用权B21	数值	(wxzc01)无形资产	iufo_measure_data_n3nl7yf0	m6tlpi7
bb.m57h69c dep_bal_land_add_other ,  --B24	其他土地使用权B22	数值	(wxzc01)无形资产	iufo_measure_data_n3nl7yf0	m57h69c
 
bb.m10086  dep_bal_land_reduce_bf,  --B26	处置土地使用权B18	数值	(wxzc01)无形资产	iufo_measure_data_n3nl7yf0	m10086
bb.m5fdyd1 dep_bal_land_reduce_alter ,  --B27	变动土地使用权B25	数值	(wxzc01)无形资产	iufo_measure_data_n3nl7yf0	m5fdyd1
bb.mwbzzas dep_bal_land_reduce_other , --B28	其他土地使用权B26	数值	(wxzc01)无形资产	iufo_measure_data_n3nl7yf0	mwbzzas
0 dep_bal_land_dx , 
bb.m10009  imp_beg_bal_land ,  --B31	期初余额土地使用权B21	数值	(wxzc01)无形资产	iufo_measure_data_n3nl7yf0	m10009
bb.m10043  imp_bal_land_add_jt ,  --B33	计提土地使用权B23	数值	(wxzc01)无形资产	iufo_measure_data_n3nl7yf0	m10043
bb.mmvfx38 imp_bal_land_add_alter ,   --B34	变动土地使用权B32	数值	(wxzc01)无形资产	iufo_measure_data_n3nl7yf0	mmvfx38
bb.mjywqac imp_bal_land_add_other ,  --B35	其他土地使用权B33	数值	(wxzc01)无形资产	iufo_measure_data_n3nl7yf0	mjywqac

bb.m10027  imp_bal_land_reduce_bf ,  --B37	处置土地使用权B25	数值	(wxzc01)无形资产	iufo_measure_data_n3nl7yf0	m10027
bb.mwalyc4 imp_bal_land_reduce_alter,  --B38	变动土地使用权B36	数值	(wxzc01)无形资产	iufo_measure_data_n3nl7yf0	mwalyc4
bb.m6rnvio imp_bal_land_reduce_other ,   --B39	其他土地使用权B37	数值	(wxzc01)无形资产	iufo_measure_data_n3nl7yf0	m6rnvio
0 imp_bal_land_dx , 
bb.m10053  beg_bal_soft ,  --C6	期初余额办公软件	数值	(wxzc01)无形资产	iufo_measure_data_n3nl7yf0	m10053
bb.m10032  bal_soft_add_pur , --C8	购置办公软件	数值	(wxzc01)无形资产	iufo_measure_data_n3nl7yf0	m10032
bb.m10073  bal_soft_add_cons,--C9	在建工程转入办公软件	数值	(wxzc01)无形资产	iufo_measure_data_n3nl7yf0	m10073
bb.muv69wb bal_soft_add_alter,  --C10	变动办公软件	数值	(wxzc01)无形资产	iufo_measure_data_n3nl7yf0	muv69wb
bb.mzptwd2 bal_soft_add_other, --C11	其他办公软件	数值	(wxzc01)无形资产	iufo_measure_data_n3nl7yf0	mzptwd2

bb.m10050  bal_soft_reduce_bf, --C13	处置办公软件	数值	(wxzc01)无形资产	iufo_measure_data_n3nl7yf0	m10050
bb.mibmu13 bal_soft_reduce_alter, --C14	变动办公软件C14	数值	(wxzc01)无形资产	iufo_measure_data_n3nl7yf0	mibmu13
bb.mbox5hm bal_soft_reduce_other , --C15	其他办公软件C15	数值	(wxzc01)无形资产	iufo_measure_data_n3nl7yf0	mbox5hm
0 bal_soft_dx , 
bb.m10084  dep_beg_bal_soft , --C18	期初余额办公软件C14	数值	(wxzc01)无形资产	iufo_measure_data_n3nl7yf0
bb.m10026  dep_bal_soft_add_jt , --C20	计提办公软件	数值	(wxzc01)无形资产	iufo_measure_data_n3nl7yf0	m10026
bb.m51thmx dep_bal_soft_add_pur , --C21	购置办公软件C21	数值	(wxzc01)无形资产	iufo_measure_data_n3nl7yf0	m51thmx
bb.mqy6z03 dep_bal_soft_add_cons , --C22	在建工程转入办公软件C22	数值	(wxzc01)无形资产	iufo_measure_data_n3nl7yf0	mqy6z03
bb.mwn9zvi dep_bal_soft_add_alter, --C23	变动办公软件C21	数值	(wxzc01)无形资产	iufo_measure_data_n3nl7yf0	mwn9zvi
bb.m4ewlvb dep_bal_soft_add_other, --C24	其他办公软件C22	数值	(wxzc01)无形资产	iufo_measure_data_n3nl7yf0	m4ewlvb
bb.m10092  dep_bal_soft_reduce_bf, --C26	处置办公软件C18	数值	(wxzc01)无形资产	iufo_measure_data_n3nl7yf0	m10092
bb.m61f0gw dep_bal_soft_reduce_alter, --C27	变动办公软件C25	数值	(wxzc01)无形资产	iufo_measure_data_n3nl7yf0	m61f0gw 
bb.mc5pu6l dep_bal_soft_reduce_other,  --C28	其他办公软件C26	数值	(wxzc01)无形资产	iufo_measure_data_n3nl7yf0	mc5pu6l
0 dep_bal_soft_dx ,
bb.m10087  imp_beg_bal_soft , --C31	期初余额办公软件C21	数值	(wxzc01)无形资产	iufo_measure_data_n3nl7yf0	m10087
bb.m10001  imp_bal_soft_add_jt,  --C33	计提办公软件C23	数值	(wxzc01)无形资产	iufo_measure_data_n3nl7yf0	m10001
bb.m7ibb55 imp_bal_soft_add_alter , --C34	变动办公软件C32	数值	(wxzc01)无形资产	iufo_measure_data_n3nl7yf0	m7ibb55 
bb.mg4d6nr  imp_bal_soft_add_other, --C35	其他办公软件C33	数值	(wxzc01)无形资产	iufo_measure_data_n3nl7yf0	mg4d6nr
 
 
bb.m10025  imp_bal_soft_reduce_bf , --C37	处置办公软件C25	数值	(wxzc01)无形资产	iufo_measure_data_n3nl7yf0	m10025
bb.m5ai6p1 imp_bal_soft_reduce_alter , --C38	变动办公软件C36	数值	(wxzc01)无形资产	iufo_measure_data_n3nl7yf0	m5ai6p1
bb.meww8ks imp_bal_soft_reduce_other  , --C39	其他办公软件C37	数值	(wxzc01)无形资产	iufo_measure_data_n3nl7yf0	meww8ks
 0 imp_bal_soft_dx  ,
 
bb.m10018  beg_bal_aut ,  --D6	期初余额特许经营权	数值	(wxzc01)无形资产	iufo_measure_data_n3nl7yf0	m10018
bb.m10031  bal_aut_add_pur,  --D8	购置特许经营权	数值	(wxzc01)无形资产	iufo_measure_data_n3nl7yf0	m10031
bb.m10091  bal_aut_add_cons ,  --D9	在建工程转入特许经营权	数值	(wxzc01)无形资产	iufo_measure_data_n3nl7yf0	m10091
bb.ml05srk bal_aut_add_alter ,  --D10	变动特许经营权	数值	(wxzc01)无形资产	iufo_measure_data_n3nl7yf0	ml05srk
bb.mlh47g2 bal_aut_add_other,   --D11	其他特许经营权	数值	(wxzc01)无形资产	iufo_measure_data_n3nl7yf0	mlh47g2
bb.m10071  bal_aut_reduce_bf , --D13	处置特许经营权	数值	(wxzc01)无形资产	iufo_measure_data_n3nl7yf0	m10071
bb.mxiqf0n bal_aut_reduce_alter ,  --D14	变动特许经营权D14	数值	(wxzc01)无形资产	iufo_measure_data_n3nl7yf0	mxiqf0n
bb.mouax5y bal_aut_reduce_other,  --D15	其他特许经营权D15	数值	(wxzc01)无形资产	iufo_measure_data_n3nl7yf0	mouax5y
0 bal_aut_dx , 
bb.m10095  dep_beg_bal_aut ,  --D18	期初余额特许经营权D14	数值	(wxzc01)无形资产	iufo_measure_data_n3nl7yf0	m10095
bb.m10056  dep_aut_add_jt ,   --D20	计提特许经营权	数值	(wxzc01)无形资产	iufo_measure_data_n3nl7yf0	m10056
bb.mp7aso7 dep_aut_add_pur ,  --D21	购置特许经营权D21	数值	(wxzc01)无形资产	iufo_measure_data_n3nl7yf0	mp7aso7
bb.mex3ku7 dep_aut_add_cons ,  --D22	在建工程转入特许经营权D22	数值	(wxzc01)无形资产	iufo_measure_data_n3nl7yf0	mex3ku7 
bb.m2z2nya dep_aut_add_alter,  -- D23	变动特许经营权D21	数值	(wxzc01)无形资产	iufo_measure_data_n3nl7yf0	m2z2nya 
bb.mukii5d dep_aut_add_other,  --D24	其他特许经营权D22	数值	(wxzc01)无形资产	iufo_measure_data_n3nl7yf0	mukii5d
 
bb.m10024  dep_aut_reduce_bf ,  --D26	处置特许经营权D18	数值	(wxzc01)无形资产	iufo_measure_data_n3nl7yf0	m10024
bb.muttcvn  dep_aut_reduce_alter , --D27	变动特许经营权D25	数值	(wxzc01)无形资产	iufo_measure_data_n3nl7yf0	muttcvn
bb.mwexx4m  dep_aut_reduce_other,  --D28	其他特许经营权D26	数值	(wxzc01)无形资产	iufo_measure_data_n3nl7yf0	mwexx4m
0 dep_bal_aut_dx , 
bb.m10045  imp_beg_bal_aut ,  --D31	期初余额特许经营权D21	数值	(wxzc01)无形资产	iufo_measure_data_n3nl7yf0	m10045
bb.m10013  imp_bal_aut_add_jt ,  --D33	计提特许经营权D23	数值	(wxzc01)无形资产	iufo_measure_data_n3nl7yf0	m10013
bb.mcuntts imp_bal_aut_add_alter ,  --D34	变动特许经营权D32	数值	(wxzc01)无形资产	iufo_measure_data_n3nl7yf0	mcuntts 
bb.mid2v6i imp_bal_aut_add_other,  --D35	其他特许经营权D33	数值	(wxzc01)无形资产	iufo_measure_data_n3nl7yf0	mid2v6i 
bb.m10022  imp_bal_aut_reduce_bf ,  --D37	处置特许经营权D25	数值	(wxzc01)无形资产	iufo_measure_data_n3nl7yf0	m10022
bb.mso7tb8 imp_bal_aut_reduce_alter ,  --D38	变动特许经营权D36	数值	(wxzc01)无形资产	iufo_measure_data_n3nl7yf0	mso7tb8
bb.m3xlw9j imp_bal_aut_reduce_other ,  --D39	其他特许经营权D37	数值	(wxzc01)无形资产	iufo_measure_data_n3nl7yf0	m3xlw9j
 0 imp_bal_aut_dx , 
 
bb.mro6770 beg_bal_other , --E6	期初余额其他	数值	(wxzc01)无形资产	iufo_measure_data_n3nl7yf0	mro6770
bb.mzvovhn bal_other_add_pur ,   --E8	购置其他	数值	(wxzc01)无形资产	iufo_measure_data_n3nl7yf0	mzvovhn
bb.m7d0fot bal_other_add_cons ,   --E9	在建工程转入其他	数值	(wxzc01)无形资产	iufo_measure_data_n3nl7yf0	m7d0fot
bb.m4xdhjb bal_other_add_alter,    --E10	变动其他	数值	(wxzc01)无形资产	iufo_measure_data_n3nl7yf0	m4xdhjb
bb.mjml344 bal_other_add_other ,   --E11	其他其他	数值	(wxzc01)无形资产	iufo_measure_data_n3nl7yf0	mjml344
bb.m4xbvhb bal_other_reduce_bf ,   --E13	处置其他	数值	(wxzc01)无形资产	iufo_measure_data_n3nl7yf0	m4xbvhb 
bb.mm0z0s2 bal_other_reduce_alter ,   --E14	变动其他E14	数值	(wxzc01)无形资产	iufo_measure_data_n3nl7yf0	mm0z0s2
bb.md2w16y bal_other_reduce_other,   --E15	其他其他E15	数值	(wxzc01)无形资产	iufo_measure_data_n3nl7yf0	md2w16y
0 bal_other_dx , 
bb.m7lxagc dep_beg_bal_other ,  --E18	期初余额其他E14	数值	(wxzc01)无形资产	iufo_measure_data_n3nl7yf0	m7lxagc 
bb.m0ax22l dep_bal_other_add_jt ,   --E20	计提其他	数值	(wxzc01)无形资产	iufo_measure_data_n3nl7yf0	m0ax22l
bb.mvzf12m dep_bal_other_add_pur ,  --E21	购置其他E21	数值	(wxzc01)无形资产	iufo_measure_data_n3nl7yf0	mvzf12m
bb.maloaaw dep_bal_other_add_cons,  --E22	在建工程转入其他E22	数值	(wxzc01)无形资产	iufo_measure_data_n3nl7yf0	maloaaw
bb.mg8fb50 dep_bal_other_add_alter ,   --E23	变动其他E21	数值	(wxzc01)无形资产	iufo_measure_data_n3nl7yf0	mg8fb50 
bb.malm10p dep_bal_other_add_other,  --E24	其他其他E22	数值	(wxzc01)无形资产	iufo_measure_data_n3nl7yf0	malm10p
bb.mkzsqkm dep_bal_other_reduce_bf,   --E26	处置其他E18	数值	(wxzc01)无形资产	iufo_measure_data_n3nl7yf0	mkzsqkm 
bb.mazgmv0 dep_bal_other_reduce_alter ,    --E27	变动其他E25	数值	(wxzc01)无形资产	iufo_measure_data_n3nl7yf0	mazgmv0
bb.mnicvx6 dep_bal_other_reduce_other,   --E28	其他其他E26	数值	(wxzc01)无形资产	iufo_measure_data_n3nl7yf0	mnicvx6
0 dep_bal_other_dx , 
bb.m2n9dlk imp_beg_bal_other ,  --E31	期初余额其他E21	数值	(wxzc01)无形资产	iufo_measure_data_n3nl7yf0	m2n9dlk
bb.mbaly46 imp_bal_other_add_jt ,   --E33	计提其他E23	数值	(wxzc01)无形资产	iufo_measure_data_n3nl7yf0	mbaly46
bb.m214xek imp_bal_other_add_alter ,   --E34	变动其他E32	数值	(wxzc01)无形资产	iufo_measure_data_n3nl7yf0	m214xek
bb.my5m44s imp_bal_other_add_other,    --E35	其他其他E33	数值	(wxzc01)无形资产	iufo_measure_data_n3nl7yf0	my5m44s
bb.mc75aes imp_bal_other_reduce_bf ,   --E37	处置其他E25	数值	(wxzc01)无形资产	iufo_measure_data_n3nl7yf0	mc75aes
bb.mfoapa6 imp_bal_other_reduce_alter ,   --E38	变动其他E36	数值	(wxzc01)无形资产	iufo_measure_data_n3nl7yf0	mfoapa6
bb.m365hia imp_bal_other_reduce_other ,   --E39	其他其他E37	数值	(wxzc01)无形资产	iufo_measure_data_n3nl7yf0	m365hia
 
0 imp_bal_other_dx 
from  IUFO_MEASPUB_0011  aa

inner join  iufo_measure_data_n3nl7yf0  bb  
      on(
       
           bb.alone_id  = aa.alone_id  
           and nvl(bb.dr , 0 ) = 0 
           and nvl(aa.dr , 0) = 0 
           and aa.keyword1 in (

select children_pk_org  pk_org_list from (select  zz.code  children_org_code ,zz.name  children_org_name  ,yy.pk_org children_pk_org    , (select decode( count(pk_org)  , 0 , 'n' , 'y') b_father    from ORG_RCSMEMBER  mm where mm.pk_fatherorg  =  yy.pk_org ) b_father  , 'n' b_self from  org_orgs zz ,  ORG_RCSMEMBER yy   ,org_financeorg  xx  where 1=1 and zz.dr = 0 and zz.pk_org = yy.pk_org   and yy.dr =0  and yy.pk_fatherorg = xx.pk_financeorg  and xx.dr = 0 and xx.code = parameter('org_code_param') union all select mm.code  children_org_code  , mm.name children_org_name ,   mm.pk_financeorg  children_pk_org    , (select decode( count(pk_org)  , 0 , 'n' , 'y') b_father   from ORG_RCSMEMBER kk  where  kk.pk_fatherorg  = mm.pk_financeorg  ) b_father  , 'y' b_self from org_financeorg mm  where mm.dr = 0 and mm.code = parameter('org_code_param')) where  b_father = 'n'   or  b_self ='y'


)
           and aa.keyword2 = parameter('year_month_param')
      
      )    
inner join org_financeorg  cc  
     on(  cc.pk_financeorg  = aa.keyword1 and cc.dr = 0  )
     
     
union all 


select cc.code org_code , cc.name org_name, 
bb.m10049  beg_bal_land , --B6	期初余额土地使用权	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	m10049
bb.m10125  bal_land_add_pur,   --B8	购置土地使用权	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	m10125
bb.m10151  bal_land_add_cons , --B9	在建工程转入土地使用权	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	m10151
bb.m10008 bal_LAND_ADD_alter ,    --B10	变动土地使用权	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	m10008
bb.m10089 bal_land_add_other ,  --B11	其他土地使用权	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	m10089
bb.m10136  bal_land_reduce_bf,   --B13	处置土地使用权	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	m10136
bb.m10156 bal_land_reduce_alter ,  --B14	变动土地使用权B14	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	m10156
bb.m10090 bal_land_reduce_other ,   --B15	其他土地使用权B15	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	m10090
bb.mvt4c48 bal_land_dx , --B16	合并抵销土地使用权	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	mvt4c48
bb.m10098  dep_beg_bal_land ,   --B18	期初余额土地使用权B14	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	m10098
bb.m10005  dep_bal_land_add_jt ,   --B20	计提土地使用权	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	m10005
bb.m10102 dep_bal_land_add_pur,   --B21	变动土地使用权B21	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	m10102
bb.m2dt4lb dep_bal_land_add_cons,  --B22	在建工程转入土地使用权B22	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	m2dt4lb

bb.mapja6m dep_bal_land_add_alter ,   --B23	变动土地使用权B23	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	mapja6m
bb.m10012 dep_bal_land_add_other ,  --B24	其他土地使用权B22	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	m10012
 
bb.m10120  dep_bal_land_reduce_bf,  --B26	处置土地使用权B18	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	m10120
bb.m10065 dep_bal_land_reduce_alter ,  --B27	变动土地使用权B25	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	m10065
bb.m10107 dep_bal_land_reduce_other , --B28	其他土地使用权B26	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	m10107
bb.m4uw0qk dep_bal_land_dx , -- B30	合并抵销土地使用权B30	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	m4uw0qk
bb.m10010  imp_beg_bal_land ,  --B31	期初余额土地使用权B21	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	m10010
bb.m10085  imp_bal_land_add_jt ,  --B33	计提土地使用权B23	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	m10085
bb.m10039 imp_bal_land_add_alter ,   --B34	变动土地使用权B32	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	m10039
bb.m10055 imp_bal_land_add_other ,  --B35	其他土地使用权B33	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	m10055

bb.m10140  imp_bal_land_reduce_bf ,  --B37	处置土地使用权B25	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	m10140
bb.m10062 imp_bal_land_reduce_alter,  --B38	变动土地使用权B36	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	m10062
bb.m10077 imp_bal_land_reduce_other ,   --B39	其他土地使用权B37	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	m10077
bb.m42642f imp_bal_land_dx , -- B42	合并抵销土地使用权B42	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	m42642f


bb.m10018  beg_bal_soft ,  --C6	期初余额办公软件	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	m10018
bb.m10083  bal_soft_add_pur , --C8	购置办公软件	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	m10083
bb.m10058  bal_soft_add_cons,--C9	在建工程转入办公软件	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	m10058
bb.m10148 bal_soft_add_alter,  --C10	变动办公软件	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	m10148
bb.m10126 bal_soft_add_other, --C11	其他办公软件	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	m10126

bb.m10028  bal_soft_reduce_bf, --C13	处置办公软件	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	m10028
bb.m10155 bal_soft_reduce_alter, --C14	变动办公软件C14	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	m10155
bb.m10152 bal_soft_reduce_other , --C15	其他办公软件C15	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	m10152
bb.m8k73ka bal_soft_dx , -- C16	合并抵销办公软件	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	m8k73ka
bb.m10114  dep_beg_bal_soft , --C18	期初余额办公软件C14	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	m10114
bb.m10017  dep_bal_soft_add_jt , --C20	计提办公软件	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	m10017
bb.m10093 dep_bal_soft_add_pur , --C21	变动办公软件C21	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	m10093
bb.mgpojl5 dep_bal_soft_add_cons , --C22	在建工程转入办公软件C22	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	mgpojl5
bb.mfd8kqo dep_bal_soft_add_alter, --C23	变动办公软件C23	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	mfd8kqo
bb.m10119 dep_bal_soft_add_other, --C24	其他办公软件C22	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	m10119
bb.m10006  dep_bal_soft_reduce_bf, --C26	处置办公软件C18	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	m10006
bb.m10110 dep_bal_soft_reduce_alter, --C27	变动办公软件C25	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	m10110
bb.m10099 dep_bal_soft_reduce_other,  --C28	其他办公软件C26	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	m10099
bb.mhpojmz dep_bal_soft_dx , -- C30	合并抵销办公软件C30	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	mhpojmz

bb.m10043  imp_beg_bal_soft , --C31	期初余额办公软件C21	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	m10043
bb.m10103  imp_bal_soft_add_jt,  --C33	计提办公软件C23	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	m10103
bb.m10068 imp_bal_soft_add_alter , --C34	变动办公软件C32	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	m10068
bb.m10153  imp_bal_soft_add_other, --C35	其他办公软件C33	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	m10153
 
 
bb.m10116  imp_bal_soft_reduce_bf , --C37	处置办公软件C25	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	m10116
bb.m10074 imp_bal_soft_reduce_alter , --C38	变动办公软件C36	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	m10074
bb.m10141 imp_bal_soft_reduce_other  , --C39	其他办公软件C37	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	m10141
bb.m346aov imp_bal_soft_dx , -- C42	合并抵销办公软件C42	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	m346aov
 
 
bb.m10076  beg_bal_aut ,  --D6	期初余额特许经营权	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	m10076
bb.m10128  bal_aut_add_pur,  --D8	购置特许经营权	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	m10128
bb.m10022  bal_aut_add_cons ,  --D9	在建工程转入特许经营权	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	m10022
bb.m10084 bal_aut_add_alter ,  --D10	变动特许经营权	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	m10084
bb.m10030 bal_aut_add_other,   --D11	其他特许经营权	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	m10030
bb.m10070  bal_aut_reduce_bf , --D13	处置特许经营权	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	m10070
bb.m10123 bal_aut_reduce_alter ,  --D14	变动特许经营权D14	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	m10123
bb.m10051 bal_aut_reduce_other,  --D15	其他特许经营权D15	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	m10051
bb.mayv8wu bal_aut_dx , -- D16	合并抵销特许经营权	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	mayv8wu
bb.m10075  dep_beg_bal_aut ,  --D18	期初余额特许经营权D14	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	m10075
bb.m10095  dep_aut_add_jt ,   --D20	计提特许经营权	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	m10095
bb.m10027 dep_aut_add_pur ,  --D21	变动特许经营权D21	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	m10027
bb.mpjs502 dep_aut_add_cons ,  --D22	在建工程转入特许经营权D22	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	mpjs502
bb.mopoxf1 dep_aut_add_alter,  -- D23	变动特许经营权D23	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	mopoxf1
bb.m10003 dep_aut_add_other,  --D24	其他特许经营权D22	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	m10003
 
bb.m10053  dep_aut_reduce_bf ,  --D26	处置特许经营权D18	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	m10053
bb.m10164  dep_aut_reduce_alter , --D27	变动特许经营权D25	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	m10164
bb.m10004  dep_aut_reduce_other,  --D28	其他特许经营权D26	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	m10004
bb.mdlix7v  dep_bal_aut_dx , -- D30	合并抵销特许经营权D30	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	mdlix7v
   
bb.m10045  imp_beg_bal_aut ,  --D31	期初余额特许经营权D21	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	m10045
bb.m10020  imp_bal_aut_add_jt ,  --D33	计提特许经营权D23	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	m10020
bb.m10106 imp_bal_aut_add_alter ,  --D34	变动特许经营权D32	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	m10106
bb.m10014 imp_bal_aut_add_other,  --D35	其他特许经营权D33	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	m10014
bb.m10056  imp_bal_aut_reduce_bf ,  --D37	处置特许经营权D25	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	m10056
bb.m10016 imp_bal_aut_reduce_alter ,  --D38	变动特许经营权D36	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	m10016
bb.m10159 imp_bal_aut_reduce_other ,  --D39	其他特许经营权D37	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	m10159
bb.mqzrf1t imp_bal_aut_dx  , -- D42	合并抵销特许经营权D42	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	mqzrf1t
 
bb.m10025 beg_bal_other , --E6	期初余额其他	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	m10025
bb.m10038 bal_other_add_pur ,   --E8	购置其他	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	m10038
bb.m10078 bal_other_add_cons ,   --E9	在建工程转入其他	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	m10078
bb.m10082 bal_other_add_alter,    --E10	变动其他	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	m10082
bb.m10145 bal_other_add_other ,   --E11	其他其他	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	m10145
bb.m10117 bal_other_reduce_bf ,   --E13	处置其他	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	m10117
bb.m10071 bal_other_reduce_alter ,   --E14	变动其他E14	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	m10071
bb.m10129 bal_other_reduce_other,   --E15	其他其他E15	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	m10129
bb.mirdbwt bal_other_dx , -- E16	合并抵销其他	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	mirdbwt
bb.m10096 dep_beg_bal_other ,  --E18	期初余额其他E14	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	m10096
bb.m10059 dep_bal_other_add_jt ,   --E20	计提其他	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	m10059
bb.m10127 dep_bal_other_add_pur ,  --E21	变动其他E21	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	m10127
bb.mv62y0t dep_bal_other_add_cons,  --E22	在建工程转入其他E22	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	mv62y0t
bb.msu4s4u dep_bal_other_add_alter ,   --E23	变动其他E23	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	msu4s4u
bb.m10046 dep_bal_other_add_other,  --E24	其他其他E22	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	m10046
bb.m10054 dep_bal_other_reduce_bf,   --E26	处置其他E18	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	m10054
bb.m10122 dep_bal_other_reduce_alter ,    --E27	变动其他E25	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	m10122
bb.m10063 dep_bal_other_reduce_other,   --E28	其他其他E26	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	m10063
bb.m5q5aua dep_bal_other_dx , -- E30	合并抵销其他E30	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	m5q5aua

bb.m10105 imp_beg_bal_other ,  --E31	期初余额其他E21	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	m10105
bb.m10088 imp_bal_other_add_jt ,   --E33	计提其他E23	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	m10088
bb.m10113 imp_bal_other_add_alter ,   --E34	变动其他E32	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	m10113
bb.m10057 imp_bal_other_add_other,    --E35	其他其他E33	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	m10057
bb.m10104 imp_bal_other_reduce_bf ,   --E37	处置其他E25	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	m10104
bb.m10080 imp_bal_other_reduce_alter ,   --E38	变动其他E36	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	m10080
bb.m10097 imp_bal_other_reduce_other,  --E39	其他其他E37	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	m10097
bb.mhn5vq1 imp_bal_other_dx  -- E42	合并抵销其他E42	数值	(wxzc03)无形资产_合并	iufo_measure_data_ypzuun0l	mhn5vq1 
       
from  IUFO_MEASPUB_0011  aa

inner join  iufo_measure_data_ypzuun0l  bb  
      on(
       
           bb.alone_id  = aa.alone_id  
           and nvl(bb.dr , 0 ) = 0 
           and nvl(aa.dr , 0) = 0 
           and aa.keyword1 in (

               select children_pk_org  pk_org_list from (select  zz.code  children_org_code ,zz.name  children_org_name  ,yy.pk_org children_pk_org    , (select decode( count(pk_org)  , 0 , 'n' , 'y') b_father    from ORG_RCSMEMBER  mm where mm.pk_fatherorg  =  yy.pk_org ) b_father  , 'n' b_self from  org_orgs zz ,  ORG_RCSMEMBER yy   ,org_financeorg  xx  where 1=1 and zz.dr = 0 and zz.pk_org = yy.pk_org   and yy.dr =0  and yy.pk_fatherorg = xx.pk_financeorg and xx.dr = 0 and xx.code = parameter('org_code_param') union all select mm.code  children_org_code  , mm.name children_org_name ,   mm.pk_financeorg  children_pk_org    , (select decode( count(pk_org)  , 0 , 'n' , 'y') b_father   from ORG_RCSMEMBER kk  where  kk.pk_fatherorg  = mm.pk_financeorg  ) b_father  , 'y' b_self from org_financeorg mm  where mm.dr = 0 and mm.code = parameter('org_code_param')) where b_father = 'y'  and b_self ='n'

            )
           and aa.keyword2 = parameter('year_month_param')
      
      )    
inner join org_financeorg  cc  
     on(  cc.pk_financeorg  = aa.keyword1 and cc.dr = 0  )

) order by org_code 
