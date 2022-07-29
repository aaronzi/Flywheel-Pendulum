%% EINFACHE ZUSTANDSRÜCKFÜHRUNG LINEAR
function einfache_zustandsrueckfuehrung_linear()
    warning('off','all')

    % WINKELDATEN
    start_deg = 0:-2:-16;

    % LEGENDENEINTRÄGE
    legendString = strings(length(start_deg), 1);
    for i = 1:length(start_deg)
        legendString(i) = sprintf('%i°', start_deg(i));
    end

    % FIGURE ERSTELLEN
    figure

    % NUMMER DES SUBPLOTS
    subplot(3, 1, 1)

    for j=1:lenght(start_deg)
        % SIMULATIONSDATEN
        assignin('base','start_deg',start_deg(i));

        % SIMULATIONSPFAD
        simOut = sim('Einfache_Zustandsrueckfuehrung_linear','StartTime','0','StopTime','15','FixedStep','1/1e4');

        % THETA
        vec_theta = simOut.x.Data(:, 1)*180/pi;

        % ZEITVEKTOR
        t_vec = simOut.tout;

        hold on
    end
    xlabel('Zeit t [s]','interpreter','latex')
    ylabel('Winkel $\Theta$ [$^{\circ}$]','interpreter','latex')
    legend(legendString)
    hold off;


        % PFAD DER SIMULATION 
        simOut = sim('Einfache_Zustandsrueckfuehrung_linear','StartTime','0','StopTime','15','FixedStep','1/1e4');
        


        % PLOT
        hold on;
        subplot(3, 1, 1);
        plot(t_vec, vec_theta);
        xlabel("Zeit t [s]");
        ylabel('Winkel $\Theta$ [$^{\circ}$]','interpreter','latex');
        grid on;
        hold off;

        hold on;
        subplot(3, 1, 2);
        plot(t_vec, vec_phi);
        xlabel("Zeit t [s]");
        ylabel('Winkel $\varphi$ [$^{\circ}$]','interpreter','latex');
        grid on;
        hold off;

        hold on;
        subplot(3, 1, 3);
        plot(t_vec, vec_v_m);
        xlabel("Zeit t [s]");
        ylabel('Spannung $V_{\mathrm{m}}$ [$V$]','interpreter','latex');
        grid on;
        hold off;
    end
    
    legend(legendString);
    hold off;
    
    % PDF SPEICHERN
    pos = get(gcf, 'Position');
    set(gcf, 'Position',pos-[0 0 0 100])
    filename = fullfile('./6. Reglervalidierung_linear/2. Einfache_Zustandsrueckfuehrung_linear/', 'einfache_zustandsrueckfuehrung_linear.pdf');
    exportgraphics(gcf,filename,'ContentType','vector');
    disp('Successfully created PDF')
end