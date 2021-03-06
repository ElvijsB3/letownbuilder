--function show_tooltop_message(text, x,y) -- render.lua show text on mouseover 

function mouse_clicked_inrect(x,y, cx, cy, cw, ch) -- clicked in a rectangle
   if y >= cy and y <= cy+ch and 
   x >= cx and x <= cx+cw then
      return 1
   else
      return 0
   end
end

function get_tooltip_info_from_item() --ran in update?
	mx = love.mouse.getX() --mouse x coord
	my = love.mouse.getY() --mouse y coord
	scrw = love.graphics.getWidth() --screen width
	scrh = love.graphics.getHeight() --screen height
	if mouse_clicked_inrect(mx,my, 600, 1, 32, 32)== 1 then --wood
	   game.tooltip_text = "town records"
	elseif mouse_clicked_inrect(mx,my, 632, 1, 32, 32)== 1 then --wood
	   game.tooltip_text = "load game"
	elseif mouse_clicked_inrect(mx,my, 664, 1, 32, 32)== 1 then --wood
	   game.tooltip_text = "nosave exit"
	elseif mouse_clicked_inrect(mx,my, 696, 1, 32, 32)== 1 then --wood
	   game.tooltip_text = "save and exit"
	elseif mouse_clicked_inrect(mx,my, scrw-64, 1, 32, 32)== 1 then --wood
	   game.tooltip_text = "wood"
	elseif mouse_clicked_inrect(mx,my, scrw-32, 1, 32,32) == 1 then --sakura
	   game.tooltip_text = "sakura"
	elseif mouse_clicked_inrect(mx,my, scrw-64, 32, 32,32)== 1 then --sakura
	   game.tooltip_text = "rocks"
	elseif mouse_clicked_inrect(mx,my, scrw-30, 32, 32,32) == 1 then --sakura
	   game.tooltip_text = "bamboo"
	elseif mouse_clicked_inrect(mx,my, scrw-64, 64, 32,32)== 1 then --sakura
	   game.tooltip_text = "fish"
	elseif mouse_clicked_inrect(mx,my, scrw-30, 64, 32,32) == 1 then --sakura
	   game.tooltip_text = "iron ore"
	elseif mouse_clicked_inrect(mx,my, scrw-64, 96, 32,32)== 1 then --sakura
	   game.tooltip_text = "cherries"
	elseif mouse_clicked_inrect(mx,my, scrw-30, 96, 32,32) == 1 then --sakura
	   game.tooltip_text = "gold ore"
	elseif mouse_clicked_inrect(mx,my, scrw-64, 128, 32,32)== 1 then --sakura
	   game.tooltip_text = "carrots"
	elseif mouse_clicked_inrect(mx,my, scrw-30, 128, 32,32) == 1 then --sakura
	   game.tooltip_text = "iron bars"
	elseif mouse_clicked_inrect(mx,my, scrw-64, 160, 32,32)== 1 then --sakura
	   game.tooltip_text = "tomatoes"
	elseif mouse_clicked_inrect(mx,my, scrw-30, 160, 32,32) == 1 then --sakura
	   game.tooltip_text = "gold bars"
	elseif mouse_clicked_inrect(mx,my, scrw-64, 192, 32,32)== 1 then --sakura
	   game.tooltip_text = "meat"
	elseif mouse_clicked_inrect(mx,my, scrw-30, 192, 32,32) == 1 then --sakura
	   game.tooltip_text = "wheat"
	elseif mouse_clicked_inrect(mx,my, scrw-64, 224, 32,32)== 1 then --sakura
	   game.tooltip_text = "sansai"
	elseif mouse_clicked_inrect(mx,my, scrw-30, 224, 32,32) == 1 then --sakura
	   game.tooltip_text = "apples"
	elseif mouse_clicked_inrect(mx,my, scrw-64, 256, 32,32)== 1 then --sakura
	   game.tooltip_text = "fish wine"
	elseif mouse_clicked_inrect(mx,my, scrw-30, 256, 32,32) == 1 then --sakura
	   game.tooltip_text = "pale ale"
	elseif mouse_clicked_inrect(mx,my, scrw-64, 288, 32,32)== 1 then --sakura
	   game.tooltip_text = "sandstone"
	elseif mouse_clicked_inrect(mx,my, scrw-30, 288, 32,32) == 1 then --sakura
	   game.tooltip_text = "wild onions"
	else 
		game.tooltip_text = "NONE"
	end
end

function update_checkscrolling(mx, my)
   if game.mouse_last_x > mx and love.mouse.isDown("l") and game.give_direction == "Scrolling" then
      game.draw_x = game.draw_x-game.scroll_speed
   elseif game.mouse_last_x < mx and love.mouse.isDown("l") and game.give_direction == "Scrolling" then
      game.draw_x = game.draw_x+game.scroll_speed
   end
   if game.mouse_last_y >  my and love.mouse.isDown("l") and game.give_direction == "Scrolling" then
      game.draw_y = game.draw_y-game.scroll_speed
   elseif game.mouse_last_y <  my and love.mouse.isDown("l") and game.give_direction == "Scrolling" then
      game.draw_y = game.draw_y+game.scroll_speed
   end
   if love.keyboard.isDown("up") then
      game.draw_y = game.draw_y+game.scroll_speed
   elseif love.keyboard.isDown("down") then
      game.draw_y = game.draw_y-game.scroll_speed
   elseif love.keyboard.isDown("left") then
      game.draw_x = game.draw_x+game.scroll_speed
   elseif love.keyboard.isDown("right") then
      game.draw_x = game.draw_x-game.scroll_speed
   end
end

function love.mousereleased(x, y, button)
   if button == "l" then
      if game.give_direction == "Scrolling" then
	 game.give_direction = "None"
      end
   end
end


function on_plow_where_click()
   if game_map[game.tile_selected_y][game.tile_selected_x] > 2 then
      game_directives.job_type = "None."
      game_directives.active = 0
      game.give_direction = "Clear this area first"
   else
      update_directives_loc(300, 1)
      game_directives.job_type = "Make garden"
      game.give_direction = "Plow where?"  --"None"
      villagers_do_job(game_directives.location_x, game_directives.location_y, "farmer")
      create_job_forque()
      play_sound(sound_click)
   end -- game_map[game.tile_selected_y][game.tile_selected_x] > 2 then
end

function on_tomatoes_where_click()
   if game_map[game.tile_selected_y][game.tile_selected_x] > 2 then
      game_directives.job_type = "None."
      game_directives.active = 0
      game.give_direction = "Clear this area first"
   else
      update_directives_loc(300, 1)
      game_directives.job_type = "Plant tomatoes"
      game.give_direction = "Tomatoes where?"  --"None"
      villagers_do_job(game_directives.location_x, game_directives.location_y, "farmer")
      create_job_forque()
      play_sound(sound_click)
   end -- game_map[game.tile_selected_y][game.tile_selected_x] > 2 then
end

function on_cut_where_click()
   if game.biome == "forest" and
      game_map[game.tile_selected_y][game.tile_selected_x] >= 3 and
   game_map[game.tile_selected_y][game.tile_selected_x] <= 20 then
      update_directives_loc(300, 1)
      game_directives.job_type = "Cut trees"
      game.give_direction = "Cut where?"
      villagers_do_job(game_directives.location_x, game_directives.location_y , "woodcutter")
      create_job_forque()
      play_sound(sound_treecutting)
      --17-20 desert, has limited "trees"
   elseif game.biome == "desert" and game_map[game.tile_selected_y][game.tile_selected_x] >= 17 and
   	game_map[game.tile_selected_y][game.tile_selected_x] <= 20 then
      update_directives_loc(300, 1)
      game_directives.job_type = "Cut trees"
      game.give_direction = "Cut where?"
      villagers_do_job(game_directives.location_x, game_directives.location_y , "woodcutter")
      create_job_forque()
      play_sound(sound_treecutting)
   elseif game.biome == "japan" and game_map[game.tile_selected_y][game.tile_selected_x] >= 3 and
   game_map[game.tile_selected_y][game.tile_selected_x] <= 9 then
      --japan 3-9 sakura, 10-20 bamboo
      update_directives_loc(300, 1)
      game_directives.job_type = "Cut sakura"
      game.give_direction = "Cut where?"
      villagers_do_job(game_directives.location_x, game_directives.location_y, "woodcutter")
      create_job_forque()
      play_sound(sound_treecutting)
   elseif game.biome == "japan" and game_map[game.tile_selected_y][game.tile_selected_x] >= 10 and
   game_map[game.tile_selected_y][game.tile_selected_x] <= 20 then
      update_directives_loc(300, 1)
      game_directives.job_type = "Cut bamboo"
      game.give_direction = "Cut where?"
      villagers_do_job(game_directives.location_x, game_directives.location_y, "woodcutter")
      create_job_forque()
      play_sound(sound_treecutting)
   else
      game_directives.job_type = "No Trees here" --error you cant find any wood here.
      game_directives.active = 0
      game.give_direction = "No Trees here"
   end -- game_map[game.tile_selected_y][game.tile_selected_x] 
end

function on_dig_where_click()
   if game.biome == "desert" then --you can dig almost anywhere in a desert.
      if game_map[game.tile_selected_y][game.tile_selected_x] > 17 then
	 game_directives.job_type = "None."
	 game_directives.active = 0
	 game.give_direction = "Clear this area first"
      else
	 update_directives_loc(300, 1)
	 game_directives.job_type = "Dig hole"
	 game.give_direction = "Dig where?"
	 villagers_do_job(game_directives.location_x, game_directives.location_y, "miner")
	 create_job_forque()
	 play_sound(sound_click)
      end --desert
   elseif game_map[game.tile_selected_y][game.tile_selected_x] > 2 and
      game_map[game.tile_selected_y][game.tile_selected_x] ~= 55 and
   game_map[game.tile_selected_y][game.tile_selected_x] ~= 56 then
      
      game_directives.job_type = "None."
      game_directives.active = 0
      game.give_direction = "Clear this area first"
   else
      update_directives_loc(300, 1)
      game_directives.job_type = "Dig hole"
      game.give_direction = "Dig where?"
      villagers_do_job(game_directives.location_x, game_directives.location_y, "miner")
      create_job_forque()
      play_sound(sound_click)
   end -- if game_map[game.tile_selected_y][game.tile_selected_x] > 2 then
end

function mouse_clicked_in32(x, y, icon_x, icon_y)
   if y >= icon_y and y <= icon_y +32 and x >= icon_x and x <= icon_x+32 then
      return 1
   else
      return 0
   end
end



function love.mousepressed(x, y, button)
   if button == "l" then
      game.printx = x		--game.printx = 0 -- 0  -62
      game.printy = y      --game.printy = 0 -- 536-600 --0, 64
      if game.show_menu == 1 then
	 game_menu_mouse(x,y,"l")
      elseif game.show_menu == 2 then
	 select_biome_mouse(x,y,"l")
      end
      if mouse_clicked_in32(x, y, 632,0) == 1 then
	 love_crude_load()
	 load_game_res()
      end
      if mouse_clicked_in32(x, y, 664,0) == 1 then
	 love.event.quit()
      end
      if mouse_clicked_in32(x, y, 696,0) == 1 then
	 love_crude_save() --save/quit autosave feature
	 love.event.quit()
      end
      if game.give_direction == "Hunt what?" then
	 on_hunt_something(x,y) --buildings.lua
      end
      
      function mouse_clicked_in64(x, y, icon_x, icon_y)
	 if y >= icon_y and y <= icon_y +64 and x >= icon_x and x <= icon_x+64 then
	    return 1
	 else 
	    return 0
	 end
      end
      if mouse_clicked_in32(x, y, 600,0) == 1 then  --show records
	 if game.game_roster == 0 then 
	    game.game_roster = 1
	 else 
	    game.game_roster = 0
	 end
      end
      if mouse_clicked_in64(x, y, 0, 64*1) == 1 then --Select job
	 if game.give_direction == "Select job" then
	    game.give_direction = "None"
	 else
	    game.give_direction = "Select job"
	 end
      elseif mouse_clicked_in64(x, y, 0, 64*2) == 1 then --Gather Food
	 game.give_direction = "Gather Food"
      elseif mouse_clicked_in64(x, y, 0, 64*3) == 1 then --Build House
	 if game.give_direction == "Select house to build" then
	    game.give_direction = "None"
	 else
	    game.give_direction = "Select house to build" --"Build house"
	 end
      elseif mouse_clicked_in64(x, y, 0, 64*4) == 1 then --Build Road
	 if game.give_direction == "Select road to build"  then
	    game.give_direction = "None"
	 else
	    game.give_direction = "Select road to build"
	 end
      elseif mouse_clicked_in64(x, y, 0, 64*5) == 1 then --and game.give_direction == "None" then
	 if get_kingdom_researchable() == 1 and game.give_direction == "Research" then
	    game.give_direction = "None" -- check for researchables
	 elseif get_kingdom_researchable() == 1 then
	    game.give_direction = "Research" -- check for researchables
	 end
      elseif game.game_roster == 1 then
	 col_one = 80
	 col_two = 160
	 col_three = 240
	 col_four = 328
	 col_five = 428
	 row_num = 1
	 if mouse_clicked_inrect(x,y, col_one-3, 20+68, 60, 23) == 1 then
	    game.records_tab = 1
	    game.roster_selected = "villagers"
	 elseif mouse_clicked_inrect(x,y, col_two-3, 20+68, 60, 23) == 1 then  -- food?
	    game.records_tab = 2
	    game.roster_selected = "food"
	 elseif mouse_clicked_inrect(x,y, col_three-3, 20+68, 60, 23) == 1 then  -- resources?
	    game.records_tab = 3
	    game.roster_selected = "resources"
	 elseif mouse_clicked_inrect(x,y, col_four-3, 20+68, 60, 23) == 1 then
	    game.records_tab = 4
	    game.roster_selected = "messages"
	 end
      elseif game.give_direction == "Research" then
	 if x >= 0 and x <= 64*1 and y >=64*5 and y <= 64*5+64 and game.give_direction == "Research" then
	    game.give_direction = "None"
	 elseif x >= 64*1 and x <= 64*2 and y >=64*5 and y <= 64*5+64 and game.give_direction == "Research" then
	    game.give_direction = "Research economy"
	    game_directives.research_type = "Research economy"
	    game.research_timer = 5000
	 elseif x >= 64*2 and x <= 64*3 and y >=64*5 and y <= 64*5+64 and game.give_direction == "Research" then
	    game.give_direction = "Research security"
	    game_directives.research_type = "Research security"
	    game.research_timer = 5000
	 elseif x >= 64*3 and x <= 64*4 and y >=64*5 and y <= 64*5+64 and game.give_direction == "Research" then
	    game.give_direction = "Research agriculture"
	    game_directives.research_type = "Research agriculture"
	    game.research_timer = 5000
	 elseif x >= 64*4 and x <= 64*5 and y >=64*5 and y <= 64*5+64 and game.give_direction == "Research" then
	    game.give_direction = "Research civics"
	    game_directives.research_type = "Research civics"
	    game.research_timer = 5000
	 elseif x >= 64*5 and x <= 64*6 and y >=64*5 and y <= 64*5+64 and game.give_direction == "Research" then
	    game.give_direction = "Research industry"
	    game_directives.research_type = "Research industry"
	    game.research_timer = 5000
	 end
	 -- ************** Do Job
      elseif game.give_direction == "Demolish what?" then
	 on_demolish_structure()
      elseif game.give_direction == "Hunt What?" then
	 on_hunt_something(x,y)
      elseif game.give_direction == "Gather Food" then
	 on_gather_food()
      elseif game.give_direction == "Cut where?" then
	 on_cut_where_click()
      elseif game.give_direction == "Plow where?" then
	 on_plow_where_click()
      elseif game.give_direction == "Plant tomatoes" then
         on_tomatoes_where_click()
      elseif game.give_direction == "Dig where?" then
      	on_dig_where_click()
      elseif game.give_direction == "Select job" then	 
	 if  mouse_clicked_in64(x,y, 0, 64) == 1 then 
	    game.give_direction = "None"
	 elseif mouse_clicked_in64(x,y, 64*1, 64) == 1 then
	    game.give_direction = "Cut where?" --pressed axe
	 elseif mouse_clicked_in64(x,y, 64*2, 64) == 1 then
	    game.give_direction = "Dig where?" --spressed shovel
	 elseif mouse_clicked_in64(x,y, 64*3, 64) == 1 then
	    game.give_direction = "Plow where?" --farming!
	 elseif mouse_clicked_in64(x,y, 64*4, 64) == 1 then
	    game.give_direction = "Hunt what?" -- hunting
	 elseif mouse_clicked_in64(x,y, 64*5, 64) == 1 then
	    game.give_direction = "Make fire where?"
	 elseif mouse_clicked_in64(x,y, 64*6, 64) == 1 then
	    game.give_direction = "Demolish what?"
	 elseif mouse_clicked_in64(x,y, 64*7, 64) == 1 then
	    if research_topics.tomatoes == 1 then
	       game.give_direction = "Plant tomatoes"
	    end
	 end --if x >= 64*0 and x <= 64*1 and y >=64 and y <= 64+64 then
      -------------- SELECT HOUSE TO BUILD ------------------------
      elseif game.give_direction == "Select house to build" then
	 for i = 0, 8 do
	    if x >= 64*i and x <= 64*(i+1) and y >=64*3 and y <= 64*3+64 then
	       if i*64 == 0 then
		  game.give_direction = "None"
	       elseif x >= 64*1 and x <= 64*(1+1) and y >=64*3 and y <= 64*3+64 then --house
		  build_house_directive("Build house", 23, 23)
	       elseif x >= 64*2 and x <= 64*(2+1) and y >=64*3 and y <= 64*3+64 then --house2
		  build_house_directive("Build house", 24, 24)
	       elseif x >= 64*3 and x <= 64*(3+1) and y >=64*3 and y <= 64*3+64 then --house3
		  build_house_directive("Build house", 25, 25)
	       elseif x >= 64*4 and x <= 64*(4+1) and y >=64*3 and y <= 64*3+64 then --house4
		  build_house_directive("Build house", 26, 26)
	       elseif x >= 64*5 and x <= 64*(5+1) and y >=64*3 and y <= 64*3+64 then --mine
		  build_house_directive("Build house", 27, 27)
	       elseif x >= 64*6 and x <= 64*(6+1) and y >=64*3 and y <= 64*3+64 then --school
		  build_house_directive("Build house", 51, 51)
	       elseif x >= 64*7 and x <= 64*(7+1) and y >=64*3 and y <= 64*3+64 then --barn
		  build_house_directive("Build house", 52, 52)
	       elseif x >= 64*8 and x <= 64*(8+1) and y >=64*3 and y <= 64*3+64 then --graveyard
		  build_house_directive("Build house", 53, 53)
		  --else
		  --build_house_directive("Build house", 60+i, 22+i)
	       end -- if i*64 == 0 then
	    end -- if x >= 64*i and x <= 64*(i+1) and y >=64*3 and y <= 64*3+64 then
	 end -- for i = 0, 7 do
	 
	 if mouse_clicked_in64(x, y, 64*1, 64*4) == 1 then
	    if research_topics.economy >= 1 then
	       build_house_directive("Build house", 66, 66)--trade post
	    end
	 elseif mouse_clicked_in64(x, y, 64*2, 64*4) == 1 then
	    if research_topics.security >= 1 then
	       build_house_directive("Build house", 67, 67)--sharrifs office
	    end
	 elseif mouse_clicked_in64(x, y, 64*3, 64*4) == 1 then
	    if research_topics.industry >= 1 then
	       build_house_directive("Build house", 55, 55)--fishing hut
	    end
	 elseif mouse_clicked_in64(x, y, 64*4, 64*4) == 1 then
	    if research_topics.militia_house >= 1 then
	       build_house_directive("Build house", 60,60)--militia house (needs resource check)
	    end
	 elseif mouse_clicked_in64(x, y, 64*5, 64*4) == 1 then
	    if research_topics.mayors_monument >= 1 then
	       build_house_directive("Build house", game.mayor_sex, game.mayor_sex)--mayors monument
	    end
	 elseif mouse_clicked_in64(x, y, 64*6, 64*4) == 1 then
	    if research_topics.watchtower >= 1 then
	       build_house_directive("Build house", 65, 65)--watchtower
	    end
	 elseif mouse_clicked_in64(x, y, 64*7, 64*4) == 1 then
	    if research_topics.smelter >= 1 then
	       build_house_directive("Build house", 70, 70)--smelter
	    end
	 elseif mouse_clicked_in64(x, y, 64*8, 64*4) == 1 then
	    if research_topics.brewery >= 1 then
	       build_house_directive("Build house", 71, 71)--brewery
	    end
	    ---------------row 3-------------------------------
	 elseif mouse_clicked_in64(x, y, 64*1, 64*5) == 1 then
	    if research_topics.smithy  >= 1 then
	       build_house_directive("Build house", 64, 64)--smithy 
	    end
	 end
	 ------------------SELCT ROAD TO BUILD -------on_build_road()  buildings.lua
      elseif game.give_direction == "Select road to build" then --28,36
	 for i = 0, 10 do
	    if y >= 64*4 and y <= 64*4+64 and x >= 64*i and x <= 64*(i+1) then
	       if i*64 == 0 then
		  game.give_direction = "None"
	       else
		  game.give_direction = "Build road"
		  game.road_to_build = 27+i --1 or higher because of if
	       end
	    end--endif
	 end --endfor
	 for i = 0, 2 do
	    if y >= 64*5 and y <= 64*5+64 and x >= 64*i and x <= 64*(i+1) then
	       if i*64 == 0 then
		  game.give_direction = "None"
	       else
		  game.give_direction = "Build bridge"
		  game.house_to_build = 20+i
	       end --endif
	    end -- endif
	 end --endfor
	 ------------------MAKE GARDEN-----------------------------
      elseif game.give_direction == "Make garden" then --Garden
	 on_build_garden("wheat")
      elseif game.give_direction == "Plant tomatoes" then
         on_build_garden("tomatoes")
	 ------------------HUNT WHAT--------------------------------
      elseif game.give_direction == "Hunt What?" then
	 on_hunt_something(x,y) --buildings.lua
	 ------------------MAKE BONFIRE-----------------------------
      elseif game.give_direction == "Make bonfire" then
	 on_build_bonfire()
      elseif game.give_direction == "Make fire where?" then
	 on_build_bonfire()
	 ----------- PLACE HOUSE ON MAP - CHECK RESOURCES--------------
      elseif game.give_direction == "Build house" then
	 on_build_house()  --buildings.lua
      elseif game.give_direction == "Build bridge" then
	 on_build_bridge() --buildings.lua
      elseif game.give_direction == "Build road" then
	 on_build_road()   --buildings.lua
	 --message_que_add("on_build_road()", 80, 41)
      else
	 game.mouse_last_x =  love.mouse.getX()
	 game.mouse_last_y =  love.mouse.getY()
	 game.give_direction = "Scrolling" 
      end --elseif game.give_direction == "Build road" then
   end
end
