classdef CForwardEIntegrator
    %CMesh
    %   Brief: Forward Euler integrator
    %   Author: S.Ramon
    %   Version: 0.0.1
    
    methods (Static)
        function Yn1 = step( tn, ~, Yn, h, ~, f, w, Problem, N )
            
            fn = Problem.f(tn, Yn, f, w, N ) ;

            Yn1 = Yn + h * fn ;

        end
    end
    
end