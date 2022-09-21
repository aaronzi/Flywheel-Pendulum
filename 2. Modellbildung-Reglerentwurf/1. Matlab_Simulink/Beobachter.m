function [L, eigA1cD_Obs] = Beobachter(A,C_obs,sP)
%BEOBACHTER Summary of this function goes here
%   Detailed explanation goes here

warning('on','all')

% ===============================================================
% Beobachter Entwurf mit LMI:
% ===============================================================

% neue Lambda Werte für Beobachter bestimmen
i=2; % Mltiplikationsfaktor mit den wunschpolstellen der Regelung

sp_obs = i*sP; % Wunschpolstellen
alpha_obs_max=max(abs(sp_obs)); % den Maximalwert als Beginn des Wunschpolstellenfeldes


% Parameter des Observer-Gain bestimmen:
[L, Psol, ~] = func_obs_criteria_Statefeedback_design_exp_dynamic(A,C_obs,alpha_obs_max);

% Polynom auf steuerbarkeit testen:
[~,notPosDef] = chol(Psol); % wenn notPosDef == 0 => P ist positiv definit.

% testen ob das System steuerbar ist: P muss positiv definit sein!
if notPosDef ~= 0
    error("Das Polynom P ist nicht positiv Definit! Damit ist das System nicht steuerbar!");
end

% Eigenwerte des Observer bestimmen:
eigA1cD_Obs = real(eig(A-L*C_obs));

% testen ob die Eigenwerte hinter der geforderten alpha-Schranke liegen und
% damit den Anforderungen genügen:
if all(real(eig(A-L*C_obs)) >= -alpha_obs_max)
    error("Die Polstellen liegen nicht hinter der alpha-Schranke!");
end
% ---------------------------------------------------------------

warning('off','all')

end

