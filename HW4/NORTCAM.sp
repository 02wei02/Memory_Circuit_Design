*** NOR-type TCAM ***
*** .protect
.inc "/home/college/c109501201/Memory/65nm_bulk.pm"
.unprotect
*** 

.param VDD = 1
***
.global VSS! VDD!
VDD    VDD! 0   dc VDD
VSS    VSS! 0    dc  0

***inverter
** Mos D G S B
** .ic 是初始偏壓值
.subckt inv in out Wp = 1 Wn = 1
Mp out in VDD! VDD! pmos w= 'Wp * 1u' l=65n m=1
Mn out in VSS! VSS! nmos w= 'Wn * 1u' l=65n m=1
.ends

*** store
* VWL   WL VSS! pulse(0  VDD  0.1ns 0.05ns 0.05ns 1ns 2ns)
* VPRE PRE VSS! pulse(0  VDD  -0.7ns 0.05ns 0.05ns 1.5ns 2ns)
* VS   SL VSS!   pulse(VDD  0   -0.1ns 0.05ns 0.05ns 2ns 4ns)
* VSB  SLB VSS!   pulse(0  VDD   0.1ns 0.05ns 0.05ns 2ns 4ns)
* VD   BL VSS!   pulse(VDD  0   -0.1ns 0.05ns 0.05ns 4ns 8ns)
* VDB  BLB VSS!   pulse(0  VDD   0.1ns 0.05ns 0.05ns 4ns 8ns)
* VWE   WE VSS! pulse(0V VDD 0ns 0.05ns 0.05ns 4ns 8ns)
* xweb WE WEB inv Wp = 0.25 Wn = 0.1
* xinvB BL BLB  inv Wp = 0.25 Wn = 0.1
* xinvD BL BLB  inv Wp = 0.25 Wn = 0.1

*** search care mode
* VWL   WL VSS! pulse(0  VDD  0.1ns 0.05ns 0.05ns 1ns 2ns)
* VPRE PRE VSS! pulse(0  VDD  -0.7ns 0.05ns 0.05ns 1.5ns 2ns)
* VS   SL VSS!   pulse(VDD  0   -0.1ns 0.05ns 0.05ns 2ns 4ns)
* VSB  SLB VSS!   pulse(0  VDD   0.1ns 0.05ns 0.05ns 2ns 4ns)
* VD   BL VSS!   pulse(VDD  0   -0.1ns 0.05ns 0.05ns 4ns 8ns)
* VDB  BLB VSS!   pulse(0  VDD   0.1ns 0.05ns 0.05ns 4ns 8ns)


*** search don't care mode
VWL   WL VSS! pulse(0  VDD  0.1ns 0.05ns 0.05ns 1ns 2ns)
VPRE PRE VSS! pulse(0  VDD  -0.7ns 0.05ns 0.05ns 1.5ns 2ns)
VS   SL VSS!   pulse(VDD  0   -0.1ns 0.05ns 0.05ns 4ns 8ns)
VSB  SLB VSS!   pulse(0  VDD   0.1ns 0.05ns 0.05ns 2ns 4ns)
VD   BL VSS!   dc VDD
VDB  BLB VSS!  dc VDD

* VWL   WL VSS! pulse(0  VDD  0.1ns 0.05ns 0.05ns 1ns 2ns)
* VPRE PRE VSS! pulse(0  VDD  -0.7ns 0.05ns 0.05ns 1.5ns 2ns)
* VS   SL VSS!   dc 0
* VSB  SLB VSS!  dc 0
* VD   BL VSS!   pulse(VDD  0   -0.1ns 0.05ns 0.05ns 4ns 8ns)
* VDB  BLB VSS!  pulse(0  VDD   0.1ns 0.05ns 0.05ns 2ns 4ns)


*** precharge
Mpmlu ML  PRE  VDD! VDD! pmos w = 1u l = 65n


xinv1   m1g     Qi              inv Wp = 0.25 Wn = 0.1
xinv2   Qi      m1g             inv  Wp = 0.25 Wn = 0.1
MNwd    Qi       WL    BL   gnd nmos w = 5u l = 65n

xinv3   m2g     QiB         inv Wp = 0.25 Wn = 0.1
xinv4   QiB    m2g          inv  Wp = 0.25 Wn = 0.1
MNwdb   QiB    WL   BLB   gnd nmos w = 5u l = 65n


MN1   ML   m1g   1     gnd  nmos w = 1u l = 0.2u
MN3   1    SL    gnd   gnd  nmos w = 1u l = 0.2u

MN2   ML   m2g    2     gnd  nmos w = 1u l = 0.2u
MN4   2    SLB    gnd   gnd  nmos w = 1u l = 0.2u


.tran    1p    8ns 
.MEAS TRAN AvgPower AVG(power) FROM=1pS TO=10ns


.option post
.end


