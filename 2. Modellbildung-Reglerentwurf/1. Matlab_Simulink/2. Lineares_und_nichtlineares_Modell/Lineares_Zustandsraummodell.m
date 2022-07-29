% EINGABEN
% x             symbolischer Zustandsvektor x
% Vm            symbolische Spannung
% x_c           Ruhelage als Zeilenvektor
% f1 - f4       Funktionhandle des nichtlinearisierten Zustandsraummodells

% AUSGABEN
% A             Systemmatrix A
% B             Eingangsmatrix B
% C             Ausgangsmatrix C
% D             Störmatrix D

function [A, B, C, D] = Lineares_Zustandsraummodell(x, Vm, x_c, f1, f2, f3, f4)

    % Linearisierung
    A = jacobian([f1(x, Vm); f2(x, Vm); f3(x, Vm); f4(x, Vm)], [x(1), x(2), x(3), x(4)]);
    A = double(subs(A, {x(1), x(2), x(3), x(4)}, {x_c(1), x_c(2), x_c(3), x_c(4)}));
    B = jacobian([f1(x, Vm); f2(x, Vm); f3(x, Vm); f4(x, Vm)], Vm);
    B = double(subs(B, {x(1), x(2), x(3), x(4)}, {x_c(1), x_c(2), x_c(3), x_c(4)}));
    C = [1 0 0 0];
    D = 0;
end