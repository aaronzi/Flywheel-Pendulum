%% VOREINSTELLUNGEN
clear;
clc;
warning('off','all');


%% ORDNER HINZUFÜGEN
addpath('./1. Konstanten/', '2. Lineares_und_nichtlineares_Modell\', '3. Steuerbarkeit\', '4. LMI', '5. Simulationen\', '6. Reglervalidierung_linear', '7. Regleranwendung_nichtlinear');
addpath('6. Reglervalidierung_linear/1. Vergleich_linear_nichtlinear', '6. Reglervalidierung_linear/2. Einfache_Zustandsrueckfuehrung_linear');
addpath('7. Regleranwendung_nichtlinear/1. Einfache_Zustandsrueckfuehrung_nichtlinear');

%% KONSTANTEN
global c;                   % Konstanten als global deklarieren
c = Konstanten();           % Konstanten aufrufen
V_m=10;
start_deg=180;

%% ZUSTANDSRAUMMODELL (NICHT LINEARISIERT)
syms x [4 1];               % symbolische (4x1)-Matrix
syms Vm;                    % symbolische Eingangsspanung
[f1, f2, f3, f4] = Nichtlineares_Zustandsraummodell(c);


%% ZUSTANDSRAUMMODELL (LINEARISIERT) 
x_c = [0; 0; 0; 0];      % Ruhelage
[A, B, C, D] = Lineares_Zustandsraummodell(x, Vm, x_c, f1, f2, f3, f4);


%% ÜBERPÜRFUNG DER STEUERBARKEIT
[Q] = Steuerbarkeit(A, B);


%% REGLER - EINFACHE ZUSTANDSRÜCKFÜHRUNG
alpha = 0.5;                                            % Decay Rate
theta = 50*pi/180;                                      % Kegelwinkel
r = 14;                                                 % Radius des Halbkreises
k = LMI_Berechnung_k_komplex(A, B, alpha, theta, r);    % k-Faktoren
sP = eig(A - B*k);                                      % Eigenwerte des Reglers

%{
% Polregion und Polstellen plotten
figure
hold on;

% Decay-Rate
xline(-alpha, "m--");                                               % Ploten der Decay-Rate

% Halbkreis
Kreis_Aus = pi/2:0.01:3/2*pi; 
x_Kreis = r*cos(Kreis_Aus);
y_Kreis = r*sin(Kreis_Aus);
plot(x_Kreis, y_Kreis, "--k");                                      % Kreisausschnitt

% Kegel
x_Kegel = 0:-10:-10;
y_Kegel_oben = -tan(theta)*x_Kegel;
y_Kegel_unten = (-tan(theta)*x_Kegel)*(-1);
plot(x_Kegel, y_Kegel_oben, "b--", x_Kegel, y_Kegel_unten, "b--");  % Kegel

% Lokalisierung der Polstellen
p1 = plot(real(eig(A)), imag(eig(A)), "bx", "LineWidth", 2);
p2 = plot(real(sP), imag(sP), "rx", "LineWidth", 2);
xlabel("Real(x)");
ylabel("Imag(x)");
legend([p1 p2], "Eigenwerte der Systemmatrix", "Eigenwerte geregeltes System", "Location", "northeast");
grid on;
hold off;

% PDF SPEICHERN
pos = get(gcf, 'Position');
set(gcf, 'Position',pos-[0 0 0 100]);
filename = fullfile('Vergleich_der_Polstellenlagen.pdf');
exportgraphics(gcf,filename,'ContentType','vector');
%}