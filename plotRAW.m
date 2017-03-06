function plotRAW(d1,d2,d3,d4,d5,d6,d7,d8)
%this subfunction is used to plot EEG data

% plotRAW(data_raw,data_attention,data_meditation,data_delta,data_theta,data_alpha1,data_beta1,data_gamma1);   

subplot(4,2,1)
plot(d1)
title('Raw')
axis([0 255 -300 300])

subplot(4,2,2)
plot(d2)
title('Meditation')
axis([0 120 0 100])

subplot(4,2,3)
plot(d3)
title('Attention')
axis([0 120 0 100])

subplot(4,2,4)
plot(d4)
title('Delta')
axis([0 120 0 1e6])

subplot(4,2,5)
plot(d5)
title('Theta')
axis([0 120 0 2e5])

subplot(4,2,6)
plot(d6)
title('Alpha')
axis([0 120 0 2e5])

subplot(4,2,7)
plot(d7)
title('Beta')
axis([0 120 0 2e4])

subplot(4,2,8)
plot(d8)
title('Gamma')
axis([0 120 0 2e4])


drawnow;
