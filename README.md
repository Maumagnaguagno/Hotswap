# Hotswap
**Swap hotend and bed temperatures of G-code**

In 3D printing one can easily swap the material to make a new piece, but temperatures need to swap too.
This program affects the commands M104, M109, M140 and M190 of [G-Code](https://en.wikipedia.org/wiki/G-code).
The input files remains untouched, and new files are generated with the new temperatures.

## Execution

```Shell
ruby Hotswap.rb hotend_temperature bed_temperature {filenames}
```