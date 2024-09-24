TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------

# Build the Virtual Linac IOC application

PROD_IOC = vlinac

DBD += vlinac.dbd

vlinac_DBD = base.dbd

vlinac_SRCS += vlinac_registerRecordDeviceDriver.cpp
vlinac_SRCS_DEFAULT += vlinacMain.cpp
vlinac_SRCS_vxWorks += -nil-

# The following builds sequence programs as a component of vlinac
# as long as SNCSEQ was defined in <top>/configure/RELEASE
ifdef SNCSEQ
  vlinac_SRCS += beamTrajectory.st
  vlinac_SRCS += autoControl.st
  vlinac_SRCS += stabilizer.st
  vlinac_LIBS += seq pv
  vlinac_DBD  += vlinacSeq.dbd
endif

vlinac_LIBS += $(EPICS_BASE_IOC_LIBS)

# This is required because O.$(T_A)/MakefileInclude gets confused if it
# finds all of the lib*.so files it needs already in $(INSTALL_LIB)
vlinac_LDFLAGS += $(addprefix -L,$(SHRLIB_SEARCH_DIRS))

#----------------------------------------
include $(TOP)/configure/RULES

