function [EvalResult,Info] = sensitivity_1000(p)
%SENSITIVITYEVALUATION_EINFACHE_ZUSTANDSRUECKFUEHRUNG_NICHTLINEAR
%
% Solve a design exploration problem for the Einfache_Zustandsrueckfuehrung_nichtlinear model.
%
% The function returns model results, EvalResult,
% and model evaluation information, Info.
%
% The input argument, p, defines the model parameters to vary,
% if omitted the parameters specified in the function body are varied.
%
% Modify the function to include or exclude new design requirements, or
% to change the evaluation options.
%
% Auto-generated by SSATOOL on 30-Sep-2022 16:03:15.
%

%% Open the model.
open_system('Einfache_Zustandsrueckfuehrung_nichtlinear')

%% Specify Model Parameters to Vary
%
if nargin < 1 || isempty(p)
    p = sdo.getParameterFromModel('Einfache_Zustandsrueckfuehrung_nichtlinear',{'c.J2','c.J1','c.l2','c.l1','c.m2','c.m1','c.c2','c.c1','V_m'});
    p(1).Value = 0.00055;
    p(1).Minimum = 0.0001;
    p(1).Maximum = 0.001;
    p(2).Value = 0.05500000000000001;
    p(2).Minimum = 0.01;
    p(2).Maximum = 0.1;
    p(3).Value = 0.55;
    p(3).Minimum = 0.1;
    p(3).Maximum = 1;
    p(4).Value = 0.55;
    p(4).Minimum = 0.1;
    p(4).Maximum = 1;
    p(5).Value = 2.75;
    p(5).Minimum = 0.5;
    p(5).Maximum = 5;
    p(6).Value = 4.4;
    p(6).Minimum = 0.8;
    p(6).Maximum = 8;
    p(7).Value = 0.005500000000000001;
    p(7).Minimum = 0.001;
    p(7).Maximum = 0.01;
    p(8).Value = 0.22;
    p(8).Minimum = 0.04;
    p(8).Maximum = 0.4;
    p(9).Value = 12.5;
    p(9).Minimum = 5;
    p(9).Maximum = 20;
end
ParamValues = getData('ParamSet_1');

%% Specify Design Requirements
%
% Specify design requirements to satisfy during optimization.
Requirements = struct;
Requirements.phi_punkt_max = sdo.requirements.SignalProperty(...
    'Function', @max, ...
    'Type', 'min');
Requirements.tau_max = sdo.requirements.SignalProperty(...
    'Function', @max, ...
    'Type', 'min');
Requirements.phiPunktPunktMax = sdo.requirements.SignalProperty(...
    'Function', @max, ...
    'Type', 'min');
Requirements.thetaMax = sdo.requirements.SignalProperty(...
    'Function', @max, ...
    'Type', 'min');
Requirements.theta_punkt_max = sdo.requirements.SignalProperty(...
    'Function', @max, ...
    'Type', 'min');
Requirements.Thetat_punktpunkt_max = sdo.requirements.SignalProperty(...
    'Function', @max, ...
    'Type', 'min');

%% Simulation Definition
%
% Specify model signals to log during model simulation.
Simulator = sdo.SimulationTest('Einfache_Zustandsrueckfuehrung_nichtlinear');

Sig_Info = Simulink.SimulationData.SignalLoggingInfo;
Sig_Info.BlockPath = 'Einfache_Zustandsrueckfuehrung_nichtlinear/NICHTLINEARE STRECKE/Control Loop/Integrator, Second-Order2';
Sig_Info.OutputPortIndex = 2;
Sig_Info.LoggingInfo.LoggingName = 'Sig';
Sig_Info.LoggingInfo.NameMode = 1;

Sig1_Info = Simulink.SimulationData.SignalLoggingInfo;
Sig1_Info.BlockPath = 'Einfache_Zustandsrueckfuehrung_nichtlinear/NICHTLINEARE STRECKE/DC Motor';
Sig1_Info.LoggingInfo.LoggingName = 'Sig1';
Sig1_Info.LoggingInfo.NameMode = 1;

phi_punkt_punkt_Info = Simulink.SimulationData.SignalLoggingInfo;
phi_punkt_punkt_Info.BlockPath = 'Einfache_Zustandsrueckfuehrung_nichtlinear/NICHTLINEARE STRECKE/Control Loop/MATLAB Function1';
phi_punkt_punkt_Info.LoggingInfo.LoggingName = 'phi_punkt_punkt';
phi_punkt_punkt_Info.LoggingInfo.NameMode = 1;

theta_Info = Simulink.SimulationData.SignalLoggingInfo;
theta_Info.BlockPath = 'Einfache_Zustandsrueckfuehrung_nichtlinear/NICHTLINEARE STRECKE/Control Loop/Integrator, Second-Order1';
theta_Info.LoggingInfo.LoggingName = 'theta';
theta_Info.LoggingInfo.NameMode = 1;

theta_punkt_punkt_Info = Simulink.SimulationData.SignalLoggingInfo;
theta_punkt_punkt_Info.BlockPath = 'Einfache_Zustandsrueckfuehrung_nichtlinear/NICHTLINEARE STRECKE/Control Loop/MATLAB Function';
theta_punkt_punkt_Info.LoggingInfo.LoggingName = 'theta_punkt_punkt';
theta_punkt_punkt_Info.LoggingInfo.NameMode = 1;

thetapunkt_Info = Simulink.SimulationData.SignalLoggingInfo;
thetapunkt_Info.BlockPath = 'Einfache_Zustandsrueckfuehrung_nichtlinear/NICHTLINEARE STRECKE/Control Loop/Integrator, Second-Order1';
thetapunkt_Info.OutputPortIndex = 2;
thetapunkt_Info.LoggingInfo.LoggingName = 'thetapunkt';
thetapunkt_Info.LoggingInfo.NameMode = 1;

Simulator.LoggingInfo.Signals = [...
    Sig_Info; ...
    Sig1_Info; ...
    phi_punkt_punkt_Info; ...
    theta_Info; ...
    theta_punkt_punkt_Info; ...
    thetapunkt_Info];

%%
% Configure the simulator for fast restart
Simulator = fastRestart(Simulator,'on');

%% Create Evaluation Objective Function
%
% Create a function that is called for each combination of parameters
% being varied, to compute the cost.
%
% Use an anonymous function with one argument that calls Einfache_Zustandsrueckfuehrung_nichtlinear_evalFcn.
evalfcn = @(P) Einfache_Zustandsrueckfuehrung_nichtlinear_evalFcn(P,Simulator,Requirements);

%% Evaluation Options
%
% Specify evaluation options.
Options = sdo.EvaluateOptions;
Options.EvaluatedModel = Simulator;
Options.UseParallel = 1;
Options.ParallelFileDependencies = getData('Options_ParallelFileDependencies');
Options.ParallelFileDependencies{end+1} = mfilename('fullpath');

%% Evaluate the Model
%
% Call sdo.evaluate with the objective function handle, parameters to
% vary, parameter values, and options.
[EvalResult,Info] = sdo.evaluate(evalfcn,p,ParamValues,Options);

%%
% Restore the simulator fast restart settings
Simulator = fastRestart(Simulator,'off');
end

function Vals = Einfache_Zustandsrueckfuehrung_nichtlinear_evalFcn(P,Simulator,Requirements)
%EINFACHE_ZUSTANDSRUECKFUEHRUNG_NICHTLINEAR_EVALFCN
%
% Function called at each iteration of the evaluation problem.
%
% The function is called with a set of parameter values, P, and returns
% the evaluated cost, Vals.
%
% See the sdoExampleCostFunction function and sdo.evaluate for a more
% detailed description of the function signature.
%

%% Model Evaluation

% Simulate the model.
Simulator.Parameters = P;
Simulator = sim(Simulator);

% Retrieve logged signal data.
SimLog = find(Simulator.LoggedData,get_param('Einfache_Zustandsrueckfuehrung_nichtlinear','SignalLoggingName'));
Sig_Log = find(SimLog,'Sig');
Sig1_Log = find(SimLog,'Sig1');
phi_punkt_punkt_Log = find(SimLog,'phi_punkt_punkt');
theta_Log = find(SimLog,'theta');
theta_punkt_punkt_Log = find(SimLog,'theta_punkt_punkt');
thetapunkt_Log = find(SimLog,'thetapunkt');

% Evaluate the design requirements.
Vals.phi_punkt_max = evalRequirement(Requirements.phi_punkt_max,Sig_Log.Values);
Vals.tau_max = evalRequirement(Requirements.tau_max,Sig1_Log.Values);
Vals.phiPunktPunktMax = evalRequirement(Requirements.phiPunktPunktMax,phi_punkt_punkt_Log.Values);
Vals.thetaMax = evalRequirement(Requirements.thetaMax,theta_Log.Values);
Vals.theta_punkt_max = evalRequirement(Requirements.theta_punkt_max,thetapunkt_Log.Values);
Vals.Thetat_punktpunkt_max = evalRequirement(Requirements.Thetat_punktpunkt_max,theta_punkt_punkt_Log.Values);

% Evaluate custom requirement functions.  Custom requirement outputs are
% checked using validateattributes, but this is unnecessary if the outputs
% are the correct data type.
phi_punkt_settlingtime_Data.p = P;
phi_punkt_settlingtime_Data.Nominal.Sig = Sig_Log.Values;
Vals.phi_punkt_settlingtime = SettlingTimeFilter(phi_punkt_settlingtime_Data);
validateattributes(Vals.phi_punkt_settlingtime,{'double'},{'real','vector'},'','Vals.phi_punkt_settlingtime');
tau_settling_time_Data.p = P;
tau_settling_time_Data.Nominal.Sig1 = Sig1_Log.Values;
Vals.tau_settling_time = SettlingTimeFilter(tau_settling_time_Data);
validateattributes(Vals.tau_settling_time,{'double'},{'real','vector'},'','Vals.tau_settling_time');
phi_punkt_punkt_transientTime_Data.p = P;
phi_punkt_punkt_transientTime_Data.Nominal.phi_punkt_punkt = phi_punkt_punkt_Log.Values;
Vals.phi_punkt_punkt_transientTime = TransientTimeFilter(phi_punkt_punkt_transientTime_Data);
validateattributes(Vals.phi_punkt_punkt_transientTime,{'double'},{'real','vector'},'','Vals.phi_punkt_punkt_transientTime');
thetaTransient_Data.p = P;
thetaTransient_Data.Nominal.theta = theta_Log.Values;
Vals.thetaTransient = TransientTimeFilter(thetaTransient_Data);
validateattributes(Vals.thetaTransient,{'double'},{'real','vector'},'','Vals.thetaTransient');
theta_punkt_settling_Data.p = P;
theta_punkt_settling_Data.Nominal.thetapunkt = thetapunkt_Log.Values;
Vals.theta_punkt_settling = SettlingTimeFilter(theta_punkt_settling_Data);
validateattributes(Vals.theta_punkt_settling,{'double'},{'real','vector'},'','Vals.theta_punkt_settling');
ThetaPunktPunktSettlingTime_Data.p = P;
ThetaPunktPunktSettlingTime_Data.Nominal.theta_punkt_punkt = theta_punkt_punkt_Log.Values;
Vals.ThetaPunktPunktSettlingTime = SettlingTimeFilter(ThetaPunktPunktSettlingTime_Data);
validateattributes(Vals.ThetaPunktPunktSettlingTime,{'double'},{'real','vector'},'','Vals.ThetaPunktPunktSettlingTime');

% Compress requirement outputs by taking maximum value.
Vals.phi_punkt_max = max(Vals.phi_punkt_max(:));
Vals.tau_max = max(Vals.tau_max(:));
Vals.phiPunktPunktMax = max(Vals.phiPunktPunktMax(:));
Vals.thetaMax = max(Vals.thetaMax(:));
Vals.theta_punkt_max = max(Vals.theta_punkt_max(:));
Vals.Thetat_punktpunkt_max = max(Vals.Thetat_punktpunkt_max(:));
Vals.phi_punkt_settlingtime = max(Vals.phi_punkt_settlingtime(:));
Vals.tau_settling_time = max(Vals.tau_settling_time(:));
Vals.phi_punkt_punkt_transientTime = max(Vals.phi_punkt_punkt_transientTime(:));
Vals.thetaTransient = max(Vals.thetaTransient(:));
Vals.theta_punkt_settling = max(Vals.theta_punkt_settling(:));
Vals.ThetaPunktPunktSettlingTime = max(Vals.ThetaPunktPunktSettlingTime(:));
end

function Data = getData(DataID)
%GETDATA
%
% Helper function to store data used by sensitivityEvaluation_Einfache_Zustandsrueckfuehrung_nichtlinear.
%
% The input, DataID, specifies the name of the data to retrieve. The output,
% Data, contains the requested data.
%

SaveData = load('sensitivityEvaluation_Einfache_Zustandsrueckfuehrung_nichtlinear_Data');
Data = SaveData.Data.(DataID);
end
