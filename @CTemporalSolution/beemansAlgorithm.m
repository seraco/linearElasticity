function Yn1 = beemansAlgorithm( tn, Ynm1, Yn, M, K, h )

xnm1 = Ynm1(1:size(M,1)) ;
xn = Yn(1:size(M,1)) ;
vn = Yn(size(M,1)+1:size(Yn,1)) ;

xn1 = xn + vn*h + 1/6*(4*CTemporalSolution.a(tn,xn,M,K) - CTemporalSolution.a(tn,xnm1,M,K))*h^2 ;
vn1 = vn + 1/6*(2*CTemporalSolution.a(tn,xn1,M,K) + 5*CTemporalSolution.a(tn,xn,M,K) - CTemporalSolution.a(tn,xnm1,M,K))*h ;

Yn1 = [ xn1; vn1 ] ;

end

