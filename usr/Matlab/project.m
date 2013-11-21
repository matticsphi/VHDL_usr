f=0:0.1:300; % range of frequency
w=f*2*pi; % omega
[b,a]=butter(3,200*2*pi,'s'); % 3rd order Butterworth filter with cutoff at 200Hz
% b: numerator; a: denominator
H=freqs(b,a,w); % find the frequency response
figure(1) % open graphic window #1 for plot
plot(f,abs(H)) % plot magnitude vs. frequency
xlabel('frequency f (Hz)') % label x, y axis
ylabel('magnitude of H(s)')