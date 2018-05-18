function [param1, param2, prefix] = get_params_from_filename(filename, common_name)

param1 = 0;
param2 = 0;
prefix = "";

if ~contains(filename, common_name)
    return;
end

prefix = extractBefore(filename, common_name);

if strlength(prefix) == 0
    return;
end

psplit = split(prefix, '_');

param1 = str2double(psplit{2}) / 100.0;
param2 = str2double(psplit{3}) / 100.0;