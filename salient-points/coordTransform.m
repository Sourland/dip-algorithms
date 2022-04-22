function [x, y] = coordTransform(i, j, R, N, M)
    x = j + floor(N/2);
    y = -i + floor(M/2);
    uv = floor(R'*[x;y]);
    x = uv(1) - floor(N/2);
    y = floor(M/2) - uv(2);
end