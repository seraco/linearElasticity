classdef CForwardEIntegrator < CLEIntegrator
    %CMesh
    %   Brief: Forward Euler integrator
    %   Author: S.Ramon
    %   Version: 0.0.1
    
    methods
        function Yn1 = step( object, tn, ~, Yn, M, K, h, ~, fN, w )
            
            fn = object.f(tn, Yn, M, K, fN, w ) ;

            Yn1 = Yn + h * fn ;

        end
    end
    
end