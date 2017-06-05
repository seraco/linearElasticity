classdef CAlphaMethodIntegrator < CLEIntegrator
    %CMesh
    %   Brief: Alpha Method integrator
    %   Author: S.Ramon
    %   Version: 0.0.1
    
    methods
        function Yn1 = step( object, tn, ~, Yn, M, K, h, alpha, fN, w )
            
            options = optimoptions('fsolve','Display','none') ;

            Yn1 = fsolve(@(Yn1) Yn1 - Yn - h * ((1-alpha)*object.f(tn,Yn,M,K,fN,w)...
                + alpha*object.f(tn+h,Yn1,M,K,fN,w)), Yn, options);

        end
    end
    
end