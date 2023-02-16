clear; close all; clc

[imgup,map] = imread('grass_up.png');
imgup = ind2rgb(imgup,map);
[imgdown,map] = imread('grass_down.png');
imgdown = ind2rgb(imgdown,map);
[imgside,map] = imread('grass_side.png');
imgside = ind2rgb(imgside,map);

h = creatblock(0,0,0,imgup,imgdown,imgside);
H = view3d([0,0,0],3,1,h);





















function h = creatblock(cx,cy,cz,imgup,imgdown,imgside)
R = 15;
[x1,y1,z1] = meshgrid(0:R,0:R,0);
[x2,y2,z2] = meshgrid(0:R,0:R,R);
[y3,z3,x3] = meshgrid(0:R,R:-1:0,0);
[y4,z4,x4] = meshgrid(0:R,R:-1:0,R);
[x5,z5,y5] = meshgrid(0:R,R:-1:0,0);
[x6,z6,y6] = meshgrid(0:R,R:-1:0,R);
x = cat(1,x2,x6,x3,x4,x5,x1)/R-0.5+cx;
y = cat(1,y2,y6,y3,y4,y5,y1)/R-0.5+cy;
z = cat(1,z2,z6,z3,z4,z5,z1)/R-0.5+cz;
img = cat(1,imgup,imgside,imgside,imgside,imgside,imgdown);

h = surf(x,y,z,'EdgeAlpha',0);
set(h,'CData',img,'FaceColor','texturemap');
end



