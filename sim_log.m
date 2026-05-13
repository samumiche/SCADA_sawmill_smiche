
% Carica i dati dal log di Simulink
data = out.Magazzino_log.Data; 
time = out.Magazzino_log.Time;

dTa = 10; % step per velocizzare animazione;


[H_dim, L_dim, T] = size(data); 


% 1. Creiamo le griglie invertendo l'ordine per ottenere la scansione desiderata
% Usiamo h_index come primo argomento per far sì che cambi più lentamente se usiamo la logica giusta
[L_grid, H_grid] = meshgrid(l_index, h_index);

% 2. TRUCCO PER IL RESHAPE: 
% Poiché 'data' è [H_dim x L_dim x T], e noi vogliamo l'ordine per riga,
% dobbiamo permutare le dimensioni per mettere il tempo alla fine ma 
% gestire l'appiattimento riga per riga.
data_permuted = permute(data, [2, 1, 3]); % Scambiamo H e L internamente
data_flat = reshape(data_permuted, L_dim * H_dim, T); 

% Facciamo lo stesso per il target (che deve seguire lo stesso ordine dei bin)
target_matrice_permuted = target_matrice'; % Trasposta per passare da [H x L] a [L x H]
target_flat = target_matrice_permuted(:); 

% 3. Generiamo le etichette nello stesso ordine
% Ora scorreranno: H1-L1, H1-L2, H1-L3... poi H2-L1, H2-L2...
tick_labels = cell(1, H_dim * L_dim);
k = 1;
for i = 1:H_dim
    for j = 1:L_dim
        tick_labels{k} = sprintf('%d X %d', h_index(i), l_index(j));
        k = k + 1;
    end
end

% --- Logica di Animazione (rimane quasi identica) ---
data_flat_new = [data_flat, ones(size(data_flat,1), dTa) .* data_flat(:,end)];
time_new = [time; time(end)*ones(dTa,1)];

figure('Color', 'w', 'Position', [100, 100, 1000, 600]);
hBar = bar(data_flat_new(:,1)); 
grid on; hold on;

set(gca, 'XTick', 1:H_dim*L_dim, 'XTickLabel', tick_labels, 'XTickLabelRotation', 45, 'FontSize', 9);
hTarget = plot(1:H_dim*L_dim, target_flat, 'ro', 'MarkerFaceColor', 'r', 'DisplayName', 'Target');

% ... (resto del loop for rimane invariato)

ylim([0, max(target_flat) + 20]);
ylabel('Quantità Assi');
xlabel('Specifiche Sezione (Altezza H x Larghezza L)');
title('Monitoraggio Magazzino per Tipologia Prodotto');

% Colori 
color_working = [0 0.447 0.741]; 
color_finished = [0.466 0.674 0.188]; 

% Animazione
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

