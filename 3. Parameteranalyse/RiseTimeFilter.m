function vals=RiseTimeFilter(data)
%RISETIMEFILTER
s=stepinfo(data.Nominal.Sig.Data,data.Nominal.Sig.Time);
vals=s.RiseTime;

end