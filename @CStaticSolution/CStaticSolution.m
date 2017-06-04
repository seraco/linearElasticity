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
        function object = CStaticSolution( InitialData, K )
            if nargin > 0
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
            end
        end
    end
    
end

