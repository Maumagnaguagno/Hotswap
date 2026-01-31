# Hotswap
**Swap hotend and bed temperature of G-code**

In 3D printing one can easily swap the material to make a new piece, but temperatures need to swap too.
This program affects the commands M104, M109, M140 and M190 of [G-Code](https://en.wikipedia.org/wiki/G-code).
The input file remains untouched, and a new file is generated with the new temperatures.

## Execution

```Shell
ruby Hotswap.rb filename hotend_temperature bed_temperature
```