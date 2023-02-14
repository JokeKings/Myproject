function varargout = test10(varargin)
% TEST10 MATLAB code for test10.fig
%      TEST10, by itself, creates a new TEST10 or raises the existing
%      singleton*.
%
%      H = TEST10 returns t                   he handle to a new TEST10 or the handle to
%      the existing singleton*.
%
%      TEST10('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TEST10.M with the given input arguments.
%
%      TEST10('Property','Value',...) creates a new TEST10 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before test10_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to test10_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help test10
% Last Modified by GUIDE v2.5 27-Jan-2023 09:37:34
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @test10_OpeningFcn, ...
                   'gui_OutputFcn',  @test10_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before test10 is made visible.
function test10_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to test10 (see VARARGIN)

% Choose default command line output for test10
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes test10 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = test10_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global s
axes(handles.axes1);
[filename,pathname]=uigetfile({'*.*';'*.jpg';'*.bmp';'*.png';'*.tif'},'Read Pic','D:\Matlab1\toolbox\images\imdata');
str=[pathname filename];
s=str;
im=imread(str);
imshow(im)
handles.img=im
guidata(hObject,handles);
% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc;
close all;
close(gcf); 

% --- Executes on button press in tuxiangfanse.
function tuxiangfanse_Callback(hObject, eventdata, handles)
% hObject    handle to tuxiangfanse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T
T=handles.img;
axes(handles.axes1);
imshow(handles.img);
mysize=size(handles.img);
I=imcomplement(handles.img);
axes(handles.axes2)
imshow(I);
handles.img=I
guidata(hObject,handles);

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global I
I=handles.img;
I1=rgb2gray(I); %将彩色图变成灰色图
axes(handles.axes3)
imshow(I1);
model=[0,-1;1,0];
[m,n]=size(I1);
I2=double(I1);
for i=2:m-1
    for j=2:n-1
        I2(i,j)=I1(i+1,j)-I1(i,j+1);
    end
end
axes(handles.axes2)
imshow(I2);
handles.img=I2
guidata(hObject,handles);

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global I
I=handles.img;
I1=rgb2gray(I); %将彩色图变成灰色图
axes(handles.axes3)
imshow(I1);
I2=im2uint8(mat2gray(log(1+double(I1))))%归一化后放大到0，255区间
axes(handles.axes2)
imshow(I2);
handles.img=I2;
guidata(hObject,handles);

% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global I
I=handles.img;
I1=rgb2gray(I); %将彩色图变成灰色图
axes(handles.axes3)
imshow(I1);
model=[-1,0,1;
       -2,0,2;
       -1,0,1];
[m,n]=size(I1);
I2=double(I1);

for i=2:m-1
    for j=2:n-1
        I2(i,j)=I1(i+1,j+1)+2*I1(i+1,j)+I1(i+1,j-1)-I1(i-1,j+1)-2*I1(i-1,j)-I1(i-1,j-1);
    end
end
axes(handles.axes2)
imshow(I2);
handles.img=I2;
guidata(hObject,handles);

% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global I
I=handles.img;
I1=rgb2gray(I); %将彩色图变成灰色图
axes(handles.axes3)
imshow(I1);
ylim('auto')
g=histeq(I1,256);
figure,imhist(g)
ylim('auto')
axes(handles.axes2)
imshow(g)%直方图均衡化后的图像
handles.img=I;
guidata(hObject,handles);

% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%何为椒盐噪声，椒盐噪声又称脉冲噪声，它随机改变一些像素值，是由图像传感器，
%传输信道，解码处理等产生的黑白相间的亮暗点噪声。椒盐噪声往往由图像切割引起
 global T  
 axes(handles.axes1);
 imshow(handles.img);
 T=handles.img;
 mysize=size(handles.img);
prompt={'输入椒盐噪声：'};
defans={'0.02'};
p=inputdlg(prompt,'input',1,defans);%prompt是提示语，input是对话框的标题，1是输入方框的大小设置，defans是输入框的默认值  
p1=str2num(p{1});
f=imnoise(handles.img,'salt & pepper',p1);  %由于调试出现各种错误提示，不知道什么情况，最后发现salt&pepper之间需要空格。
 axes(handles.axes2);   
imshow(f);
handles.img=f;
guidata(hObject,handles);

% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%幅度分布服从高斯分布，概率谱分布服从均匀分布。白光是所有颜色光的集合，
%而白噪声也可以理解成在频谱上分布丰富，且在功率谱上趋近于常值。频域有限，时域无限，
%那么也就是说，它在任何时刻出现的噪声幅值都是随机的。
%高斯分布也称正态分布，有均值和方差两个参数，均值反应了对称轴的方位，
%方差表示了正态分布曲线的胖瘦。高斯分布是最普通的噪声分布
global T
T=handles.img;
mysize=size(handles.img);
axes(handles.axes1);
imshow(handles.img);
prompt={'输入高斯噪声1：','输入高斯噪声2:'};
defans={'0','0.02'};
p=inputdlg(prompt,'input',1,defans);
p1=str2num(p{1});
p2=str2num(p{2});
f=imnoise(handles.img,'gaussian',p1,p2);
axes(handles.axes2);
imshow(f);
handles.img=f;
guidata(hObject,handles);

% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 global T
T=handles.img;
prompt={'输入旋转角度：'};
		defans={'30'};
		p=inputdlg(prompt,'input',1,defans);%prompt是提示语，input是对话框的标题，1是输入方框的大小设置，defans是输入框的默认值 
if ~isempty(p)%判断inputdlg是否有返回值。进一步判断
		p1=str2num(p{1});
else
return;    
end
handles.im1=imrotate(handles.img,p1,'nearest','crop');%crop
% guidata(hObject,handles);
axes(handles.axes2);
imshow(handles.im1);
handles.img=handles.im1;
guidata(hObject,handles);%需要保存数据不然后面的操作无法读取原来的数据，实现不了还原撤销操作。

% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.img==0
msgbox('没有可保存的图像！','error');
return;
else
[filename,pathname,filterindex]=...
uiputfile({'*.bmp';'*.tif';'*.png';'*.jpg';'*.jpeg'},'save picture');%存储图片路径
end
if filterindex==0
return  %如果取消操作，返回
else
str=[pathname filename];  %合成路径+文件名
axes(handles.axes2);  %使用第二个axes
imwrite(handles.img,str);  %写入图片信息，即保存图片
end

% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 global T
if handles.img==0 %判断系统是否有处理文件
msgbox('请输入函数图像！','error');
return;
else
 axes(handles.axes1);
 imshow(handles.img);
T=handles.img;
axes(handles.axes2);
prompt={'请输入模板维度：'};
defans={'3'};
p=inputdlg(prompt,'input',1,defans);
p1=str2num(p{1});
h1=fspecial('average',[p1 p1]);
I=imfilter(handles.img,h1);%线性空间滤波
end
imshow(I);
handles.img=I;
guidata(hObject,handles);

% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T
if handles.img==0
msgbox('请输入函数图像！','error');
return;
else
 axes(handles.axes1);
 imshow(handles.img);
T=handles.img;
axes(handles.axes2);
h=fspecial('sobel');
g2=imfilter(handles.img,h);
g3=imadd(g2,handles.img);
end
imshow(g3);
handles.img=g3;
guidata(hObject,handles);

% --- Executes on button press in pushbutton14.
function pushbutton14_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T
T=handles.img;
axes(handles.axes2);
h=fspecial('laplacian');
g2=imfilter(handles.img,h);
g3=imadd(g2,handles.img);
imshow(g3);
title('Laplacian方法的处理结果')
handlse.img=g3;
guidata(hObject,handles);

I1=mat2gray(T);%实现图像矩阵的归一化操作
[m,n]=size(I1);
newGrayPic=I1;%为保留图像的边缘一个像素
LaplacianNum=0;%经Laplacian算子计算得到的每个像素的值
LaplacianThreshold=0.2;%设定阈值
for j=2:m-1 %进行边界提取
    for k=2:n-1
        LaplacianNum=abs(4*I1(j,k)-I1(j-1,k)-I1(j+1,k)-I1(j,k+1)-I1(j,k-1));
        if(LaplacianNum > LaplacianThreshold)
            newGrayPic(j,k)=255;
        else
            newGrayPic(j,k)=0;
        end
    end
end
axes(handles.axes3);
result = imadd(im2double(T),(im2double(newGrayPic)));
imshow(result);
title('Laplacian算子的处理结果')

% --- Executes on button press in pushbutton15.
function pushbutton15_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T    
T=handles.img;    
 axes(handles.axes1);
 imshow(handles.img);  
 prompt={'输入左下标的x位置：','输入左下标的y位置:','输入长度','输入高度'};
defans={'403','0','810','1080'};
p=inputdlg(prompt,'input',1,defans);
p1=str2num(p{1});
p2=str2num(p{2});
p3=str2num(p{3});
p4=str2num(p{4});
I = imcrop(T,[p1,p2,p3,p4]);
axes(handles.axes2);
imshow(I);
handles.img=I;
guidata(hObject,handles);

% --- Executes on button press in mid.
function mid_Callback(hObject, eventdata, handles)
% hObject    handle to mid (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%使用方法实现的中值滤波
% global T    
% T=handles.img;
% T1=rgb2gray(T)
% t1=imnoise(T1,'salt & pepper',0.3);%添加椒盐噪声
% I=medfilt2(t1, [3,3]);
% T1=I;
% axes(handles.axes2)
% imshow(t1);
% title('添加椒盐噪声后的灰度图像'); 
% axes(handles.axes3); 
% imshow(T1);
% title('处理后的灰度图像'); 

%代码实现中值滤波
global T    
T=handles.img;
T1=rgb2gray(T)
t1=imnoise(T1,'salt & pepper',0.3);%添加椒盐噪声
[M,N] = size(t1);
prompt={'输入滤波器维度：'};
defans={'3'};
p=inputdlg(prompt,'input',1,defans);
n=str2double(p{1});
% 中值滤波
for i = 2:M-n+1
    for j=2:N-n+1
        t = T1(i-1:i+1,j-1:j+1);
        new_img_mid(i,j) =median(t(:));
    end
end
axes(handles.axes2); 
imshow(t1);
title('添加噪声后的图像')
axes(handles.axes3); 
imshow(new_img_mid)
title('中值滤波')

% --- Executes on button press in pushbutton17.
function pushbutton17_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T    
T=handles.img;
T1=rgb2gray(T)  %定义全局变量 
t1=imnoise(T1,'salt & pepper',0.3);%添加椒盐噪声
prompt={'请输入模板矩阵维度：'};
defans={'3'};
p=inputdlg(prompt,'input',1,defans);
p1=str2num(p{1});
k1=filter2(fspecial('average',p1),t1);
axes(handles.axes2);
imshow(t1)
axes(handles.axes3); 
imshow(uint8(k1));

% --- Executes on button press in pushbutton18.
function pushbutton18_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T    
T=handles.img;
I1 = 0.299.*T(:,:,1)+0.587.*T(:,:,2)+0.114.*T(:,:,3);   % 转化成灰度图
figure(1)
subplot(1,3,1);
imhist(T(:,:,1),50);
title('Red 灰度统计');
subplot(1,3,2);
imhist(T(:,:,2),50);
title('Green 灰度统计');
subplot(1,3,3);
imhist(T(:,:,3),50);
title('Blue 灰度统计')
% 对灰度图像
figure(2)
imhist(I1);
title('256灰度统计');

% --- Executes on button press in pushbutton19.
function pushbutton19_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T    
T=handles.img;
I1 = 0.299.*T(:,:,1)+0.587.*T(:,:,2)+0.114.*T(:,:,3);   % 转化成灰度图
axes(handles.axes3)
imshow(I1);
I1  = im2double(I1);
I2 =  im2double(T);         % 为了对矩阵进行计算，这里需要把数据类型转换为float类型
prompt={'设线性变换的斜率k：','截距b:'};
defans={'-2','200'};
p=inputdlg(prompt,'input',1,defans);
k=str2double(p{1});
b=str2double(p{2});
% 图像的线性变换
I3 = k.*I1 + b/255;
axes(handles.axes2); 
imshow(I3);   
title(sprintf('斜率为%d，截距为%d的线性变换', k,b)); 
handles.img=T;
guidata(hObject,handles);

% --- Executes on button press in pushbutton20.
function pushbutton20_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T    
T=handles.img;
F = fft2(im2double(T));
T1 = log(F+1);
T2=im2double(T);
L=log(T2+1);
axes(handles.axes2); 
imshow(L,[]);
title('对数变换后的图像')
axes(handles.axes3); 
imshow(T1,[]);
title('对数变换后的频谱')
handles.img=T;
guidata(hObject,handles);

% --- Executes on button press in pushbutton21.
function pushbutton21_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T    
T=handles.img;
I1 = 0.299.*T(:,:,1)+0.587.*T(:,:,2)+0.114.*T(:,:,3);   % 转化成灰度图
axes(handles.axes3)
imshow(I1);
I1  = im2double(I1);
thresh = graythresh(T);    % 自适应选取阈值
bw2 = imbinarize(I1,thresh);
axes(handles.axes2); 
imshow(bw2);
title('自适应阈值')
bw2 = imbinarize(I1,120/255);
%imshow(bw2);
%title('自选120为阈值')
handles.img=T;
guidata(hObject,handles);

% --- Executes on button press in pushbutton22.
function pushbutton22_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T
handles.img=T;
axes(handles.axes2);
imshow(T);
guidata(hObject,handles);

% --- Executes on button press in pushbutton23.
function pushbutton23_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global s
im=imread(s);
axes(handles.axes2);
imshow(im);
handles.img=im;
guidata(hObject,handles);

% --- Executes on button press in pushbutton24.
function pushbutton24_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T    
T=handles.img;
I1 = 0.299.*T(:,:,1)+0.587.*T(:,:,2)+0.114.*T(:,:,3);   % 转化成灰度图
I1  = im2double(I1);
I2 =  im2double(T);         % 为了对矩阵进行计算，这里需要把数据类型转换为float类型
prompt={'输入gama系数：'};
defans={'0.75'};
p=inputdlg(prompt,'input',1,defans);
gama=str2double(p{1});
axes(handles.axes2)
imshow(imadjust(T,[],[],gama));  
title(sprintf('gama = %d',gama));
handles.img=T;
guidata(hObject,handles);

% --- Executes on button press in Batewosi.
function Batewosi_Callback(hObject, eventdata, handles)
% hObject    handle to Batewosi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T    
T=handles.img;
I=im2double(T);
I=imnoise(I,'gaussian',0,0.03);
M=2*size(I,1);
N=2*size(I,2);%图像尺寸的两倍
u=-M/2:(M/2-1);
v=-N/2:(N/2-1);
[U,V]=meshgrid(u,v);%生成二维网格矩阵
D=sqrt(U.^2+V.^2);
D0=40;
n=6;
H=1./(1+(D./D0).^(2*n));%巴特沃斯增强函数
J=fftshift(fft2(I,size(H,1),size(H,2)));
K=J.*H;
L=ifft2(ifftshift(K));
L=L(1:size(I,1),1:size(I,2));%添加高斯噪声后的图像
axes(handles.axes2);
imshow(I);
title('添加高斯噪声后的图像');
axes(handles.axes3);
imshow(L);title('巴特沃斯滤波器');

% --- Executes on button press in gaus.
function gaus_Callback(hObject, eventdata, handles)
% hObject    handle to gaus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T    
T=handles.img;
I=rgb2gray(T);
I=imnoise(I,'gaussian');%加入高斯白噪声
axes(handles.axes2);
imshow(I);
title('加入噪声后所得图像');
% 函数fft2()用于计算二维傅立叶变换
% 函数fftshift()是对函数fft2()作傅里叶变换后得到的频谱进行平移,将变换后的图像频谱中心从矩阵的原点移到矩阵的中心
% 作二维傅里叶变换前一定要用函数im2double()把原始图像的数据类型由uint8转化为double类型
% 否则会因为unit8数据类型只能表示0-255的整数而出现数据截断,进而出现错误结果
s=fftshift(fft2(im2double(I)));
[a,b]=size(s);
d0=30; % 将高斯低通滤波器的截止频率D0设置为30
a0=round(a/2);
b0=round(b/2);
for i=1:a
    for j=1:b
        distance=sqrt((i-a0)^2+(j-b0)^2);    % 根据高斯低通滤波器公式H(u,v)=e^-[D^2(u,v)/2*D0^2] 
        h=exp(-(distance*distance)/(2*(d0^2))); % exp表示以e为底的指数函数
        s(i,j)=h*s(i,j);% 频域图像乘以滤波器的系数
    end
end
s=real(ifft2(ifftshift(s)));% 最后进行二维傅里叶反变换转换为时域图像
axes(handles.axes3);
imshow(s,[]); 
title('高斯低通滤波图像');


% --- Executes on button press in Tongtai.
function Tongtai_Callback(hObject, eventdata, handles)
% hObject    handle to Tongtai (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in ILPF.
function ILPF_Callback(hObject, eventdata, handles)
% hObject    handle to ILPF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T    
T=handles.img;
I=rgb2gray(T);

I=imnoise(I,'gaussian');%加入高斯白噪声
axes(handles.axes2);
imshow(I);
title('加入噪声后所得图像');
% 函数fft2()用于计算二维傅立叶变换
% 函数fftshift()是对函数fft2()作傅里叶变换后得到的频谱进行平移,将变换后的图像频谱中心从矩阵的原点移到矩阵的中心
% 作二维傅里叶变换前一定要用函数im2double()把原始图像的数据类型由uint8转化为double类型
% 否则会因为unit8数据类型只能表示0-255的整数而出现数据截断,进而出现错误结果
s=fftshift(fft2(im2double(I)));
[a,b]=size(s);
a0=round(a/2);
b0=round(b/2);
d0=50; % 将理想低通滤波器的截止频率D0设置为50
for i=1:a %双重for循环计算频率点(i,j)与频域中心的距离D(i,j)=sqrt((i-round(a/2)^2+(j-round(b/2)^2))
    for j=1:b 
        distance=sqrt((i-a0)^2+(j-b0)^2);
        if distance<=d0  % 根据理想低通滤波器产生公式,当D(i,j)<=D0,置为1
            h=1;
        else
            h=0;        % 根据理想低通滤波器产生公式,当D(i,j)>D0,置为0
        end
        s(i,j)=h*s(i,j);% 频域图像乘以滤波器的系数
    end
end
% real函数取元素的实部
s=real(ifft2(ifftshift(s)));% 最后进行二维傅里叶反变换转换为时域图像
axes(handles.axes3);
imshow(s,[]);
title('理想低通滤波所得图像'); 

% --- Executes on button press in max.
function max_Callback(hObject, eventdata, handles)
% hObject    handle to max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T    
T=handles.img;
T1=rgb2gray(T)
t1=imnoise(T1,'salt & pepper',0.3);%添加椒盐噪声
[M,N] = size(t1);
prompt={'输入滤波器维度：'};
defans={'3'};
p=inputdlg(prompt,'input',1,defans);
n=str2double(p{1});
% 最大值滤波
for i = 2:M-n+1
    for j=2:N-n+1
        t = T1(i-1:i+1,j-1:j+1);
        new_img_max(i,j) =max(t(:));
    end
end
axes(handles.axes2); 
imshow(t1);
title('添加噪声后的图像')
axes(handles.axes3); 
imshow(new_img_max)
title('最大值滤波')

% --- Executes on button press in min.
function min_Callback(hObject, eventdata, handles)
% hObject    handle to min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T    
T=handles.img;
T1=rgb2gray(T)
t1=imnoise(T1,'salt & pepper',0.3);%添加椒盐噪声
[M,N] = size(t1);
prompt={'输入滤波器维度：'};
defans={'3'};
p=inputdlg(prompt,'input',1,defans);
n=str2double(p{1});
% 最小值滤波
for i = 2:M-n+1
    for j=2:N-n+1
        t = T1(i-1:i+1,j-1:j+1);
        new_img_min(i,j) =min(t(:));
    end
end
axes(handles.axes2); 
imshow(t1);
title('添加噪声后的图像')
axes(handles.axes3); 
imshow(new_img_min);
title('最小值滤波')

% --- Executes on button press in HighpassF.
function HighpassF_Callback(hObject, eventdata, handles)
% hObject    handle to HighpassF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%高斯高通
global T    
T=handles.img;
Y=fft2(im2double(T));%傅里叶变换
Y=fftshift(Y);%频谱搬移,直流分量搬移到频谱中心
figure;
imshow(log(abs(Y)+1),[]); 
title('图像傅里叶变换取对数所得频谱');
[M,N]=size(Y);%获得图像的高度和宽度
h=zeros(M,N);%滤波器函数
%图像中心点
M0=M/2;
N0=N/2;
%截至频率距离圆点的距离，delta表示高斯曲线的扩散程度
D0=40;
delta=D0;
for x=1:M
    for y=1:N
        %计算点（x,y）到中心点的距离
        d2=(x-M0)^2+(y-N0)^2;
        %计算高斯滤波器
        h(x,y)=1-exp(-d2/(2*delta^2));
    end
end
%滤波后结果
res=h.*Y;
res=real(ifft2(ifftshift(res)));
axes(handles.axes2);
imshow(res)
title('高斯高通滤波所得图像'); 
axes(handles.axes3);
imshow(h);
title('高斯高通滤波器图象');

% --- Executes on button press in xianboR.
function xianboR_Callback(hObject, eventdata, handles)
% hObject    handle to xianboR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T    
T=handles.img;
%图像填充
[M,N] = size(T);
P = 2*M;
Q = 2*N;
fillimage = uint8(zeros(P,Q));
fillimage(1:M,1:N) = T;

%频域中心化
for x=1:P
    for y=1:Q
        h(x,y)=(-1)^(x+y);
    end
end
fillimagecenter = h.*double(fillimage);
%二维傅里叶变换
F = fft2(double(fillimagecenter));
%陷波滤波算法
H_NF = ones(P,Q);%为了方便后面的累乘，所以用ones,如果是累加就用zeros
for u = 1:P
     for v = 1:Q
        D = 30;
        v_k = 60; u_k = 80;
        D_k1 = ((u-P/2-u_k)^2 + (v-Q/2-v_k)^2)^(0.5);
        D_k2 = ((u-P/2+u_k)^2 + (v-Q/2+v_k)^2)^(0.5);
        H_NF(u,v) = H_NF(u,v) * 1/(1+(D/D_k1)^4) * 1/(1+(D/D_k2)^4);
        
        v_k = 60; u_k = 160;
        D_k1 = ((u-P/2-u_k)^2 + (v-Q/2-v_k)^2)^(0.5);
        D_k2 = ((u-P/2+u_k)^2 + (v-Q/2+v_k)^2)^(0.5);
        H_NF(u,v) = H_NF(u,v) * 1/(1+(D/D_k1)^4) * 1/(1+(D/D_k2)^4);
        
        v_k = -45; u_k = 84;
        D_k1 = ((u-P/2-u_k)^2 + (v-Q/2-v_k)^2)^(0.5);
        D_k2 = ((u-P/2+u_k)^2 + (v-Q/2+v_k)^2)^(0.5);
        H_NF(u,v) = H_NF(u,v) * 1/(1+(D/D_k1)^4) * 1/(1+(D/D_k2)^4);
        
        v_k = -15; u_k = 167;
        D_k1 = ((u-P/2-u_k)^2 + (v-Q/2-v_k)^2)^(0.5);
        D_k2 = ((u-P/2+u_k)^2 + (v-Q/2+v_k)^2)^(0.5);
        H_NF(u,v) = H_NF(u,v) * 1/(1+(D/D_k1)^4) * 1/(1+(D/D_k2)^4);
     end
end
%傅里叶逆变换
G_1 = H_NF .* F;
g_1 = real(ifft2(G_1));
g_1 = g_1(1:M,1:N);     
for x = 1:M
    for y = 1:N
        g_1(x,y) = g_1(x,y) * (-1)^(x+y);
    end
end
figure(1);
subplot(221);imshow(T);title('原图');%显示原图

f=fft2(T);          %傅里叶变换
f=fftshift(f);      %使图像对称
r=real(f);          %图像频域实部
i=imag(f);          %图像频域虚部
margin=log(abs(f)); %图像幅度谱，加log便于显示
subplot(222);imshow(margin,[]);title('原图幅度谱');
subplot(223);imshow((H_NF));title('陷波滤波器');
subplot(224);imshow(uint8(g_1));title('陷波滤波后的结果图');

% --- Executes on button press in FakeColor.
function FakeColor_Callback(hObject, eventdata, handles)
% hObject    handle to FakeColor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 输入灰度级        输出彩色
% 0～63  1/4         蓝色
% 64～127 2/4        紫色
% 128～191 3/4       黄色
% 192～255  4/4      红色
global T
T=handles.img;
[row,col]=size(T);
range=255;%每个通道的最大灰度值

R = zeros(row,col);
G = zeros(row,col);
B = zeros(row,col);
for i=1:row
     for j=1:col
        if T(i,j)<=range/4% [0,64]偏蓝
            R(i,j)=0;
            G(i,j)=4*T(i,j);
            B(i,j)=range;
            else if T(i,j)<=range/2% (64,128] 偏紫
                 R(i,j)=0;
                 G(i,j)=range;
                 B(i,j)=-4*T(i,j)+2*range;
                else if T(i,j)<=3*range/4% (128, 192]
                        R(i,j)=4*T(i,j)-2*range;
                        G(i,j)=range;
                        B(i,j)=0;
                     else
                        R(i,j)=range;
                        G(i,j)=4*(range-T(i,j));
                        B(i,j)=0;
                    end
                end
        end
    end
end

out = zeros(row,col);
for i=1:row
    for j=1:col
              out(i,j,1)=R(i,j);
              out(i,j,2)=G(i,j);
              out(i,j,3)=B(i,j);
    end
end
out=out/256;
axes(handles.axes2); 
imshow(out);

% --- Executes on button press in pushbutton38.
function pushbutton38_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton38 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T
T=handles.img;
hsi = rgb2hsi(T); 
H = hsi(:,:,1); 
S = hsi(:,:,2);
I = hsi(:,:,3);
I =I*1.4; 
hsi_new = cat(3,H,S,I);
rgb_new = hsi2rgb(hsi_new); 
rgb_new = min(rgb_new,150);
figure;
subplot(221);imshow(T) 
title('原始rgb图像')
subplot(222);imshow(hsi)
title('hsi图像') 
subplot(223);imshow(rgb_new)  
title('线性变换增强亮度后的rgb图像') 
subplot(224);imshow(hsi_new)
title('增强后的hsi图像')

% --- Executes on button press in pushbutton39.
function pushbutton39_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton39 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T
T=handles.img;
hsi = rgb2hsi(T); 
H = hsi(:,:,1); 
S = hsi(:,:,2);
I = hsi(:,:,3);
S =S*2.0;
I=I*1.4;
hsi_new = cat(3,H,S,I);
rgb_new = hsi2rgb(hsi_new); 
rgb_new = min(rgb_new,100);
figure;
subplot(221);imshow(T)
title('原始图像') 
subplot(222);imshow(hsi)
title('hsi图像') 
subplot(223);imshow(rgb_new)
title('增强后的rgb图像')
subplot(224);imshow(hsi_new)
title('增强后的hsi图像')

% --- Executes on button press in pushbutton40.
function pushbutton40_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton40 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T
T=handles.img;
[o p q]=size(T);
r(:,:,1)=T(:,:,1);
r(:,:,2)=zeros(o,p); 
r(:,:,3)=zeros(o,p);
r=imadjust(r,[0.2 0.8],[0,1]);
g(:,:,2)=T(:,:,2);
g(:,:,1)=zeros(o,p); 
g(:,:,3)=zeros(o,p);
g=imadjust(g,[0.2 0.8],[0,1]);
b(:,:,3)=T(:,:,3);
b(:,:,2)=zeros(o,p); 
b(:,:,1)=zeros(o,p);
b=imadjust(b,[0.2 0.8],[0,1]);
rgb_new(:,:,1)=r(:,:,1); 
rgb_new(:,:,2)=g(:,:,2);
rgb_new(:,:,3)=b(:,:,3);
axes(handles.axes2);
imshow(rgb_new);
title('分段线性变换增强后rgb图像'); 
