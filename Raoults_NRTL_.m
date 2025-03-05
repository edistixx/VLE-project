clc
clearvars

pres = inputdlg("Pressure (bar) (1,15 or 40 bar)");
P = str2double(pres);
if P == 1 || P == 15 || P == 40;
    TXY(P)
else
    w = warndlg("The provided pressure value is out of the simulation range,this might affect comparisons")
    waitfor(w)
    TXY(P)
end


function TXY(P)

P = P*760;
ant_const = [8.07247,1574.99,238.86;8.04494,1554.3,222.65];

Xa = linspace(0,1,11);
Tsati = [64.7,78.3];

Tsat = [];
for i = 1:length(Xa)
    fun = @(T) P- (Xa(i)*10.^(ant_const(1,1) - ((ant_const(1,2))./(T + ant_const(1,3)))) + (1-Xa(i))*10.^(ant_const(2,1) - ((ant_const(2,2))./(T + ant_const(2,3)))));
    ni = sum(Tsati);
    Tf = fzero(fun,ni);
    Tsat = [Tsat,Tf];

end

Ya = (Xa.*10.^(ant_const(1,1) - ((ant_const(1,2))./(Tsat + ant_const(1,3)))))/P;
if P == 760
    figure(1)
    plot(Xa,Tsat,Ya,Tsat)
    xlabel("Composition")
    grid()
    ylabel("Temperature (C)")
    legend("Bubble Point curve","Dew Point curve")
    title(sprintf("A Txy diagram for methanol and ethanol at %1i bar using Raoult's law",P/760))

    %for 1 bar

    Yas = [0,0.160125,0.301279,0.425954,0.536327,0.634342,0.72178,0.800337,0.871689,0.937591,1];
    Xas = [0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1];
    Temp = [77.9763,76.203,74.5239,72.9365,71.4393,70.0304,68.7079,67.469,66.3094,65.2229,64.2006];
    figure(2)
    plot(Xa,Tsat,Ya,Tsat)
    hold on
    plot(Xas,Temp,"--",Yas,Temp,"--")
    xlabel("Composition")
    grid()
    ylabel("Temperature (C)")
    legend(["Bubble Point curve (Raoult's)","Dew Point curve (Raoult's)","Bubble Point curve (RK-NRTL)","Dew Point curve (RK-NRTL)"])
    title(sprintf("A combination of Txy diagrams for methanol and ethanol at %1i bar Using Aspen and Raoult's law",P/760))


elseif P == (760*15)
    figure(1)
    plot(Xa,Tsat,Ya,Tsat)
    xlabel("Composition")
    grid()
    ylabel("Temperature (C)")
    legend("Bubble Point curve","Dew Point curve")
    title(sprintf("A Txy diagram for methanol and ethanol at %1i bar using Raoult's law",P/760))

    %for 1 bar

    Yas = [0,0.119531,0.237972,0.353486,0.464561,0.570081,0.669326,0.761925,0.847795,0.927062,1];
    Xas = [0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1];
    Temp = [167.701,166.601,165.361,164.003,162.555,161.044,159.495,157.932,156.374,154.837,153.334];
    figure(2)
    plot(Xa,Tsat,Ya,Tsat)
    hold on
    plot(Xas,Temp,"--",Yas,Temp,"--")
    xlabel("Composition")
    grid()
    ylabel("Temperature (C)")

    legend(["Bubble Point curve (Raoult's)","Dew Point curve (Raoult's)","Bubble Point curve (RK-NRTL)","Dew Point curve (RK-NRTL)"])
    title(sprintf("A combination of Txy diagrams for methanol and ethanol at %1i bar Using Aspen and Raoult's law",P/760))


elseif P == (760*40)
    figure(1)
    plot(Xa,Tsat,Ya,Tsat)
    xlabel("Composition")
    grid()
    ylabel("Temperature (C)")
    legend("Bubble Point curve","Dew Point curve")
    title(sprintf("A Txy diagram for methanol and ethanol at %1i bar using Raoult's law",P/760))
    Temp = [215.918,216.135,215.785,214.844,213.361,211.445,209.231,206.842,204.382,201.925,199.524];
    Xas = [0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1];
    Yas = [0,0.10048,0.209615,0.323664,0.438505,0.550389,0.656483,0.755018,0.845154,0.926727,1];
    figure(2)
    plot(Xa,Tsat,Ya,Tsat)
    hold on
    plot(Xas,Temp,"--",Yas,Temp,"--")
    xlabel("Composition")
    grid()
    ylabel("Temperature (C)")

    legend(["Bubble Point curve (Raoult's)","Dew Point curve (Raoult's)","Bubble Point curve (RK-NRTL)","Dew Point curve (RK-NRTL)"])
    title(sprintf("A combination of Txy diagrams for methanol and ethanol at %1i bar Using Aspen and Raoult's law",P/760))
else
    figure(1)
    plot(Xa,Tsat,Ya,Tsat)
    xlabel("Composition")
    grid()
    ylabel("Temperature (C)")
    legend("Bubble Point curve","Dew Point curve")
    title(sprintf("A Txy diagram for methanol and ethanol at %1i bar using Raoult's law",P/760))
end
%raoult's
r_mean_t = mean(Tsat);
r_st = std(Tsat);
r_cvar = (r_st/r_mean_t) * 100;
%RK
rk_mean_t = mean(Temp);
rk_st = std(Temp);
rk_cvar = (rk_st/rk_mean_t) * 100;
Tsat_variation_measures = ["Mean";"Standard dev";"Coefficient of variation"];
Raoults =  [r_mean_t;r_st;r_cvar];
NRTL_RK = [rk_mean_t;rk_st;rk_cvar];
tab = table(Tsat_variation_measures,Raoults,NRTL_RK)
end







