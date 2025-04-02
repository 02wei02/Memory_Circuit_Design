*** subcircuit ***
***inverter
.subckt inv in out Wp = 0.1 Wn = 0.065
Mp out in VCC! VCC! pmos w= 'Wp * 1u' l=65n m=1
Mn out in VSS! VSS! nmos w= 'Wn * 1u' l=65n m=1
.ends
*** TG : Transmission Gate
.subckt TG in out en enbar Wp = 0.4 Wn = 0.2
Mp out enbar in VCC! pmos w= 'Wp * 1u' l=65n m=1
Mn out   en  in VSS! nmos w= 'Wn * 1u' l=65n m=1
.ends

*** buf : buffer
.subckt buf in out
xinv1 in 1  inv Wp = 10 Wn = 1
xinv2 1 out inv Wp = 20 Wn = 1
.ends

*** D2to4 : 2 to 4 decoder
.subckt D2to4 in1 in0 out3 out2 out1 out0
xinv0 in1 in1B inv 
xinv1 in0 in0B inv 

xAND1  in1B in0B out0 AND Wp = 0.2 Wn = 0.1
xAND2  in1B in0  out1 AND Wp = 0.2 Wn = 0.1
xAND3  in1  in0B out2 AND Wp = 0.2 Wn = 0.1
xAND4  in1  in0  out3 AND Wp = 0.2 Wn = 0.1
.ends

*** D2to4 : 2 to 4 decoder Having SA enabler
.subckt D2to4sen in1 in0 sen out3 out2 out1 out0
xinv0 in1 in1B inv 
xinv1 in0 in0B inv 

xAND1  in1B in0B sen out0 AND3 Wp = 0.2 Wn = 0.1
xAND2  in1B in0  sen out1 AND3 Wp = 0.2 Wn = 0.1
xAND3  in1  in0B sen out2 AND3 Wp = 0.2 Wn = 0.1
xAND4  in1  in0  sen out3 AND3 Wp = 0.2 Wn = 0.1
.ends


*** AND Gate for 2 inputs
.subckt AND in1 in2 out Wp = 0.2 Wn = 0.1
Mn1  1    in1     gnd gnd  nmos  w= 'Wn * 1u' l=65n m=1
Mn2  nout in2     1   gnd  nmos  w= 'Wn * 1u' l=65n m=1

Mp1  nout in1     VCC! VCC! pmos w= 'Wp * 1u' l=65n m=1
Mp2  nout in2     VCC! VCC! pmos w= 'Wp * 1u' l=65n m=1
xinv nout out inv
.ends

*** AND for 3 inputs
.subckt AND3 in1 in2 in3 out Wp = 0.2 Wn = 0.1
Mn1  1    in1     gnd gnd  nmos  w= 'Wn * 1u' l=65n m=1
Mn2  2    in2     1   gnd  nmos  w= 'Wn * 1u' l=65n m=1
Mn3  nout in3     2   gnd  nmos  w= 'Wn * 1u' l=65n m=1


Mp1  nout in1     VCC! VCC! pmos w= 'Wp * 1u' l=65n m=1
Mp2  nout in2     VCC! VCC! pmos w= 'Wp * 1u' l=65n m=1
Mp3  nout in3     VCC! VCC! pmos w= 'Wp * 1u' l=65n m=1
xinv nout out inv
.ends

