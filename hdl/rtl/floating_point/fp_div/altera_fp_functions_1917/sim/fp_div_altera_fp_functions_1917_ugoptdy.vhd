-- ------------------------------------------------------------------------- 
-- High Level Design Compiler for Intel(R) FPGAs Version 23.3 (Release Build #f9894c94f4)
-- Quartus Prime development tool and MATLAB/Simulink Interface
-- 
-- Legal Notice: Copyright 2023 Intel Corporation.  All rights reserved.
-- Your use of  Intel Corporation's design tools,  logic functions and other
-- software and  tools, and its AMPP partner logic functions, and any output
-- files any  of the foregoing (including  device programming  or simulation
-- files), and  any associated  documentation  or information  are expressly
-- subject  to the terms and  conditions of the  Intel FPGA Software License
-- Agreement, Intel MegaCore Function License Agreement, or other applicable
-- license agreement,  including,  without limitation,  that your use is for
-- the  sole  purpose of  programming  logic devices  manufactured by  Intel
-- and  sold by Intel  or its authorized  distributors. Please refer  to the
-- applicable agreement for further details.
-- ---------------------------------------------------------------------------

-- VHDL created from fp_div_altera_fp_functions_1917_ugoptdy
-- VHDL created on Thu Nov 23 21:06:16 2023


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;
use IEEE.MATH_REAL.all;
use std.TextIO.all;
use work.dspba_library_package.all;

LIBRARY altera_mf;
USE altera_mf.altera_mf_components.all;
LIBRARY altera_lnsim;
USE altera_lnsim.altera_lnsim_components.altera_syncram;

library cyclone10gx;
use cyclone10gx.cyclone10gx_components.cyclone10gx_mac;
use cyclone10gx.cyclone10gx_components.cyclone10gx_fp_mac;

entity fp_div_altera_fp_functions_1917_ugoptdy is
    port (
        a : in std_logic_vector(31 downto 0);  -- float32_m23
        b : in std_logic_vector(31 downto 0);  -- float32_m23
        q : out std_logic_vector(31 downto 0);  -- float32_m23
        clk : in std_logic;
        areset : in std_logic
    );
end fp_div_altera_fp_functions_1917_ugoptdy;

architecture normal of fp_div_altera_fp_functions_1917_ugoptdy is

    attribute altera_attribute : string;
    attribute altera_attribute of normal : architecture is "-name AUTO_SHIFT_REGISTER_RECOGNITION OFF; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 10037; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 15400; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 12020; -name MESSAGE_DISABLE 12030; -name MESSAGE_DISABLE 12010; -name MESSAGE_DISABLE 12110; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 13410; -name MESSAGE_DISABLE 113007";
    
    signal GND_q : STD_LOGIC_VECTOR (0 downto 0);
    signal VCC_q : STD_LOGIC_VECTOR (0 downto 0);
    signal cstBiasM1_uid6_fpDivTest_q : STD_LOGIC_VECTOR (7 downto 0);
    signal cstBias_uid7_fpDivTest_q : STD_LOGIC_VECTOR (7 downto 0);
    signal expX_uid9_fpDivTest_b : STD_LOGIC_VECTOR (7 downto 0);
    signal fracX_uid10_fpDivTest_b : STD_LOGIC_VECTOR (22 downto 0);
    signal signX_uid11_fpDivTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal expY_uid12_fpDivTest_b : STD_LOGIC_VECTOR (7 downto 0);
    signal fracY_uid13_fpDivTest_b : STD_LOGIC_VECTOR (22 downto 0);
    signal signY_uid14_fpDivTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal fracYZero_uid15_fpDivTest_a : STD_LOGIC_VECTOR (23 downto 0);
    signal fracYZero_uid15_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal cstAllOWE_uid18_fpDivTest_q : STD_LOGIC_VECTOR (7 downto 0);
    signal cstZeroWF_uid19_fpDivTest_q : STD_LOGIC_VECTOR (22 downto 0);
    signal cstAllZWE_uid20_fpDivTest_q : STD_LOGIC_VECTOR (7 downto 0);
    signal excZ_x_uid23_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal expXIsMax_uid24_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fracXIsZero_uid25_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fracXIsNotZero_uid26_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excI_x_uid27_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excN_x_uid28_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal invExpXIsMax_uid29_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal InvExpXIsZero_uid30_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excR_x_uid31_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excZ_y_uid37_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal expXIsMax_uid38_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fracXIsZero_uid39_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fracXIsNotZero_uid40_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excI_y_uid41_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excN_y_uid42_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal invExpXIsMax_uid43_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal InvExpXIsZero_uid44_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excR_y_uid45_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal signR_uid46_fpDivTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal signR_uid46_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal expXmY_uid47_fpDivTest_a : STD_LOGIC_VECTOR (8 downto 0);
    signal expXmY_uid47_fpDivTest_b : STD_LOGIC_VECTOR (8 downto 0);
    signal expXmY_uid47_fpDivTest_o : STD_LOGIC_VECTOR (8 downto 0);
    signal expXmY_uid47_fpDivTest_q : STD_LOGIC_VECTOR (8 downto 0);
    signal expR_uid48_fpDivTest_a : STD_LOGIC_VECTOR (10 downto 0);
    signal expR_uid48_fpDivTest_b : STD_LOGIC_VECTOR (10 downto 0);
    signal expR_uid48_fpDivTest_o : STD_LOGIC_VECTOR (10 downto 0);
    signal expR_uid48_fpDivTest_q : STD_LOGIC_VECTOR (9 downto 0);
    signal yAddr_uid51_fpDivTest_b : STD_LOGIC_VECTOR (8 downto 0);
    signal yPE_uid52_fpDivTest_b : STD_LOGIC_VECTOR (13 downto 0);
    signal invY_uid54_fpDivTest_in : STD_LOGIC_VECTOR (31 downto 0);
    signal invY_uid54_fpDivTest_b : STD_LOGIC_VECTOR (26 downto 0);
    signal invYO_uid55_fpDivTest_in : STD_LOGIC_VECTOR (32 downto 0);
    signal invYO_uid55_fpDivTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal lOAdded_uid57_fpDivTest_q : STD_LOGIC_VECTOR (23 downto 0);
    signal z4_uid60_fpDivTest_q : STD_LOGIC_VECTOR (3 downto 0);
    signal oFracXZ4_uid61_fpDivTest_q : STD_LOGIC_VECTOR (27 downto 0);
    signal divValPreNormYPow2Exc_uid63_fpDivTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal divValPreNormYPow2Exc_uid63_fpDivTest_q : STD_LOGIC_VECTOR (27 downto 0);
    signal norm_uid64_fpDivTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal divValPreNormHigh_uid65_fpDivTest_in : STD_LOGIC_VECTOR (26 downto 0);
    signal divValPreNormHigh_uid65_fpDivTest_b : STD_LOGIC_VECTOR (24 downto 0);
    signal divValPreNormLow_uid66_fpDivTest_in : STD_LOGIC_VECTOR (25 downto 0);
    signal divValPreNormLow_uid66_fpDivTest_b : STD_LOGIC_VECTOR (24 downto 0);
    signal normFracRnd_uid67_fpDivTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal normFracRnd_uid67_fpDivTest_q : STD_LOGIC_VECTOR (24 downto 0);
    signal expFracRnd_uid68_fpDivTest_q : STD_LOGIC_VECTOR (34 downto 0);
    signal zeroPaddingInAddition_uid74_fpDivTest_q : STD_LOGIC_VECTOR (23 downto 0);
    signal expFracPostRnd_uid75_fpDivTest_q : STD_LOGIC_VECTOR (25 downto 0);
    signal expFracPostRnd_uid76_fpDivTest_a : STD_LOGIC_VECTOR (36 downto 0);
    signal expFracPostRnd_uid76_fpDivTest_b : STD_LOGIC_VECTOR (36 downto 0);
    signal expFracPostRnd_uid76_fpDivTest_o : STD_LOGIC_VECTOR (36 downto 0);
    signal expFracPostRnd_uid76_fpDivTest_q : STD_LOGIC_VECTOR (35 downto 0);
    signal fracXExt_uid77_fpDivTest_q : STD_LOGIC_VECTOR (23 downto 0);
    signal fracPostRndF_uid79_fpDivTest_in : STD_LOGIC_VECTOR (24 downto 0);
    signal fracPostRndF_uid79_fpDivTest_b : STD_LOGIC_VECTOR (23 downto 0);
    signal fracPostRndF_uid80_fpDivTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal fracPostRndF_uid80_fpDivTest_q : STD_LOGIC_VECTOR (23 downto 0);
    signal expPostRndFR_uid81_fpDivTest_in : STD_LOGIC_VECTOR (32 downto 0);
    signal expPostRndFR_uid81_fpDivTest_b : STD_LOGIC_VECTOR (7 downto 0);
    signal expPostRndF_uid82_fpDivTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal expPostRndF_uid82_fpDivTest_q : STD_LOGIC_VECTOR (7 downto 0);
    signal lOAdded_uid84_fpDivTest_q : STD_LOGIC_VECTOR (24 downto 0);
    signal lOAdded_uid87_fpDivTest_q : STD_LOGIC_VECTOR (23 downto 0);
    signal qDivProdNorm_uid90_fpDivTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal qDivProdFracHigh_uid91_fpDivTest_in : STD_LOGIC_VECTOR (47 downto 0);
    signal qDivProdFracHigh_uid91_fpDivTest_b : STD_LOGIC_VECTOR (23 downto 0);
    signal qDivProdFracLow_uid92_fpDivTest_in : STD_LOGIC_VECTOR (46 downto 0);
    signal qDivProdFracLow_uid92_fpDivTest_b : STD_LOGIC_VECTOR (23 downto 0);
    signal qDivProdFrac_uid93_fpDivTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal qDivProdFrac_uid93_fpDivTest_q : STD_LOGIC_VECTOR (23 downto 0);
    signal qDivProdExp_opA_uid94_fpDivTest_a : STD_LOGIC_VECTOR (8 downto 0);
    signal qDivProdExp_opA_uid94_fpDivTest_b : STD_LOGIC_VECTOR (8 downto 0);
    signal qDivProdExp_opA_uid94_fpDivTest_o : STD_LOGIC_VECTOR (8 downto 0);
    signal qDivProdExp_opA_uid94_fpDivTest_q : STD_LOGIC_VECTOR (8 downto 0);
    signal qDivProdExp_opBs_uid95_fpDivTest_a : STD_LOGIC_VECTOR (8 downto 0);
    signal qDivProdExp_opBs_uid95_fpDivTest_b : STD_LOGIC_VECTOR (8 downto 0);
    signal qDivProdExp_opBs_uid95_fpDivTest_o : STD_LOGIC_VECTOR (8 downto 0);
    signal qDivProdExp_opBs_uid95_fpDivTest_q : STD_LOGIC_VECTOR (8 downto 0);
    signal qDivProdExp_uid96_fpDivTest_a : STD_LOGIC_VECTOR (11 downto 0);
    signal qDivProdExp_uid96_fpDivTest_b : STD_LOGIC_VECTOR (11 downto 0);
    signal qDivProdExp_uid96_fpDivTest_o : STD_LOGIC_VECTOR (11 downto 0);
    signal qDivProdExp_uid96_fpDivTest_q : STD_LOGIC_VECTOR (10 downto 0);
    signal qDivProdFracWF_uid97_fpDivTest_b : STD_LOGIC_VECTOR (22 downto 0);
    signal qDivProdLTX_opA_uid98_fpDivTest_in : STD_LOGIC_VECTOR (7 downto 0);
    signal qDivProdLTX_opA_uid98_fpDivTest_b : STD_LOGIC_VECTOR (7 downto 0);
    signal qDivProdLTX_opA_uid99_fpDivTest_q : STD_LOGIC_VECTOR (30 downto 0);
    signal qDivProdLTX_opB_uid100_fpDivTest_q : STD_LOGIC_VECTOR (30 downto 0);
    signal qDividerProdLTX_uid101_fpDivTest_a : STD_LOGIC_VECTOR (32 downto 0);
    signal qDividerProdLTX_uid101_fpDivTest_b : STD_LOGIC_VECTOR (32 downto 0);
    signal qDividerProdLTX_uid101_fpDivTest_o : STD_LOGIC_VECTOR (32 downto 0);
    signal qDividerProdLTX_uid101_fpDivTest_c : STD_LOGIC_VECTOR (0 downto 0);
    signal betweenFPwF_uid102_fpDivTest_in : STD_LOGIC_VECTOR (0 downto 0);
    signal betweenFPwF_uid102_fpDivTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal extraUlp_uid103_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fracPostRndFT_uid104_fpDivTest_b : STD_LOGIC_VECTOR (22 downto 0);
    signal fracRPreExcExt_uid105_fpDivTest_a : STD_LOGIC_VECTOR (23 downto 0);
    signal fracRPreExcExt_uid105_fpDivTest_b : STD_LOGIC_VECTOR (23 downto 0);
    signal fracRPreExcExt_uid105_fpDivTest_o : STD_LOGIC_VECTOR (23 downto 0);
    signal fracRPreExcExt_uid105_fpDivTest_q : STD_LOGIC_VECTOR (23 downto 0);
    signal fracPostRndFPostUlp_uid106_fpDivTest_in : STD_LOGIC_VECTOR (22 downto 0);
    signal fracPostRndFPostUlp_uid106_fpDivTest_b : STD_LOGIC_VECTOR (22 downto 0);
    signal fracRPreExc_uid107_fpDivTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal fracRPreExc_uid107_fpDivTest_q : STD_LOGIC_VECTOR (22 downto 0);
    signal ovfIncRnd_uid109_fpDivTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal expFracPostRndInc_uid110_fpDivTest_a : STD_LOGIC_VECTOR (8 downto 0);
    signal expFracPostRndInc_uid110_fpDivTest_b : STD_LOGIC_VECTOR (8 downto 0);
    signal expFracPostRndInc_uid110_fpDivTest_o : STD_LOGIC_VECTOR (8 downto 0);
    signal expFracPostRndInc_uid110_fpDivTest_q : STD_LOGIC_VECTOR (8 downto 0);
    signal expFracPostRndR_uid111_fpDivTest_in : STD_LOGIC_VECTOR (7 downto 0);
    signal expFracPostRndR_uid111_fpDivTest_b : STD_LOGIC_VECTOR (7 downto 0);
    signal expRPreExc_uid112_fpDivTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal expRPreExc_uid112_fpDivTest_q : STD_LOGIC_VECTOR (7 downto 0);
    signal expRExt_uid114_fpDivTest_b : STD_LOGIC_VECTOR (10 downto 0);
    signal expUdf_uid115_fpDivTest_a : STD_LOGIC_VECTOR (12 downto 0);
    signal expUdf_uid115_fpDivTest_b : STD_LOGIC_VECTOR (12 downto 0);
    signal expUdf_uid115_fpDivTest_o : STD_LOGIC_VECTOR (12 downto 0);
    signal expUdf_uid115_fpDivTest_n : STD_LOGIC_VECTOR (0 downto 0);
    signal expOvf_uid118_fpDivTest_a : STD_LOGIC_VECTOR (12 downto 0);
    signal expOvf_uid118_fpDivTest_b : STD_LOGIC_VECTOR (12 downto 0);
    signal expOvf_uid118_fpDivTest_o : STD_LOGIC_VECTOR (12 downto 0);
    signal expOvf_uid118_fpDivTest_n : STD_LOGIC_VECTOR (0 downto 0);
    signal zeroOverReg_uid119_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal regOverRegWithUf_uid120_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal xRegOrZero_uid121_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal regOrZeroOverInf_uid122_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excRZero_uid123_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excXRYZ_uid124_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excXRYROvf_uid125_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excXIYZ_uid126_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excXIYR_uid127_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excRInf_uid128_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excXZYZ_uid129_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excXIYI_uid130_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excRNaN_uid131_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal concExc_uid132_fpDivTest_q : STD_LOGIC_VECTOR (2 downto 0);
    signal excREnc_uid133_fpDivTest_q : STD_LOGIC_VECTOR (1 downto 0);
    signal oneFracRPostExc2_uid134_fpDivTest_q : STD_LOGIC_VECTOR (22 downto 0);
    signal fracRPostExc_uid137_fpDivTest_s : STD_LOGIC_VECTOR (1 downto 0);
    signal fracRPostExc_uid137_fpDivTest_q : STD_LOGIC_VECTOR (22 downto 0);
    signal expRPostExc_uid141_fpDivTest_s : STD_LOGIC_VECTOR (1 downto 0);
    signal expRPostExc_uid141_fpDivTest_q : STD_LOGIC_VECTOR (7 downto 0);
    signal invExcRNaN_uid142_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal sRPostExc_uid143_fpDivTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal sRPostExc_uid143_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal divR_uid144_fpDivTest_q : STD_LOGIC_VECTOR (31 downto 0);
    signal yT1_uid158_invPolyEval_b : STD_LOGIC_VECTOR (12 downto 0);
    signal lowRangeB_uid160_invPolyEval_in : STD_LOGIC_VECTOR (0 downto 0);
    signal lowRangeB_uid160_invPolyEval_b : STD_LOGIC_VECTOR (0 downto 0);
    signal highBBits_uid161_invPolyEval_b : STD_LOGIC_VECTOR (12 downto 0);
    signal s1sumAHighB_uid162_invPolyEval_a : STD_LOGIC_VECTOR (22 downto 0);
    signal s1sumAHighB_uid162_invPolyEval_b : STD_LOGIC_VECTOR (22 downto 0);
    signal s1sumAHighB_uid162_invPolyEval_o : STD_LOGIC_VECTOR (22 downto 0);
    signal s1sumAHighB_uid162_invPolyEval_q : STD_LOGIC_VECTOR (22 downto 0);
    signal s1_uid163_invPolyEval_q : STD_LOGIC_VECTOR (23 downto 0);
    signal lowRangeB_uid166_invPolyEval_in : STD_LOGIC_VECTOR (1 downto 0);
    signal lowRangeB_uid166_invPolyEval_b : STD_LOGIC_VECTOR (1 downto 0);
    signal highBBits_uid167_invPolyEval_b : STD_LOGIC_VECTOR (22 downto 0);
    signal s2sumAHighB_uid168_invPolyEval_a : STD_LOGIC_VECTOR (32 downto 0);
    signal s2sumAHighB_uid168_invPolyEval_b : STD_LOGIC_VECTOR (32 downto 0);
    signal s2sumAHighB_uid168_invPolyEval_o : STD_LOGIC_VECTOR (32 downto 0);
    signal s2sumAHighB_uid168_invPolyEval_q : STD_LOGIC_VECTOR (32 downto 0);
    signal s2_uid169_invPolyEval_q : STD_LOGIC_VECTOR (34 downto 0);
    signal osig_uid172_divValPreNorm_uid59_fpDivTest_b : STD_LOGIC_VECTOR (27 downto 0);
    signal osig_uid175_pT1_uid159_invPolyEval_b : STD_LOGIC_VECTOR (13 downto 0);
    signal osig_uid178_pT2_uid165_invPolyEval_b : STD_LOGIC_VECTOR (24 downto 0);
    signal rndOne_uid72_fpDivTest_b_const_q : STD_LOGIC_VECTOR (0 downto 0);
    signal memoryC0_uid146_invTables_lutmem_reset0 : std_logic;
    signal memoryC0_uid146_invTables_lutmem_ena_NotRstA : std_logic;
    signal memoryC0_uid146_invTables_lutmem_ia : STD_LOGIC_VECTOR (31 downto 0);
    signal memoryC0_uid146_invTables_lutmem_aa : STD_LOGIC_VECTOR (8 downto 0);
    signal memoryC0_uid146_invTables_lutmem_ab : STD_LOGIC_VECTOR (8 downto 0);
    signal memoryC0_uid146_invTables_lutmem_ir : STD_LOGIC_VECTOR (31 downto 0);
    signal memoryC0_uid146_invTables_lutmem_r : STD_LOGIC_VECTOR (31 downto 0);
    signal memoryC1_uid149_invTables_lutmem_reset0 : std_logic;
    signal memoryC1_uid149_invTables_lutmem_ena_NotRstA : std_logic;
    signal memoryC1_uid149_invTables_lutmem_ia : STD_LOGIC_VECTOR (21 downto 0);
    signal memoryC1_uid149_invTables_lutmem_aa : STD_LOGIC_VECTOR (8 downto 0);
    signal memoryC1_uid149_invTables_lutmem_ab : STD_LOGIC_VECTOR (8 downto 0);
    signal memoryC1_uid149_invTables_lutmem_ir : STD_LOGIC_VECTOR (21 downto 0);
    signal memoryC1_uid149_invTables_lutmem_r : STD_LOGIC_VECTOR (21 downto 0);
    signal memoryC2_uid152_invTables_lutmem_reset0 : std_logic;
    signal memoryC2_uid152_invTables_lutmem_ena_NotRstA : std_logic;
    signal memoryC2_uid152_invTables_lutmem_ia : STD_LOGIC_VECTOR (12 downto 0);
    signal memoryC2_uid152_invTables_lutmem_aa : STD_LOGIC_VECTOR (8 downto 0);
    signal memoryC2_uid152_invTables_lutmem_ab : STD_LOGIC_VECTOR (8 downto 0);
    signal memoryC2_uid152_invTables_lutmem_ir : STD_LOGIC_VECTOR (12 downto 0);
    signal memoryC2_uid152_invTables_lutmem_r : STD_LOGIC_VECTOR (12 downto 0);
    signal qDivProd_uid89_fpDivTest_cma_reset : std_logic;
    signal qDivProd_uid89_fpDivTest_cma_a0 : STD_LOGIC_VECTOR (24 downto 0);
    signal qDivProd_uid89_fpDivTest_cma_c0 : STD_LOGIC_VECTOR (23 downto 0);
    signal qDivProd_uid89_fpDivTest_cma_s0 : STD_LOGIC_VECTOR (48 downto 0);
    signal qDivProd_uid89_fpDivTest_cma_qq0 : STD_LOGIC_VECTOR (48 downto 0);
    signal qDivProd_uid89_fpDivTest_cma_q : STD_LOGIC_VECTOR (48 downto 0);
    signal qDivProd_uid89_fpDivTest_cma_ena0 : std_logic;
    signal qDivProd_uid89_fpDivTest_cma_ena1 : std_logic;
    signal qDivProd_uid89_fpDivTest_cma_ena2 : std_logic;
    signal prodXY_uid171_divValPreNorm_uid59_fpDivTest_cma_reset : std_logic;
    signal prodXY_uid171_divValPreNorm_uid59_fpDivTest_cma_a0 : STD_LOGIC_VECTOR (26 downto 0);
    signal prodXY_uid171_divValPreNorm_uid59_fpDivTest_cma_c0 : STD_LOGIC_VECTOR (23 downto 0);
    signal prodXY_uid171_divValPreNorm_uid59_fpDivTest_cma_s0 : STD_LOGIC_VECTOR (50 downto 0);
    signal prodXY_uid171_divValPreNorm_uid59_fpDivTest_cma_qq0 : STD_LOGIC_VECTOR (50 downto 0);
    signal prodXY_uid171_divValPreNorm_uid59_fpDivTest_cma_q : STD_LOGIC_VECTOR (50 downto 0);
    signal prodXY_uid171_divValPreNorm_uid59_fpDivTest_cma_ena0 : std_logic;
    signal prodXY_uid171_divValPreNorm_uid59_fpDivTest_cma_ena1 : std_logic;
    signal prodXY_uid171_divValPreNorm_uid59_fpDivTest_cma_ena2 : std_logic;
    signal prodXY_uid174_pT1_uid159_invPolyEval_cma_reset : std_logic;
    signal prodXY_uid174_pT1_uid159_invPolyEval_cma_a0 : STD_LOGIC_VECTOR (12 downto 0);
    signal prodXY_uid174_pT1_uid159_invPolyEval_cma_c0 : STD_LOGIC_VECTOR (12 downto 0);
    signal prodXY_uid174_pT1_uid159_invPolyEval_cma_s0 : STD_LOGIC_VECTOR (25 downto 0);
    signal prodXY_uid174_pT1_uid159_invPolyEval_cma_qq0 : STD_LOGIC_VECTOR (25 downto 0);
    signal prodXY_uid174_pT1_uid159_invPolyEval_cma_q : STD_LOGIC_VECTOR (25 downto 0);
    signal prodXY_uid174_pT1_uid159_invPolyEval_cma_ena0 : std_logic;
    signal prodXY_uid174_pT1_uid159_invPolyEval_cma_ena1 : std_logic;
    signal prodXY_uid174_pT1_uid159_invPolyEval_cma_ena2 : std_logic;
    signal prodXY_uid177_pT2_uid165_invPolyEval_cma_reset : std_logic;
    signal prodXY_uid177_pT2_uid165_invPolyEval_cma_a0 : STD_LOGIC_VECTOR (13 downto 0);
    signal prodXY_uid177_pT2_uid165_invPolyEval_cma_c0 : STD_LOGIC_VECTOR (23 downto 0);
    signal prodXY_uid177_pT2_uid165_invPolyEval_cma_s0 : STD_LOGIC_VECTOR (37 downto 0);
    signal prodXY_uid177_pT2_uid165_invPolyEval_cma_qq0 : STD_LOGIC_VECTOR (37 downto 0);
    signal prodXY_uid177_pT2_uid165_invPolyEval_cma_q : STD_LOGIC_VECTOR (37 downto 0);
    signal prodXY_uid177_pT2_uid165_invPolyEval_cma_ena0 : std_logic;
    signal prodXY_uid177_pT2_uid165_invPolyEval_cma_ena1 : std_logic;
    signal prodXY_uid177_pT2_uid165_invPolyEval_cma_ena2 : std_logic;
    signal redist0_sRPostExc_uid143_fpDivTest_q_3_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist0_sRPostExc_uid143_fpDivTest_q_3_delay_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal redist1_excREnc_uid133_fpDivTest_q_3_q : STD_LOGIC_VECTOR (1 downto 0);
    signal redist1_excREnc_uid133_fpDivTest_q_3_delay_0 : STD_LOGIC_VECTOR (1 downto 0);
    signal redist2_fracPostRndFT_uid104_fpDivTest_b_3_q : STD_LOGIC_VECTOR (22 downto 0);
    signal redist2_fracPostRndFT_uid104_fpDivTest_b_3_delay_0 : STD_LOGIC_VECTOR (22 downto 0);
    signal redist2_fracPostRndFT_uid104_fpDivTest_b_3_delay_1 : STD_LOGIC_VECTOR (22 downto 0);
    signal redist3_betweenFPwF_uid102_fpDivTest_b_3_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist3_betweenFPwF_uid102_fpDivTest_b_3_delay_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal redist3_betweenFPwF_uid102_fpDivTest_b_3_delay_1 : STD_LOGIC_VECTOR (0 downto 0);
    signal redist4_qDivProdLTX_opB_uid100_fpDivTest_q_3_q : STD_LOGIC_VECTOR (30 downto 0);
    signal redist4_qDivProdLTX_opB_uid100_fpDivTest_q_3_delay_0 : STD_LOGIC_VECTOR (30 downto 0);
    signal redist5_qDivProdExp_opA_uid94_fpDivTest_q_3_q : STD_LOGIC_VECTOR (8 downto 0);
    signal redist5_qDivProdExp_opA_uid94_fpDivTest_q_3_delay_0 : STD_LOGIC_VECTOR (8 downto 0);
    signal redist6_expPostRndFR_uid81_fpDivTest_b_3_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist6_expPostRndFR_uid81_fpDivTest_b_3_delay_0 : STD_LOGIC_VECTOR (7 downto 0);
    signal redist6_expPostRndFR_uid81_fpDivTest_b_3_delay_1 : STD_LOGIC_VECTOR (7 downto 0);
    signal redist7_lOAdded_uid57_fpDivTest_q_3_q : STD_LOGIC_VECTOR (23 downto 0);
    signal redist7_lOAdded_uid57_fpDivTest_q_3_delay_0 : STD_LOGIC_VECTOR (23 downto 0);
    signal redist7_lOAdded_uid57_fpDivTest_q_3_delay_1 : STD_LOGIC_VECTOR (23 downto 0);
    signal redist8_invYO_uid55_fpDivTest_b_3_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist8_invYO_uid55_fpDivTest_b_3_delay_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal redist8_invYO_uid55_fpDivTest_b_3_delay_1 : STD_LOGIC_VECTOR (0 downto 0);
    signal redist9_yPE_uid52_fpDivTest_b_2_q : STD_LOGIC_VECTOR (13 downto 0);
    signal redist9_yPE_uid52_fpDivTest_b_2_delay_0 : STD_LOGIC_VECTOR (13 downto 0);
    signal redist10_yPE_uid52_fpDivTest_b_5_q : STD_LOGIC_VECTOR (13 downto 0);
    signal redist10_yPE_uid52_fpDivTest_b_5_delay_0 : STD_LOGIC_VECTOR (13 downto 0);
    signal redist10_yPE_uid52_fpDivTest_b_5_delay_1 : STD_LOGIC_VECTOR (13 downto 0);
    signal redist11_yAddr_uid51_fpDivTest_b_3_q : STD_LOGIC_VECTOR (8 downto 0);
    signal redist11_yAddr_uid51_fpDivTest_b_3_delay_0 : STD_LOGIC_VECTOR (8 downto 0);
    signal redist11_yAddr_uid51_fpDivTest_b_3_delay_1 : STD_LOGIC_VECTOR (8 downto 0);
    signal redist12_yAddr_uid51_fpDivTest_b_6_q : STD_LOGIC_VECTOR (8 downto 0);
    signal redist12_yAddr_uid51_fpDivTest_b_6_delay_0 : STD_LOGIC_VECTOR (8 downto 0);
    signal redist12_yAddr_uid51_fpDivTest_b_6_delay_1 : STD_LOGIC_VECTOR (8 downto 0);
    signal redist13_signR_uid46_fpDivTest_q_11_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist17_fracX_uid10_fpDivTest_b_11_q : STD_LOGIC_VECTOR (22 downto 0);
    signal redist17_fracX_uid10_fpDivTest_b_11_delay_0 : STD_LOGIC_VECTOR (22 downto 0);
    signal redist17_fracX_uid10_fpDivTest_b_11_delay_1 : STD_LOGIC_VECTOR (22 downto 0);
    signal redist4_qDivProdLTX_opB_uid100_fpDivTest_q_3_outputreg0_q : STD_LOGIC_VECTOR (30 downto 0);
    signal redist14_fracY_uid13_fpDivTest_b_11_outputreg0_q : STD_LOGIC_VECTOR (22 downto 0);
    signal redist14_fracY_uid13_fpDivTest_b_11_mem_reset0 : std_logic;
    signal redist14_fracY_uid13_fpDivTest_b_11_mem_ia : STD_LOGIC_VECTOR (22 downto 0);
    signal redist14_fracY_uid13_fpDivTest_b_11_mem_aa : STD_LOGIC_VECTOR (3 downto 0);
    signal redist14_fracY_uid13_fpDivTest_b_11_mem_ab : STD_LOGIC_VECTOR (3 downto 0);
    signal redist14_fracY_uid13_fpDivTest_b_11_mem_iq : STD_LOGIC_VECTOR (22 downto 0);
    signal redist14_fracY_uid13_fpDivTest_b_11_mem_q : STD_LOGIC_VECTOR (22 downto 0);
    signal redist14_fracY_uid13_fpDivTest_b_11_rdcnt_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist14_fracY_uid13_fpDivTest_b_11_rdcnt_i : UNSIGNED (3 downto 0);
    attribute preserve : boolean;
    attribute preserve of redist14_fracY_uid13_fpDivTest_b_11_rdcnt_i : signal is true;
    signal redist14_fracY_uid13_fpDivTest_b_11_rdcnt_eq : std_logic;
    attribute preserve of redist14_fracY_uid13_fpDivTest_b_11_rdcnt_eq : signal is true;
    signal redist14_fracY_uid13_fpDivTest_b_11_wraddr_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist14_fracY_uid13_fpDivTest_b_11_mem_last_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist14_fracY_uid13_fpDivTest_b_11_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist14_fracY_uid13_fpDivTest_b_11_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute dont_merge : boolean;
    attribute dont_merge of redist14_fracY_uid13_fpDivTest_b_11_cmpReg_q : signal is true;
    signal redist14_fracY_uid13_fpDivTest_b_11_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist14_fracY_uid13_fpDivTest_b_11_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist14_fracY_uid13_fpDivTest_b_11_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute dont_merge of redist14_fracY_uid13_fpDivTest_b_11_sticky_ena_q : signal is true;
    signal redist14_fracY_uid13_fpDivTest_b_11_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist15_expY_uid12_fpDivTest_b_11_outputreg0_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist15_expY_uid12_fpDivTest_b_11_mem_reset0 : std_logic;
    signal redist15_expY_uid12_fpDivTest_b_11_mem_ia : STD_LOGIC_VECTOR (7 downto 0);
    signal redist15_expY_uid12_fpDivTest_b_11_mem_aa : STD_LOGIC_VECTOR (3 downto 0);
    signal redist15_expY_uid12_fpDivTest_b_11_mem_ab : STD_LOGIC_VECTOR (3 downto 0);
    signal redist15_expY_uid12_fpDivTest_b_11_mem_iq : STD_LOGIC_VECTOR (7 downto 0);
    signal redist15_expY_uid12_fpDivTest_b_11_mem_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist15_expY_uid12_fpDivTest_b_11_rdcnt_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist15_expY_uid12_fpDivTest_b_11_rdcnt_i : UNSIGNED (3 downto 0);
    attribute preserve of redist15_expY_uid12_fpDivTest_b_11_rdcnt_i : signal is true;
    signal redist15_expY_uid12_fpDivTest_b_11_rdcnt_eq : std_logic;
    attribute preserve of redist15_expY_uid12_fpDivTest_b_11_rdcnt_eq : signal is true;
    signal redist15_expY_uid12_fpDivTest_b_11_wraddr_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist15_expY_uid12_fpDivTest_b_11_mem_last_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist15_expY_uid12_fpDivTest_b_11_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist15_expY_uid12_fpDivTest_b_11_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute dont_merge of redist15_expY_uid12_fpDivTest_b_11_cmpReg_q : signal is true;
    signal redist15_expY_uid12_fpDivTest_b_11_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist15_expY_uid12_fpDivTest_b_11_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist15_expY_uid12_fpDivTest_b_11_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute dont_merge of redist15_expY_uid12_fpDivTest_b_11_sticky_ena_q : signal is true;
    signal redist15_expY_uid12_fpDivTest_b_11_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist16_fracX_uid10_fpDivTest_b_8_mem_reset0 : std_logic;
    signal redist16_fracX_uid10_fpDivTest_b_8_mem_ia : STD_LOGIC_VECTOR (22 downto 0);
    signal redist16_fracX_uid10_fpDivTest_b_8_mem_aa : STD_LOGIC_VECTOR (2 downto 0);
    signal redist16_fracX_uid10_fpDivTest_b_8_mem_ab : STD_LOGIC_VECTOR (2 downto 0);
    signal redist16_fracX_uid10_fpDivTest_b_8_mem_iq : STD_LOGIC_VECTOR (22 downto 0);
    signal redist16_fracX_uid10_fpDivTest_b_8_mem_q : STD_LOGIC_VECTOR (22 downto 0);
    signal redist16_fracX_uid10_fpDivTest_b_8_rdcnt_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist16_fracX_uid10_fpDivTest_b_8_rdcnt_i : UNSIGNED (2 downto 0);
    attribute preserve of redist16_fracX_uid10_fpDivTest_b_8_rdcnt_i : signal is true;
    signal redist16_fracX_uid10_fpDivTest_b_8_rdcnt_eq : std_logic;
    attribute preserve of redist16_fracX_uid10_fpDivTest_b_8_rdcnt_eq : signal is true;
    signal redist16_fracX_uid10_fpDivTest_b_8_wraddr_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist16_fracX_uid10_fpDivTest_b_8_mem_last_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist16_fracX_uid10_fpDivTest_b_8_cmp_b : STD_LOGIC_VECTOR (3 downto 0);
    signal redist16_fracX_uid10_fpDivTest_b_8_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist16_fracX_uid10_fpDivTest_b_8_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute dont_merge of redist16_fracX_uid10_fpDivTest_b_8_cmpReg_q : signal is true;
    signal redist16_fracX_uid10_fpDivTest_b_8_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist16_fracX_uid10_fpDivTest_b_8_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist16_fracX_uid10_fpDivTest_b_8_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute dont_merge of redist16_fracX_uid10_fpDivTest_b_8_sticky_ena_q : signal is true;
    signal redist16_fracX_uid10_fpDivTest_b_8_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist18_expX_uid9_fpDivTest_b_11_mem_reset0 : std_logic;
    signal redist18_expX_uid9_fpDivTest_b_11_mem_ia : STD_LOGIC_VECTOR (7 downto 0);
    signal redist18_expX_uid9_fpDivTest_b_11_mem_aa : STD_LOGIC_VECTOR (3 downto 0);
    signal redist18_expX_uid9_fpDivTest_b_11_mem_ab : STD_LOGIC_VECTOR (3 downto 0);
    signal redist18_expX_uid9_fpDivTest_b_11_mem_iq : STD_LOGIC_VECTOR (7 downto 0);
    signal redist18_expX_uid9_fpDivTest_b_11_mem_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist18_expX_uid9_fpDivTest_b_11_rdcnt_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist18_expX_uid9_fpDivTest_b_11_rdcnt_i : UNSIGNED (3 downto 0);
    attribute preserve of redist18_expX_uid9_fpDivTest_b_11_rdcnt_i : signal is true;
    signal redist18_expX_uid9_fpDivTest_b_11_rdcnt_eq : std_logic;
    attribute preserve of redist18_expX_uid9_fpDivTest_b_11_rdcnt_eq : signal is true;
    signal redist18_expX_uid9_fpDivTest_b_11_wraddr_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist18_expX_uid9_fpDivTest_b_11_mem_last_q : STD_LOGIC_VECTOR (4 downto 0);
    signal redist18_expX_uid9_fpDivTest_b_11_cmp_b : STD_LOGIC_VECTOR (4 downto 0);
    signal redist18_expX_uid9_fpDivTest_b_11_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist18_expX_uid9_fpDivTest_b_11_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute dont_merge of redist18_expX_uid9_fpDivTest_b_11_cmpReg_q : signal is true;
    signal redist18_expX_uid9_fpDivTest_b_11_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist18_expX_uid9_fpDivTest_b_11_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist18_expX_uid9_fpDivTest_b_11_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute dont_merge of redist18_expX_uid9_fpDivTest_b_11_sticky_ena_q : signal is true;
    signal redist18_expX_uid9_fpDivTest_b_11_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);

begin


    -- VCC(CONSTANT,1)
    VCC_q <= "1";

    -- redist14_fracY_uid13_fpDivTest_b_11_notEnable(LOGICAL,215)
    redist14_fracY_uid13_fpDivTest_b_11_notEnable_q <= STD_LOGIC_VECTOR(not (VCC_q));

    -- redist14_fracY_uid13_fpDivTest_b_11_nor(LOGICAL,216)
    redist14_fracY_uid13_fpDivTest_b_11_nor_q <= not (redist14_fracY_uid13_fpDivTest_b_11_notEnable_q or redist14_fracY_uid13_fpDivTest_b_11_sticky_ena_q);

    -- redist14_fracY_uid13_fpDivTest_b_11_mem_last(CONSTANT,212)
    redist14_fracY_uid13_fpDivTest_b_11_mem_last_q <= "0111";

    -- redist14_fracY_uid13_fpDivTest_b_11_cmp(LOGICAL,213)
    redist14_fracY_uid13_fpDivTest_b_11_cmp_q <= "1" WHEN redist14_fracY_uid13_fpDivTest_b_11_mem_last_q = redist14_fracY_uid13_fpDivTest_b_11_rdcnt_q ELSE "0";

    -- redist14_fracY_uid13_fpDivTest_b_11_cmpReg(REG,214)
    redist14_fracY_uid13_fpDivTest_b_11_cmpReg_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            redist14_fracY_uid13_fpDivTest_b_11_cmpReg_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            redist14_fracY_uid13_fpDivTest_b_11_cmpReg_q <= STD_LOGIC_VECTOR(redist14_fracY_uid13_fpDivTest_b_11_cmp_q);
        END IF;
    END PROCESS;

    -- redist14_fracY_uid13_fpDivTest_b_11_sticky_ena(REG,217)
    redist14_fracY_uid13_fpDivTest_b_11_sticky_ena_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            redist14_fracY_uid13_fpDivTest_b_11_sticky_ena_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (redist14_fracY_uid13_fpDivTest_b_11_nor_q = "1") THEN
                redist14_fracY_uid13_fpDivTest_b_11_sticky_ena_q <= STD_LOGIC_VECTOR(redist14_fracY_uid13_fpDivTest_b_11_cmpReg_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist14_fracY_uid13_fpDivTest_b_11_enaAnd(LOGICAL,218)
    redist14_fracY_uid13_fpDivTest_b_11_enaAnd_q <= redist14_fracY_uid13_fpDivTest_b_11_sticky_ena_q and VCC_q;

    -- redist14_fracY_uid13_fpDivTest_b_11_rdcnt(COUNTER,210)
    -- low=0, high=8, step=1, init=0
    redist14_fracY_uid13_fpDivTest_b_11_rdcnt_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            redist14_fracY_uid13_fpDivTest_b_11_rdcnt_i <= TO_UNSIGNED(0, 4);
            redist14_fracY_uid13_fpDivTest_b_11_rdcnt_eq <= '0';
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (redist14_fracY_uid13_fpDivTest_b_11_rdcnt_i = TO_UNSIGNED(7, 4)) THEN
                redist14_fracY_uid13_fpDivTest_b_11_rdcnt_eq <= '1';
            ELSE
                redist14_fracY_uid13_fpDivTest_b_11_rdcnt_eq <= '0';
            END IF;
            IF (redist14_fracY_uid13_fpDivTest_b_11_rdcnt_eq = '1') THEN
                redist14_fracY_uid13_fpDivTest_b_11_rdcnt_i <= redist14_fracY_uid13_fpDivTest_b_11_rdcnt_i + 8;
            ELSE
                redist14_fracY_uid13_fpDivTest_b_11_rdcnt_i <= redist14_fracY_uid13_fpDivTest_b_11_rdcnt_i + 1;
            END IF;
        END IF;
    END PROCESS;
    redist14_fracY_uid13_fpDivTest_b_11_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist14_fracY_uid13_fpDivTest_b_11_rdcnt_i, 4)));

    -- fracY_uid13_fpDivTest(BITSELECT,12)@0
    fracY_uid13_fpDivTest_b <= b(22 downto 0);

    -- redist14_fracY_uid13_fpDivTest_b_11_wraddr(REG,211)
    redist14_fracY_uid13_fpDivTest_b_11_wraddr_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            redist14_fracY_uid13_fpDivTest_b_11_wraddr_q <= "1000";
        ELSIF (clk'EVENT AND clk = '1') THEN
            redist14_fracY_uid13_fpDivTest_b_11_wraddr_q <= STD_LOGIC_VECTOR(redist14_fracY_uid13_fpDivTest_b_11_rdcnt_q);
        END IF;
    END PROCESS;

    -- redist14_fracY_uid13_fpDivTest_b_11_mem(DUALMEM,209)
    redist14_fracY_uid13_fpDivTest_b_11_mem_ia <= STD_LOGIC_VECTOR(fracY_uid13_fpDivTest_b);
    redist14_fracY_uid13_fpDivTest_b_11_mem_aa <= redist14_fracY_uid13_fpDivTest_b_11_wraddr_q;
    redist14_fracY_uid13_fpDivTest_b_11_mem_ab <= redist14_fracY_uid13_fpDivTest_b_11_rdcnt_q;
    redist14_fracY_uid13_fpDivTest_b_11_mem_reset0 <= areset;
    redist14_fracY_uid13_fpDivTest_b_11_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 23,
        widthad_a => 4,
        numwords_a => 9,
        width_b => 23,
        widthad_b => 4,
        numwords_b => 9,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        address_reg_b => "CLOCK0",
        indata_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK1",
        outdata_aclr_b => "CLEAR1",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "TRUE",
        intended_device_family => "Cyclone 10 GX"
    )
    PORT MAP (
        clocken1 => redist14_fracY_uid13_fpDivTest_b_11_enaAnd_q(0),
        clocken0 => '1',
        clock0 => clk,
        aclr1 => redist14_fracY_uid13_fpDivTest_b_11_mem_reset0,
        clock1 => clk,
        address_a => redist14_fracY_uid13_fpDivTest_b_11_mem_aa,
        data_a => redist14_fracY_uid13_fpDivTest_b_11_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist14_fracY_uid13_fpDivTest_b_11_mem_ab,
        q_b => redist14_fracY_uid13_fpDivTest_b_11_mem_iq
    );
    redist14_fracY_uid13_fpDivTest_b_11_mem_q <= redist14_fracY_uid13_fpDivTest_b_11_mem_iq(22 downto 0);

    -- redist14_fracY_uid13_fpDivTest_b_11_outputreg0(DELAY,208)
    redist14_fracY_uid13_fpDivTest_b_11_outputreg0_clkproc_0: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            redist14_fracY_uid13_fpDivTest_b_11_outputreg0_q <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            redist14_fracY_uid13_fpDivTest_b_11_outputreg0_q <= STD_LOGIC_VECTOR(redist14_fracY_uid13_fpDivTest_b_11_mem_q);
        END IF;
    END PROCESS;

    -- cstZeroWF_uid19_fpDivTest(CONSTANT,18)
    cstZeroWF_uid19_fpDivTest_q <= "00000000000000000000000";

    -- fracXIsZero_uid39_fpDivTest(LOGICAL,38)@11
    fracXIsZero_uid39_fpDivTest_q <= "1" WHEN cstZeroWF_uid19_fpDivTest_q = redist14_fracY_uid13_fpDivTest_b_11_outputreg0_q ELSE "0";

    -- cstAllOWE_uid18_fpDivTest(CONSTANT,17)
    cstAllOWE_uid18_fpDivTest_q <= "11111111";

    -- redist15_expY_uid12_fpDivTest_b_11_notEnable(LOGICAL,226)
    redist15_expY_uid12_fpDivTest_b_11_notEnable_q <= STD_LOGIC_VECTOR(not (VCC_q));

    -- redist15_expY_uid12_fpDivTest_b_11_nor(LOGICAL,227)
    redist15_expY_uid12_fpDivTest_b_11_nor_q <= not (redist15_expY_uid12_fpDivTest_b_11_notEnable_q or redist15_expY_uid12_fpDivTest_b_11_sticky_ena_q);

    -- redist15_expY_uid12_fpDivTest_b_11_mem_last(CONSTANT,223)
    redist15_expY_uid12_fpDivTest_b_11_mem_last_q <= "0111";

    -- redist15_expY_uid12_fpDivTest_b_11_cmp(LOGICAL,224)
    redist15_expY_uid12_fpDivTest_b_11_cmp_q <= "1" WHEN redist15_expY_uid12_fpDivTest_b_11_mem_last_q = redist15_expY_uid12_fpDivTest_b_11_rdcnt_q ELSE "0";

    -- redist15_expY_uid12_fpDivTest_b_11_cmpReg(REG,225)
    redist15_expY_uid12_fpDivTest_b_11_cmpReg_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            redist15_expY_uid12_fpDivTest_b_11_cmpReg_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            redist15_expY_uid12_fpDivTest_b_11_cmpReg_q <= STD_LOGIC_VECTOR(redist15_expY_uid12_fpDivTest_b_11_cmp_q);
        END IF;
    END PROCESS;

    -- redist15_expY_uid12_fpDivTest_b_11_sticky_ena(REG,228)
    redist15_expY_uid12_fpDivTest_b_11_sticky_ena_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            redist15_expY_uid12_fpDivTest_b_11_sticky_ena_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (redist15_expY_uid12_fpDivTest_b_11_nor_q = "1") THEN
                redist15_expY_uid12_fpDivTest_b_11_sticky_ena_q <= STD_LOGIC_VECTOR(redist15_expY_uid12_fpDivTest_b_11_cmpReg_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist15_expY_uid12_fpDivTest_b_11_enaAnd(LOGICAL,229)
    redist15_expY_uid12_fpDivTest_b_11_enaAnd_q <= redist15_expY_uid12_fpDivTest_b_11_sticky_ena_q and VCC_q;

    -- redist15_expY_uid12_fpDivTest_b_11_rdcnt(COUNTER,221)
    -- low=0, high=8, step=1, init=0
    redist15_expY_uid12_fpDivTest_b_11_rdcnt_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            redist15_expY_uid12_fpDivTest_b_11_rdcnt_i <= TO_UNSIGNED(0, 4);
            redist15_expY_uid12_fpDivTest_b_11_rdcnt_eq <= '0';
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (redist15_expY_uid12_fpDivTest_b_11_rdcnt_i = TO_UNSIGNED(7, 4)) THEN
                redist15_expY_uid12_fpDivTest_b_11_rdcnt_eq <= '1';
            ELSE
                redist15_expY_uid12_fpDivTest_b_11_rdcnt_eq <= '0';
            END IF;
            IF (redist15_expY_uid12_fpDivTest_b_11_rdcnt_eq = '1') THEN
                redist15_expY_uid12_fpDivTest_b_11_rdcnt_i <= redist15_expY_uid12_fpDivTest_b_11_rdcnt_i + 8;
            ELSE
                redist15_expY_uid12_fpDivTest_b_11_rdcnt_i <= redist15_expY_uid12_fpDivTest_b_11_rdcnt_i + 1;
            END IF;
        END IF;
    END PROCESS;
    redist15_expY_uid12_fpDivTest_b_11_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist15_expY_uid12_fpDivTest_b_11_rdcnt_i, 4)));

    -- expY_uid12_fpDivTest(BITSELECT,11)@0
    expY_uid12_fpDivTest_b <= b(30 downto 23);

    -- redist15_expY_uid12_fpDivTest_b_11_wraddr(REG,222)
    redist15_expY_uid12_fpDivTest_b_11_wraddr_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            redist15_expY_uid12_fpDivTest_b_11_wraddr_q <= "1000";
        ELSIF (clk'EVENT AND clk = '1') THEN
            redist15_expY_uid12_fpDivTest_b_11_wraddr_q <= STD_LOGIC_VECTOR(redist15_expY_uid12_fpDivTest_b_11_rdcnt_q);
        END IF;
    END PROCESS;

    -- redist15_expY_uid12_fpDivTest_b_11_mem(DUALMEM,220)
    redist15_expY_uid12_fpDivTest_b_11_mem_ia <= STD_LOGIC_VECTOR(expY_uid12_fpDivTest_b);
    redist15_expY_uid12_fpDivTest_b_11_mem_aa <= redist15_expY_uid12_fpDivTest_b_11_wraddr_q;
    redist15_expY_uid12_fpDivTest_b_11_mem_ab <= redist15_expY_uid12_fpDivTest_b_11_rdcnt_q;
    redist15_expY_uid12_fpDivTest_b_11_mem_reset0 <= areset;
    redist15_expY_uid12_fpDivTest_b_11_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 8,
        widthad_a => 4,
        numwords_a => 9,
        width_b => 8,
        widthad_b => 4,
        numwords_b => 9,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        address_reg_b => "CLOCK0",
        indata_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK1",
        outdata_aclr_b => "CLEAR1",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "TRUE",
        intended_device_family => "Cyclone 10 GX"
    )
    PORT MAP (
        clocken1 => redist15_expY_uid12_fpDivTest_b_11_enaAnd_q(0),
        clocken0 => '1',
        clock0 => clk,
        aclr1 => redist15_expY_uid12_fpDivTest_b_11_mem_reset0,
        clock1 => clk,
        address_a => redist15_expY_uid12_fpDivTest_b_11_mem_aa,
        data_a => redist15_expY_uid12_fpDivTest_b_11_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist15_expY_uid12_fpDivTest_b_11_mem_ab,
        q_b => redist15_expY_uid12_fpDivTest_b_11_mem_iq
    );
    redist15_expY_uid12_fpDivTest_b_11_mem_q <= redist15_expY_uid12_fpDivTest_b_11_mem_iq(7 downto 0);

    -- redist15_expY_uid12_fpDivTest_b_11_outputreg0(DELAY,219)
    redist15_expY_uid12_fpDivTest_b_11_outputreg0_clkproc_0: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            redist15_expY_uid12_fpDivTest_b_11_outputreg0_q <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            redist15_expY_uid12_fpDivTest_b_11_outputreg0_q <= STD_LOGIC_VECTOR(redist15_expY_uid12_fpDivTest_b_11_mem_q);
        END IF;
    END PROCESS;

    -- expXIsMax_uid38_fpDivTest(LOGICAL,37)@11
    expXIsMax_uid38_fpDivTest_q <= "1" WHEN redist15_expY_uid12_fpDivTest_b_11_outputreg0_q = cstAllOWE_uid18_fpDivTest_q ELSE "0";

    -- excI_y_uid41_fpDivTest(LOGICAL,40)@11
    excI_y_uid41_fpDivTest_q <= expXIsMax_uid38_fpDivTest_q and fracXIsZero_uid39_fpDivTest_q;

    -- redist16_fracX_uid10_fpDivTest_b_8_notEnable(LOGICAL,236)
    redist16_fracX_uid10_fpDivTest_b_8_notEnable_q <= STD_LOGIC_VECTOR(not (VCC_q));

    -- redist16_fracX_uid10_fpDivTest_b_8_nor(LOGICAL,237)
    redist16_fracX_uid10_fpDivTest_b_8_nor_q <= not (redist16_fracX_uid10_fpDivTest_b_8_notEnable_q or redist16_fracX_uid10_fpDivTest_b_8_sticky_ena_q);

    -- redist16_fracX_uid10_fpDivTest_b_8_mem_last(CONSTANT,233)
    redist16_fracX_uid10_fpDivTest_b_8_mem_last_q <= "0101";

    -- redist16_fracX_uid10_fpDivTest_b_8_cmp(LOGICAL,234)
    redist16_fracX_uid10_fpDivTest_b_8_cmp_b <= STD_LOGIC_VECTOR("0" & redist16_fracX_uid10_fpDivTest_b_8_rdcnt_q);
    redist16_fracX_uid10_fpDivTest_b_8_cmp_q <= "1" WHEN redist16_fracX_uid10_fpDivTest_b_8_mem_last_q = redist16_fracX_uid10_fpDivTest_b_8_cmp_b ELSE "0";

    -- redist16_fracX_uid10_fpDivTest_b_8_cmpReg(REG,235)
    redist16_fracX_uid10_fpDivTest_b_8_cmpReg_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            redist16_fracX_uid10_fpDivTest_b_8_cmpReg_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            redist16_fracX_uid10_fpDivTest_b_8_cmpReg_q <= STD_LOGIC_VECTOR(redist16_fracX_uid10_fpDivTest_b_8_cmp_q);
        END IF;
    END PROCESS;

    -- redist16_fracX_uid10_fpDivTest_b_8_sticky_ena(REG,238)
    redist16_fracX_uid10_fpDivTest_b_8_sticky_ena_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            redist16_fracX_uid10_fpDivTest_b_8_sticky_ena_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (redist16_fracX_uid10_fpDivTest_b_8_nor_q = "1") THEN
                redist16_fracX_uid10_fpDivTest_b_8_sticky_ena_q <= STD_LOGIC_VECTOR(redist16_fracX_uid10_fpDivTest_b_8_cmpReg_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist16_fracX_uid10_fpDivTest_b_8_enaAnd(LOGICAL,239)
    redist16_fracX_uid10_fpDivTest_b_8_enaAnd_q <= redist16_fracX_uid10_fpDivTest_b_8_sticky_ena_q and VCC_q;

    -- redist16_fracX_uid10_fpDivTest_b_8_rdcnt(COUNTER,231)
    -- low=0, high=6, step=1, init=0
    redist16_fracX_uid10_fpDivTest_b_8_rdcnt_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            redist16_fracX_uid10_fpDivTest_b_8_rdcnt_i <= TO_UNSIGNED(0, 3);
            redist16_fracX_uid10_fpDivTest_b_8_rdcnt_eq <= '0';
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (redist16_fracX_uid10_fpDivTest_b_8_rdcnt_i = TO_UNSIGNED(5, 3)) THEN
                redist16_fracX_uid10_fpDivTest_b_8_rdcnt_eq <= '1';
            ELSE
                redist16_fracX_uid10_fpDivTest_b_8_rdcnt_eq <= '0';
            END IF;
            IF (redist16_fracX_uid10_fpDivTest_b_8_rdcnt_eq = '1') THEN
                redist16_fracX_uid10_fpDivTest_b_8_rdcnt_i <= redist16_fracX_uid10_fpDivTest_b_8_rdcnt_i + 2;
            ELSE
                redist16_fracX_uid10_fpDivTest_b_8_rdcnt_i <= redist16_fracX_uid10_fpDivTest_b_8_rdcnt_i + 1;
            END IF;
        END IF;
    END PROCESS;
    redist16_fracX_uid10_fpDivTest_b_8_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist16_fracX_uid10_fpDivTest_b_8_rdcnt_i, 3)));

    -- fracX_uid10_fpDivTest(BITSELECT,9)@0
    fracX_uid10_fpDivTest_b <= a(22 downto 0);

    -- redist16_fracX_uid10_fpDivTest_b_8_wraddr(REG,232)
    redist16_fracX_uid10_fpDivTest_b_8_wraddr_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            redist16_fracX_uid10_fpDivTest_b_8_wraddr_q <= "110";
        ELSIF (clk'EVENT AND clk = '1') THEN
            redist16_fracX_uid10_fpDivTest_b_8_wraddr_q <= STD_LOGIC_VECTOR(redist16_fracX_uid10_fpDivTest_b_8_rdcnt_q);
        END IF;
    END PROCESS;

    -- redist16_fracX_uid10_fpDivTest_b_8_mem(DUALMEM,230)
    redist16_fracX_uid10_fpDivTest_b_8_mem_ia <= STD_LOGIC_VECTOR(fracX_uid10_fpDivTest_b);
    redist16_fracX_uid10_fpDivTest_b_8_mem_aa <= redist16_fracX_uid10_fpDivTest_b_8_wraddr_q;
    redist16_fracX_uid10_fpDivTest_b_8_mem_ab <= redist16_fracX_uid10_fpDivTest_b_8_rdcnt_q;
    redist16_fracX_uid10_fpDivTest_b_8_mem_reset0 <= areset;
    redist16_fracX_uid10_fpDivTest_b_8_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 23,
        widthad_a => 3,
        numwords_a => 7,
        width_b => 23,
        widthad_b => 3,
        numwords_b => 7,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        address_reg_b => "CLOCK0",
        indata_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK1",
        outdata_aclr_b => "CLEAR1",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "TRUE",
        intended_device_family => "Cyclone 10 GX"
    )
    PORT MAP (
        clocken1 => redist16_fracX_uid10_fpDivTest_b_8_enaAnd_q(0),
        clocken0 => '1',
        clock0 => clk,
        aclr1 => redist16_fracX_uid10_fpDivTest_b_8_mem_reset0,
        clock1 => clk,
        address_a => redist16_fracX_uid10_fpDivTest_b_8_mem_aa,
        data_a => redist16_fracX_uid10_fpDivTest_b_8_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist16_fracX_uid10_fpDivTest_b_8_mem_ab,
        q_b => redist16_fracX_uid10_fpDivTest_b_8_mem_iq
    );
    redist16_fracX_uid10_fpDivTest_b_8_mem_q <= redist16_fracX_uid10_fpDivTest_b_8_mem_iq(22 downto 0);

    -- redist17_fracX_uid10_fpDivTest_b_11(DELAY,205)
    redist17_fracX_uid10_fpDivTest_b_11_clkproc_0: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            redist17_fracX_uid10_fpDivTest_b_11_delay_0 <= (others => '0');
            redist17_fracX_uid10_fpDivTest_b_11_delay_1 <= (others => '0');
            redist17_fracX_uid10_fpDivTest_b_11_q <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            redist17_fracX_uid10_fpDivTest_b_11_delay_0 <= STD_LOGIC_VECTOR(redist16_fracX_uid10_fpDivTest_b_8_mem_q);
            redist17_fracX_uid10_fpDivTest_b_11_delay_1 <= redist17_fracX_uid10_fpDivTest_b_11_delay_0;
            redist17_fracX_uid10_fpDivTest_b_11_q <= redist17_fracX_uid10_fpDivTest_b_11_delay_1;
        END IF;
    END PROCESS;

    -- fracXIsZero_uid25_fpDivTest(LOGICAL,24)@11
    fracXIsZero_uid25_fpDivTest_q <= "1" WHEN cstZeroWF_uid19_fpDivTest_q = redist17_fracX_uid10_fpDivTest_b_11_q ELSE "0";

    -- redist18_expX_uid9_fpDivTest_b_11_notEnable(LOGICAL,246)
    redist18_expX_uid9_fpDivTest_b_11_notEnable_q <= STD_LOGIC_VECTOR(not (VCC_q));

    -- redist18_expX_uid9_fpDivTest_b_11_nor(LOGICAL,247)
    redist18_expX_uid9_fpDivTest_b_11_nor_q <= not (redist18_expX_uid9_fpDivTest_b_11_notEnable_q or redist18_expX_uid9_fpDivTest_b_11_sticky_ena_q);

    -- redist18_expX_uid9_fpDivTest_b_11_mem_last(CONSTANT,243)
    redist18_expX_uid9_fpDivTest_b_11_mem_last_q <= "01000";

    -- redist18_expX_uid9_fpDivTest_b_11_cmp(LOGICAL,244)
    redist18_expX_uid9_fpDivTest_b_11_cmp_b <= STD_LOGIC_VECTOR("0" & redist18_expX_uid9_fpDivTest_b_11_rdcnt_q);
    redist18_expX_uid9_fpDivTest_b_11_cmp_q <= "1" WHEN redist18_expX_uid9_fpDivTest_b_11_mem_last_q = redist18_expX_uid9_fpDivTest_b_11_cmp_b ELSE "0";

    -- redist18_expX_uid9_fpDivTest_b_11_cmpReg(REG,245)
    redist18_expX_uid9_fpDivTest_b_11_cmpReg_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            redist18_expX_uid9_fpDivTest_b_11_cmpReg_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            redist18_expX_uid9_fpDivTest_b_11_cmpReg_q <= STD_LOGIC_VECTOR(redist18_expX_uid9_fpDivTest_b_11_cmp_q);
        END IF;
    END PROCESS;

    -- redist18_expX_uid9_fpDivTest_b_11_sticky_ena(REG,248)
    redist18_expX_uid9_fpDivTest_b_11_sticky_ena_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            redist18_expX_uid9_fpDivTest_b_11_sticky_ena_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (redist18_expX_uid9_fpDivTest_b_11_nor_q = "1") THEN
                redist18_expX_uid9_fpDivTest_b_11_sticky_ena_q <= STD_LOGIC_VECTOR(redist18_expX_uid9_fpDivTest_b_11_cmpReg_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist18_expX_uid9_fpDivTest_b_11_enaAnd(LOGICAL,249)
    redist18_expX_uid9_fpDivTest_b_11_enaAnd_q <= redist18_expX_uid9_fpDivTest_b_11_sticky_ena_q and VCC_q;

    -- redist18_expX_uid9_fpDivTest_b_11_rdcnt(COUNTER,241)
    -- low=0, high=9, step=1, init=0
    redist18_expX_uid9_fpDivTest_b_11_rdcnt_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            redist18_expX_uid9_fpDivTest_b_11_rdcnt_i <= TO_UNSIGNED(0, 4);
            redist18_expX_uid9_fpDivTest_b_11_rdcnt_eq <= '0';
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (redist18_expX_uid9_fpDivTest_b_11_rdcnt_i = TO_UNSIGNED(8, 4)) THEN
                redist18_expX_uid9_fpDivTest_b_11_rdcnt_eq <= '1';
            ELSE
                redist18_expX_uid9_fpDivTest_b_11_rdcnt_eq <= '0';
            END IF;
            IF (redist18_expX_uid9_fpDivTest_b_11_rdcnt_eq = '1') THEN
                redist18_expX_uid9_fpDivTest_b_11_rdcnt_i <= redist18_expX_uid9_fpDivTest_b_11_rdcnt_i + 7;
            ELSE
                redist18_expX_uid9_fpDivTest_b_11_rdcnt_i <= redist18_expX_uid9_fpDivTest_b_11_rdcnt_i + 1;
            END IF;
        END IF;
    END PROCESS;
    redist18_expX_uid9_fpDivTest_b_11_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist18_expX_uid9_fpDivTest_b_11_rdcnt_i, 4)));

    -- expX_uid9_fpDivTest(BITSELECT,8)@0
    expX_uid9_fpDivTest_b <= a(30 downto 23);

    -- redist18_expX_uid9_fpDivTest_b_11_wraddr(REG,242)
    redist18_expX_uid9_fpDivTest_b_11_wraddr_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            redist18_expX_uid9_fpDivTest_b_11_wraddr_q <= "1001";
        ELSIF (clk'EVENT AND clk = '1') THEN
            redist18_expX_uid9_fpDivTest_b_11_wraddr_q <= STD_LOGIC_VECTOR(redist18_expX_uid9_fpDivTest_b_11_rdcnt_q);
        END IF;
    END PROCESS;

    -- redist18_expX_uid9_fpDivTest_b_11_mem(DUALMEM,240)
    redist18_expX_uid9_fpDivTest_b_11_mem_ia <= STD_LOGIC_VECTOR(expX_uid9_fpDivTest_b);
    redist18_expX_uid9_fpDivTest_b_11_mem_aa <= redist18_expX_uid9_fpDivTest_b_11_wraddr_q;
    redist18_expX_uid9_fpDivTest_b_11_mem_ab <= redist18_expX_uid9_fpDivTest_b_11_rdcnt_q;
    redist18_expX_uid9_fpDivTest_b_11_mem_reset0 <= areset;
    redist18_expX_uid9_fpDivTest_b_11_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 8,
        widthad_a => 4,
        numwords_a => 10,
        width_b => 8,
        widthad_b => 4,
        numwords_b => 10,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        address_reg_b => "CLOCK0",
        indata_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK1",
        outdata_aclr_b => "CLEAR1",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "TRUE",
        intended_device_family => "Cyclone 10 GX"
    )
    PORT MAP (
        clocken1 => redist18_expX_uid9_fpDivTest_b_11_enaAnd_q(0),
        clocken0 => '1',
        clock0 => clk,
        aclr1 => redist18_expX_uid9_fpDivTest_b_11_mem_reset0,
        clock1 => clk,
        address_a => redist18_expX_uid9_fpDivTest_b_11_mem_aa,
        data_a => redist18_expX_uid9_fpDivTest_b_11_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist18_expX_uid9_fpDivTest_b_11_mem_ab,
        q_b => redist18_expX_uid9_fpDivTest_b_11_mem_iq
    );
    redist18_expX_uid9_fpDivTest_b_11_mem_q <= redist18_expX_uid9_fpDivTest_b_11_mem_iq(7 downto 0);

    -- expXIsMax_uid24_fpDivTest(LOGICAL,23)@11
    expXIsMax_uid24_fpDivTest_q <= "1" WHEN redist18_expX_uid9_fpDivTest_b_11_mem_q = cstAllOWE_uid18_fpDivTest_q ELSE "0";

    -- excI_x_uid27_fpDivTest(LOGICAL,26)@11
    excI_x_uid27_fpDivTest_q <= expXIsMax_uid24_fpDivTest_q and fracXIsZero_uid25_fpDivTest_q;

    -- excXIYI_uid130_fpDivTest(LOGICAL,129)@11
    excXIYI_uid130_fpDivTest_q <= excI_x_uid27_fpDivTest_q and excI_y_uid41_fpDivTest_q;

    -- fracXIsNotZero_uid40_fpDivTest(LOGICAL,39)@11
    fracXIsNotZero_uid40_fpDivTest_q <= not (fracXIsZero_uid39_fpDivTest_q);

    -- excN_y_uid42_fpDivTest(LOGICAL,41)@11
    excN_y_uid42_fpDivTest_q <= expXIsMax_uid38_fpDivTest_q and fracXIsNotZero_uid40_fpDivTest_q;

    -- fracXIsNotZero_uid26_fpDivTest(LOGICAL,25)@11
    fracXIsNotZero_uid26_fpDivTest_q <= not (fracXIsZero_uid25_fpDivTest_q);

    -- excN_x_uid28_fpDivTest(LOGICAL,27)@11
    excN_x_uid28_fpDivTest_q <= expXIsMax_uid24_fpDivTest_q and fracXIsNotZero_uid26_fpDivTest_q;

    -- cstAllZWE_uid20_fpDivTest(CONSTANT,19)
    cstAllZWE_uid20_fpDivTest_q <= "00000000";

    -- excZ_y_uid37_fpDivTest(LOGICAL,36)@11
    excZ_y_uid37_fpDivTest_q <= "1" WHEN redist15_expY_uid12_fpDivTest_b_11_outputreg0_q = cstAllZWE_uid20_fpDivTest_q ELSE "0";

    -- excZ_x_uid23_fpDivTest(LOGICAL,22)@11
    excZ_x_uid23_fpDivTest_q <= "1" WHEN redist18_expX_uid9_fpDivTest_b_11_mem_q = cstAllZWE_uid20_fpDivTest_q ELSE "0";

    -- excXZYZ_uid129_fpDivTest(LOGICAL,128)@11
    excXZYZ_uid129_fpDivTest_q <= excZ_x_uid23_fpDivTest_q and excZ_y_uid37_fpDivTest_q;

    -- excRNaN_uid131_fpDivTest(LOGICAL,130)@11
    excRNaN_uid131_fpDivTest_q <= excXZYZ_uid129_fpDivTest_q or excN_x_uid28_fpDivTest_q or excN_y_uid42_fpDivTest_q or excXIYI_uid130_fpDivTest_q;

    -- invExcRNaN_uid142_fpDivTest(LOGICAL,141)@11
    invExcRNaN_uid142_fpDivTest_q <= not (excRNaN_uid131_fpDivTest_q);

    -- signY_uid14_fpDivTest(BITSELECT,13)@0
    signY_uid14_fpDivTest_b <= STD_LOGIC_VECTOR(b(31 downto 31));

    -- signX_uid11_fpDivTest(BITSELECT,10)@0
    signX_uid11_fpDivTest_b <= STD_LOGIC_VECTOR(a(31 downto 31));

    -- signR_uid46_fpDivTest(LOGICAL,45)@0 + 1
    signR_uid46_fpDivTest_qi <= signX_uid11_fpDivTest_b xor signY_uid14_fpDivTest_b;
    signR_uid46_fpDivTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => signR_uid46_fpDivTest_qi, xout => signR_uid46_fpDivTest_q, clk => clk, aclr => areset, ena => '1' );

    -- redist13_signR_uid46_fpDivTest_q_11(DELAY,201)
    redist13_signR_uid46_fpDivTest_q_11 : dspba_delay
    GENERIC MAP ( width => 1, depth => 10, reset_kind => "ASYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => signR_uid46_fpDivTest_q, xout => redist13_signR_uid46_fpDivTest_q_11_q, clk => clk, aclr => areset, ena => '1' );

    -- sRPostExc_uid143_fpDivTest(LOGICAL,142)@11 + 1
    sRPostExc_uid143_fpDivTest_qi <= redist13_signR_uid46_fpDivTest_q_11_q and invExcRNaN_uid142_fpDivTest_q;
    sRPostExc_uid143_fpDivTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => sRPostExc_uid143_fpDivTest_qi, xout => sRPostExc_uid143_fpDivTest_q, clk => clk, aclr => areset, ena => '1' );

    -- redist0_sRPostExc_uid143_fpDivTest_q_3(DELAY,188)
    redist0_sRPostExc_uid143_fpDivTest_q_3_clkproc_0: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            redist0_sRPostExc_uid143_fpDivTest_q_3_delay_0 <= (others => '0');
            redist0_sRPostExc_uid143_fpDivTest_q_3_q <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            redist0_sRPostExc_uid143_fpDivTest_q_3_delay_0 <= STD_LOGIC_VECTOR(sRPostExc_uid143_fpDivTest_q);
            redist0_sRPostExc_uid143_fpDivTest_q_3_q <= redist0_sRPostExc_uid143_fpDivTest_q_3_delay_0;
        END IF;
    END PROCESS;

    -- GND(CONSTANT,0)
    GND_q <= "0";

    -- fracXExt_uid77_fpDivTest(BITJOIN,76)@11
    fracXExt_uid77_fpDivTest_q <= redist17_fracX_uid10_fpDivTest_b_11_q & GND_q;

    -- lOAdded_uid57_fpDivTest(BITJOIN,56)@8
    lOAdded_uid57_fpDivTest_q <= VCC_q & redist16_fracX_uid10_fpDivTest_b_8_mem_q;

    -- redist7_lOAdded_uid57_fpDivTest_q_3(DELAY,195)
    redist7_lOAdded_uid57_fpDivTest_q_3_clkproc_0: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            redist7_lOAdded_uid57_fpDivTest_q_3_delay_0 <= (others => '0');
            redist7_lOAdded_uid57_fpDivTest_q_3_delay_1 <= (others => '0');
            redist7_lOAdded_uid57_fpDivTest_q_3_q <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            redist7_lOAdded_uid57_fpDivTest_q_3_delay_0 <= STD_LOGIC_VECTOR(lOAdded_uid57_fpDivTest_q);
            redist7_lOAdded_uid57_fpDivTest_q_3_delay_1 <= redist7_lOAdded_uid57_fpDivTest_q_3_delay_0;
            redist7_lOAdded_uid57_fpDivTest_q_3_q <= redist7_lOAdded_uid57_fpDivTest_q_3_delay_1;
        END IF;
    END PROCESS;

    -- z4_uid60_fpDivTest(CONSTANT,59)
    z4_uid60_fpDivTest_q <= "0000";

    -- oFracXZ4_uid61_fpDivTest(BITJOIN,60)@11
    oFracXZ4_uid61_fpDivTest_q <= redist7_lOAdded_uid57_fpDivTest_q_3_q & z4_uid60_fpDivTest_q;

    -- yAddr_uid51_fpDivTest(BITSELECT,50)@0
    yAddr_uid51_fpDivTest_b <= fracY_uid13_fpDivTest_b(22 downto 14);

    -- memoryC2_uid152_invTables_lutmem(DUALMEM,183)@0 + 2
    memoryC2_uid152_invTables_lutmem_aa <= yAddr_uid51_fpDivTest_b;
    memoryC2_uid152_invTables_lutmem_ena_NotRstA <= not (areset);
    memoryC2_uid152_invTables_lutmem_reset0 <= areset;
    memoryC2_uid152_invTables_lutmem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "M20K",
        operation_mode => "ROM",
        width_a => 13,
        widthad_a => 9,
        numwords_a => 512,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        outdata_reg_a => "CLOCK0",
        outdata_aclr_a => "CLEAR0",
        clock_enable_input_a => "NORMAL",
        power_up_uninitialized => "FALSE",
        init_file => "fp_div_altera_fp_functions_1917_ugoptdy_memoryC2_uid152_invTables_lutmem.hex",
        init_file_layout => "PORT_A",
        intended_device_family => "Cyclone 10 GX"
    )
    PORT MAP (
        clocken0 => memoryC2_uid152_invTables_lutmem_ena_NotRstA,
        aclr0 => memoryC2_uid152_invTables_lutmem_reset0,
        clock0 => clk,
        address_a => memoryC2_uid152_invTables_lutmem_aa,
        q_a => memoryC2_uid152_invTables_lutmem_ir
    );
    memoryC2_uid152_invTables_lutmem_r <= memoryC2_uid152_invTables_lutmem_ir(12 downto 0);

    -- yPE_uid52_fpDivTest(BITSELECT,51)@0
    yPE_uid52_fpDivTest_b <= b(13 downto 0);

    -- redist9_yPE_uid52_fpDivTest_b_2(DELAY,197)
    redist9_yPE_uid52_fpDivTest_b_2_clkproc_0: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            redist9_yPE_uid52_fpDivTest_b_2_delay_0 <= (others => '0');
            redist9_yPE_uid52_fpDivTest_b_2_q <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            redist9_yPE_uid52_fpDivTest_b_2_delay_0 <= STD_LOGIC_VECTOR(yPE_uid52_fpDivTest_b);
            redist9_yPE_uid52_fpDivTest_b_2_q <= redist9_yPE_uid52_fpDivTest_b_2_delay_0;
        END IF;
    END PROCESS;

    -- yT1_uid158_invPolyEval(BITSELECT,157)@2
    yT1_uid158_invPolyEval_b <= redist9_yPE_uid52_fpDivTest_b_2_q(13 downto 1);

    -- prodXY_uid174_pT1_uid159_invPolyEval_cma(CHAINMULTADD,186)@2 + 3
    prodXY_uid174_pT1_uid159_invPolyEval_cma_reset <= areset;
    prodXY_uid174_pT1_uid159_invPolyEval_cma_ena0 <= '1';
    prodXY_uid174_pT1_uid159_invPolyEval_cma_ena1 <= prodXY_uid174_pT1_uid159_invPolyEval_cma_ena0;
    prodXY_uid174_pT1_uid159_invPolyEval_cma_ena2 <= prodXY_uid174_pT1_uid159_invPolyEval_cma_ena0;

    prodXY_uid174_pT1_uid159_invPolyEval_cma_a0 <= STD_LOGIC_VECTOR(RESIZE(UNSIGNED(yT1_uid158_invPolyEval_b),13));
    prodXY_uid174_pT1_uid159_invPolyEval_cma_c0 <= STD_LOGIC_VECTOR(RESIZE(SIGNED(memoryC2_uid152_invTables_lutmem_r),13));
    prodXY_uid174_pT1_uid159_invPolyEval_cma_DSP0 : cyclone10gx_mac
    GENERIC MAP (
        operation_mode => "m18x18_full",
        ay_scan_in_clock => "0",
        ay_scan_in_width => 13,
        ax_clock => "0",
        ax_width => 13,
        signed_may => "false",
        signed_max => "true",
        input_pipeline_clock => "2",
        output_clock => "1",
        result_a_width => 26
    )
    PORT MAP (
        clk(0) => clk,
        clk(1) => clk,
        clk(2) => clk,
        ena(0) => prodXY_uid174_pT1_uid159_invPolyEval_cma_ena0,
        ena(1) => prodXY_uid174_pT1_uid159_invPolyEval_cma_ena1,
        ena(2) => prodXY_uid174_pT1_uid159_invPolyEval_cma_ena2,
        aclr(0) => prodXY_uid174_pT1_uid159_invPolyEval_cma_reset,
        aclr(1) => prodXY_uid174_pT1_uid159_invPolyEval_cma_reset,
        ay => prodXY_uid174_pT1_uid159_invPolyEval_cma_a0,
        ax => prodXY_uid174_pT1_uid159_invPolyEval_cma_c0,
        resulta => prodXY_uid174_pT1_uid159_invPolyEval_cma_s0
    );
    prodXY_uid174_pT1_uid159_invPolyEval_cma_delay0 : dspba_delay
    GENERIC MAP ( width => 26, depth => 0, reset_kind => "ASYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => prodXY_uid174_pT1_uid159_invPolyEval_cma_s0, xout => prodXY_uid174_pT1_uid159_invPolyEval_cma_qq0, clk => clk, aclr => areset, ena => '1' );
    prodXY_uid174_pT1_uid159_invPolyEval_cma_q <= STD_LOGIC_VECTOR(prodXY_uid174_pT1_uid159_invPolyEval_cma_qq0(25 downto 0));

    -- osig_uid175_pT1_uid159_invPolyEval(BITSELECT,174)@5
    osig_uid175_pT1_uid159_invPolyEval_b <= STD_LOGIC_VECTOR(prodXY_uid174_pT1_uid159_invPolyEval_cma_q(25 downto 12));

    -- highBBits_uid161_invPolyEval(BITSELECT,160)@5
    highBBits_uid161_invPolyEval_b <= STD_LOGIC_VECTOR(osig_uid175_pT1_uid159_invPolyEval_b(13 downto 1));

    -- redist11_yAddr_uid51_fpDivTest_b_3(DELAY,199)
    redist11_yAddr_uid51_fpDivTest_b_3_clkproc_0: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            redist11_yAddr_uid51_fpDivTest_b_3_delay_0 <= (others => '0');
            redist11_yAddr_uid51_fpDivTest_b_3_delay_1 <= (others => '0');
            redist11_yAddr_uid51_fpDivTest_b_3_q <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            redist11_yAddr_uid51_fpDivTest_b_3_delay_0 <= STD_LOGIC_VECTOR(yAddr_uid51_fpDivTest_b);
            redist11_yAddr_uid51_fpDivTest_b_3_delay_1 <= redist11_yAddr_uid51_fpDivTest_b_3_delay_0;
            redist11_yAddr_uid51_fpDivTest_b_3_q <= redist11_yAddr_uid51_fpDivTest_b_3_delay_1;
        END IF;
    END PROCESS;

    -- memoryC1_uid149_invTables_lutmem(DUALMEM,182)@3 + 2
    memoryC1_uid149_invTables_lutmem_aa <= redist11_yAddr_uid51_fpDivTest_b_3_q;
    memoryC1_uid149_invTables_lutmem_ena_NotRstA <= not (areset);
    memoryC1_uid149_invTables_lutmem_reset0 <= areset;
    memoryC1_uid149_invTables_lutmem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "M20K",
        operation_mode => "ROM",
        width_a => 22,
        widthad_a => 9,
        numwords_a => 512,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        outdata_reg_a => "CLOCK0",
        outdata_aclr_a => "CLEAR0",
        clock_enable_input_a => "NORMAL",
        power_up_uninitialized => "FALSE",
        init_file => "fp_div_altera_fp_functions_1917_ugoptdy_memoryC1_uid149_invTables_lutmem.hex",
        init_file_layout => "PORT_A",
        intended_device_family => "Cyclone 10 GX"
    )
    PORT MAP (
        clocken0 => memoryC1_uid149_invTables_lutmem_ena_NotRstA,
        aclr0 => memoryC1_uid149_invTables_lutmem_reset0,
        clock0 => clk,
        address_a => memoryC1_uid149_invTables_lutmem_aa,
        q_a => memoryC1_uid149_invTables_lutmem_ir
    );
    memoryC1_uid149_invTables_lutmem_r <= memoryC1_uid149_invTables_lutmem_ir(21 downto 0);

    -- s1sumAHighB_uid162_invPolyEval(ADD,161)@5
    s1sumAHighB_uid162_invPolyEval_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((22 downto 22 => memoryC1_uid149_invTables_lutmem_r(21)) & memoryC1_uid149_invTables_lutmem_r));
    s1sumAHighB_uid162_invPolyEval_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((22 downto 13 => highBBits_uid161_invPolyEval_b(12)) & highBBits_uid161_invPolyEval_b));
    s1sumAHighB_uid162_invPolyEval_o <= STD_LOGIC_VECTOR(SIGNED(s1sumAHighB_uid162_invPolyEval_a) + SIGNED(s1sumAHighB_uid162_invPolyEval_b));
    s1sumAHighB_uid162_invPolyEval_q <= s1sumAHighB_uid162_invPolyEval_o(22 downto 0);

    -- lowRangeB_uid160_invPolyEval(BITSELECT,159)@5
    lowRangeB_uid160_invPolyEval_in <= osig_uid175_pT1_uid159_invPolyEval_b(0 downto 0);
    lowRangeB_uid160_invPolyEval_b <= lowRangeB_uid160_invPolyEval_in(0 downto 0);

    -- s1_uid163_invPolyEval(BITJOIN,162)@5
    s1_uid163_invPolyEval_q <= s1sumAHighB_uid162_invPolyEval_q & lowRangeB_uid160_invPolyEval_b;

    -- redist10_yPE_uid52_fpDivTest_b_5(DELAY,198)
    redist10_yPE_uid52_fpDivTest_b_5_clkproc_0: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            redist10_yPE_uid52_fpDivTest_b_5_delay_0 <= (others => '0');
            redist10_yPE_uid52_fpDivTest_b_5_delay_1 <= (others => '0');
            redist10_yPE_uid52_fpDivTest_b_5_q <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            redist10_yPE_uid52_fpDivTest_b_5_delay_0 <= STD_LOGIC_VECTOR(redist9_yPE_uid52_fpDivTest_b_2_q);
            redist10_yPE_uid52_fpDivTest_b_5_delay_1 <= redist10_yPE_uid52_fpDivTest_b_5_delay_0;
            redist10_yPE_uid52_fpDivTest_b_5_q <= redist10_yPE_uid52_fpDivTest_b_5_delay_1;
        END IF;
    END PROCESS;

    -- prodXY_uid177_pT2_uid165_invPolyEval_cma(CHAINMULTADD,187)@5 + 3
    prodXY_uid177_pT2_uid165_invPolyEval_cma_reset <= areset;
    prodXY_uid177_pT2_uid165_invPolyEval_cma_ena0 <= '1';
    prodXY_uid177_pT2_uid165_invPolyEval_cma_ena1 <= prodXY_uid177_pT2_uid165_invPolyEval_cma_ena0;
    prodXY_uid177_pT2_uid165_invPolyEval_cma_ena2 <= prodXY_uid177_pT2_uid165_invPolyEval_cma_ena0;

    prodXY_uid177_pT2_uid165_invPolyEval_cma_a0 <= STD_LOGIC_VECTOR(RESIZE(UNSIGNED(redist10_yPE_uid52_fpDivTest_b_5_q),14));
    prodXY_uid177_pT2_uid165_invPolyEval_cma_c0 <= STD_LOGIC_VECTOR(RESIZE(SIGNED(s1_uid163_invPolyEval_q),24));
    prodXY_uid177_pT2_uid165_invPolyEval_cma_DSP0 : cyclone10gx_mac
    GENERIC MAP (
        operation_mode => "m27x27",
        use_chainadder => "false",
        ay_scan_in_clock => "0",
        ay_scan_in_width => 14,
        ax_clock => "0",
        ax_width => 24,
        signed_may => "false",
        signed_max => "true",
        input_pipeline_clock => "2",
        output_clock => "1",
        result_a_width => 38
    )
    PORT MAP (
        clk(0) => clk,
        clk(1) => clk,
        clk(2) => clk,
        ena(0) => prodXY_uid177_pT2_uid165_invPolyEval_cma_ena0,
        ena(1) => prodXY_uid177_pT2_uid165_invPolyEval_cma_ena1,
        ena(2) => prodXY_uid177_pT2_uid165_invPolyEval_cma_ena2,
        aclr(0) => prodXY_uid177_pT2_uid165_invPolyEval_cma_reset,
        aclr(1) => prodXY_uid177_pT2_uid165_invPolyEval_cma_reset,
        ay => prodXY_uid177_pT2_uid165_invPolyEval_cma_a0,
        ax => prodXY_uid177_pT2_uid165_invPolyEval_cma_c0,
        resulta => prodXY_uid177_pT2_uid165_invPolyEval_cma_s0
    );
    prodXY_uid177_pT2_uid165_invPolyEval_cma_delay0 : dspba_delay
    GENERIC MAP ( width => 38, depth => 0, reset_kind => "ASYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => prodXY_uid177_pT2_uid165_invPolyEval_cma_s0, xout => prodXY_uid177_pT2_uid165_invPolyEval_cma_qq0, clk => clk, aclr => areset, ena => '1' );
    prodXY_uid177_pT2_uid165_invPolyEval_cma_q <= STD_LOGIC_VECTOR(prodXY_uid177_pT2_uid165_invPolyEval_cma_qq0(37 downto 0));

    -- osig_uid178_pT2_uid165_invPolyEval(BITSELECT,177)@8
    osig_uid178_pT2_uid165_invPolyEval_b <= STD_LOGIC_VECTOR(prodXY_uid177_pT2_uid165_invPolyEval_cma_q(37 downto 13));

    -- highBBits_uid167_invPolyEval(BITSELECT,166)@8
    highBBits_uid167_invPolyEval_b <= STD_LOGIC_VECTOR(osig_uid178_pT2_uid165_invPolyEval_b(24 downto 2));

    -- redist12_yAddr_uid51_fpDivTest_b_6(DELAY,200)
    redist12_yAddr_uid51_fpDivTest_b_6_clkproc_0: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            redist12_yAddr_uid51_fpDivTest_b_6_delay_0 <= (others => '0');
            redist12_yAddr_uid51_fpDivTest_b_6_delay_1 <= (others => '0');
            redist12_yAddr_uid51_fpDivTest_b_6_q <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            redist12_yAddr_uid51_fpDivTest_b_6_delay_0 <= STD_LOGIC_VECTOR(redist11_yAddr_uid51_fpDivTest_b_3_q);
            redist12_yAddr_uid51_fpDivTest_b_6_delay_1 <= redist12_yAddr_uid51_fpDivTest_b_6_delay_0;
            redist12_yAddr_uid51_fpDivTest_b_6_q <= redist12_yAddr_uid51_fpDivTest_b_6_delay_1;
        END IF;
    END PROCESS;

    -- memoryC0_uid146_invTables_lutmem(DUALMEM,181)@6 + 2
    memoryC0_uid146_invTables_lutmem_aa <= redist12_yAddr_uid51_fpDivTest_b_6_q;
    memoryC0_uid146_invTables_lutmem_ena_NotRstA <= not (areset);
    memoryC0_uid146_invTables_lutmem_reset0 <= areset;
    memoryC0_uid146_invTables_lutmem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "M20K",
        operation_mode => "ROM",
        width_a => 32,
        widthad_a => 9,
        numwords_a => 512,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        outdata_reg_a => "CLOCK0",
        outdata_aclr_a => "CLEAR0",
        clock_enable_input_a => "NORMAL",
        power_up_uninitialized => "FALSE",
        init_file => "fp_div_altera_fp_functions_1917_ugoptdy_memoryC0_uid146_invTables_lutmem.hex",
        init_file_layout => "PORT_A",
        intended_device_family => "Cyclone 10 GX"
    )
    PORT MAP (
        clocken0 => memoryC0_uid146_invTables_lutmem_ena_NotRstA,
        aclr0 => memoryC0_uid146_invTables_lutmem_reset0,
        clock0 => clk,
        address_a => memoryC0_uid146_invTables_lutmem_aa,
        q_a => memoryC0_uid146_invTables_lutmem_ir
    );
    memoryC0_uid146_invTables_lutmem_r <= memoryC0_uid146_invTables_lutmem_ir(31 downto 0);

    -- s2sumAHighB_uid168_invPolyEval(ADD,167)@8
    s2sumAHighB_uid168_invPolyEval_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((32 downto 32 => memoryC0_uid146_invTables_lutmem_r(31)) & memoryC0_uid146_invTables_lutmem_r));
    s2sumAHighB_uid168_invPolyEval_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((32 downto 23 => highBBits_uid167_invPolyEval_b(22)) & highBBits_uid167_invPolyEval_b));
    s2sumAHighB_uid168_invPolyEval_o <= STD_LOGIC_VECTOR(SIGNED(s2sumAHighB_uid168_invPolyEval_a) + SIGNED(s2sumAHighB_uid168_invPolyEval_b));
    s2sumAHighB_uid168_invPolyEval_q <= s2sumAHighB_uid168_invPolyEval_o(32 downto 0);

    -- lowRangeB_uid166_invPolyEval(BITSELECT,165)@8
    lowRangeB_uid166_invPolyEval_in <= osig_uid178_pT2_uid165_invPolyEval_b(1 downto 0);
    lowRangeB_uid166_invPolyEval_b <= lowRangeB_uid166_invPolyEval_in(1 downto 0);

    -- s2_uid169_invPolyEval(BITJOIN,168)@8
    s2_uid169_invPolyEval_q <= s2sumAHighB_uid168_invPolyEval_q & lowRangeB_uid166_invPolyEval_b;

    -- invY_uid54_fpDivTest(BITSELECT,53)@8
    invY_uid54_fpDivTest_in <= s2_uid169_invPolyEval_q(31 downto 0);
    invY_uid54_fpDivTest_b <= invY_uid54_fpDivTest_in(31 downto 5);

    -- prodXY_uid171_divValPreNorm_uid59_fpDivTest_cma(CHAINMULTADD,185)@8 + 3
    prodXY_uid171_divValPreNorm_uid59_fpDivTest_cma_reset <= areset;
    prodXY_uid171_divValPreNorm_uid59_fpDivTest_cma_ena0 <= '1';
    prodXY_uid171_divValPreNorm_uid59_fpDivTest_cma_ena1 <= prodXY_uid171_divValPreNorm_uid59_fpDivTest_cma_ena0;
    prodXY_uid171_divValPreNorm_uid59_fpDivTest_cma_ena2 <= prodXY_uid171_divValPreNorm_uid59_fpDivTest_cma_ena0;

    prodXY_uid171_divValPreNorm_uid59_fpDivTest_cma_a0 <= STD_LOGIC_VECTOR(RESIZE(UNSIGNED(invY_uid54_fpDivTest_b),27));
    prodXY_uid171_divValPreNorm_uid59_fpDivTest_cma_c0 <= STD_LOGIC_VECTOR(RESIZE(UNSIGNED(lOAdded_uid57_fpDivTest_q),24));
    prodXY_uid171_divValPreNorm_uid59_fpDivTest_cma_DSP0 : cyclone10gx_mac
    GENERIC MAP (
        operation_mode => "m27x27",
        use_chainadder => "false",
        ay_scan_in_clock => "0",
        ay_scan_in_width => 27,
        ax_clock => "0",
        ax_width => 24,
        signed_may => "false",
        signed_max => "false",
        input_pipeline_clock => "2",
        output_clock => "1",
        result_a_width => 51
    )
    PORT MAP (
        clk(0) => clk,
        clk(1) => clk,
        clk(2) => clk,
        ena(0) => prodXY_uid171_divValPreNorm_uid59_fpDivTest_cma_ena0,
        ena(1) => prodXY_uid171_divValPreNorm_uid59_fpDivTest_cma_ena1,
        ena(2) => prodXY_uid171_divValPreNorm_uid59_fpDivTest_cma_ena2,
        aclr(0) => prodXY_uid171_divValPreNorm_uid59_fpDivTest_cma_reset,
        aclr(1) => prodXY_uid171_divValPreNorm_uid59_fpDivTest_cma_reset,
        ay => prodXY_uid171_divValPreNorm_uid59_fpDivTest_cma_a0,
        ax => prodXY_uid171_divValPreNorm_uid59_fpDivTest_cma_c0,
        resulta => prodXY_uid171_divValPreNorm_uid59_fpDivTest_cma_s0
    );
    prodXY_uid171_divValPreNorm_uid59_fpDivTest_cma_delay0 : dspba_delay
    GENERIC MAP ( width => 51, depth => 0, reset_kind => "ASYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => prodXY_uid171_divValPreNorm_uid59_fpDivTest_cma_s0, xout => prodXY_uid171_divValPreNorm_uid59_fpDivTest_cma_qq0, clk => clk, aclr => areset, ena => '1' );
    prodXY_uid171_divValPreNorm_uid59_fpDivTest_cma_q <= STD_LOGIC_VECTOR(prodXY_uid171_divValPreNorm_uid59_fpDivTest_cma_qq0(50 downto 0));

    -- osig_uid172_divValPreNorm_uid59_fpDivTest(BITSELECT,171)@11
    osig_uid172_divValPreNorm_uid59_fpDivTest_b <= prodXY_uid171_divValPreNorm_uid59_fpDivTest_cma_q(50 downto 23);

    -- fracYZero_uid15_fpDivTest(LOGICAL,16)@11
    fracYZero_uid15_fpDivTest_a <= STD_LOGIC_VECTOR("0" & redist14_fracY_uid13_fpDivTest_b_11_outputreg0_q);
    fracYZero_uid15_fpDivTest_q <= "1" WHEN fracYZero_uid15_fpDivTest_a = zeroPaddingInAddition_uid74_fpDivTest_q ELSE "0";

    -- divValPreNormYPow2Exc_uid63_fpDivTest(MUX,62)@11
    divValPreNormYPow2Exc_uid63_fpDivTest_s <= fracYZero_uid15_fpDivTest_q;
    divValPreNormYPow2Exc_uid63_fpDivTest_combproc: PROCESS (divValPreNormYPow2Exc_uid63_fpDivTest_s, osig_uid172_divValPreNorm_uid59_fpDivTest_b, oFracXZ4_uid61_fpDivTest_q)
    BEGIN
        CASE (divValPreNormYPow2Exc_uid63_fpDivTest_s) IS
            WHEN "0" => divValPreNormYPow2Exc_uid63_fpDivTest_q <= osig_uid172_divValPreNorm_uid59_fpDivTest_b;
            WHEN "1" => divValPreNormYPow2Exc_uid63_fpDivTest_q <= oFracXZ4_uid61_fpDivTest_q;
            WHEN OTHERS => divValPreNormYPow2Exc_uid63_fpDivTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- norm_uid64_fpDivTest(BITSELECT,63)@11
    norm_uid64_fpDivTest_b <= STD_LOGIC_VECTOR(divValPreNormYPow2Exc_uid63_fpDivTest_q(27 downto 27));

    -- zeroPaddingInAddition_uid74_fpDivTest(CONSTANT,73)
    zeroPaddingInAddition_uid74_fpDivTest_q <= "000000000000000000000000";

    -- rndOne_uid72_fpDivTest_b_const(CONSTANT,180)
    rndOne_uid72_fpDivTest_b_const_q <= "1";

    -- expFracPostRnd_uid75_fpDivTest(BITJOIN,74)@11
    expFracPostRnd_uid75_fpDivTest_q <= norm_uid64_fpDivTest_b & zeroPaddingInAddition_uid74_fpDivTest_q & rndOne_uid72_fpDivTest_b_const_q;

    -- cstBiasM1_uid6_fpDivTest(CONSTANT,5)
    cstBiasM1_uid6_fpDivTest_q <= "01111110";

    -- expXmY_uid47_fpDivTest(SUB,46)@11
    expXmY_uid47_fpDivTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("0" & redist18_expX_uid9_fpDivTest_b_11_mem_q));
    expXmY_uid47_fpDivTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("0" & redist15_expY_uid12_fpDivTest_b_11_outputreg0_q));
    expXmY_uid47_fpDivTest_o <= STD_LOGIC_VECTOR(SIGNED(expXmY_uid47_fpDivTest_a) - SIGNED(expXmY_uid47_fpDivTest_b));
    expXmY_uid47_fpDivTest_q <= expXmY_uid47_fpDivTest_o(8 downto 0);

    -- expR_uid48_fpDivTest(ADD,47)@11
    expR_uid48_fpDivTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((10 downto 9 => expXmY_uid47_fpDivTest_q(8)) & expXmY_uid47_fpDivTest_q));
    expR_uid48_fpDivTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("000" & cstBiasM1_uid6_fpDivTest_q));
    expR_uid48_fpDivTest_o <= STD_LOGIC_VECTOR(SIGNED(expR_uid48_fpDivTest_a) + SIGNED(expR_uid48_fpDivTest_b));
    expR_uid48_fpDivTest_q <= expR_uid48_fpDivTest_o(9 downto 0);

    -- divValPreNormHigh_uid65_fpDivTest(BITSELECT,64)@11
    divValPreNormHigh_uid65_fpDivTest_in <= divValPreNormYPow2Exc_uid63_fpDivTest_q(26 downto 0);
    divValPreNormHigh_uid65_fpDivTest_b <= divValPreNormHigh_uid65_fpDivTest_in(26 downto 2);

    -- divValPreNormLow_uid66_fpDivTest(BITSELECT,65)@11
    divValPreNormLow_uid66_fpDivTest_in <= divValPreNormYPow2Exc_uid63_fpDivTest_q(25 downto 0);
    divValPreNormLow_uid66_fpDivTest_b <= divValPreNormLow_uid66_fpDivTest_in(25 downto 1);

    -- normFracRnd_uid67_fpDivTest(MUX,66)@11
    normFracRnd_uid67_fpDivTest_s <= norm_uid64_fpDivTest_b;
    normFracRnd_uid67_fpDivTest_combproc: PROCESS (normFracRnd_uid67_fpDivTest_s, divValPreNormLow_uid66_fpDivTest_b, divValPreNormHigh_uid65_fpDivTest_b)
    BEGIN
        CASE (normFracRnd_uid67_fpDivTest_s) IS
            WHEN "0" => normFracRnd_uid67_fpDivTest_q <= divValPreNormLow_uid66_fpDivTest_b;
            WHEN "1" => normFracRnd_uid67_fpDivTest_q <= divValPreNormHigh_uid65_fpDivTest_b;
            WHEN OTHERS => normFracRnd_uid67_fpDivTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- expFracRnd_uid68_fpDivTest(BITJOIN,67)@11
    expFracRnd_uid68_fpDivTest_q <= expR_uid48_fpDivTest_q & normFracRnd_uid67_fpDivTest_q;

    -- expFracPostRnd_uid76_fpDivTest(ADD,75)@11
    expFracPostRnd_uid76_fpDivTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((36 downto 35 => expFracRnd_uid68_fpDivTest_q(34)) & expFracRnd_uid68_fpDivTest_q));
    expFracPostRnd_uid76_fpDivTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("00000000000" & expFracPostRnd_uid75_fpDivTest_q));
    expFracPostRnd_uid76_fpDivTest_o <= STD_LOGIC_VECTOR(SIGNED(expFracPostRnd_uid76_fpDivTest_a) + SIGNED(expFracPostRnd_uid76_fpDivTest_b));
    expFracPostRnd_uid76_fpDivTest_q <= expFracPostRnd_uid76_fpDivTest_o(35 downto 0);

    -- fracPostRndF_uid79_fpDivTest(BITSELECT,78)@11
    fracPostRndF_uid79_fpDivTest_in <= expFracPostRnd_uid76_fpDivTest_q(24 downto 0);
    fracPostRndF_uid79_fpDivTest_b <= fracPostRndF_uid79_fpDivTest_in(24 downto 1);

    -- invYO_uid55_fpDivTest(BITSELECT,54)@8
    invYO_uid55_fpDivTest_in <= STD_LOGIC_VECTOR(s2_uid169_invPolyEval_q(32 downto 0));
    invYO_uid55_fpDivTest_b <= STD_LOGIC_VECTOR(invYO_uid55_fpDivTest_in(32 downto 32));

    -- redist8_invYO_uid55_fpDivTest_b_3(DELAY,196)
    redist8_invYO_uid55_fpDivTest_b_3_clkproc_0: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            redist8_invYO_uid55_fpDivTest_b_3_delay_0 <= (others => '0');
            redist8_invYO_uid55_fpDivTest_b_3_delay_1 <= (others => '0');
            redist8_invYO_uid55_fpDivTest_b_3_q <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            redist8_invYO_uid55_fpDivTest_b_3_delay_0 <= STD_LOGIC_VECTOR(invYO_uid55_fpDivTest_b);
            redist8_invYO_uid55_fpDivTest_b_3_delay_1 <= redist8_invYO_uid55_fpDivTest_b_3_delay_0;
            redist8_invYO_uid55_fpDivTest_b_3_q <= redist8_invYO_uid55_fpDivTest_b_3_delay_1;
        END IF;
    END PROCESS;

    -- fracPostRndF_uid80_fpDivTest(MUX,79)@11
    fracPostRndF_uid80_fpDivTest_s <= redist8_invYO_uid55_fpDivTest_b_3_q;
    fracPostRndF_uid80_fpDivTest_combproc: PROCESS (fracPostRndF_uid80_fpDivTest_s, fracPostRndF_uid79_fpDivTest_b, fracXExt_uid77_fpDivTest_q)
    BEGIN
        CASE (fracPostRndF_uid80_fpDivTest_s) IS
            WHEN "0" => fracPostRndF_uid80_fpDivTest_q <= fracPostRndF_uid79_fpDivTest_b;
            WHEN "1" => fracPostRndF_uid80_fpDivTest_q <= fracXExt_uid77_fpDivTest_q;
            WHEN OTHERS => fracPostRndF_uid80_fpDivTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- fracPostRndFT_uid104_fpDivTest(BITSELECT,103)@11
    fracPostRndFT_uid104_fpDivTest_b <= fracPostRndF_uid80_fpDivTest_q(23 downto 1);

    -- redist2_fracPostRndFT_uid104_fpDivTest_b_3(DELAY,190)
    redist2_fracPostRndFT_uid104_fpDivTest_b_3_clkproc_0: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            redist2_fracPostRndFT_uid104_fpDivTest_b_3_delay_0 <= (others => '0');
            redist2_fracPostRndFT_uid104_fpDivTest_b_3_delay_1 <= (others => '0');
            redist2_fracPostRndFT_uid104_fpDivTest_b_3_q <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            redist2_fracPostRndFT_uid104_fpDivTest_b_3_delay_0 <= STD_LOGIC_VECTOR(fracPostRndFT_uid104_fpDivTest_b);
            redist2_fracPostRndFT_uid104_fpDivTest_b_3_delay_1 <= redist2_fracPostRndFT_uid104_fpDivTest_b_3_delay_0;
            redist2_fracPostRndFT_uid104_fpDivTest_b_3_q <= redist2_fracPostRndFT_uid104_fpDivTest_b_3_delay_1;
        END IF;
    END PROCESS;

    -- fracRPreExcExt_uid105_fpDivTest(ADD,104)@14
    fracRPreExcExt_uid105_fpDivTest_a <= STD_LOGIC_VECTOR("0" & redist2_fracPostRndFT_uid104_fpDivTest_b_3_q);
    fracRPreExcExt_uid105_fpDivTest_b <= STD_LOGIC_VECTOR("00000000000000000000000" & extraUlp_uid103_fpDivTest_q);
    fracRPreExcExt_uid105_fpDivTest_o <= STD_LOGIC_VECTOR(UNSIGNED(fracRPreExcExt_uid105_fpDivTest_a) + UNSIGNED(fracRPreExcExt_uid105_fpDivTest_b));
    fracRPreExcExt_uid105_fpDivTest_q <= fracRPreExcExt_uid105_fpDivTest_o(23 downto 0);

    -- ovfIncRnd_uid109_fpDivTest(BITSELECT,108)@14
    ovfIncRnd_uid109_fpDivTest_b <= STD_LOGIC_VECTOR(fracRPreExcExt_uid105_fpDivTest_q(23 downto 23));

    -- expFracPostRndInc_uid110_fpDivTest(ADD,109)@14
    expFracPostRndInc_uid110_fpDivTest_a <= STD_LOGIC_VECTOR("0" & redist6_expPostRndFR_uid81_fpDivTest_b_3_q);
    expFracPostRndInc_uid110_fpDivTest_b <= STD_LOGIC_VECTOR("00000000" & ovfIncRnd_uid109_fpDivTest_b);
    expFracPostRndInc_uid110_fpDivTest_o <= STD_LOGIC_VECTOR(UNSIGNED(expFracPostRndInc_uid110_fpDivTest_a) + UNSIGNED(expFracPostRndInc_uid110_fpDivTest_b));
    expFracPostRndInc_uid110_fpDivTest_q <= expFracPostRndInc_uid110_fpDivTest_o(8 downto 0);

    -- expFracPostRndR_uid111_fpDivTest(BITSELECT,110)@14
    expFracPostRndR_uid111_fpDivTest_in <= expFracPostRndInc_uid110_fpDivTest_q(7 downto 0);
    expFracPostRndR_uid111_fpDivTest_b <= expFracPostRndR_uid111_fpDivTest_in(7 downto 0);

    -- expPostRndFR_uid81_fpDivTest(BITSELECT,80)@11
    expPostRndFR_uid81_fpDivTest_in <= expFracPostRnd_uid76_fpDivTest_q(32 downto 0);
    expPostRndFR_uid81_fpDivTest_b <= expPostRndFR_uid81_fpDivTest_in(32 downto 25);

    -- redist6_expPostRndFR_uid81_fpDivTest_b_3(DELAY,194)
    redist6_expPostRndFR_uid81_fpDivTest_b_3_clkproc_0: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            redist6_expPostRndFR_uid81_fpDivTest_b_3_delay_0 <= (others => '0');
            redist6_expPostRndFR_uid81_fpDivTest_b_3_delay_1 <= (others => '0');
            redist6_expPostRndFR_uid81_fpDivTest_b_3_q <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            redist6_expPostRndFR_uid81_fpDivTest_b_3_delay_0 <= STD_LOGIC_VECTOR(expPostRndFR_uid81_fpDivTest_b);
            redist6_expPostRndFR_uid81_fpDivTest_b_3_delay_1 <= redist6_expPostRndFR_uid81_fpDivTest_b_3_delay_0;
            redist6_expPostRndFR_uid81_fpDivTest_b_3_q <= redist6_expPostRndFR_uid81_fpDivTest_b_3_delay_1;
        END IF;
    END PROCESS;

    -- betweenFPwF_uid102_fpDivTest(BITSELECT,101)@11
    betweenFPwF_uid102_fpDivTest_in <= STD_LOGIC_VECTOR(fracPostRndF_uid80_fpDivTest_q(0 downto 0));
    betweenFPwF_uid102_fpDivTest_b <= STD_LOGIC_VECTOR(betweenFPwF_uid102_fpDivTest_in(0 downto 0));

    -- redist3_betweenFPwF_uid102_fpDivTest_b_3(DELAY,191)
    redist3_betweenFPwF_uid102_fpDivTest_b_3_clkproc_0: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            redist3_betweenFPwF_uid102_fpDivTest_b_3_delay_0 <= (others => '0');
            redist3_betweenFPwF_uid102_fpDivTest_b_3_delay_1 <= (others => '0');
            redist3_betweenFPwF_uid102_fpDivTest_b_3_q <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            redist3_betweenFPwF_uid102_fpDivTest_b_3_delay_0 <= STD_LOGIC_VECTOR(betweenFPwF_uid102_fpDivTest_b);
            redist3_betweenFPwF_uid102_fpDivTest_b_3_delay_1 <= redist3_betweenFPwF_uid102_fpDivTest_b_3_delay_0;
            redist3_betweenFPwF_uid102_fpDivTest_b_3_q <= redist3_betweenFPwF_uid102_fpDivTest_b_3_delay_1;
        END IF;
    END PROCESS;

    -- qDivProdLTX_opB_uid100_fpDivTest(BITJOIN,99)@11
    qDivProdLTX_opB_uid100_fpDivTest_q <= redist18_expX_uid9_fpDivTest_b_11_mem_q & redist17_fracX_uid10_fpDivTest_b_11_q;

    -- redist4_qDivProdLTX_opB_uid100_fpDivTest_q_3(DELAY,192)
    redist4_qDivProdLTX_opB_uid100_fpDivTest_q_3_clkproc_0: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            redist4_qDivProdLTX_opB_uid100_fpDivTest_q_3_delay_0 <= (others => '0');
            redist4_qDivProdLTX_opB_uid100_fpDivTest_q_3_q <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            redist4_qDivProdLTX_opB_uid100_fpDivTest_q_3_delay_0 <= STD_LOGIC_VECTOR(qDivProdLTX_opB_uid100_fpDivTest_q);
            redist4_qDivProdLTX_opB_uid100_fpDivTest_q_3_q <= redist4_qDivProdLTX_opB_uid100_fpDivTest_q_3_delay_0;
        END IF;
    END PROCESS;

    -- redist4_qDivProdLTX_opB_uid100_fpDivTest_q_3_outputreg0(DELAY,207)
    redist4_qDivProdLTX_opB_uid100_fpDivTest_q_3_outputreg0_clkproc_0: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            redist4_qDivProdLTX_opB_uid100_fpDivTest_q_3_outputreg0_q <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            redist4_qDivProdLTX_opB_uid100_fpDivTest_q_3_outputreg0_q <= STD_LOGIC_VECTOR(redist4_qDivProdLTX_opB_uid100_fpDivTest_q_3_q);
        END IF;
    END PROCESS;

    -- lOAdded_uid87_fpDivTest(BITJOIN,86)@11
    lOAdded_uid87_fpDivTest_q <= VCC_q & redist14_fracY_uid13_fpDivTest_b_11_outputreg0_q;

    -- lOAdded_uid84_fpDivTest(BITJOIN,83)@11
    lOAdded_uid84_fpDivTest_q <= VCC_q & fracPostRndF_uid80_fpDivTest_q;

    -- qDivProd_uid89_fpDivTest_cma(CHAINMULTADD,184)@11 + 3
    qDivProd_uid89_fpDivTest_cma_reset <= areset;
    qDivProd_uid89_fpDivTest_cma_ena0 <= '1';
    qDivProd_uid89_fpDivTest_cma_ena1 <= qDivProd_uid89_fpDivTest_cma_ena0;
    qDivProd_uid89_fpDivTest_cma_ena2 <= qDivProd_uid89_fpDivTest_cma_ena0;

    qDivProd_uid89_fpDivTest_cma_a0 <= STD_LOGIC_VECTOR(RESIZE(UNSIGNED(lOAdded_uid84_fpDivTest_q),25));
    qDivProd_uid89_fpDivTest_cma_c0 <= STD_LOGIC_VECTOR(RESIZE(UNSIGNED(lOAdded_uid87_fpDivTest_q),24));
    qDivProd_uid89_fpDivTest_cma_DSP0 : cyclone10gx_mac
    GENERIC MAP (
        operation_mode => "m27x27",
        use_chainadder => "false",
        ay_scan_in_clock => "0",
        ay_scan_in_width => 25,
        ax_clock => "0",
        ax_width => 24,
        signed_may => "false",
        signed_max => "false",
        input_pipeline_clock => "2",
        output_clock => "1",
        result_a_width => 49
    )
    PORT MAP (
        clk(0) => clk,
        clk(1) => clk,
        clk(2) => clk,
        ena(0) => qDivProd_uid89_fpDivTest_cma_ena0,
        ena(1) => qDivProd_uid89_fpDivTest_cma_ena1,
        ena(2) => qDivProd_uid89_fpDivTest_cma_ena2,
        aclr(0) => qDivProd_uid89_fpDivTest_cma_reset,
        aclr(1) => qDivProd_uid89_fpDivTest_cma_reset,
        ay => qDivProd_uid89_fpDivTest_cma_a0,
        ax => qDivProd_uid89_fpDivTest_cma_c0,
        resulta => qDivProd_uid89_fpDivTest_cma_s0
    );
    qDivProd_uid89_fpDivTest_cma_delay0 : dspba_delay
    GENERIC MAP ( width => 49, depth => 0, reset_kind => "ASYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => qDivProd_uid89_fpDivTest_cma_s0, xout => qDivProd_uid89_fpDivTest_cma_qq0, clk => clk, aclr => areset, ena => '1' );
    qDivProd_uid89_fpDivTest_cma_q <= STD_LOGIC_VECTOR(qDivProd_uid89_fpDivTest_cma_qq0(48 downto 0));

    -- qDivProdNorm_uid90_fpDivTest(BITSELECT,89)@14
    qDivProdNorm_uid90_fpDivTest_b <= STD_LOGIC_VECTOR(qDivProd_uid89_fpDivTest_cma_q(48 downto 48));

    -- cstBias_uid7_fpDivTest(CONSTANT,6)
    cstBias_uid7_fpDivTest_q <= "01111111";

    -- qDivProdExp_opBs_uid95_fpDivTest(SUB,94)@14
    qDivProdExp_opBs_uid95_fpDivTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("0" & cstBias_uid7_fpDivTest_q));
    qDivProdExp_opBs_uid95_fpDivTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("00000000" & qDivProdNorm_uid90_fpDivTest_b));
    qDivProdExp_opBs_uid95_fpDivTest_o <= STD_LOGIC_VECTOR(SIGNED(qDivProdExp_opBs_uid95_fpDivTest_a) - SIGNED(qDivProdExp_opBs_uid95_fpDivTest_b));
    qDivProdExp_opBs_uid95_fpDivTest_q <= qDivProdExp_opBs_uid95_fpDivTest_o(8 downto 0);

    -- expPostRndF_uid82_fpDivTest(MUX,81)@11
    expPostRndF_uid82_fpDivTest_s <= redist8_invYO_uid55_fpDivTest_b_3_q;
    expPostRndF_uid82_fpDivTest_combproc: PROCESS (expPostRndF_uid82_fpDivTest_s, expPostRndFR_uid81_fpDivTest_b, redist18_expX_uid9_fpDivTest_b_11_mem_q)
    BEGIN
        CASE (expPostRndF_uid82_fpDivTest_s) IS
            WHEN "0" => expPostRndF_uid82_fpDivTest_q <= expPostRndFR_uid81_fpDivTest_b;
            WHEN "1" => expPostRndF_uid82_fpDivTest_q <= redist18_expX_uid9_fpDivTest_b_11_mem_q;
            WHEN OTHERS => expPostRndF_uid82_fpDivTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- qDivProdExp_opA_uid94_fpDivTest(ADD,93)@11 + 1
    qDivProdExp_opA_uid94_fpDivTest_a <= STD_LOGIC_VECTOR("0" & redist15_expY_uid12_fpDivTest_b_11_outputreg0_q);
    qDivProdExp_opA_uid94_fpDivTest_b <= STD_LOGIC_VECTOR("0" & expPostRndF_uid82_fpDivTest_q);
    qDivProdExp_opA_uid94_fpDivTest_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            qDivProdExp_opA_uid94_fpDivTest_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            qDivProdExp_opA_uid94_fpDivTest_o <= STD_LOGIC_VECTOR(UNSIGNED(qDivProdExp_opA_uid94_fpDivTest_a) + UNSIGNED(qDivProdExp_opA_uid94_fpDivTest_b));
        END IF;
    END PROCESS;
    qDivProdExp_opA_uid94_fpDivTest_q <= qDivProdExp_opA_uid94_fpDivTest_o(8 downto 0);

    -- redist5_qDivProdExp_opA_uid94_fpDivTest_q_3(DELAY,193)
    redist5_qDivProdExp_opA_uid94_fpDivTest_q_3_clkproc_0: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            redist5_qDivProdExp_opA_uid94_fpDivTest_q_3_delay_0 <= (others => '0');
            redist5_qDivProdExp_opA_uid94_fpDivTest_q_3_q <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            redist5_qDivProdExp_opA_uid94_fpDivTest_q_3_delay_0 <= STD_LOGIC_VECTOR(qDivProdExp_opA_uid94_fpDivTest_q);
            redist5_qDivProdExp_opA_uid94_fpDivTest_q_3_q <= redist5_qDivProdExp_opA_uid94_fpDivTest_q_3_delay_0;
        END IF;
    END PROCESS;

    -- qDivProdExp_uid96_fpDivTest(SUB,95)@14
    qDivProdExp_uid96_fpDivTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("000" & redist5_qDivProdExp_opA_uid94_fpDivTest_q_3_q));
    qDivProdExp_uid96_fpDivTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((11 downto 9 => qDivProdExp_opBs_uid95_fpDivTest_q(8)) & qDivProdExp_opBs_uid95_fpDivTest_q));
    qDivProdExp_uid96_fpDivTest_o <= STD_LOGIC_VECTOR(SIGNED(qDivProdExp_uid96_fpDivTest_a) - SIGNED(qDivProdExp_uid96_fpDivTest_b));
    qDivProdExp_uid96_fpDivTest_q <= qDivProdExp_uid96_fpDivTest_o(10 downto 0);

    -- qDivProdLTX_opA_uid98_fpDivTest(BITSELECT,97)@14
    qDivProdLTX_opA_uid98_fpDivTest_in <= qDivProdExp_uid96_fpDivTest_q(7 downto 0);
    qDivProdLTX_opA_uid98_fpDivTest_b <= qDivProdLTX_opA_uid98_fpDivTest_in(7 downto 0);

    -- qDivProdFracHigh_uid91_fpDivTest(BITSELECT,90)@14
    qDivProdFracHigh_uid91_fpDivTest_in <= qDivProd_uid89_fpDivTest_cma_q(47 downto 0);
    qDivProdFracHigh_uid91_fpDivTest_b <= qDivProdFracHigh_uid91_fpDivTest_in(47 downto 24);

    -- qDivProdFracLow_uid92_fpDivTest(BITSELECT,91)@14
    qDivProdFracLow_uid92_fpDivTest_in <= qDivProd_uid89_fpDivTest_cma_q(46 downto 0);
    qDivProdFracLow_uid92_fpDivTest_b <= qDivProdFracLow_uid92_fpDivTest_in(46 downto 23);

    -- qDivProdFrac_uid93_fpDivTest(MUX,92)@14
    qDivProdFrac_uid93_fpDivTest_s <= qDivProdNorm_uid90_fpDivTest_b;
    qDivProdFrac_uid93_fpDivTest_combproc: PROCESS (qDivProdFrac_uid93_fpDivTest_s, qDivProdFracLow_uid92_fpDivTest_b, qDivProdFracHigh_uid91_fpDivTest_b)
    BEGIN
        CASE (qDivProdFrac_uid93_fpDivTest_s) IS
            WHEN "0" => qDivProdFrac_uid93_fpDivTest_q <= qDivProdFracLow_uid92_fpDivTest_b;
            WHEN "1" => qDivProdFrac_uid93_fpDivTest_q <= qDivProdFracHigh_uid91_fpDivTest_b;
            WHEN OTHERS => qDivProdFrac_uid93_fpDivTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- qDivProdFracWF_uid97_fpDivTest(BITSELECT,96)@14
    qDivProdFracWF_uid97_fpDivTest_b <= qDivProdFrac_uid93_fpDivTest_q(23 downto 1);

    -- qDivProdLTX_opA_uid99_fpDivTest(BITJOIN,98)@14
    qDivProdLTX_opA_uid99_fpDivTest_q <= qDivProdLTX_opA_uid98_fpDivTest_b & qDivProdFracWF_uid97_fpDivTest_b;

    -- qDividerProdLTX_uid101_fpDivTest(COMPARE,100)@14
    qDividerProdLTX_uid101_fpDivTest_a <= STD_LOGIC_VECTOR("00" & qDivProdLTX_opA_uid99_fpDivTest_q);
    qDividerProdLTX_uid101_fpDivTest_b <= STD_LOGIC_VECTOR("00" & redist4_qDivProdLTX_opB_uid100_fpDivTest_q_3_outputreg0_q);
    qDividerProdLTX_uid101_fpDivTest_o <= STD_LOGIC_VECTOR(UNSIGNED(qDividerProdLTX_uid101_fpDivTest_a) - UNSIGNED(qDividerProdLTX_uid101_fpDivTest_b));
    qDividerProdLTX_uid101_fpDivTest_c(0) <= qDividerProdLTX_uid101_fpDivTest_o(32);

    -- extraUlp_uid103_fpDivTest(LOGICAL,102)@14
    extraUlp_uid103_fpDivTest_q <= qDividerProdLTX_uid101_fpDivTest_c and redist3_betweenFPwF_uid102_fpDivTest_b_3_q;

    -- expRPreExc_uid112_fpDivTest(MUX,111)@14
    expRPreExc_uid112_fpDivTest_s <= extraUlp_uid103_fpDivTest_q;
    expRPreExc_uid112_fpDivTest_combproc: PROCESS (expRPreExc_uid112_fpDivTest_s, redist6_expPostRndFR_uid81_fpDivTest_b_3_q, expFracPostRndR_uid111_fpDivTest_b)
    BEGIN
        CASE (expRPreExc_uid112_fpDivTest_s) IS
            WHEN "0" => expRPreExc_uid112_fpDivTest_q <= redist6_expPostRndFR_uid81_fpDivTest_b_3_q;
            WHEN "1" => expRPreExc_uid112_fpDivTest_q <= expFracPostRndR_uid111_fpDivTest_b;
            WHEN OTHERS => expRPreExc_uid112_fpDivTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- invExpXIsMax_uid43_fpDivTest(LOGICAL,42)@11
    invExpXIsMax_uid43_fpDivTest_q <= not (expXIsMax_uid38_fpDivTest_q);

    -- InvExpXIsZero_uid44_fpDivTest(LOGICAL,43)@11
    InvExpXIsZero_uid44_fpDivTest_q <= not (excZ_y_uid37_fpDivTest_q);

    -- excR_y_uid45_fpDivTest(LOGICAL,44)@11
    excR_y_uid45_fpDivTest_q <= InvExpXIsZero_uid44_fpDivTest_q and invExpXIsMax_uid43_fpDivTest_q;

    -- excXIYR_uid127_fpDivTest(LOGICAL,126)@11
    excXIYR_uid127_fpDivTest_q <= excI_x_uid27_fpDivTest_q and excR_y_uid45_fpDivTest_q;

    -- excXIYZ_uid126_fpDivTest(LOGICAL,125)@11
    excXIYZ_uid126_fpDivTest_q <= excI_x_uid27_fpDivTest_q and excZ_y_uid37_fpDivTest_q;

    -- expRExt_uid114_fpDivTest(BITSELECT,113)@11
    expRExt_uid114_fpDivTest_b <= STD_LOGIC_VECTOR(expFracPostRnd_uid76_fpDivTest_q(35 downto 25));

    -- expOvf_uid118_fpDivTest(COMPARE,117)@11
    expOvf_uid118_fpDivTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((12 downto 11 => expRExt_uid114_fpDivTest_b(10)) & expRExt_uid114_fpDivTest_b));
    expOvf_uid118_fpDivTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("00000" & cstAllOWE_uid18_fpDivTest_q));
    expOvf_uid118_fpDivTest_o <= STD_LOGIC_VECTOR(SIGNED(expOvf_uid118_fpDivTest_a) - SIGNED(expOvf_uid118_fpDivTest_b));
    expOvf_uid118_fpDivTest_n(0) <= not (expOvf_uid118_fpDivTest_o(12));

    -- invExpXIsMax_uid29_fpDivTest(LOGICAL,28)@11
    invExpXIsMax_uid29_fpDivTest_q <= not (expXIsMax_uid24_fpDivTest_q);

    -- InvExpXIsZero_uid30_fpDivTest(LOGICAL,29)@11
    InvExpXIsZero_uid30_fpDivTest_q <= not (excZ_x_uid23_fpDivTest_q);

    -- excR_x_uid31_fpDivTest(LOGICAL,30)@11
    excR_x_uid31_fpDivTest_q <= InvExpXIsZero_uid30_fpDivTest_q and invExpXIsMax_uid29_fpDivTest_q;

    -- excXRYROvf_uid125_fpDivTest(LOGICAL,124)@11
    excXRYROvf_uid125_fpDivTest_q <= excR_x_uid31_fpDivTest_q and excR_y_uid45_fpDivTest_q and expOvf_uid118_fpDivTest_n;

    -- excXRYZ_uid124_fpDivTest(LOGICAL,123)@11
    excXRYZ_uid124_fpDivTest_q <= excR_x_uid31_fpDivTest_q and excZ_y_uid37_fpDivTest_q;

    -- excRInf_uid128_fpDivTest(LOGICAL,127)@11
    excRInf_uid128_fpDivTest_q <= excXRYZ_uid124_fpDivTest_q or excXRYROvf_uid125_fpDivTest_q or excXIYZ_uid126_fpDivTest_q or excXIYR_uid127_fpDivTest_q;

    -- xRegOrZero_uid121_fpDivTest(LOGICAL,120)@11
    xRegOrZero_uid121_fpDivTest_q <= excR_x_uid31_fpDivTest_q or excZ_x_uid23_fpDivTest_q;

    -- regOrZeroOverInf_uid122_fpDivTest(LOGICAL,121)@11
    regOrZeroOverInf_uid122_fpDivTest_q <= xRegOrZero_uid121_fpDivTest_q and excI_y_uid41_fpDivTest_q;

    -- expUdf_uid115_fpDivTest(COMPARE,114)@11
    expUdf_uid115_fpDivTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("000000000000" & GND_q));
    expUdf_uid115_fpDivTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((12 downto 11 => expRExt_uid114_fpDivTest_b(10)) & expRExt_uid114_fpDivTest_b));
    expUdf_uid115_fpDivTest_o <= STD_LOGIC_VECTOR(SIGNED(expUdf_uid115_fpDivTest_a) - SIGNED(expUdf_uid115_fpDivTest_b));
    expUdf_uid115_fpDivTest_n(0) <= not (expUdf_uid115_fpDivTest_o(12));

    -- regOverRegWithUf_uid120_fpDivTest(LOGICAL,119)@11
    regOverRegWithUf_uid120_fpDivTest_q <= expUdf_uid115_fpDivTest_n and excR_x_uid31_fpDivTest_q and excR_y_uid45_fpDivTest_q;

    -- zeroOverReg_uid119_fpDivTest(LOGICAL,118)@11
    zeroOverReg_uid119_fpDivTest_q <= excZ_x_uid23_fpDivTest_q and excR_y_uid45_fpDivTest_q;

    -- excRZero_uid123_fpDivTest(LOGICAL,122)@11
    excRZero_uid123_fpDivTest_q <= zeroOverReg_uid119_fpDivTest_q or regOverRegWithUf_uid120_fpDivTest_q or regOrZeroOverInf_uid122_fpDivTest_q;

    -- concExc_uid132_fpDivTest(BITJOIN,131)@11
    concExc_uid132_fpDivTest_q <= excRNaN_uid131_fpDivTest_q & excRInf_uid128_fpDivTest_q & excRZero_uid123_fpDivTest_q;

    -- excREnc_uid133_fpDivTest(LOOKUP,132)@11 + 1
    excREnc_uid133_fpDivTest_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            excREnc_uid133_fpDivTest_q <= "01";
        ELSIF (clk'EVENT AND clk = '1') THEN
            CASE (concExc_uid132_fpDivTest_q) IS
                WHEN "000" => excREnc_uid133_fpDivTest_q <= "01";
                WHEN "001" => excREnc_uid133_fpDivTest_q <= "00";
                WHEN "010" => excREnc_uid133_fpDivTest_q <= "10";
                WHEN "011" => excREnc_uid133_fpDivTest_q <= "00";
                WHEN "100" => excREnc_uid133_fpDivTest_q <= "11";
                WHEN "101" => excREnc_uid133_fpDivTest_q <= "00";
                WHEN "110" => excREnc_uid133_fpDivTest_q <= "00";
                WHEN "111" => excREnc_uid133_fpDivTest_q <= "00";
                WHEN OTHERS => -- unreachable
                               excREnc_uid133_fpDivTest_q <= (others => '-');
            END CASE;
        END IF;
    END PROCESS;

    -- redist1_excREnc_uid133_fpDivTest_q_3(DELAY,189)
    redist1_excREnc_uid133_fpDivTest_q_3_clkproc_0: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            redist1_excREnc_uid133_fpDivTest_q_3_delay_0 <= (others => '0');
            redist1_excREnc_uid133_fpDivTest_q_3_q <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            redist1_excREnc_uid133_fpDivTest_q_3_delay_0 <= STD_LOGIC_VECTOR(excREnc_uid133_fpDivTest_q);
            redist1_excREnc_uid133_fpDivTest_q_3_q <= redist1_excREnc_uid133_fpDivTest_q_3_delay_0;
        END IF;
    END PROCESS;

    -- expRPostExc_uid141_fpDivTest(MUX,140)@14
    expRPostExc_uid141_fpDivTest_s <= redist1_excREnc_uid133_fpDivTest_q_3_q;
    expRPostExc_uid141_fpDivTest_combproc: PROCESS (expRPostExc_uid141_fpDivTest_s, cstAllZWE_uid20_fpDivTest_q, expRPreExc_uid112_fpDivTest_q, cstAllOWE_uid18_fpDivTest_q)
    BEGIN
        CASE (expRPostExc_uid141_fpDivTest_s) IS
            WHEN "00" => expRPostExc_uid141_fpDivTest_q <= cstAllZWE_uid20_fpDivTest_q;
            WHEN "01" => expRPostExc_uid141_fpDivTest_q <= expRPreExc_uid112_fpDivTest_q;
            WHEN "10" => expRPostExc_uid141_fpDivTest_q <= cstAllOWE_uid18_fpDivTest_q;
            WHEN "11" => expRPostExc_uid141_fpDivTest_q <= cstAllOWE_uid18_fpDivTest_q;
            WHEN OTHERS => expRPostExc_uid141_fpDivTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- oneFracRPostExc2_uid134_fpDivTest(CONSTANT,133)
    oneFracRPostExc2_uid134_fpDivTest_q <= "00000000000000000000001";

    -- fracPostRndFPostUlp_uid106_fpDivTest(BITSELECT,105)@14
    fracPostRndFPostUlp_uid106_fpDivTest_in <= fracRPreExcExt_uid105_fpDivTest_q(22 downto 0);
    fracPostRndFPostUlp_uid106_fpDivTest_b <= fracPostRndFPostUlp_uid106_fpDivTest_in(22 downto 0);

    -- fracRPreExc_uid107_fpDivTest(MUX,106)@14
    fracRPreExc_uid107_fpDivTest_s <= extraUlp_uid103_fpDivTest_q;
    fracRPreExc_uid107_fpDivTest_combproc: PROCESS (fracRPreExc_uid107_fpDivTest_s, redist2_fracPostRndFT_uid104_fpDivTest_b_3_q, fracPostRndFPostUlp_uid106_fpDivTest_b)
    BEGIN
        CASE (fracRPreExc_uid107_fpDivTest_s) IS
            WHEN "0" => fracRPreExc_uid107_fpDivTest_q <= redist2_fracPostRndFT_uid104_fpDivTest_b_3_q;
            WHEN "1" => fracRPreExc_uid107_fpDivTest_q <= fracPostRndFPostUlp_uid106_fpDivTest_b;
            WHEN OTHERS => fracRPreExc_uid107_fpDivTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- fracRPostExc_uid137_fpDivTest(MUX,136)@14
    fracRPostExc_uid137_fpDivTest_s <= redist1_excREnc_uid133_fpDivTest_q_3_q;
    fracRPostExc_uid137_fpDivTest_combproc: PROCESS (fracRPostExc_uid137_fpDivTest_s, cstZeroWF_uid19_fpDivTest_q, fracRPreExc_uid107_fpDivTest_q, oneFracRPostExc2_uid134_fpDivTest_q)
    BEGIN
        CASE (fracRPostExc_uid137_fpDivTest_s) IS
            WHEN "00" => fracRPostExc_uid137_fpDivTest_q <= cstZeroWF_uid19_fpDivTest_q;
            WHEN "01" => fracRPostExc_uid137_fpDivTest_q <= fracRPreExc_uid107_fpDivTest_q;
            WHEN "10" => fracRPostExc_uid137_fpDivTest_q <= cstZeroWF_uid19_fpDivTest_q;
            WHEN "11" => fracRPostExc_uid137_fpDivTest_q <= oneFracRPostExc2_uid134_fpDivTest_q;
            WHEN OTHERS => fracRPostExc_uid137_fpDivTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- divR_uid144_fpDivTest(BITJOIN,143)@14
    divR_uid144_fpDivTest_q <= redist0_sRPostExc_uid143_fpDivTest_q_3_q & expRPostExc_uid141_fpDivTest_q & fracRPostExc_uid137_fpDivTest_q;

    -- xOut(GPOUT,4)@14
    q <= divR_uid144_fpDivTest_q;

END normal;
