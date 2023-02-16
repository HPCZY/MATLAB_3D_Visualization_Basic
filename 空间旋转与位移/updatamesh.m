function [xq,yq,zq] = updatamesh(x,y,z,dis,angle,zoom)

[m,n,d] = size(x);
num = m*n*d;
x = reshape(x,[1,num]);
y = reshape(y,[1,num]);
z = reshape(z,[1,num]);
center = [(min(x)+max(x))/2;(min(y)+max(y))/2;(min(z)+max(z))/2];
coor = [x;y;z];

Rz = [cos(angle(2)),-sin(angle(2)),0;...
      sin(angle(2)),cos(angle(2)), 0;...
      0,              0,           1];
Ry = [cos(angle(1)), 0, sin(angle(1));...
      0,             1,           0;...
      -sin(angle(1)), 0,cos(angle(1))];

coorp = Rz*Ry*(coor-center)*zoom+center+dis';

xq = reshape(coorp(1,:),[m,n,d]);
yq = reshape(coorp(2,:),[m,n,d]);
zq = reshape(coorp(3,:),[m,n,d]);

end