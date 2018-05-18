function create_dataset(infos, dataset_info_filename)

counter = 0;
for i = 1 : length(infos)
    info = infos{i}.info;
    info_file = infos{i}.file;
    
    fileID = fopen(strcat(info_file.directory, dataset_info_filename), 'w');
    fprintf(fileID, 'Filename\tHasTarget\tTargetCenterX\tTargetCenterY\tTargetWidth\tTargetHeight\tTargetAngle\n');
    
    for j = 1 : length(info.OriginalFile)
        if info.GroundTruth(j) == 1 && info.OurAlgorithm(j) == 1
            fprintf(fileID, '%s\t%d\t%0.3f\t%0.3f\t%0.3f\t%0.3f\t%0.3f\n', ...
                info.OriginalFile(j), info.GroundTruth(j), info.TargetCenterX(j), ...
                info.TargetCenterY(j), info.TargetWidth(j), info.TargetHeight(j), info.TargetAngle(j));
        elseif info.GroundTruth(j) == 1 && info.OurAlgorithm(j) == 0
            fprintf(fileID, '%s\t%d\t%0.3f\t%0.3f\t%0.3f\t%0.3f\t%0.3f\n', ...
                info.OriginalFile(j), info.GroundTruth(j), -1, -1, -1, -1, -1);
            counter = counter + 1;
        else % if info.GroundTruth(j) == 0
            fprintf(fileID, '%s\t%d\t%0.3f\t%0.3f\t%0.3f\t%0.3f\t%0.3f\n', ...
                info.OriginalFile(j), info.GroundTruth(j), 0, 0, 0, 0, 0);
        end
    end
    fclose(fileID);
end

fprintf("Created dataset has %d rows without sufficient data.\n", counter);