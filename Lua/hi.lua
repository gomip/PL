print("Major : Informatics\n")
print("Id : 2014210069\n")
print("Name : Kim jung hoon\n")
print("Topic : generate random integer and write it to text file\n")
print("        after create text file, read that file and fill in the tictactoe board\n")

math.randomseed(os.time()) --���� ������ ���� �۾�

local val={1,2,3,4,5,6,7,8,9}
local board={" "," "," "," "," "," "," "," "," "}
local p="O"

--[[
���Ӱ�� �Ǵ��� ���� �Լ�
1 -> A Ȥ�� B ��
-1 -> ���º�
0 -> ����������
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

--�ؽ�Ʈ ���� ����
function Generate(val)
	local file=io.open("test.txt","w")
	for i=1,9 do
		file:write(val[i],"\n") --���Ƿ� ������ ������ ������ �ִ� val[i]�� test.txt���� �ȿ� ����
	end
	file:close()
end

--�ؽ�Ʈ ���� �ҷ��ͼ� �����ǿ� �׸���
function ReadFile()
	local finish=0 --���Ӱ���� Ȯ���ϱ� ���� ����
	local integer_val --�⺻������ �ؽ�Ʈ ���Ϸ� �ҷ����϶� string���� ����Ǳ� ������ �� ������ integer �������� �ٲ㼭 �����ϱ� ���� ����
	print("\n====Read====\n")
	print("A goes first\n")
	filename="test.txt"
	file1=assert(io.open(filename,"r")) --���� �о���̱�. assert�� ������ �ҷ��鿴�� �� error�� �߻��ߴ��� ���ߴ��� �ٷ�� ���� ��. error �߻��� ������ ������ش�
	for i=1,9 do
		rFile=file1:read() --rfile�̶�� ������ �ҷ����� �ؽ�Ʈ���� �������� ����
		integer_val=tonumber(rFile) --tonumber�� ���� integer�� ����
		if finish==0 then
			if i%2~=0 then --i���� �������� ���� i�� Ȧ����°�� O�� ��� �ƴϸ� X�� �ش��ǿ� ����
				print("Move ["..i.."]="..integer_val)
				p="O"
				board[integer_val]=p
			else
				print("Move ["..i.."]="..integer_val)
				p="X"
				board[integer_val]=p
			end
		end
		finish=checkWin() --���� ���൵ Ȯ��.
	end
	checkState(finish) --����� Ȯ��

end

function drawBoard() --������ �׸���
	print("\n====Board====\n")
	print("-------------")
	print("| "..board[1].." �� "..board[2].." �� "..board[3].." ��")
	print("-------------")
	print("| "..board[4].." �� "..board[5].." �� "..board[6].." ��")
	print("-------------")
	print("| "..board[7].." �� "..board[8].." �� "..board[9].." ��")
	print("-------------")
end

--[[
��� ���� �Լ�
���� 3�� ���� 3�� �밢 2��
return 1 = ��
return -1 = ���º�
return 0 = ���� ����
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

--�����Լ� ���� �۾��� �Ʒ��� ����
print("\n====List====\n")

--[[
������ ������ �����ϴ� �۾�
������ �ʱ�ȭ�� val�̶�� �迭���� 9������ ������ �����ϴµ� ���̺� �ȿ� �ִ� �ΰ��� ������ ��� �ڸ��� �ٲ����μ� ���� ���� ���� ���ϵ��� ����
]]
for i=1,9 do
	local j=math.random(1,9)
	local k=math.random(1,9)
	val[j],val[k]=val[k],val[j]
end

for i=1,9 do
	print("Move ["..i.."]="..val[i]) --val�� ���
end

Generate(val)
ReadFile()
drawBoard()
checkWin()
