function keyChar = show_images(original_filename, processed_filename, directory, i, N)

% Show the pictures on the screen
original_path = strcat(directory, original_filename);
original_image = imread(convertStringsToChars(original_path));
processed_path = strcat(directory, processed_filename);
processed_image = imread(convertStringsToChars(processed_path));
subplot(2, 1, 1);
imshow(original_image);
title(original_filename)
subplot(2, 1, 2);
imshow(processed_image);
title(processed_filename)
str = sprintf('Image %d / %d', i, N);
suptitle({'Y = True P/N | N = False P/N | W = Wrong P | <- = Prev'; str});

% Wait for the correct keys to be pressed for labeling
correctButtonPressed = false;
while correctButtonPressed == false
    waitforbuttonpress;
    keyChar = get(gcf,'CurrentCharacter');
    if keyChar == 'y' || keyChar == 'n' || keyChar == 'w' || ...
            double(keyChar) == 27 || double(keyChar) == 28
        correctButtonPressed = true;
    end
end
