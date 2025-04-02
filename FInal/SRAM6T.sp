************************************************************************
* auCdl Netlist:
* 
* Library Name:  109501201
* Top Cell Name: SRAM6T
* View Name:     schematic
* Netlisted on:  Jan  5 02:19:39 2024
************************************************************************
.TEMP 25
.OPTION POST = 2
.LIB "/E/memory_student/s109501201/sh/N16ADFP_SPICE_MODEL/n16adfp_spice_model_v1d0_usage.l" TTMacro_MOS_MOSCAP
************************************************************************
*.INCLUDE  /E/cad_install/sh/N16ADFP_iPDK/tsmcN16/../Calibre/lvs/source.added
*.BIPOLAR
*.RESI = 2000 
*.RESVAL
*.CAPVAL
*.DIOPERI
*.DIOAREA
*.EQUATION
*.SCALE METER
*.MEGA

************************************************************************
* Library Name: 109501201
* Cell Name:    SRAM6T
* View Name:    schematic
************************************************************************

*.SUBCKT SRAM6T VBL VBLB VDD VSS VWL
*.PININFO VBL:I VBLB:I VDD:I VSS:I VWL:I
MM3 net09 net011 VDD VDD pch_svt_mac l=16.0n nfin=4 m=1
MM0 net011 net09 VDD VDD pch_svt_mac l=16.0n nfin=4 m=1
MM5 VBLB VWL net011 VSS nch_svt_mac l=16.0n nfin=4 m=1
MM4 net09 VWL VBL VSS nch_svt_mac l=16.0n nfin=4 m=1
MM2 net011 net09 VSS VSS nch_svt_mac l=16.0n nfin=4 m=1
MM7 net09 net011 VSS VSS nch_svt_mac l=16.0n nfin=4 m=1
*.ENDS


*************************************************************************
*** change this Vdd = 0.8, 0.6, 0.4
.param V1 = 0.4

*************************************************************************
.global VDD VSS
VSS  VSS  0     dc  0
VDD  VDD  0     dc V1


********************************* source ********************************

VWL  VWL  gnd  dc V1
VBL  VBL  gnd  dc V1
VBLB VBLB gnd  dc 0
**** change this net011(find RSNM) or net09(find WNM)
VIN  net09  gnd

*******************************  circuit *********************************
* XSRAM  VBL VBLB VDD! VSS! VWL SRAM6T


*** only the first dc is effective
.dc VIN  0 V1 0.01V

.probe WNM =   'V(net011)'
.probe RSNM  = 'V(net09)'
.option post
.end
