%function main2

% Define the parent directory for the images and other file names
imageDirectory = "D:\Images\";

%infoFilename = 'yaedwgt_info';
infoFilename = 'awgt_info';
datasetFilename = 'ground_truth.txt';

% Retrieve the file structure for result files
fs = retrieve_file_structure(imageDirectory, '*results*.txt');

for fs_index = 1 : length(fs)
    curr_dir = strcat(fs(fs_index).path, '\');

    % Read all the gathered information
    infos = read_info_files(curr_dir, infoFilename);
    gtinfo = infos{1}.info;
    
    % Retrieve all the list of the result files
    files = retrieve_file_list(curr_dir, '*results*.txt');

    fprintf('Processing directory %d / %d: "%s"\n', fs_index, length(fs), curr_dir);
    
    % Process each information file
    for f = 1 : length(files.name)

        % Print the current directory
        fprintf('Processing file %d / %d: "%s"\n', f, length(files.name), files.name(f));

        [param1, param2, param_prefix] = get_params_from_filename(files.name(f), 'all_results_gnt');
        if param1 == 0 || param2 == 0
            continue;
        end
        
        % Check if the directory is already processed
        resultsFiles = dir(strcat(files.directory(f), param_prefix, infoFilename, '*'));
        if ~isempty(resultsFiles)
            fprintf('The result file is already processed!\n');
            continue;
        end

        % Retrieve all the information about the results saved in the file
        info = read_results_file(files.path(f));

        % Retrieve the number of images to be processed
        N = size(info.OriginalFile, 1);

        fprintf('Processing %d images..."\n', N);

        % Initialize the Ground Truth and Our Result
        info.OurAlgorithm = zeros(N, 1);

        % Process all the images
        i = 1;
        while i <= size(info.OriginalFile, 1)
            if gtinfo.GroundTruth(i) == 0 && info.TargetFound(i) == 1
                info.OurAlgorithm(i) = 0;
            elseif gtinfo.GroundTruth(i) == 0 && info.TargetFound(i) == 0
                info.OurAlgorithm(i) = 1;
            elseif gtinfo.GroundTruth(i) == 1 && info.TargetFound(i) == 0
                info.OurAlgorithm(i) = 0;
            elseif gtinfo.GroundTruth(i) == 1 && info.TargetFound(i) == 1
                isSameTarget = compare_detections(gtinfo, info, i, i);
                if gtinfo.TargetFound(i) == 1 && ~isSameTarget
                    info.OurAlgorithm(i) = 0;
                elseif gtinfo.TargetFound(i) == 1 && isSameTarget
                    info.OurAlgorithm(i) = 1;
                else %if gtinfo.TargetFound(i) == 0
                    % Show images and wait for a key pressed
                    keyChar = show_images(info.OriginalFile(i), info.ProcessedFile(i), ...
                        files.directory(f), i, N);

                    % Process the pressed key
                    switch keyChar
                        case 'y' % If true positive
                            gtinfo.TargetFound(i) = 1;
                            gtinfo.TargetCenterX(i) = info.TargetCenterX(i);
                            gtinfo.TargetCenterY(i) = info.TargetCenterY(i);
                            gtinfo.TargetWidth(i) = info.TargetWidth(i);
                            gtinfo.TargetHeight(i) = info.TargetHeight(i);
                            gtinfo.TargetAngle(i) = info.TargetAngle(i);
                            info.OurAlgorithm(i) = 1;
                        case 'n' % If false positive or false negative
                            i = i - 1;
                        case 'w' % If true positive with wrong detection
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
                end
            end
            i = i + 1;
        end

        % Save the resulted information
        info.GroundTruth = gtinfo.GroundTruth;
        save(strcat(files.directory(f), param_prefix, infoFilename, '.mat'), 'info');
        info = gtinfo;
        save(strcat(files.directory(f), infoFilename, '.mat'), 'info');
    end
end

% Read all the gathered information
infos = read_info_files(imageDirectory, infoFilename);

% Create the dataset groundtruth files
create_dataset(infos, datasetFilename);

close all;

contour_fit_score = 10 : 10 : 90;
ellipse_fixed_fit_score = 70;

for i = 1 : length(contour_fit_score)
    clc;
    fprintf("Stats for %0.1f - 0.7\n\n", contour_fit_score(i) / 100.0);
    
    local_filename = strcat("our_", int2str(contour_fit_score(i)), ...
        "_", int2str(ellipse_fixed_fit_score), "_", infoFilename);
    infos = read_info_files(imageDirectory, local_filename);
    
    % Calculate all the stats of our algorithm
    stats = get_algorithm_stats(infos);

    % Print the calculated statistics
    stat_vars(i) = print_stats(stats);

end

ellipse_fit_score = 10 : 10 : 90;
contour_fixed_fit_score = 80;

generate_stats_plots((ellipse_fit_score / 100.0), 'Contour Overlap Threshold', stat_vars);

for i = 1 : length(ellipse_fit_score)
    clc;
    fprintf("Stats for %0.1f - 0.7\n\n", ellipse_fit_score(i) / 100.0);
    
    local_filename = strcat("our_", int2str(contour_fixed_fit_score), ...
        "_", int2str(ellipse_fit_score(i)), "_", infoFilename);
    infos = read_info_files(imageDirectory, local_filename);
    
    % Calculate all the stats of our algorithm
    stats = get_algorithm_stats(infos);

    % Print the calculated statistics
    stat_vars(i) = print_stats(stats);

end

generate_stats_plots((ellipse_fit_score / 100.0), 'Ellipse Overlap Threshold', stat_vars);
