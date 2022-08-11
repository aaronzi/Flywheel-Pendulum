%% OPTIMALE LMI-PARAMETER-EINSTELLUNGEN - LINEAR
% MIT ALPHA
function optimal_LMI_einfach_linear(A, B)
    warning('off','all')
  
    % WINKELDATEN
    start_deg = 11;

    % ALPHA-DATEN
    alpha = [1.0 0.5 0.3 0.1 0.05];

    % MATRIZEN
    vec_u = table([], [], [], 'VariableNames',{'Alpha', 'u [V]', 'u < 20.0 V'});

    % BERECHNUNGEN
    for i = 1:length(alpha)

        % BERECHNUNG k-FAKTOREN
        k = LMI_Berechnung_k_einfach(A, B, alpha(i));
        assignin('base','start_deg',start_deg);
        assignin('base', 'V_m', 0);
        assignin('base', "k", k);

        % SIMULATIONSPFAD
        simOut = sim('Einfache_Zustandsrueckfuehrung_linear','StartTime','0','StopTime','5','FixedStep','1/1e4');

        % U
        u = max(abs(simOut.u.Data));
        if u < 20.0
            vec_u = vertcat(vec_u, table([alpha(i)], [u], ["X"], 'VariableNames',{'Alpha', 'u [V]', 'u < 20.0 V'}));
        else
            vec_u = vertcat(vec_u, table([alpha(i)], [u], ["-"], 'VariableNames',{'Alpha', 'u [V]', 'u < 20.0 V'}));
        end
    end

    filename = fullfile('./6. Reglervalidierung_linear/2. Einfache_Zustandsrueckfuehrung_linear/', 'Optimale_LMI_Parameter_einfach_linear.xls');
    writetable(vec_u, filename, 'WriteVariableNames',false,'WriteRowNames', false);
end