function [ ro, E, area, alpha, iTime, nSteps, fTime, Fext, fixnodes, StaticPost, ModalPost,...
    TemporalPost, OneModePost, ModePost, Integrator ] = readInitialData( filename )

% A = importdata(filename);
% n = length(A.textdata(:,1));
fid = fopen(filename);
scan = textscan(fid, '%s %s %s');
fclose(fid);

firstColumn = scan(1);
secondColumn = scan(2);
thirdColumn = scan(3);

n = size(firstColumn{1},1);

readFext = false;
readFixnodes = false;
j=0;
k=0;

for i=1:n
    if strcmp(firstColumn{1}{i},'Integrator')
        Integrator = thirdColumn{1}{i};
    end
    if strcmp(firstColumn{1}{i},'Density')
        ro = str2double(thirdColumn{1}{i});
    end
    if strcmp(firstColumn{1}{i},'Young')
        E = str2double(thirdColumn{1}{i});
    end
    if strcmp(firstColumn{1}{i},'Area')
        area = str2double(thirdColumn{1}{i});
    end
    if strcmp(firstColumn{1}{i},'Alpha')
        alpha = str2double(thirdColumn{1}{i});
    end
    if strcmp(firstColumn{1}{i},'Time')
        iTime = str2double(firstColumn{1}{i+1});
        fTime = str2double(secondColumn{1}{i+1});
        nSteps = str2double(thirdColumn{1}{i+1});
    end
    if strcmp(firstColumn{1}{i},'Fext')
        readFext = true;
    end
    if strcmp(firstColumn{1}{i},'End') && readFext
        readFext = false;
    end
    if strcmp(firstColumn{1}{i},'Fixnodes')
        readFixnodes = true;
    end
    if strcmp(firstColumn{1}{i},'End') && readFixnodes
        readFixnodes = false;
    end
    if strcmp(firstColumn{1}{i},'StaticPost')
        StaticPost = str2double(thirdColumn{1}{i});
    end
    if strcmp(firstColumn{1}{i},'ModalPost')
        ModalPost = str2double(thirdColumn{1}{i});
    end
    if strcmp(firstColumn{1}{i},'TemporalPost')
        TemporalPost = str2double(thirdColumn{1}{i});
    end
    if strcmp(firstColumn{1}{i},'OneModePost')
        OneModePost = str2double(thirdColumn{1}{i});
    end
    if strcmp(firstColumn{1}{i},'Mode')
        ModePost = str2double(thirdColumn{1}{i});
    end
    if readFext && strcmp(firstColumn{1}{i},'Fext') == false
        j=j+1;
        Fext(j,1) = str2double(firstColumn{1}{i});
        Fext(j,2) = str2double(secondColumn{1}{i});
        Fext(j,3) = str2double(thirdColumn{1}{i});
    end
    if readFixnodes && strcmp(firstColumn{1}{i},'Fixnodes') == false
        k=k+1;
        fixnodes(k,1) = str2double(firstColumn{1}{i});
        fixnodes(k,2) = str2double(secondColumn{1}{i});
        fixnodes(k,3) = str2double(thirdColumn{1}{i});     
    end
end

end

