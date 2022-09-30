%%>
data=sensitivity_1000();
%%
data.thetaMax=data.thetaMax*180/pi;
%%
tparameter_1000=sensi.Data.Workspace.LocalWorkspace.ParamSet_1.Values  ;
%%
sdo.scatterPlot(tparameter_1000,data);
%%
[H,AX,BigAX,P,PAx] = sdo.scatterPlot(tparameter_1000,data);
for i= 1:length(H)
    for z= 1:9
 H(i,z).MarkerSize = 10;
    end
end

%%
ylabel(AX(1,1),'$\dot\varphi_{Max}$','interpreter','latex','FontSize',20)
ylabel(AX(2,1),'$\tau_{Max}$','interpreter','latex','FontSize',20)
ylabel(AX(3,1),'$\ddot\varphi_{Max}$','interpreter','latex','FontSize',20)
ylabel(AX(4,1),'$\theta_{Max}$','interpreter','latex','FontSize',20)
ylabel(AX(5,1),'$\dot\theta_{Max}$','interpreter','latex','FontSize',20)
ylabel(AX(6,1),'$\ddot\theta_{Max}$','interpreter','latex','FontSize',20)
ylabel(AX(7,1),'$\dot\varphi_{t}$','interpreter','latex','FontSize',20)
ylabel(AX(8,1),'$\tau_{t}$','interpreter','latex','FontSize',20)
ylabel(AX(9,1),'$\ddot\varphi_{t}$','interpreter','latex','FontSize',20)
ylabel(AX(10,1),'$\theta_{t}$','interpreter','latex','FontSize',20)
ylabel(AX(11,1),'$\dot\theta_{t}$','interpreter','latex','FontSize',20)
ylabel(AX(12,1),'$\ddot\theta_{t}$','interpreter','latex','FontSize',20)

%%
xlabel(AX(12,1),'$J_{2}$','interpreter','latex','FontSize',20)
xlabel(AX(12,2),'$J_{1}$','interpreter','latex','FontSize',20)
xlabel(AX(12,3),'$l_{2}$','interpreter','latex','FontSize',20)
xlabel(AX(12,4),'$l_{1}$','interpreter','latex','FontSize',20)
xlabel(AX(12,5),'$m_{2}$','interpreter','latex','FontSize',20)
xlabel(AX(12,6),'$m_{1}$','interpreter','latex','FontSize',20)
xlabel(AX(12,7),'$c_{2}$','interpreter','latex','FontSize',20)
xlabel(AX(12,8),'$c_{1}$','interpreter','latex','FontSize',20)
xlabel(AX(12,9),'$V_{m}$','interpreter','latex','FontSize',20)
%%
for i=1:length(AX)
AX(i,1).FontSize=15;
end
for i=1:9
AX(12,i).FontSize=15;
end

%%
scatter(tparameter_1000.V_m,data.phi_punkt_max,'filled')
xlabel('$V_m$','interpreter','latex','FontSize',20)
ylabel('$\dot\varphi_{Max}$','interpreter','latex','FontSize',20)
%%
scatter(tparameter_1000.c_c2,data.phi_punkt_max,'filled')
xlabel('$C_2$','interpreter','latex','FontSize',20)
ylabel('$\dot\varphi_{Max}$','interpreter','latex','FontSize',20)
%%
scatter(tparameter_1000.c_c2,data.phi_punkt_settlingtime,'filled')
xlabel('$C_2$','interpreter','latex','FontSize',20)
ylabel('$\dot\varphi_{t}$','interpreter','latex','FontSize',20)
%%
scatter(tparameter_1000.c_J2,data.phi_punkt_settlingtime,'filled')
xlabel('$J_2$','interpreter','latex','FontSize',20)
ylabel('$\dot\varphi_{t}$','interpreter','latex','FontSize',20)
%%
scatter(tparameter_1000.c_J2,data.phiPunktPunktMax,'filled')
xlabel('$J_2$','interpreter','latex','FontSize',20)
ylabel('$\ddot\varphi_{Max}$','interpreter','latex','FontSize',20)
%%
scatter(tparameter_1000.c_J2,data.phi_punkt_punkt_transientTime,'filled')
xlabel('$J_2$','interpreter','latex','FontSize',20)
ylabel('$\ddot\varphi_{t}$','interpreter','latex','FontSize',20)

%%
scatter(tparameter_1000.c_c2,data.phi_punkt_punkt_transientTime,'filled')
xlabel('$C_2$','interpreter','latex','FontSize',20)
ylabel('$\ddot\varphi_{t}$','interpreter','latex','FontSize',20)
%%
scatter(tparameter_1000.c_J2,data.thetaMax,'filled')
xlabel('$J_2$','interpreter','latex','FontSize',20)
ylabel('$\theta_{max}$','interpreter','latex','FontSize',20)
%%
scatter(tparameter_1000.c_J2,data.thetaMax,'filled')
xlabel('$J_2$','interpreter','latex','FontSize',20)
ylabel('$\theta_{max}$','interpreter','latex','FontSize',20)
%%
scatter(tparameter_1000.V_m,data.thetaMax,'filled')
xlabel('$V_m$','interpreter','latex','FontSize',20)
ylabel('$\theta_{max}$','interpreter','latex','FontSize',20)
%%
scatter(tparameter_1000.c_l2,data.thetaMax,'filled')
xlabel('$l_2$','interpreter','latex','FontSize',20)
ylabel('$\theta_{max}$','interpreter','latex','FontSize',20)
%%
scatter(tparameter_1000.c_c1,data.thetaMax,'filled')
xlabel('$C_1$','interpreter','latex','FontSize',20)
ylabel('$\theta_{max}$','interpreter','latex','FontSize',20)
%%

scatter(tparameter_1000.V_m,data.tau_max,'filled')
xlabel('$V_m$','interpreter','latex','FontSize',20)
ylabel('$\tau_{max}$','interpreter','latex','FontSize',20)

%%
scatter(tparameter_1000.c_J2,data.tau_settling_time,'filled')
xlabel('$J_2$','interpreter','latex','FontSize',20)
ylabel('$\tau_{t}$','interpreter','latex','FontSize',20)
%%
scatter(tparameter_1000.c_c2,data.tau_settling_time,'filled')
xlabel('$C_2$','interpreter','latex','FontSize',20)
ylabel('$\tau_{t}$','interpreter','latex','FontSize',20)
%%
scatter(tparameter_1000.c_J2,data.theta_punkt_max,'filled')
xlabel('$J_2$','interpreter','latex','FontSize',20)
ylabel('$\dot\theta_{Max}$','interpreter','latex','FontSize',20)
%%
scatter(tparameter_1000.c_J2,data.Thetat_punktpunkt_max,'filled')
xlabel('$J_2$','interpreter','latex','FontSize',20)
ylabel('$\ddot\theta_{Max}$','interpreter','latex','FontSize',20)

