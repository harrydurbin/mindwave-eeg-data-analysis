for i = 1:30
    trial = i;

    card_time = [33,21,28,58,40,20,35,33,13,16,47,23,6,52,11,40,35,5,27,...
        53,54,56,4,13,20,25,34,9,30,20];

    filename = sprintf('Trial_%d.csv', trial);
    figurename = sprintf('Trial %d', trial);
    figurefilename_1 = sprintf('Trial %d Figure 1', trial);
    figurefilename_2 = sprintf('Trial %d Figure 2', trial);
    figurefilename_3 = sprintf('Trial %d Figure 3', trial);


    data_array = csvread(filename,1,0);
    t = card_time(trial); % retrieves time noticed for that trial
    x = [t,t];

    % extract columns from the array
    time = data_array(:,1);
    sample = data_array(:,2);
    attention = data_array(:,4);
    meditation = data_array(:,5);
    raw = data_array(:,6);
    delta = data_array(:,7);
    theta = data_array(:,8);
    alpha_low = data_array(:,9);
    alpha_high = data_array(:,10);
    beta_low = data_array(:,11);
    beta_high = data_array(:,12);
    gamma_low = data_array(:,13);
    gamma_mid = data_array(:,14);


    f1 = figure;
    plot(time,raw)
    % h = vline(t);
    title(figurename)
    legend('Raw')
    xlim([t-1,t+1]);
    xlabel('Approximate Time Trigger Card Dealt')
    ylabel('Amp')
    set(gcf,'PaperUnits','centimeters','PaperPosition',[0 0 30 20])
    print(f1,figurefilename_1,'-dpng', '-r300')

    f2 = figure;
    subplot(3,1,1)
    plot(time,attention,time,meditation)
    h = vline(t);
    title(figurename)
    legend('Attention','Meditation')
    xlabel('Time')
    ylabel('Amp')
    subplot(3,1,2)
    plot(time,delta)
    h = vline(t);
    legend('Delta')
    xlabel('Time')
    ylabel('Amp')
    subplot(3,1,3)
    plot(time,theta)
    h = vline(t);
    legend('Theta')
    xlabel('Time')
    ylabel('Amp')
    set(gcf,'PaperUnits','centimeters','PaperPosition',[0 0 30 20])
    print(f2,figurefilename_2,'-dpng', '-r300')


    f3 = figure;
    subplot(3,1,1)
    plot(time,alpha_low,time,alpha_high)
    h = vline(t);
    title(figurename)
    legend('Alpha Low', 'Alpha High')
    xlabel('Time')
    ylabel('Amp')
    subplot(3,1,2)
    plot(time, beta_low,time, beta_high)
    h = vline(t);
    legend('Beta Low', 'Beta High')
    subplot(3,1,3)
    plot(time,gamma_low,time,gamma_mid)
    h = vline(t);
    legend('Gamma Low', 'Gamma Mid')
    set(gcf,'PaperUnits','centimeters','PaperPosition',[0 0 30 20])
    print(f3,figurefilename_3,'-dpng', '-r300')
end