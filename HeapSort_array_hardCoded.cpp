// ============================================================================
// File: main.cpp (Spring 2015)
// ============================================================================
// This is a test driver for the CHeap class.
// ============================================================================
// Output:
//      Remove some items:
//      intVal = 20                                    - 20-
//      intVal = 20                        -  20 -                    -12-
//      intVal = 12                 -12-              -7          7           5
//      intVal = 12           5           4       4
//      intVal = 7
//      intVal = 7
//      intVal = 5
//      intVal = 5
//      intVal = 4
//      intVal = 4
//      Error removing heap value...
//      Error removing heap value...
//      Error removing heap value...
// ============================================================================

#include    <iostream>
#include    <cstdlib>
using namespace std;
#include    "CHeap.h"


// ==== main ==================================================================
//
// ============================================================================

int     main(void)
{
    CHeap<int>      myHeap;       // CHeap Object that houses array of ints with max val and numItems
    int             heapInts[] = { 5, 20, 4, 12, 7, 5, 20, 4, 12, 7 };
    unsigned int    index;
    int             intVal;
    
    // insert some values into the heap
    // no additional +3 added as the one below so no errors should occur
    // in this hard coded program
    for (index = 0; index < (sizeof(heapInts) / sizeof(*heapInts)); ++index)
    {
        try {
                myHeap.InsertItem(heapInts[index]);
            }
        catch (CHeapEx&) // works since it's an unnamed marked place in memory
            {
                cerr << "Error inserting " << heapInts[index] << endl;
                exit(EXIT_FAILURE);
            }
    }
    
    // try removing some items (we loop a few extra times here to try out the
    // exception handling [i.e the +3 in the checker])
    cout << "Remove some items: " << endl;
    for (index = 0; index < (sizeof(heapInts) / sizeof(*heapInts)) + 3; ++index)
    {
        try {
                myHeap.RemoveItem(intVal);
                cout << "intVal = " << intVal << endl;
            }
        catch (CHeapEx&)
            {
                cerr << "Error removing heap value..." << endl;
            }
    }
    
    return (EXIT_SUCCESS);
    
}  // end of "main"