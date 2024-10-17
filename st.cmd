## Register all support components
dbLoadDatabase dbd/vlinac.dbd
vlinac_registerRecordDeviceDriver(pdbbase)

## Load record instances
#dbLoadRecords vlinacApp/db/xxMedmDemo.db, user=${USER}
dbLoadRecords vlinacApp/Db/xxVirtualLinac.db, user=${USER}

iocInit()

## Start the sequence programs.  These will give an error if
## SNCSEQ is not defined, but won't stop the database from working
#seq &beamTrajectory, user=${USER}
#seq &autoControl, user=${USER}
#seq &stabilizer, user=${USER}

