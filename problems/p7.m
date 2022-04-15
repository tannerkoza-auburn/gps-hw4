%% Fundamentals of GPS - Homework 4 - Problem 7

clear
clc
close all

%% Serial Search

% Data Import
tData = 0.01; % 2 ms of Signal
[sig, sigSamps] = parseIFEN(tData);
s1 = sig(1:sigSamps/2);
s2 = sig((sigSamps/2)+1:end);

% Time Initialization
tInt = tData/2;
fS = 20e6;
tS = 1/fS;
n = 0:tS:tInt-tS;

% Code Initialization
prn = 7;
codeL = 1023;

% Code Upsampling
ca = genCA(prn,codeL);
caU = sample(ca',sigSamps/2,1.023e6,fS,0);
sShift = (sigSamps/2)/codeL;
% caU = interp1(linspace(0,1,codeL), ca, (linspace(0,1,(tInt/tS))));
% caUl = length(caU);

% Doppler Initialization
fIF = 5000445.88565834; % Intermediate Frequency (Hz)
fBin = 500; % Frequency Bin Size (Hz)
fLim = 10000; % Doppler Frequency Limit (Hz)
fSearch = (fIF-fLim):fBin:(fIF+fLim); % Frequency Search Space
fSearchL = length(fSearch); % Frequency Search Space Length

% Correlation
R1 = zeros(fSearchL,codeL);
R2 = zeros(fSearchL,codeL);

for i = 1:fSearchL
    for j = 1:codeL
        I = s1'.*caU'.*cos(2*pi*fSearch(i)*n);
        Q = s1'.*caU'.*sin(2*pi*fSearch(i)*n);
        R1(i,j) = sum(I)^2 + sum(Q)^2;

        caU = sample(ca',sigSamps/2,1.023e6,fS,j);
%         ca = circshift(ca,j);
    end
end
% figure
% surf(R1)

for i = 1:fSearchL
    for j = 1:codeL
        I = s2'.*caU'.*cos(2*pi*fSearch(i)*n);
        Q = s2'.*caU'.*sin(2*pi*fSearch(i)*n);
        R2(i,j) = sum(I)^2 + sum(Q)^2;

        caU = sample(ca',sigSamps/2,1.023e6,fS,j);
%         ca = circshift(ca,j);
    end
end
% figure
% surf(R2)

% figure
% surf(R1+R2)

%% Plotting
[X,Y] = meshgrid(1:codeL, 0:fBin:2*fLim);

figure
surf(X,Y,R1)
title('Correlation: Chunk 1')
xlabel('Code Phase (Chips)')
ylabel('Doppler (Hz)')
zlabel('Correlation')
xlim([0 codeL])

figure
surf(X,Y,R2)
title('Correlation: Chunk 2')
xlabel('Code Phase (Chips)')
ylabel('Doppler (Hz)')
zlabel('Correlation')
xlim([0 codeL])

figure
surf(X,Y,R1+R2)
title('Correlation: Stacked')
xlabel('Code Phase (Chips)')
ylabel('Doppler (Hz)')
zlabel('Correlation')
xlim([0 codeL])
