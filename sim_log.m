close all
% Carica i dati dal log di Simulink
data = out.Magazzino_log.Data; 
time = out.Magazzino_log.Time;

dTa = 10; % step per velocizzare l'animazione;

time_new = [time; time(end)*ones(dTa,1)]; % solo per loop di animazione (altrimenti con step troppo alto non comleta il magazzino)
[H_dim, L_dim, T] = size(data); 

% 1. CREAZIONE ETICHETTE PERSONALIZZATE
% Creiamo le griglie basandoci sui VALORI degli indici forniti
[L_grid, H_grid] = meshgrid(l_index, h_index);

% Appiattiamo seguendo l'ordine di reshape di MATLAB (colonna per colonna)
data_flat = reshape(data, H_dim*L_dim, T); 
data_flat_new = [data_flat, ones(size(data_flat,1),dTa).*data_flat(:,end)]; % solo per loop di animazione (altrimenti con step troppo alto non comleta il magazzino)
target_flat = reshape(target_matrice, H_dim*L_dim, 1); 

% Generiamo le stringhe: "H:70, L:30", ecc.
tick_labels = arrayfun(@(h, l) sprintf('%d X %d', h, l), H_grid(:), L_grid(:), 'UniformOutput', false);

% 2. SETUP GRAFICO
figure('Color', 'w', 'Position', [100, 100, 1000, 600]);
hBar = bar(data_flat_new(:,1)); 
grid on; hold on;

% Applicazione etichette reali
set(gca, 'XTick', 1:H_dim*L_dim, ...
         'XTickLabel', tick_labels, ...
         'XTickLabelRotation', 45, ...
         'FontSize', 9);

hTarget = plot(1:H_dim*L_dim, target_flat, 'ro', 'MarkerFaceColor', 'r', 'DisplayName', 'Target');
ylim([0, max(target_flat) + 20]);
ylabel('Quantità Assi');
xlabel('Specifiche Sezione (Altezza H x Larghezza L)');
title('Monitoraggio Magazzino per Tipologia Prodotto');

% Colori 
color_working = [0 0.447 0.741]; 
color_finished = [0.466 0.674 0.188]; 

% 3. LOOP DI ANIMAZIONE
for t = 1:dTa:length(time_new)
    current_vals = data_flat_new(:,t);
    set(hBar, 'YData', current_vals);
    
    colors = repmat(color_working, H_dim*L_dim, 1);
    idx_target_reached = current_vals >= target_flat;
    colors(idx_target_reached, :) = repmat(color_finished, sum(idx_target_reached), 1);
    
    set(hBar, 'FaceColor', 'flat', 'CData', colors);
    title(['Stato Magazzino al tempo: ', num2str(time_new(t), '%.1f'), ' s']);
    drawnow limitrate;
end


