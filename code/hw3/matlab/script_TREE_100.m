%% [TIP7077 - INTELIGENCIA COMPUTACIONAL APLICADA]
% Author: Lucas Abdalah and Brewton Morais
% Homework 3: Data Classication 
% script: script_TREE_100.m
% 2022/11/26 - v1
% Attention: this script uses functions present in:
% https://github.com/lucasabdalah/basic-functions

summary.TREE_100.filename = 'TREE_100_confusion';


f = waitbar(0,'TREE_100');
pause(0.5);


%% Train
waitbar(1/3, f, 'Train TREE_100');
t = tic;
[TREE_100, vTREE_100] = classifiers.TREE_100(train_set); 
summary.TREE_100.trainTime = toc(t);
fprintf('Train time: %1.3e \n', summary.TREE_100.trainTime)


%% Test
waitbar(2/3, f,'Test TREE_100');
t = tic;
test_TREE_100 = TREE_100.predictFcn(test_set);
summary.TREE_100.testTime = toc(t);
fprintf('Test time: %1.3e \n', summary.TREE_100.testTime)


%% Confusion Matrix
response_testing = cellstr(data.true_testing);
[cm_TREE_100,go_TREE_100] = confusionmat(response_testing,test_TREE_100);


%% Plot Confusion Matrix and export
summary.TREE_100.h = figure;
cm_TREE_100_plot = confusionchart(cm_TREE_100,go_TREE_100);
cm_TREE_100_plot.RowSummary = 'row-normalized';


%% Confusion Matrix and Accuracy summary to Text
summary.TREE_100.CFmat = flip(flip(cm_TREE_100),2);
summary.TREE_100.ACC = (cm_TREE_100(1,1) + cm_TREE_100(2,2)) /size(data.Testing,1);
log = ['- ', summary.TREE_100.filename, '\n\n', ...
  'Confusion Matrix:\n', sprintf('\t %d %d\n', summary.TREE_100.CFmat'), '\n', ...
  'Accuracy: ', sprintf('%1.3e', summary.TREE_100.ACC), '\n', ...
  'Train Time: ', sprintf('%1.3e', summary.TREE_100.trainTime), '\n', ...
  'Test Time: ', sprintf('%1.3e', summary.TREE_100.testTime)];


%% Export Results
% savefig_tight(summary.TREE_100.h, ['figures/', summary.TREE_100.filename], 'both');
% log_write(log);

waitbar(3/3, f, "Finish TREE_100");
close(f)