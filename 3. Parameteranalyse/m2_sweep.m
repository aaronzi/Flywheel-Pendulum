%%
% m2 variation
close all
model="Einfache_Zustandsrueckfuehrung_nichtlinear";
load_system(model);
m2_sweeps=[0.1, 0.5, 1 ,1.5];
simIn(1:4) = Simulink.SimulationInput(model);

for idx = 1:4
   %simIn(idx) = setVariable(simIn,'l2',l2sweep(idx),'Workspace','Einfache_Zustandsrueckfuehrung_nichtlinear');
    simIn(idx) = simIn(idx).setVariable('c.m2',m2_sweeps(idx));
    
end

%simIn(idx)=setVariable(simIn,'l2',2);
out=sim(simIn);

%%
% Phi punkt
figure('Name','Phi Punkt')
plot(out(1).x.Phi_Punkt.Time,out(1).x.Phi_Punkt.Data,'black','LineWidth',1.5)
hold on
plot(out(2).x.Phi_Punkt.Time,out(2).x.Phi_Punkt.Data,'b--','LineWidth',1.5)
plot(out(3).x.Phi_Punkt.Time,out(3).x.Phi_Punkt.Data,'r:','LineWidth',1.5)
plot(out(4).x.Phi_Punkt.Time,out(4).x.Phi_Punkt.Data,'c-.','LineWidth',1.5)
grid on ;
xlabel('t [s]','interpreter','latex','fontsize',1.5)
ylabel('$\dot\varphi \,[rad/s]$','interpreter','latex','fontsize',1.5)
legend('$m2=0.1\,kg$','$m2=0.5\,kg$','$m2=1\,kg$','$m2=1.5\,kg$','interpreter','latex','fontsize',14)
saveas(gcf,'figure/m2/phi_punkt','epsc')
%%
%Phi punkt punkt
figure('Name','Phi Punkt Punkt')
plot(out(1).phi_punkt_punkt.Time,out(1).phi_punkt_punkt.Data,'black','LineWidth',1.5)
hold on
plot(out(2).phi_punkt_punkt.Time,out(2).phi_punkt_punkt.Data,'b--','LineWidth',1.5)
plot(out(3).phi_punkt_punkt.Time,out(3).phi_punkt_punkt.Data,'r:','LineWidth',1.5)
plot(out(4).phi_punkt_punkt.Time,out(4).phi_punkt_punkt.Data,'c-.','LineWidth',1.5)
grid on ;
xlabel('t [s]','interpreter','latex','fontsize',1.5)
ylabel('$\ddot\varphi \,[rad/s^2]$','interpreter','latex','fontsize',1.5)
legend('$m2=0.1\,kg$','$m2=0.5\,kg$','$m2=1\,kg$','$m2=1.5\,kg$','interpreter','latex','fontsize',14)
saveas(gcf,'figure/m2/phi_punkt_punkt','epsc')
%%
% Theta
figure('Name','Theta')
plot(out(1).x.Theta.Time,out(1).x.Theta.Data*180/pi,'black','LineWidth',1.5)
hold on
plot(out(2).x.Theta.Time,out(2).x.Theta.Data*180/pi,'b--','LineWidth',1.5)
plot(out(3).x.Theta.Time,out(3).x.Theta.Data*180/pi,'r:','LineWidth',1.5)
plot(out(4).x.Theta.Time,out(4).x.Theta.Data*180/pi,'c-.','LineWidth',1.5)
grid on ;
xlabel('t [s]','interpreter','latex','fontsize',1.5)
ylabel('$\Theta \,[deg]$','interpreter','latex','fontsize',1.5)
legend('$m2=0.1\,kg$','$m2=0.5\,kg$','$m2=1\,kg$','$m2=1.5\,kg$','interpreter','latex','fontsize',14)
saveas(gcf,'figure/m2/theta','epsc')
%%
%pendel geschwindikkeit theta punkt
figure('Name','Theta Punkt')
plot(out(1).x.Theta_Punkt.Time,out(1).x.Theta_Punkt.Data,'black','LineWidth',1.5)
hold on
plot(out(2).x.Theta_Punkt.Time,out(2).x.Theta_Punkt.Data,'b--','LineWidth',1.5)
plot(out(3).x.Theta_Punkt.Time,out(3).x.Theta_Punkt.Data,'r:','LineWidth',1.5)
plot(out(4).x.Theta_Punkt.Time,out(4).x.Theta_Punkt.Data,'c-.','LineWidth',1.5)
grid on ;
xlabel('t [s]','interpreter','latex','fontsize',1.5)
ylabel('$\dot\Theta \,[rad/s]$','interpreter','latex','fontsize',1.5)
legend('$m2=0.1\,kg$','$m2=0.5\,kg$','$m2=1\,kg$','$m2=1.5\,kg$','interpreter','latex','fontsize',14)
saveas(gcf,'figure/m2/theta_punkt','epsc')
%%
%theta punkt punkt
figure('Name','Theta Punkt punkt')
plot(out(1).theta_punkt_punkt.Time,out(1).theta_punkt_punkt.Data,'black','LineWidth',1.5)
hold on
plot(out(2).theta_punkt_punkt.Time,out(2).theta_punkt_punkt.Data,'b--','LineWidth',1.5)
plot(out(3).theta_punkt_punkt.Time,out(3).theta_punkt_punkt.Data,'r:','LineWidth',1.5)
plot(out(4).theta_punkt_punkt.Time,out(4).theta_punkt_punkt.Data,'c-.','LineWidth',1.5)
grid on ;
xlabel('t [s]','interpreter','latex','fontsize',1.5)
ylabel('$\ddot\Theta \,[rad/s^2]$','interpreter','latex','fontsize',1.5)
legend('$m2=0.1\,kg$','$m2=0.5\,kg$','$m2=1\,kg$','$m2=1.5\,kg$','interpreter','latex','fontsize',14)
saveas(gcf,'figure/m2/theta_punkt_punkt','epsc')
%%
figure('Name','Motor torque')
plot(out(1).tau.Time,out(1).tau.Data,'black','LineWidth',1.5)
hold on
plot(out(2).tau.Time,out(2).tau.Data,'b--','LineWidth',1.5)
plot(out(3).tau.Time,out(3).tau.Data,'r:','LineWidth',1.5)
plot(out(4).tau.Time,out(4).tau.Data,'c-.','LineWidth',1.5)
grid on ;
xlabel('t [s]','interpreter','latex','fontsize',1.5)
ylabel('$\tau \,[Nm]$','interpreter','latex','fontsize',1.5)
legend('$m2=0.1\,kg$','$m2=0.5\,kg$','$m2=1\,kg$','$m2=1.5\,kg$','interpreter','latex','fontsize',14)
saveas(gcf,'figure/m2/tau','epsc')