function f = f( t, Y, M, K )

F = CTemporalSolution.force(t,Y(1:size(M,1))) ;

A = [ zeros(size(M,1)) eye(size(M,1)) ; -M\K zeros(size(M,1)) ] ;
B = [ zeros(size(M,1),1) ; M\F ] ;

f = A * Y + B ;

end

