*** 4x6 DCIM_ARRAY ***
.option nomod 
.lib'0.18umCMOSModel.l'TT
.temp 27

*power supply*
VDD VDD 0 1.2
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

Xsram0_0 wl0 blb0 bl0 in_b0 out0_0 vdd vss sram_nor
Xsram0_1 wl0 blb1 bl1 in_b0 out0_1 vdd vss sram_nor
Xsram0_2 wl0 blb2 bl2 in_b0 out0_2 vdd vss sram_nor
Xsram0_3 wl0 blb3 bl3 in_b0 out0_3 vdd vss sram_nor
Xsram0_4 wl0 blb4 bl4 in_b0 out0_4 vdd vss sram_nor
Xsram0_5 wl0 blb5 bl5 in_b0 out0_5 vdd vss sram_nor
Xsram1_0 wl1 blb0 bl0 in_b1 out1_0 vdd vss sram_nor
Xsram1_1 wl1 blb1 bl1 in_b1 out1_1 vdd vss sram_nor
Xsram1_2 wl1 blb2 bl2 in_b1 out1_2 vdd vss sram_nor
Xsram1_3 wl1 blb3 bl3 in_b1 out1_3 vdd vss sram_nor
Xsram1_4 wl1 blb4 bl4 in_b1 out1_4 vdd vss sram_nor
Xsram1_5 wl1 blb5 bl5 in_b1 out1_5 vdd vss sram_nor
Xsram2_0 wl2 blb0 bl0 in_b2 out2_0 vdd vss sram_nor
Xsram2_1 wl2 blb1 bl1 in_b2 out2_1 vdd vss sram_nor
Xsram2_2 wl2 blb2 bl2 in_b2 out2_2 vdd vss sram_nor
Xsram2_3 wl2 blb3 bl3 in_b2 out2_3 vdd vss sram_nor
Xsram2_4 wl2 blb4 bl4 in_b2 out2_4 vdd vss sram_nor
Xsram2_5 wl2 blb5 bl5 in_b2 out2_5 vdd vss sram_nor
Xsram3_0 wl3 blb0 bl0 in_b3 out3_0 vdd vss sram_nor
Xsram3_1 wl3 blb1 bl1 in_b3 out3_1 vdd vss sram_nor
Xsram3_2 wl3 blb2 bl2 in_b3 out3_2 vdd vss sram_nor
Xsram3_3 wl3 blb3 bl3 in_b3 out3_3 vdd vss sram_nor
Xsram3_4 wl3 blb4 bl4 in_b3 out3_4 vdd vss sram_nor
Xsram3_5 wl3 blb5 bl5 in_b3 out3_5 vdd vss sram_nor
