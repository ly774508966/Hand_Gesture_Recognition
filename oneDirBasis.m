function [ basis,subjects,ROW,COL ] = oneDirBasis(directory,distinct)
% Forms a training basis from multiple subjects' .csv files inside a single
% directory for knnclassify. 
% Requires a single directory which contains all the data from all subjects
% distinct is the unique number of gestures (ex: 5)
% It also returns subjects, which is the number of participants
    basis1 = dir(fullfile(directory,'*csv'));
    num_files = numel(basis1);
    b1_file = (csvread(fullfile(directory, basis1(1).name),1,1));
    [ROW,COL] = size(b1_file); 
   
    i=1;
    subjects = num_files / distinct;
    basis = [];
    temp = [];
    % check if there is only one subject
    if (distinct ~= num_files)
        for n = 1 : distinct
            for i = n :distinct :  num_files
               
                %removes name(row) and time(col)and only takes an even fraction of
                %data from each subject's distinct gesture
                b1_files = (csvread(fullfile(directory, basis1(i).name),1,1,[1,1,int8(ROW/subjects),COL]));
                %concatenates col values (8 meaningful values)
                temp = vertcat(temp,b1_files);
            end
            %sums col values
            basis(n,:) = sum(temp);
            temp = []; % reset the matrix to be concatenated
        end
    else 
        for n = 1 :distinct 
            b1_files = sum(csvread(fullfile(directory, basis1(n).name),1,1));
            basis(n,:) = (b1_files);
        end
    end
end
