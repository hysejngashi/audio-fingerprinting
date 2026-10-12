function [bestMatch, scores] = match_song(queryHashes, database)
% Identifies which song in the database best matches the query hashes.

numSongs = length(database);
scores = zeros(numSongs, 1);

for k = 1:numSongs
    dbHashes = database{k};
    offsets = [];
    
    for i = 1:size(queryHashes, 1)
        qf1 = queryHashes(i, 1);
        qf2 = queryHashes(i, 2);
        qdt = queryHashes(i, 3);
        qt1 = queryHashes(i, 4);
        
        matchMask = (dbHashes(:,1) == qf1) & ...
                    (dbHashes(:,2) == qf2) & ...
                    (dbHashes(:,3) == qdt);
        
        if any(matchMask)
            matchedT1s = dbHashes(matchMask, 4);
            offsets = [offsets; matchedT1s - qt1]; 
        end
    end
    
    if isempty(offsets)
        scores(k) = 0;
    else
        offsetsRounded = round(offsets, 1);
        [counts, ~] = histcounts(offsetsRounded, ...
            min(offsetsRounded)-0.05:0.1:max(offsetsRounded)+0.05);
        scores(k) = max(counts);
    end
end

[~, bestMatch] = max(scores);

end