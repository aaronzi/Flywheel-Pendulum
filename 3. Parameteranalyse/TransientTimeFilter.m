function vals=TransientTimeFilter(data)
%RISETIMEFILTER
fields = char(fieldnames(data.Nominal));
%strDat=sprintf('data.Nominals.%s.Data',fields)
%strTime=sprintf('data.Nominals.%s.Time',fields)

sig_data=getfield(data,'Nominal',fields,'Data');
sig_time=getfield(data,'Nominal',fields,'Time');

step_info=stepinfo(sig_data,sig_time);
vals=step_info.TransientTime;

end