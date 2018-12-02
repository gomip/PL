// PL_test.cpp: 콘솔 응용 프로그램의 진입점을 정의합니다.
//

#include "stdafx.h"
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

void Generate(int* arr,const char* fileName);
void init_board();
int board[10] = { ' ',' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '};
int check_win(); //check game state 1 = win -1 = draw 0 = none

int main()
{
	int value1[9]; 
	int checkRepeat=0; //to avoid repeat in random variable
	char p; //check player 
	int finish; // check game state

	srand(time(NULL));

	init_board();

	int turn=rand()%2+1;

	if (turn == 1) {
		printf("A goes first\n");
		p = 'O';
	}
	else {
		printf("B goes first\n");
		p = 'X';
	}
	printf("\n======= List ======\n");
	for (int i = 0; i < 9; i++) {
		value1[i] = rand() % 9 + 1;
		for (int j = 0; j < i; j++) {
			if (value1[i] == value1[j]) {
				i--;
				break;
			}
		}
	}
	for (int i = 0; i < 9; i++) {
		printf("A [%d] = %d\n", i+1, value1[i]);
	}

	Generate(value1, "move.txt");

	finish = check_win();

	if (finish == -1) {
		printf("draw\n");
	}
	else if (finish==1){
		if (p == 'O') {
			printf("A win\n");
		}
		else {
			printf("B win\n");
		}
	}
	else {
		printf("\n");
	}
    return 0;
}


void Generate(int* arr,const char* fileName) {
	FILE *fp;
	fopen_s(&fp, fileName, "wt");
	for (int i = 0; i < 9; i++) {
		fprintf(fp, "[%d] = %d\n", i, arr[i]);
	}
}

void init_board() {
	printf("\n====Board====\n");
	printf("-------------\n");
	printf("| %c │ %c │ %c │\n",board[1],board[2] ,board[3] );
	printf("-------------\n");
	printf("| %c │ %c │ %c │\n", board[4], board[5], board[6]);
	printf("-------------\n");
	printf("| %c │ %c │ %c │\n", board[7], board[8], board[9]);
	printf("-------------\n");
}

int check_win() {
	int i;
	//horizontal and vertical
	if (board[1] == board[2] && board[2] == board[3] && board[1]!=' ') {
		return 1;
	}
	else if (board[4] == board[5] && board[5] == board[6] && board[4] != ' ') {
		return 1;
	}
	else if (board[7] == board[8] && board[8] == board[9] && board[7] != ' ') {
		return 1;
	}
	else if (board[1] == board[4] && board[4] == board[7] && board[1] != ' ') {
		return 1;
	}
	else if (board[2] == board[5] && board[5] == board[8] && board[2] != ' ') {
		return 1;
	}
	else if (board[3] == board[6] && board[6] == board[9] && board[3] != ' ') {
		return 1;
	}
	else if (board[1] == board[5] && board[5] == board[9] && board[1] != ' ') {
		return 1;
	}
	else if (board[3] == board[5] && board[5] == board[7] && board[3] != ' ') {
		return 1;
	}
	else if (board[1] != ' '&&board[2] != ' '&&board[3] != ' '&&board[4] != ' '&&board[5] != ' '&&board[6] != ' '&&board[7] != ' '&&board[8] != ' '&&board[9] != ' ') {
		return -1;
	}
	else {
		return 0;
	}
}
