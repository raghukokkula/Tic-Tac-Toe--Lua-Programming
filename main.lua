local piece = {};
local board = {};
for i=1,3 do
  board[i] = {}     
  for j=1,3 do
    board[i][j] = 3
  end
end
local player = 0;
local zone
local ver
local hor
local exit = 0 ;
local msg =0;
local paint = 
{
  type = "image",
  filename = "3.png" 
}
local rect = display.newRect(100, 200, 600, 600 )
rect.fill = paint

function gameBoard()
  zone = display.newRect( display.contentCenterX, display.contentCenterY, 300, 300 )
  zone.strokeWidth = 2;
  zone:setFillColor(0,.4,.4);
  zone.isSensor = true;

  ver = display.newRect (display.contentCenterX, display.contentCenterY, 100,300);
  ver:setFillColor(0,0,0,0);
  ver.strokeWidth = 2;

  hor = display.newRect (display.contentCenterX, display.contentCenterY, 300,100);
  hor:setFillColor(0,0,0,0);
  hor.strokeWidth = 2;

  Refresh=display.newRect(160,450,160,35)
  Refresh:setFillColor(0,.4,.4)
  RefText=display.newText("Refresh!",160,450,"Algerian",35)
  RefText:setFillColor()
end
gameBoard();

local function zoneHandler (event)
  local x, y = event.target:contentToLocal(event.x, event.y);
  x = x + 150;
  y = y + 150; 
  x = math.ceil( x/100 );
  y = math.ceil( y/100 );
  if (gameMark(x,y)==false) then 
    return;
  end
  checkWin();
  return x,y;
end
zone:addEventListener("tap", zoneHandler);

function gameMark (x,y)
  if (board[x][y] ~= 3) then 
    print("The Space is not empty!")
    return false;
  end
  board[x][y] = player;
  local x1, y1 = zone:localToContent(x,y)
  if(x1 == 161) then
    x1 = 60
    if(y1 == 241) then
      y1 = 140
      elseif (y1 == 242) then
      y1 = 240
      elseif (y1 == 243) then
      y1 = 340
    end
  elseif (x1 == 162) then
    x1 = 160
    if(y1 == 241) then
      y1 = 140
      elseif (y1 == 242) then
      y1 = 240
      elseif (y1 == 243) then
      y1 = 340
    end
  elseif (x1 == 163) then
    x1 = 260
    if(y1 == 241) then
      y1 = 140
      elseif (y1 == 242) then
      y1 = 240
      elseif (y1 == 243) then
      y1 = 340
    end
  end
  piece(player, x1, y1);
  player = (player + 1) % 2;
  return true;
end

function piece(type, x, y)
  if(exit == 0) then
    if (type == 0 ) then
      shape = display.newCircle (x,y, 25);
      shape:setFillColor (1,0,0);
    else 
      shape = display.newRect (x,y, 50, 50);
      shape.rotation= 45;
      shape:setFillColor (0,0,1);
    end
    return shape;
  end
end

function checkWin()
  for i=1,3 do
    if (board[i][1] == board[i][2] and board[i][1] == board[i][3] and board[i][1] ~= 3 and exit==0 and msg==0 ) then
      local winner = "player"..player.." Won!";
      disp= display.newText(winner, 150,50,"Chiller", 40);
      disp:setFillColor();
      exit = 1;
      msg=1;
    elseif (board[1][i] == board[2][i] and board[1][i] == board[3][i] and board[1][i] ~= 3 and exit == 0 and msg==0)  then
      local winner = "player"..player.."  Won!";
      disp = display.newText(winner, 150,50, "Chiller", 40);
      disp:setFillColor();
      msg=1;
      exit = 1
    elseif (board[1][1] == board[2][2] and board[1][1] == board[3][3] and board[1][1] ~= 3 and exit == 0 and msg==0) then
      local winner = "player"..player.." Won!";
      disp =  display.newText(winner, 150,50, "Chiller", 40);
      disp:setFillColor();
      exit = 1;
      msg=1;
    elseif (board[3][1] == board[2][2] and board[3][1] == board[1][3] and board[3][1] ~= 3 and exit == 0 and msg==0) then
      local winner ="player"..player.." Won!";
      disp =  display.newText(winner, 150,50, "Chiller", 40);
      disp:setFillColor();
      exit = 1
      msg=1;
    elseif (board[1][1]~=3 and board[1][2]~=3 and board[1][3]~=3 and board[2][1]~=3 and board[2][2]~=3 and board[2][3]~=3 and board[3][1]~=3 and board[3][2]~=3 and board[3][3]~=3 and msg==0) then 
      local winner ="Stalemate!";
      disp=  display.newText(winner, 150,50, "Chiller", 40);
      disp:setFillColor();
      exit = 1;
      msg=1;
    end
  end
end

function refresh(event)
  for i=1,3 do 
    for j=1,3 do
      board[i][j]=3;
    end
  end
  display.remove(disp);
  gameBoard()
  turn=0
  exit=0
  msg=0
end
Refresh:addEventListener("touch",refresh)