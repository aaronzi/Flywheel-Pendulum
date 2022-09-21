%--------------------------------------------------------------------------------
% func_criteria_expStability                                   14.6.2020
%--------------------------------------------------------------------------------
% Matlab function for solving a LMI for exponential stability of closed
% loop state feedback controlled systems
%--------------------------------------------------------------------------------
function [L, Psol, LMISYS] = func_obs_criteria_Statefeedback_design_exp_dynamic(A,C,alpha)

%-------------------------------------------------------------
% 1. Beginning of a LMI program
%-------------------------------------------------------------
setlmis([]);


%-------------------------------------------------------------
% 2. Define all LMI variables
%-------------------------------------------------------------
varType_symBlock        = 1;  % symmetric block diagonal
varType_fullRectangular = 2;  % full rectangular

[n,~]=size(C);
[~,m]=size(A);

P = lmivar(varType_symBlock,[m 1]);         % specify variable P as square symmetric (n,n) matrix 
N = lmivar(varType_fullRectangular,[m n]);  % specify variable N as full rectangular (m,n)
                      
   
%-------------------------------------------------------------
% 3. Define all LMI terms lmiterm(TERMID,A,B,FLAG)   L(Z) < R(Z)
%-------------------------------------------------------------
% with TERMID(1) = +n  ->  left-hand side of the n-th L
%      TERMID(1) = -n  ->  right-hand side of the n-th LMI
%lmiterm([-1 1 1 P],-1,1);         % LMI constraint -P < 0 <=> P > 0
%%lmiterm([ 1 1 1 P], 1,1);        % LMI constraint P > 0

%lmiterm([1 1 1 P],A',1,'s');      % A'P + PA  < 0 
%lmiterm([1 1 2 0],1);            % 0
%lmiterm([1 2 2 P],-1,1);         % P > 0

lmiterm([1 1 1 P],1,A,'s');      % A'P + PA  + 2 alpha P < 0 
lmiterm([1 1 1 P],2*alpha,1)
lmiterm([1 1 1 N],1,-C,'s');      % - C'N - NC 
lmiterm([-2 1 1 P],1,1);         % P > 0
%------------------------------------------------------------- 


%-------------------------------------------------------------
% 4. Solve LMI problem
%-------------------------------------------------------------

LMISYS = getlmis;                % Declare the whole LMI problem
[tmin,xfeas] = feasp(LMISYS);    % Solve the LMI problem
disp(tmin)

P_sol = dec2mat(LMISYS,xfeas,P);  % Get solution as the numerical value of P
N_sol = dec2mat(LMISYS,xfeas,N);  % Get solution as the numerical value of N
L = inv(P_sol) * N_sol;           % Get the numerical value of L
Psol = P_sol;


%lmiinfo(LMISYS)





