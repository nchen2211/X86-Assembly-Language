//;   Program: Project 4_ Integer Square Root Estimate
//;   Author: Noreen Chrysilla & Lynne Tien
//;   Class: CSCI 150
//;   Date: Due on 6/3/2015
//;   Description: Implement Newton-Raphson method to estimate unsigned int root based on 
//;				 a list of integer entered by the user. Implement a macro that resembles setw c++ instruction.
//;				 Print the int and root list as a two column table.
//
//;   I certify that the code below is my own work.
//;	
//;	Exception(s): N/A

#include<iostream>
#include <iomanip>
using namespace std;

int sqrtEstimation (int, int, int);
void userInput();
void Print(int);
int originalVal = 0;
int arrayInput[20] = {0};
int squareRoot[20] = {0};

void userInput()
{
	cout<<"Input a list of integer. Press -1 to end the list of integer.\n"<<
		"The following table is the integer list and its corresponding root estimation."<<endl;
	int i = 0;
	int count = 0;

	while(arrayInput[i] != -1)
	{
		cin>>arrayInput[i];
		squareRoot[i] = sqrtEstimation(arrayInput[i], 0, 0);
		count++;
	}

	Print(count);
}

int sqrtEstimation (int x, int y, int root)
{
	if(y == 0)
	{
		y = x / 2;
		originalVal = x;
	}

	if(x - y == 0 || x - y == 1) //base case of this recursion
	{
		root = y;
		return root;
	}
	else
	{
		x = y;
		y = (originalVal / y + y) / 2;
		return sqrtEstimation (x, y, root);
	}
}

void Print(int size)
{
	int  i = 0;
	while(i <= size)
		cout<<right<<arrayInput[i]<<setw(9)<<squareRoot[i]<<endl;
}
		

