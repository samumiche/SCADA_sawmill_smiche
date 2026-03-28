%% VISUALIZZAZIONE MAGAZZINO


% Carica i dati (assumendo che si chiamino 'out.MagazzinoStorico')
data = out.Magazzino_log.Data; 
time = out.Magazzino_log.Time;

[H, L, T] = size(data);

% "Appiattiamo" sia i dati che i target per il grafico 2D
data_flat = reshape(data, H*L, T); 
target_flat = reshape(target_matrice, H*L, 1); 

% 2. Setup Grafico
figure('Color', 'w', 'Position', [100, 100, 900, 600]);
hBar = bar(data_flat(:,1)); 
grid on;
hold on;

% Aggiungiamo i marker del target (pallini rossi sopra ogni barra)
hTarget = plot(1:H*L, target_flat, 'ro', 'MarkerFaceColor', 'r');

ylim([0, max(target_flat) + 10]);
ylabel('Numero Assi');
xlabel('Indice Sezione (H x L)');
title('Monitoraggio Produzione e Raggiungimento Target');

% Definiamo i colori
color_working = [0 0.447 0.741]; % Blu (In produzione)
color_finished = [0.466 0.674 0.188]; % Verde (Target raggiunto)

% 3. Loop di Animazione
for t = 1:50:length(time)
    current_vals = data_flat(:,t);
    
    % Aggiorna le altezze delle barre
    set(hBar, 'YData', current_vals);
    
    % Logica del colore: crea una matrice di colori [N_sezioni x 3]
    colors = repmat(color_working, H*L, 1);
    
    % Trova gli indici delle sezioni che hanno raggiunto o superato il target
    idx_target_reached = current_vals >= target_flat;
    colors(idx_target_reached, :) = repmat(color_finished, sum(idx_target_reached), 1);
    
    % Applica i colori alle barre
    set(hBar, 'FaceColor', 'flat', 'CData', colors);
    
    title(['Avanzamento al tempo: ', num2str(time(t), '%.1f'), ' s']);
    drawnow limitrate;
end