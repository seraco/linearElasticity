classdef CModalSolution < CBaseSolution
    %CMesh
    %   Brief: Main class used to calculate the modal solution
    %   Author: S.Ramon
    %   Version: 0.0.1
    
    properties
        X
        w
    end
    
    methods
        function object = CModalSolution( Mesh, InitialData, LEMatrices, StaticSolution )
            if nargin > 0
                xpoints = Mesh.xpoints;
                T = Mesh.T;
                nnodepelem = Mesh.nnodepelem;
                nelem = Mesh.nelem;
                nnode = Mesh.nnode;
                ndofpn = Mesh.ndofpn;
                postProcessing = InitialData.ModalPost;
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

                for i = 1:size(t,2)

                    xt = zeros(size(object.X,1),1);
                    vt = zeros(size(object.X,1),1);

                    for j = 1:size(object.X,2)

                        xt(N) = xt(N) + object.X(N,j)*(A(j)*cos(object.w(j)*t(i))+B(j)*sin(object.w(j)*t(i)));
                        vt(N) = vt(N) + object.X(N,j)*object.w(j)*(A(j)*-sin(object.w(j)*t(i))+B(j)*cos(object.w(j)*t(i)));

                    end

                    xt(D) = Xo(D) ;
                    vt(D) = Vo(D) ;
                    
                    if postProcessing

                        PostProcessing = CPostProcessing('data/Modal',t(i)) ;

                        PostProcessing.toGID ( xpoints(:,1:3), T, nnodepelem, nelem, nnode );
                        PostProcessing.toGIDPost( nnodepelem, ndofpn, 1, xt' );
                    
                    end

                    object.potentialEnergy(i) = 0.5*xt'*K*xt;
                    object.kineticEnergy(i) = 0.5*vt'*M*vt;

                end

            end
        end
    end
    
end

