clc; clear ; 

%% Read the world, open and display it

world = vrworld('anim.wrl');
open(world);
fig = view(world, '-internal');
vrdrawnow

%% Examining the world properties
get(world);

%% getting the nodes of the wolrd.
%nodes(world);
car = vrnode(world, 'Car');
observer_viewpoint = vrnode(world, 'observer');

%% Drive from driveway to workplace via school
y=car.translation(2); z=car.translation(3);
ox=observer_viewpoint.position(1); oy=observer_viewpoint.position(2); oz=observer_viewpoint.position(3);

move = 1:1:50;
view=ox:1:length(move);
for i=1:length(move)
    car.translation = [move(i), y, z];
    observer_viewpoint.position = [view(i), oy, oz];
    vrdrawnow;
    pause(0.1);
end

% rotate the car towards the school road
 car.rotation = [0, 1, 0, deg2rad(-90)];
 vrdrawnow;
 
 % To the school
 move = 1:1:40;
 x = car.translation(1); y=car.translation(2); 
 ox=observer_viewpoint.position(1); oy=observer_viewpoint.position(2); oz=observer_viewpoint.position(3);
 pos = observer_viewpoint.position(3)-15:1:80;
 for i=1:length(move)
     car.translation = [x, y, move(i)];
     if i == 7
         % rotate the camera towards the school
         ox=observer_viewpoint.orientation(1); oz=observer_viewpoint.orientation(3);
         observer_viewpoint.orientation = [ox, -1, oz, deg2rad(180)];
         ox=observer_viewpoint.position(1); oy=observer_viewpoint.position(2); oz=observer_viewpoint.position(3);
         observer_viewpoint.position = [ox+6, oy, oz];
         observer_viewpoint.position;   
     end
     if i > 7
         observer_viewpoint.position = [ox+8, oy, pos(i)];
     end
     vrdrawnow;
     pause(0.1);
 end

 %% To the parking lot and back to the road

 %change the viewpoint
observer_viewpoint.position = [51.8076  0.9054  132.0032];
observer_viewpoint.orientation = [0 -1 0 deg2rad(32.4)];
vrdrawnow;
%pause(1);

 % move car according to new viewpoint, then rotate to enter parking lot
x = car.translation(1); y=car.translation(2); z=car.translation(3);
rx = car.rotation(1); ry=car.rotation(2); rz=car.rotation(3); rc=car.rotation(4); 

car.translation = [x+2, 1, z];
car.rotation = [rx, ry, rz deg2rad(-80)];
vrdrawnow;
move = 65:1:110;
for i=1:length(move)
    car.translation = [x+2, y, move(i)];
    vrdrawnow;
    pause(0.1);
end
car.rotation = [rx, ry, rz deg2rad(10)];
vrdrawnow;

%into the parking lot
x = car.translation(1); y=car.translation(2); z= car.translation(3);
move = x:1:68;
for i=1:length(move)
    car.translation = [move(i), y, z];
    vrdrawnow;
    pause(0.1);
end
% rotate at parking lot
car.rotation = [rx, ry, rz deg2rad(-80)];
vrdrawnow;

% forward at the parking lot
x = car.translation(1); y=car.translation(2); z= car.translation(3);
move = z:1:128;
for i=1:length(move)
    car.translation = [x, y, move(i)];
    vrdrawnow;
    pause(0.1);
end
car.rotation = [rx, ry, rz, deg2rad(180)];
%%
%out of the parking lot and rotating it
x = car.translation(1); y=car.translation(2); z= car.translation(3);
move=x:-1:52;
for i=1:length(move)
   car.translation = [move(i), y, z]; 
   vrdrawnow;
   pause(0.1);
end
car.rotation = [rx, ry, rz, deg2rad(92)];
vrdrawnow;

%%
% going back to the main road
x = car.translation(1); y=car.translation(2); z= car.translation(3);
move=z:-1:1;
pos = 132:-1:-10;
for i=1:length(move)
    car.translation=[x, y, move(i)];
    if i == 7
        observer_viewpoint.position = [51.8076  0.9054  132.0032];
        observer_viewpoint.orientation = [0 -1 0 deg2rad(14)];
    end
    if i>7
        observer_viewpoint.position = [51.8076  0.9054  pos(i)+5];
    end
    vrdrawnow;
    pause(0.1);
end
%% Going to work

% change to final viewpoint
observer_viewpoint.position = [30.8944  0.9054  -1.888];
observer_viewpoint.orientation = [0 -1 0 deg2rad(117)];

car.rotation=[rx, ry, rz, deg2rad(0)];
vrdrawnow;
x = car.translation(1); y=car.translation(2); z= car.translation(3);
move=x:1:200;
for i=1:length(move)
    car.translation=[move(i), y, z];  
    vrdrawnow;
    pause(0.1);
end    

 %% Finish
reload(world);
vrdrawnow;


