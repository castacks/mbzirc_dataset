function files = retrieve_file_list(parent_directory, pattern)

% Initialize the output
files.name = [];
files.directory = [];
files.path = [];

% Get a list of all files and folders in this folder.
fileList = dir(parent_directory);

% Extract the subdirectories
subDirectories = fileList([fileList.isdir]);
subDirectories([1 2]) = [];

% Extract the files matching the pattern
fileList = dir(strcat(parent_directory, pattern));
fileList = fileList(~[fileList.isdir]);

% Add the files to the output
for f = 1 : length(fileList)
    files.name = [files.name; string(fileList(f).name)];
    files.directory = [files.directory; string(parent_directory)];
    files.path = [files.path; strcat(parent_directory, fileList(f).name)];
end

% Perform a recursive search
for d = 1 : length(subDirectories)
    subFiles = retrieve_file_list(strcat(parent_directory, subDirectories(d).name, filesep), pattern);
    files.name = [files.name; subFiles.name];
    files.directory = [files.directory; subFiles.directory];
    files.path = [files.path; subFiles.path];
end
