*** 4x4 NOR2x1 DCIM_ARRAY ***
.option nomod captable=1
.lib'rf018.l'TT
.temp 27
.param C_NOR2x1_inb=3.4184f
.param C_NOR2x2_inb=6.8427f
.param C_NOR2x4_inb=13.6222f
.param C_NOR2xL_inb=2.3512f
.param C_bl=12.4587f
.param C_blb=11.9573f


*power supply*
VDD VDD 0 1.8
VSS VSS 0 0

*single cell*
.subckt sram_nor WL BLB BL  QB VDD VSS
MN1 Q QB VSS VSS nch  W= 0.22U L= 0.18U
MN2 QB Q VSS VSS nch  W= 0.22U L= 0.18U
MN3 QB WL BLB VSS nch  W= 0.60U L= 0.18U
MN4 Q WL BL VSS nch  W= 0.60U L= 0.18U
MP1 Q QB VDD VDD pch  W= 0.44U L= 0.18U
MP2 QB Q VDD VDD pch  W= 0.44U L= 0.18U
.ends

*NOR*
.subckt NOR2x1 Y A B VDD VSS
M0 VDD   B   hnet7 VDD  pch L=0.18u  W=1.2U
M1 hnet7 A  Y      VDD  pch L=0.18u  W=1.2U
M2  Y  B  VSS  VSS      nch L=0.18u  W=0.6u
M3  Y  A  VSS  VSS      nch L=0.18u  W=0.6u
.ends

.subckt NOR2x2 Y A B VDD VSS
M0 VDD B hnet8 VDD pch L=0.18u W=1.2u
M1 hnet8 A Y VDD pch L=0.18u W=1.2u
M2 VDD B hnet6 VDD pch L=0.18u W=1.2u
M3 hnet6 A Y VDD pch L=0.18u W=1.2u
M4 Y B VSS VSS nch L=0.18u W=1.2u
M5 Y A VSS VSS nch L=0.18u W=1.2u
.ends

.subckt NOR2x4 Y A B VDD VSS
M0 Y B VSS VSS nch L=0.18u W=2.4u
M1 Y A VSS VSS nch L=0.18u W=2.4u
M2 VDD B hnet10 VDD pch L=0.18u W=1.6u
M3 hnet10 A Y VDD pch L=0.18u W=1.6u
M4 VDD B hnet15 VDD pch L=0.18u W=1.6u
M5 hnet15 A Y VDD pch L=0.18u W=1.6u
M6 VDD B hnet20 VDD pch L=0.18u W=1.56u
M7 hnet20 A Y VDD pch L=0.18u W=1.56u
.ends

.subckt NOR2xL Y A B VDD VSS
M0 VDD B hnet7 VDD pch L=0.18u W=0.84u
M1 hnet7 A Y VDD pch L=0.18u W=0.84u
M2 Y B VSS VSS nch L=0.18u W=0.4u
M3 Y A VSS VSS nch L=0.18u W=0.4u
.ends

* NOR *
.subckt nor a b out vdd vss
mn22 out a vss vss nch  W= 1U L= 0.18U
mn23 out b vss vss nch  W= 1U L= 0.18U
mp18 out a n1 vdd pch  W= 1U L= 0.18U
mp19 n1 b vdd vdd pch  W= 1U L= 0.18U
.ends

*INVERTER*
.subckt inv IN OUT VDD VSS
MN16 OUT IN VSS VSS nch  W= 1U L= 0.18U
MP11 OUT IN VDD VDD pch  W= 3.55U L= 0.18U
.ends

*BUFFER*
.subckt buf IN OUT VDD VSS
Xinv11 in out1 vdd vss inv
Xinv12 out1 out vdd vss inv
.ends

*precharge circuit*
.subckt precharge_circuit pc bl blb vdd vss
MP5 bl pc vdd vdd pch W= 1U L= 0.18U
MP6 blb pc vdd vdd pch W= 1U L= 0.18U
MP7 bl pc blb vdd pch W= 1U L= 0.18U
.ends

*write circuit*
.subckt write_circuit we bl blb data vdd vss
*MN7 BL WE a VSS nch  W= 1U L= 0.18U
*MN8 BLB WE b VSS nch  W= 1U L= 0.18U
*MN9 a data_bar VSS VSS nch  W= 1U L= 0.18U
*MN10 b data_in VSS VSS nch  W= 1U L= 0.18U
MN7 BL WE data_in VSS nch  W= 1U L= 0.18U
MN8 BLB WE data_bar VSS nch  W= 1U L= 0.18U
MP8 data_bar data VDD VDD pch  W= 3.55U L= 0.18U
MN11 data_bar data VSS VSS nch W= 1U L= 0.18U
Xinv data_bar data_in vdd vss inv
.ends


*sense amplifier*
.subckt sense_amplifier we se BL BLB ROUT vdd vss
MP9 C C VDD VDD pch W= 1U L= 0.18U
MP10 Y C VDD VDD pch W= 1U L= 0.18U
MN12 C b D VSS nch  W= 1U L= 0.18U
MN13 Y a D VSS nch  W= 1U L= 0.18U
MN14 D SE VSS VSS nch  W= 1U L= 0.18U
MP12 ROUT Y VDD VDD pch  W= 3.55U L= 0.18U
MN15 ROUT Y VSS VSS nch W= 1U L= 0.18U

Mp16 BL    wE a VSS nch W=1u L=0.18u
Mp17 BLB wE b VSS nch W=1u L=0.18u
.ends

*nand*
.subckt nand A B out vdd vss
MP20 out A vdd vdd pch  W= 1U L= 0.18U
MP30 out B vdd vdd pch  W= 1U L= 0.18U
MN20 out A n1 n1 nch  W= 1U L= 0.18U
MN30 n1 B vss vss nch  W= 1U L= 0.18U
.ends 

*nand3_1*
.subckt nand3_1 A B C out vdd vss
mp40 out A vdd vdd pch  W= 1U L= 0.18U
mp50 out B vdd vdd pch  W= 1U L= 0.18U
mp60 out C vdd vdd pch  W= 1U L= 0.18U
mn40 out A n1 vss nch  W= 1U L= 0.18U
mn50 n1 B n2 vss nch  W= 1U L= 0.18U
mn60 n2 C vss vss nch  W= 1U L= 0.18U
.ends

*d-filp flop*
.subckt dff clk d Q QB VDD VSS
Xnand3_1 S clk n1 R vdd vss nand3_1
Xnand1 n1 S n2 vdd vss nand
Xnand2 n2 clk S vdd vss nand
Xnand3 R d n1 vdd vss nand
Xnand4 S Qb Q vdd vss nand
Xnand5 R Q QB vdd vss nand
.ends 

*2-input AND gate
.subckt and2 a1 a2 and_out vdd vss
MN1 n1 a1 n2 vss nch W=1U L=0.18U
MN2 n2 a2 vss vss nch W=1U L=0.18U
MP1 n1 a1 vdd vdd pch W=1U L=0.18U
MP2 n1 a2 vdd vdd pch W=1U L=0.18U
Xinv n1 and_out vdd vss inv
.ends

*2-to-4 Decoder
.subckt decoder2to4 ce a1 a2 out1 out2 out3 out4 vdd vss
Xinv1 a1 abar1 vdd vss inv
Xinv2 a2 abar2 vdd vss inv
Xand1 abar1 abar2 and_out1 vdd vss and2
Xand2 a1 abar2 and_out2 vdd vss and2
Xand3 abar1 a2 and_out3 vdd vss and2
Xand4 a1 a2 and_out4 vdd vss and2
Xand5 ce and_out1 out1 vdd vss and2
Xand6 ce and_out2 out2 vdd vss and2
Xand7 ce and_out3 out3 vdd vss and2
Xand8 ce and_out4 out4 vdd vss and2

.ends

*control logic
.subckt control_logic clk we ce pc we_en se_en vdd vss
*input : we
*input : ce
*input : clk
*output : pc
*output : we_en
*output : se_en
Xdff_ce  clk   ce   pc   ce0_bar  vdd vss dff
Xdff_we  clk   we we0  we0_bar vdd vss dff
Xnor0  ce0_bar  we0  se_en  vdd vss nor
Xnor1  ce0_bar  we0_bar we_en vdd vss nor
.ends

*driver*
.subckt driver in out vdd vss 
Xbuf0  in   out  vdd vss buf m=1
.ends

Xdff0  clk0 a0 addr0 addr0_bar vdd vss dff
Xdff1  clk0 a1 addr1 addr1_bar vdd vss dff


Xdriver0  out0 wl0 vdd vss driver
Xdriver1  out1 wl1 vdd vss driver
Xdriver2  out2 wl2 vdd vss driver
Xdriver3  out3 wl3 vdd vss driver  

Xsram0_0 wl0 blb0 bl0  QB0_0 vdd vss sram_nor
Xsram0_1 wl0 blb1 bl1  QB0_1 vdd vss sram_nor
Xsram0_2 wl0 blb2 bl2  QB0_2 vdd vss sram_nor
Xsram0_3 wl0 blb3 bl3  QB0_3 vdd vss sram_nor
Xsram1_0 wl1 blb0 bl0  QB1_0 vdd vss sram_nor
Xsram1_1 wl1 blb1 bl1  QB1_1 vdd vss sram_nor
Xsram1_2 wl1 blb2 bl2  QB1_2 vdd vss sram_nor
Xsram1_3 wl1 blb3 bl3  QB1_3 vdd vss sram_nor
Xsram2_0 wl2 blb0 bl0  QB2_0 vdd vss sram_nor
Xsram2_1 wl2 blb1 bl1  QB2_1 vdd vss sram_nor
Xsram2_2 wl2 blb2 bl2  QB2_2 vdd vss sram_nor
Xsram2_3 wl2 blb3 bl3  QB2_3 vdd vss sram_nor
Xsram3_0 wl3 blb0 bl0  QB3_0 vdd vss sram_nor
Xsram3_1 wl3 blb1 bl1  QB3_1 vdd vss sram_nor
Xsram3_2 wl3 blb2 bl2  QB3_2 vdd vss sram_nor
Xsram3_3 wl3 blb3 bl3  QB3_3 vdd vss sram_nor


*Xcontrol_logic  clk0 we ce pc we_en se_en vdd vss control_logic

Xdecoder2to4 pc addr0 addr1 out0 out1 out2 out3 vdd vss decoder2to4


XPC0 pc bl0 blb0 vdd vss precharge_circuit
XPC1 pc bl1 blb1 vdd vss precharge_circuit
XPC2 pc bl2 blb2 vdd vss precharge_circuit
XPC3 pc bl3 blb3 vdd vss precharge_circuit

XINV0_0 inb0_0 inb0_1 vdd vss inv m=1.0
XBUF0_1 inb0_1 inb0_2 vdd vss buf m=2.0

XINV1_0 inb1_0 inb1_1 vdd vss inv m=1.0
XBUF1_1 inb1_1 inb1_2 vdd vss buf m=2.0

XINV2_0 inb2_0 inb2_1 vdd vss inv m=1.0
XBUF2_1 inb2_1 inb2_2 vdd vss buf m=2.0

XINV3_0 inb3_0 inb3_1 vdd vss inv m=1.0
XBUF3_1 inb3_1 inb3_2 vdd vss buf m=2.0

XNOR0_0 out0_0 QB0_0 b0_0 vdd vss NOR2x1
 XNOR0_1 out0_1 QB0_1 b0_1 vdd vss NOR2x1
 XNOR0_2 out0_2 QB0_2 b0_2 vdd vss NOR2x1
 XNOR0_3 out0_3 QB0_3 b0_3 vdd vss NOR2x1
 XNOR1_0 out1_0 QB1_0 b1_0 vdd vss NOR2x1
 XNOR1_1 out1_1 QB1_1 b1_1 vdd vss NOR2x1
 XNOR1_2 out1_2 QB1_2 b1_2 vdd vss NOR2x1
 XNOR1_3 out1_3 QB1_3 b1_3 vdd vss NOR2x1
 XNOR2_0 out2_0 QB2_0 b2_0 vdd vss NOR2x1
 XNOR2_1 out2_1 QB2_1 b2_1 vdd vss NOR2x1
 XNOR2_2 out2_2 QB2_2 b2_2 vdd vss NOR2x1
 XNOR2_3 out2_3 QB2_3 b2_3 vdd vss NOR2x1
 XNOR3_0 out3_0 QB3_0 b3_0 vdd vss NOR2x1
 XNOR3_1 out3_1 QB3_1 b3_1 vdd vss NOR2x1
 XNOR3_2 out3_2 QB3_2 b3_2 vdd vss NOR2x1
 XNOR3_3 out3_3 QB3_3 b3_3 vdd vss NOR2x1
 
R0_0 inb0_2 b0_0  1 
 R0_1 b0_0 b0_1  1 
 R0_2 b0_1 b0_2  1 
 R0_3 b0_2 b0_3  1 
 R1_0 inb1_2 b1_0  1 
 R1_1 b1_0 b1_1  1 
 R1_2 b1_1 b1_2  1 
 R1_3 b1_2 b1_3  1 
 R2_0 inb2_2 b2_0  1 
 R2_1 b2_0 b2_1  1 
 R2_2 b2_1 b2_2  1 
 R2_3 b2_2 b2_3  1 
 R3_0 inb3_2 b3_0  1 
 R3_1 b3_0 b3_1  1 
 R3_2 b3_1 b3_2  1 
 R3_3 b3_2 b3_3  1 
 
C0_0  b0_0 vss   'C_NOR2x1_inb' 
 C0_1  b0_1 vss   'C_NOR2x1_inb' 
 C0_2  b0_2 vss   'C_NOR2x1_inb' 
 C0_3  b0_3 vss   'C_NOR2x1_inb' 
 C1_0  b1_0 vss   'C_NOR2x1_inb' 
 C1_1  b1_1 vss   'C_NOR2x1_inb' 
 C1_2  b1_2 vss   'C_NOR2x1_inb' 
 C1_3  b1_3 vss   'C_NOR2x1_inb' 
 C2_0  b2_0 vss   'C_NOR2x1_inb' 
 C2_1  b2_1 vss   'C_NOR2x1_inb' 
 C2_2  b2_2 vss   'C_NOR2x1_inb' 
 C2_3  b2_3 vss   'C_NOR2x1_inb' 
 C3_0  b3_0 vss   'C_NOR2x1_inb' 
 C3_1  b3_1 vss   'C_NOR2x1_inb' 
 C3_2  b3_2 vss   'C_NOR2x1_inb' 
 C3_3  b3_3 vss   'C_NOR2x1_inb' 

Xdff4 clk0 data0_in data0 data0_bar vdd vss dff
Xdff5 clk0 data1_in data1 data1_bar vdd vss dff
Xdff6 clk0 data2_in data2 data2_bar vdd vss dff
Xdff7 clk0 data3_in data3 data3_bar vdd vss dff

Xbuf0 we we1 vdd vss buf m=1
Xbuf1 we1 we_en vdd vss buf m=2

XWE0 we_en bl0 blb0 data0 vdd vss write_circuit
XWE1 we_en bl1 blb1 data1 vdd vss write_circuit
XWE2 we_en bl2 blb2 data2 vdd vss write_circuit
XWE3 we_en bl3 blb3 data3 vdd vss write_circuit

Xbuf2 se se1 vdd vss buf m=1
Xbuf3 se1 se_en vdd vss buf m=2

XSA0 we_en se_en bl0 blb0 rout0 vdd vss sense_amplifier
XSA1 we_en se_en bl1 blb1 rout1 vdd vss sense_amplifier
XSA2 we_en se_en bl2 blb2 rout2 vdd vss sense_amplifier
XSA3 we_en se_en bl3 blb3 rout3 vdd vss sense_amplifier


Xdff_inb0  clk0 inb0 inb0_0 inb0_0_bar vdd vss dff
Xdff_inb1  clk0 inb1 inb1_0 inb1_0_bar vdd vss dff
Xdff_inb2  clk0 inb2 inb2_0 inb2_0_bar vdd vss dff
Xdff_inb3  clk0 inb3 inb3_0 inb3_0_bar vdd vss dff


cbl0    bl0      vss   'C_bl'
cblb0  blb0   vss   'C_blb'

cbl1    bl1      vss   'C_bl'
cblb1  blb1   vss   'C_blb'

cbl2    bl2      vss   'C_bl'
cblb2  blb2   vss   'C_blb'

cbl3    bl3      vss   'C_bl'
cblb3  blb3   vss   'C_blb'





.op
*clock
*period : 10n
*transition : 0.01n
Vclk0 clk0  0 PULSE (0  1.8  0u 0.01n  0.01n  4.99n  10n)

*input source
*pc_time: 0.35n
Vpc pc 0 PWL(0n 0v 0.35n 0v 0.36n 1.8v 10n 1.8v, R)
Vwe we 0 PWL(0n 0v 10n 0v 10.35n 0v 10.36n 1.8v 19.99n 1.8v 20n 0v 50n 0v  50.35n 0v 50.36n 1.8v 59.99n 1.8v 60n 0v)
Vse se 0 PWL(0n 0v 20n 0v 20.35n 0v 20.36n 1.8v 29.99n 1.8v 30n 0v 60n 0v  60.35n 0v 60.36n 1.8v 69.99n 1.8v 70n 0v)


*Vinb3 inb3 0 PWL(0n 0v 20n 0v 20.01n 1.8v  30n 1.8v 30.01n 0v 70n 0v)
Vinb3 inb3 0 PWL(0u 0v 7.995n 0v 8.005n 0.0 17.995n 0.0v 18.005n 1.8v 27.995n 1.8v 28.005n 0.0v )

*address
Va0 a0 0 PWL(0u 0v 7.995n 0v 8.005n 1.8 17.995n 1.8v 18.005n 1.8v 27.995n 1.8v 28.005n 1.8v 37.995n 1.8v 38.005n 1.8v 47.995n 1.8v 48.005n 1.8v 57.995n 1.8v 58.005n 1.8v )

Va1 a1 0 PWL(0u 0v 7.995n 0v 8.005n 1.8 17.995n 1.8v 18.005n 1.8v 27.995n 1.8v 28.005n 1.8v 37.995n 1.8v 38.005n 1.8v 47.995n 1.8v 48.005n 1.8v 57.995n 1.8v 58.005n 1.8v )


*input data
Vdata0_in data0_in 0 PWL(0u 0v 7.995n 0v 8.005n 1.8 17.995n 1.8v 18.005n 1.8v 27.995n 1.8v 28.005n 1.8v 37.995n 1.8v 38.005n 1.8v 47.995n 1.8v 48.005n 0.0v 57.995n 0.0v 58.005n 0.0v )

Vdata1_in data1_in 0 PWL(0u 0v 7.995n 0v 8.005n 1.8 17.995n 1.8v 18.005n 1.8v 27.995n 1.8v 28.005n 1.8v 37.995n 1.8v 38.005n 1.8v 47.995n 1.8v 48.005n 0.0v 57.995n 0.0v 58.005n 0.0v )

Vdata2_in data2_in 0 PWL(0u 0v 7.995n 0v 8.005n 1.8 17.995n 1.8v 18.005n 1.8v 27.995n 1.8v 28.005n 1.8v 37.995n 1.8v 38.005n 1.8v 47.995n 1.8v 48.005n 0.0v 57.995n 0.0v 58.005n 0.0v )

Vdata3_in data3_in 0 PWL(0u 0v 7.995n 0v 8.005n 1.8 17.995n 1.8v 18.005n 1.8v 27.995n 1.8v 28.005n 1.8v 37.995n 1.8v 38.005n 1.8v 47.995n 1.8v 48.005n 0.0v 57.995n 0.0v 58.005n 0.0v )


*.ic v(bl0)=0v v(blb0)=0v


*measurement


*.meas TRAN Tread1_delay TRIG v(clk0) val=0.9 RISE=3 TARG v(rout3) val=1.44 RISE=1

*.meas TRAN Tread1_slew TRIG v(rout3) val=0.54 RISE=1 TARG V(rout3) val=1.26 RISE=1

*.meas TRAN Tread0_delay TRIG v(clk0) val=0.9 RISE=6 TARG v(rout3) val=0.9 FALL=1

*.meas TRAN Tread0_slew TRIG v(rout3) val=1.26 FALL=1 TARG V(rout3) val=0.54 FALL=1


*.meas TRAN Tcompute1_delay_0 TRIG v(clk0) val=0.9 RISE=4 TARG v(out3_0) val=0.9 RISE=1
*.meas TRAN Tcompute1_delay_1 TRIG v(clk0) val=0.9 RISE=4 TARG v(out3_1) val=0.9 RISE=1
*.meas TRAN Tcompute1_delay_2 TRIG v(clk0) val=0.9 RISE=4 TARG v(out3_2) val=0.9 RISE=1
*.meas TRAN Tcompute1_delay_3 TRIG v(clk0) val=0.9 RISE=4 TARG v(out3_3) val=0.9 RISE=1

*.meas TRAN Tcompute1_slew TRIG v(out3_3) val=0.54 RISE=1 TARG v(out3_3) val=1.26 RISE=1


*.meas TRAN Tcompute0_delay TRIG v(clk0) val=0.9  RISE=5 TARG v(out3_3) val=0.9 FALL=1

*.meas TRAN Tcompute0_slew TRIG v(out3_3) val=1.26 FALL=1 TARG V(out3_3) val=0.54 FALL=1


*.print v(blb0)

.meas TRAN Tread1_delay TRIG v(clk0) val=0.9 RISE=3 TARG v(rout3) val=0.9 RISE=1
.meas TRAN Tread1_slew TRIG v(rout3) val=0.54 RISE=1 TARG v(rout3) val=1.26 RISE=1
.meas TRAN Tread1_wl_delay TRIG v(clk0) val=0.9 RISE=3 TARG v(wl3) val=0.9 RISE=2
.meas TRAN Tread1_se_delay TRIG v(clk0) val=0.9 RISE=3 TARG v(se_en) val=0.9 RISE=1

.meas TRAN Tread0_delay TRIG v(clk0) val=0.9 RISE=7 TARG v(rout3) val=0.9 FALL=1
.meas TRAN Tread0_slew TRIG v(rout3) val=1.26 FALL=1 TARG v(rout3) val=0.54 FALL=1
.meas TRAN Tread0_wl_delay TRIG v(clk0) val=0.9 RISE=7 TARG v(wl3) val=0.9 RISE=6
.meas TRAN Tread0_se_delay TRIG v(clk0) val=0.9 RISE=7 TARG v(se_en) val=0.9 RISE=2




.tran 0.01n 70n
.end