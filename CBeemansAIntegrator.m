classdef CBeemansAIntegrator < CLEIntegrator
    %CMesh
    %   Brief: Beeman's Algorithm integrator
    %   Author: S.Ramon
    %   Version: 0.0.1
    
    methods (Static)
        function Yn1 = step( tn, Ynm1, Yn, h, ~, f, w, LEProblem, N )
            xnm1 = Ynm1(1:size(LEProblem.M(N,N),1)) ;
            xn = Yn(1:size(LEProblem.M(N,N),1)) ;
            vn = Yn(size(LEProblem.M(N,N),1)+1:size(Yn,1)) ;

            xn1 = xn + vn*h + 1/6*(4*LEProblem.a(tn,xn,f,w,N) -...
                  LEProblem.a(tn-h,xnm1,f,w,N))*h^2 ;
            vn1 = vn + 1/6*(2*LEProblem.a(tn+h,xn1,f,w,N) +...
                  5*LEProblem.a(tn,xn,f,w,N) - LEProblem.a(tn-h,xnm1,f,w,N))*h ;

            Yn1 = [ xn1; vn1 ] ;

        end
    end
    
end

