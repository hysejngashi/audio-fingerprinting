function hashes = compute_fingerprint(filename)

windowSize = 4096;
overlap = 2048;
fanOut = 5;
ampMin = 10;
neighborhoodSize = 3;

[x, Fs] = audioread(filename);
x = mean(x, 2);

peakAmp = max(abs(x));
if peakAmp > 0
    x = x / peakAmp;
end

[S, F, T] = spectrogram(x, windowSize, overlap, [], Fs);
S = abs(S);

peaks = zeros(size(S));
[nFreqBins, nTimeBins] = size(S);

for t = (1 + neighborhoodSize):(nTimeBins - neighborhoodSize)
    for f = (1 + neighborhoodSize):(nFreqBins - neighborhoodSize)
        localWindow = S(f - neighborhoodSize:f + neighborhoodSize, ...
                        t - neighborhoodSize:t + neighborhoodSize);
        localMax = max(localWindow(:));
        if S(f, t) == localMax && S(f, t) > ampMin
            peaks(f, t) = 1;
        end
    end
end

[peakFreqIdx, peakTimeIdx] = find(peaks);

hashes = [];
for i = 1:length(peakTimeIdx)
    for j = 1:fanOut
        if i + j <= length(peakTimeIdx)
            t1 = T(peakTimeIdx(i));
            t2 = T(peakTimeIdx(i + j));
            f1 = F(peakFreqIdx(i));
            f2 = F(peakFreqIdx(i + j));
            deltaT = round(t2 - t1, 2);
            hashes(end+1, :) = [round(f1), round(f2), deltaT, round(t1, 2)]; 
        end
    end
end

end