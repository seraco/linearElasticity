classdef CBeemansAIntegrator < CLEIntegrator
    %CMesh
    %   Brief: Beeman's Algorithm integrator
    %   Author: S.Ramon
    %   Version: 0.0.1
    
    methods
        function Yn1 = step( object, tn, Ynm1, Yn, M, K, h, ~ )
            xnm1 = Ynm1(1:size(M,1)) ;
            xn = Yn(1:size(M,1)) ;
            vn = Yn(size(M,1)+1:size(Yn,1)) ;

            xn1 = xn + vn*h + 1/6*(4*object.a(tn,xn,M,K) - object.a(tn-h,xnm1,M,K))*h^2 ;
            vn1 = vn + 1/6*(2*object.a(tn+h,xn1,M,K) + 5*object.a(tn,xn,M,K) - object.a(tn-h,xnm1,M,K))*h ;

            Yn1 = [ xn1; vn1 ] ;

        end
    end
    
end

