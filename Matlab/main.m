%function main

% Define the parent directory for the images and other file names
%imageDirectory = strcat('..', filesep, 'Dataset', filesep);
imageDirectory = "D:\Datasets\OurDataset\NewTarget\";
%imageDirectory = "D:\Datasets\YaedDataset\NewTarget\";
%imageDirectory = "D:\Datasets\HTDataset\NewTarget\";

%infoFilename = 'yaedwgt_info';
infoFilename = 'awgt_info';
datasetFilename = 'ground_truth.txt';

% Retrieve all the list of the result files
files = retrieve_file_list(imageDirectory, '*results*.txt');

% Process each information file
for f = 1 : length(files.name)
    
    % Print the current directory
    fprintf('Processing directory %d / %d: "%s"\n', f, length(files.name), files.directory(f));
    
    % Check if the directory is already processed
    resultsFiles = dir(strcat(files.directory(f), infoFilename, '*'));
    if ~isempty(resultsFiles)
        fprintf('The directory is already processed!\n');
        continue;
    end
    
    % Retrieve all the information about the results saved in the file
    info = read_results_file(files.path(f));
    
    % Retrieve the number of images to be processed
    N = size(info.OriginalFile, 1);

    fprintf('Processing %d images..."\n', N);
    
    % Initialize the Ground Truth and Our Result
    info.GroundTruth = zeros(N, 1);
    info.OurAlgorithm = zeros(N, 1);
    
    % Process all the images
    i = 1;
    while i <= size(info.OriginalFile, 1)
        % Show images and wait for a key pressed
        keyChar = show_images(info.OriginalFile(i), info.ProcessedFile(i), ...
            files.directory(f), i, N);
        
        % Process the pressed key
        switch keyChar
            case 'y' % If true positive or true negative
                info.GroundTruth(i) = info.TargetFound(i);
                info.OurAlgorithm(i) = 1;
            case 'n' % If false positive or false negative
                info.GroundTruth(i) = 1 - info.TargetFound(i);
                info.OurAlgorithm(i) = 0;
            case 'w' % If true positive with wrong detection
                info.GroundTruth(i) = 1;
                info.OurAlgorithm(i) = -1;
            otherwise
                if double(keyChar) == 28 % Go to previous with left arrow
                    if i > 1
                        i = i - 2;
                    else
                        i = i - 1;
                    end
                else % Exit the program if ESC key is pressed
                    close all; 
                    return;
                end
        end
        i = i + 1;
    end
    
    % Save the resulted information
    save(strcat(files.directory(f), infoFilename, '.mat'), 'info');
end

% Read all the gathered information
infos = read_info_files(imageDirectory, infoFilename);

% Create the dataset groundtruth files
create_dataset(infos, datasetFilename);

% Calculate all the stats of our algorithm
stats = get_algorithm_stats(infos);

% Print the calculated statistics
clc;
print_stats(stats);

close all;
