 
 
procedure p_hx(org_code_param varchar2 , subj_code_param varchar2 , beg_year_param varchar2 ,
              beg_month_param varchar2 , end_year_param varchar2 , end_month_param varchar2 ,init_mark  varchar2  default 'n' ) 
is
 l_beg_table  nt_arap_voucher_detail := new nt_arap_voucher_detail() ; 
 l_beg_table_init  nt_tb_beg := new nt_tb_beg() ; 
 l_accur_table  nt_tb_accur := new nt_tb_accur() ;
 l_bal_count pls_integer := 0 ;
 l_accur_count pls_integer := 0 ;  
 l_find_mark  pls_integer :=0 ; 
 begin 
   
              
              
  
   if(init_mark = 'n') then 
   
       open arap_voucher_detail(org_code_param , subj_code_param , beg_year_param, beg_month_param , end_year_param , end_month_param ) ;
       fetch arap_voucher_detail bulk collect into l_beg_table ; 
       close arap_voucher_detail ; 
   else  
   
        open cur_tb_beg(org_code_param , subj_code_param, beg_year_param, beg_month_param ,end_year_param, end_month_param) ; 
        fetch cur_tb_beg bulk collect into l_beg_table_init ;
        close cur_tb_beg ; 
   
   end if;
   
   
   open cur_tb_accur(org_code_param , subj_code_param , beg_year_param, beg_month_param, end_year_param, end_month_param) ;
       fetch cur_tb_accur bulk collect into l_accur_table ; 
   close cur_tb_accur ; 
   
   
   if ( l_beg_table_init.count >=1 and init_mark = 'y') then  
   
       for x  in 1 ..  l_beg_table_init.count loop 
       
            l_beg_table.extend; 
            l_beg_table(x) := l_beg_table_init(x) ;
       
       end loop; 
   
  end if;
  
  
  
  
  for x  in 1 .. l_accur_table.count loop
   
  
       if(  l_accur_table(x).amount = 0  or l_accur_table(x).handle_mark ='y' ) then 
       
            continue; 
            
       end if; 
    
       l_accur_count := x +1 ; 
       
       
       
       for  y  in  l_accur_count  .. l_accur_table.count loop 
       
                 if( l_accur_table(x).org_code = l_accur_table(y).org_code  and  
                   l_accur_table(x).subj_code = l_accur_table(y).subj_code and 
                   l_accur_table(x).ks_code = l_accur_table(y).ks_code  )  then 
                   
                        if( l_accur_table(x).amount = - l_accur_table(y).amount  ) then 
                        
                                      l_accur_table(x).amount := 0 ; 
                                      l_accur_table(y).amount := 0 ;  
                                      l_accur_table(x).handle_mark :='y' ; 
                                      l_accur_table(y).handle_mark :='y' ; 
                                      
                                      
                                      exit ;
                        
                        end if; 
                   
                   
                 end if; 
          
       
      end loop ; 
          
  
 end loop; 
  
  
/*
  for x  in  1   ..  l_beg_table.count loop  
  
         l_bal_count  := x; 
         
         
         if( l_beg_table(x).amount = 0  or  l_beg_table(x).handle_mark ='y'  ) then 
         
              continue ; 
         end if; 
         
         
         l_find_mark := 0 ;
 
         
         for y in 1 .. l_accur_table.count loop 
           
         
               if( l_find_mark = 3) then 
               
                  exit; 
                  
                end if; 
               
                 if(l_accur_table(y).amount = 0  or l_accur_table(y).handle_mark = 'y'  ) then 
                         
                      continue; 
                 
                end if; 
                 
               if( l_beg_table(x).org_code = l_accur_table(y).org_code  and  
                   l_beg_table(x).subj_code = l_accur_table(y).subj_code and 
                   l_beg_table(x).ks_code = l_accur_table(y).ks_code  )  then 
                   
                      l_find_mark :=1 ; 
               
                      if(l_beg_table(x).amount * l_accur_table(y).amount  <0   )  then 
                      
                            if(abs(l_beg_table(x).amount ) <= abs(l_accur_table(y).amount)  ) then 
                            
                                    l_accur_table(y).amount  := l_accur_table(y).amount +   l_beg_table(x).amount ; 
                                    l_beg_table(x).amount := 0 ; 
                                    exit; 
                                
                            
                            else 
                            
                                    l_beg_table(x).amount := l_accur_table(y).amount +  l_beg_table(x).amount ; 
                                    l_accur_table(y).amount := 0 ;    
                              
                                      
                            end if; 
                      
                     end if; 
                    
               
               end if; 
               
               if(l_find_mark = 1 ) then 
                    l_find_mark := 2; 
               elsif(l_find_mark =2) then 
                    l_find_mark := 3 ; 
               else 
                    l_find_mark := 0 ; 
               end if;  
               
         
        end loop; 
  
  
  
  end loop; 
  
  */
  
  /*
  
  for x  in 1 .. l_accur_table.count loop
  
         l_accur_count :=  x +1; 
         
         if( l_accur_table(x).amount = 0 or  l_accur_table(x).handle_mark = 'y'  ) then 
         
                continue ; 
         
          end if; 
          
          
         l_find_mark := 0 ; 
         
         for y  in   l_accur_count  ..   l_accur_table.count loop
         
         
         
                 if( l_find_mark = 3   ) then 
                 
                      exit; 
                 
                 end if ; 
         
                 if( l_accur_table(y).handle_mark ='y'  or l_accur_table(y).amount = 0  )  then 
                      
                          continue; 
                 
                 end if; 
                  
         
                 if( l_accur_table(x).org_code = l_accur_table(y).org_code  and  
                   l_accur_table(x).subj_code = l_accur_table(y).subj_code and 
                   l_accur_table(x).ks_code = l_accur_table(y).ks_code  )  then 
                   
                   
                        l_find_mark := 1 ; 
                   
                        if(l_accur_table(x).amount * l_accur_table(y).amount  <0   )  then 
                      
                            if(abs(l_accur_table(x).amount ) <= abs(l_accur_table(y).amount)  ) then 
                            
                                    l_accur_table(y).amount  := l_accur_table(y).amount +   l_accur_table(x).amount ; 
                                    l_accur_table(x).amount := 0 ; 
                                    exit;
                                
                            
                            else 
                            
                                    l_accur_table(x).amount := l_accur_table(y).amount +  l_accur_table(x).amount ; 
                                    l_accur_table(y).amount := 0 ;    
                              
                                      
                            end if; 
                      
                     end if; 
                   
                 
                 
                  end if; 
                  
                  
                  if(l_find_mark =1  ) then 
                      
                        l_find_mark := 2 ; 
                  
                  elsif ( l_find_mark =2)  then 
                  
                       l_find_mark := 3; 
                        
                        
                  else
                  
                      l_find_mark  := 0 ; 
                  
                  end if; 
                  
                   
         
         
        end loop ;  
  
  
 end loop; 
 
 */
 
      savepoint  p_hx ;  
 
      if( init_mark = 'y') then
       
          execute immediate  l_delete_arap_age_year_month_1   using beg_year_param|| beg_month_param; 
      
      else  
 
      execute immediate  l_delete_arap_age_year_month   using beg_year_param||beg_month_param; 
      
      end if; 
 
 
     for x  in 1 .. l_beg_table.count loop 
       
               if(  l_beg_table(x).amount <> 0.111) then 
               
                    execute immediate  l_insert_arap_age_year_month 
                    using seq_arap.nextval, l_beg_table(x).pk_org,  
                    l_beg_table(x).org_code, 
                    l_beg_table(x).org_name, 
                    l_beg_table(x).pk_account, 
                    l_beg_table(x).subj_code, 
                    l_beg_table(x).subj_name, 
                    l_beg_table(x).disp_name, 
                    l_beg_table(x).balanorient, 
                    l_beg_table(x).ks_code, 
                    l_beg_table(x).ks_name, 
                    l_beg_table(x).ks_pk, 
                    l_beg_table(x).voucher_date, 
                    l_beg_table(x).amount,
                    --l_beg_table(x).year_month  ; 
                    end_year_param||end_month_param ; 
        
                       
                end if; 
        
       end loop ; 
       
       
   /*
       
       for x in  1 ..   l_accur_table.count   loop
       
                if(l_accur_table(x).amount <>0.111) then 
                 
                   execute immediate   l_insert_arap_age_year_month  
                    using seq_arap.nextval ,l_accur_table(x).pk_org,  
                    l_accur_table(x).org_code, 
                    l_accur_table(x).org_name, 
                    l_accur_table(x).pk_account, 
                    l_accur_table(x).subj_code, 
                    l_accur_table(x).subj_name, 
                    l_accur_table(x).disp_name, 
                    l_accur_table(x).balanorient, 
                    l_accur_table(x).ks_code, 
                    l_accur_table(x).ks_name, 
                    l_accur_table(x).ks_pk, 
                    l_accur_table(x).voucher_date, 
                    l_accur_table(x).amount,
                    l_accur_table(x).year_month  ; 
                    
                    
           
                end if; 
       
      end loop ; 
      

      */
      
      commit; 
      
  
   exception 
   
         when  others    then 
         
         
              if  (cur_tb_accur % isopen ) then close cur_tb_accur ;  end if ; 
              if  (cur_tb_beg % isopen )   then  close cur_tb_beg  ; end if ; 
 
 
 							rollback to p_hx ;  
              
   
 end ; 
 
 
 