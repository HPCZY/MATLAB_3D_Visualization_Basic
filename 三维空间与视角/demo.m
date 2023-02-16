function demo()

%% 搭框架
Fig = figure('Position',[200,100,800,800],'menu','none');
set(Fig,'WindowKeyPressFcn',@KeyDown);
set(Fig,'WindowScrollWheelFcn',@ScrollWheel);

Pnl = uipanel(Fig,'Position',[0,0,1,1]);
Axes = axes(Pnl,'Position',[0.1,0.1,0.8,0.8]);

%% 参数
pos = [0,0,0];
range = 20;
angle = [10,20];

dD = .5;
dA = 1;

%% 显示
DrawCube();
axis(Axes,'equal')
grid(Axes,'on')
xlabel('x');
ylabel('y');
zlabel('z');
update()

%% 键盘组
    function KeyDown(~,event)
        switch event.Key
            case 'e'
                pos(3) = pos(3)+dD;
            case 'd'
                pos(3) = pos(3)-dD;
            case 'w'
                pos(2) = pos(2)+dD;
            case 's'
                pos(2) = pos(2)-dD;
            case 'q'
                pos(1) = pos(1)+dD;
            case 'a'
                pos(1) = pos(1)-dD;
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
        axis(Axes,[-range+pos(1),range+pos(1),-range+pos(2),range+pos(2),-range+pos(3),range+pos(3)])
        view(Axes,angle)
        drawnow
    end

end

% 自己写的画魔方的函数（不必在意）
function h = DrawCube()

%% 块定义
% 块八顶点定义（魔方每一个小块上的8个顶点的相对坐标）
blockVertices = [ 1,-1,-1; 1, 1,-1;-1, 1,-1;-1,-1,-1;...
    1,-1, 1; 1, 1, 1;-1, 1, 1;-1,-1, 1]*0.95; % *0.95
% 块六面顶点索引（在上次的基础上优化了一下，用索引表示）
blockFace{1} = [1,2,3,4];
blockFace{2} = [1,2,6,5];
blockFace{3} = [2,3,7,6];
blockFace{4} = [3,4,8,7];
blockFace{5} = [4,1,5,8];
blockFace{6} = [5,6,7,8];

%% 26块中心定义（先用半径1写，完事儿*2，简单快捷，以后想变大直接改）
% 6轴
axisPosList = [0, 0,-1; 1, 0, 0; 0, 1, 0; -1, 0, 0; 0,-1, 0; 0, 0, 1]*2;
% 8角
cornerPosList = [1,-1,-1; 1, 1,-1; -1, 1,-1; -1,-1,-1;...
    1,-1, 1; 1, 1, 1; -1, 1, 1; -1,-1, 1]*2;
% 12棱
edgePosList = [1, 0,-1; 0, 1,-1;-1, 0,-1; 0,-1,-1;...
    1, 1, 0;-1, 1, 0;-1,-1, 0; 1,-1, 0;
    1, 0, 1; 0, 1, 1;-1, 0, 1; 0,-1, 1]*2;

%% 颜色与不透明度  白 蓝 红 绿 橙 黄
color = {[1,1,1],[0,0.2,0.8],[0.8,0,0],[0,0.8,0.2],...
    [1,0.4,0],[1,1,0],[0.1,0.1,0.1]};
colorAlpha = [1,1,1,1,1,1,0.3];

%% 26块6面上色
% 轴块属性初始化
axisBlock = cell(6,1);
for n = 1:6
    axisBlock{n}.position = axisPosList(n,:);
    axisBlock{n}.color = ones(1,6)*7;
    axisBlock{n}.color(n) = n;
end

% 角块属性初始化
cornerBlock = cell(8,1);
for n = 1:8
    cornerBlock{n}.position = cornerPosList(n,:);
    cornerBlock{n}.color = ones(1,6)*7;
end
cornerBlock{1}.color([1,2,5]) = [1,2,5];
cornerBlock{2}.color([1,2,3]) = [1,2,3];
cornerBlock{3}.color([1,3,4]) = [1,3,4];
cornerBlock{4}.color([1,4,5]) = [1,4,5];
cornerBlock{5}.color([6,2,5]) = [6,2,5];
cornerBlock{6}.color([6,2,3]) = [6,2,3];
cornerBlock{7}.color([6,3,4]) = [6,3,4];
cornerBlock{8}.color([6,4,5]) = [6,4,5];

% 棱块属性初始化
edgeBlock = cell(12,1);
for n = 1:12
    edgeBlock{n}.position = edgePosList(n,:);
    edgeBlock{n}.color = ones(1,6)*7;
end
edgeBlock{1}.color([1,2]) = [1,2];
edgeBlock{2}.color([1,3]) = [1,3];
edgeBlock{3}.color([1,4]) = [1,4];
edgeBlock{4}.color([1,5]) = [1,5];
edgeBlock{5}.color([2,3]) = [2,3];
edgeBlock{6}.color([3,4]) = [3,4];
edgeBlock{7}.color([4,5]) = [4,5];
edgeBlock{8}.color([5,2]) = [5,2];
edgeBlock{9}.color([6,2]) = [6,2];
edgeBlock{10}.color([6,3]) = [6,3];
edgeBlock{11}.color([6,4]) = [6,4];
edgeBlock{12}.color([6,5]) = [6,5];

%% 显示一下（利用循环全部绘制）

% 轴块
for n = 1:6
    for f = 1:6
        V = axisBlock{n}.position+blockVertices(blockFace{f},:);
        C = color{axisBlock{n}.color(f)};
        A = colorAlpha(axisBlock{n}.color(f));
        h = patch('Faces',[1 2 3 4],'Vertices',V,'FaceColor',C,...
            'FaceAlpha',A);
    end
end
% 棱
for n = 1:12
    for f = 1:6
        V = edgeBlock{n}.position+blockVertices(blockFace{f},:);
        C = color{edgeBlock{n}.color(f)};
        A = colorAlpha(edgeBlock{n}.color(f));
        h = patch('Faces',[1 2 3 4],'Vertices',V,'FaceColor',C,...
            'FaceAlpha',A);
    end
end
% 角块
for n = 1:8
    for f = 1:6
        V = cornerBlock{n}.position+blockVertices(blockFace{f},:);
        C = color{cornerBlock{n}.color(f)};
        A = colorAlpha(cornerBlock{n}.color(f));
        h = patch('Faces',[1 2 3 4],'Vertices',V,'FaceColor',C,...
            'FaceAlpha',A);
    end
end

end