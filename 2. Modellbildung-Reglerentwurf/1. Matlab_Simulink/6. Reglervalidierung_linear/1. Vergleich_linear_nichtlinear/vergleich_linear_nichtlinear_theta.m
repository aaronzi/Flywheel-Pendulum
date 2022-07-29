%% VERGLEICH LINEARES UND NICHTLINEARES MODELL - Theta
function vergleich_linear_nichtlinear_theta()
    warning('off','all')

    % SIMULATIONSDATEN
    assignin('base','V_m',0);
    assignin('base','V_m_dyn',0);
    assignin('base','start_deg',-60);

    % PFAD DER SIMULATION 
    simOut = sim('Vergleich_linear_nichtlinear','StartTime','0','StopTime','5','FixedStep','1/1e4');

    % NICHTLINEAR
    vec_theta_nichtlinear = simOut.y_nichtlinear.Data;

    % LINEAR
    vec_theta_linear = simOut.y_linear.Data;

    % ZEITVEKTOR
    t_vec = simOut.tout;

    % PLOT
    figure
    hold on;
    plot(t_vec, vec_theta_linear, 'r--', "LineWidth", 1);
    plot(t_vec, vec_theta_nichtlinear, "b");
    legend("linear", "nichtlinear", "location", "northeast");
    xlabel("Zeit t [s]");
    ylabel('Winkel $\Theta$ [$^{\circ}$]','interpreter','latex');
    grid on;
    hold off;

    % PDF SPEICHERN
    pos = get(gcf, 'Position');
    set(gcf, 'Position',pos-[0 0 0 100])
    filename = fullfile('./6. Reglervalidierung_linear/1. Vergleich_linear_nichtlinear/', 'vergleich_linear_nichtlinear_theta.pdf');
    exportgraphics(gcf,filename,'ContentType','vector');
    disp('Successfully created PDF')
end