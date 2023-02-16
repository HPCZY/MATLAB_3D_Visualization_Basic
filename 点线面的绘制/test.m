clear; close all; clc

x = -2*pi:0.01:2*pi;
y = sin(x);
z = cos(x);

figure
axis('equal')
grid('on')
hold on 
xlabel('x');
ylabel('y');
zlabel('z');
view([20,30])

% % 点
% plot3(x,y,z,'r.')
% 
% % 线1
% plot3(-x,-y,-z,'b.')
% 
% % 线2
% line([-10,10],[0,0],[0,0],'color',[0,0,0])

% 面
F = [1,2,3,4;5,6,7,8;1,2,6,5;3,4,8,7;1,4,8,5;2,3,7,6]; % 定义图形的顶点顺序
V = [2,-2,2; 2,-2,-2; 2,2,-2; 2,2,2;...
    -2,-2,2; -2,-2,-2; -2,2,-2; -2,2,2];
A = 0.99; % 定义图形的不透明度 
color = {[0,.8,.2],[0,.2,.8],[1,1,1],[1,1,0],[.8,.0,0],[1,.4,0]};
for n = 1:6
    patch('Faces',F(n,:),'Vertices',V,'FaceColor',color{n},'FaceAlpha',A) % 绘制
end










