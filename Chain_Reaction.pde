float randVmax = 5;
int randAmount = 300;
float partSize = 2;

ArrayList<Particle> particles;
void setup()
{

  particles = new ArrayList<Particle>();

  for (int i = 0; i < randAmount; i++)
  {
    particles.add(RandomParticle());
  }

  fullScreen();
}

void draw()
{
  thread("checkPositions");
  thread("moveParticles");
  background(61);
  fill(255);
  noStroke();
  for (int i = particles.size() - 1; i >= 0; i--) 
  {
    Particle part1 = particles.get(i);
    drawParticle(part1);
    for (int j = particles.size() - 1; j >= 0; j--) 
    {
      if (i != j )
      {
        if ( particlesAreTouching(part1, particles.get(j)) && particles.size() < 100000 )
        {
          particles.remove(min(i, j));
          particles.remove(max(i, j)-1);
          particles.add(RandomParticle());
          particles.add(RandomParticle());
          particles.add(RandomParticle());
          if (i > 0)
            i--;
        }
      }
    }
  }
}

boolean particlesAreTouching(Particle part1, Particle part2)
{
  float dist = dist(part1.x, part1.y, part2.x, part2.y);
  return dist < partSize;
}

void checkPositions()
{
  for (int i = particles.size() - 1; i >= 0; i--) 
  {

    Particle part1 = particles.get(i);
    checkPosition(part1);
    //    moveParticle(part1);
    //  drawParticle(part1);
  }
}

void checkPosition(Particle part)
{
  if (part.x < partSize/2 || part.x > (width - partSize/2))
    part.vx *= -1;
  if (part.y < partSize/2 || part.y > (height - partSize/2))
    part.vy *= -1;
}

void moveParticles()
{
  for (int i = particles.size() - 1; i >= 0; i--) 
  {
    Particle part1 = particles.get(i);
    moveParticle(part1);
  }
}

void moveParticle(Particle part)
{
  part.x += part.vx;
  part.y += part.vy;
}

void drawParticle(Particle part)
{
  ellipse(part.x, part.y, partSize, partSize);
}

Particle RandomParticle()
{
  return new Particle(random(partSize/2, width - partSize/2), random(partSize/2, height - partSize/2), random(-randVmax, randVmax), random(-randVmax, randVmax));
}
