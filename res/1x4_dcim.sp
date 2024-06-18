*** 1x4 DCIM_ARRAY ***
.option nomod 
.lib'0.18umCMOSModel.l'TT
.temp 27

*power supply*
VDD VDD 0 1.2
Vwl0 wl0 0 1.2
VSS VSS 0 0

.subckt sram_nor WL BLB BL IN_B OUT VDD VSS
MN1 Q QB VSS VSS nch  W= 0.30U L= 0.10U
MN2 QB Q VSS VSS nch  W= 0.30U L= 0.10U
MN3 QB WL BLB VSS nch  W= 0.60U L= 0.10U
MN4 Q WL BL VSS nch  W= 0.60U L= 0.10U
MN5 OUT QB VSS VSS nch  W= 0.60U L= 0.10U
MN6 OUT IN_B VSS VSS nch  W= 0.60U L= 0.10U
MP1 Q QB VDD VDD pch  W= 0.60U L= 0.10U
MP2 QB Q VDD VDD pch  W= 0.60U L= 0.10U
MP3 OUT IN_B N1 VDD pch  W= 0.60U L= 0.10U
MP4 N1 QB VDD VDD pch  W= 0.60U L= 0.10U
.ends

Xsram0_0 wl0 blb0 bl0 in_b0 out0_0 vdd vss
Xsram0_1 wl0 blb1 bl1 in_b0 out0_1 vdd vss
Xsram0_2 wl0 blb2 bl2 in_b0 out0_2 vdd vss
Xsram0_3 wl0 blb3 bl3 in_b0 out0_3 vdd vss
