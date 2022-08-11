%% EINFACHE ZUSTANDSRÜCKFÜHRUNG LINEAR
function einfache_zustandsrueckfuehrung_linear()
    warning('off','all')
  
    % WINKELDATEN
    start_deg = 14;

    % MATRIZEN
    vec_theta = [];
    vec_phi = [];
    vec_u = [];

    % LEGENDENEINTRÄGE
    legendString = strings(length(start_deg), 1);
    legendString = sprintf('%.1f°', start_deg(1));

    %{
    for i = 1:length(start_deg)
        legendString(i) = sprintf('%.1f°', start_deg(i));
    end
    %}


    % BERECHNUNGEN
    % SIMULATIONSDATEN
    assignin('base','start_deg',start_deg);
    assignin('base', 'V_m', 0);

    % SIMULATIONSPFAD
    simOut = sim('Einfache_Zustandsrueckfuehrung_linear','StartTime','0','StopTime','5','FixedStep','1/1e4');

    % THETA
    vec_theta = horzcat(vec_theta, simOut.x.Data(:, 1)*180/pi);

    % PHI
    vec_phi = horzcat(vec_phi, simOut.x.Data(:, 3)*180/pi);

    % PHI
    vec_u = horzcat(vec_u, simOut.u.Data);
    
    % PLOTS
    figure
    t_vec = simOut.tout;

    subplot(3, 1, 1);
    plot(t_vec, vec_theta(:, 1), "LineWidth", 1.2);
    xlabel('Zeit t [s]','interpreter','latex');
    ylabel('Winkel $\Theta$ [$^{\circ}$]','interpreter','latex');
    legend(legendString);
    title("Pendelwinkel $\Theta$", 'interpreter','latex');
    grid on;

    subplot(3, 1, 2);
    plot(t_vec, vec_phi(:, 1), "LineWidth", 1.2);
    xlabel('Zeit t [s]','interpreter','latex');
    ylabel('Winkel $\varphi$ [$^{\circ}$]','interpreter','latex');
    legend(legendString);
    title("Schwungradwinkel $\varphi$", 'interpreter','latex');
    grid on;

    subplot(3, 1, 3);
    plot(t_vec, vec_u(:, 1), "LineWidth", 1.2);
    xlabel('Zeit t [s]','interpreter','latex');
    ylabel('Spannung $V_{\mathrm{m}}$ [$V$]','interpreter','latex');
    legend(legendString);
    title("Eingangsspannung $V_{\mathrm{m}}$", 'interpreter','latex');
    grid on;

    %{
    subplot(3, 1, 1);
    for i = 1:length(start_deg)
        hold on;
        plot(t_vec, vec_theta(:, i));
        xlabel('Zeit t [s]','interpreter','latex');
        ylabel('Winkel $\Theta$ [$^{\circ}$]','interpreter','latex');
        legend(legendString);
        grid on;
        hold off;
    end

    subplot(3, 1, 2);
    for i = 1:length(start_deg)
        hold on;
        plot(t_vec, vec_phi(:, i));
        xlabel('Zeit t [s]','interpreter','latex');
        ylabel('Winkel $\varphi$ [$^{\circ}$]','interpreter','latex');
        legend(legendString);
        grid on;
        hold off;
    end

    subplot(3, 1, 3);
    for i = 1:length(start_deg)
        hold on;
        plot(t_vec, vec_u(:, i));
        xlabel('Zeit t [s]','interpreter','latex');
        ylabel('Spannung $V_{\mathrm{m}}$ [$V$]','interpreter','latex');
        legend(legendString);
        grid on;
        hold off;
    end
    %}

    % PDF SPEICHERN
    pos = get(gcf, 'Position');
    set(gcf, 'Position',pos-[0 0 0 100])
    filename = fullfile('./6. Reglervalidierung_linear/2. Einfache_Zustandsrueckfuehrung_linear/', 'einfache_zustandsrueckfuehrung_linear.pdf');
    exportgraphics(gcf,filename,'ContentType','vector');
    disp('Successfully created PDF')
end