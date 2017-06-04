function Yn1 = alphaMethod( tn, Yn, M, K, h, alpha )

options = optimoptions('fsolve','Display','none') ;

Yn1 = fsolve(@(Yn1) Yn1 - Yn - h * ((1-alpha)*CTemporalSolution.f(tn,Yn,M,K)...
    + alpha*CTemporalSolution.f(tn+h,Yn1,M,K)), Yn, options);

end