%% [TIP7077 - INTELIGENCIA COMPUTACIONAL APLICADA]
% Author: Lucas Abdalah and Brewton Morais
% Homework 3: Data Classication 
% script: script_KNN_50.m
% 2022/11/26 - v1
% Attention: this script uses functions present in:
% https://github.com/lucasabdalah/basic-functions

summary.KNN_50.filename = 'KNN_50_confusion';


f = waitbar(0,'KNN_50');
pause(0.5);


%% Train
waitbar(1/3, f, 'Train KNN_50');
t = tic;
[KNN_50, vKNN_50] = classifiers.KNN_50(train_set); 
summary.KNN_50.trainTime = toc(t);
fprintf('Train time: %1.3e \n', summary.KNN_50.trainTime)


%% Test
waitbar(2/3, f,'Test KNN_50');
t = tic;
test_KNN_50 = KNN_50.predictFcn(test_set);
summary.KNN_50.testTime = toc(t);
fprintf('Test time: %1.3e \n', summary.KNN_50.testTime)


%% Confusion Matrix
response_testing = cellstr(data.true_testing);
[cm_KNN_50,go_KNN_50] = confusionmat(response_testing,test_KNN_50);


%% Plot Confusion Matrix and export
summary.KNN_50.h = figure;
cm_KNN_50_plot = confusionchart(cm_KNN_50,go_KNN_50);
cm_KNN_50_plot.RowSummary = 'row-normalized';


%% Confusion Matrix and Accuracy summary to Text
summary.KNN_50.CFmat = flip(flip(cm_KNN_50),2);
summary.KNN_50.ACC = (cm_KNN_50(1,1) + cm_KNN_50(2,2)) /size(data.Testing,1);
log = ['- ', summary.KNN_50.filename, '\n\n', ...
'Confusion Matrix:\n', sprintf('\t %d %d\n', summary.KNN_50.CFmat'), '\n', ...
'Accuracy: ', sprintf('%1.3e', summary.KNN_50.ACC), '\n', ...
'Train Time: ', sprintf('%1.3e', summary.KNN_50.trainTime), '\n', ...
'Test Time: ', sprintf('%1.3e', summary.KNN_50.testTime)];


%% Export Results
% savefig_tight(summary.KNN_50.h, ['figures/', summary.KNN_50.filename], 'both');
% log_write(log);

waitbar(3/3, f, "Finish KNN_50");
close(f)