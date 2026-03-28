clear all;
close all;
clc;

%% Legno
%Dt = 350; % Diametro tronco [mm]
h1 = 70; % spessore per M1 [mm]
h2 = 18; 
n_sottili = 4;
w = 50; % spessore per M2 [mm]

% A linea singola
Mag_legno = [0 1 5 2 4 3 1 5 2 4 3 1 5 2 4 3 1 5 2 4 3 1 5 2 4 3 1 5 2 4 3]; % tipologia di legno [0 randi([1 5],1,10)] per vettore con valori randomici
Mag_D = [0 430 320 260 230 540 430 320 260 230 540 430 320 260 230 540 430 320 260 230 540 430 320 260 230 540 430 320 260 230 540]; % diametro del tronco

% Linea 1
Mag_legno1 = [0 1 5 2 4 3 1 3 5 4 2]; % tipologia di legno [0 randi([1 5],1,10)] per vettore con valori randomici
Mag_D1 = [0 430 320 260 230 540 430 320 400 290 350]; % diametro del tronco

% Linea 2
Mag_legno2 = [0 2 3 5 3 4 1 1 3 4 2];
Mag_D2 = [0 250 470 600 320 290 510 300 380 430 210];

% Linea 3
Mag_legno3 = [0 5 3 4 2 2 3 1 5 3 1];
Mag_D3 = [0 320 370 410 550 280 390 310 610 400 310];

kc = [0 35 40 50 55 90];
Lt = 4; % lunghezza tronchi [m]

%% Paremtri Macchina 1

%Sega
t = 1.8; % spessore lama [mm]
s = 0.5*t; % stradatura [mm]
b = t + 2*s;
omega = 50; % velocità angolare sega [rad/s]
Rs = 800; % raggio volani [mm]

% Motore
Kt = 2;
i_id = 60;
% i_max = 100;
Rm = 150; %[m]
B = 0.05; %[Nm s/rad]
Tatt = 4; %[Nm]
SR = Rs/Rm;
Tdamp = B*omega*SR;
Tloss = Tatt+ Tdamp;

%% Parametri Macchina 2

% Threashold parallelo
thrsh = 40;

%Sega
t2 = 5; % spessore lama [mm]
s2 = 0.5*t2; % stradatura [mm]
b2 = t2 + 2*s2;
omega2 = 3000*(2*pi/60); % velocità angolare sega [rad/s]
Rc = 200; % raggio volani [mm]

% Motore
Kt2 = 5;
i_id2 = 60;
% i_max = 100;
Rm2 = 50; %[m]
B2 = 0.05; %[Nm s/rad]
Tatt2 = 4; %[Nm]
SR2 = Rc/Rm2;
Tdamp2 = B2*omega2*SR2;
Tloss2 = Tatt2+ Tdamp2;

%% PRODOTTI FINALI
% N_altezze = 2;
% N_larghezze = 2;

% altezze e larghezze di cui dispongo
h_index = [70, 80, 90];
l_index = [30, 40, 70];

% MATRICE TARGET - h:righe - l:colonne
target_matrice = [50, 100, 50;
                  25, 95, 15;
                  50, 25, 35];

%% prova vettore
% clear all;

% deficit = [1 5 3;
%            8 2 4;
%            10 3 6];
% 
% [max, idx] = sort(deficit(:), 'descend');
% 
% second_linear_idx = idx(2);
% [row, col] = ind2sub(size(deficit), second_linear_idx);