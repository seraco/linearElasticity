function [ ro, E, area, alpha, iTime, nSteps, fTime, Fext, fixnodes  ] = readInitialData( filename )

A = importdata(filename);
n = length(A.textdata(:,1));

readFext = false;
readFixnodes = false;
j=0;
k=0;

for i=1:n
    if strcmp(A.textdata(i,1),'Density')
        ro = A.data(i,1);
    end
    if strcmp(A.textdata(i,1),'Young')
        E = A.data(i,1);
    end
    if strcmp(A.textdata(i,1),'Area')
        area = A.data(i,1);
    end
    if strcmp(A.textdata(i,1),'Alpha')
        alpha = A.data(i,1);
    end
    if strcmp(A.textdata(i,1),'Time')
        iTime = str2double(A.textdata(i+1,1));
        fTime = str2double(A.textdata(i+1,2));
        nSteps = A.data(i+1,1);
    end
    if strcmp(A.textdata(i,1),'Fext')
        readFext = true;
    end
    if strcmp(A.textdata(i,1),'End') && readFext
        readFext = false;
    end
    if strcmp(A.textdata(i,1),'Fixnodes')
        readFixnodes = true;
    end
    if strcmp(A.textdata(i,1),'End') && readFixnodes
        readFixnodes = false;
    end
    
    if readFext && strcmp(A.textdata(i,1),'Fext') == false
        j=j+1;
        Fext(j,1:2) = str2double(A.textdata(i,1:2));
        Fext(j,3) = A.data(i,1);
    end
    if readFixnodes && strcmp(A.textdata(i,1),'Fixnodes') == false
        k=k+1;
        fixnodes(k,1:2) = str2double(A.textdata(i,1:2));
        fixnodes(k,3) = A.data(i,1);      
    end
end

end

