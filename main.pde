/*
	
	Last updated at: 2019 July 9th

	Processing 3 sketch imitating random line movement

	additional commands of the sketch: 
	  j for jittery lines
	  k for non-jittery lines
	  n to reset the lines
*/


ArrayList <PVector> points = new ArrayList <PVector> ();

boolean jitter = false;

void setup() {
  size(1024,512);
  points.add(new PVector(mouseX,mouseY));
}

void draw() {

  background(#333333);

  if (frameCount % 3 == 0) {
    float x = points.get(points.size()-1).x;
    float y = points.get(points.size()-1).y;
    if (mousePressed) {
      x = mouseX + random(-32,32);
      y = mouseY + random(-32,32);
    } else if (frameCount % int(random(32,64)) == 0) {
      x += random(-64, 64);
      y += random(-64, 64);
    } else {
      x += random(-32,32);
      y += random(-32,32);
    }
    x = constrain(x,2,width-2);
    y = constrain(y,2,height-2);
    points.add(new PVector(x,y));
  }

  while (points.size() > 255) {
    points.remove(0);
  }

  for (int i=1; i<points.size(); i++) {
    PVector p1 = points.get(i-1);

    if (jitter == true) {
      if (i > 5) {
        p1 = points.get(i-int(random(1,5)));
      }
    }
    
    PVector p2 = points.get(i);
    stroke(i);
    strokeWeight(1);
    line(p1.x,p1.y, p2.x,p2.y);

    if (i > 3) {
      PVector p3 = points.get(i-2);
      PVector p4 = points.get(i-3);

      line(p1.x,p1.y,p3.x,p3.y);
      line(p1.x,p1.y,p4.x,p4.y);
    }
  }
}

void keyPressed( ){
  if (key == 'j') {
    jitter = true;
  } else if (key == 'k') {
    jitter = false;
  } else if (key == 'n') {
    points = new ArrayList <PVector> ();
    setup();
  }
}
