print("====Info====\n")
print("학과 : 컴퓨터학과\n")
print("학번 : 2014210069\n")
print("이름 : 김정훈\n")
print("주제 : 난수를 생성해 파일을 만들고 그 파일을 불러들여 tictactoe 수행\n")

math.randomseed(os.time()) --난수 생성을 위한 작업

local val={1,2,3,4,5,6,7,8,9}
local board={" "," "," "," "," "," "," "," "," "}
local p="O"

--[[
게임결과 판단을 위한 함수
1 -> A 혹은 B 승
-1 -> 무승부
0 -> 게임진행중
]]
function checkState(finish)
	print("\n====Result====\n")
	if (finish==-1) then
		print("Draw")
	elseif (finish==1) then
		if p=="O" then
			print("A win")
		else print("B win")
		end
	else
		print("\n")
	end
end

--텍스트 파일 생성
function Generate(val)
	local file=io.open("Move_Lua.txt","w")
	for i=1,9 do
		file:write(val[i],"\n") --임의로 생성된 난수를 가지고 있는 val[i]를 test.txt파일 안에 저장
	end
	file:close()
end

--텍스트 파일 불러와서 게임판에 그리기
function ReadFile()
	local finish=0 --게임결과를 확인하기 위한 변수
	local integer_val --기본적으로 텍스트 파일로 불러들일때 string으로 저장되기 때문에 그 값들을 integer 형식으로 바꿔서 저장하기 위한 변수
	print("\n====Read====\n")
	print("A goes first\n")
	filename="Move_Lua.txt"
	file1=assert(io.open(filename,"r")) --파일 읽어들이기. assert는 파일을 불러들였을 때 error가 발생했는지 안했는지 다루기 위한 것. error 발생시 사유를 출력해준다
	for i=1,9 do
		rFile=file1:read() --rfile이라는 변수에 불러들인 텍스트파일 한줄한줄 저장
		integer_val=tonumber(rFile) --tonumber를 통해 integer로 저장
		if finish==0 then
			if i%2~=0 then --i값을 기준으로 만약 i가 홀수번째면 O을 출력 아니면 X를 해당판에 저장
				print("Move A["..i.."]="..integer_val)
				p="O"
				board[integer_val]=p
			else
				print("Move B["..i.."]="..integer_val)
				p="X"
				board[integer_val]=p
			end
		end
		finish=checkWin() --게임 진행도 확인.
	end
	checkState(finish) --결과값 확인

end

function drawBoard() --게임판 그리기
	print("\n====Board====\n")
	print("-------------")
	print("| "..board[1].." │ "..board[2].." │ "..board[3].." │")
	print("-------------")
	print("| "..board[4].." │ "..board[5].." │ "..board[6].." │")
	print("-------------")
	print("| "..board[7].." │ "..board[8].." │ "..board[9].." │")
	print("-------------")
end

--[[
결과 판정 함수
가로 3줄 세로 3줄 대각 2줄
return 1 = 승
return -1 = 무승부
return 0 = 게임 진행
]]
function checkWin()
	if board[1]==board[2] and board[2]==board[3] and board[1]~=" "then
		return 1
	elseif board[4]==board[5] and board[5]==board[6] and board[4]~=" "then
		return 1
	elseif board[7]==board[8] and board[8]==board[9] and board[7]~=" "then
		return 1
	elseif board[1]==board[4] and board[4]==board[7] and board[1]~=" "then
		return 1
	elseif board[2]==board[5] and board[5]==board[8] and board[2]~=" "then
		return 1
	elseif board[3]==board[6] and board[6]==board[9] and board[3]~=" "then
		return 1
	elseif board[1]==board[5] and board[5]==board[9] and board[1]~=" "then
		return 1
	elseif board[3]==board[5] and board[5]==board[7] and board[3]~=" "then
		return 1
	elseif board[1]~=" " and board[2]~=" " and board[3]~=" " and board[4]~=" " and board[5]~=" " and board[6]~=" " and board[7]~=" " and board[8]~=" " and board[9]~=" " then
		return -1
	else return 0
	end
end

--메인함수 같은 작업을 아래서 수행
print("\n====List====\n")

--[[
임의의 난수를 생성하는 작업
위에서 초기화한 val이라는 배열값에 9번동안 난수를 생성하는데 테이블 안에 있는 두개의 값들이 계속 자리를 바꿈으로서 같은 값을 갖지 못하도록 방지
]]
for i=1,9 do
	local j=math.random(1,9)
	local k=math.random(1,9)
	val[j],val[k]=val[k],val[j]
end

for i=1,9 do
	print("Move ["..i.."]="..val[i]) --val값 출력
end

Generate(val)
ReadFile()
drawBoard()
checkWin()
