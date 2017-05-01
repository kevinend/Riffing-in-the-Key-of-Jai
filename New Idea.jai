After watching several more demos of the language I have a new (possibly better) idea for how to handle ownership, that would
be opt-in versus mandated.

The JAI compiler operates in the following stages:

Parse --> Infer --> Size --> Bytecode --> Run (CTFE) --> Output 
       ^         ^
       <---------|
       User Level Code         

The compiler maintains a message loop telling the user level program when statements/blocks/expressions/declarations/etc have been 
completed. You as the user can inspect those messages and based on AST information kicked back to you, make modifications and pass
it back into the Infer stage.

The key idea is that you can add what Jon calls "Notes" to declarations such as identifiers/structs/functions. These notes get added
to the AST representation and are accessible to you after the Infer stage. You can use your own notes to dictate how the compiler
interprets certain operations by looking at the notes handed back to you and the way that certain variables are being used, such as in
an assignment or as an argument to a function. Then pass this back into infer stage and have the compiler throw special custom errors
and preventing compilation if certain USER DEFINED conditions are not met. 

Here is a simple example illustrating the idea with the use of the allocation/deallocation functions new and delete.

main :: () {

   owned_pointer: *int; @owned    // this note is added to the declaration which I can inspect later 
   owned_pointer = new( int );    // in the compiler message loop, look for the new procedure call and make sure
                                     // identifier on the left is tagged with the @owned note, otherwise reject the program
   free(owned_pointer);           // again, in the compiler message loop, look for free procedure and make sure it's argument
                                      // is tagged with the @owned tag
                                        
   return;
}

This would be a super simple and lightweight way to check for ownership. The best part is that unlike Rust it would be opt-in.
You could write small functions to check different pointer/memory conditions and depending on how extensive a check you wanted 
you could enable as many or as few as you wanted.

This is just a simple baseline idea but I think it has real potential.









