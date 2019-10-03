clear all;
%create raspberrypi object
mypi = raspi;
%create serial connection with the ATMEGA BOARD
myserialdevice = serialdev(mypi,'/dev/serial0',9600,8,'none',1)
% Create the cam object.
cam = cameraboard(mypi,'Resolution','640x480');
%cam = webcam;
cam.Brightness= 50;
cam.Contrast= 80;
pause(6);% Waiting for a certain time for the system to get initialised
rgb_image = snapshot(cam); % Storing Image in an array variable
[a b c]= size(rgb_image); % Determining the size of the captured frame.
y=a;
x=b;
% Defining Boundaries
 x1=x/2-120;
 x2=x/2+120;
 y1=y/2-30;
 y2=y/2+30;
figure(1);
for i = 1:2000
    %%gives us both the binary and image with dot
    [img, bw,xm,ym] = selfmadetracking(snapshot(cam), 40);
    subplot(121);
    image(img);
    subplot(122);
    image(bw);
       drawnow;
    %%now we use switch cases to handle the robot where to go
    % Converting to decimal number
     e=(((ym>=x1)*2*2*2) + ((ym<=x2)*2*2) + ((xm>=y1)*2) + (xm<=y2));
     disp(xm);
     disp(ym);
% Decision Making Conditions
%% Center distinct
b= selects(5);
      disp(cast(b,'char'));
      write(myserialdevice,b,'int8');
if(xm==0&&ym==0)
     b= selects(5);
     disp(cast(b,'char'));
     write(myserialdevice,b,'int8');
         
elseif(ym <=200)
    b=selects(4);
    disp(cast(b,'char'));
    write(myserialdevice,b,'int8');
    
elseif(ym>=400)
    b=selects(3);
    disp(cast(b,'char'));
    write(myserialdevice,b,'int8');

elseif(xm<=150)
      b= selects(1);
       disp(cast(b,'char'));
     write(myserialdevice,b,'int8');
      
elseif(xm>=300)
      b= selects(2);
      disp(cast(b,'char'));
      write(myserialdevice,b,'int8');

else
     b= selects(5);
     disp(cast(b,'char'));
     write(myserialdevice,b,'int8');
         
end
end

clear all;