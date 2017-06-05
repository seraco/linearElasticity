classdef CBackwardEIntegrator < CLEIntegrator
    %CMesh
    %   Brief: Backward Euler integrator
    %   Author: S.Ramon
    %   Version: 0.0.1
    
    methods
        function Yn1 = step( object, tn, ~, Yn, M, K, h, ~, fN, w )
            
            options = optimoptions('fsolve','Display','none');

            Yn1 = fsolve(@(Yn1) Yn1 - Yn - h * object.f( tn+h, Yn1, M, K, fN, w ), Yn, options);

        end
    end
    
end