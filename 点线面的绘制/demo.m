clear; close all; clc


H = view3d();

x = -2*pi:0.01:2*pi;
y = sin(x);
z = cos(x);

% 点
p1 = plot3(x,y,z,'r.','Parent',H.Axes);

% 线1
l1 = plot3(-x,-y,-z,'b.');

% 线2
l2 = line([-10,10],[0,0],[0,0]);

% 面
F = [1,2,3,4]; % 定义图形的顶点顺序
V = [0,-2,2; 0,-2,-2; 0,2,-2; 0,2,2]; % 定义图形的顶点坐标
C = [1,1,0]; % 定义图形的颜色
A = 0.6; % 定义图形的不透明度 3ew
a = patch('Faces',F,'Vertices',V,'FaceColor',C,'FaceAlpha',A); % 绘制




function H = view3d()

%% 搭框架
H.Fig = figure('Position',[200,100,800,800],'menu','none');
set(H.Fig,'WindowKeyPressFcn',@KeyDown);
set(H.Fig,'WindowScrollWheelFcn',@ScrollWheel);

H.Pnl = uipanel(H.Fig,'Position',[0,0,1,1]);
H.Axes = axes(H.Pnl,'Position',[0.1,0.1,0.8,0.8]);

%% 参数
pos = [0,0,0];
range = 20;
angle = [10,20];

dD = .5;
dA = 1;

%% 显示

axis(H.Axes,'equal')
grid(H.Axes,'on')
hold on 
xlabel('x');
ylabel('y');
zlabel('z');
update()

%% 键盘组
    function KeyDown(~,event)
        switch event.Key
            case 'e'
                pos(3) = pos(3)-dD;
            case 'd'
                pos(3) = pos(3)+dD;
            case 'w'
                pos(2) = pos(2)-dD;
            case 's'
                pos(2) = pos(2)+dD;
            case 'q'
                pos(1) = pos(1)-dD;
            case 'a'
                pos(1) = pos(1)+dD;
            case 'downarrow'
                angle(2) = angle(2)+dA;
            case 'uparrow'
                angle(2) = angle(2)-dA;
            case 'leftarrow'
                angle(1) = angle(1)+dA;
            case 'rightarrow'
                angle(1) = angle(1)-dA;
        end
        update()
    end

%% 鼠标组
    function ScrollWheel(~,event)
        value = event.VerticalScrollCount; % 关键句
        range = max(1,range+value);
        update()
    end

%% 更新画面
    function update(~,~)
        axis(H.Axes,[-range+pos(1),range+pos(1),-range+pos(2),range+pos(2),-range+pos(3),range+pos(3)])
        view(H.Axes,angle)
        drawnow
    end

end
