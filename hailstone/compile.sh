gcc -O0 -S hailstone.c -o hailstoneC0.s
gcc -O1 -S hailstone.c -o hailstoneC1.s
gcc -O2 -S hailstone.c -o hailstoneC2.s
gcc -O3 -S hailstone.c -o hailstoneC3.s
gcc -O0 hailstone.c -o hailstoneC0
gcc -O1 hailstone.c -o hailstoneC1
gcc -O2 hailstone.c -o hailstoneC2
gcc -O3 hailstone.c -o hailstoneC3
gcc hailstone.s -o hailstone
gcc hailstone2.s -o hailstone2
gcc hailstone_final.s -o hailstone_final
