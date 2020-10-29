import java.awt.Robot;

Robot robot;

Boundary[] walls;
Player player;

boolean leftDown = false;
boolean rightDown = false;
boolean upDown = false;
boolean downDown = false;

boolean mouseStuck = false;

int fov = 65;

boolean drawBoundariesRays = false;
boolean drawScene = true;

void setup() {
  
  size(800, 600);
  walls = new Boundary[5+4];
  
  for (int i = 0; i < walls.length; i++) {
    float x1 = random(width);
    float x2 = random(width);
    float y1 = random(height);
    float y2 = random(height);
    walls[i] = new Boundary(x1, y1, x2, y2);
  }
  
  walls[walls.length-4] = (new Boundary(0, 0, width, 0));
  walls[walls.length-3] = (new Boundary(width, 0, width, height));
  walls[walls.length-2] = (new Boundary(width, height, 0, height));
  walls[walls.length-1] = (new Boundary(0, height, 0, 0));
  
  player = new Player(fov);
  
  try {
    robot = new Robot();
  } 
  catch (Throwable e) {}
  
}

void draw() {
  
  update();
  
  background(0);
  
  if(drawBoundariesRays) {
    
    for (Boundary wall : walls) {
      wall.show();
    }
  
    player.show();
    
  }
  
  float[] scene = player.look(walls, drawBoundariesRays);
  
  float w = width / scene.length;
  
  push();
  
  for(int i = 0 ; i < scene.length ; i++) {
   
    float record = scene[i];
 
    float ssq = record*record;

    float wsq = width * width;
    
    float b = map(ssq, 0, wsq, 255, 0);
    float h = height * player.fov / record;
    
    noStroke();
    
    rectMode(CENTER);
    
    fill(b);
    rect(i * w + w / 2, height / 2, w + 1, h);
    
  }
  
  pop();
  
}

void update() {
 
  if(leftDown) {
     player.rotate(-4); 
  } else if(rightDown) {
     player.rotate(4); 
  }
  
  if(upDown) {
     player.move(1, walls); 
  } else if(downDown) {
     player.move(-1, walls); 
  }
  
  if(mouseStuck) {
    robot.mouseMove(width, height); 
  }
  
}

void keyPressed() {
 
   if (key == CODED) {
    if(keyCode == LEFT) leftDown = true;
    if(keyCode == RIGHT) rightDown = true;
    if(keyCode == UP) upDown = true;
    if(keyCode == DOWN) downDown = true;
  }
  
}


void keyReleased() {
 
    if(keyCode == LEFT) leftDown = false;
    if(keyCode == RIGHT) rightDown = false;
    
    if(keyCode == UP) upDown = false;
    if(keyCode == DOWN) downDown = false;
    
    if(keyCode == ESC) {
       mouseStuck = !mouseStuck; 
    }
  
}
