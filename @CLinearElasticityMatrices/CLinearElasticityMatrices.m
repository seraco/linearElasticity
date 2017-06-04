classdef CLinearElasticityMatrices
    %CLinearElasticityMatrices
    %   Brief: Main class used to calculate the matrices for the linear elastic problem
    %   Author: S.Ramon
    %   Version: 0.0.1
    
    properties
        M
        K
    end
    
    methods
        function object = CLinearElasticityMatrices( mesh, iData )
            if nargin > 0
                
                xpoints = mesh.xpoints;
                T = mesh.T;
                nelem = mesh.nelem;
                nnode = mesh.nnode;
                ndofpn = mesh.ndofpn;
                nnodepelem = mesh.nnodepelem;
                alpha = iData.alpha;
                A = iData.A;
                E = iData.E;
                ro = iData.ro;

                object.M = zeros( nnode*ndofpn, nnode*ndofpn ) ;
                object.K = zeros( nnode*ndofpn, nnode*ndofpn ) ;

                for ielem = 1:nelem

                    x1 = xpoints( T(ielem,1), : ) ;
                    x2 = xpoints( T(ielem,2), : ) ;

                    v = x2 - x1;
                    iVec = [ 1, 0, 0 ];

                    L = norm(v);
                    theta = acos(dot(v, iVec)/L) ;
                    u = cross(v, iVec) ;
                    if norm(u) ~= 0
                        u = u/norm(u) ;
                    end

                    ML = object.MLocal( ro, A, L, alpha, theta, u(1), u(2), u(3) ) ;
                    KL = object.KLocal( A, E, L, theta, u(1), u(2), u(3) ) ;

                    for i = 1:size(KL, 1)
                        for j = 1:size(KL, 2)

                            inodepelem = mod(i-1, nnodepelem) + 1 ;
                            jnodepelem = mod(j-1, nnodepelem) + 1 ;

                            idofpn = floor((i-1)/nnodepelem) + 1 ;
                            jdofpn = floor((j-1)/nnodepelem) + 1 ;

                            ig = T(ielem,inodepelem) + (idofpn - 1)*nnode ;
                            jg = T(ielem,jnodepelem) + (jdofpn - 1)*nnode ;

                            object.M(ig,jg) = object.M(ig,jg) + ML(i,j) ;
                            object.K(ig,jg) = object.K(ig,jg) + KL(i,j) ;

                        end
                    end
                end
            end
        end
    end
    methods (Static)
        ML = MLocal( ro, A, L, alpha, theta, ux, uy, uz )
        KL = KLocal( A, E, L, theta, ux, uy, uz )
    end
    
end

