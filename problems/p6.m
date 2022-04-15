%% Fundamentals of GPS - Homework 4 - Problem 6

clear
clc
close all

%% Part A

% Generate C/A Code
codeL = 2046;
prn4 = genCA(4,codeL);
prn7 = genCA(7,codeL);

% Upsample C/A Code
upSamp = 16;
prn4 = reshape(repmat(prn4',upSamp,1),1,[]);
prn7 = reshape(repmat(prn7',upSamp,1),1,[]);

% Autocorrelation
numSamp = length(prn4);
r4 = zeros(numSamp,1);
r7 = zeros(numSamp,1);

for i = 1:numSamp
    r4(i) = prn4*circshift(prn4,i)'/numSamp;
    r7(i) = prn7*circshift(prn7,i)'/numSamp;
end

% Plotting
chips = 5;
lLim = (codeL/2)*upSamp - (chips*upSamp) + 1;
rLim = (codeL/2)*upSamp + (chips*upSamp) - 1;

figure
stem(r4)
axis padded
title('PRN 4 Upsampled Autocorrelation')
ylabel('Sample Autocorrelation')
xlabel('Chips')
xlim([lLim rLim])
xticks([lLim (codeL/2)*upSamp rLim])
xticklabels({'-5','0','5'})

figure
stem(r7)
axis padded
title('PRN 7 Upsampled Autocorrelation')
ylabel('Sample Autocorrelation')
xlabel('Chips')
xlim([lLim rLim])
xticks([lLim (codeL/2)*upSamp rLim])
xticklabels({'-5','0','5'})

%% Part B

% Noisy PRN
sigma = 0.2;
prn4N = prn4 + sigma*randn(1,numSamp);
prn7N = prn7 + sigma*randn(1,numSamp);

% Autocorrelation
r4N = zeros(numSamp,1);
r7N = zeros(numSamp,1);

for i = 1:numSamp
    r4N(i) = prn4N*circshift(prn4N,i)'/numSamp;
    r7N(i) = prn7N*circshift(prn7N,i)'/numSamp;
end

figure
stem(r4N)
axis padded
title('PRN 4 Upsampled Autocorrelation')
ylabel('Sample Autocorrelation')
xlabel('Chips')
xlim([lLim rLim])
xticks([lLim (codeL/2)*upSamp rLim])
xticklabels({'-5','0','5'})

figure
stem(r7N)
axis padded
title('PRN 7 Upsampled Autocorrelation')
ylabel('Sample Autocorrelation')
xlabel('Chips')
xlim([lLim rLim])
xticks([lLim (codeL/2)*upSamp rLim])
xticklabels({'-5','0','5'})