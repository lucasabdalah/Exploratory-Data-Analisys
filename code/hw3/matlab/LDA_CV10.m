function [trainedClassifier, validationAccuracy] = LDA_CV10(trainingData)
  % [trainedClassifier, validationAccuracy] = trainClassifier(trainingData)
  % returns a trained classifier and its accuracy. This code recreates the
  % classification model trained in Classification Learner app. Use the
  % generated code to automate training the same model with new data, or to
  % learn how to programmatically train models.
  %
  %  Input:
  %      trainingData: a table containing the same predictor and response
  %       columns as imported into the app.
  %
  %  Output:
  %      trainedClassifier: a struct containing the trained classifier. The
  %       struct contains various fields with information about the trained
  %       classifier.
  %
  %      trainedClassifier.predictFcn: a function to make predictions on new
  %       data.
  %
  %      validationAccuracy: a double containing the accuracy in percent. In
  %       the app, the History list displays this overall accuracy score for
  %       each model.
  %
  % Use the code to train the model with new data. To retrain your
  % classifier, call the function from the command line with your original
  % data or new data as the input argument trainingData.
  %
  % For example, to retrain a classifier trained with the original data set
  % T, enter:
  %   [trainedClassifier, validationAccuracy] = trainClassifier(T)
  %
  % To make predictions with the returned 'trainedClassifier' on new data T2,
  % use
  %   yfit = trainedClassifier.predictFcn(T2)
  %
  % T2 must be a table containing at least the same predictor columns as used
  % during training. For details, enter:
  %   trainedClassifier.HowToPredict
  
  % Auto-generated by MATLAB on 22-Nov-2018 10:50:28
  
  
  % Extract predictors and response
  % This code processes the data into the right shape for training the
  % model.
  inputTable = trainingData;
  predictorNames = {'NumCI', 'NumDR', 'NumECI', 'NumPS', 'NumSCI', 'NumSR', 'NumUNK', 'CI_1940', 'CI_1945', 'CI_1950', 'CI_1955', 'DR_1955', 'PS_1955', 'CI_1960', 'PS_1960', 'CI_1965', 'PS_1965', 'CI_1970', 'CI_1975', 'CI_1980', 'CI_AsiaPacific', 'CI_Australia', 'DR_Australia', 'PS_Australia', 'CI_EasternEurope', 'CI_GreatBritain', 'CI_MiddleEastandAfrica', 'CI_NewZealand', 'CI_NorthAmerica', 'CI_SouthAfrica', 'CI_TheAmericas', 'CI_WesternEurope', 'CI_English', 'DR_English', 'PS_English', 'CI_OtherLang', 'CI_PhD', 'DR_PhD', 'PS_PhD', 'Success_CI', 'Unsuccess_CI', 'Success_DR', 'Success_PS', 'Unsuccess_PS', 'CI_Dept1033', 'CI_Dept1038', 'CI_Dept1098', 'CI_Dept1258', 'CI_Dept2053', 'CI_Dept2103', 'CI_Dept2153', 'CI_Dept2163', 'CI_Dept2178', 'CI_Dept2253', 'CI_Dept2498', 'CI_Dept2523', 'CI_Dept2533', 'CI_Dept2538', 'CI_Dept2553', 'CI_Dept2558', 'CI_Dept2563', 'CI_Dept2578', 'CI_Dept2603', 'CI_Dept2628', 'CI_Dept2653', 'CI_Dept2668', 'CI_Dept2678', 'PS_Dept2678', 'CI_Dept2713', 'CI_Dept2728', 'CI_Dept2763', 'CI_Dept2768', 'CI_Dept2813', 'CI_Dept2828', 'CI_Dept2853', 'CI_Dept2893', 'CI_Dept2923', 'CI_Dept3028', 'CI_Dept3048', 'CI_Dept3098', 'CI_Dept3123', 'CI_Dept3198', 'CI_Dept3258', 'CI_Dept3268', 'CI_Dept528', 'CI_Dept593', 'CI_Dept653', 'CI_Dept803', 'CI_Dept828', 'CI_Faculty1', 'CI_Faculty13', 'CI_Faculty19', 'CI_Faculty22', 'CI_Faculty25', 'DR_Faculty25', 'PS_Faculty25', 'CI_Faculty31', 'PS_Faculty31', 'CI_Faculty34', 'CI_Faculty4', 'CI_Faculty46', 'CI_Faculty7', 'Duration0to5', 'Duration10to15', 'Duration5to10', 'DurationGT15', 'DurationLT0', 'DurationUnk', 'Astar_CI', 'A_CI', 'B_CI', 'C_CI', 'Astar_PS', 'A_PS', 'C_PS', 'AstarTotal', 'ATotal', 'BTotal', 'CTotal', 'RFCD250103', 'RFCD270103', 'RFCD270106', 'RFCD270199', 'RFCD270201', 'RFCD270299', 'RFCD270603', 'RFCD270708', 'RFCD320202', 'RFCD320305', 'RFCD320502', 'RFCD320602', 'RFCD320701', 'RFCD320702', 'RFCD320799', 'RFCD320899', 'RFCD321003', 'RFCD321004', 'RFCD321006', 'RFCD321010', 'RFCD321013', 'RFCD321014', 'RFCD321015', 'RFCD321016', 'RFCD321021', 'RFCD321024', 'RFCD321028', 'RFCD321029', 'RFCD321202', 'RFCD321204', 'RFCD321206', 'RFCD321208', 'RFCD321216', 'RFCD321299', 'RFCD380103', 'RFCD430101', 'SEO670401', 'SEO670403', 'SEO671401', 'SEO700103', 'SEO730101', 'SEO730102', 'SEO730104', 'SEO730105', 'SEO730106', 'SEO730107', 'SEO730108', 'SEO730109', 'SEO730110', 'SEO730111', 'SEO730113', 'SEO730114', 'SEO730115', 'SEO730116', 'SEO730118', 'SEO730199', 'SEO730201', 'SEO730202', 'SEO730203', 'SEO730204', 'SEO730206', 'SEO730211', 'SEO730213', 'SEO730214', 'SEO730218', 'SEO730219', 'SEO730299', 'SEO730303', 'SEO730305', 'SEO730306', 'SEO740201', 'SEO740301', 'SEO750901', 'SEO750902', 'SEO770101', 'SEO770703', 'SEO780101', 'SEO780102', 'SEO780103', 'SEO780105', 'SEO780108', 'Sponsor149A', 'Sponsor24D', 'Sponsor29A', 'Sponsor2B', 'Sponsor32D', 'Sponsor34B', 'Sponsor40D', 'Sponsor4D', 'Sponsor59C', 'Sponsor5A', 'Sponsor60D', 'Sponsor62B', 'Sponsor6B', 'Sponsor75C', 'Sponsor97A', 'ContractValueBandA', 'ContractValueBandB', 'ContractValueBandC', 'ContractValueBandD', 'ContractValueBandE', 'ContractValueBandF', 'ContractValueBandG', 'ContractValueBandH', 'ContractValueBandUnk', 'GrantCat10A', 'GrantCat10B', 'GrantCat20A', 'GrantCat20C', 'GrantCat30B', 'GrantCat30C', 'GrantCat30D', 'GrantCat30G', 'GrantCat50A', 'GrantCatUnk', 'Apr', 'Aug', 'Dec', 'Feb', 'Jan', 'Jul', 'Jun', 'May', 'Nov', 'Oct', 'Sep', 'Fri', 'Mon', 'Sat', 'Thurs', 'Tues', 'Wed', 'Day'};
  predictors = inputTable(:, predictorNames);
  response = inputTable.Class;
  isCategoricalPredictor = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false];
  
  % Train a classifier
  % This code specifies all the classifier options and trains the classifier.
  classificationDiscriminant = fitcdiscr(...
      predictors, ...
      response, ...
      'DiscrimType', 'linear', ...
      'Gamma', 0, ...
      'FillCoeffs', 'off', ...
      'ClassNames', {'successful'; 'unsuccessful'});
  
  % Create the result struct with predict function
  predictorExtractionFcn = @(t) t(:, predictorNames);
  discriminantPredictFcn = @(x) predict(classificationDiscriminant, x);
  trainedClassifier.predictFcn = @(x) discriminantPredictFcn(predictorExtractionFcn(x));
  
  % Add additional fields to the result struct
  trainedClassifier.RequiredVariables = {'NumCI', 'NumDR', 'NumECI', 'NumPS', 'NumSCI', 'NumSR', 'NumUNK', 'CI_1940', 'CI_1945', 'CI_1950', 'CI_1955', 'DR_1955', 'PS_1955', 'CI_1960', 'PS_1960', 'CI_1965', 'PS_1965', 'CI_1970', 'CI_1975', 'CI_1980', 'CI_AsiaPacific', 'CI_Australia', 'DR_Australia', 'PS_Australia', 'CI_EasternEurope', 'CI_GreatBritain', 'CI_MiddleEastandAfrica', 'CI_NewZealand', 'CI_NorthAmerica', 'CI_SouthAfrica', 'CI_TheAmericas', 'CI_WesternEurope', 'CI_English', 'DR_English', 'PS_English', 'CI_OtherLang', 'CI_PhD', 'DR_PhD', 'PS_PhD', 'Success_CI', 'Unsuccess_CI', 'Success_DR', 'Success_PS', 'Unsuccess_PS', 'CI_Dept1033', 'CI_Dept1038', 'CI_Dept1098', 'CI_Dept1258', 'CI_Dept2053', 'CI_Dept2103', 'CI_Dept2153', 'CI_Dept2163', 'CI_Dept2178', 'CI_Dept2253', 'CI_Dept2498', 'CI_Dept2523', 'CI_Dept2533', 'CI_Dept2538', 'CI_Dept2553', 'CI_Dept2558', 'CI_Dept2563', 'CI_Dept2578', 'CI_Dept2603', 'CI_Dept2628', 'CI_Dept2653', 'CI_Dept2668', 'CI_Dept2678', 'PS_Dept2678', 'CI_Dept2713', 'CI_Dept2728', 'CI_Dept2763', 'CI_Dept2768', 'CI_Dept2813', 'CI_Dept2828', 'CI_Dept2853', 'CI_Dept2893', 'CI_Dept2923', 'CI_Dept3028', 'CI_Dept3048', 'CI_Dept3098', 'CI_Dept3123', 'CI_Dept3198', 'CI_Dept3258', 'CI_Dept3268', 'CI_Dept528', 'CI_Dept593', 'CI_Dept653', 'CI_Dept803', 'CI_Dept828', 'CI_Faculty1', 'CI_Faculty13', 'CI_Faculty19', 'CI_Faculty22', 'CI_Faculty25', 'DR_Faculty25', 'PS_Faculty25', 'CI_Faculty31', 'PS_Faculty31', 'CI_Faculty34', 'CI_Faculty4', 'CI_Faculty46', 'CI_Faculty7', 'Duration0to5', 'Duration10to15', 'Duration5to10', 'DurationGT15', 'DurationLT0', 'DurationUnk', 'Astar_CI', 'A_CI', 'B_CI', 'C_CI', 'Astar_PS', 'A_PS', 'C_PS', 'AstarTotal', 'ATotal', 'BTotal', 'CTotal', 'RFCD250103', 'RFCD270103', 'RFCD270106', 'RFCD270199', 'RFCD270201', 'RFCD270299', 'RFCD270603', 'RFCD270708', 'RFCD320202', 'RFCD320305', 'RFCD320502', 'RFCD320602', 'RFCD320701', 'RFCD320702', 'RFCD320799', 'RFCD320899', 'RFCD321003', 'RFCD321004', 'RFCD321006', 'RFCD321010', 'RFCD321013', 'RFCD321014', 'RFCD321015', 'RFCD321016', 'RFCD321021', 'RFCD321024', 'RFCD321028', 'RFCD321029', 'RFCD321202', 'RFCD321204', 'RFCD321206', 'RFCD321208', 'RFCD321216', 'RFCD321299', 'RFCD380103', 'RFCD430101', 'SEO670401', 'SEO670403', 'SEO671401', 'SEO700103', 'SEO730101', 'SEO730102', 'SEO730104', 'SEO730105', 'SEO730106', 'SEO730107', 'SEO730108', 'SEO730109', 'SEO730110', 'SEO730111', 'SEO730113', 'SEO730114', 'SEO730115', 'SEO730116', 'SEO730118', 'SEO730199', 'SEO730201', 'SEO730202', 'SEO730203', 'SEO730204', 'SEO730206', 'SEO730211', 'SEO730213', 'SEO730214', 'SEO730218', 'SEO730219', 'SEO730299', 'SEO730303', 'SEO730305', 'SEO730306', 'SEO740201', 'SEO740301', 'SEO750901', 'SEO750902', 'SEO770101', 'SEO770703', 'SEO780101', 'SEO780102', 'SEO780103', 'SEO780105', 'SEO780108', 'Sponsor149A', 'Sponsor24D', 'Sponsor29A', 'Sponsor2B', 'Sponsor32D', 'Sponsor34B', 'Sponsor40D', 'Sponsor4D', 'Sponsor59C', 'Sponsor5A', 'Sponsor60D', 'Sponsor62B', 'Sponsor6B', 'Sponsor75C', 'Sponsor97A', 'ContractValueBandA', 'ContractValueBandB', 'ContractValueBandC', 'ContractValueBandD', 'ContractValueBandE', 'ContractValueBandF', 'ContractValueBandG', 'ContractValueBandH', 'ContractValueBandUnk', 'GrantCat10A', 'GrantCat10B', 'GrantCat20A', 'GrantCat20C', 'GrantCat30B', 'GrantCat30C', 'GrantCat30D', 'GrantCat30G', 'GrantCat50A', 'GrantCatUnk', 'Apr', 'Aug', 'Dec', 'Feb', 'Jan', 'Jul', 'Jun', 'May', 'Nov', 'Oct', 'Sep', 'Fri', 'Mon', 'Sat', 'Thurs', 'Tues', 'Wed', 'Day'};
  trainedClassifier.ClassificationDiscriminant = classificationDiscriminant;
  trainedClassifier.About = 'This struct is a trained model exported from Classification Learner R2018a.';
  trainedClassifier.HowToPredict = sprintf('To make predictions on a new table, T, use: \n  yfit = c.predictFcn(T) \nreplacing ''c'' with the name of the variable that is this struct, e.g. ''trainedModel''. \n \nThe table, T, must contain the variables returned by: \n  c.RequiredVariables \nVariable formats (e.g. matrix/vector, datatype) must match the original training data. \nAdditional variables are ignored. \n \nFor more information, see <a href="matlab:helpview(fullfile(docroot, ''stats'', ''stats.map''), ''appclassification_exportmodeltoworkspace'')">How to predict using an exported model</a>.');
  
  % Extract predictors and response
  % This code processes the data into the right shape for training the
  % model.
  inputTable = trainingData;
  predictorNames = {'NumCI', 'NumDR', 'NumECI', 'NumPS', 'NumSCI', 'NumSR', 'NumUNK', 'CI_1940', 'CI_1945', 'CI_1950', 'CI_1955', 'DR_1955', 'PS_1955', 'CI_1960', 'PS_1960', 'CI_1965', 'PS_1965', 'CI_1970', 'CI_1975', 'CI_1980', 'CI_AsiaPacific', 'CI_Australia', 'DR_Australia', 'PS_Australia', 'CI_EasternEurope', 'CI_GreatBritain', 'CI_MiddleEastandAfrica', 'CI_NewZealand', 'CI_NorthAmerica', 'CI_SouthAfrica', 'CI_TheAmericas', 'CI_WesternEurope', 'CI_English', 'DR_English', 'PS_English', 'CI_OtherLang', 'CI_PhD', 'DR_PhD', 'PS_PhD', 'Success_CI', 'Unsuccess_CI', 'Success_DR', 'Success_PS', 'Unsuccess_PS', 'CI_Dept1033', 'CI_Dept1038', 'CI_Dept1098', 'CI_Dept1258', 'CI_Dept2053', 'CI_Dept2103', 'CI_Dept2153', 'CI_Dept2163', 'CI_Dept2178', 'CI_Dept2253', 'CI_Dept2498', 'CI_Dept2523', 'CI_Dept2533', 'CI_Dept2538', 'CI_Dept2553', 'CI_Dept2558', 'CI_Dept2563', 'CI_Dept2578', 'CI_Dept2603', 'CI_Dept2628', 'CI_Dept2653', 'CI_Dept2668', 'CI_Dept2678', 'PS_Dept2678', 'CI_Dept2713', 'CI_Dept2728', 'CI_Dept2763', 'CI_Dept2768', 'CI_Dept2813', 'CI_Dept2828', 'CI_Dept2853', 'CI_Dept2893', 'CI_Dept2923', 'CI_Dept3028', 'CI_Dept3048', 'CI_Dept3098', 'CI_Dept3123', 'CI_Dept3198', 'CI_Dept3258', 'CI_Dept3268', 'CI_Dept528', 'CI_Dept593', 'CI_Dept653', 'CI_Dept803', 'CI_Dept828', 'CI_Faculty1', 'CI_Faculty13', 'CI_Faculty19', 'CI_Faculty22', 'CI_Faculty25', 'DR_Faculty25', 'PS_Faculty25', 'CI_Faculty31', 'PS_Faculty31', 'CI_Faculty34', 'CI_Faculty4', 'CI_Faculty46', 'CI_Faculty7', 'Duration0to5', 'Duration10to15', 'Duration5to10', 'DurationGT15', 'DurationLT0', 'DurationUnk', 'Astar_CI', 'A_CI', 'B_CI', 'C_CI', 'Astar_PS', 'A_PS', 'C_PS', 'AstarTotal', 'ATotal', 'BTotal', 'CTotal', 'RFCD250103', 'RFCD270103', 'RFCD270106', 'RFCD270199', 'RFCD270201', 'RFCD270299', 'RFCD270603', 'RFCD270708', 'RFCD320202', 'RFCD320305', 'RFCD320502', 'RFCD320602', 'RFCD320701', 'RFCD320702', 'RFCD320799', 'RFCD320899', 'RFCD321003', 'RFCD321004', 'RFCD321006', 'RFCD321010', 'RFCD321013', 'RFCD321014', 'RFCD321015', 'RFCD321016', 'RFCD321021', 'RFCD321024', 'RFCD321028', 'RFCD321029', 'RFCD321202', 'RFCD321204', 'RFCD321206', 'RFCD321208', 'RFCD321216', 'RFCD321299', 'RFCD380103', 'RFCD430101', 'SEO670401', 'SEO670403', 'SEO671401', 'SEO700103', 'SEO730101', 'SEO730102', 'SEO730104', 'SEO730105', 'SEO730106', 'SEO730107', 'SEO730108', 'SEO730109', 'SEO730110', 'SEO730111', 'SEO730113', 'SEO730114', 'SEO730115', 'SEO730116', 'SEO730118', 'SEO730199', 'SEO730201', 'SEO730202', 'SEO730203', 'SEO730204', 'SEO730206', 'SEO730211', 'SEO730213', 'SEO730214', 'SEO730218', 'SEO730219', 'SEO730299', 'SEO730303', 'SEO730305', 'SEO730306', 'SEO740201', 'SEO740301', 'SEO750901', 'SEO750902', 'SEO770101', 'SEO770703', 'SEO780101', 'SEO780102', 'SEO780103', 'SEO780105', 'SEO780108', 'Sponsor149A', 'Sponsor24D', 'Sponsor29A', 'Sponsor2B', 'Sponsor32D', 'Sponsor34B', 'Sponsor40D', 'Sponsor4D', 'Sponsor59C', 'Sponsor5A', 'Sponsor60D', 'Sponsor62B', 'Sponsor6B', 'Sponsor75C', 'Sponsor97A', 'ContractValueBandA', 'ContractValueBandB', 'ContractValueBandC', 'ContractValueBandD', 'ContractValueBandE', 'ContractValueBandF', 'ContractValueBandG', 'ContractValueBandH', 'ContractValueBandUnk', 'GrantCat10A', 'GrantCat10B', 'GrantCat20A', 'GrantCat20C', 'GrantCat30B', 'GrantCat30C', 'GrantCat30D', 'GrantCat30G', 'GrantCat50A', 'GrantCatUnk', 'Apr', 'Aug', 'Dec', 'Feb', 'Jan', 'Jul', 'Jun', 'May', 'Nov', 'Oct', 'Sep', 'Fri', 'Mon', 'Sat', 'Thurs', 'Tues', 'Wed', 'Day'};
  predictors = inputTable(:, predictorNames);
  response = inputTable.Class;
  isCategoricalPredictor = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false];
  
  % Perform cross-validation
  partitionedModel = crossval(trainedClassifier.ClassificationDiscriminant, 'KFold', 10);
  
  % Compute validation predictions
  [validationPredictions, validationScores] = kfoldPredict(partitionedModel);
  
  % Compute validation accuracy
  validationAccuracy = 1 - kfoldLoss(partitionedModel, 'LossFun', 'ClassifError');
  