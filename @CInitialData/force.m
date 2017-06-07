function F = force( t, fN, w )

    if w == 0
        F = zeros(size(fN,2),1);
    else
        F = fN'*cos(w*t);
    end

end

