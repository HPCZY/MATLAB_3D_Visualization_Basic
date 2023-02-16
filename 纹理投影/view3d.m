function H = view3d(pos,range,flag)

%% 搭框架
H.Fig = figure('Position',[200,100,800,800],'menu','none');
set(H.Fig,'WindowKeyPressFcn',@KeyDown);
set(H.Fig,'WindowScrollWheelFcn',@ScrollWheel);

H.Pnl = uipanel(H.Fig,'Position',[0,0,1,1]);
H.Axes = axes(H.Pnl,'Position',[0.1,0.1,0.8,0.8]);

%% 参数
angle = [10,20];
dD = -range/50;
dA = 2;

%% 显示
if flag
    axis equal
    grid on
    xlabel('x')
    ylabel('y')
    zlabel('z')
end
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
%         range = max(1,range+value*w);
            range = range*(1+value/10);
        update()
    end

%% 更新画面
    function update(~,~)
        axis(H.Axes,[-range+pos(1),range+pos(1),-range+pos(2),range+pos(2),-range+pos(3),range+pos(3)])
        view(H.Axes,angle)
        drawnow
    end

end
