classdef CMidPImplicitIntegrator
    %CMesh
    %   Brief: Mid Point Implicit integrator
    %   Author: S.Ramon
    %   Version: 0.0.1
    
    methods (Static)
        function Yn1 = step( tn, ~, Yn, h, ~, f, w, Problem, N )
            
            options = optimoptions('fsolve','Display','none') ;

            Yn1 = fsolve(@(Yn1) Yn1 - Yn - h * Problem.f( tn+0.5*h, 0.5*(Yn1+Yn),...
                  f, w, N ), Yn, options) ;

        end
    end
    
end