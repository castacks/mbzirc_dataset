function info = read_results_file(path)

% Import the data with its headers
data = importdata(path, '\t', 1);

% Retrieve the number of text columns (all the text columns are assumed to
% be first)
n_textdata = size(data.textdata, 2) - size(data.data, 2);

% Retrieve data from the text columns
for i = 1 : n_textdata
    info.(data.textdata{1, i}) = [];
    for j = 2 : size(data.textdata, 1)
        info.(data.textdata{1, i}) = [info.(data.textdata{1, i}); string(data.textdata{j, i})];
    end
end

% Retrieve data from the numeric columns
for i = 1 : size(data.data, 2)
    info.(data.textdata{1, n_textdata + i}) = data.data(:, i);
end
