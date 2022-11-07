function [penalty] = addPenaltybemt(x1,x2,x3,x4);
%add penalty to callalgo function
limit1=0.2;
limit2=0.2;
limit3=5;
limit4=12;
if x1<=limit1 && x2<=limit2 && x3<=limit3 && x4<=limit4
         penalty = 0;
         
  else 
    if x1 >limit1 && x2>limit2 && x3>limit3 &&x4>limit4
          penalty = 100000*(((limit1-x1)^2)+((limit2-x2)^2)+((limit3-x3)^2)+((limit4-x4)^2));
      
    else
        if x1 > limit1 && x2>limit2 && x3<=limit3 &&x4>limit4 
        penalty = 100000*(((limit1-x1)^2)+((limit2-x2)^2)+((limit4-x4)^2));
     
        else
            if x1 > limit1 && x2<=limit2 && x3>limit3 && x4>limit4
                 penalty = 100000*(((limit1-x1)^2)+((limit3-x3)^2)+((limit4-x4)^2));
             
            else 
                if x1 <= limit1 && x2>limit2 && x3>limit3 &&x4>limit4  
                    penalty = 100000*(((limit2-x2)^2)+((limit3-x3)^2)+((limit4-x4)^2));
                
                else
                    if x1> limit1 && x2>limit2 && x3>limit3 && x4<=limit4  
                    penalty = 100000*(((limit2-x2)^2)+((limit3-x3)^2)+(limit1-x1)^2);
               
                    else
                      if x1 > limit1 && x2<=limit2 && x3<=limit3 && x4<=limit4
                      penalty = 100000*((limit1-x1)^2);
                    
                   else 
                     if  x1 <= limit3 && x2>limit2 && x3<=limit3 &&x4 <=limit4 
                     penalty = 100000*((limit2-x2)^2);
                    
                     else
                         if  x1 <= limit1 && x2<=limit2 && x3>limit3 && x4<=limit4
                          penalty = 100000*((limit3-x3)^2);
                          
                         else
                             if x1 <= limit1 && x2<=limit2 && x3<=limit3 && x4>limit4
                          penalty = 100000*((limit4-x4)^2);
                             else 
                                 if x1 > limit1 && x2> limit2 && x3<=limit3 && x4<=limit4
                                  penalty = 100000*(((limit1-x1)^2)+((limit2-x2)^2));
                                 else 
                                     if x1 > limit1 && x2<= limit2 && x3>limit3 && x4<=limit4
                                          penalty = 100000*(((limit1-x1)^2)+((limit3-x3)^3));
                                     else
                                         if  x1 > limit1 && x2<= limit2 && x3<=limit3 && x4>limit4
                                  penalty = 100000*(((limit1-x1)^2)+((limit4-x4)^2));
                                         else
                                             if x1 <= limit1 && x2> limit2 && x3>limit3 && x4<=limit4
                                  penalty = 100000*(((limit2-x2)^2)+((limit3-x3)^2));
                                             else 
                                                 if x1 <= limit1 && x2> limit2 && x3<=limit3 && x4>limit4
                                  penalty = 100000*(((limit2-x2)^2)+((limit4-x4)^2));
                                                 else
                                                     if x1 <= limit1 && x2<= limit2 && x3>limit3 && x4>limit4
                                  penalty = 100000*(((limit3-x3)^2)+((limit4-x4)^2));
                                                     end
                                                 end
                                             end
                                         end
                                     end
                                 end
                             end
                         end
                     end
                      end
                    end
                end
            end
        end
    end
end
end

  
