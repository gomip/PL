package main

import (
	"bufio"
	"fmt"       //printf와 scanf같은 작업을 수행하기 위한것
	"math/rand" //고정된 난수 시퀀스를 반환한다.
	"os"
	"strconv" //string to int 작업을 수행해주는 atoi 포함
	"time"
)

var board = [10]string{" ", " ", " ", " ", " ", " ", " ", " ", " ", " "}

var p = " "

/*난수 생성을 하기 위한 함수*/
func randomInt(min int, max int) int {
	return min + rand.Intn(max-min)
}

func main() {
	fmt.Printf("\n======Info======\n")
	fmt.Printf("\n학과 : 컴퓨터학과\n")
	fmt.Printf("\n학번 : 2014210069\n")
	fmt.Printf("\n이름 : 김정훈\n")
	fmt.Printf("\n주제 : 난수를 생성해 파일을 만들고 그 파일을 불러들여 tictactoe 수행")

	var val [10]int
	rand.Seed(time.Now().UnixNano()) //덜 결정적인 시퀀스를 얻기 위해 현재 시간을 시드로 사용

	/*1부터 9까지 중복없이 난수 생성*/
	fmt.Printf("\n======Write======\n")
	for i := 0; i < 9; i++ {
		val[i] = randomInt(1, 10)
		for j := 0; j < i; j++ {
			if val[i] == val[j] { //중복확인
				i--
				break
			}
		}
	}
	for i := 0; i < 9; i++ {
		fmt.Printf("Move [%d] = %d\n", i+1, val[i])
	}

	GenerateText(val) //생성한 난수를 텍스트 파일로 저장
	ReadText()        //생성된 텍스트 파일을 읽어오기
	InitBoard()       //게임보드 불러오기
}

func GenerateText(val [10]int) {
	createFile, _ := os.Create("move.txt") //createFile이라는 변수로 os에 포함된 create함수를 이용해 파일 출력 작업 수행
	defer createFile.Close()               //main함수가 끝나기 직전에 파일 닫음
	for i := 0; i < 9; i++ {
		fmt.Fprintln(createFile, val[i]) //val[i]에 난수들을 저장하여 그 값들을 create_file에 전달해서 text 파일에 저장하도록
	}
}

func check(e error) {
	if e != nil {
		panic(e)
	}
} // 파일 읽기전 에러 체크 수행

func ReadText() {
	//i := 0
	finish := 0 //게임이 끝났는지 아닌지 판별하기 위한 변수
	count := 0  //차례를 정하기 위한 변수 (짝수 - A , 홀수 -B)

	rFile, _ := os.Open("move.txt")    //os.open을 통해 텍스트파일 읽어들여 rFile에 저장
	defer rFile.Close()                //main 함수가 끝나기 직전에 파일 닫는다.
	scanner := bufio.NewScanner(rFile) //읽어들인 텍스트파일 스캔
	scanner.Split(bufio.ScanLines)     //텍스트파일을 한줄한줄 읽기 위한 작업

	fmt.Println("\n======Read======")
	for scanner.Scan() {
		mark := 0                              //현재 어느위치에 둬야하는지 분별하기 위한 변수.
		mark, _ = strconv.Atoi(scanner.Text()) //텍스트에서 읽어온 string 값을 int값으로 변환해서 mark라는 변수에 저장
		if finish == 0 {
			if count%2 == 0 { //짝수면 A 수행, A는 O를 판에 그린다
				fmt.Printf("Move A[%d] : %s\n", count+1, scanner.Text())
				p = "O"
				fmt.Printf("p : %s\n", p)
				fmt.Printf("mark : %d\n", mark)
				board[mark] = p
			} else { //홀수면 B 수행, B는 X를 판에 그린다
				fmt.Printf("Move B[%d] : %s\n", count+1, scanner.Text())
				p = "X"
				fmt.Printf("p : %s\n", p)
				fmt.Printf("mark : %d\n", mark)
				board[mark] = p
			}
		}
		finish = CheckWin() //한번 수행할때마다 게임판이 끝났는지 아닌지 판별
		count++
	}
	checkState(finish) //게임이 끝났다면 승패무 판단
	fmt.Printf("\n")
}

func InitBoard() { //게임보드 생성
	fmt.Printf("====Board====\n")
	fmt.Printf("-------------\n")
	fmt.Printf("| %s │ %s │ %s │\n", board[1], board[2], board[3])
	fmt.Printf("-------------\n")
	fmt.Printf("| %s │ %s │ %s │\n", board[4], board[5], board[6])
	fmt.Printf("-------------\n")
	fmt.Printf("| %s │ %s │ %s │\n", board[7], board[8], board[9])
	fmt.Printf("-------------\n")
}

func CheckWin() int { //게임 승리 조건, (리턴 1 -> 승, 리턴 -1 -> 무, 리턴 0 ->계속 수행)
	if board[1] == board[2] && board[2] == board[3] && board[1] != " " {
		return 1
	} else if board[4] == board[5] && board[5] == board[6] && board[4] != " " {
		return 1
	} else if board[7] == board[8] && board[8] == board[9] && board[7] != " " {
		return 1
	} else if board[1] == board[4] && board[4] == board[7] && board[1] != " " {
		return 1
	} else if board[2] == board[5] && board[5] == board[8] && board[2] != " " {
		return 1
	} else if board[3] == board[6] && board[6] == board[9] && board[3] != " " {
		return 1
	} else if board[1] == board[5] && board[5] == board[9] && board[1] != " " {
		return 1
	} else if board[3] == board[5] && board[5] == board[7] && board[3] != " " {
		return 1
	} else if board[1] != " " && board[2] != " " && board[3] != " " && board[4] != " " && board[5] != " " && board[6] != " " && board[7] != " " && board[8] != " " && board[9] != " " {
		return -1
	} else {
		return 0
	}
}

func checkState(finish int) { //게임 결과 출력
	fmt.Printf("\n====Result====\n")
	if finish == -1 {
		fmt.Printf("Draw\n")
	} else if finish == 1 {
		if p == "O" {
			fmt.Printf("\nA win\n")
		} else {
			fmt.Printf("\nB Win\n")
		}
	} else {
		fmt.Printf("\n")
	}
}
