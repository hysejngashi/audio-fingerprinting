\# Audio Fingerprinting



A Shazam-style song identification system built from scratch in MATLAB.



\## How it works



1\. Compute the spectrogram of an audio clip

2\. Find spectral peaks: local maxima in a 7x7 time-frequency neighborhood,

&#x20;  which stay stable even in noisy recordings

3\. Pair each peak with the next 5 peaks in time. Each pair becomes a hash

&#x20;  of two frequencies plus the time delta between them

4\. To match, build a histogram of time offsets between clip hashes and

&#x20;  database hashes. The correct song produces a sharp peak at one offset;

&#x20;  wrong songs produce noise



\## Results



9-song database, 880 to 2360 hashes per song. Both test clips, recorded

on a phone from 2 to 3 seconds of audio, matched correctly:

scores of 58 vs 4 and 23 vs 5 against the next closest song.



\## Debugging notes



Two failures worth recording:



\- \*\*Amplitude threshold.\*\* Peak detection assumed audio peaking near 1.0,

&#x20; but phone recordings peaked around 0.1 to 0.3, so almost nothing crossed

&#x20; the threshold and one clip produced zero hashes. Fixed by normalizing

&#x20; each clip to peak amplitude 1.0 before computing the spectrogram.

\- \*\*Sample rate mismatch.\*\* Clips came out at 48 kHz while reference files

&#x20; were 44.1 kHz. Since hashes round frequencies to integers and bin width

&#x20; depends on sample rate, the same pitch landed in different bins and

&#x20; nothing matched. Fixed by converting everything to 44.1 kHz.



\## Also included



FIR and IIR filter design, orders 32 and 64 with a 3 kHz cutoff,

analyzed with DTFT/DFT spectral methods.



\## Files



\- `compute\\\_fingerprint.m` - spectrogram, peak extraction, hashing

\- `match\\\_song.m` - offset histogram matching

\- `exercise1\\\_\\\*.m` - filter designs

\- `exercise2\\\_\\\*.m` - spectral analysis



Audio files are excluded from this repository.

