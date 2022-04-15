function CA = genCA(prn, codeL)

    % Initialize Shift Registers
    G1 = ones(1, 10);
    G2 = ones(1, 10);
    
    % Phase Selector Bit Registers
    PS(1,:) = [2 6];
    PS(2,:) = [3 7];
    PS(3,:) = [4 8];
    PS(4,:) = [5 9];
    PS(5,:) = [1 9];
    PS(6,:) = [2 10];
    PS(7,:) = [1 8];
    PS(8,:) = [2 9];
    PS(9,:) = [3 10];
    PS(10,:) = [2 3];
    PS(11,:) = [3 4];
    PS(12,:) = [5 6];
    PS(13,:) = [6 7];
    PS(14,:) = [7 9];
    PS(15,:) = [8 9];
    PS(16,:) = [9 10];
    PS(17,:) = [1 4];
    PS(18,:) = [2 5];
    PS(19,:) = [3 6];
    PS(20,:) = [4 7];
    PS(21,:) = [5 8];
    PS(22,:) = [6 9];
    PS(23,:) = [1 3];
    PS(24,:) = [4 6];
    PS(25,:) = [5 7];
    PS(26,:) = [6 8];
    PS(27,:) = [7 9];
    PS(28,:) = [8 10];
    PS(29,:) = [1 6];
    PS(30,:) = [2 7];
    PS(31,:) = [3 8];
    PS(32,:) = [4 9];
    PS(33,:) = [5 10];
    PS(34,:) = [4 10];
    PS(35,:) = [1 7];
    PS(36,:) = [2 8];
    PS(37,:) = [4 10];

    % C/A Code Length
    CA = zeros(codeL, 1);

    for i = 1:codeL

        S1 = G2(PS(prn,1));
        S2 = G2(PS(prn,2));
    
        G2i = mod(S1 + S2, 2);
        
        CA(i) = mod(G1(10) +  G2i, 2);
        
        newG1 = mod(G1(3) + G1(10), 2);
        newG2 = mod(G2(2) + G2(3) + G2(6) + G2(8) + G2(9) + G2(10), 2);
    
        G1 = [newG1 G1(1:9)];
        G2 = [newG2 G2(1:9)];

    end

    CA(CA==0) = -1;
 
end