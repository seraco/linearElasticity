classdef CMidPImplicitIntegrator < CLEIntegrator
    %CMesh
    %   Brief: Mid Point Implicit integrator
    %   Author: S.Ramon
    %   Version: 0.0.1
    
    methods
        function Yn1 = step( object, tn, ~, Yn, M, K, h, ~ )
            
            options = optimoptions('fsolve','Display','none') ;

            Yn1 = fsolve(@(Yn1) Yn1 - Yn - h * object.f( tn+0.5*h, 0.5*(Yn1+Yn), M, K ), Yn, options) ;

        end
    end
    
end