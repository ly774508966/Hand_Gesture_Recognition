input_dir = 'C:\Users\Beverly\Documents\GitHub\Hand_Gesture_Recognition\Grouped_Data';
test_samp = 5;
train_samp = 5;
distinct = 5;
[training,test,training_COL] = dataProducer(input_dir,train_samp,test_samp);
gesture = training;
mean_gest = mean(gesture,2);  
gesture = gesture - repmat(mean_gest, 1, training_COL);
[evectors, score, evalues] = pca(gesture');

num_eigenfaces = 1;
evectors = evectors(:,1:num_eigenfaces);
features = evectors' * gesture;
%Read Sample Data and Compare%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 for n = 1: training_COL
    filename = test;
    feature_vec = evectors' * (filename(:,n) - mean_gest);
    similarity_score = arrayfun(@(n) 1 / (1 + norm(features(:,n) - feature_vec)), 1:training_COL);
    [match_score, match_ix] = max(similarity_score);
    names(n,:) = (offset(match_ix, test_samp));
 end
% pretty arbitrary for loop, no string parsing; all based on Grouped_Data
% folder format
for i = 1 : training_COL
    test_names(i,:) = offset(i, train_samp);
end    
     [PCA_acc, each_PCA_acc] = NMF_accuracy(test_names, names, training_COL, distinct);
    PCA_acc
    
    
    