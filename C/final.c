#include "stdafx.h"
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

void Generate(int* arr, const char* fileName);
int read_file(const char* fileName);
void init_board();
char board[10] = { ' ',' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' };
int check_win(); //check game state 1 = win -1 = draw 0 = none
int state;
void check_state(int finish);

char p; //check player 

int main()
{
	int value1[9];
	int checkRepeat = 0; //to avoid repeat in random variable
	int finish=0; // check game state

	srand(time(NULL));

	init_board();


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
		printf("Move [%d] = %d\n", i + 1, value1[i]);
	}

	Generate(value1, "move.txt");
	read_file("move.txt");
	init_board();
	//finish = check_win();

	return 0;
}


void Generate(int* arr, const char* fileName) {
	FILE *fp;
	fopen_s(&fp, fileName, "w");
	for (int i = 0; i < 9; i++) {
		//fprintf(fp, "Move [%d] = %d\n", i+1, arr[i]);
		fprintf(fp, "%d\n", arr[i]);
	}
	fclose(fp);
}

int read_file(const char* fileName) {
	FILE *fp2;
	int finish=0;
	char line[9];
	fopen_s(&fp2, fileName, "r");
	int i;

	printf("\nFile name : %s\n", fileName);

	if (fp2 == NULL) {
		printf("error\n");
		return 1;
	}

	/*
	while (fgets(line, 100, fp2) != NULL) {
	printf("%s", line);
	}
	*/

	printf("A goes first\n");

	for (i = 0; i < 9; i++) {
		fgets(line, 9, fp2);
		//printf("%s", line);
		int x = atoi(line);
		if (finish == 0) {
			if (i % 2 == 0) {
				printf("A : %s", line);
				p = 'O';
				board[x] = p;
			}
			else {
				printf("B : %s", line);
				p = 'X';
				board[x] = p;
			}
		}
		finish = check_win();
	}
	check_state(finish);

	printf("\n");

	fclose(fp2);
	return 0;
}

void init_board() {
	printf("\n====Board====\n");
	printf("-------------\n");
	printf("| %c │ %c │ %c │\n", board[1], board[2], board[3]);
	printf("-------------\n");
	printf("| %c │ %c │ %c │\n", board[4], board[5], board[6]);
	printf("-------------\n");
	printf("| %c │ %c │ %c │\n", board[7], board[8], board[9]);
	printf("-------------\n");
}

int check_win() {
	//horizontal and vertical
	if (board[1] == board[2] && board[2] == board[3] && board[1] != ' ') {
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

void check_state(int finish) {
	printf("====================\n");
	if (finish == -1) {
		printf("\ndraw\n");
	}
	else if (finish == 1) {
		if (p == 'O') {
			printf("\nA win");
		}
		else {
			printf("\nB win");
		}
	}
	else {
		printf("\n");
	}
}
