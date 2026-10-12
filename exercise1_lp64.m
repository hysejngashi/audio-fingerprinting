% Exercise 1.1 and 1.2 - LP filter, order 64

[audio1, Fs] = audioread('pirates.wav');
[audio2, ~] = audioread('papas_megalitriti.wav');

filterOrder = 64;
cutoffFreq = 3000;
normalizedCutoff = cutoffFreq / (Fs / 2);

b = fir1(filterOrder, normalizedCutoff, 'low', hamming(filterOrder + 1));

audioOut1 = filter(b, 1, audio1);
audioOut2 = filter(b, 1, audio2);

audiowrite('pirates_lp64.wav', audioOut1, Fs);
audiowrite('papas_lp64.wav', audioOut2, Fs);

disp('Original pirates...');
sound(audio1, Fs);
pause(length(audio1)/Fs + 1);
disp('Filtered pirates...');
sound(audioOut1, Fs);
pause(length(audioOut1)/Fs + 1);

disp('Original papas...');
sound(audio2, Fs);
pause(length(audio2)/Fs + 1);
disp('Filtered papas...');
sound(audioOut2, Fs);
pause(length(audioOut2)/Fs + 1);

N = 2048;
w = linspace(-pi, pi, N);
H = freqz(b, 1, w);
f = w * Fs / (2*pi);

figure;
subplot(2,2,1);
plot(w, abs(H));
xlabel('\omega (rad/sample)');
ylabel('|H(e^{j\omega})|');
title('Magnitude vs \omega');
xlim([-pi pi]);
grid on;

subplot(2,2,2);
plot(f, abs(H));
xlabel('f (Hz)');
ylabel('|H(e^{j\omega})|');
title('Magnitude vs f');
xlim([-Fs/2 Fs/2]);
grid on;

subplot(2,2,3);
plot(w, unwrap(angle(H)));
xlabel('\omega (rad/sample)');
ylabel('\angle H(e^{j\omega}) (rad)');
title('Phase vs \omega');
xlim([-pi pi]);
grid on;

subplot(2,2,4);
plot(f, unwrap(angle(H)));
xlabel('f (Hz)');
ylabel('\angle H(e^{j\omega}) (rad)');
title('Phase vs f');
xlim([-Fs/2 Fs/2]);
grid on;

sgtitle('LP Filter, Order 64, fc = 3 kHz');