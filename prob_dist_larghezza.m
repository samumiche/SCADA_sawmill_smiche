%% Stima Larghezza Assi M1

posterior_m1 = out.posterior_m1.Data;
likelihood_m1 = out.likelihood_m1.Data;
prior_m1 = out.prior_m1.Data;
true_m1 = out.true_larg_m1.Data;

larg_m1 = (0:size(posterior_m1,2)-1); % possibili valori

E_post_m1 = squeeze(sum(posterior_m1 .* larg_m1, 2));
E_like_m1 = squeeze(sum(likelihood_m1 .* larg_m1, 2));
E_prior_m1 = squeeze(sum(prior_m1 .* larg_m1, 2));

figure
hold on;
plot(E_like_m1, 'b'); 
plot(E_prior_m1, 'g');
plot(E_post_m1, 'r', 'LineWidth', 2);
plot(true_m1, 'k--', 'LineWidth', 2);
legend("Likelihood", "Prior", "Posterior", "True")
xlabel("Time step")
ylabel("Larghezza assi stimato (M1)")
grid on
hold off;


% figure()
% for t = 1:100:size(posterior_m1,3)
%     clf
%     plot(posterior_m1(1,:,t), 'r', 'LineWidth', 2); hold on;
%     plot(likelihood_m1(1,:,t), 'b');
%     plot(prior_m1(1,:,t), 'g');
%     xline(true_m1(t), 'k--', 'LineWidth', 2);
% 
%     title(['Time step: ', num2str(t)])
%     legend("Posterior", "Likelihood", "Prior")% , "True")
%     ylim([0 1])
%     grid on
%     pause(1)
% end

%% Stima Larghezza Assi M1

posterior_m4 = out.posterior_m4.Data;
likelihood_m4 = out.likelihood_m4.Data;
prior_m4 = out.prior_m4.Data;
true_m4 = out.true_larg_m4.Data;

larg_m4 = (0:size(posterior_m4,2)-1); % possibili valori

E_post_m4 = squeeze(sum(posterior_m4 .* larg_m4, 2));
E_like_m4 = squeeze(sum(likelihood_m4 .* larg_m4, 2));
E_prior_m4 = squeeze(sum(prior_m4 .* larg_m4, 2));

figure
hold on;
plot(E_like_m4, 'b'); 
plot(E_prior_m4, 'g');
plot(E_post_m4, 'r', 'LineWidth', 2);
plot(true_m4, 'k--', 'LineWidth', 2);
legend("Likelihood", "Prior", "Posterior", "True")
xlabel("Time step")
ylabel("Larghezza assi stimato (M4)")
grid on
hold off;



% figure()
% for t = 1:100:size(posterior_m4,3)
%     clf
%     plot(posterior_m4(1,:,t), 'r', 'LineWidth', 2); hold on;
%     plot(likelihood_m4(1,:,t), 'b');
%     plot(prior_m4(1,:,t), 'g');
%     xline(true_m4(t), 'k--', 'LineWidth', 2);
% 
%     title(['Time step: ', num2str(t)])
%     legend("Posterior", "Likelihood", "Prior")% , "True")
%     ylim([0 1])
%     grid on
%     pause(1)
% end

%% Stima Larghezza Assi M1

posterior_m7 = out.posterior_m7.Data;
likelihood_m7 = out.likelihood_m7.Data;
prior_m7 = out.prior_m7.Data;
true_m7 = out.true_larg_m7.Data;

larg_m7 = (0:size(posterior_m7,2)-1); % possibili valori

E_post_m7 = squeeze(sum(posterior_m7 .* larg_m7, 2));
E_like_m7 = squeeze(sum(likelihood_m7 .* larg_m7, 2));
E_prior_m7 = squeeze(sum(prior_m7 .* larg_m7, 2));

figure
hold on;
plot(E_like_m7, 'b'); 
plot(E_prior_m7, 'g');
plot(E_post_m7, 'r', 'LineWidth', 2);
plot(true_m7, 'k--', 'LineWidth', 2);
legend("Likelihood", "Prior", "Posterior", "True")
xlabel("Time step")
ylabel("Larghezza assi stimato (M1)")
grid on
hold off;


% figure()
% for t = 1:100:size(posterior_m1,3)
%     clf
%     plot(posterior_m1(1,:,t), 'r', 'LineWidth', 2); hold on;
%     plot(likelihood_m1(1,:,t), 'b');
%     plot(prior_m1(1,:,t), 'g');
%     xline(true(t), 'k--', 'LineWidth', 2);
% 
%     title(['Time step: ', num2str(t)])
%     legend("Posterior", "Likelihood", "Prior")% , "True")
%     ylim([0 1])
%     grid on
%     pause(1)
% end