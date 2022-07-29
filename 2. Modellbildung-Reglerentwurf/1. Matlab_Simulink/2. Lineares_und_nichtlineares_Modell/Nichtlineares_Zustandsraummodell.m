% EINGABEN
% c           Konstanten als Funktionshandle

% AUSGABEN
% f1 - f4     Zeilen des nichtlinearisierten Zustandsraummodell

function [f1, f2, f3, f4] = Nichtlineares_Zustandsraummodell(c)

    % Zeilen für nichtlinearisiertes Zustandsraummodell
    f1 = @(x, Vm) x(2);
    f2 = @(x, Vm) (((c.Kt*(Vm-c.Kb*x(4))/c.Ra)-c.c2*x(4)-(c.m1*c.l1+c.m2*c.l2)*c.g*sin(x(1))+c.c1*x(2))/c.J2)/(1-(c.m1*c.l1^2+c.m2*c.l2^2+c.J1+c.J2)/c.J2);
    f3 = @(x, Vm) x(4);
    f4 = @(x, Vm) (((c.m1*c.l1+c.m2*c.l2)*c.g*sin(x(1))-c.c1*x(2)-(c.m1*c.l1^2+c.m2*c.l2^2+c.J1+c.J2)*((c.Kt*(Vm-c.Kb*x(4))/c.Ra)-c.c2*x(4))/c.J2)/c.J2)/(1-(c.m1*c.l1^2+c.m2*c.l2^2+c.J1+c.J2)/c.J2);
end