

n_m = 2; % n_macchina


% (max_boards_number, n_machines, t_steps)
posterior = out.posterior.Data(:, n_m, :);
likelihood = out.likelihood.Data(:, n_m, :);
prior = out.prior.Data(:, n_m, :);
true = out.assi_instant.Data(:, n_m);
n_assi_stim = out.n_assi_stim;

non_nulle_posterior = any(posterior, [1 2]);
non_nulle_likelihood = any(likelihood, [1 2]);
non_nulle_prior = any(prior, [1 2]);
non_nulle_true = true(:, 1) ~= 0;



% Steps in cui ho dei valori
posterior = posterior(:, :, non_nulle_posterior);
likelihood = likelihood(:, :, non_nulle_likelihood);
prior = prior(:, :, non_nulle_prior);
true = true(non_nulle_true);

% figure()
% plot(posterior(:, :, 1) ,Color="red", LineWidth=2)
% grid on;
% hold on;
% plot(likelihood(:, :, 1), Color="blue")
% plot(prior(:, :, 1), Color="green" , LineWidth=1)
% xline(true(1), LineWidth=2)
% legend("Posterior", "Likelihood", "Prior")


assi = (1:size(posterior,1))'; % possibili valori

E_post = round(squeeze(sum(posterior .* assi, 1)));
E_like = squeeze(sum(likelihood .* assi, 1));
E_prior = squeeze(sum(prior .* assi, 1));



figure(1000)
plot(E_like, 'b'); hold on;
plot(E_prior, 'g'); 
plot(E_post, 'r', 'LineWidth', 2);
plot(true, 'k--', 'LineWidth', 2);
legend("Likelihood", "Prior", "Posterior", "True")
xlabel("Time step")
ylabel("Numero assi stimato")
grid on
hold off;



% figure()
% for t = 1:size(posterior,3)
%     clf
%     plot(posterior(:,1,t), 'r', 'LineWidth', 2); hold on;
%     plot(likelihood(:,1,t), 'b');
%     plot(prior(:,1,t), 'g');
%     xline(true(t), 'k--', 'LineWidth', 2);
% 
%     title(['Time step: ', num2str(t)])
%     legend("Posterior", "Likelihood", "Prior", "True")
%     ylim([0 1])
%     grid on
%     pause(1)
% end