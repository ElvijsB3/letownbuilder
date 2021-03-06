function game_menu_miniload()
   huge_font = love.graphics.newFont("data/newscycle-bold.ttf", 48 )
   dirt =  love.graphics.newImage( "data/images/basic001.png" )
   grass = love.graphics.newImage( "data/images/basic002.png" )
   trees = love.graphics.newImage( "data/images/basic003.png" )
   house = love.graphics.newImage( "data/images/basic026.png" )
   garden = love.graphics.newImage( "data/images/basic046.png")
   donkey = love.graphics.newImage( "data/sprites/s024.png")
   girl   = love.graphics.newImage( "data/sprites/s003.png")
   minimap = { 
      {trees, trees, trees, trees, trees,trees},
      {trees, grass, grass, grass, grass,trees},
      {trees, trees, garden, grass, grass,trees},
      {trees, trees, house, grass, grass,trees},
      {trees, grass, grass, grass, grass,trees},
      {trees, trees, trees, trees, trees,trees}
   }
   
end

function game_menu_draw()
   local row = 45
   local col1 = 100
   --big_font = love.graphics.newFont("data/newscycle-bold.ttf", 24 )
   --love.graphics.setFont( big_font )
   love.graphics.setColor(255,255,255,255)--outside white
   love.graphics.rectangle( "fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight() )
   love.graphics.setColor(0,0,30,255)--inside black
   love.graphics.rectangle( "fill", 5, 5, love.graphics.getWidth()-10, love.graphics.getHeight()-10 )
   love.graphics.setColor(150,150,150,255)--white lettering
   love.graphics.setFont( huge_font )
   love.graphics.print("LeTownBuilder", col1-2+150, 10-2 )
   love.graphics.setColor(255,255,255,255)--white lettering
   love.graphics.print("LeTownBuilder", col1+150, 10  )
   --love.graphics.setFont(base_font)
   love.graphics.setFont( big_font )
   love.graphics.print("New Game", col1, 100 +row*1 )
   love.graphics.print("Load Game", col1, 100 +row*2 )
   if game.map_generated == 0 then
      love.graphics.setColor(80,80,80,255)
   else
      love.graphics.setColor(255,255,255,255) end
   love.graphics.print("Save Game", col1, 100 +row*3 )
   love.graphics.setColor(255,255,255,255)
   love.graphics.print("Love Version  (" ..game.version..")", col1, 100 +row*4 )
   love.graphics.print("Sound  ("..game.togglesound..")", col1, 100 +row*5 )
   love.graphics.print("Quit Game Without Save", col1, 100 +row*6 )
   if game.map_generated == 0 then
      love.graphics.setColor(80,80,80,255)
   else
      love.graphics.setColor(255,255,255,255)
   end
   love.graphics.print("Save/Quit Game", col1, 100 +row*7 )
   lx=0
   ly=0
   love.graphics.setColor(255,255,255,255)
   for y = 1, 6 do
      for x = 1, 6 do
	 lx = 500+(y - x) * 32 + 64
	 ly = 100+(y + x) * 32 / 2 + 50
	 --love.graphics.draw(minimap[y][x], lx+game.draw_x, ly+game.draw_y)
	 love.graphics.draw(minimap[y][x], lx-100, ly-100)
      end
   end
   love.graphics.draw(girl, 460, 230)
   love.graphics.draw(donkey, 470, 230)
end

function game_menu_mouse(x,y,button)
   local row = 45
   local col1 = 100
   if button == "l" then
      if x >= col1 and x <= 500 and y >=100 +row*1 and y <= 100 +row*2 then --new game
	 game.show_menu = 2
      end
      if x >= col1 and x <= 500 and y >=100 +row*2 and y <= 100 +row*3 then --load game
	 
	 love_crude_load()
	 load_game_res()
	 game.show_menu = 0
      end
      if x >= col1 and x <= 500 and y >=100 +row*3 and y <= 100 +row*4 then --save game
	 if game.map_generated == 1 then
	    love_crude_save()
	    game.show_menu = 0
	 end
      end
      if x >= col1 and x <= 500 and y >=100 +row*4 and y <= 100 +row*5 then --toggle version
	 if game.version == "0.9.0" then game.version = "0.8.0" 
	 else game.version = "0.9.0" end
      end
      if x >= col1 and x <= 500 and y >=100 +row*5 and y <= 100 +row*6 then --toggle version
	 if game.togglesound == "on" then game.togglesound = "off" 
	 else game.togglesound = "on" end
      end
      if x >= col1 and x <= 500 and y >=100 +row*6 and y <= 100 +row*7 then --exit nosave
	 love.event.quit()
      end
      if x >= col1 and x <= 500 and y >=100 +row*7 and y <= 100 +row*8 then --exit nosave
	 if game.map_generated == 1 then
	    love_crude_save()
	    love.event.quit()
	 end
      end
   end
end

function select_biome_mouse(x,y,click)
   if mouse_clicked_inrect(x,y, 150,200,64,148) == 1 then
      game.biome = "forest"
      load_game_res() --load map
      create_new_scene(file)
      game.show_menu = 0
   elseif mouse_clicked_inrect(x,y, 250,200,64,148) == 1 then
      game.biome = "japan"
      load_game_res() --load map
      create_new_scene(file) --no longer in load_game_res because it breaks restore from save
      game.show_menu = 0
   elseif mouse_clicked_inrect(x,y, 350,200,64,148) == 1 then
      game.biome = "desert"
      load_game_res() --load map
      create_new_scene(file) --no longer in load_game_res because it breaks restore from save
      game.show_menu = 0
   end
   
end

function draw_biome_select() -- select your biome!
   love.graphics.print("Letownbuilder: Select your biome", 100,100)
   love.graphics.draw(biome_forest_img, 150, 200)
   love.graphics.draw(biome_japan_img, 250, 200)
   love.graphics.setColor(100,100,100,150)
   love.graphics.draw(biome_desert_img, 350, 200)
   love.graphics.setColor(255,255,255,255)
   --love.graphics.draw(biome_desert_img, 450, 200)
end
