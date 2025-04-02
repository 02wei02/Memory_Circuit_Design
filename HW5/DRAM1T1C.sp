*** 4x4 mini 1T1C DRAM array ***
*** Basic Sense Amplifier Circuit Diagram - DRAM ***
*** .protect
.inc "/home/college/c109501201/Memory/65nm_bulk.pm"
.inc "/home/college/c109501201/HW5/subskt.sp"
.unprotect

.param VCC = 1
.param VOVER = 'VCC + 0.5'
***
.global VSS! VCC!
VCC  VCC! 0   dc VCC
VSS  VSS! 0   dc  0

.IC V(SAN) = 0
.IC V(SAP) = 0

VWL     WL    VSS! pulse(0 'VCC+0.5' -5ns  0.05ns 0.05ns 12ns 14ns)
VINPUT  INPUT VSS! pulse(0     VCC  0.5ns  0.05ns 0.05ns 13.5ns  25ns)

VWE     WE    VSS! pulse(0  'VCC+0.5'  0.5ns  0.05ns 0.05ns 6ns 14ns)
VEQ     EQ    VSS! pulse(VCC    0      -6ns 0.05ns 0.05ns 13ns 14ns)
VCSL    CSL   VSS! pulse(0  'VCC+0.5'  0.5ns  0.05ns 0.05ns 5.5ns 13ns)
VHVCC   HVCC  VSS! dc VCC/2

xinvinput  INPUT INPUTB inv Wp = 0.2 Wn = 0.1

xbuf  INPUT   IN    buf
xbufB INPUTB  INB   buf

*** Write Enable
MNWE1   IN    WE  OUT   gnd  nmos  w = 10u l = 65n
MNWE2   INB   WE  OUTB  gnd  nmos  w = 10u l = 65n


MNCSL1   OUT   CSL   BL   gnd   nmos w = 20u l = 65n
MNCSL2   OUTB  CSL   BLB  gnd   nmos w = 20u l = 65n

*** Voltage Equalization Circuit
MNEQR   BL   EQ  BLB   GND   nmos w = 6u l = 650n
MNEQL1  BL   EQ  HVCC  GND   nmos w = 6u l = 650n
MNEQL2  HVCC EQ  BLB   GND   nmos w = 6u l = 650n

*** Sensing Circuit
MNSC1   BL  BLB  SAN   GND   nmos w = 5u l = 100n
MNSC2   SAN BL   BLB   GND   nmos w = 5u l = 100n
MPSC1   BL  BLB  SAP   VCC!  pmos w = 10u l = 100n
MPSC2   SAP BL   BLB   VCC!  pmos w = 10u l = 100n

* MNCT    CO       WL    BL   GND   nmos w = 10u l = 65n
MNR     cref     WL    BLB  GND   nmos w = 5u l = 65n

* CCT     c1      gnd      1p
CR      cref      gnd      1p    


VIR1     IR1    VSS! dc VCC
VIR0     IR0    VSS! dc 0

VIC1     IC1    VSS! dc VCC
VIC0     IC0    VSS! dc VCC


xD1 IR1 IR0 ROW4 ROW3 ROW2 ROW1 D2to4
xD2 IC1 IC0 WL COL4 COL3 COL2 COL1 D2to4sen

xinvcol0 COL1 COL1B inv
xinvcol1 COL2 COL2B inv
xinvcol2 COL3 COL3B inv
xinvcol3 COL4 COL4B inv

*** SA
xTGc0  out1 BL COL1 COL1B TG
xTGc1  out2 BL COL2 COL2B TG
xTGc2  out3 BL COL3 COL3B TG
xTGc3  out4 BL COL4 COL4B TG


*** Grounded
MNG0  out1 COL1B  gnd  gnd  nmos w = 0.1u l = 65n
MNG1  out2 COL2B  gnd  gnd  nmos w = 0.1u l = 65n
MNG2  out3 COL3B  gnd  gnd  nmos w = 0.1u l = 65n
MNG3  out4 COL4B  gnd  gnd  nmos w = 0.1u l = 65n




.param W1 = 6u
MN11  out1  ROW1 c11  gnd   nmos w = W1 l = 65n
MN12  out2  ROW1 c12  gnd   nmos w = W1 l = 65n
MN13  out3  ROW1 c13  gnd   nmos w = W1 l = 65n
MN14  out4  ROW1 c14  gnd   nmos w = W1 l = 65n

MN21  out1  ROW2 c21  gnd   nmos w = W1 l = 65n
MN22  out2  ROW2 c22  gnd   nmos w = W1 l = 65n
MN23  out3  ROW2 c23  gnd   nmos w = W1 l = 65n
MN24  out4  ROW2 c24  gnd   nmos w = W1 l = 65n

MN31  out1  ROW3 c31  gnd   nmos w = W1 l = 65n
MN32  out2  ROW3 c32  gnd   nmos w = W1 l = 65n
MN33  out3  ROW3 c33  gnd   nmos w = W1 l = 65n
MN34  out4  ROW3 c34  gnd   nmos w = W1 l = 65n

MN41  out1  ROW4 c41  gnd   nmos w = W1 l = 65n
MN42  out2  ROW4 c42  gnd   nmos w = W1 l = 65n
MN43  out3  ROW4 c43  gnd   nmos w = W1 l = 65n
MN44  out4  ROW4 c44  gnd   nmos w = W1 l = 65n

*** Initialize
.IC V(c11) = VCC
.IC V(c12) = VCC
.IC V(c13) = VCC
.IC V(c14) = VCC
.IC V(c21) = 0
.IC V(c22) = 0
.IC V(c23) = 0
.IC V(c24) = VCC
.IC V(c31) = 0
.IC V(c32) = 0
.IC V(c33) = 0
.IC V(c34) = 0
.IC V(c41) = VCC
.IC V(c42) = 0
.IC V(c43) = 0
.IC V(c44) = 0

.param Cp = 1p
C11     c11     gnd     Cp
C12     c12     gnd     Cp
C13     c13     gnd     Cp
C14     c14     gnd     Cp

C21     c21     gnd     Cp
C22     c22     gnd     Cp
C23     c23     gnd     Cp
C24     c24     gnd     Cp

C31     c31     gnd     Cp
C32     c32     gnd     Cp
C33     c33     gnd     Cp
C34     c34     gnd     Cp

C41     c41     gnd     Cp
C42     c42     gnd     Cp
C43     c43     gnd     Cp
C44     c44     gnd     Cp


.tran    1p    28ns 

.option post
.end
