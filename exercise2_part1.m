% Exercise 2.1 - Fingerprinting on the 9 recorded songs

songNames = {'Enter Sandman', 'Hotel California', 'Eyes Without a Face', ...
             'Power', 'Runaway', 'Headlines', 'Cornfield Chase', ...
             'Stronger', 'Pyramids'};

database = cell(9, 1);

for k = 1:9
    filename = sprintf('song%d.wav', k);
    fprintf('\n=== Song %d: %s (%s) ===\n', k, songNames{k}, filename);
    
    hashes = compute_fingerprint(filename);
    database{k} = hashes;
    
    fprintf('Total hashes generated: %d\n', size(hashes, 1));
    fprintf('First 10 hashes [f1, f2, deltaT, t1]:\n');
    disp(hashes(1:min(10, size(hashes,1)), :));
end

save('database.mat', 'database', 'songNames');
fprintf('\nDatabase saved to database.mat\n');