clear; clc; close all;
%{
[rr, rr_time, rr_int] = import_rr('data/slp03.rr');
[annotation, an_time, an_class] = import_annotation('data/slp03.an');

%feature extraction
%rr = [0.508 0.752 0.72 0.728 0.76 0.772 0.8 0.788 0.78 0.74 0.732 0.72 0.74 0.728 0.752 0.82 0.76 0.78 0.82 0.888 1.2 1.06 0.98 0.8 0.72 0.692 0.688 0.66 0.68 1.232 1.028 0.84 0.732 0.708 0.712 0.76 0.88 1.188 0.992 0.888 0.78 0.74 0.752 0.748 0.7 0.7 0.672 0.76 1.268 1.112 1.02 0.888 0.78 0.736 0.748 0.824 0.888 0.828 0.796 0.772 0.76 0.76 0.752 0.756 0.776 0.772 0.756 0.74 0.704 0.68 0.668 0.692 0.756 0.772];
%cd('feature_extraction');
%features = extract_features(rr);

%rr_int = str2num(cell2mat(rr_int));
rr_int = single_numeric_cell_to_matrix(rr_int);
%a = str2num(cell2mat(temp{1}'))
epoch = 1;
rr_row_per_epoch = 1;
temp = cell(size(an_time, 1), 1);
time = cell(size(an_time, 1), 1);
for i=1:size(rr_time, 1)
    if strcmp(rr_time(i), an_time(epoch))
        temp{epoch}(rr_row_per_epoch) = rr_int(i);
        time{epoch}(rr_row_per_epoch) = rr_time(i);
        rr_row_per_epoch=rr_row_per_epoch+1;
    elseif ~strcmp(rr_time(i), an_time(epoch)) && ~strcmp(rr_time(i), an_time(epoch+1))
        while ~strcmp(rr_time(i), an_time(epoch+1))
            epoch = epoch + 1;
        end
        rr_row_per_epoch=1;
        epoch=epoch+1;
        temp{epoch}(rr_row_per_epoch) = rr_int(i);
        time{epoch}(rr_row_per_epoch) = rr_time(i);
        rr_row_per_epoch=rr_row_per_epoch+1;        
    elseif ~strcmp(rr_time(i), an_time(epoch)) && strcmp(rr_time(i), an_time(epoch+1))
        rr_row_per_epoch=1;
        epoch=epoch+1;
        temp{epoch}(rr_row_per_epoch) = rr_int(i);
        time{epoch}(rr_row_per_epoch) = rr_time(i);
        rr_row_per_epoch=rr_row_per_epoch+1;
    end
end

data = struct('time', an_time, 'rr', temp, 'annotation', an_class);
%}

%feature extraction
%rr = [0.508 0.752 0.72 0.728 0.76 0.772 0.8 0.788 0.78 0.74 0.732 0.72 0.74 0.728 0.752 0.82 0.76 0.78 0.82 0.888 1.2 1.06 0.98 0.8 0.72 0.692 0.688 0.66 0.68 1.232 1.028 0.84 0.732 0.708 0.712 0.76 0.88 1.188 0.992 0.888 0.78 0.74 0.752 0.748 0.7 0.7 0.672 0.76 1.268 1.112 1.02 0.888 0.78 0.736 0.748 0.824 0.888 0.828 0.796 0.772 0.76 0.76 0.752 0.756 0.776 0.772 0.756 0.74 0.704 0.68 0.668 0.692 0.756 0.772];
%cd('feature_extraction');
%features = extract_features(rr);

file_names = {'slp01a', 'slp01b', 'slp02a', 'slp02b', 'slp03', 'slp04', 'slp14', 'slp16', 'slp32', 'slp37', 'slp41', 'slp45', 'slp48', 'slp59', 'slp60', 'slp61', 'slp66', 'slp67x'};
sec_per_epoch = 30;
all_data = [];
data = [];
%data = import_data(file_names(6), sec_per_epoch);

for i=1:size(file_names, 2)
    fprintf('\n\n%s importing...\n', cell2mat(file_names(i)));
    data = import_data(file_names(i), sec_per_epoch);
    all_data = [all_data;data];
end
%import_data(file_names)