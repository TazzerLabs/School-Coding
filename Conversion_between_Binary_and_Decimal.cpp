// ============================================================================
// Programmer: Johnathan Soto
// Language: C++
// Date: 1/31/2015
// Description: A Binary to Decimal conversion program that can be worked from
//              Decimals to Binary and vice versa.  A menu will appear at the 
//				start of the program such as to ask for a Binary to Decimal 
//				conversion or for the opposite version, also an exit option 
//				will be given.  Program will cease to execute when user chooses
//				to quit.  Seg fault occurs at DecToBinary due to memory 
//				cannot finsih assignment fully due to time so homework is not
//				completed.
//
// ============================================================================

#include <iostream>
#include <string.h>
using namespace std;

// ============================================================================
// Function:	BinToDec
// Description:	This function converts an 8-bit binary integer to its decimal
// Parameter:   s [IN] -- a C-string with 8-bit binary digits received
// Return:      A decimal integer value calculated from s
// ============================================================================
int BinToDec(char* s);

// ============================================================================
// Function:	DecToBin
// Description:	This function converts a decimal integer to its binary bits
// Parameter:   n [IN] -- a decimal integer received, less than 256
// Return:      A C-string with 8-bit binary digits calculated from n
// ============================================================================
char* DecToBin(int n);

int main(void)
{
	//cout << "Hello World!\n";
	//system("pause");  To pause program

	int exit = 1;
	char* DResult[9dw];
	char binary[9];
	int choice;
	int BResult;
	int decimal;
	int index = 0;
	int sign = 1;

	while (exit)
	{
		cout << ">>> Please select the conversion type:\n";
		cout << "1. Binary to Decimal\n"; 
		cout << "2. Decimal to Binary\n";
		cout << "3. Exit";
		cout << "---------------------------------------\n";
		cout << "Enter your choice: ";
		cin >> choice;

		// =============================================================================
		// Case 1: Binary selection
		// Case 2: Decimal selection
		// Case 3 (default): Exit function to terminate program
		// =============================================================================
		switch (choice)
		{

		case 1:

			while (true)
			{
				cout << "Please Enter 8-bit binary digits (e.g., 11110000): ";
				scanf("%s", binary);
				//CHECKER FOR LENGTH OF STRING HERE
				if ((strlen(binary) > 9))
				{
					cout << "Binary isn't a 8-bit...\n";
				}
				else
				{
					break;
				}
				//String is a NULL
				if (binary == NULL)
				{
					return 0;
				}


			}
			
				strcpy(BResult, BinToDec(binary));

				cout << "The decimal integer of " << binary << " is " << BResult << endl;
				break;

		case 2:

			while (true)
			{
				cout << "Please Enter a decimal integer less than 256: ";
				cin >> decimal;

				if (decimal > 256)
				{
					cout << "Integer is bigger than 256...\n";
				}
				else
				{
					break;
				}
			}

			DResult = DecToBin(decimal);
			cout << "The binary of " << decimal << " is " << DResult << endl;
			delete[] *DResult;
			break;

		default:
			exit = 0;
			break;
		}//end of switch
		
	}//end of while

	cout << "Bye...\n";
	return 0;
}//end of main

// ============================================================================
// Function:	BinToDec
// Description:	This function converts an 8-bit binary integer to its decimal
// Parameter:   s [IN] -- a C-string with 8-bit binary digits received
// Return:      A decimal integer value calculated from s
// ============================================================================
int BinToDec(char* s)
{
	
	int result = 0, pow = 1;

	for (int index = ((unsigned)strlen(s))-1; index >= 0; --index, pow <<= 1)
		result += (s[index] - '0') * pow;

	return result;
}

// ============================================================================
// Function:	DecToBin
// Description:	This function converts a decimal integer to its binary bits
// Parameter:   n [IN] -- a decimal integer received, less than 256
// Return:      A C-string with 8-bit binary digits calculated from n
// ============================================================================
char* DecToBin(int n)
{

	char    *binary = new char[9];
	int index;
	binary[8] = 0;

	//Fills the dynamic array with 0's
	for (index = 0; index < 7; ++index)       
	{
		binary[index] = '0';
	}

	//Fills the array with the binary conversion
	for (index = 0; index < 8; index++)            
	{
		if (n % 2)
			binary[7 - index] = '1';
		else
			binary[7 - index] = '0';
		if (n / 2 == 0)
			break;
		n /= 2;
	}

	return binary;

}