classdef CTemporalSolution < CBaseSolution
    %CMesh
    %   Brief: Main class used to calculate the temporal solution
    %   Author: S.Ramon
    %   Version: 0.0.1
    
    methods
        function object = CTemporalSolution( Mesh, InitialData, LEMatrices, StaticSolution )
            if nargin > 0
                xpoints = Mesh.xpoints;
                T = Mesh.T;
                nnodepelem = Mesh.nnodepelem;
                nelem = Mesh.nelem;
                nnode = Mesh.nnode;
                ndofpn = Mesh.ndofpn;
                postProcessing = InitialData.TemporalPost;
                D = InitialData.D;
                N = InitialData.N;
                object.t = InitialData.t;
                t = InitialData.t;
                integratorType = InitialData.Integrator;
                w = InitialData.w;
                M = LEMatrices.M;
                K = LEMatrices.K;
                Xo(D) = StaticSolution.u(D);
                Xo(N) = StaticSolution.u(N);
                Vo =  zeros(size(M,1),1);
                fN = StaticSolution.f(N);
                
                Ynm1 = [ Xo(N)'; Vo(N) ];
                Yn = [ Xo(N)'; Vo(N) ];
                h = t(2) - t(1);

                object.potentialEnergy = zeros(1, size(t,2));
                object.kineticEnergy = zeros(1, size(t,2));
                
                switch integratorType
                    case 'forwardEuler'
                        Integrator = CForwardEIntegrator;
                    case 'backwardEuler'
                        Integrator = CBackwardEIntegrator;
                    case 'midPointImplicit'
                        Integrator = CMidPImplicitIntegrator;
                    case 'alphaMethod'
                        Integrator = CAlphaMethodIntegrator;
                    case 'beemansAlgorithm'
                        Integrator = CBeemansAIntegrator;
                end

                for i = 1:size(t,2)

                    Yn1 = Integrator.step( t(i), Ynm1, Yn, M(N,N), K(N,N), h, 0.5, fN, w );

                    xt(N) = Yn1(1:size(Yn1,1)/2);
                    xt(D) = Xo(D);
                    vt(N) = Yn1(size(Yn1,1)/2+1:size(Yn1,1));
                    vt(D) = Vo(D);

                    object.potentialEnergy(i) = 0.5*xt*K*xt';
                    object.kineticEnergy(i) = 0.5*vt*M*vt';
                    
                    if postProcessing

                        PostProcessing = CPostProcessing('data/Temporal',t(i));

                        PostProcessing.toGID ( xpoints(:,1:3), T, nnodepelem, nelem, nnode );
                        PostProcessing.toGIDPost( nnodepelem, ndofpn, 1, xt' );
            
                    end

                    Ynm1 = Yn;
                    Yn = Yn1;

                end
            end
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

