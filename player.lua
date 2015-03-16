--player.lua

player = {}

function player.load()
	--플레이어 상태를 초기화한다.
	player.x = 10 --플레이어 x좌표 위치
	player.y = 10 --플레이어 y좌표 위치
	player.state = "live" --플레이어 상태. live:살았음 dead:죽음 win:이김
	player.teleportchance = 3 --남은 텔레포트 횟수
end

function player.teleport()
	local b, randomx, randomy
	
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
	
	player.x = randomx
	player.y = randomy
	
	turns = turns + 1
end

function player.move(direction)
	--플레이어를 움직이게 한다. direction은 left/right/up/down이다.
	local a
	if direction == "left" then
		--왼쪽으로 움직이는 처리
		player.x = player.x - 1
	elseif direction == "up" then
		--위로 움직이는 처리
		player.y = player.y - 1
	elseif direction == "right" then
		--오른쪽으로 움직이는 처리
		player.x = player.x + 1
	elseif direction == "down" then
		--아래쪽으로 움직이는 처리
		player.y = player.y + 1
	end
	
	--플레이어와 같은 자리에 여우가 있는지 체크함
	local a
	for a = 1, #fox do
		if (fox[a].x == player.x) and (fox[a].y == player.y) then
			--여우가 죽었으면 상관없음. 살았으면 플레이어 죽음.
			if fox[a].state == "live" then
				player.state = "dead" --으앙 쥬금
			else
				--폭발 이펙트 상태거나 죽었거나. 암것도 안함..
			end
		end
	end
	
	turns = turns + 1
end

function player.draw()
	--플레이어를 그린다.
	if player.state == "live" then
		--살아있는 플레이어를 그림
		love.graphics.draw(imgchick, player.x * 16, player.y * 16)
	elseif player.state == "dead" then
		--죽은 플레이어를 그림
		love.graphics.draw(imgchick_dead, player.x * 16, player.y * 16)
	elseif player.state == "win" then
		--플레이어 승리!
		love.graphics.draw(imgchick_smile, player.x * 16, player.y * 16)
	end
end