classdef CModalSolution
    %CMesh
    %   Brief: Main class used to calculate the modal solution
    %   Author: S.Ramon
    %   Version: 0.0.1
    
    properties
        X
        w
        potentialEnergy
        kineticEnergy
        totalEnergy
        t
    end
    
    methods
        function object = CModalSolution( InitialData, LEMatrices, StaticSolution )
            if nargin > 0
                D = InitialData.D;
                N = InitialData.N;
                uD = InitialData.uD;
                t = InitialData.t;
                object.t = t;
                M = LEMatrices.M;
                K = LEMatrices.K;
                MNN = M(N, N);
                KNN = K(N, N);
                Xo(D) = StaticSolution.u(D);
                Xo(N) = StaticSolution.u(N);
                Vo =  zeros(size(LEMatrices.M,1),1);
                
                [ XAux, lambda ] = eig(MNN^-1*KNN) ;

                object.X(N,:) = XAux;

                for i = 1:size(object.X,2)

                    object.X(D,i) = uD;

                end

                W = real(sqrt(lambda)) ;
                object.w = diag(W) ;
                
                A = object.X(N,:)\Xo(N)';
                B = -(object.X(N,:)\Vo(N))./object.w;

                object.potentialEnergy = zeros(1, size(t,2));
                object.kineticEnergy = zeros(1, size(t,2));
                object.totalEnergy = zeros(1, size(t,2));

                for i = 1:size(t,2)

                    xt = zeros(size(object.X,1),1);
                    vt = zeros(size(object.X,1),1);

                    for j = 1:size(object.X,2)

                        xt(N) = xt(N) + object.X(N,j)*(A(j)*cos(object.w(j)*t(i))+B(j)*sin(object.w(j)*t(i)));
                        vt(N) = vt(N) + object.X(N,j)*object.w(j)*(A(j)*-sin(object.w(j)*t(i))+B(j)*cos(object.w(j)*t(i)));

                    end

                    xt(D) = Xo(D) ;
                    vt(D) = Vo(D) ;

%                     filename = 'data/problema7' ;

%                     ToGID ( filename, t(i), xpoints(:,1:3), T, nnodepelem, nelem, nnode );
%                     ToGiD_post( filename, t(i), nnodepelem, ndofpn, 1, xt' );

                    object.potentialEnergy(i) = 0.5*xt'*K*xt;
                    object.kineticEnergy(i) = 0.5*vt'*M*vt;
                    object.totalEnergy(i) = object.potentialEnergy(i) + object.kineticEnergy(i);

                end

            end
        end
        function plotEnergy( object )
            figure
            o = object;
            plot(o.t,o.potentialEnergy,o.t,o.kineticEnergy,o.t,o.totalEnergy);
            title('Total Energy')
            xlabel('t[s]')
            ylabel('Energy[W]')
            legend('Potential','Kinetic','Total')
        end
    end
    
end

