---------------------------货龄分析基础表设置-----------------------
procedure  p_mtl_age_build_table( end_year   varchar2 default 2012 ,
                                  end_month  varchar2 default '07', 
                                  begn_year   varchar2 default 2012 ,
                                  begn_month  varchar2 default '01', 
                                                              corp_code varchar2 default '01' )
    is
    l_year_month  char(6) ;
    l_count   pls_integer ;
    
    l_mtl_pk_table  t_mtl_pk_table ; 
    cursor l_cur is 
           select pk_invbasdoc from bd_invmandoc where pk_corp =v_pk_corp ;
    
    begin
            set_corp_PK(corp_code) ; 
                    
            select count(year_month)   into l_count from inventory_age_aux_2
            where year_month = begn_year||begn_month||v_pk_corp   ; 
                    
            savepoint  p_mtl_age_build_table ; 
            open l_cur ; 
            fetch l_cur bulk collect into l_mtl_pk_table ;
            close l_cur ;
            
            if(l_count =0) then 
              
               --for i in  l_mtl_pk_table.first .. l_mtl_pk_table.last loop 
                 for i in  1 .. l_mtl_pk_table.count loop 
                     
                         p_mtl_verify_by_pk(l_mtl_pk_table(i) , '2001', '01' ,
                                                                end_year ,end_month) ;    
                 end loop ; 
            else
              
                --for i in  l_mtl_pk_table.first .. l_mtl_pk_table.last loop 
                    for i in  1 .. l_mtl_pk_table.count loop 
                 
                    p_mtl_verify_by_pk(l_mtl_pk_table(i) , begn_year, begn_month ,
                                        end_year ,end_month) ;    
               end loop ; 
            end if ;
            
            insert into inventory_age_aux_2 values (end_year||end_month||v_pk_corp);
            
            commit ;
        
            exception 
                  when  NO_DATA_FOUND THEN 
                           dbms_output.put_line('本期没有核销') ; 
                  when  others then 
                         dbms_output.put_line('exception accur') ; 
                         dbms_output.put_line('begin  rollback ') ; 
                         dbms_output.put_line(sqlerrm) ;
                         rollback to p_mtl_age_build_table ;
                          dbms_output.put_line('after  rollback ') ; 
    end ; 

------------------------------------------------------------------------------