# Riffing-in-the-Key-of-Jai

After fooling around with Rust for a while, I really liked its approach to program correctness and safety. However, I really disliked the cumbersome nature of some of its syntax and some of the restrictions imposed by the borrow checker.

I am really interested in Jonathan Blow's new language JAI, which is currently unreleased. He has provided a series of videos showcasing features of the language. The language definitely follows closer to the procedural paradigm of C but with a lot of enhancements that make it a significant improvement over C and probably C++. 

After watching a few of the videos, I think some of the features could be used to enhance the safety of the programs written in the language without going full boar like Rust. Those features were

  1. Implicit context with custom allocators
  2. Polymorphic/Generic data structures
  3. Polymorphic/Generic functions
  4. #bake_values (compile-time partial function execution)

This repository shows how we could use some of the above features to make ownership more explicit, while not sacrificing performance in handling both primitive data and owned data.
