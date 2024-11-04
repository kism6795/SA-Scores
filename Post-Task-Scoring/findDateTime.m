function date_time = findDateTime(subject_folder)
    x = dir(subject_folder);
    for k=1:length(x)
        if strfind(x(k).name, 'RATE')
            temp = extractBetween(x(k).name, 'RATE_','.txt');
            break
        end
    end
    date_time = temp{1};
end