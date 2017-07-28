// ============================================================================
// File: CHeap.h (Spring 2015)
// ============================================================================
// Header file for the CHeap class.
// Will be using the CSimpleList code to organize this program
// ============================================================================

#ifndef CHEAP_HEADER
#define CHEAP_HEADER

#include    "CSimpleList.h"

struct  CHeapEx
{
};


const   int     DEFAULT_HEAP_ITEMS = DEFAULT_NUM_ITEMS;
enum    HeapType { MAX_HEAP, MIN_HEAP };

template    <typename  HeapItemType>
class   CHeap : private CSimpleList<HeapItemType>
{
    // Gets the stuff from CSimple privately (must use functions to access prvate members)
    public:
    // constructors and destructor
    CHeap(HeapType  heapType = MAX_HEAP, int  numItems = DEFAULT_HEAP_ITEMS)
                                        : CSimpleList<HeapItemType>(numItems) // Init a ListType with HeapType and with 
                                        , m_heapType(heapType) {}
    virtual ~CHeap() { DestroyHeap(); }
    
    // member functions
    void    DestroyHeap() { CSimpleList<HeapItemType>::DestroyList(); }
    void    InsertItem(const HeapItemType  &newItem);   // Will call the CSimple version and will pass over newItem
    bool    IsHeapEmpty() { return  CSimpleList<HeapItemType>::IsEmpty(); }
    bool    IsHeapFull() { return  CSimpleList<HeapItemType>::IsListFull(); }
    void    RemoveItem(HeapItemType  &item);   // Will Call the Csimple version to the specific Item
    
    private:
    // data members
    HeapType    m_heapType;  // Type of Heap: Max or Min Heap
    
    // member functions
    void    RebuildHeap(int  rootIndex);  
};

#include    "CHeap.cpp"

#endif  // CHEAP_HEADER