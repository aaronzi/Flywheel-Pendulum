function vals=SettlingTimeFilter(data)
%RISETIMEFILTER
s=stepinfo(data.Nominal.Sig.Data,data.Nominal.Sig.Time);
vals=s.SettlingTime;

end