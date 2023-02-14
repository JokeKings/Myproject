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
I1=rgb2gray(I); %����ɫͼ��ɻ�ɫͼ
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
I1=rgb2gray(I); %����ɫͼ��ɻ�ɫͼ
axes(handles.axes3)
imshow(I1);
I2=im2uint8(mat2gray(log(1+double(I1))))%��һ����Ŵ�0��255����
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
I1=rgb2gray(I); %����ɫͼ��ɻ�ɫͼ
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
I1=rgb2gray(I); %����ɫͼ��ɻ�ɫͼ
axes(handles.axes3)
imshow(I1);
ylim('auto')
g=histeq(I1,256);
figure,imhist(g)
ylim('auto')
axes(handles.axes2)
imshow(g)%ֱ��ͼ���⻯���ͼ��
handles.img=I;
guidata(hObject,handles);

% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%��Ϊ�������������������ֳ�����������������ı�һЩ����ֵ������ͼ�񴫸�����
%�����ŵ������봦��Ȳ����ĺڰ�������������������������������ͼ���и�����
 global T  
 axes(handles.axes1);
 imshow(handles.img);
 T=handles.img;
 mysize=size(handles.img);
prompt={'���뽷��������'};
defans={'0.02'};
p=inputdlg(prompt,'input',1,defans);%prompt����ʾ�input�ǶԻ���ı��⣬1�����뷽��Ĵ�С���ã�defans��������Ĭ��ֵ  
p1=str2num(p{1});
f=imnoise(handles.img,'salt & pepper',p1);  %���ڵ��Գ��ָ��ִ�����ʾ����֪��ʲô����������salt&pepper֮����Ҫ�ո�
 axes(handles.axes2);   
imshow(f);
handles.img=f;
guidata(hObject,handles);

% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%���ȷֲ����Ӹ�˹�ֲ��������׷ֲ����Ӿ��ȷֲ����׹���������ɫ��ļ��ϣ�
%��������Ҳ����������Ƶ���Ϸֲ��ḻ�����ڹ������������ڳ�ֵ��Ƶ�����ޣ�ʱ�����ޣ�
%��ôҲ����˵�������κ�ʱ�̳��ֵ�������ֵ��������ġ�
%��˹�ֲ�Ҳ����̬�ֲ����о�ֵ�ͷ���������������ֵ��Ӧ�˶Գ���ķ�λ��
%�����ʾ����̬�ֲ����ߵ����ݡ���˹�ֲ�������ͨ�������ֲ�
global T
T=handles.img;
mysize=size(handles.img);
axes(handles.axes1);
imshow(handles.img);
prompt={'�����˹����1��','�����˹����2:'};
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
prompt={'������ת�Ƕȣ�'};
		defans={'30'};
		p=inputdlg(prompt,'input',1,defans);%prompt����ʾ�input�ǶԻ���ı��⣬1�����뷽��Ĵ�С���ã�defans��������Ĭ��ֵ 
if ~isempty(p)%�ж�inputdlg�Ƿ��з���ֵ����һ���ж�
		p1=str2num(p{1});
else
return;    
end
handles.im1=imrotate(handles.img,p1,'nearest','crop');%crop
% guidata(hObject,handles);
axes(handles.axes2);
imshow(handles.im1);
handles.img=handles.im1;
guidata(hObject,handles);%��Ҫ�������ݲ�Ȼ����Ĳ����޷���ȡԭ�������ݣ�ʵ�ֲ��˻�ԭ����������

% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.img==0
msgbox('û�пɱ����ͼ��','error');
return;
else
[filename,pathname,filterindex]=...
uiputfile({'*.bmp';'*.tif';'*.png';'*.jpg';'*.jpeg'},'save picture');%�洢ͼƬ·��
end
if filterindex==0
return  %���ȡ������������
else
str=[pathname filename];  %�ϳ�·��+�ļ���
axes(handles.axes2);  %ʹ�õڶ���axes
imwrite(handles.img,str);  %д��ͼƬ��Ϣ��������ͼƬ
end

% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 global T
if handles.img==0 %�ж�ϵͳ�Ƿ��д����ļ�
msgbox('�����뺯��ͼ��','error');
return;
else
 axes(handles.axes1);
 imshow(handles.img);
T=handles.img;
axes(handles.axes2);
prompt={'������ģ��ά�ȣ�'};
defans={'3'};
p=inputdlg(prompt,'input',1,defans);
p1=str2num(p{1});
h1=fspecial('average',[p1 p1]);
I=imfilter(handles.img,h1);%���Կռ��˲�
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
msgbox('�����뺯��ͼ��','error');
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
title('Laplacian�����Ĵ�����')
handlse.img=g3;
guidata(hObject,handles);

I1=mat2gray(T);%ʵ��ͼ�����Ĺ�һ������
[m,n]=size(I1);
newGrayPic=I1;%Ϊ����ͼ��ı�Եһ������
LaplacianNum=0;%��Laplacian���Ӽ���õ���ÿ�����ص�ֵ
LaplacianThreshold=0.2;%�趨��ֵ
for j=2:m-1 %���б߽���ȡ
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
title('Laplacian���ӵĴ�����')

% --- Executes on button press in pushbutton15.
function pushbutton15_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T    
T=handles.img;    
 axes(handles.axes1);
 imshow(handles.img);  
 prompt={'�������±��xλ�ã�','�������±��yλ��:','���볤��','����߶�'};
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

%ʹ�÷���ʵ�ֵ���ֵ�˲�
% global T    
% T=handles.img;
% T1=rgb2gray(T)
% t1=imnoise(T1,'salt & pepper',0.3);%��ӽ�������
% I=medfilt2(t1, [3,3]);
% T1=I;
% axes(handles.axes2)
% imshow(t1);
% title('��ӽ���������ĻҶ�ͼ��'); 
% axes(handles.axes3); 
% imshow(T1);
% title('�����ĻҶ�ͼ��'); 

%����ʵ����ֵ�˲�
global T    
T=handles.img;
T1=rgb2gray(T)
t1=imnoise(T1,'salt & pepper',0.3);%��ӽ�������
[M,N] = size(t1);
prompt={'�����˲���ά�ȣ�'};
defans={'3'};
p=inputdlg(prompt,'input',1,defans);
n=str2double(p{1});
% ��ֵ�˲�
for i = 2:M-n+1
    for j=2:N-n+1
        t = T1(i-1:i+1,j-1:j+1);
        new_img_mid(i,j) =median(t(:));
    end
end
axes(handles.axes2); 
imshow(t1);
title('����������ͼ��')
axes(handles.axes3); 
imshow(new_img_mid)
title('��ֵ�˲�')

% --- Executes on button press in pushbutton17.
function pushbutton17_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T    
T=handles.img;
T1=rgb2gray(T)  %����ȫ�ֱ��� 
t1=imnoise(T1,'salt & pepper',0.3);%��ӽ�������
prompt={'������ģ�����ά�ȣ�'};
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
I1 = 0.299.*T(:,:,1)+0.587.*T(:,:,2)+0.114.*T(:,:,3);   % ת���ɻҶ�ͼ
figure(1)
subplot(1,3,1);
imhist(T(:,:,1),50);
title('Red �Ҷ�ͳ��');
subplot(1,3,2);
imhist(T(:,:,2),50);
title('Green �Ҷ�ͳ��');
subplot(1,3,3);
imhist(T(:,:,3),50);
title('Blue �Ҷ�ͳ��')
% �ԻҶ�ͼ��
figure(2)
imhist(I1);
title('256�Ҷ�ͳ��');

% --- Executes on button press in pushbutton19.
function pushbutton19_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T    
T=handles.img;
I1 = 0.299.*T(:,:,1)+0.587.*T(:,:,2)+0.114.*T(:,:,3);   % ת���ɻҶ�ͼ
axes(handles.axes3)
imshow(I1);
I1  = im2double(I1);
I2 =  im2double(T);         % Ϊ�˶Ծ�����м��㣬������Ҫ����������ת��Ϊfloat����
prompt={'�����Ա任��б��k��','�ؾ�b:'};
defans={'-2','200'};
p=inputdlg(prompt,'input',1,defans);
k=str2double(p{1});
b=str2double(p{2});
% ͼ������Ա任
I3 = k.*I1 + b/255;
axes(handles.axes2); 
imshow(I3);   
title(sprintf('б��Ϊ%d���ؾ�Ϊ%d�����Ա任', k,b)); 
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
title('�����任���ͼ��')
axes(handles.axes3); 
imshow(T1,[]);
title('�����任���Ƶ��')
handles.img=T;
guidata(hObject,handles);

% --- Executes on button press in pushbutton21.
function pushbutton21_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T    
T=handles.img;
I1 = 0.299.*T(:,:,1)+0.587.*T(:,:,2)+0.114.*T(:,:,3);   % ת���ɻҶ�ͼ
axes(handles.axes3)
imshow(I1);
I1  = im2double(I1);
thresh = graythresh(T);    % ����Ӧѡȡ��ֵ
bw2 = imbinarize(I1,thresh);
axes(handles.axes2); 
imshow(bw2);
title('����Ӧ��ֵ')
bw2 = imbinarize(I1,120/255);
%imshow(bw2);
%title('��ѡ120Ϊ��ֵ')
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
I1 = 0.299.*T(:,:,1)+0.587.*T(:,:,2)+0.114.*T(:,:,3);   % ת���ɻҶ�ͼ
I1  = im2double(I1);
I2 =  im2double(T);         % Ϊ�˶Ծ�����м��㣬������Ҫ����������ת��Ϊfloat����
prompt={'����gamaϵ����'};
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
N=2*size(I,2);%ͼ��ߴ������
u=-M/2:(M/2-1);
v=-N/2:(N/2-1);
[U,V]=meshgrid(u,v);%���ɶ�ά�������
D=sqrt(U.^2+V.^2);
D0=40;
n=6;
H=1./(1+(D./D0).^(2*n));%������˹��ǿ����
J=fftshift(fft2(I,size(H,1),size(H,2)));
K=J.*H;
L=ifft2(ifftshift(K));
L=L(1:size(I,1),1:size(I,2));%��Ӹ�˹�������ͼ��
axes(handles.axes2);
imshow(I);
title('��Ӹ�˹�������ͼ��');
axes(handles.axes3);
imshow(L);title('������˹�˲���');

% --- Executes on button press in gaus.
function gaus_Callback(hObject, eventdata, handles)
% hObject    handle to gaus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T    
T=handles.img;
I=rgb2gray(T);
I=imnoise(I,'gaussian');%�����˹������
axes(handles.axes2);
imshow(I);
title('��������������ͼ��');
% ����fft2()���ڼ����ά����Ҷ�任
% ����fftshift()�ǶԺ���fft2()������Ҷ�任��õ���Ƶ�׽���ƽ��,���任���ͼ��Ƶ�����ĴӾ����ԭ���Ƶ����������
% ����ά����Ҷ�任ǰһ��Ҫ�ú���im2double()��ԭʼͼ�������������uint8ת��Ϊdouble����
% �������Ϊunit8��������ֻ�ܱ�ʾ0-255���������������ݽض�,�������ִ�����
s=fftshift(fft2(im2double(I)));
[a,b]=size(s);
d0=30; % ����˹��ͨ�˲����Ľ�ֹƵ��D0����Ϊ30
a0=round(a/2);
b0=round(b/2);
for i=1:a
    for j=1:b
        distance=sqrt((i-a0)^2+(j-b0)^2);    % ���ݸ�˹��ͨ�˲�����ʽH(u,v)=e^-[D^2(u,v)/2*D0^2] 
        h=exp(-(distance*distance)/(2*(d0^2))); % exp��ʾ��eΪ�׵�ָ������
        s(i,j)=h*s(i,j);% Ƶ��ͼ������˲�����ϵ��
    end
end
s=real(ifft2(ifftshift(s)));% �����ж�ά����Ҷ���任ת��Ϊʱ��ͼ��
axes(handles.axes3);
imshow(s,[]); 
title('��˹��ͨ�˲�ͼ��');


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

I=imnoise(I,'gaussian');%�����˹������
axes(handles.axes2);
imshow(I);
title('��������������ͼ��');
% ����fft2()���ڼ����ά����Ҷ�任
% ����fftshift()�ǶԺ���fft2()������Ҷ�任��õ���Ƶ�׽���ƽ��,���任���ͼ��Ƶ�����ĴӾ����ԭ���Ƶ����������
% ����ά����Ҷ�任ǰһ��Ҫ�ú���im2double()��ԭʼͼ�������������uint8ת��Ϊdouble����
% �������Ϊunit8��������ֻ�ܱ�ʾ0-255���������������ݽض�,�������ִ�����
s=fftshift(fft2(im2double(I)));
[a,b]=size(s);
a0=round(a/2);
b0=round(b/2);
d0=50; % �������ͨ�˲����Ľ�ֹƵ��D0����Ϊ50
for i=1:a %˫��forѭ������Ƶ�ʵ�(i,j)��Ƶ�����ĵľ���D(i,j)=sqrt((i-round(a/2)^2+(j-round(b/2)^2))
    for j=1:b 
        distance=sqrt((i-a0)^2+(j-b0)^2);
        if distance<=d0  % ���������ͨ�˲���������ʽ,��D(i,j)<=D0,��Ϊ1
            h=1;
        else
            h=0;        % ���������ͨ�˲���������ʽ,��D(i,j)>D0,��Ϊ0
        end
        s(i,j)=h*s(i,j);% Ƶ��ͼ������˲�����ϵ��
    end
end
% real����ȡԪ�ص�ʵ��
s=real(ifft2(ifftshift(s)));% �����ж�ά����Ҷ���任ת��Ϊʱ��ͼ��
axes(handles.axes3);
imshow(s,[]);
title('�����ͨ�˲�����ͼ��'); 

% --- Executes on button press in max.
function max_Callback(hObject, eventdata, handles)
% hObject    handle to max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T    
T=handles.img;
T1=rgb2gray(T)
t1=imnoise(T1,'salt & pepper',0.3);%��ӽ�������
[M,N] = size(t1);
prompt={'�����˲���ά�ȣ�'};
defans={'3'};
p=inputdlg(prompt,'input',1,defans);
n=str2double(p{1});
% ���ֵ�˲�
for i = 2:M-n+1
    for j=2:N-n+1
        t = T1(i-1:i+1,j-1:j+1);
        new_img_max(i,j) =max(t(:));
    end
end
axes(handles.axes2); 
imshow(t1);
title('����������ͼ��')
axes(handles.axes3); 
imshow(new_img_max)
title('���ֵ�˲�')

% --- Executes on button press in min.
function min_Callback(hObject, eventdata, handles)
% hObject    handle to min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T    
T=handles.img;
T1=rgb2gray(T)
t1=imnoise(T1,'salt & pepper',0.3);%��ӽ�������
[M,N] = size(t1);
prompt={'�����˲���ά�ȣ�'};
defans={'3'};
p=inputdlg(prompt,'input',1,defans);
n=str2double(p{1});
% ��Сֵ�˲�
for i = 2:M-n+1
    for j=2:N-n+1
        t = T1(i-1:i+1,j-1:j+1);
        new_img_min(i,j) =min(t(:));
    end
end
axes(handles.axes2); 
imshow(t1);
title('����������ͼ��')
axes(handles.axes3); 
imshow(new_img_min);
title('��Сֵ�˲�')

% --- Executes on button press in HighpassF.
function HighpassF_Callback(hObject, eventdata, handles)
% hObject    handle to HighpassF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%��˹��ͨ
global T    
T=handles.img;
Y=fft2(im2double(T));%����Ҷ�任
Y=fftshift(Y);%Ƶ�װ���,ֱ���������Ƶ�Ƶ������
figure;
imshow(log(abs(Y)+1),[]); 
title('ͼ����Ҷ�任ȡ��������Ƶ��');
[M,N]=size(Y);%���ͼ��ĸ߶ȺͿ��
h=zeros(M,N);%�˲�������
%ͼ�����ĵ�
M0=M/2;
N0=N/2;
%����Ƶ�ʾ���Բ��ľ��룬delta��ʾ��˹���ߵ���ɢ�̶�
D0=40;
delta=D0;
for x=1:M
    for y=1:N
        %����㣨x,y�������ĵ�ľ���
        d2=(x-M0)^2+(y-N0)^2;
        %�����˹�˲���
        h(x,y)=1-exp(-d2/(2*delta^2));
    end
end
%�˲�����
res=h.*Y;
res=real(ifft2(ifftshift(res)));
axes(handles.axes2);
imshow(res)
title('��˹��ͨ�˲�����ͼ��'); 
axes(handles.axes3);
imshow(h);
title('��˹��ͨ�˲���ͼ��');

% --- Executes on button press in xianboR.
function xianboR_Callback(hObject, eventdata, handles)
% hObject    handle to xianboR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T    
T=handles.img;
%ͼ�����
[M,N] = size(T);
P = 2*M;
Q = 2*N;
fillimage = uint8(zeros(P,Q));
fillimage(1:M,1:N) = T;

%Ƶ�����Ļ�
for x=1:P
    for y=1:Q
        h(x,y)=(-1)^(x+y);
    end
end
fillimagecenter = h.*double(fillimage);
%��ά����Ҷ�任
F = fft2(double(fillimagecenter));
%�ݲ��˲��㷨
H_NF = ones(P,Q);%Ϊ�˷��������۳ˣ�������ones,������ۼӾ���zeros
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
%����Ҷ��任
G_1 = H_NF .* F;
g_1 = real(ifft2(G_1));
g_1 = g_1(1:M,1:N);     
for x = 1:M
    for y = 1:N
        g_1(x,y) = g_1(x,y) * (-1)^(x+y);
    end
end
figure(1);
subplot(221);imshow(T);title('ԭͼ');%��ʾԭͼ

f=fft2(T);          %����Ҷ�任
f=fftshift(f);      %ʹͼ��Գ�
r=real(f);          %ͼ��Ƶ��ʵ��
i=imag(f);          %ͼ��Ƶ���鲿
margin=log(abs(f)); %ͼ������ף���log������ʾ
subplot(222);imshow(margin,[]);title('ԭͼ������');
subplot(223);imshow((H_NF));title('�ݲ��˲���');
subplot(224);imshow(uint8(g_1));title('�ݲ��˲���Ľ��ͼ');

% --- Executes on button press in FakeColor.
function FakeColor_Callback(hObject, eventdata, handles)
% hObject    handle to FakeColor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% ����Ҷȼ�        �����ɫ
% 0��63  1/4         ��ɫ
% 64��127 2/4        ��ɫ
% 128��191 3/4       ��ɫ
% 192��255  4/4      ��ɫ
global T
T=handles.img;
[row,col]=size(T);
range=255;%ÿ��ͨ�������Ҷ�ֵ

R = zeros(row,col);
G = zeros(row,col);
B = zeros(row,col);
for i=1:row
     for j=1:col
        if T(i,j)<=range/4% [0,64]ƫ��
            R(i,j)=0;
            G(i,j)=4*T(i,j);
            B(i,j)=range;
            else if T(i,j)<=range/2% (64,128] ƫ��
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
title('ԭʼrgbͼ��')
subplot(222);imshow(hsi)
title('hsiͼ��') 
subplot(223);imshow(rgb_new)  
title('���Ա任��ǿ���Ⱥ��rgbͼ��') 
subplot(224);imshow(hsi_new)
title('��ǿ���hsiͼ��')

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
title('ԭʼͼ��') 
subplot(222);imshow(hsi)
title('hsiͼ��') 
subplot(223);imshow(rgb_new)
title('��ǿ���rgbͼ��')
subplot(224);imshow(hsi_new)
title('��ǿ���hsiͼ��')

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
title('�ֶ����Ա任��ǿ��rgbͼ��'); 
