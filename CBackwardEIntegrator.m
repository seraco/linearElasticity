classdef CBackwardEIntegrator
    %CMesh
    %   Brief: Backward Euler integrator
    %   Author: S.Ramon
    %   Version: 0.0.1
    
    methods (Static)
        function Yn1 = step( tn, ~, Yn, h, ~, f, w, Problem, N )
            
            options = optimoptions('fsolve','Display','none');

            Yn1 = fsolve(@(Yn1) Yn1 - Yn - h * Problem.f( tn+h, Yn1, f, w, N ), Yn, options);

        end
    end
    
end