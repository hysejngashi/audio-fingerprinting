% Exercise 2.3 - Test the song matching algorithm

load('database.mat', 'database', 'songNames');

testFiles = {'test_a.wav', 'test_b.wav'};
expectedSong = [4, 1];
expectedNames = {'Power', 'Enter Sandman'};

for i = 1:length(testFiles)
    fprintf('\n========================================================\n');
    fprintf('Matching: %s (expected: song %d - %s)\n', ...
        testFiles{i}, expectedSong(i), expectedNames{i});
    fprintf('========================================================\n');
    
    queryHashes = compute_fingerprint(testFiles{i});
    fprintf('Query hash count: %d\n\n', size(queryHashes, 1));
    
    [bestMatch, scores] = match_song(queryHashes, database);
    
    fprintf('Score per song (higher = better match):\n');
    [sortedScores, sortIdx] = sort(scores, 'descend');
    for r = 1:length(scores)
        idx = sortIdx(r);
        marker = '';
        if r == 1
            marker = '   <-- BEST';
        end
        fprintf('  Song %d (%s): %d%s\n', idx, songNames{idx}, ...
                sortedScores(r), marker);
    end
    
    fprintf('\nPredicted: song %d (%s)\n', bestMatch, songNames{bestMatch});
    fprintf('Expected:  song %d (%s)\n', expectedSong(i), expectedNames{i});
    if bestMatch == expectedSong(i)
        fprintf('Result: CORRECT\n');
    else
        fprintf('Result: INCORRECT\n');
    end
end