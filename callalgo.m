function Return = callalgo(x)
%call function for 4-d Nelder Mead

%loops through nodes in simplex
parfor i=1:size(x,2);
   Cp=BEMT_Template(3, [0.12, 0.5], x(3,i), [x(2,i), x(1,i)], [x(4,i) 5], 30, 3, 1.5e-5, 0.001, 30);
   penalty(i) = addPenaltybemt(x(1,i),x(2,i),x(3,i),x(4,i));
  
   Return(i)=1-Cp+penalty(i)
   
    
end

end