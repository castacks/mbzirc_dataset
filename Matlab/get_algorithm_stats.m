function stats = get_algorithm_stats(infos)

counter = 1;
for i = 1 : length(infos)
    info = infos{i}.info;
    for j = 1 : length(info.OriginalFile)
        stats(counter).InfoSet = i;
        stats(counter).FileInSet = j;
        stats(counter).ExecTime = info.ExecTime(j);
        stats(counter).GroundTruth = info.GroundTruth(j);
        stats(counter).TruePos = (info.GroundTruth(j) == 1 && info.OurAlgorithm(j) == 1);
        stats(counter).TrueNeg = (info.GroundTruth(j) == 0 && info.OurAlgorithm(j) == 1);
        stats(counter).FalsePos = (info.GroundTruth(j) == 0 && info.OurAlgorithm(j) == 0);
        stats(counter).FalseNeg = (info.GroundTruth(j) == 1 && info.OurAlgorithm(j) == 0);
        stats(counter).WrongPos = (info.GroundTruth(j) == 1 && info.OurAlgorithm(j) == -1);
        counter = counter + 1;
    end
end
