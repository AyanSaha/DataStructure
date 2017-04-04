require 'csv' 
require 'pry'   
#class EnumAutomation
 
 @hmr_present=0
 hash_arr=Array.new
 
  #parse the csv text and put value in hash
  
  
  csv_text = File.read('BGCF.TRUNK_ACTIVITY_BEFORE.csv')

  csv_text=csv_text.split(";")
  



                csv_text.each do |row|
                  enum_hash={:host=>nil,:egress_trunk=>nil,:route_advance=>nil,:hmr_request_cos=>nil,:error_code_range_1=>nil,:error_code_range_2=>nil,:error_code_range_3=>nil,:max_throughput=>nil,:response_code=>nil,:response_message=>nil,:retry_after=>nil,:priority=>nil,:weight=>nil}
                    row=row.gsub("\n",'')
                    unless row.empty?
                    item=row.split(' ')
                 #condition to check host in string
                    
                   if item[0].include? "host"
                   enum_hash[:host]=item[0]
                   end 
                 if item[1].include? "egress_trunk"
                  enum_hash[:egress_trunk]=item[1]
                 end
                 enum_hash[:route_advance]="TRUE"
                 if item[4].include?("hmr_req_cos")
                   enum_hash[:hmr_request_cos]=item[4]
                   @hmr_present=1
                 end
                 
                 if @hmr_present==1
                    if item[5].include?("408..408")
                        enum_hash[:error_code_range_1]=item[5]
                    end
                  #there will be some cases when 500 will appear before 503 .
                    if item[6].include?("503..503")
                      enum_hash[:error_code_range_2]=item[6]
                    elsif item[6].inlude?("500..500")
                      enum_hash[:error_code_range_3]=item[6]
                    else
                      #here neither 503 nor 500 exist so shift values
                       if item[6].include?("max_throughput")
                        #check for max throughput
                        enum_hash[:max_throughput]=item[6]
                       end
                        if item[7].include?("response_code")
                        #check for max response code value present
                       
                          response_code=item[7]
                          if response_code.empty?
                            enum_hash[:response_code]=nil
                          else
                            enum_hash[:response_code]=response_code
                           end
                        end
                        
                        if item[8].include?("response_message")
                          response_message=item[8]
                          response_message=response_message.delete('\\"')
                          if response_message.empty?
                            enum_hash[:response_message]=nil
                          else
                            enum_hash[:response_message]=response_message
                          end


                        end
                        if item[9].include?("retry_after")
                            retry_after=item[9].delete('}')
                            if retry_after.empty?
                             enum_hash[:retry_after]=nil
                            else
                              enum_hash[:retry_after]=retry_after
                            end
                        end
                      if item[11].include?("priority")
                        #validation for priority
                        priority=item[11]
                        if priority.empty?
                             enum_hash[:priority]=nil
                         else
                          enum_hash[:priority]=priority
                         end
                      end
                      if item[12].include?("weight")
                        #validation for priority
                        weight=item[12].delete('}')
                        if weight.empty?
                             enum_hash[:weight]=nil
                         else
                          enum_hash[:weight]=weight
                         end
                      end
                           

                     end#end of else

                    
                    if item[7].include?("500..500")
                      enum_hash[:error_code_range_3]=item[7]
                    elsif item[7].include?("503..503")
                      enum_hash[:error_code_range_2]=item[7]
                    else
                      #here neither

                      if item[7].include?("max_throughput")
                        #check for max throughput
                        enum_hash[:max_throughput]=item[7]
                       end
                      if item[8].include?("response_code")
                        #check for max response code value present
                       
                        response_code=item[8]
                        if response_code.empty?
                            enum_hash[:response_code]=nil
                        else
                          enum_hash[:response_code]=response_code
                        end
                      end
                        
                       if item[9].include?("response_message")
                        response_message=item[9].partition('=').last
                        response_message=response_message.delete('\\"')
                        if response_message.empty?
                            enum_hash[:response_message]=nil
                        else
                          enum_hash[:response_message]=response_message
                        end
                       end
                       if item[10].include?("retry_after")
                         retry_after=item[10].partition('=').last.delete('}')
                         if retry_after.empty?
                             enum_hash[:retry_after]=nil
                         else
                          enum_hash[:retry_after]=retry_after
                         end
                      end
                      if item[12].include?("priority")
                        #validation for priority
                        priority=item[12].partition('=').last
                        if priority.empty?
                             enum_hash[:priority]=nil
                         else
                          enum_hash[:priority]=priority
                         end
                      end
                      if item[13].include?("weight")
                        #validation for priority
                        weight=item[13].delete('}')
                        if weight.empty?
                             enum_hash[:weight]=nil
                         else
                          enum_hash[:weight]=weight
                         end
                      end     
                  #this code has been developed on 4 th April 2017.Do not change anything else you would waste your time
                    
                    end#else end
                    #check for max throughput when all the error_ranges are present
                    #this code should execute whenever all the eror code range  are present
                    if !enum_hash[:error_code_range_1].nil? && !enum_hash[:error_code_range_2].nil? && !enum_hash[:error_code_range_3].nil? 
                        if item[8].include?("max_throughput")
                            #check for max throughput
                            enum_hash[:max_throughput]=item[8]
                        end
                         

                         if item[9].include?("response_code")
                            #check for max response code value present
                           
                            response_code=item[9]
                            if response_code.empty?
                                enum_hash[:response_code]=nil
                            else
                              enum_hash[:response_code]=response_code
                            end
                         end
                            
                         if item[10].include?("response_message")
                            response_message=item[10]
                            response_message=response_message.delete('\\"')
                            if response_message.empty?
                                enum_hash[:response_message]=nil
                            else
                              enum_hash[:response_message]=response_message
                            end


                         end
                         if item[11].include?("retry_after")
                             retry_after=item[11].delete('}')
                             if retry_after.empty?
                                 enum_hash[:retry_after]=nil
                             else
                              enum_hash[:retry_after]=retry_after
                             end
                          end
                          if item[13].include?("priority")
                            #validation for priority
                            priority=item[13]
                            if priority.empty?
                                 enum_hash[:priority]=nil
                             else
                              enum_hash[:priority]=priority
                             end
                          end
                          
                          if item[14].include?("weight")
                            #validation for priority
                            weight=item[14].delete('}')
                            if weight.empty?
                                 enum_hash[:weight]=nil
                             else
                              enum_hash[:weight]=weight
                             end
                          end
                          
                    end#unless loop end
                    
                    #condition when hmr_not present
                    else

                       ################################ELSE START######################################
                        if item[4].include?("408..408")
                        enum_hash[:error_code_range_1]=item[4]
                        end
                  #there will be some cases when 500 will appear before 503 .
                        if item[5].include?("503..503")
                            enum_hash[:error_code_range_2]=item[5]
                        elsif item[5].inlude?("500..500")
                            enum_hash[:error_code_range_3]=item[5]
                        else
                            #here neither 503 nor 500 exist so shift values
                            if item[5].include?("max_throughput")
                                #check for max throughput
                                enum_hash[:max_throughput]=item[5]
                            end
                            if item[5].include?("response_code")
                            #check for max response code value present
                           
                              response_code=item[5]
                              if response_code.empty?
                                enum_hash[:response_code]=nil
                              else
                                enum_hash[:response_code]=response_code
                               end
                            end
                        
                            if item[7].include?("response_message")
                              response_message=item[7]
                              response_message=response_message
                              if response_message.empty?
                                enum_hash[:response_message]=nil
                              else
                                enum_hash[:response_message]=response_message
                              end


                            end
                            if item[8].include?("retry_after")
                                retry_after=item[8].delete('}')
                                if retry_after.empty?
                                 enum_hash[:retry_after]=nil
                                else
                                  enum_hash[:retry_after]=retry_after
                                end
                            end
                            if item[10].include?("priority")
                              #validation for priority
                              priority=item[10]
                              if priority.empty?
                                   enum_hash[:priority]=nil
                               else
                                enum_hash[:priority]=priority
                               end
                            end
                            if item[11].include?("weight")
                              #validation for priority
                              weight=item[11].delete('}')
                              if weight.empty?
                                   enum_hash[:weight]=nil
                               else
                                enum_hash[:weight]=weight
                               end
                            end
                                 

                           end#end of else

                    
                          if item[6].include?("500..500")
                            enum_hash[:error_code_range_3]=item[6]
                          elsif item[6].include?("503..503")
                            enum_hash[:error_code_range_2]=item[6]
                          else
                      #here neither

                            if item[6].include?("max_throughput")
                              #check for max throughput
                              enum_hash[:max_throughput]=item[6]
                             end
                            if item[7].include?("response_code")
                              #check for max response code value present
                             
                              response_code=item[7]
                              if response_code.empty?
                                  enum_hash[:response_code]=nil
                              else
                                enum_hash[:response_code]=response_code
                              end
                            end
                              
                             if item[8].include?("response_message")
                              response_message=item[8]
                              response_message=response_message
                              if response_message.empty?
                                  enum_hash[:response_message]=nil
                              else
                                enum_hash[:response_message]=response_message
                              end
                             end
                             if item[9].include?("retry_after")
                               retry_after=item[9].delete('}')
                               if retry_after.empty?
                                   enum_hash[:retry_after]=nil
                               else
                                enum_hash[:retry_after]=retry_after
                               end
                            end
                            if item[11].include?("priority")
                              #validation for priority
                              priority=item[11]
                              if priority.empty?
                                   enum_hash[:priority]=nil
                               else
                                enum_hash[:priority]=priority
                               end
                            end
                            if item[12].include?("weight")
                              #validation for priority
                              weight=item[12].delete('}')
                              if weight.empty?
                                   enum_hash[:weight]=nil
                               else
                                enum_hash[:weight]=weight
                               end
                            end     
                        #this code has been developed on 4 th April 2017.Do not change anything else you would waste your time
                          
                          end#else end
                          #check for max throughput when all the error_ranges are present
                          #this code should execute whenever all the eror code range  are present
                          if !enum_hash[:error_code_range_1].nil? && !enum_hash[:error_code_range_2].nil? && !enum_hash[:error_code_range_3].nil? 
                              if item[7].include?("max_throughput")
                                  #check for max throughput
                                  enum_hash[:max_throughput]=item[7]
                              end
                               

                               if item[8].include?("response_code")
                                  #check for max response code value present
                                 
                                  response_code=item[8]
                                  if response_code.empty?
                                      enum_hash[:response_code]=nil
                                  else
                                    enum_hash[:response_code]=response_code
                                  end
                               end
                                  
                               if item[9].include?("response_message")
                                  response_message=item[9]
                                  response_message=response_message
                                  if response_message.empty?
                                      enum_hash[:response_message]=nil
                                  else
                                    enum_hash[:response_message]=response_message
                                  end


                               end
                               if item[10].include?("retry_after")
                                   retry_after=item[10].delete('}')
                                   if retry_after.empty?
                                       enum_hash[:retry_after]=nil
                                   else
                                    enum_hash[:retry_after]=retry_after
                                   end
                                end
                                if item[12].include?("priority")
                                  #validation for priority
                                  priority=item[12]
                                  if priority.empty?
                                       enum_hash[:priority]=nil
                                   else
                                    enum_hash[:priority]=priority
                                   end
                                end
                                
                                if item[13].include?("weight")
                                  #validation for priority
                                  weight=item[13].delete('}')
                                  if weight.empty?
                                       enum_hash[:weight]=nil
                                   else
                                    enum_hash[:weight]=weight
                                   end
                                end
                          end
                    









                 



                
                 end#if condition check for hmr_present
                
                hash_arr.push(enum_hash)
          end#end of until row empty
  end#end of loop
 CSV.open("data.csv", "wb") do |csv|

  hash_arr.each do |hash|
    csv << hash.values
  end
end
  
#end