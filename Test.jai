// Key features:
//  1. Polymorphic/Generic procedures
//  2. Polymorphic/Generic data structures
//  3. #bake_values (compile-time partial function execution)
//  4. Implicit context 
//  5. Generic allocator/deallocator

// 1. Generic Procedures - $ denotes the authoritative type for a polymorphic function
// monomorphic functions:
add_int :: (x: int, y: int) -> int {
  return x + y;
}

add_float :: (x: float, y: float) -> float {
  return x + y;
}

// generic verion -- nothing fancy here
