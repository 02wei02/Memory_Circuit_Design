*** HW3 Basic Sense Amplifier Circuit Diagram - DRAM ***
*** .protect
.inc "/home/college/c109501201/Memory/65nm_bulk.pm"
.unprotect
*** 

.param VCC = 1
.param VOVER = 'VCC + 0.5'
***
.global VSS! VCC!
VCC  VCC! 0   dc VCC
VSS  VSS! 0    dc  0

***inverter
** Mos D G S B
** .ic 是初始偏壓值
.subckt inv in out Wp = 1 Wn = 1
Mp out in VCC! VCC! pmos w= 'Wp * 1u' l=65n m=1
Mn out in VSS! VSS! nmos w= 'Wn * 1u' l=65n m=1
.ends

.subckt buf in out
xinv1 in 1  inv Wp = 20 Wn = 1
xinv2 1 out inv Wp = 40 Wn = 1
.ends

* .IC v(C2)='VCC/2'
* .IC v(BL) = 0
* .IC v(BLB) = 0
.IC V(SAN) = 0
.IC V(SAP) = 0

* VWL     WL    VSS! pulse('VCC+0.4' 0  -0.5ns  0.05ns 0.05ns 2.5ns  10ns)
* VINPUT  INPUT VSS! pulse(0     VCC  -0.5ns  0.05ns 0.05ns 10ns  20ns)
* VPRE    PRE   VSS! pulse(VCC      0 0.5ns  0.05ns 0.05ns 2.5ns 10ns)
* VWE     WE    VSS! pulse(VCC      0  -0.5ns  0.05ns 0.05ns 5ns 10ns)
* VEQ     EQ    VSS! pulse(0    VCC    0.5ns 0.05ns 0.05ns 2ns 10ns)
* VCSL    CSL   VSS! pulse(VCC   0  -0.5ns  0.05ns 0.05ns 4ns 10ns)
* VHVCC   HVCC  VSS! dc VCC/2


VWL     WL    VSS! pulse(0 'VCC+0.5' 0.5ns  0.05ns 0.05ns 8.5ns 10ns)
VINPUT  INPUT VSS! pulse(0     VCC  0.5ns  0.05ns 0.05ns 13.5ns  25ns)
* VPRE    PRE   VSS! pulse(0   VCC  -0.5ns  0.05ns 0.05ns 9.5ns 10ns)
VWE     WE    VSS! pulse(0  'VCC'  0.5ns  0.05ns 0.05ns 3ns 14ns)
VEQ     EQ    VSS! pulse(VCC    0  0ns 0.05ns 0.05ns 9ns 10ns)
VCSL    CSL   VSS! pulse(0  'VCC'  0.5ns  0.05ns 0.05ns 4ns 13ns)
VHVCC   HVCC  VSS! dc VCC/2

xinvinput  INPUT INPUTB inv Wp = 0.2 Wn = 0.1
* xinvinput1 INPUTB INPUT inv Wp = 0.2 Wn = 0.1
* xinvout   OUT   OUTB   inv Wp = 0.2 Wn = 0.1
* xinvout1   OUTB   OUT  inv Wp = 0.2 Wn = 0.1
* xinvbit   BL   BLB     inv Wp = 0.2 Wn = 0.1
* xinvbit1   BLB   BL    inv Wp = 0.2 Wn = 0.1


xbuf  INPUT   IN    buf
xbufB INPUTB  INB   buf

*** Write Enable
MNWE1   IN    WE  OUT   gnd  nmos  w = 10u l = 65n
MNWE2   INB   WE  OUTB  gnd  nmos  w = 10u l = 65n


MNCSL1   OUT   CSL   BL   gnd   nmos w = 10u l = 65n
MNCSL2   OUTB  CSL   BLB  gnd   nmos w = 10u l = 65n

*** Voltage Equalization Circuit
MNEQR   BL   EQ  BLB   GND   nmos w = 6u l = 650n
MNEQL1  BL   EQ  HVCC  GND   nmos w = 6u l = 650n
MNEQL2  HVCC EQ  BLB   GND   nmos w = 6u l = 650n

*** Sensing Circuit
MNSC1   BL  BLB  SAN   GND   nmos w = 5u l = 100n
MNSC2   SAN BL   BLB   GND   nmos w = 5u l = 100n
MPSC1   BL  BLB  SAP   VCC!  pmos w = 10u l = 100n
MPSC2   SAP BL   BLB   VCC!  pmos w = 10u l = 100n

* XSAN BL BLB inv Wp = 0.2 Wn = 0.1

MNCT    BL     WL    c1   GND   nmos w = 5u l = 65n
MNR     c2     WL    BLB  GND   nmos w = 5u l = 65n

CCT     c1      gnd      1p
CR      c2      gnd      1p    

* MPRE1   SAN     PRE     VCC!   VCC!     pmos w = 10u l = 65n
* MPRE2   SAP     PRE     VCC!   VCC!     pmos w = 10u l = 65n

* .probe PWR_BLB =  'I(Mn5)'*'V(BLB)'
* .probe PWR_BL =  'I(Mn6)'*'V(BL)'
.tran    1p    28ns 
* .MEAS TRAN AvgPower AVG(power) FROM=1pS TO=10ns


.option post
.end
