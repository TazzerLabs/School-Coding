// ==================================================================
//
// Program: Inline_Assembly_Prime_Check
// Programmer: Johnathan Soto
// Language: C++
// Date: May 14, 2015
// Professor: Zoulu Ding
// Description: Just practicing asm in c++ programming with a prime
//              checker.
//
// Last edited: 5/14/2015 3:33 pm
//
// ===================================================================

#include <iostream>
using namespace std;


// ==== isPrime C++ version ============================================
//
// Input:                   -n = an integer to check if prime
//
// Output:                  -bool value of true or false to see if the
//                           integer is a prime (true == Prime else not)
//
// Description: just have the integer get checked through the numeral
//              list inorder to find if the integer is a PRIME.
//
// ======================================================================

bool isPrimeC(int n)
{
    
    if (n < 2)
    {
        return false;
    }
    
    for (int divisor = 2; divisor <= n / 2; divisor++)
    {
        if ( n % divisor == 0 )
        return false;
    }
    return true;
} // end of isPrime C++ version



// ==== inLine asm version1 =============================================
//
// Input:                   -n = an integer to check if prime
//
// Output:                  -bool value of true or false to see if the
//                           integer is a prime (true == Prime else not)
//
// Description: just have the integer get checked through the numeral
//              list inorder to find if the integer is a PRIME. In
//              addition to using asm code to make the program faster.
//
// ======================================================================

bool isPrimeC_inlineASM(int n)
{
    __asm
    {
        
        ; TRUE  = 1
        ; FALSE = 0
        
        ; if (n < 2)
        
        mov ecx, 0
        
        mov eax, n
        cmp eax, 2
        jl FuncEnd
        
        
        ; fill is prime logic here...
        mov ebx, 1
        mov ecx, 1
        
        ;for (int divisor = 2; divisor <= n / 2; divisor++)
        
        mov esi, n
        sar esi, 1                      ; esi = (n / 2)
            
       FOR:
        
        inc ebx
            
        cmp ebx, esi
        jg FuncEnd
            
        ;if ( n % divisor == 0 )
        xor edx, edx
        mov eax, n
        div ebx                        ; Get the remainder from div and store in edx
            
        cmp edx, 0                      ; edx is the (n % divisor)
        jne FOR
        mov ecx, 0
        jmp FuncEnd
        
      FuncEnd:
        
        ; The return is stored in eax
        mov eax, ecx
        
    } // asm
    
} // end of isPrime asm version1

// ==== inLine asm version2 =============================================
//
// Input:                   -n = an integer to check if prime
//
// Output:                  -bool value of true or false to see if the
//                           integer is a prime (true == Prime else not)
//
// Description: just have the integer get checked through the numeral
//              list inorder to find if the integer is a PRIME. In
//              addition to using asm code to make the program faster,
//              however also have C++ code for a for loop.
//
// ======================================================================

bool isPrimeC_inlineASM2(int n)
{
    bool isPrime = true;
    
    if (n < 2)
    {
        return false;
    }
    
    for (int divisor = 2; divisor <= n / 2; divisor++)
    {
        __asm
        {
            ; fill is prime checking here...
            
            mov eax, n
            div divisor

            cmp edx, 0
            jne NFal
            mov eax, 0
            mov isPrime, al
            
          NFal:
            
        } // asm
        
        if (!isPrime)
        break;
    }
    return isPrime;
} // end of isPrime asm version2


 
// ==== MAIN ============================================================
//
// Input: Nothing
//
// OutPut: a text to the string indicating if the value the user enters
//         within this program is a prime or not (only integers)
//
// Description: Just a driver function that will test the C++ isPrime,
//              C++ isPrime w/ asm for body, and isPrime w/ as with for
//              loop and asm body within it.
//
// ======================================================================
int main(void)
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
        
        if (isPrimeC(input))
        {
            cout << "the number is prime\n";
        }
        else
        {
            cout << "the number is NOT prime\n";
        }
        
        
    }


    return 0;

} // end of main














