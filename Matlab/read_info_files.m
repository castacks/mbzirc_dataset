function infos = read_info_files(parent_directory, info_filename)

% Read all the info files for further processing
files = retrieve_file_list(parent_directory, strcat(info_filename, '*'));

% Initialize the output
infos = cell(size(files.name, 1), 1);

for i = 1 : length(files.name)
    infos{i} = load(files.path(i));
    infos{i}.file.name = files.name(i);
    infos{i}.file.directory = files.directory(i);
    infos{i}.file.path = files.path(i);
end