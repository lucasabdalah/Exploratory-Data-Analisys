
%% Train
[LDA, vLDA] = LDA_CV10(train_set); 

%% Test
test_LDA = LDA.predictFcn(test_set);

%% Confusion Matrix
response_testing = cellstr(data.true_testing);
[cm_lda,go_lda] = confusionmat(response_testing,test_LDA);

%% Plot Confusion Matrix and export
figure
cm_lda_plot = confusionchart(cm_lda,go_lda);
cm_lda_plot.RowSummary = 'row-normalized';
% saveas(gcf,'test_LDA.pdf')

%% Text summary and export
CFmat = flip(flip(cm_lda),2);
ef_LDA = (cm_lda(1,1) + cm_lda(2,2))/518; 