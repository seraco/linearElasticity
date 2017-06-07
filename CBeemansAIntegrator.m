classdef CBeemansAIntegrator
    %CMesh
    %   Brief: Beeman's Algorithm integrator
    %   Author: S.Ramon
    %   Version: 0.0.1
    
    methods (Static)
        function Yn1 = step( tn, Ynm1, Yn, h, ~, f, w, Problem, N )
            xnm1 = Ynm1(1:size(Problem.M(N,N),1)) ;
            xn = Yn(1:size(Problem.M(N,N),1)) ;
            vn = Yn(size(Problem.M(N,N),1)+1:size(Yn,1)) ;

            xn1 = xn + vn*h + 1/6*(4*Problem.a(tn,xn,f,w,N) -...
                  Problem.a(tn-h,xnm1,f,w,N))*h^2 ;
            vn1 = vn + 1/6*(2*Problem.a(tn+h,xn1,f,w,N) +...
                  5*Problem.a(tn,xn,f,w,N) - Problem.a(tn-h,xnm1,f,w,N))*h ;

            Yn1 = [ xn1; vn1 ] ;

        end
    end
    
end

