theta = out.theta(3,:);
t = out.tout;
[peaks, locs] = findpeaks(theta,t);
plot(locs,peaks,'o')
hold on
plot(t,theta)
fitType = fittype('a*exp(-b*x)+c*exp(d*x)');
fittetValues = fit(locs,peaks',fitType);
y = fittetValues(t);
plot(t,y)
hold off