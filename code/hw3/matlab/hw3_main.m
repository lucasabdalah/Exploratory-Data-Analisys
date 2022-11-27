%% [TIP7077 - INTELIGENCIA COMPUTACIONAL APLICADA]
% Author: Lucas Abdalah and Brewton Morais
% Homework 3: Data Classication 
% script: hw3_main.m
% 2022/11/26 - v1
% Attention: this script uses functions present in:
% https://github.com/lucasabdalah/basic-functions

%% Clear Ambient
close all; clearvars; clc; pause(0.1);  

data = load('hw3_data.mat');
default = true;


%% Loop in data preditors
pos = zeros(length(data.reducedSet_s),1);

count = 1;

for p = 1:length(data.predictors)
    if data.predictors(p) == data.reducedSet_s(count)
        pos(count) = p;
        count = count + 1;
    end      
end

pos(count) = p + 1;


%% Split Train and Test Data  
train_set = data.Training(:,pos');
test_set = data.Testing(:,pos'); 


%% Classifiers
script_LR
export_fig(default, summary.LR.h,['figures/', summary.LR.filename])

script_LDA
export_fig(default, summary.LDA.h,['figures/', summary.LDA.filename])

script_KNN_1
export_fig(default, summary.KNN_1.h,['figures/', summary.KNN_1.filename])

script_KNN_50
export_fig(default, summary.KNN_50.h,['figures/', summary.KNN_50.filename])

script_SVM
export_fig(default, summary.SVM.h,['figures/', summary.SVM.filename])

script_TREE_10
export_fig(default, summary.TREE_10.h,['figures/', summary.TREE_10.filename])

script_TREE_100
export_fig(default, summary.TREE_100.h,['figures/', summary.TREE_100.filename])

genLog(default, summary.LR, summary.LDA, summary.KNN_1, summary.KNN_50, ... 
  summary.SVM, summary.TREE_10, summary.TREE_100);


%% ROC
script_ROC
export_fig(default, summary.ROC.h,['figures/', summary.ROC.filename])


%% Auxiliar functions
function export_fig(Activate, h, filename)
  if Activate
      savefig_tight(h, filename, 'both');
      verbose_save(filename);
  else
      pause(2)
      close(h);
  end
end

function verbose_save(filename)
  fprintf('Saving Results for:\n\t %s \n\n', filename);
end

function genLog(Activate, varargin)
  if Activate
    if isempty(varargin)
      log_write('Performed')
    else
      for i = 1:1:length(varargin)
        input = varargin{i};
        log_message{i} = [input.filename, '\n', ...
        'Confusion Matrix:\n', sprintf('%d %d\n', input.CFmat'), ...
        'Accuracy:', sprintf('%1.3e', input.ACC), '\n', ...
        'Train Time: ', sprintf('%1.3e', input.trainTime), '\n', ...
        'Test Time: ', sprintf('%1.3e', input.testTime), '\n.......\n'];

      end
      log_write(strjoin(log_message));
    end
  end
end