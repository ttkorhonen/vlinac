#Makefile at top of application tree
TOP = .
include $(TOP)/configure/CONFIG
DIRS := configure
DIRS += vlinacApp
DIRS += $(wildcard installApp)
include $(TOP)/configure/RULES_TOP
