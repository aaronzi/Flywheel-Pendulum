% EINGABEN
% A             Systemmatrix  
% B             Eingangsmatrix  
% alpha         Decay-Rate

% AUSGABEN
% k             Verstärkungungen für Zustandsrückführung
% k_LMIsys      Lösung des LMI-System

function [k, k_LMIsys] = LMI_Berechnung_k_einfach(A, B, alpha)

% Initialisierung des LMI-Systems
setlmis([]);

% Matrizen X und M spezifizieren
varType_symBlock        = 1;
varType_fullRectangular = 2;

[n, ~] = size(A);
[~, m] = size(B);      

X = lmivar(varType_symBlock, [n 1]);         % X-Matrix 
M = lmivar(varType_fullRectangular, [m n]);  % M-Matrix

% Terme der LMI spezifizieren
% 1. LMI
% A*X + X*A' - B*M - M'*B' + 2*alpha*X
lmiterm([1 1 1 X], A, 1, 's');                  % LMI 1
lmiterm([1 1 1 M], -B, 1, 's');                 % LMI 1 
lmiterm([1 1 1 X], 2*alpha, 1);                 % LMI 1

% 2. LMI
% X > 0
lmiterm([-2 1 1 X], 1, 1);                      % LMI 2

% LMI lösen
k_LMIsys = getlmis; 

[~, xfeas] = feasp(k_LMIsys);
 
X_sol = dec2mat(k_LMIsys, xfeas, X);    % Lösung für X
M_sol = dec2mat(k_LMIsys, xfeas, M);    % Lösung für M

k = M_sol * inv(X_sol);                 % Berechnung von k
