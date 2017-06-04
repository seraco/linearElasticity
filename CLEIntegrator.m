classdef CLEIntegrator
    %CMesh
    %   Brief: Base class for linear elasticity integrators
    %   Author: S.Ramon
    %   Version: 0.0.1
    
    methods (Static)
        function f = f( t, Y, M, K )

            F = CInitialData.force(t,Y(1:size(M,1))) ;

            A = [ zeros(size(M,1)) eye(size(M,1)) ; -M\K zeros(size(M,1)) ] ;
            B = [ zeros(size(M,1),1) ; M\F ] ;

            f = A * Y + B ;

        end
        function a = a( t, x, M, K )

            F = CInitialData.force(t,x);

            a = M\(F - K*x);

        end

    end
    
end

