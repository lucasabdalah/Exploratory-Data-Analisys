%% [TIP7077 - INTELIGENCIA COMPUTACIONAL APLICADA]
% Author: Lucas Abdalah and Brewton Morais
% Homework 3: Data Classication 
% script: script_SVM.m
% 2022/11/26 - v1
% Attention: this script uses functions present in:
% https://github.com/lucasabdalah/basic-functions

summary.SVM.filename = 'SVM_confusion';


f = waitbar(0,'SVM');
pause(0.5);


%% Train
waitbar(1/3, f, 'Train SVM');
t = tic;
[SVM, vSVM] = classifiers.SVM(train_set); 
summary.SVM.trainTime = toc(t);
fprintf('Train time: %1.3e \n', summary.SVM.trainTime)


%% Test
waitbar(2/3, f,'Test SVM');
t = tic;
test_SVM = SVM.predictFcn(test_set);
summary.SVM.testTime = toc(t);
fprintf('Test time: %1.3e \n', summary.SVM.testTime)


%% Confusion Matrix
response_testing = cellstr(data.true_testing);
[cm_SVM,go_SVM] = confusionmat(response_testing,test_SVM);


%% Plot Confusion Matrix and export
summary.SVM.h = figure;
cm_SVM_plot = confusionchart(cm_SVM,go_SVM);
cm_SVM_plot.RowSummary = 'row-normalized';


%% Confusion Matrix and Accuracy summary to Text
summary.SVM.CFmat = flip(flip(cm_SVM),2);
summary.SVM.ACC = (cm_SVM(1,1) + cm_SVM(2,2)) /size(data.Testing,1);
log = ['- ', summary.SVM.filename, '\n\n', ...
  'Confusion Matrix:\n', sprintf('\t %d %d\n', summary.SVM.CFmat'), '\n', ...
  'Accuracy: ', sprintf('%1.3e', summary.SVM.ACC), '\n', ...
  'Train Time: ', sprintf('%1.3e', summary.SVM.trainTime), '\n', ...
  'Test Time: ', sprintf('%1.3e', summary.SVM.testTime)];


%% Export Results
% savefig_tight(summary.SVM.h, ['figures/', summary.SVM.filename], 'both');
% log_write(log);

waitbar(3/3, f, "Finish SVM");
close(f)