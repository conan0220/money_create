*** decoder ***
.option nomod captable=1
.lib'rf018.l'TT
.temp 27

*power supply*
VDD VDD 0 1.8
VSS VSS 0 0

*INVERTER*
.subckt inv IN OUT VDD VSS
MN16 OUT IN VSS VSS nch  W= 1U L= 0.18U
MP11 OUT IN VDD VDD pch  W= 3.55U L= 0.18U
.ends

*2-input AND gate
.subckt and2 a1 a2 and_out vdd vss
MN1 n1 a1 n2 vss nch W=1U L=0.18U
MN2 n2 a2 vss vss nch W=1U L=0.18U
MP1 n1 a1 vdd vdd pch W=1U L=0.18U
MP2 n1 a2 vdd vdd pch W=1U L=0.18U
Xinv n1 and_out vdd vss inv
.ends

*3-input AND gate
.subckt and3 a1 a2 a3 and_out vdd vss
MN1 n1 a1 n2 vss nch  W=1U L=0.18U
MN2 n2 a2 n3 vss nch W=1U L=0.18U
MN3 n3 a3 vss vss nch W=1U L=0.18U
MP1 n1 a1 vdd vdd pch W=1U L=0.18U
MP2 n1 a2 vdd vdd pch W=1U L=0.18U
MP3 n1 a3 vdd vdd pch W=1U L=0.18U
Xinv n1 and_out vdd vss inv
.ends

*2-to-4 Decoder
.subckt decoder2to4 en a1 a2 out1 out2 out3 out4 vdd vss
Xinv1 a1 abar1 vdd vss inv
Xinv2 a2 abar2 vdd vss inv
Xand1 abar1 abar2 and_out1 vdd vss and2
Xand2 a1 abar2 and_out2 vdd vss and2
Xand3 abar1 a2 and_out3 vdd vss and2
Xand4 a1 a2 and_out4 vdd vss and2
Xand5 en and_out1 out1 vdd vss and2
Xand6 en and_out2 out2 vdd vss and2
Xand7 en and_out3 out3 vdd vss and2
Xand8 en and_out4 out4 vdd vss and2

.ends

*3-to-8 decoder
.subckt decoder3to8 ce a1 a2 a3 out0 out1 out2 out3 out4 out5 out6 out7 vdd vss
Xinv1 a1 abar1 vdd vss inv
Xinv2 a2 abar2 vdd vss inv
Xinv3 a3 abar3 vdd vss inv

Xand0 abar3 abar2 abar1 and_out1 vdd vss and3
Xand1 abar3 abar2 a1 and_out2 vdd vss and3 
Xand2 abar3 a2 abar1 and_out3 vdd vss and3
Xand3 abar3 a2 a1 and_out4 vdd vss and3
Xand4 a3 abar2 abar1 and_out5 vdd vss and3
Xand5 a3 abar2 a1 and_out6 vdd vss and3
Xand6 a3 a2 abar1 and_out7 vdd vss and3
Xand7 a3 a2 a1 and_out8 vdd vss and3

Xand8 ce and_out1 out0 vdd vss and2
Xand9 ce and_out2 out1 vdd vss and2
Xand10 ce and_out3 out2 vdd vss and2
Xand11 ce and_out4 out3 vdd vss and2
Xand12 ce and_out5 out4 vdd vss and2
Xand13 ce and_out6 out5 vdd vss and2
Xand14 ce and_out7 out6 vdd vss and2
Xand15 ce and_out8 out7 vdd vss and2

.ends

Xdecoder3to8 pc a1 a2 a3 out0 out1 out2 out3 out4 out5 out6 out7 vdd vss decoder3to8

.op
Va1 a1 0 PWL(0u 0v 7.995n 0v 8.005n 0.0 17.995n 0.0v 18.005n 1.8v 27.995n 1.8v 28.005n 0.0v 37.995n 0.0v 38.005n 1.8v 47.995n 1.8v 48.005n 0.0v 57.995n 0.0v 58.005n 1.8v 67.995n 1.8v 68.005n 0.0v 77.995n 0.0v 78.005n 1.8v )

Va2 a2 0 PWL(0u 0v 7.995n 0v 8.005n 0.0 17.995n 0.0v 18.005n 0.0v 27.995n 0.0v 28.005n 1.8v 37.995n 1.8v 38.005n 1.8v 47.995n 1.8v 48.005n 0.0v 57.995n 0.0v 58.005n 0.0v 67.995n 0.0v 68.005n 1.8v 77.995n 1.8v 78.005n 1.8v )

Va3 a3 0 PWL(0u 0v 7.995n 0v 8.005n 0.0 17.995n 0.0v 18.005n 0.0v 27.995n 0.0v 28.005n 0.0v 37.995n 0.0v 38.005n 0.0v 47.995n 0.0v 48.005n 1.8v 57.995n 1.8v 58.005n 1.8v 67.995n 1.8v 68.005n 1.8v 77.995n 1.8v 78.005n 1.8v )

Vpc pc 0 pwl(0n 1.8v 85n 1.8v)

.tran 0.01n 85n
.end


