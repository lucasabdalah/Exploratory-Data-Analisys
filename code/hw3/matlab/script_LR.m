%% [TIP7077 - INTELIGENCIA COMPUTACIONAL APLICADA]
% Author: Lucas Abdalah and Brewton Morais
% Homework 3: Data Classication 
% script: script_LR.m
% 2022/11/26 - v1
% Attention: this script uses functions present in:
% https://github.com/lucasabdalah/basic-functions

summary.LR.filename = 'LR_confusion';

%% Train
t = tic;
[LR, vLR] = LR_CV10(train_set);
summary.LR.trainTime = toc(t);

%% Test
t = tic;
test_LR = LR.predictFcn(test_set);
summary.LR.testTime = toc(t);

%% Confusion Matrix
response_testing = cellstr(data.true_testing);
[cm_LR,go_LR] = confusionmat(response_testing,test_LR);

%% Plot Confusion Matrix and export
summary.LR.h = figure;
cm_LR_plot = confusionchart(cm_LR,go_LR);
cm_LR_plot.RowSummary = 'row-normalized';
savefig_tight(summary.LR.h, ['figures/', summary.LR.filename], 'both');

%% Confusion Matrix and Accuracy summary to Text
summary.LR.CFmat = flip(flip(cm_LR),2);
summary.LR.ACC = (cm_LR(1,1) + cm_LR(2,2)) /size(data.Testing,1);

log = ['-', summary.LR.filename, '\n\n', ...
  'Confusion Matrix:\n', sprintf('\t %d %d\n', summary.LR.CFmat'), '\n', ...
  'Accuracy: ', sprintf('%1.3e', summary.LR.ACC), '\n', ...
  'Train Time: ', sprintf('%1.3e', summary.LR.trainTime), '\n', ...
  'Test Time: ', sprintf('%1.3e', summary.LR.testTime)];

log_write(log);