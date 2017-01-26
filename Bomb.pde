class Bomb
{
  int x, y;
  float t;
  
  Bomb(int x, int y, float t)
  {
    this.x = x;
    this.y = y;
    this.t = t;
  }//end Bomb
  
  boolean render()
  {
    //bomb_data[k][2]
    float time = ((millis() - t) / 1000); 
    if(time < 0.5 || (time >= 1 && time < 1.5) || (time >= 2 && time < 2.5))
    {
      fill(255, 0, 0);
      triangle(x * block, y * block,(x + 1) * block, y * block, (x + 0.5) * block, (y + 1) * block);
    }//end if
    else if((time >= 0.5 && time < 1) || (time >= 1.5 && time < 2) || (time >= 2.5 && time < 3))
    {
      fill(255, 0, 255);
      triangle(x * block, y * block,(x + 1) * block, y * block, (x + 0.5) * block, (y + 1) * block);
    }//end else if
    else if(time >= 3 && time < 4.5)
    {
      fill(255, 125, 0);
      rect(x * block, y * block, block, block);
      explosion(1, 0);
      explosion(-1, 0);
      explosion(0, 1);
      explosion(0, -1);
    }//end if
    else
    {
      bomb_count++;
      return level[x][y] = true;
    }//end else
    return false;
  }//end render
  
  void explosion(int l, int k)
  {
    for(int i = 1; i < bomb_power; i++)
    {
      if(level[x + (l * i)][y + (k * i)])
      {
        rect((x + (l * i)) * block, (y + (k * i)) * block, block, block);
      }//end if
    }//end for
  }//end explosion
}//end Bomb