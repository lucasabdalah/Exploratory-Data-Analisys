%% [TIP7077 - INTELIGENCIA COMPUTACIONAL APLICADA]
% Author: Lucas Abdalah and Brewton Morais
% Homework 3: Data Classication 
% script: hw3_main.m
% 2022/11/26 - v1

% cd 'C:\Users\lucasabdalah-dell\Documents\'

%% Clear Ambient
clc; close all; 

data = load('hw3_data.mat');

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

