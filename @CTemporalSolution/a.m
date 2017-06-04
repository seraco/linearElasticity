function a = a( t, x, M, K )

F = CTemporalSolution.force(t,x);

a = M\(F - K*x);

end

