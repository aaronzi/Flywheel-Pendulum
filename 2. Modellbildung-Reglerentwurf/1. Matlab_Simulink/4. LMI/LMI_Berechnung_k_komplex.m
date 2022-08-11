% EINGABEN
% A             Systemmatrix  
% B             Eingangsmatrix  
% alpha         Decay-Rate

% AUSGABEN
% k             Verstärkungungen für Zustandsrückführung
% k_LMIsys      Lösung des LMI-System

function [k, k_LMIsys] = LMI_Berechnung_k_komplex(A, B, alpha, theta, r)

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
% [A*X + X*A' - B*M - M'*B']*sin(theta)
lmiterm([2 1 1 X], A, sin(theta), 's');         % LMI 2 (1. Zeile, 1. Spalte)
lmiterm([2 1 1 M], -B, sin(theta), 's');        % LMI 2 (1. Zeile, 1. Spalte)

% [A*X - X*A' - B*M + M'*B']*cos(theta)
lmiterm([2 1 2 X], A, cos(theta));              % LMI 2 (1. Zeile, 2. Spalte)
lmiterm([2 1 2 X], 1, -A'*cos(theta));          % LMI 2 (1. Zeile, 2. Spalte)
lmiterm([2 1 2 M], -B, cos(theta));             % LMI 2 (1. Zeile, 2. Spalte)
lmiterm([2 1 2 -M], 1, B'*cos(theta));          % LMI 2 (1. Zeile, 2. Spalte)

% [X*A' - A*X - M'*B' + B*M]*cos(theta)
lmiterm([2 2 1 X], 1, A'*cos(theta));           % LMI 2 (2. Zeile, 1. Spalte)
lmiterm([2 2 1 X], -A, cos(theta));             % LMI 2 (2. Zeile, 1. Spalte)
lmiterm([2 2 1 -M], 1, -B'*cos(theta));         % LMI 2 (2. Zeile, 1. Spalte)
lmiterm([2 2 1 M], B, cos(theta));              % LMI 2 (2. Zeile, 1. Spalte)

% [A*X + X*A' - B*M - M'*B']*sin(theta)
lmiterm([2 2 2 X], A, sin(theta), 's');         % LMI 2 (2. Zeile, 2. Spalte)
lmiterm([2 2 2 M], -B, sin(theta), 's');        % LMI 2 (2. Zeile, 2. Spalte)

% 3. LMI
% [-r*X]
lmiterm([3 1 1 X], -r, 1);                      % LMI 3 (1. Zeile, 1. Spalte)

% [A*X - B*M]
lmiterm([3 1 2 X], A, 1);                       % LMI 3 (1. Zeile, 2. Spalte)
lmiterm([3 1 2 M], -B, 1);                      % LMI 3 (1. Zeile, 2. Spalte)

% [X*A' - M'*B']
lmiterm([3 2 1 X], 1, A');                      % LMI 3 (2. Zeile, 1. Spalte)
lmiterm([3 2 1 -M], 1, -B');                    % LMI 3 (2. Zeile, 1. Spalte)

% [-r*X]
lmiterm([3 2 2 X], -r, 1);                      % LMI 3 (2. Zeile, 2. Spalte)

% 4. LMI
lmiterm([-4 1 1 X], 1, 1);                      % LMI 4

% LMI lösen
k_LMIsys = getlmis; 

[~, xfeas] = feasp(k_LMIsys);
 
X_sol = dec2mat(k_LMIsys, xfeas, X);    % Lösung für X
M_sol = dec2mat(k_LMIsys, xfeas, M);    % Lösung für M

k = M_sol * inv(X_sol);                 % Berechnung von k
