%% [TIP7077 - INTELIGENCIA COMPUTACIONAL APLICADA]
% Author: Lucas Abdalah and Brewton Morais
% Homework 3: Data Classication 
% script: script_ROC.m
% 2022/11/26 - v1

%% Receiver operating characteristic (ROC) 
% curve or other performance curve for classifier output

summary.ROC.filename = 'ROC';

c_ = struct('LR', [57 106 177]./255, 'LDA', [204 37 41]./255, ...
  'SVM', [62 150 81]./255, 'TREE_10', [107 76 154]./255, 'TREE_100', 'm');

[x_lr,y_lr] = perfcurve(train_set.Class,LR.GeneralizedLinearModel.Fitted.Probability,'successful');

[~,score_lda] = resubPredict(LDA.ClassificationDiscriminant);
[x_lda,y_lda] = perfcurve(train_set.Class,score_lda(:,1),'successful');

[~,score_svm] = resubPredict(SVM.ClassificationSVM);
[x_svm,y_svm] = perfcurve(train_set.Class,score_svm(:,1),'successful');

[~,score_tr10] = resubPredict(TREE_10.ClassificationTree);
 diffscore = score_tr10(:,1) - max(score_tr10(:,2));
[x_tr10,y_tr10] = perfcurve(train_set.Class,diffscore,'successful');

[~,score_tr100] = resubPredict(TREE_100.ClassificationTree);
 diffscore = score_tr100(:,1) - max(score_tr100(:,2));
[x_tr100,y_tr100] = perfcurve(train_set.Class,diffscore,'successful');

%% Plot ROC perfomance
summary.ROC.h = figure;
linewidth = 1.5;
plot(x_lr, y_lr,'-', 'color', c_.LR, 'Marker', 'o', 'MarkerFaceColor', ...
c_.LR, 'MarkerIndices', mkrind(x_lr), 'linewidth', linewidth);
hold on;
plot(x_lda, y_lda,'-', 'color', c_.LDA, 'Marker', 's', 'MarkerFaceColor', ...
  c_.LDA, 'MarkerIndices', mkrind(x_lda), 'linewidth', linewidth);
plot(x_svm, y_svm,'-.', 'color', c_.SVM, 'linewidth', linewidth);
plot(x_tr10, y_tr10,'--', 'color', c_.TREE_10, 'Marker', '^', ...
  'MarkerFaceColor', c_.TREE_10, 'MarkerIndices', mkrind(x_tr10), 'linewidth', linewidth);
plot(x_tr100, y_tr100,'--', 'color', c_.TREE_100, 'Marker', 'x', ...
  'MarkerFaceColor', c_.TREE_100, 'MarkerIndices', mkrind(x_tr100), 'linewidth', linewidth);
hold off;
legend('LR', 'LDA', 'SVM', 'TREE-10', 'TREE-100', 'Location', 'Southeast', ... 
  'FontSize', 16, 'Interpreter', 'Latex');
xlabel('False positive rate','FontSize', 16,'Interpreter','Latex');
ylabel('True positive rate','FontSize', 16,'Interpreter','Latex');
grid on


%% Auxiliar functions
function y = mkrind(x)
  y = 1:floor(length(x)/5):length(x);
end