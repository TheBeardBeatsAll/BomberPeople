void setup()
{
  fullScreen();
  initialise();
}//end setup

float border;
float block, block_num;
float x, y;
int player_x, player_y;
int bomb_count, max_bomb, x_pos, y_pos;

float timer_b;

boolean check_b;
boolean[][] level = new boolean[15][15];

Table t;

Player player;
ArrayList<Brick> bricks = new ArrayList<Brick>();
ArrayList<Bomb> bombs = new ArrayList<Bomb>();

void initialise()
{
  bricks.clear();
  
  t = loadTable("brickone.csv", "csv");
  for(TableRow row : t.rows())
  {
    Brick b = new Brick(row);
    bricks.add(b);
  }//end for
  
  block_num = 15;
  border = (width - height)/2;
  block = height / block_num;
  
  bomb_count = 1;
  max_bomb = 5;
  x = block;
  y = block;
  
  player_x = 1;
  player_y = 1;
                  
  for(int i = 0; i < 15 ; i++)
  {
    for(int j = 0; j < 15; j++)
    {
      if( i == 0 || i == 14 || j == 0 || j == 14 || ( i % 2 == 0 && j % 2 == 0))
      {
        level[i][j] = false;
      }//end if
      else
      {
        level[i][j] = true;
      }//end else
    }//end for
  }//end for
  for (int i = 0; i < bricks.size(); i++)
  {
    Brick b = bricks.get(i);
    level[b.x][b.y] = false;
  }//end for
  
  player = new Player(x, y, 'w', 's', 'a', 'd', 'c');
}//end initialise

void draw()
{
  background(0);
  fill(255);
  translate(border, 0);
  rect(0, 0, height, height);
  
  for(int i = 0; i < 15 ; i++)
  {
    for(int j = 0; j < 15; j++)
    {
      if( i == 0 || i == 14 || j == 0 || j == 14 || ( i % 2 == 0 && j % 2 == 0))
      {
        fill(150);
        rect(0 + (i * block), 0 + (j * block), block, block);
      }//end if
    }//end for
  }//end for
  for (int i = 0; i < bricks.size(); i++)
  {
    Brick b = bricks.get(i);
    b.render();
  }//end for
  player.render();
  for(int i = 0; i < bombs.size(); i++)
  {
    Bomb bm = bombs.get(i);
    if(bm.render())
    {
      bomb_count++;
      level[x_pos][y_pos] = true;
      bombs.remove(bm);
    }//end if
  }//end for
}//end draw

void keyPressed()
{
  check_b = player.update(key);
  if(check_b)
  {
    if(bomb_count > 0)
    {
      Bomb bm = new Bomb(player_x, player_y);
      bombs.add(bm);
      x_pos = player_x;
      y_pos = player_y;
      bomb_count--;
      timer_b = millis();
      level[x_pos][y_pos] = false;
    }//end if
  }//end if
}//end keyPressed