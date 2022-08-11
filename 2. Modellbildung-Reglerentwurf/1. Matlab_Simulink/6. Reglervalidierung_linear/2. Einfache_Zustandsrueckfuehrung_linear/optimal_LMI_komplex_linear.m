%% OPTIMALE LMI-PARAMETER-EINSTELLUNGEN - LINEAR
% MIT ALPHA, THETA UND R
function optimal_LMI_komplex_linear(A, B)
    warning('off','all')
  
    % WINKELDATEN
    start_deg = 14;

    % ALPHA-DATEN
    alpha = [1 0.5 0.3 0.1 0.05];

    % THETA-DATEN
    theta = 10:10:60;

    % R-DATEN
    r = 11:1:15;

    % MATRIZEN
    vec_u = table([], [], [], [], [], 'VariableNames',{'Alpha','Theta [°]', 'r', 'u [V]', 'u < 20.0 V'});

    % BERECHNUNGEN
    for i = 1:length(alpha)

        for j = 1:length(theta)

            for h = 1:length(r)
                % BERECHNUNG k-FAKTOREN
                k = LMI_Berechnung_k_komplex(A, B, alpha(i), theta(j)*pi/180, r(h));
                assignin('base','start_deg',start_deg);
                assignin('base', 'V_m', 0);
                assignin('base', "k", k);

                % SIMULATIONSPFAD
                simOut = sim('Einfache_Zustandsrueckfuehrung_linear','StartTime','0','StopTime','5','FixedStep','1/1e4');
                         
                % U
                u = max(abs(simOut.u.Data));
                if u < 20.0
                    vec_u = vertcat(vec_u, table([alpha(i)], [theta(j)], [r(h)], [u], ["X"], 'VariableNames',{'Alpha','Theta [°]', 'r', 'u [V]', 'u < 20.0 V'}));
                else
                    vec_u = vertcat(vec_u, table([alpha(i)], [theta(j)], [r(h)], [u], ["-"], 'VariableNames',{'Alpha','Theta [°]', 'r', 'u [V]', 'u < 20.0 V'}));
                end
            end
        end
    end

    filename = fullfile('./6. Reglervalidierung_linear/2. Einfache_Zustandsrueckfuehrung_linear/', 'Optimale_LMI_Parameter_komplex_linear.xls');
    writetable(vec_u, filename, 'WriteVariableNames',true, 'WriteRowNames', true);
end