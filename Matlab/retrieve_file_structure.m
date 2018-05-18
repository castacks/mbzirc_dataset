function files = retrieve_file_structure(parent_directory, pattern)

% Get a list of all files and folders in this folder.
fileList = dir(parent_directory);

% Extract the subdirectories
subDirectories = fileList([fileList.isdir]);
subDirectories([1 2]) = [];

% Extract the files matching the pattern
fileList = dir(strcat(parent_directory, pattern));
fileList = fileList(~[fileList.isdir]);

% Add the files and directories to the output
Ndir = length(subDirectories);
for d = 1 : Ndir
    files(d).name = string(subDirectories(d).name);
    files(d).directory = string(parent_directory);
    files(d).path = strcat(parent_directory, subDirectories(d).name);
    files(d).is_dir = true;
end
for f = 1 : length(fileList)
    files(Ndir + f).name = string(fileList(f).name);
    files(Ndir + f).directory = string(parent_directory);
    files(Ndir + f).path = strcat(parent_directory, fileList(f).name);
    files(Ndir + f).is_dir = false;
end

% Perform a recursive search
for d = 1 : length(subDirectories)
    files(d).files = retrieve_file_structure(strcat(parent_directory, subDirectories(d).name, filesep), pattern);
end
