*** NAND-type TCAM ***
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
* VPRE PRE VSS! pulse(0  VDD  -0.7ns 0.05ns 0.05ns 1.9ns 2ns)
* VB    BL VSS!   pulse(VDD  0   -0.1ns 0.05ns 0.05ns 2ns 4ns)
* VD  DL VSS!   pulse(VDD  0   -0.1ns 0.05ns 0.05ns 4ns 8ns)
* VWE   WE VSS! pulse(0V VDD 0ns 0.05ns 0.05ns 4ns 8ns)
* xweb WE WEB inv Wp = 0.25 Wn = 0.1
xinvB BL BLB  inv Wp = 0.25 Wn = 0.1
xinvD DL DLB  inv Wp = 0.25 Wn = 0.1

*** search
VWL   WL VSS! pulse(0  VDD  0.1ns 0.05ns 0.05ns 1ns 2ns)
VPRE PRE VSS! pulse(0  VDD  -0.7ns 0.05ns 0.05ns 1.5ns 2ns)
VD  DL VSS!   pulse(0  VDD  0.1ns 0.05ns 0.05ns 8ns 16ns)
* VB    BL VSS!   pulse(VDD  0   -0.1ns 0.05ns 0.05ns 2ns 4ns)
VB    BL VSS!    PWL(0n 0V 2n 0V 2.1n VDD 4n VDD 4.1n 0V 5.1n 0V 5.2n VDD 7.2n VDD 7.3n 0V)


* Mpl BL PRE  VDD! VDD! pmos w = 0.1u l = 65n
* Mp2 BLB PRE VDD! VDD! pmos w = 0.1u l = 65n

*** Comparison data (SRAM)
* MnB   INB  WE  BL  gnd nmos w = 0.1u l = 65n
* MpB   INB  WEB BL  gnd pmos w = 0.1u l = 65n
* MnBB INBB  WE  BLB gnd nmos w = 0.1u l = 65n
* MpBB INBB  WEB BLB gnd pmos w = 0.1u l = 65n



xinv1 QiB Qi         inv Wp = 0.25 Wn = 0.1
Mn5   Qi  WL BL  gnd nmos w = 1u l = 0.2u

xinv2 Qi  QiB        inv  Wp = 0.25 Wn = 0.1
Mn6   QiB WL BLB gnd nmos w = 1u l = 0.2u


*** Don't-care data (SRAM)
* MnD  IND  WE  DL  gnd nmos w = 0.1u l = 65n
* MpD  IND  WEB DL  gnd pmos w = 0.1u l = 65n
* MnDB INDB WE  DLB gnd nmos w = 0.1u l = 65n
* MpDB INDB WEB DLB gnd pmos w = 0.1u l = 65n

xinv3 QjB Qj         inv  Wp = 0.25 Wn = 0.1
Mn7   Qj  WL  DL  gnd nmos w = 1u l = 0.2u

xinv4 Qj  QjB         inv Wp = 0.25 Wn = 0.1
Mn8   QjB WL  DLB gnd nmos w = 1u l = 0.2u

*** ML
MNmu  ML1  mid ML2  gnd nmos w = 5u l = 65n
MNmd  ML1  Qj  ML2   gnd nmos w = 5u l = 65n

Mpmlu ML1  PRE  VDD! VDD! pmos w = 1u l = 65n
Mnmld ML2  PRE  gnd  gnd  nmos w = 1u l = 65n


*** mid
Mn9   BL    Qi   mid  gnd nmos w = 5u l = 65n
Mn10  BLB   QiB  mid  gnd nmos w = 5u l = 65n


* .probe PWR_BLB = 'I(Mn5)'*'V(BLB)'
* .probe PWR_BL =  'I(Mn6)'*'V(BL)'
.tran    1p    8ns 
* .MEAS TRAN AvgPower AVG(power) FROM=1pS TO=10ns


.option post
.end

