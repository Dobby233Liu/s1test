@echo off

if exist s1built.bin move /Y s1built.bin s1built.prev.bin >NUL
asm68k /k /p /o ae- sonic.asm, s1built.bin, sonic.sym, sonic.lst
if not exist s1built.bin pause