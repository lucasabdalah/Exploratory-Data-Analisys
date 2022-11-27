%% [TIP7077 - INTELIGENCIA COMPUTACIONAL APLICADA]
% Author: Lucas Abdalah and Brewton Morais
% Homework 3: Data Classication 
% script: script_TREE_10.m
% 2022/11/26 - v1
% Attention: this script uses functions present in:
% https://github.com/lucasabdalah/basic-functions

summary.TREE_10.filename = 'TREE_10_confusion';


f = waitbar(0,'TREE_10');
pause(0.5);


%% Train
waitbar(1/3, f, 'Train TREE_10');
t = tic;
[TREE_10, vTREE_10] = classifiers.TREE_10(train_set); 
summary.TREE_10.trainTime = toc(t);
fprintf('Train time: %1.3e \n', summary.TREE_10.trainTime)


%% Test
waitbar(2/3, f,'Test TREE_10');
t = tic;
test_TREE_10 = TREE_10.predictFcn(test_set);
summary.TREE_10.testTime = toc(t);
fprintf('Test time: %1.3e \n', summary.TREE_10.testTime)


%% Confusion Matrix
response_testing = cellstr(data.true_testing);
[cm_TREE_10,go_TREE_10] = confusionmat(response_testing,test_TREE_10);


%% Plot Confusion Matrix and export
summary.TREE_10.h = figure;
cm_TREE_10_plot = confusionchart(cm_TREE_10,go_TREE_10);
cm_TREE_10_plot.RowSummary = 'row-normalized';


%% Confusion Matrix and Accuracy summary to Text
summary.TREE_10.CFmat = flip(flip(cm_TREE_10),2);
summary.TREE_10.ACC = (cm_TREE_10(1,1) + cm_TREE_10(2,2)) /size(data.Testing,1);
log = ['- ', summary.TREE_10.filename, '\n\n', ...
  'Confusion Matrix:\n', sprintf('\t %d %d\n', summary.TREE_10.CFmat'), '\n', ...
  'Accuracy: ', sprintf('%1.3e', summary.TREE_10.ACC), '\n', ...
  'Train Time: ', sprintf('%1.3e', summary.TREE_10.trainTime), '\n', ...
  'Test Time: ', sprintf('%1.3e', summary.TREE_10.testTime)];

  
%% Export Results
% savefig_tight(summary.TREE_10.h, ['figures/', summary.TREE_10.filename], 'both');
% log_write(log);

waitbar(3/3, f, "Finish TREE_10");
close(f)