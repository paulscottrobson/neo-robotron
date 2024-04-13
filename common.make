# ***************************************************************************************
# ***************************************************************************************
#
#		Name : 		common.make
#		Author :	Paul Robson (paul@robsons.org.uk)
#		Date : 		13th April 2024
#		Reviewed :	No
#		Purpose :	Game build.
#
# ***************************************************************************************
# ***************************************************************************************

PYTHON = python3

ROOTDIR =  $(dir $(realpath $(lastword $(MAKEFILE_LIST))))../
BINDIR = $(ROOTDIR)/neo6502-firmware/bin/