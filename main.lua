-- fox and chick
-- 2014.01.10 노루발 제작.
-- 2시간만에 게임 만드는 120분 챌린지를 위한 게임
-- 근데 이거 지루해서 만들어도 누가 동영상 볼까 몰라.

require "player"
require "fox"

function love.load()
	-- 이 부분에서는 여러가지를 로딩하고 초기화합니다. 게임의 시작인 셈이죠.
	--우리가 만든 이미지를 로드합시다.
	
	imgtile = love.graphics.newImage("graphics/tile.png")
	imgchick = love.graphics.newImage("graphics/chick.png")
	imgchick_dead = love.graphics.newImage("graphics/chick_dead.png")
	imgchick_smile = love.graphics.newImage("graphics/chick_smile.png")
	imgfox = love.graphics.newImage("graphics/fox.png")
	imgfox_bam = love.graphics.newImage("graphics/fox_dead.png")
	
	--이미지를 모두 로드했습니다. 이제 병아리와 여우를 만들고 초기화시켜 봅시다.
	--앞으로 병아리는 편의상 player라고 칭합니다.
	
	player.load() --플레이어를 초기화한다.
	fox.load() --여우들을 초기화한다.
	
	fontcms = love.graphics.newFont("graphics/comic.ttf", 12) --폰트 초기화
	
	--그냥 글로벌 변수들
	turns = 0 --몇 턴 경과했는가?
end

function love.keypressed(key)
	-- 이 부분에서는 키가 입력되었을 때의 처리를 합니다.
	--플레이어를 움직이는 처리.
	
	--화면을 벗어나는지의 처리는 여기서 하겠다!
	if player.state == "live" then --플레이어가 살아있을때만 움직일 수 있다.
		if key == "left" then
			if not (player.x == 0) then
				player.move("left")
				fox.update() --플레이어가 한번 움직이면 여우들도 한번씩 움직인다.
			end
		elseif key == "right" then
			if not (player.x == 19) then
				player.move("right")
				fox.update() --플레이어가 한번 움직이면 여우들도 한번씩 움직인다.
			end
		elseif key == "up" then
			if not (player.y == 0) then
				player.move("up")
				fox.update() --플레이어가 한번 움직이면 여우들도 한번씩 움직인다.
			end
		elseif key == "down" then
			if not (player.y == 19) then
				player.move("down")
				fox.update() --플레이어가 한번 움직이면 여우들도 한번씩 움직인다.
			end
		elseif key == "return" then
			if not (player.teleportchance == 0) then
				player.teleportchance = player.teleportchance - 1
				player.teleport()
			end
		end
	end
end

function love.draw()
	--이 부분에서는 그리는 처리를 합니다.
	--타일을 그리는 처리
	local a, b
	love.graphics.setColor(255, 255, 255) --글씨를 하얀색으로 쓰기 위해서...
	
	for a = 1, 20 do
		for b = 1, 20 do
			love.graphics.draw(imgtile, (a - 1) * 16, (b - 1) * 16)
		end
	end
	
	--여우를 그리는 처리
	fox.draw()
	
	--플레이어를 그리는 처리
	player.draw()
	
	--인터페이스 내 글씨를 쓰자.
	love.graphics.setFont(fontcms)
	if player.state == "live" then
		love.graphics.print("Turns passed: "..turns, 3, 320)
		love.graphics.print("Fox left: "..fox.count, 3, 336)
		love.graphics.print("Teleports left: "..player.teleportchance, 3, 352)
	elseif player.state == "dead" then
		love.graphics.print("You lose...", 3, 320)
		love.graphics.print("Turns passed: "..turns, 3, 336)
	elseif player.state == "win" then
		love.graphics.print("You win!", 3, 320)
		love.graphics.print("Turns passed: "..turns, 3, 336)
	end
	
end