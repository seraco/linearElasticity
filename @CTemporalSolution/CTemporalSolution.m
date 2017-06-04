classdef CTemporalSolution
    %CMesh
    %   Brief: Main class used to calculate the temporal solution
    %   Author: S.Ramon
    %   Version: 0.0.1
    %   Todo: Set totalEnergy as dependent property
    
    properties
        potentialEnergy
        kineticEnergy
        totalEnergy
        t
    end
    
    methods
        function object = CTemporalSolution( InitialData, LEMatrices, StaticSolution )
            if nargin > 0
                D = InitialData.D;
                N = InitialData.N;
                object.t = InitialData.t;
                t = InitialData.t;
                M = LEMatrices.M;
                K = LEMatrices.K;
                Xo(D) = StaticSolution.u(D);
                Xo(N) = StaticSolution.u(N);
                Vo =  zeros(size(M,1),1);
                
                Ynm1 = [ Xo(N)'; Vo(N) ];
                Yn = [ Xo(N)'; Vo(N) ];
                h = t(2) - t(1);

                object.potentialEnergy = zeros(1, size(t,2));
                object.kineticEnergy = zeros(1, size(t,2));
                object.totalEnergy = zeros(1, size(t,2));

                for i = 1:size(t,2)

                    Yn1 = object.beemansAlgorithm( t, Ynm1, Yn, M(N,N), K(N,N), h );

                    xt(N) = Yn1(1:size(Yn1,1)/2);
                    xt(D) = Xo(D);
                    vt(N) = Yn1(size(Yn1,1)/2+1:size(Yn1,1));
                    vt(D) = Vo(D);

                    object.potentialEnergy(i) = 0.5*xt*K*xt';
                    object.kineticEnergy(i) = 0.5*vt*M*vt';
                    object.totalEnergy(i) = object.potentialEnergy(i) + object.kineticEnergy(i);

            %         filename = 'data/problema7_FE';
            % 
            %         ToGID ( filename, t(i), xpoints(:,1:3), T, nnodepelem, nelem, nnode );
            %         ToGiD_post( filename, t(i), nnodepelem, ndofpn, 1, xt' );

                    Ynm1 = Yn;
                    Yn = Yn1;

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
    methods (Static)
        Yn1 = forwardEuler( tn, Yn, M, K, h )
        Yn1 = backwardEuler( tn, Yn, M, K, h )
        Yn1 = alphaMethod( tn, Yn, M, K, h, alpha )
        Yn1 = midPointImplicit( tn, Yn, M, K, h )
        Yn1 = beemansAlgorithm( tn, Ynm1, Yn, M, K, h )
        f = f( t, Y, M, K )
        a = a( t, x, M, K )
        F = force( t, x )
    end
    
end

