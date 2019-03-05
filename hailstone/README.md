# Hailstone benchmark

This famous benchmark involves lots of 64-bit integer arithmetic to compute the longest sequence in a simple recurrence relation.

Here is a quick summary of the results obtained with GCC 6.3.0 on a Raspberry Pi 3 running Raspbian:

| Source  | LOC | Time (s) |
| ------- | --- | -------- |
| gcc -O0 | 246 |    2.612 |
| gcc -O1 | 193 |    1.334 |
| gcc -O2 | 247 |    1.423 |
| gcc -O3 | 240 |    1.457 |
| Manual  |  58 |    1.106 |

As you can see from these results it is still very easy to write ARM assembly by hand that outperforms a decent C/C++ compiler even with -O3.

I wrote the ARM assembly version the most obvious way possible and employs no fancy optimisations at all. So what are the differences between my hand-written code and the compiler-generated code? I would suggest the following:

* Whereas GCC copied the functions from the C source code I inlined the `collatzLen` and `loop` functions into `main`.
* Whereas GCC repeatedly spills lots of registers onto the stack I simply use registers r0-r9 to perform the entire computation without ever spilling anything.
* Whereas GCC uses a completely naive layout of instruction blocks copying the C source code, I write `while` loops starting with the loop body followed by the predicate test at the end with a loop back to the start of the body and enter the loop by jumping into the predicate test at the end. Therefore, my code uses one jump per iteration whereas GCC uses two.

I have noticed before that compilers tend to make really poor use of ARM's conditional instruction set (usually resorting to many unnecessary jumps which are costly on the ARM architecture) but in this case the use of 64-bit arithmetic from a 32-bit instruction set required the carry flag so I was not able to explooit any fancy optimisations using the conditional instruction set to avoid jumps.

I would like to explore the possibility to write the ARM assembly using 64-bit arithmetic instructions which this CPU is capable of executing even though I am using a 32-bit Raspbian OS.
