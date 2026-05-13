
assi_instant = out.assi_instant.Data;
time = out.Magazzino_log.Time;
sezioni = out.sezioni.Data;

sez_m2_l1 = sezioni(:, 1:2);
sez_m3_l1 = sezioni(:, 3:4);

sez_m2_l2 = sezioni(:, 5:6);
sez_m3_l2 = sezioni(:, 7:8);

sez_m2_l3 = sezioni(:, 9:10);
sez_m3_l3 = sezioni(:, 11:12);


%% 1. Setup Dati e Combinazioni (Invariato)
[H_grid, L_grid] = meshgrid(h_index, l_index);
combinazioni_raw = [H_grid(:), L_grid(:)];
combinazioni_sorted = sort(combinazioni_raw, 2);

bin_labels = cell(1, size(combinazioni_raw, 1));
for i = 1:size(combinazioni_raw, 1)
    bin_labels{i} = sprintf('%dX%d', combinazioni_raw(i,1), combinazioni_raw(i,2));
end

num_bins = size(combinazioni_sorted, 1);
num_macchine = 6;
sez_totali = {sez_m2_l1, sez_m3_l1, sez_m2_l2, sez_m3_l2, sez_m2_l3, sez_m3_l3};



%% 2. Pre-calcolo della produzione per ogni istante
% Creiamo una matrice 3D [Bins x Macchine x Tempo] per l'animazione
% NOTA: Per velocizzare l'animazione, campioniamo il tempo (es. ogni 100 step)
step_animazione = 100; 
time_indices = 1:step_animazione:size(assi_instant, 1);

% Inizializziamo la matrice dei conteggi accumulati nel tempo
counts_over_time = zeros(num_bins, num_macchine, length(time_indices));

% Variabile di appoggio per il conteggio corrente
current_counts = zeros(num_bins, num_macchine);

% Calcoliamo l'accumulo (con la logica dell'istante precedente)
for t = 2:size(assi_instant, 1)
    for m = 1:num_macchine
        if assi_instant(t, m) > 0
            % Sezione all'istante PRECEDENTE (t-1)
            sez_raw = sez_totali{m}(t-1, :);
            sez_sorted = sort(sez_raw);
            
            % Trova a quale bin appartiene
            for c = 1:num_bins
                if all(sez_sorted == combinazioni_sorted(c, :))
                    current_counts(c, m) = current_counts(c, m) + assi_instant(t, m);
                    break;
                end
            end
        end
    end
    
    % Salviamo lo stato se siamo in uno step di animazione
    [is_sync, loc] = ismember(t, time_indices);
    if is_sync
        counts_over_time(:, :, loc) = current_counts;
    end
end



%% 3. Animazione del Grafico
figure('Color', 'w', 'Name', 'Produzione nel Tempo');
hold on;
hBar = bar(counts_over_time(:,:,1), 'stacked'); 
grid on;
set(gca, 'XTick', 1:length(bin_labels), 'XTickLabel', bin_labels);
xtickangle(45);
ylabel('Numero Totale di Assi Prodotte');
ylim([0, max(sum(current_counts, 2)) + 10]); 
legend({'M2 L1', 'M3 L1', 'M2 L2', 'M3 L2', 'M2 L3', 'M3 L3'}, 'Location', 'northeastoutside');
set(gca, 'Box', 'on', 'LineWidth', 1.2);

% Loop di aggiornamento (il resto rimane uguale)
for i = 1:length(time_indices)
    for m = 1:num_macchine
        set(hBar(m), 'YData', counts_over_time(:, m, i));
    end
    drawnow limitrate; 
    pause(0.01)
end

% Visualizzazione finale completa
for m = 1:num_macchine
    set(hBar(m), 'YData', current_counts(:, m));
end

