%% Function for direction selection
function [ x ] = select(a)
type=(['F','B','R','L','S']);
i=a;
ip=type(i);
b = cast(ip,'int8');
x=b;
end
