%% KONSTANTEN
function c = Konstanten()
    c.J1 = 0.01186;             % [kg*m^2] Massenträgheitsmoment J1 
    c.J2 = 0.0005711;           % [kg*m^2] Massenträgheitsmoment J2 
    c.c1 = 0.04;                % [(N*m*s)/rad] Reibungskoeffizient Pendel
    c.c2 = 0.0001;              % [(N*m*s)/rad] Reibungskoeffizient Schwungrad
    c.m1 = 0.826;               % [kg] Masse Pendel + Stator 
    c.m2 = 0.583;               % [kg] Masse Schwungrad + Rotor
    c.l1 = 0.1053;              % [m] Länge l1
    c.l2 = 0.14;                % [m] Länge l2
    c.Kb = 0.0987;              % [V/(rad/s)] Back-emf Konstante
    c.Kt = 0.0987;              % [(N*m)/A] Drehmomentkonstante Motor
    c.Ra = 1.5562;              % [Ohm] Wicklungswiderstand
    c.g = 9.81;                 % [m/s^2] Erdbeschleunigung
end