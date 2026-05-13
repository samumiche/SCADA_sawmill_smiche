basi_m = l_index / 1000;
altezze_m = h_index / 1000;

matrice_aree = basi_m' * altezze_m;


n_tronchi_1 = max(out.n_tronchi_1.Data);
n_tronchi_2 = max(out.n_tronchi_2.Data);
n_tronchi_3 = max(out.n_tronchi_3.Data);


% m3 di legname tagliato
volume_totale_m3 = sum(data(:, :, end) .* matrice_aree * 4, 'all')

% m3 di legna
cubi1 = sum((Mag_D1(2:n_tronchi_1)/2000).^2*pi*4);
cubi2 = sum((Mag_D2(2:n_tronchi_2)/2000).^2*pi*4);
cubi3 = sum((Mag_D3(2:n_tronchi_3)/2000).^2*pi*4);

volume_da_tagliare = cubi1 + cubi2 + cubi3

volume_totale_m3/volume_da_tagliare