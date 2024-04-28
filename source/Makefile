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

SOURCES = basic/robotron.bsc basic/setup.bsc

.any:

assembler: .any
	cd assembler ; 64tass -b -c -Wall main.asm -o ../storage/robotron.bin -L ../build/robotron.lst

basic: .any 
	$(PYTHON) $(BINDIR)makebasic.zip $(SOURCES) -orobotron.bas

app: assembler basic 

release: app
	rm -f ../robotron.zip
	zip ../robotron.zip robotron.bas storage/robotron.bin storage/robotron.gfx

run: app
	$(BINDIR)neo robotron.bas@page exec

neo: app
	cat $(SOURCES) >$(ROOTDIR)/neo6502-firmware/basic/test.bsc
	cp	storage/* $(ROOTDIR)/neo6502-firmware/basic/storage
	make -C $(ROOTDIR)/neo6502-firmware/basic tneo
	
sendbas:
	$(PYTHON) $(BINDIR)nxmit.zip /dev/ttyUSB0 s:robotron.bas
sendbin:
	$(PYTHON) $(BINDIR)nxmit.zip /dev/ttyUSB0 s:storage/robotron.bin
sendgfx:		
	$(PYTHON) $(BINDIR)nxmit.zip /dev/ttyUSB0 s:storage/robotron.gfx

update:
	cd .. ; git add * ; git add * -u ; git commit -m "Update" ; git push