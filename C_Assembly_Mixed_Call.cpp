// ==================================================================
//
// Program: C_Assembly_Mixed_Call
// Programmer: Johnathan Soto
// Language: C++
// Date: May 19, 2015
// Professor: Zoulu Ding
// Description: Have calls from C++ to Assembly and vise versa.
//
// Last edited: ?
//
// ===================================================================

#include <iostream>
using namespace std;

extern "C" bool isPrimeASM( int n );

// ==============================================================
extern "C"
{
    extern "C" bool isPrimeASM( int n );
    
    int intSqrt(int squareN);
}

// ==================================================================
int main (void)
{

    int input;
    
    while (1)
    {
        cout << "Enter an integer (-1 to exit): ";
        cin >> input;
        
        if (input == -1)
        {
            break;
        }
        
        if (isPrimeASM(input))
        {
            cout << "the number is prime\n";
        }
        else
        {
            cout << "the number is NOT prime\n";
        }
        
        
    }
    
    
    return 0;
}

int intSqrt(int n)
{
    return (int)sqrt((float)n);
} // end of intSqrt

