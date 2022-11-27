%% [TIP7077 - INTELIGENCIA COMPUTACIONAL APLICADA]
% Author: Lucas Abdalah and Brewton Morais
% Homework 3: Data Classication 
% script: script_LR.m
% 2022/11/26 - v1
% Attention: this script uses functions present in:
% https://github.com/lucasabdalah/basic-functions

summary.LR.filename = 'LR_confusion';

f = waitbar(0,'LR');
pause(0.5);

%% Train
f = waitbar(1/3, f, 'Train LR');
t = tic;
[LR, vLR] = classifiers.LR(train_set);
summary.LR.trainTime = toc(t);
fprintf('Train time: %1.3e \n', summary.LR.trainTime)

%% Test
f = waitbar(2/3, f,'Test LR');
t = tic;
test_LR = LR.predictFcn(test_set);
summary.LR.testTime = toc(t);
fprintf('Test time: %1.3e \n', summary.LR.testTime)

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

log = ['- ', summary.LR.filename, '\n\n', ...
  'Confusion Matrix:\n', sprintf('\t %d %d\n', summary.LR.CFmat'), '\n', ...
  'Accuracy: ', sprintf('%1.3e', summary.LR.ACC), '\n', ...
  'Train Time: ', sprintf('%1.3e', summary.LR.trainTime), '\n', ...
  'Test Time: ', sprintf('%1.3e', summary.LR.testTime)];

log_write(log);

waitbar(3/3, f, "Finish LR");
close(f)