function generate_stats_plots(X, param_description, stat_vars)

co = [
    0         0.4470    0.7410
    0.8500    0.3250    0.0980
    0.4660    0.6740    0.1880
    0.4940    0.1840    0.5560
    0.3010    0.7450    0.9330
    0.9290    0.6940    0.1250
    0.6350    0.0780    0.1840];
set(groot,'defaultAxesColorOrder',co)

figure;
plot(X, [stat_vars.Accuracy], ...
    X, [stat_vars.Precision], ...
    X, [stat_vars.Recall], ...
    X, [stat_vars.F1Score], ...
    'LineWidth', 2);
title(['Performance of our algorithm vs. ', param_description]);
xlabel('Threshold');
ylabel('Value');
legend('Accuracy', 'Precision', 'Recall', 'F1 Score', 'Location', 'SouthEast');

figure;
plot(X, [stat_vars.TruePositives] ./ [stat_vars.Positives] * 100.0, ...
    X, [stat_vars.TrueNegatives] ./ [stat_vars.Negatives] * 100.0, ...
    'LineWidth', 2);
title(['Performance of our algorithm vs. ', param_description]);
xlabel('Threshold');
ylabel('Percent');
legend('True Positives', 'True Negatives', 'Location', 'SouthEast');

figure;
plot(X, [stat_vars.FalsePositives] ./ [stat_vars.Negatives] * 100.0, ...
    X, [stat_vars.FalseNegatives] ./ [stat_vars.Positives] * 100.0, ...
    X, [stat_vars.WrongPositives] ./ [stat_vars.Positives] * 1000.0, ...
    'LineWidth', 2);
% Note that WrongPositives is multiplied by 1000 instead of 100 for better visualization
title(['Performance of our algorithm vs. ', param_description]);
xlabel('Threshold');
ylabel('Percent');
legend('False Positives', 'False Negatives', 'Wrong Positives', 'Location', 'NorthEast');

figure;
plot(X, [stat_vars.AvgTimeTruePos], ...
    X, [stat_vars.AvgTimeTrueNeg], ...
    X, [stat_vars.AvgTimeFalseNeg], ...
    'LineWidth', 2);
title(['Average execution times of our algorithm vs. ', param_description]);
xlabel('Threshold');
ylabel('Time (ms)');
legend('True Positives', 'True Negatives', 'False Negatives', 'Location', 'NorthEast');
