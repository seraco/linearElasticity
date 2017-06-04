classdef CStaticSolution
    %CMesh
    %   Brief: Main class used to calculate the static solution
    %   Author: S.Ramon
    %   Version: 0.0.1
    
    properties
        u
        f
    end
    
    methods
        function object = CStaticSolution( Mesh, InitialData, K )
            if nargin > 0
                xpoints = Mesh.xpoints;
                T = Mesh.T;
                nnodepelem = Mesh.nnodepelem;
                nelem = Mesh.nelem;
                nnode = Mesh.nnode;
                ndofpn = Mesh.ndofpn;
                postProcessing = InitialData.StaticPost;
                D = InitialData.D;
                N = InitialData.N;
                uD = InitialData.uD;
                fN = InitialData.fN;


                KDD = K(D,D);
                KDN = K(D,N);
                KND = K(N,D);
                KNN = K(N,N);

                uN = KNN\(fN-KND*uD);
                fD = KDD*uD+KDN*uN;

                object.u(N) = uN;
                object.u(D) = uD;
                object.f(N) = fN;
                object.f(D) = fD;
                
                if postProcessing
                    
                    PostProcessing = CPostProcessing('data/Static',1);
                
                    PostProcessing.toGID ( xpoints(:,1:3), T, nnodepelem, nelem, nnode );
                    PostProcessing.toGIDPost( nnodepelem, ndofpn, 1, object.u );
                
                end
            end
        end
    end
    
end

