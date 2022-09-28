model="Einfache_Zustandsrueckfuehrung_nichtlinear";
load_system(model);
V_msweep=[5, 10, 15 ,20];
simIn(1:4) = Simulink.SimulationInput(model);

for idx = 1:4
   %simIn(idx) = setVariable(simIn,'V_m',V_msweep(idx),'Workspace','Einfache_Zustandsrueckfuehrung_nichtlinear');
    simIn(idx) = simIn(idx).setVariable('V_m',V_msweep(idx))
    
end


%simIn(idx)=setVariable(simIn,'V_m',2);
out=sim(simIn);

%%
close all;
plot(out(1).x.Phi_Punkt.Time,out(1).x.Phi_Punkt.Data,'black','LineWidth',1.5)
hold on
plot(out(2).x.Phi_Punkt.Time,out(2).x.Phi_Punkt.Data,'b--','LineWidth',1.5)
plot(out(3).x.Phi_Punkt.Time,out(3).x.Phi_Punkt.Data,'r:','LineWidth',1.5)
plot(out(4).x.Phi_Punkt.Time,out(4).x.Phi_Punkt.Data,'c-.','LineWidth',1.5)
grid on ;
xlabel('t [s]','interpreter','latex','fontsize',20)
ylabel('$\dot\varphi \,[rad/s]$','interpreter','latex','fontsize',20)
legend('$V_m=5\,V$','$V_m=10\,V$','$V_m=15\,V$','$V_m=20\,V$','interpreter','latex','fontsize',14)