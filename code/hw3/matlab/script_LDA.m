%% [TIP7077 - INTELIGENCIA COMPUTACIONAL APLICADA]
% Author: Lucas Abdalah and Brewton Morais
% Homework 3: Data Classication 
% script: script_LDA.m
% 2022/11/26 - v1
% Attention: this script uses functions present in:
% https://github.com/lucasabdalah/basic-functions

summary.LDA.filename = 'LDA_confusion';

f = waitbar(0,'LDA');
pause(0.5);

%% Train
f = waitbar(1/3, f, 'Train LDA');
t = tic;
[LDA, vLDA] = classifiers.LDA(train_set); 
summary.LDA.trainTime = toc(t);
fprintf('Train time: %1.3e \n', summary.LDA.trainTime)


%% Test
f = waitbar(2/3, f,'Test LDA');
t = tic;
test_LDA = LDA.predictFcn(test_set);
summary.LDA.testTime = toc(t);
fprintf('Test time: %1.3e \n', summary.LDA.testTime)


%% Confusion Matrix
response_testing = cellstr(data.true_testing);
[cm_LDA,go_LDA] = confusionmat(response_testing,test_LDA);

%% Plot Confusion Matrix and export
summary.LDA.h = figure;
cm_LDA_plot = confusionchart(cm_LDA,go_LDA);
cm_LDA_plot.RowSummary = 'row-normalized';
% savefig_tight(summary.LDA.h, ['figures/', summary.LDA.filename], 'both');

%% Confusion Matrix and Accuracy summary to Text
summary.LDA.CFmat = flip(flip(cm_LDA),2);
summary.LDA.ACC = (cm_LDA(1,1) + cm_LDA(2,2)) /size(data.Testing,1);

log = ['- ', summary.LDA.filename, '\n\n', ...
  'Confusion Matrix:\n', sprintf('\t %d %d\n', summary.LDA.CFmat'), '\n', ...
  'Accuracy: ', sprintf('%1.3e', summary.LDA.ACC), '\n', ...
  'Train Time: ', sprintf('%1.3e', summary.LDA.trainTime), '\n', ...
  'Test Time: ', sprintf('%1.3e', summary.LDA.testTime)];

log_write(log);

waitbar(3/3, f, "Finish LDA");
close(f)