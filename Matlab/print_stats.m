function stat_vars = print_stats(stats)

GroundTruth = [stats.GroundTruth];
TruePos = [stats.TruePos];
TrueNeg = [stats.TrueNeg];
FalsePos = [stats.FalsePos];
FalseNeg = [stats.FalseNeg];
WrongPos = [stats.WrongPos];

pos = nnz(GroundTruth);
neg = nnz(~GroundTruth);
stat_vars.Positives = pos;
stat_vars.Negatives = neg;

true_pos = nnz(TruePos);
true_neg = nnz(TrueNeg);
false_pos = nnz(FalsePos);
false_neg = nnz(FalseNeg);
wrong_pos = nnz(WrongPos);
stat_vars.TruePositives = true_pos;
stat_vars.FalsePositives = false_pos;
stat_vars.TrueNegatives = true_neg;
stat_vars.FalseNegatives = false_neg;
stat_vars.WrongPositives = wrong_pos;

fprintf('Positives (Total)   :  %d\n', pos);
fprintf('Negatives (Total)   :  %d\n', neg);
fprintf('True Positives      :  %d\n', true_pos);
fprintf('True Negatives      :  %d\n', true_neg);
fprintf('False Positives     :  %d\n', false_pos);
fprintf('False Negatives     :  %d\n', false_neg);
fprintf('Wrong Detections    :  %d\n', wrong_pos);

fprintf('\n');

accuracy = double(true_pos + true_neg) / (pos + neg);
precision = double(true_pos) / (true_pos + false_pos + wrong_pos);
recall = double(true_pos) / pos;
f1_score = 2 * (recall * precision) / (recall + precision);
stat_vars.Accuracy = accuracy;
stat_vars.Precision = precision;
stat_vars.Recall = recall;
stat_vars.F1Score = f1_score;

fprintf('Accuracy            :  %0.2f%%\n', accuracy * 100);
fprintf('Precision           :  %0.2f%%\n', precision * 100);
fprintf('Recall (Sensitivity):  %0.2f%%\n', recall * 100);
fprintf('F1 Score            :  %0.3f\n', f1_score);

fprintf('\n');

ExecTime = [stats.ExecTime];
avg_time_pos = mean(ExecTime(GroundTruth == 1));
avg_time_neg = mean(ExecTime(GroundTruth == 0));
avg_time_true_pos = mean(ExecTime(TruePos == 1));
avg_time_true_neg = mean(ExecTime(TrueNeg == 1));
avg_time_false_pos = mean(ExecTime(FalsePos == 1));
avg_time_false_neg = mean(ExecTime(FalseNeg == 1));
avg_time_wrong_pos = mean(ExecTime(WrongPos == 1));
stat_vars.AvgTimePos = avg_time_pos;
stat_vars.AvgTimeNeg = avg_time_neg;
stat_vars.AvgTimeTruePos = avg_time_true_pos;
stat_vars.AvgTimeTrueNeg = avg_time_true_neg;
stat_vars.AvgTimeFalsePos = avg_time_false_pos;
stat_vars.AvgTimeFalseNeg = avg_time_false_neg;
stat_vars.AvgTimeWrongPos = avg_time_wrong_pos;

fprintf('Average Exec Time for Positive      :  %0.1f ms\n', avg_time_pos * 1000);
fprintf('Average Exec Time for Negative      :  %0.1f ms\n', avg_time_neg * 1000);
fprintf('Average Exec Time for True Positive :  %0.1f ms\n', avg_time_true_pos * 1000);
fprintf('Average Exec Time for True Negative :  %0.1f ms\n', avg_time_true_neg * 1000);
fprintf('Average Exec Time for False Positive:  %0.1f ms\n', avg_time_false_pos * 1000);
fprintf('Average Exec Time for False Negative:  %0.1f ms\n', avg_time_false_neg * 1000);
fprintf('Average Exec Time for Wrong Positive:  %0.1f ms\n', avg_time_wrong_pos * 1000);

fprintf('\n');

ExecTime = [stats.ExecTime];
max_time_pos = max(ExecTime(GroundTruth == 1));
max_time_neg = max(ExecTime(GroundTruth == 0));
max_time_true_pos = max(ExecTime(TruePos == 1));
max_time_true_neg = max(ExecTime(TrueNeg == 1));
max_time_false_pos = max(ExecTime(FalsePos == 1));
max_time_false_neg = max(ExecTime(FalseNeg == 1));
max_time_wrong_pos = max(ExecTime(WrongPos == 1));

fprintf('Maximum Exec Time for Positive      :  %0.1f ms\n', max_time_pos * 1000);
fprintf('Maximum Exec Time for Negative      :  %0.1f ms\n', max_time_neg * 1000);
fprintf('Maximum Exec Time for True Positive :  %0.1f ms\n', max_time_true_pos * 1000);
fprintf('Maximum Exec Time for True Negative :  %0.1f ms\n', max_time_true_neg * 1000);
fprintf('Maximum Exec Time for False Positive:  %0.1f ms\n', max_time_false_pos * 1000);
fprintf('Maximum Exec Time for False Negative:  %0.1f ms\n', max_time_false_neg * 1000);
fprintf('Maximum Exec Time for Wrong Positive:  %0.1f ms\n', max_time_wrong_pos * 1000);

fprintf('\n');

ExecTime = [stats.ExecTime];
min_time_pos = min(ExecTime(GroundTruth == 1));
min_time_neg = min(ExecTime(GroundTruth == 0));
min_time_true_pos = min(ExecTime(TruePos == 1));
min_time_true_neg = min(ExecTime(TrueNeg == 1));
min_time_false_pos = min(ExecTime(FalsePos == 1));
min_time_false_neg = min(ExecTime(FalseNeg == 1));
min_time_wrong_pos = min(ExecTime(WrongPos == 1));

fprintf('Minimum Exec Time for Positive      :  %0.1f ms\n', min_time_pos * 1000);
fprintf('Minimum Exec Time for Negative      :  %0.1f ms\n', min_time_neg * 1000);
fprintf('Minimum Exec Time for True Positive :  %0.1f ms\n', min_time_true_pos * 1000);
fprintf('Minimum Exec Time for True Negative :  %0.1f ms\n', min_time_true_neg * 1000);
fprintf('Minimum Exec Time for False Positive:  %0.1f ms\n', min_time_false_pos * 1000);
fprintf('Minimum Exec Time for False Negative:  %0.1f ms\n', min_time_false_neg * 1000);
fprintf('Minimum Exec Time for Wrong Positive:  %0.1f ms\n', min_time_wrong_pos * 1000);
