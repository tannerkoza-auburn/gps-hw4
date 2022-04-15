function [signalData, samplesRead] = parseIFEN(tInt)

% File Information
fileName = 'gpsBase_IFEN_IF.bin';
dataType = 'int8';

% Sampling Frequency
fS = 20e6; % (20 MHz)

% Number of Samples Requested
dataSize = floor(tInt*fS);

% Open File & Extract Data
fileID = fopen(sprintf('%s',fileName));
fseek(fileID,0,'bof');
[signalData,samplesRead] = fread(fileID,dataSize,dataType);

end