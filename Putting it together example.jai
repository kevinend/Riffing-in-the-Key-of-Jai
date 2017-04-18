// Jai Stack Example 
// Note: This is not an accurate implementation. I just want to see what this would look like with the baked_values to see if it actually
//       would help with minimizing memory related errors
//       Also, the syntax is not fixed, so even when JAI is released this may look totally different

Stack :: struct (Elem_Type: type) {

    data: *Elem_Type;
   
    count: int = 0;         
    capacity: int = 8;
    
    allocator: Allocator = null;        // use global malloc for allocations   
    allocator_data: *void = null;
    
};


push :: ( element: T.Elem_Type, stack: *T/Stack, $$ owned: bool = false ) -> () {

    if is_full( stack ) {
        reallocate();
    }
    else {
        stack.data[stack.count] = element;
        count += 1;
    }
    
    return;
}

pop :: ( stack: *T/Stack, $$ owned: bool = false ) -> T.Elem_Type, bool {

    if is_empty( stack ) {
        return null, false;
    }
    else {
        retval := stack[stack.count];
        stack.count -= 1;
        return retval, true;
    }
}

// These are the two common functions on a stack. If the values being pushed and popped are copy types then we don't have to worry
// about the ownership semantics at all. However, if the elem_type is a pointer to owned data on the heap, when we pop 
// we need to make sure to free

// The way you could remember this is by baking versions of these at the top level of your program. Something like the following:

owned_push :: #bake_values push( owned = true );
owned_pop  :: #bake_values pop( owned = true );

// now for your function calls on your owning type you must call `owned_push` and `owned_pop` which doesn't really provide too much 
// benefit here, other than to remind you that the stacks contain owned data. In the case of 
// pop it may help you remember to free the data returned if you no longer need it.

/**** A better example of the basic principle would be inserting into a hashtable where there is a duplicate key ****/
// In the case, the value is Copy type, you simply overwrite the duplicate value with no issue
// If the value is heap allocated, the insert function should free that value (it is possible that pointers exist to this data,
// and those pointers would be invalidated by doing this, but there is no real way around handling that)

// So in basic form the insert function would look something like this
insert :: ( key: T.Key_Type, value: T.Value_Type, hashmap: *$T/Hashmap. $$ owned: bool = false ) {

    // (1) search for the insert location
    // (2) if location is occupied, check key
    // (3)   if key is duplicate 
    // (4)    IMPORTANT: if owned == true 
    //          anything down here is contigent on whether this hashmap contains owned data
    // (5)      create a new context
    // (6)      overwrite the old context with hashmap's allocator, and allocator data
    // (7)      call free on the data
    // (8)   overwrite the duplicate value with the new value
}

// At the top-level you would define a function:
owned_insert  :: #bake_values( owned = true );

// in the stack case, creating two versions of owned and non-owned functions was purely for a surface level reminder
// of the type of data you are using

// in this case, the baking of the values could have a significant improvement on performance
// if the type of values are primitive types the compiler would actually eliminate the branch checking whether owned == true and
// all the statements following it (4,5,6,7). This would reduce pressure on the instruction cache as well as speed up the actual 
// insertion of primitive types since the function would only do steps 1,2,3 and 8 which is exactly how you would write this function
// without generics (though you would have multiple fn definitions where subtle errors could come into play -- typos/wrong logic etc).

// Also, in the case of owned data, you prevent leaking memory by properly freeing in the data at the correct time. You don't have 
// to pass around function pointers explicitly as well since they are carried through with the implicit context. Finally, the correct
// allocator is also used because you can set the one you want to use at any point within the program.

// This was just an experimental first step into trying to make ownership more explicit. It is a far cry from the 
// robustness provided by the Rust compiler, but it is definitely better than C and easier to handle than C++. For example, in the 
// `owned` version case, if you have a pointer to data that gets effectively `moved` onto the data structure, this reference could
// be invalidated. Though scanning the code it may be easier to see where it happened if the functions are tagged as `owned`.

// Finally, there may be other features of JAI that make this significantly better in some way. I just wanted to give it a try to see 
// what I could come up with.
