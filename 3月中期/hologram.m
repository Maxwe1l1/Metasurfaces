clc;
clear;
close all;
% GS算法 远场
% 假设输入图像为512×512像素，256灰度级的灰度图
maxn = 200;% 设置迭代次数
Im = imread('bnu.');
Im=rgb2gray(Im);
Im = double(Im);
im_original = Im./max(max(Im));
% im_original = 1 - im_original;

imshow(im_original,[]);
title('理想光场分布');
% im_hologram表示全息面的图像，im_image表示成像面图像
im_image = im_original.*exp(2i*pi*rand(size(im_original)));% 加入随机相位
for n = 1:maxn % 迭代到指定次数结束
% 反向传播计算全息图
im_hologram = ifft2(ifftshift(im_original.*exp(1i*angle(im_image))));
% 取全息图相位，振幅全部置一，模拟正向传播，计算像面图像
im_image = fftshift(fft2(exp(1i*angle(im_hologram))));
end
angle_hologram = angle(im_hologram);

% 相位全息图显示
figure()
imshow(angle_hologram, [-pi,pi]);
img255=uint8((angle_hologram+pi)/2/pi*255);
imwrite(img255,'D:\far_smile.png');
title('器件面相位分布');

% 光场归一化
im_field = abs(fftshift(fft2(exp(1i*angle(im_hologram)))));
im_field = (im_field -min(min(im_field)))./(max(max(im_field)) - min(min(im_field)));
% 全息像显示
figure()
imshow(im_field);
title('远场光场分布');