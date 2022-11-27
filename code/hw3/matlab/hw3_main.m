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
script_LDA
export_fig(default, summary.LDA.h,['figures/', summary.LDA.filename])
genLog(default, summary.LDA)

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
  fprintf('Saving Results for:\n\t %s \n', filename);
end

function genLog(Activate, input)
  if Activate
    log = [input.filename, '\n', 'Confusion Matrix:\n', ...
    sprintf('%d %d\n', input.CFmat'), '\n', 'Accuracy:', sprintf('%1.3e', input.ACC)];
    log_write(log);
  end
end