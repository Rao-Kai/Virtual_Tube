function inflow_settings = inflowInitialization(switchtime,switchvalue,glowthrate)
inflow_settings.time = switchtime;
inflow_settings.value_init = switchvalue;
inflow_settings.glowthrate = glowthrate;
time_end=inflow_settings.time(end);
inflow_settings.num = zeros(time_end,1);
inflow_settings.totalnum = zeros(time_end,1);
inflow_settings.inflow = zeros(time_end,1);
for i=1:size(inflow_settings.inflow,1)+1
    for j =2:size(inflow_settings.time,1)
        if i<inflow_settings.time(j)+1 && i>=inflow_settings.time(j-1)+1
            inflow_settings.inflow(i)=1/10*floor(10*(inflow_settings.value_init(j-1)+inflow_settings.glowthrate(j-1)*(i-inflow_settings.time(j-1)-1)));
        end
    end
end
inflow_settings.num = 60*inflow_settings.inflow;
for i =1:size(inflow_settings.totalnum,1)
inflow_settings.totalnum(i) = sum(inflow_settings.num(1:i));
end
end

