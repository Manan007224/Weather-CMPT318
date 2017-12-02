function FINAL=hatch(img) 

inside=0;
start_x = 0;
start_y = 0;
end_x = 0;
end_y=0;
line=0;
i=1;
j=1;
while i <= size(img,1)
    while j<=size(img,2)
        
        if img(i,j) == 1 
            
            if inside==0
                inside=inside+1;
                start_x = j
                start_y = i
            else
                
                end_x = j
                end_y = i
                inside=inside-1;
                line=line+1;
            end
        end
        if line == 1
            img(i,start_x : end_x) = 1
            line=line-1;
            j=j+3;
        else
            j=j+1;
        end
    
    end
   i=i+1;
   
FINAL = img;
line=0;
inside=0;
start_x = 0;
start_y = 0;
end_x = 0;
end_y=0;
end