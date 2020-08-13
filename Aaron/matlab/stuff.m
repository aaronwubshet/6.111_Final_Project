Fs = 32000;                                             % Sampling Frequency (Change If Different)
Fn = Fs/2;                                              % Nyquist Frequency
Wp = .01;                                    % Normalised Passband
Ws = .5;                                    % Normalised Stopband
Rp =  1;                                                % Passband Ripple (dB)
Rs = 30;                                                % Stopband Ripple (dB)
[n,Ws] = cheb2ord(Wp,Ws,Rp,Rs);                         % Chebyshev Type II Order
[b,a] = cheby2(n,Rs,Ws);                                % IIR Filter Coefficients
[SOS,G] = tf2sos(b,a);                                  % Convert To Second-Order-Section For Stability
figure(1)
[x, F] = audioread('gls.wav');

freqz(SOS, 4096, Fs)                                    % Check Filter Performance
filt_sig = filtfilt(SOS,G, x);
audiowrite('stuff2.wav', filt_sig, 32000, 'BitsPerSample', 8);