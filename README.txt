# Riffing-in-the-Key-of-Jai

After fooling around with Rust for a while, I really liked its approach to program correctness and safety. However, I really disliked the cumbersome nature of some of its syntax and some of the restrictions imposed by the borrow checker.

I am really interested in Jonathan Blow's new language JAI, which is currently unreleased. He has provided a series of videos showcasing features of the language. The language definitely follows closer to the procedural paradigm of C but with a lot of enhancements that make it a significant improvement over C and probably C++. 

After watching a few of the videos, I think some of the features could be used to enhance the safety of the programs written in the language without going full boar like Rust. Those features were

Key features:
  1. Implicit context with custom allocators
  3. Polymorphic/Generic data structures
  4. Polymorphic/Generic functions
  5. #bake_values (compile-time partial function execution)


This repository just contains some examples I intend to try out once the compiler is released (hopefully soon!).
