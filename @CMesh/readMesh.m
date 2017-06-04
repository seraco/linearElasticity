function [xpoints, T] = readMesh( filename )

A = importdata(filename);
n = length(A.textdata(:,1));

read_coor = false;
read_elem = false;
j=0;
k=0;

for i=1:n
    if strcmp(A.textdata(i,1),'Coordinates')
        read_coor = true;
    end
    if strcmp(A.textdata(i,1),'End') && read_coor
        read_coor = false;
    end
    if strcmp(A.textdata(i,1),'Elements')
        read_elem = true;
    end
    if strcmp(A.textdata(i,1),'End') && read_elem
        read_elem = false;
    end
    
    if read_coor && strcmp(A.textdata(i,1),'Coordinates') == false
        j=j+1;
        xpoints(j,:) = str2double(A.textdata(i,2:4));        
    end
    if read_elem && strcmp(A.textdata(i,1),'Elements') == false
        k=k+1;
        T(k,:) = str2double(A.textdata(i,2:3));       
    end
end
end

