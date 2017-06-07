classdef CAlphaMethodIntegrator
    %CMesh
    %   Brief: Alpha Method integrator
    %   Author: S.Ramon
    %   Version: 0.0.1
    
    methods (Static)
        function Yn1 = step( tn, ~, Yn, h, alpha, f, w, LEProblem, N )
            
            options = optimoptions('fsolve','Display','none') ;

            Yn1 = fsolve(@(Yn1) Yn1 - Yn - h * ((1-alpha)*LEProblem.f(tn,Yn,f,w,N)...
                + alpha*LEProblem.f(tn+h,Yn1,f,w,N)), Yn, options);

        end
    end
    
end