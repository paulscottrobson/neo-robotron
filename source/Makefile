# ***************************************************************************************
# ***************************************************************************************
#
#		Name : 		Makefile
#		Author :	Paul Robson (paul@robsons.org.uk)
#		Date : 		13th April 2024
#		Reviewed :	No
#		Purpose :	Build Graphics
#
# ***************************************************************************************
# ***************************************************************************************

include ../common.make

SOURCES = basic/robotron.bsc

.any:

assembler: .any
	cd assembler ; 64tass -b -c -Wall main.asm -o ../storage/robotron.bin -L ../build/robotron.lst

basic: .any 
	$(PYTHON) $(BINDIR)makebasic.zip $(SOURCES) -orobotron.bas

app: assembler basic 

run: app
	$(BINDIR)neo robotron.bas@page exec

	