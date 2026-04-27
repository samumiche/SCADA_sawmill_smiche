clear all;
close all;
clc;

%% Simulation
Tsim = 1800;
dT = 0.025;

%% Legno
%Dt = 350; % Diametro tronco [mm]
h1 = 70; % spessore per M1 [mm]
h2 = 18; 
n_sottili = 4;
w = 50; % spessore per M2 [mm]

% A linea singola
Mag_legno = [0 randi([1 5], 1, 150)]; % tipologia di legno [0 randi([1 5],1,10)] per vettore con valori randomici
Mag_D =[0 randi([220 500], 1, 150)]; % diametro del tronco

% Linea 1
% Mag_legno1 = [0 1 5 2 4 3 1 3 5 4 2 2 3 5 3 4 1 1 3 4 2]; % tipologia di legno [0 randi([1 5],1,10)] per vettore con valori randomici
% Mag_D1 = [0 430 320 260 230 540 430 320 400 290 350 320 370 410 550 280 390 310 610 400 310]; % diametro del tronco
Mag_legno1 = [0 randi([1 5], 1, 40)];
Mag_D1 = [0 randi([220 500], 1, 40)];

% Linea 2
% Mag_legno2 = [0 2 3 5 3 4 1 1 3 4 2 5 3 4 2 2 3 1 5 3 1];
% Mag_D2 = [0 250 470 600 320 290 510 300 380 430 210 430 320 260 230 540 430 320 400 290 350];
Mag_legno2 = [0 randi([1 5], 1, 40)];
Mag_D2 = [0 randi([220 500], 1, 40)];

% Linea 3
% Mag_legno3 = [0 5 3 4 2 2 3 1 5 3 1 1 5 2 4 3 1 3 5 4 2];
% Mag_D3 = [0 320 370 410 550 280 390 310 610 400 310 250 470 600 320 290 510 300 380 430 210];
Mag_legno3 = [0 randi([1 5], 1, 40)];
Mag_D3 = [0 randi([220 500], 1, 40)];

Lt = 4; % lunghezza tronchi [m]

% [ 0, abete, pino, larice, faggio, quercia]
kc = [0, 25, 30, 35, 50, 70];
rho = [0, 450, 520, 590, 710, 780]*1e-9;

%% Parametri Genereali 
n_linee = 3;
V_mean1 = 0.75;
V_mean23 = 1;

%% Paremtri Macchina 1

%Sega
t = 1.8; % spessore lama [mm]
s = 0.5*t; % stradatura [mm]
b = t + 2*s;
omega_ref1 = 50; % velocità angolare sega [rad/s]
Rs = 800; % raggio volani [mm]


% Motore
J1 = 8*1e6; % [mm^2]
Kt = 10000;
Rm = 150; %[m]
SR = Rs/Rm;

%% Parametri Macchina 2


%Sega
t2 = 5; % spessore lama [mm]
s2 = 0.5*t2; % stradatura [mm]
b2 = t2 + 2*s2;
omega_ref2 = 3000*(2*pi/60); % velocità angolare sega [rad/s]
Rc = 200; % raggio volani [mm]


% Motore
J2 = 0.9*1e6; % [mm^2]
Kt2 = 4500;
Rm2 = 50; %[m]
SR2 = Rc/Rm2;

%% PRODOTTI FINALI


% altezze e larghezze di cui dispongo
h_index = [70, 80, 90, 100];
l_index = [20, 30, 40, 50];

% MATRICE TARGET - h:righe - l:colonne
% target_matrice = [100, 95, 150;
%                   40, 200, 70;
%                   50, 25, 55];

target_matrice = randi([50, 100], length(h_index), length(l_index));

% target_matrice = [600, 100;
%                   100, 100];




% PARTO A PRODURRE QUELLI CON PIù DEFICIT
deficit = target_matrice;
[val, idx] = sort(deficit(:), 'descend');

[h_start_1, l_start_1] = ind2sub(size(target_matrice), idx(1));
[h_start_2, l_start_2] = ind2sub(size(target_matrice), idx(2));
[h_start_3, l_start_3] = ind2sub(size(target_matrice), idx(3));
[h_start_4, l_start_4] = ind2sub(size(target_matrice), idx(4));
[h_start_5, l_start_5] = ind2sub(size(target_matrice), idx(5));
[h_start_6, l_start_6] = ind2sub(size(target_matrice), idx(6));




