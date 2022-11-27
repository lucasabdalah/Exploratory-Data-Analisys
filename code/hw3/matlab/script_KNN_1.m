%% [TIP7077 - INTELIGENCIA COMPUTACIONAL APLICADA]
% Author: Lucas Abdalah and Brewton Morais
% Homework 3: Data Classication 
% script: script_KNN_1.m
% 2022/11/26 - v1
% Attention: this script uses functions present in:
% https://github.com/lucasabdalah/basic-functions

summary.KNN_1.filename = 'KNN_1_confusion';


f = waitbar(0,'KNN_1');
pause(0.5);


%% Train
waitbar(1/3, f, 'Train KNN_1');
t = tic;
[KNN_1, vKNN_1] = classifiers.KNN_1(train_set); 
summary.KNN_1.trainTime = toc(t);
fprintf('Train time: %1.3e \n', summary.KNN_1.trainTime)


%% Test
waitbar(2/3, f,'Test KNN_1');
t = tic;
test_KNN_1 = KNN_1.predictFcn(test_set);
summary.KNN_1.testTime = toc(t);
fprintf('Test time: %1.3e \n', summary.KNN_1.testTime)


%% Confusion Matrix
response_testing = cellstr(data.true_testing);
[cm_KNN_1,go_KNN_1] = confusionmat(response_testing,test_KNN_1);


%% Plot Confusion Matrix
summary.KNN_1.h = figure;
cm_KNN_1_plot = confusionchart(cm_KNN_1,go_KNN_1);
cm_KNN_1_plot.RowSummary = 'row-normalized';


%% Confusion Matrix and Accuracy summary to Text
summary.KNN_1.CFmat = flip(flip(cm_KNN_1),2);
summary.KNN_1.ACC = (cm_KNN_1(1,1) + cm_KNN_1(2,2)) /size(data.Testing,1);
log = ['- ', summary.KNN_1.filename, '\n\n', ...
'Confusion Matrix:\n', sprintf('\t %d %d\n', summary.KNN_1.CFmat'), '\n', ...
'Accuracy: ', sprintf('%1.3e', summary.KNN_1.ACC), '\n', ...
'Train Time: ', sprintf('%1.3e', summary.KNN_1.trainTime), '\n', ...
'Test Time: ', sprintf('%1.3e', summary.KNN_1.testTime)];


%% Export Results
% savefig_tight(summary.KNN_1.h, ['figures/', summary.KNN_1.filename], 'both');
% log_write(log);

waitbar(3/3, f, "Finish KNN_1");
close(f)