
---------------------------根据存货PK进行核销------------
procedure p_mtl_verify_by_pk(   mtl varchar2 ,                            
                                begn_year  varchar2 default '2001' ,
                                begn_month  varchar2 default '01' , 
                                end_year  varchar2 default '2012',
                                end_month  varchar2 default '12' )
is 
l_day  char(2)  ;
l_year  char(4) ;
l_month  char(2) ; 
l_table  t_inv_age_aux_table :=t_inv_age_aux_table();

----存储入库的记录
l_table_in  t_inv_age_aux_table :=t_inv_age_aux_table();
----存储出库的记录
l_table_out  t_inv_age_aux_table :=t_inv_age_aux_table();
l_count pls_integer ; 

l_minus_mark  pls_integer:=0 ;
-----用于判断入库记录是否都已经处理完毕了
l_inend_mark  pls_integer :=0 ; 
l_count_out pls_integer ;
l_count_in  pls_integer ;
------为了生成没有成本计算，因此没有审核日期的单据
l_table_no_audit    t_inv_age_aux_table :=t_inv_age_aux_table(); 
l_count_no_audit pls_integer :=0; 

----存储核销后数量为0 ，金额不为零的金额合计；并同时指定其
----cbilltype 为II 
l_amount_zero  number(20,8) :=0  ;

----临时正数， 用于随时需要
l_int_temp   pls_integer ;

l_cur_no_auditdate  sys_refcursor ;
l_stmt  varchar2(4000) ; 
l_char_temp_table  t_mtl_pk_table :=t_mtl_pk_table();

cursor l_cur  is 
  
       with   befor_table  as 
       (select * from 
                         (select ee.* ,'00000000000000000000' cbill_bid, 
                         ee.dbilldate  dauditdate
                         from inventory_age_aux_1 ee  
                         where ee.pk_corp = v_pk_corp
                         and  ee.cinvbasid = mtl 
                         and  ee.year_month = begn_year ||begn_month
                  
                         union all 
                         
                         select * from inventory_age_aux_3 ff
                   where ff.pk_corp = v_pk_corp
                   and  ff.cinvbasid = mtl 
                   and  ff.year_month = begn_year ||begn_month)
                
                order by dbilldate) ,
                         
       ia_bill_table as (
       select tt.cbilltypecode,tt.cinvbasid,
             --nvl(tt.nnumber,0) nnumber,
             --nvl(tt.nmoney ,0) nmoney,
             nvl(tt.nnumber ,0) curr_nnumber , 
             nvl(tt.nmoney,0) curr_nmoney  ,
             tt.pk_corp,ss.dbilldate,
             '******' year_month  , 
             tt.cbill_bid ,
             tt.dauditdate
             
             from  ia_bill_b  tt , ia_bill ss  
             
             --------------注意，如果没有审核日期的情况下，库存金额或数量可以能与
             --------------NC系统中的不一致，因为存货核算系统中的存货数量是按照
             --------------审核日期来进行确定的
             where   
             tt.dr = 0   
             and tt.cinvbasid = mtl 
             and tt.cbillid = ss.cbillid
             and ss.dr = 0 
             and ss.dbilldate <=end_year||'-'||end_month||'-'||l_day
             and ss.dbilldate >= l_year||'-'||l_month||'-'||'01'
             and ss.pk_corp = v_pk_corp 
             order by ss.dbilldate )
             
             select * from befor_table
             union all
             select * from ia_bill_table ;
begin
          
                
            l_day  := f_daynum(end_year ,    end_month) ;   
                
            

              if(begn_month = '12') then 
                l_year :=begn_year +'1' ;
                    l_month := '01' ;
              elsif(to_number(begn_month) < 9) then 
                  l_year :=begn_year ;
                    l_month := '0'||(begn_month + '1') ;
                else
                    l_year :=begn_year ;
                    l_month :=begn_month +'1' ;
              end if ;
                
           
               

                ---查看是否有没有进行成本计算的单据
                l_stmt := 'select cbill_bid from inventory_age_aux_3  where  pk_corp = :v_pk_corp '||
                                  'and  cinvbasid = :mtl  and  year_month = :the_year ' ; 
                                    
                execute immediate  l_stmt bulk collect into l_char_temp_table
                                     using v_pk_corp , mtl , begn_year||begn_month ;
                
                ----如果有，则查看这些单据的最新审核日期，进行更新                                         
                l_stmt :=  ' update inventory_age_aux_3  ff  set  ff.dauditdate = '||
                           ' (select ee.dauditdate from ia_bill_b ee where ee.dr= 0 and '||
                                     ' ee.cbill_bid= :pk1) '||
                                     ' where ff.cbill_bid = :pk2 ';
             
                for i in  1  .. l_char_temp_table.count loop 
                      execute immediate l_stmt using 
                                     l_char_temp_table(i) ,l_char_temp_table(i) ;
                end loop; 
                
                
                
                open l_cur ; 
                fetch l_cur  bulk collect into l_table  ;
                close l_cur ;
                
            
                
                
                l_count_in :=1 ;
                l_count_out :=1 ;
                l_count_no_audit :=1 ;
                
                
                for  i in 1  ..  l_table.count  loop 
                    ---暂且不考虑没有进行成本计算的情况，因为
                    ----入库调整单虽然没有进行成本计算，但是也生成了
                    -----会计凭证 ； 同时出库单都已经成本计算了
                   /* if(l_table(i).dauditdate is null or l_table(i).dauditdate='1980-01-01') then */
                        if(1=2) then 
                             l_table_no_audit.extend ;
                           l_table_no_audit(l_count_no_audit)  := l_table(i);
                                 l_table_no_audit(l_count_no_audit).dauditdate:='1980-01-01' ;
                                 l_count_no_audit :=l_count_no_audit +1;    
                                 
                  ---暂且不考虑没有进行成本计算的情况，因为
                    ----入库调整单虽然没有进行成本计算，但是也生成了
                    -----会计凭证 ； 同时出库单都已经成本计算了
                    
                        /*elsif(l_table(i).dauditdate> end_year||'-'||end_month||'-'||l_day) then */
                        elsif(1=2) then 
                             l_table_no_audit.extend ;
                           l_table_no_audit(l_count_no_audit)  := l_table(i);
                                 l_count_no_audit :=l_count_no_audit +1;   
                                 
                                 
                                  
                        elsif(l_table(i).cbilltypecode='ii') then 
                              l_table_in.extend ;
                                l_table_in(l_count_in)  := l_table(i);
                                    l_count_in :=l_count_in +1;    
                        elsif(regexp_like(upper(l_table(i).cbilltypecode),'^(I0|I2|I3|I4|I9|IN)')) then  
                           if(l_table(i).curr_nnumber >=0 )   then 
                                l_table_in.extend ;
                                l_table_in(l_count_in)  := l_table(i);
                                    l_count_in :=l_count_in +1;
                              else
                                l_table_out.extend ;
                                l_table_out(l_count_out)  := l_table(i);
                                l_table_out(l_count_out).cbilltypecode :='ou' ;
                        l_table_out(l_count_out).curr_nnumber :=-(l_table_out(l_count_out).curr_nnumber) ;
                                ----------------------金额为相反数
                            l_table_out(l_count_out).curr_nmoney :=-(l_table_out(l_count_out).curr_nmoney);                                    
                                    l_count_out :=l_count_out +1;
                                end if ;
                             
                        
                        else  
                         if(l_table(i).curr_nnumber <0 ) then 
                                l_table_in.extend ;
                                l_table_in(l_count_in)  := l_table(i);
                                    l_table_in(l_count_in).cbilltypecode :='in' ;
                                    l_table_in(l_count_in).curr_nnumber :=-(l_table_in(l_count_in).curr_nnumber) ;
                                    l_table_in(l_count_in).curr_nmoney :=-(l_table_in(l_count_in).curr_nmoney) ;
                                    l_count_in :=l_count_in +1;
                         else 
                                l_table_out.extend ;
                                l_table_out(l_count_out)  := l_table(i);
                                    l_count_out :=l_count_out +1;
                         end if ;
                    end if;
                end loop ;    
                
                l_count_in := 1;
                l_count_out :=1; 
                            
                
                --------------根据出库金额，对入库金额进行核销，按照日期的先后顺序
                for i in  1 .. l_table_in.count  loop 
                      l_inend_mark := i ;
                        ------------有些调整单等，金额有，但是数量为0 ，此时不用核销，
                        ------------但是金额需要记录下来到临时变量中，以便汇总金额余额
                        ------------稍后插入到inventory_age_aux_1表中，出入库类型人为
                        ------------规定为ii   ；同时此行的金额置为0 ，不用插入到aux表中
                        -----------同时此处理要放在出库记录退出处理之前，否则当前的数量
                        -----------为负数的记录得不到在退出整个循环后紧接着的没有
                        ------------处理完的数量为0的入库记录的处理
                        if(l_table_in(i).curr_nnumber = 0 ) then
                            l_amount_zero  := l_amount_zero + l_table_in(i).curr_nmoney ;
                            l_table_in(i).curr_nmoney :=0 ;
                      ------------如果出库的记录都已经遍历完毕了，直接推出循环
                        ------------否则会出现负库存的提示，但是实际并没有负库存发生
                         elsif(l_minus_mark = l_table_out.count) then 
                              if(l_table_out.count >0) then 
                                    
                                    ----------------如果数量不为0 ，说明出库数量大，最后一行
                                    ----------------还没有核销完全，因此不能退出
                                         if(l_table_out(l_table_out.count).curr_nnumber = 0 )  then 
                                                        if(l_table_out(l_table_out.count).curr_nmoney =0) then
                                                                exit ;            
                                ------------------如果金额不为0 ，则需要把金额核销 
                                                        else 
                                                                l_amount_zero  :=l_amount_zero -  
                                                                                                    l_table_out(l_table_out.count).curr_nmoney ; 
                                                                l_table_out(l_table_out.count).curr_nmoney :=0 ;                                    
                                                        end if ;
                                           else
                                    ----------------对出库数量不为零的最后一行进行核销               
                                                            if (l_table_in(i).curr_nnumber <
                                                                    l_table_out(l_table_out.count).curr_nnumber) then 
                                                                        l_table_out(l_table_out.count).curr_nnumber := 
                                                                        l_table_out(l_table_out.count).curr_nnumber - 
                                                                                                      l_table_in(i).curr_nnumber ;
                                                                        l_table_in(i).curr_nnumber  := 0 ;                
                                                                        l_table_out(l_table_out.count).curr_nmoney :=  
                                                                        l_table_out(l_table_out.count).curr_nmoney  - 
                                                                                      l_table_in(i).curr_nmoney ;
                                                                        l_table_in(i).curr_nmoney  := 0 ;            
                                                            elsif(l_table_in(i).curr_nnumber >
                                                                       l_table_out(l_table_out.count).curr_nnumber) then 
                                                                        l_table_in(i).curr_nnumber := l_table_in(i).curr_nnumber - 
                                                                                            l_table_out(l_table_out.count).curr_nnumber ;
                                                                        l_table_in(i).curr_nmoney := l_table_in(i).curr_nmoney - 
                                                                                                l_table_out(l_table_out.count).curr_nmoney ;    
                                                                        l_table_out(l_table_out.count).curr_nnumber   :=0 ;
                                                                        l_table_out(l_table_out.count).curr_nmoney   :=0 ;        
                                                                        exit ;
                                                            else
                                                                        l_table_in(i).curr_nnumber := 0  ;
                                                                            l_table_out(l_table_out.count).curr_nnumber   :=0 ;
                                                                            l_amount_zero  := l_amount_zero +
                                                                                               l_table_in(i).curr_nmoney -
                                                                              l_table_out(l_table_out.count).curr_nmoney ;
                                                                             l_table_out(l_table_out.count).curr_nmoney    :=0;                        
                                                                        exit;    
                                                            end if ;                                        
                                 end if ;
                                          
                                       else
                                              exit ;
                                       end if ;
                              
                        ------------以下进行出库记录的迭代，核销出入库数量        
                        else 
                                for j in l_count_out .. l_table_out.count loop
                                      l_minus_mark := j; 
                                    ----------------如果出库数量为0 ， 有金额，即调整单等单据，不需要核销
                                    ----------------数量了，但是金额记录到临时变量中，以便汇总金额余额;
                                    -----------------同时出库继续向下循环
                                         if(l_table_out(j).curr_nnumber = 0 ) then 
                                             l_amount_zero  :=l_amount_zero -  l_table_out(j).curr_nmoney ;
                                                  l_table_out(j).curr_nmoney :=0 ;
                                    ------------------如果入库数量小于出库数量,入库置为0 ，出库减去入库
                                    ----同时退出库迭代，本次迭代的位置变量J计入临时变量l_count_count ;             
                                         elsif (l_table_in(i).curr_nnumber <l_table_out(j).curr_nnumber) then 
                                                    l_table_out(j).curr_nnumber := l_table_out(j).curr_nnumber - 
                                                                                                                     l_table_in(i).curr_nnumber ;
                                                    l_table_in(i).curr_nnumber  := 0 ;
                                                    
                                                    l_table_out(j).curr_nmoney :=  l_table_out(j).curr_nmoney  -
                                                                                                                 l_table_in(i).curr_nmoney ;
                                                    l_table_in(i).curr_nmoney  := 0 ;         
                                                    l_count_out := j;
                                                    exit ;
                                    ------------------如果入库数量大于出库数量,入库减去出库
                                    ----继续出库循环;                            
                                            elsif(l_table_in(i).curr_nnumber >l_table_out(j).curr_nnumber) then 
                                                    l_table_in(i).curr_nnumber := l_table_in(i).curr_nnumber - 
                                                                                                                     l_table_out(j).curr_nnumber ;
                                                    l_table_in(i).curr_nmoney := l_table_in(i).curr_nmoney - 
                                                                                                                 l_table_out(j).curr_nmoney ;    
                                                        ---赋予出库记录数量为0 ，如果此记录为最后一比记录的话，可以
                                                    ---根据是否为零进行判断是否推出上层循环                                     
                                                    l_table_out(j).curr_nnumber   :=0 ;
                                                    l_table_out(j).curr_nmoney   :=0 ;
                                                                                                                     
                                 --------------------如果出库数量和入库数量相等，推出出库循环
                                 ------------------- 入库数量置为0 ，同时把入库金额减去出库金额计入
                                 --------------------到临时变量中
                                            else
                                                    l_table_in(i).curr_nnumber   :=0 ;
                                        
                                                    
                                                    l_amount_zero  := l_amount_zero +l_table_in(i).curr_nmoney -
                                                                                  l_table_out(j).curr_nmoney ;    
                                                    
                                                    ---赋予出库记录数量为0 ，如果此记录为最后一比记录的话，可以
                                                    ---根据是否为零进行判断是否推出上层循环                                                    
                                                    l_table_out(j).curr_nnumber   :=0 ;            
                                                    l_table_out(j).curr_nmoney   :=0 ;                                                            
                                              l_count_out := j+1 ;
                                                    
                                                    exit;
                                            end if ;                       
                                end loop ;         
                        end if ;
                                
                end loop ;
                
                ----------------对于没有处理完毕的数量为0的入库记录
                ----------------在此继续处理
                for i in  l_inend_mark+1  .. l_table_in.count loop 
                      if(l_table_in(i).curr_nnumber =0 ) then 
                            l_amount_zero  := l_amount_zero +l_table_in(i).curr_nmoney ;    
                        end if ;
                end loop ;
                
                
                ------------------继续处理 出库记录中剩余的数量为0的情况;
                ------------------如果存在剩余金额不为零，则出现负库存异常；
                
                -----避免下标越界
                if(l_minus_mark= 0 ) then l_minus_mark:=1;  end if ;
                    
                for i in  l_minus_mark  .. l_table_out.count loop 
                      if(l_table_out(i).curr_nnumber =0 ) then 
                            l_amount_zero  := l_amount_zero -l_table_out(i).curr_nmoney ;    
                        else 
                              raise hsbexception  ; 
                        end if ;
                end loop ;

         
                
               
                
                for i in 1 .. l_table_in.count loop 
                      if(l_table_in(i).curr_nnumber >0) then 
                                execute immediate ' insert into inventory_age_aux_1 '|| 
                                'values (:cbilltypecode,:cinvbasid , '||
                                ':curr_nnumber,:curr_nmoney , '||
                                ':pk_corp,:dbilldate,:year_month)' 
                                using lower(l_table_in(i).cbilltypecode) , 
                                l_table_in(i).cinvbasid  , 
                                l_table_in(i).curr_nnumber , l_table_in(i).curr_nmoney , 
                                l_table_in(i).pk_corp , l_table_in(i).dbilldate ,
                              end_year||end_month ; 
                    end if ;
                end loop ;
                
                if(not l_amount_zero  = 0) then 
                        execute immediate ' insert into inventory_age_aux_1 '|| 
                                        'values (:cbilltypecode,:cinvbasid , '||
                                        ':curr_nnumber,:curr_nmoney , '||
                                        ':pk_corp,:dbilldate,:year_month)' 
                                        using 'ii', 
                                        mtl  ,     0 , l_amount_zero, v_pk_corp , 
                                        end_year||'-'||end_month||'-01' ,
                                        end_year||end_month; 
                end if; 
                
                for i in 1 .. l_table_no_audit.count loop 
                        execute immediate ' insert into inventory_age_aux_3 '|| 
                                'values (:cbilltypecode,:cinvbasid , '||
                                ':curr_nnumber,:curr_nmoney , '||
                                ':pk_corp,:dbilldate,:year_month,:id,:auditdate)' 
                                using lower(l_table_no_audit(i).cbilltypecode) , 
                                l_table_no_audit(i).cinvbasid  , 
                                l_table_no_audit(i).curr_nnumber , l_table_no_audit(i).curr_nmoney , 
                                l_table_no_audit(i).pk_corp , l_table_no_audit(i).dbilldate ,
                              end_year||end_month , l_table_no_audit(i).cbill_bid,
                                l_table_no_audit(i).dauditdate ; 
                end loop ;
                   
                
         EXCEPTION 
               when  hsbexception then 
                         dbms_output.put_line('负库存'||mtl) ;
                 when hsb_no_row_exception then 
                    
                      dbms_output.put_line('无数据'||mtl) ;
                 /*when others then 
                         dbms_output.put_line('exception'||mtl) ;
                             dbms_output.put_line(sqlerrm) ;*/
        
end ; 
