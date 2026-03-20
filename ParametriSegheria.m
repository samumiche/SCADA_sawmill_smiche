clear all;
close all;
clc;

%% Legno
%Dt = 350; % Diametro tronco [mm]
h1 = 70; % spessore per M1 [mm]
h2 = 18; 
n_sottili = 4;
w = 50; % spessore per M2 [mm]
Mag_legno = [0 1 5 2 4 3]; % tipologia di legno [0 randi([1 5],1,10)] per vettore con valori randomici
Mag_D = [0 430 320 260 230 540]; % diametro del tronco
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


