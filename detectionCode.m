% Bottle Detetion 
% Number of bottle count inside a case

clc; close all; clear all;
date 

%% Different images testing and detect number of bottle

src= dir('F:\UEF STUDIES\Mejor\Machine Vision\Bottle Detection\img\*.png');
p = 24; % Define number of images you wish to run
for i=1:p;
    stc=strcat('F:\UEF STUDIES\Mejor\Machine Vision\Bottle Detection\img\', src(i).name);
    Img = imread(stc);
    figure, subplot(2,2,1), imshow(Img),title('Original Image');
        bw=im2bw(Img);
        A=bwareaopen(bw,200);
        se=strel('disk', 07);
        B=imclose(A,se);
        C=imfill(B,'holes');
                      
    [centersBright,radiiBright] = imfindcircles(Img,[17 25], ...
    'ObjectPolarity','bright','Sensitivity',0.92);
    subplot(2,2,2), imshow(Img);
    hBright = viscircles(centersBright, radiiBright,'Color','red'); 
    b(:,i)=length(radiiBright);
    str = sprintf('Number of Bottle cap: %d', b(:,i));
    title(str);
    %total cap detected 
    
    %% detect Bottom of the bottle
   [centersBrigh,radiiBrigh] = imfindcircles(C,[36 44], ...
    'ObjectPolarity','bright','Sensitivity',0.92);
    subplot(2,2,3), imshow(Img);
    CBright = viscircles(centersBrigh, radiiBrigh,'Color','b');
    c(:,i)=length(radiiBrigh);
    str = sprintf('Number of Bottle Bottom: %d', c(:,i));
    title(str);
    %total bottom detected
    
end
dlmwrite('Bottle_Cap_Count.txt',b,'delimiter','\n','newline','pc')
dlmwrite('Bottle_Bottom_Count.txt',c,'delimiter','\n','newline','pc')
