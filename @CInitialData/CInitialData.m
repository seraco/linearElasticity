classdef CInitialData
    %CMesh
    %   Brief: Main class used to set initial data
    %   Author: S.Ramon
    %   Version: 0.0.1
    
    properties
        ro
        E
        A
        alpha
        t
        D
        N
        uD
        fN
        filename
    end
        
    methods
        function object = CInitialData(filename,nnode,ndofpn)
            if nargin > 0
                object.filename = filename;
                
                [... 
                  object.ro,...
                  object.E,...
                  object.A,...
                  object.alpha,...
                  iTime,...
                  nSteps,...
                  fTime,...
                  Fext,...
                  fixnodes...
                ] = object.readInitialData( filename );
            
                object.t = linspace(iTime, fTime, nSteps);
                Daux = zeros(size(fixnodes,1),2);
                
                for i = 1:size(fixnodes,1)

                    row = fixnodes(i,:);

                    inode = row(1);
                    idofpn = row(2);

                    ig = inode + (idofpn - 1)*nnode ;

                    Daux(i,1) = ig;
                    Daux(i,2) = row(3);

                end

                Daux = sortrows(Daux);
                object.D = Daux(:,1);
                object.uD = Daux(:,2);
                
                N = 1:nnode*ndofpn;
                fN = zeros(1, nnode*ndofpn);
                N = [N', fN'];

                for i = 1:size(Fext,1)

                    row = Fext(i,:);

                    inode = row(1);
                    idofpn = row(2);

                    ig = inode + (idofpn - 1)*nnode ;

                    N(ig,1) = ig;
                    N(ig,2) = row(3);

                end

                Naux = sortrows(N);
                object.N = Naux(:,1);
                object.fN = Naux(:,2);
                object.N(object.D) = [];
                object.fN(object.D) = [];
            end
        end
    end
    methods (Static)
        [ ro, E, area, alpha, iTime, nSteps, fTime, Fext, fixnodes  ] = readInitialData( filename )
    end
    
end

