#######################################################
#                                                     #
#  Encounter Command Logging File                     #
#  Created on Wed Oct 26 02:28:53 2016                #
#                                                     #
#######################################################

#@(#)CDS: Encounter v09.14-s273_1 (32bit) 02/17/2011 18:35 (Linux 2.6)
#@(#)CDS: NanoRoute v09.14-s029 NR110207-1105/USR65-UB (database version 2.30, 112.2.1) {superthreading v1.15}
#@(#)CDS: CeltIC v09.14-s097_1 (32bit) 02/08/2011 02:24:38 (Linux 2.6.9-89.0.19.ELsmp)
#@(#)CDS: AAE 09.14-s001 (32bit) 02/17/2011 (Linux 2.6.9-89.0.19.ELsmp)
#@(#)CDS: CTE 09.14-s140_1 (32bit) Feb  8 2011 01:13:15 (Linux 2.6.9-89.0.19.ELsmp)
#@(#)CDS: CPE v09.14-s001

setUIVar rda_Input ui_gndnet gnd
setUIVar rda_Input ui_timingcon_file ../cache_set_assoc_sdc.sdc
setUIVar rda_Input ui_leffile ../../../lib/tsmc018/lib/osu018_stdcells.lef
setUIVar rda_Input ui_netlist ../cache_set_assoc_gates.v
setUIVar rda_Input ui_timelib,max ../../../lib/tsmc018/lib/osu018_stdcells.tlf
setUIVar rda_Input ui_topcell lc4_insn_cache
setUIVar rda_Input ui_pwrnet vdd
commitConfig
fit
setDrawView fplan
setDrawView ameba
setDrawView place
setDrawView ameba
setDrawView fplan