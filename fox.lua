--fox.lua

fox = {}

function fox.load()
	--여우들의 상태를 초기화한다.
	local a, b, randomx, randomy
	
	fox.count = 5 --여우의 수는 5마리.
	
	for a = 1, fox.count do
		::randomgen::
		randomx = love.math.random(0, 19)
		randomy = love.math.random(0, 19)
		
		for b = 1, #fox do
			if (fox[b].x == randomx) and (fox[b].y == randomy) then
				goto randomgen
				-- 여우의 x,y좌표를 랜덤으로 생성하는 코드인데
				-- 혹시 똑같은게 나오면 안되니까 다시하게 만듭니다.
			end
		end
		fox.new(randomx, randomy)
	end
end

function fox.new(x, y)
	--여우를 새로 만든다.
	fox[#fox + 1] = {}
	fox[#fox].x = x
	fox[#fox].y = y
	fox[#fox].state = "live" --live:살아있음 bam:부딪힌 이펙트 상태 dead:죽었음
end

function fox.move()
	--여우들이 움직이게 한다.
	local a, b
	
	for a = 1, #fox do
		if fox[a].state == "live" then --살아있는 여우만 움직여주면 됨
			--플레이어쪽으로 1칸씩 움직임.
			--일단 x좌표 먼저 움직여줌
			if fox[a].x > player.x then
				fox[a].x = fox[a].x - 1
			elseif fox[a].x < player.x then
				fox[a].x = fox[a].x + 1
			end
			
			--y좌표도 움직임
			if fox[a].y > player.y then
				fox[a].y = fox[a].y - 1
			elseif fox[a].y < player.y then
				fox[a].y = fox[a].y + 1
			end
			
			--혹시 이동한 자리가 다른 여우랑 겹치지는 않는가?
			for b = 1, #fox do
				if not(a == b) then --자기는 자기랑 당연히 겹치지...
					if (fox[a].x == fox[b].x) and (fox[a].y == fox[b].y) then
						--살아있는 여우랑 겹쳤을 때만
						if fox[b].state == "live" then
							--둘다 죽음
							fox[a].state = "bam"
							fox[b].state = "bam"
							fox.count = fox.count - 2
						end
					end
				end
			end
			
			--혹시 이동한 자리에 플레이어가 있지는 않은가?
			if (fox[a].x == player.x) and (fox[a].y == player.y) then
				player.state = "dead"
				
			end
		end
	end
	
	--여우의 수를 확인한다.
	if fox.count < 2 then --남은 여우의 수가 1마리 이하
		player.state = "win" --이겼다! 게임 끝!
	else
		print(fox.count)
	end
end

function fox.die()
	-- 부딪힌 여우가 있다면 죽인다.
	local a
	for a = 1, #fox do
		if fox[a].state == "bam" then
			fox[a].state = "dead"
		end
	end
end

function fox.update()
	-- 여우들의 상태를 업데이트한다.
	fox.die()
	fox.move()
end

function fox.draw()
	-- 여우들을 그린다.
	local a
	for a = 1, #fox do
		if fox[a].state == "live" then
			--여우를 그린다.
			love.graphics.draw(imgfox, fox[a].x * 16, fox[a].y * 16)
		elseif fox[a].state == "bam" then
			--이펙트를 그린다.
			love.graphics.draw(imgfox_bam, fox[a].x * 16, fox[a].y * 16)
		elseif fox[a].state == "dead" then
			--그리지 않는다.
		end
	end
end