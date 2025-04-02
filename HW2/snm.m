function snm = snm(x, y, z)
    u1 = 1/sqrt(2) * (y - x);
    u2 = 1/sqrt(2) * (x - z);
    v1 = 1/sqrt(2) * (y + x);
    v2 = 1/sqrt(2) * (z + x);
    
    u = (-1/sqrt(2):0.001:1/sqrt(2));
    v11 = spline(u1, v1, u);
    v22 = spline(u2, v2, u);
    vd = (v11 - v22) / sqrt(2);
    d = abs(diff(vd) ./ diff(u));
    d = [d, d(end)];  % Ensure the length of d is consistent with u
    
    utable = sortrows([u', vd', d'], 3);
    utable = utable(1:7, :);
    
    extermums = utable(:, 2);
    us = utable(:, 1);
    
    ep = extermums(us > 0);
    em = extermums(us < 0);
    
    [~, us_min_ind1] = min(us(us > 0));
    [~, us_min_ind2] = min(-us(us < 0));
    
    if (~isempty(us_min_ind1))
        snm1 = abs(ep(us_min_ind1));
    else
        snm1 = inf;
    end
    
    if (~isempty(us_min_ind2))
        snm0 = abs(em(us_min_ind2));
    else
        snm0 = inf;
    end
    
    snm = min(snm1, snm0);
end
