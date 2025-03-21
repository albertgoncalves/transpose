# transpose

Transpose a chord progression by a given interval.

Quick start
---
```console
$ nix-shell
$ make -j
$ cat assets/0.csv
A-7,D7,G^,,C-7,F7,Bb^,
Eb-7,Ab7,Db^,Gb^,B-7,,E7,
$ interval=$(shuf -n 1 -e P1 m2 M2 m3 M3 P4 A4 d5 P5 m6 M6 m7 M7)
$ echo $interval
m6
$ ./bin/main $interval assets/0.csv
+-------+-------+-------+-------+-------+-------+-------+-------+
|F-7     Bb7    |Eb^            |Ab-7    Db7    |Gb^            |
+-------+-------+-------+-------+-------+-------+-------+-------+
|Cb-7    Fb7    |Bbb^    Ebb^   |G-7            |C7             |
+-------+-------+-------+-------+-------+-------+-------+-------+
```
