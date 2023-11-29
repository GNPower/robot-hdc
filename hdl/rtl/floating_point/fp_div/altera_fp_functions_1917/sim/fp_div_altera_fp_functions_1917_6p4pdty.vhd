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

-- VHDL created from fp_div_altera_fp_functions_1917_6p4pdty
-- VHDL created on Thu Nov 23 21:01:53 2023


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

entity fp_div_altera_fp_functions_1917_6p4pdty is
    port (
        a : in std_logic_vector(31 downto 0);  -- float32_m23
        q : out std_logic_vector(31 downto 0);  -- float32_m23
        clk : in std_logic;
        areset : in std_logic
    );
end fp_div_altera_fp_functions_1917_6p4pdty;

architecture normal of fp_div_altera_fp_functions_1917_6p4pdty is

    attribute altera_attribute : string;
    attribute altera_attribute of normal : architecture is "-name AUTO_SHIFT_REGISTER_RECOGNITION OFF; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 10037; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 15400; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 12020; -name MESSAGE_DISABLE 12030; -name MESSAGE_DISABLE 12010; -name MESSAGE_DISABLE 12110; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 13410; -name MESSAGE_DISABLE 113007";
    
    signal GND_q : STD_LOGIC_VECTOR (0 downto 0);
    signal VCC_q : STD_LOGIC_VECTOR (0 downto 0);
    signal expX_uid6_fpSqrtTest_b : STD_LOGIC_VECTOR (7 downto 0);
    signal signX_uid7_fpSqrtTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal cstAllOWE_uid8_fpSqrtTest_q : STD_LOGIC_VECTOR (7 downto 0);
    signal cstZeroWF_uid9_fpSqrtTest_q : STD_LOGIC_VECTOR (22 downto 0);
    signal cstAllZWE_uid10_fpSqrtTest_q : STD_LOGIC_VECTOR (7 downto 0);
    signal frac_x_uid12_fpSqrtTest_b : STD_LOGIC_VECTOR (22 downto 0);
    signal excZ_x_uid13_fpSqrtTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal expXIsMax_uid14_fpSqrtTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fracXIsZero_uid15_fpSqrtTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal fracXIsZero_uid15_fpSqrtTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fracXIsNotZero_uid16_fpSqrtTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excI_x_uid17_fpSqrtTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excN_x_uid18_fpSqrtTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal invExpXIsMax_uid19_fpSqrtTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal InvExpXIsZero_uid20_fpSqrtTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excR_x_uid21_fpSqrtTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal sBias_uid22_fpSqrtTest_q : STD_LOGIC_VECTOR (7 downto 0);
    signal expEvenSig_uid24_fpSqrtTest_a : STD_LOGIC_VECTOR (8 downto 0);
    signal expEvenSig_uid24_fpSqrtTest_b : STD_LOGIC_VECTOR (8 downto 0);
    signal expEvenSig_uid24_fpSqrtTest_o : STD_LOGIC_VECTOR (8 downto 0);
    signal expEvenSig_uid24_fpSqrtTest_q : STD_LOGIC_VECTOR (8 downto 0);
    signal expREven_uid25_fpSqrtTest_b : STD_LOGIC_VECTOR (7 downto 0);
    signal sBiasM1_uid26_fpSqrtTest_q : STD_LOGIC_VECTOR (7 downto 0);
    signal expOddSig_uid27_fpSqrtTest_a : STD_LOGIC_VECTOR (8 downto 0);
    signal expOddSig_uid27_fpSqrtTest_b : STD_LOGIC_VECTOR (8 downto 0);
    signal expOddSig_uid27_fpSqrtTest_o : STD_LOGIC_VECTOR (8 downto 0);
    signal expOddSig_uid27_fpSqrtTest_q : STD_LOGIC_VECTOR (8 downto 0);
    signal expROdd_uid28_fpSqrtTest_b : STD_LOGIC_VECTOR (7 downto 0);
    signal expX0PS_uid29_fpSqrtTest_in : STD_LOGIC_VECTOR (0 downto 0);
    signal expX0PS_uid29_fpSqrtTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal expOddSelect_uid30_fpSqrtTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal expRMux_uid31_fpSqrtTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal expRMux_uid31_fpSqrtTest_q : STD_LOGIC_VECTOR (7 downto 0);
    signal addrFull_uid33_fpSqrtTest_q : STD_LOGIC_VECTOR (23 downto 0);
    signal yAddr_uid35_fpSqrtTest_b : STD_LOGIC_VECTOR (7 downto 0);
    signal yForPe_uid36_fpSqrtTest_in : STD_LOGIC_VECTOR (15 downto 0);
    signal yForPe_uid36_fpSqrtTest_b : STD_LOGIC_VECTOR (15 downto 0);
    signal expInc_uid38_fpSqrtTest_in : STD_LOGIC_VECTOR (30 downto 0);
    signal expInc_uid38_fpSqrtTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal fracRPostProcessings_uid39_fpSqrtTest_in : STD_LOGIC_VECTOR (28 downto 0);
    signal fracRPostProcessings_uid39_fpSqrtTest_b : STD_LOGIC_VECTOR (22 downto 0);
    signal expR_uid40_fpSqrtTest_a : STD_LOGIC_VECTOR (8 downto 0);
    signal expR_uid40_fpSqrtTest_b : STD_LOGIC_VECTOR (8 downto 0);
    signal expR_uid40_fpSqrtTest_o : STD_LOGIC_VECTOR (8 downto 0);
    signal expR_uid40_fpSqrtTest_q : STD_LOGIC_VECTOR (8 downto 0);
    signal invSignX_uid41_fpSqrtTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal inInfAndNotNeg_uid42_fpSqrtTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal minReg_uid43_fpSqrtTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal minInf_uid44_fpSqrtTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excRNaN_uid45_fpSqrtTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excConc_uid46_fpSqrtTest_q : STD_LOGIC_VECTOR (2 downto 0);
    signal fracSelIn_uid47_fpSqrtTest_q : STD_LOGIC_VECTOR (3 downto 0);
    signal fracSel_uid48_fpSqrtTest_q : STD_LOGIC_VECTOR (1 downto 0);
    signal expRR_uid51_fpSqrtTest_in : STD_LOGIC_VECTOR (7 downto 0);
    signal expRR_uid51_fpSqrtTest_b : STD_LOGIC_VECTOR (7 downto 0);
    signal expRPostExc_uid53_fpSqrtTest_s : STD_LOGIC_VECTOR (1 downto 0);
    signal expRPostExc_uid53_fpSqrtTest_q : STD_LOGIC_VECTOR (7 downto 0);
    signal fracNaN_uid54_fpSqrtTest_q : STD_LOGIC_VECTOR (22 downto 0);
    signal fracRPostExc_uid58_fpSqrtTest_s : STD_LOGIC_VECTOR (1 downto 0);
    signal fracRPostExc_uid58_fpSqrtTest_q : STD_LOGIC_VECTOR (22 downto 0);
    signal negZero_uid59_fpSqrtTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal negZero_uid59_fpSqrtTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal RSqrt_uid60_fpSqrtTest_q : STD_LOGIC_VECTOR (31 downto 0);
    signal yT1_uid74_invPolyEval_b : STD_LOGIC_VECTOR (11 downto 0);
    signal lowRangeB_uid76_invPolyEval_in : STD_LOGIC_VECTOR (0 downto 0);
    signal lowRangeB_uid76_invPolyEval_b : STD_LOGIC_VECTOR (0 downto 0);
    signal highBBits_uid77_invPolyEval_b : STD_LOGIC_VECTOR (11 downto 0);
    signal s1sumAHighB_uid78_invPolyEval_a : STD_LOGIC_VECTOR (21 downto 0);
    signal s1sumAHighB_uid78_invPolyEval_b : STD_LOGIC_VECTOR (21 downto 0);
    signal s1sumAHighB_uid78_invPolyEval_o : STD_LOGIC_VECTOR (21 downto 0);
    signal s1sumAHighB_uid78_invPolyEval_q : STD_LOGIC_VECTOR (21 downto 0);
    signal s1_uid79_invPolyEval_q : STD_LOGIC_VECTOR (22 downto 0);
    signal lowRangeB_uid82_invPolyEval_in : STD_LOGIC_VECTOR (1 downto 0);
    signal lowRangeB_uid82_invPolyEval_b : STD_LOGIC_VECTOR (1 downto 0);
    signal highBBits_uid83_invPolyEval_b : STD_LOGIC_VECTOR (21 downto 0);
    signal s2sumAHighB_uid84_invPolyEval_a : STD_LOGIC_VECTOR (29 downto 0);
    signal s2sumAHighB_uid84_invPolyEval_b : STD_LOGIC_VECTOR (29 downto 0);
    signal s2sumAHighB_uid84_invPolyEval_o : STD_LOGIC_VECTOR (29 downto 0);
    signal s2sumAHighB_uid84_invPolyEval_q : STD_LOGIC_VECTOR (29 downto 0);
    signal s2_uid85_invPolyEval_q : STD_LOGIC_VECTOR (31 downto 0);
    signal osig_uid88_pT1_uid75_invPolyEval_b : STD_LOGIC_VECTOR (12 downto 0);
    signal osig_uid91_pT2_uid81_invPolyEval_b : STD_LOGIC_VECTOR (23 downto 0);
    signal memoryC0_uid62_sqrtTables_lutmem_reset0 : std_logic;
    signal memoryC0_uid62_sqrtTables_lutmem_ena_NotRstA : std_logic;
    signal memoryC0_uid62_sqrtTables_lutmem_ia : STD_LOGIC_VECTOR (28 downto 0);
    signal memoryC0_uid62_sqrtTables_lutmem_aa : STD_LOGIC_VECTOR (7 downto 0);
    signal memoryC0_uid62_sqrtTables_lutmem_ab : STD_LOGIC_VECTOR (7 downto 0);
    signal memoryC0_uid62_sqrtTables_lutmem_ir : STD_LOGIC_VECTOR (28 downto 0);
    signal memoryC0_uid62_sqrtTables_lutmem_r : STD_LOGIC_VECTOR (28 downto 0);
    signal memoryC1_uid65_sqrtTables_lutmem_reset0 : std_logic;
    signal memoryC1_uid65_sqrtTables_lutmem_ena_NotRstA : std_logic;
    signal memoryC1_uid65_sqrtTables_lutmem_ia : STD_LOGIC_VECTOR (20 downto 0);
    signal memoryC1_uid65_sqrtTables_lutmem_aa : STD_LOGIC_VECTOR (7 downto 0);
    signal memoryC1_uid65_sqrtTables_lutmem_ab : STD_LOGIC_VECTOR (7 downto 0);
    signal memoryC1_uid65_sqrtTables_lutmem_ir : STD_LOGIC_VECTOR (20 downto 0);
    signal memoryC1_uid65_sqrtTables_lutmem_r : STD_LOGIC_VECTOR (20 downto 0);
    signal memoryC2_uid68_sqrtTables_lutmem_reset0 : std_logic;
    signal memoryC2_uid68_sqrtTables_lutmem_ena_NotRstA : std_logic;
    signal memoryC2_uid68_sqrtTables_lutmem_ia : STD_LOGIC_VECTOR (11 downto 0);
    signal memoryC2_uid68_sqrtTables_lutmem_aa : STD_LOGIC_VECTOR (7 downto 0);
    signal memoryC2_uid68_sqrtTables_lutmem_ab : STD_LOGIC_VECTOR (7 downto 0);
    signal memoryC2_uid68_sqrtTables_lutmem_ir : STD_LOGIC_VECTOR (11 downto 0);
    signal memoryC2_uid68_sqrtTables_lutmem_r : STD_LOGIC_VECTOR (11 downto 0);
    signal prodXY_uid87_pT1_uid75_invPolyEval_cma_reset : std_logic;
    signal prodXY_uid87_pT1_uid75_invPolyEval_cma_a0 : STD_LOGIC_VECTOR (11 downto 0);
    signal prodXY_uid87_pT1_uid75_invPolyEval_cma_c0 : STD_LOGIC_VECTOR (11 downto 0);
    signal prodXY_uid87_pT1_uid75_invPolyEval_cma_s0 : STD_LOGIC_VECTOR (23 downto 0);
    signal prodXY_uid87_pT1_uid75_invPolyEval_cma_qq0 : STD_LOGIC_VECTOR (23 downto 0);
    signal prodXY_uid87_pT1_uid75_invPolyEval_cma_q : STD_LOGIC_VECTOR (23 downto 0);
    signal prodXY_uid87_pT1_uid75_invPolyEval_cma_ena0 : std_logic;
    signal prodXY_uid87_pT1_uid75_invPolyEval_cma_ena1 : std_logic;
    signal prodXY_uid87_pT1_uid75_invPolyEval_cma_ena2 : std_logic;
    signal prodXY_uid90_pT2_uid81_invPolyEval_cma_reset : std_logic;
    signal prodXY_uid90_pT2_uid81_invPolyEval_cma_a0 : STD_LOGIC_VECTOR (15 downto 0);
    signal prodXY_uid90_pT2_uid81_invPolyEval_cma_c0 : STD_LOGIC_VECTOR (22 downto 0);
    signal prodXY_uid90_pT2_uid81_invPolyEval_cma_s0 : STD_LOGIC_VECTOR (38 downto 0);
    signal prodXY_uid90_pT2_uid81_invPolyEval_cma_qq0 : STD_LOGIC_VECTOR (38 downto 0);
    signal prodXY_uid90_pT2_uid81_invPolyEval_cma_q : STD_LOGIC_VECTOR (38 downto 0);
    signal prodXY_uid90_pT2_uid81_invPolyEval_cma_ena0 : std_logic;
    signal prodXY_uid90_pT2_uid81_invPolyEval_cma_ena1 : std_logic;
    signal prodXY_uid90_pT2_uid81_invPolyEval_cma_ena2 : std_logic;
    signal redist0_yForPe_uid36_fpSqrtTest_b_2_q : STD_LOGIC_VECTOR (15 downto 0);
    signal redist0_yForPe_uid36_fpSqrtTest_b_2_delay_0 : STD_LOGIC_VECTOR (15 downto 0);
    signal redist2_yAddr_uid35_fpSqrtTest_b_3_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist2_yAddr_uid35_fpSqrtTest_b_3_delay_0 : STD_LOGIC_VECTOR (7 downto 0);
    signal redist2_yAddr_uid35_fpSqrtTest_b_3_delay_1 : STD_LOGIC_VECTOR (7 downto 0);
    signal redist3_yAddr_uid35_fpSqrtTest_b_6_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist3_yAddr_uid35_fpSqrtTest_b_6_delay_0 : STD_LOGIC_VECTOR (7 downto 0);
    signal redist3_yAddr_uid35_fpSqrtTest_b_6_delay_1 : STD_LOGIC_VECTOR (7 downto 0);
    signal redist4_expOddSelect_uid30_fpSqrtTest_q_7_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist5_fracXIsZero_uid15_fpSqrtTest_q_7_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist6_signX_uid7_fpSqrtTest_b_7_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist1_yForPe_uid36_fpSqrtTest_b_5_mem_reset0 : std_logic;
    signal redist1_yForPe_uid36_fpSqrtTest_b_5_mem_ia : STD_LOGIC_VECTOR (15 downto 0);
    signal redist1_yForPe_uid36_fpSqrtTest_b_5_mem_aa : STD_LOGIC_VECTOR (0 downto 0);
    signal redist1_yForPe_uid36_fpSqrtTest_b_5_mem_ab : STD_LOGIC_VECTOR (0 downto 0);
    signal redist1_yForPe_uid36_fpSqrtTest_b_5_mem_iq : STD_LOGIC_VECTOR (15 downto 0);
    signal redist1_yForPe_uid36_fpSqrtTest_b_5_mem_q : STD_LOGIC_VECTOR (15 downto 0);
    signal redist1_yForPe_uid36_fpSqrtTest_b_5_rdcnt_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist1_yForPe_uid36_fpSqrtTest_b_5_rdcnt_i : UNSIGNED (0 downto 0);
    attribute preserve : boolean;
    attribute preserve of redist1_yForPe_uid36_fpSqrtTest_b_5_rdcnt_i : signal is true;
    signal redist1_yForPe_uid36_fpSqrtTest_b_5_wraddr_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist1_yForPe_uid36_fpSqrtTest_b_5_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute dont_merge : boolean;
    attribute dont_merge of redist1_yForPe_uid36_fpSqrtTest_b_5_cmpReg_q : signal is true;
    signal redist1_yForPe_uid36_fpSqrtTest_b_5_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist1_yForPe_uid36_fpSqrtTest_b_5_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist1_yForPe_uid36_fpSqrtTest_b_5_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute dont_merge of redist1_yForPe_uid36_fpSqrtTest_b_5_sticky_ena_q : signal is true;
    signal redist1_yForPe_uid36_fpSqrtTest_b_5_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist7_expX_uid6_fpSqrtTest_b_7_mem_reset0 : std_logic;
    signal redist7_expX_uid6_fpSqrtTest_b_7_mem_ia : STD_LOGIC_VECTOR (7 downto 0);
    signal redist7_expX_uid6_fpSqrtTest_b_7_mem_aa : STD_LOGIC_VECTOR (2 downto 0);
    signal redist7_expX_uid6_fpSqrtTest_b_7_mem_ab : STD_LOGIC_VECTOR (2 downto 0);
    signal redist7_expX_uid6_fpSqrtTest_b_7_mem_iq : STD_LOGIC_VECTOR (7 downto 0);
    signal redist7_expX_uid6_fpSqrtTest_b_7_mem_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist7_expX_uid6_fpSqrtTest_b_7_rdcnt_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist7_expX_uid6_fpSqrtTest_b_7_rdcnt_i : UNSIGNED (2 downto 0);
    attribute preserve of redist7_expX_uid6_fpSqrtTest_b_7_rdcnt_i : signal is true;
    signal redist7_expX_uid6_fpSqrtTest_b_7_rdcnt_eq : std_logic;
    attribute preserve of redist7_expX_uid6_fpSqrtTest_b_7_rdcnt_eq : signal is true;
    signal redist7_expX_uid6_fpSqrtTest_b_7_wraddr_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist7_expX_uid6_fpSqrtTest_b_7_mem_last_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist7_expX_uid6_fpSqrtTest_b_7_cmp_b : STD_LOGIC_VECTOR (3 downto 0);
    signal redist7_expX_uid6_fpSqrtTest_b_7_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist7_expX_uid6_fpSqrtTest_b_7_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute dont_merge of redist7_expX_uid6_fpSqrtTest_b_7_cmpReg_q : signal is true;
    signal redist7_expX_uid6_fpSqrtTest_b_7_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist7_expX_uid6_fpSqrtTest_b_7_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist7_expX_uid6_fpSqrtTest_b_7_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute dont_merge of redist7_expX_uid6_fpSqrtTest_b_7_sticky_ena_q : signal is true;
    signal redist7_expX_uid6_fpSqrtTest_b_7_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);

begin


    -- signX_uid7_fpSqrtTest(BITSELECT,6)@0
    signX_uid7_fpSqrtTest_b <= STD_LOGIC_VECTOR(a(31 downto 31));

    -- redist6_signX_uid7_fpSqrtTest_b_7(DELAY,103)
    redist6_signX_uid7_fpSqrtTest_b_7 : dspba_delay
    GENERIC MAP ( width => 1, depth => 7, reset_kind => "ASYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => signX_uid7_fpSqrtTest_b, xout => redist6_signX_uid7_fpSqrtTest_b_7_q, clk => clk, aclr => areset, ena => '1' );

    -- cstAllZWE_uid10_fpSqrtTest(CONSTANT,9)
    cstAllZWE_uid10_fpSqrtTest_q <= "00000000";

    -- redist7_expX_uid6_fpSqrtTest_b_7_notEnable(LOGICAL,119)
    redist7_expX_uid6_fpSqrtTest_b_7_notEnable_q <= STD_LOGIC_VECTOR(not (VCC_q));

    -- redist7_expX_uid6_fpSqrtTest_b_7_nor(LOGICAL,120)
    redist7_expX_uid6_fpSqrtTest_b_7_nor_q <= not (redist7_expX_uid6_fpSqrtTest_b_7_notEnable_q or redist7_expX_uid6_fpSqrtTest_b_7_sticky_ena_q);

    -- redist7_expX_uid6_fpSqrtTest_b_7_mem_last(CONSTANT,116)
    redist7_expX_uid6_fpSqrtTest_b_7_mem_last_q <= "0100";

    -- redist7_expX_uid6_fpSqrtTest_b_7_cmp(LOGICAL,117)
    redist7_expX_uid6_fpSqrtTest_b_7_cmp_b <= STD_LOGIC_VECTOR("0" & redist7_expX_uid6_fpSqrtTest_b_7_rdcnt_q);
    redist7_expX_uid6_fpSqrtTest_b_7_cmp_q <= "1" WHEN redist7_expX_uid6_fpSqrtTest_b_7_mem_last_q = redist7_expX_uid6_fpSqrtTest_b_7_cmp_b ELSE "0";

    -- redist7_expX_uid6_fpSqrtTest_b_7_cmpReg(REG,118)
    redist7_expX_uid6_fpSqrtTest_b_7_cmpReg_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            redist7_expX_uid6_fpSqrtTest_b_7_cmpReg_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            redist7_expX_uid6_fpSqrtTest_b_7_cmpReg_q <= STD_LOGIC_VECTOR(redist7_expX_uid6_fpSqrtTest_b_7_cmp_q);
        END IF;
    END PROCESS;

    -- redist7_expX_uid6_fpSqrtTest_b_7_sticky_ena(REG,121)
    redist7_expX_uid6_fpSqrtTest_b_7_sticky_ena_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            redist7_expX_uid6_fpSqrtTest_b_7_sticky_ena_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (redist7_expX_uid6_fpSqrtTest_b_7_nor_q = "1") THEN
                redist7_expX_uid6_fpSqrtTest_b_7_sticky_ena_q <= STD_LOGIC_VECTOR(redist7_expX_uid6_fpSqrtTest_b_7_cmpReg_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist7_expX_uid6_fpSqrtTest_b_7_enaAnd(LOGICAL,122)
    redist7_expX_uid6_fpSqrtTest_b_7_enaAnd_q <= redist7_expX_uid6_fpSqrtTest_b_7_sticky_ena_q and VCC_q;

    -- redist7_expX_uid6_fpSqrtTest_b_7_rdcnt(COUNTER,114)
    -- low=0, high=5, step=1, init=0
    redist7_expX_uid6_fpSqrtTest_b_7_rdcnt_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            redist7_expX_uid6_fpSqrtTest_b_7_rdcnt_i <= TO_UNSIGNED(0, 3);
            redist7_expX_uid6_fpSqrtTest_b_7_rdcnt_eq <= '0';
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (redist7_expX_uid6_fpSqrtTest_b_7_rdcnt_i = TO_UNSIGNED(4, 3)) THEN
                redist7_expX_uid6_fpSqrtTest_b_7_rdcnt_eq <= '1';
            ELSE
                redist7_expX_uid6_fpSqrtTest_b_7_rdcnt_eq <= '0';
            END IF;
            IF (redist7_expX_uid6_fpSqrtTest_b_7_rdcnt_eq = '1') THEN
                redist7_expX_uid6_fpSqrtTest_b_7_rdcnt_i <= redist7_expX_uid6_fpSqrtTest_b_7_rdcnt_i + 3;
            ELSE
                redist7_expX_uid6_fpSqrtTest_b_7_rdcnt_i <= redist7_expX_uid6_fpSqrtTest_b_7_rdcnt_i + 1;
            END IF;
        END IF;
    END PROCESS;
    redist7_expX_uid6_fpSqrtTest_b_7_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist7_expX_uid6_fpSqrtTest_b_7_rdcnt_i, 3)));

    -- expX_uid6_fpSqrtTest(BITSELECT,5)@0
    expX_uid6_fpSqrtTest_b <= a(30 downto 23);

    -- redist7_expX_uid6_fpSqrtTest_b_7_wraddr(REG,115)
    redist7_expX_uid6_fpSqrtTest_b_7_wraddr_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            redist7_expX_uid6_fpSqrtTest_b_7_wraddr_q <= "101";
        ELSIF (clk'EVENT AND clk = '1') THEN
            redist7_expX_uid6_fpSqrtTest_b_7_wraddr_q <= STD_LOGIC_VECTOR(redist7_expX_uid6_fpSqrtTest_b_7_rdcnt_q);
        END IF;
    END PROCESS;

    -- redist7_expX_uid6_fpSqrtTest_b_7_mem(DUALMEM,113)
    redist7_expX_uid6_fpSqrtTest_b_7_mem_ia <= STD_LOGIC_VECTOR(expX_uid6_fpSqrtTest_b);
    redist7_expX_uid6_fpSqrtTest_b_7_mem_aa <= redist7_expX_uid6_fpSqrtTest_b_7_wraddr_q;
    redist7_expX_uid6_fpSqrtTest_b_7_mem_ab <= redist7_expX_uid6_fpSqrtTest_b_7_rdcnt_q;
    redist7_expX_uid6_fpSqrtTest_b_7_mem_reset0 <= areset;
    redist7_expX_uid6_fpSqrtTest_b_7_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 8,
        widthad_a => 3,
        numwords_a => 6,
        width_b => 8,
        widthad_b => 3,
        numwords_b => 6,
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
        clocken1 => redist7_expX_uid6_fpSqrtTest_b_7_enaAnd_q(0),
        clocken0 => '1',
        clock0 => clk,
        aclr1 => redist7_expX_uid6_fpSqrtTest_b_7_mem_reset0,
        clock1 => clk,
        address_a => redist7_expX_uid6_fpSqrtTest_b_7_mem_aa,
        data_a => redist7_expX_uid6_fpSqrtTest_b_7_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist7_expX_uid6_fpSqrtTest_b_7_mem_ab,
        q_b => redist7_expX_uid6_fpSqrtTest_b_7_mem_iq
    );
    redist7_expX_uid6_fpSqrtTest_b_7_mem_q <= redist7_expX_uid6_fpSqrtTest_b_7_mem_iq(7 downto 0);

    -- excZ_x_uid13_fpSqrtTest(LOGICAL,12)@7
    excZ_x_uid13_fpSqrtTest_q <= "1" WHEN redist7_expX_uid6_fpSqrtTest_b_7_mem_q = cstAllZWE_uid10_fpSqrtTest_q ELSE "0";

    -- VCC(CONSTANT,1)
    VCC_q <= "1";

    -- negZero_uid59_fpSqrtTest(LOGICAL,58)@7 + 1
    negZero_uid59_fpSqrtTest_qi <= excZ_x_uid13_fpSqrtTest_q and redist6_signX_uid7_fpSqrtTest_b_7_q;
    negZero_uid59_fpSqrtTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => negZero_uid59_fpSqrtTest_qi, xout => negZero_uid59_fpSqrtTest_q, clk => clk, aclr => areset, ena => '1' );

    -- cstAllOWE_uid8_fpSqrtTest(CONSTANT,7)
    cstAllOWE_uid8_fpSqrtTest_q <= "11111111";

    -- expX0PS_uid29_fpSqrtTest(BITSELECT,28)@0
    expX0PS_uid29_fpSqrtTest_in <= STD_LOGIC_VECTOR(expX_uid6_fpSqrtTest_b(0 downto 0));
    expX0PS_uid29_fpSqrtTest_b <= STD_LOGIC_VECTOR(expX0PS_uid29_fpSqrtTest_in(0 downto 0));

    -- expOddSelect_uid30_fpSqrtTest(LOGICAL,29)@0
    expOddSelect_uid30_fpSqrtTest_q <= not (expX0PS_uid29_fpSqrtTest_b);

    -- frac_x_uid12_fpSqrtTest(BITSELECT,11)@0
    frac_x_uid12_fpSqrtTest_b <= a(22 downto 0);

    -- addrFull_uid33_fpSqrtTest(BITJOIN,32)@0
    addrFull_uid33_fpSqrtTest_q <= expOddSelect_uid30_fpSqrtTest_q & frac_x_uid12_fpSqrtTest_b;

    -- yAddr_uid35_fpSqrtTest(BITSELECT,34)@0
    yAddr_uid35_fpSqrtTest_b <= addrFull_uid33_fpSqrtTest_q(23 downto 16);

    -- memoryC2_uid68_sqrtTables_lutmem(DUALMEM,94)@0 + 2
    memoryC2_uid68_sqrtTables_lutmem_aa <= yAddr_uid35_fpSqrtTest_b;
    memoryC2_uid68_sqrtTables_lutmem_ena_NotRstA <= not (areset);
    memoryC2_uid68_sqrtTables_lutmem_reset0 <= areset;
    memoryC2_uid68_sqrtTables_lutmem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "M20K",
        operation_mode => "ROM",
        width_a => 12,
        widthad_a => 8,
        numwords_a => 256,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        outdata_reg_a => "CLOCK0",
        outdata_aclr_a => "CLEAR0",
        clock_enable_input_a => "NORMAL",
        power_up_uninitialized => "FALSE",
        init_file => "fp_div_altera_fp_functions_1917_6p4pdty_memoryC2_uid68_sqrtTables_lutmem.hex",
        init_file_layout => "PORT_A",
        intended_device_family => "Cyclone 10 GX"
    )
    PORT MAP (
        clocken0 => memoryC2_uid68_sqrtTables_lutmem_ena_NotRstA,
        aclr0 => memoryC2_uid68_sqrtTables_lutmem_reset0,
        clock0 => clk,
        address_a => memoryC2_uid68_sqrtTables_lutmem_aa,
        q_a => memoryC2_uid68_sqrtTables_lutmem_ir
    );
    memoryC2_uid68_sqrtTables_lutmem_r <= memoryC2_uid68_sqrtTables_lutmem_ir(11 downto 0);

    -- yForPe_uid36_fpSqrtTest(BITSELECT,35)@0
    yForPe_uid36_fpSqrtTest_in <= frac_x_uid12_fpSqrtTest_b(15 downto 0);
    yForPe_uid36_fpSqrtTest_b <= yForPe_uid36_fpSqrtTest_in(15 downto 0);

    -- redist0_yForPe_uid36_fpSqrtTest_b_2(DELAY,97)
    redist0_yForPe_uid36_fpSqrtTest_b_2_clkproc_0: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            redist0_yForPe_uid36_fpSqrtTest_b_2_delay_0 <= (others => '0');
            redist0_yForPe_uid36_fpSqrtTest_b_2_q <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            redist0_yForPe_uid36_fpSqrtTest_b_2_delay_0 <= STD_LOGIC_VECTOR(yForPe_uid36_fpSqrtTest_b);
            redist0_yForPe_uid36_fpSqrtTest_b_2_q <= redist0_yForPe_uid36_fpSqrtTest_b_2_delay_0;
        END IF;
    END PROCESS;

    -- yT1_uid74_invPolyEval(BITSELECT,73)@2
    yT1_uid74_invPolyEval_b <= redist0_yForPe_uid36_fpSqrtTest_b_2_q(15 downto 4);

    -- prodXY_uid87_pT1_uid75_invPolyEval_cma(CHAINMULTADD,95)@2 + 3
    prodXY_uid87_pT1_uid75_invPolyEval_cma_reset <= areset;
    prodXY_uid87_pT1_uid75_invPolyEval_cma_ena0 <= '1';
    prodXY_uid87_pT1_uid75_invPolyEval_cma_ena1 <= prodXY_uid87_pT1_uid75_invPolyEval_cma_ena0;
    prodXY_uid87_pT1_uid75_invPolyEval_cma_ena2 <= prodXY_uid87_pT1_uid75_invPolyEval_cma_ena0;

    prodXY_uid87_pT1_uid75_invPolyEval_cma_a0 <= STD_LOGIC_VECTOR(RESIZE(UNSIGNED(yT1_uid74_invPolyEval_b),12));
    prodXY_uid87_pT1_uid75_invPolyEval_cma_c0 <= STD_LOGIC_VECTOR(RESIZE(SIGNED(memoryC2_uid68_sqrtTables_lutmem_r),12));
    prodXY_uid87_pT1_uid75_invPolyEval_cma_DSP0 : cyclone10gx_mac
    GENERIC MAP (
        operation_mode => "m18x18_full",
        ay_scan_in_clock => "0",
        ay_scan_in_width => 12,
        ax_clock => "0",
        ax_width => 12,
        signed_may => "false",
        signed_max => "true",
        input_pipeline_clock => "2",
        output_clock => "1",
        result_a_width => 24
    )
    PORT MAP (
        clk(0) => clk,
        clk(1) => clk,
        clk(2) => clk,
        ena(0) => prodXY_uid87_pT1_uid75_invPolyEval_cma_ena0,
        ena(1) => prodXY_uid87_pT1_uid75_invPolyEval_cma_ena1,
        ena(2) => prodXY_uid87_pT1_uid75_invPolyEval_cma_ena2,
        aclr(0) => prodXY_uid87_pT1_uid75_invPolyEval_cma_reset,
        aclr(1) => prodXY_uid87_pT1_uid75_invPolyEval_cma_reset,
        ay => prodXY_uid87_pT1_uid75_invPolyEval_cma_a0,
        ax => prodXY_uid87_pT1_uid75_invPolyEval_cma_c0,
        resulta => prodXY_uid87_pT1_uid75_invPolyEval_cma_s0
    );
    prodXY_uid87_pT1_uid75_invPolyEval_cma_delay0 : dspba_delay
    GENERIC MAP ( width => 24, depth => 0, reset_kind => "ASYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => prodXY_uid87_pT1_uid75_invPolyEval_cma_s0, xout => prodXY_uid87_pT1_uid75_invPolyEval_cma_qq0, clk => clk, aclr => areset, ena => '1' );
    prodXY_uid87_pT1_uid75_invPolyEval_cma_q <= STD_LOGIC_VECTOR(prodXY_uid87_pT1_uid75_invPolyEval_cma_qq0(23 downto 0));

    -- osig_uid88_pT1_uid75_invPolyEval(BITSELECT,87)@5
    osig_uid88_pT1_uid75_invPolyEval_b <= STD_LOGIC_VECTOR(prodXY_uid87_pT1_uid75_invPolyEval_cma_q(23 downto 11));

    -- highBBits_uid77_invPolyEval(BITSELECT,76)@5
    highBBits_uid77_invPolyEval_b <= STD_LOGIC_VECTOR(osig_uid88_pT1_uid75_invPolyEval_b(12 downto 1));

    -- redist2_yAddr_uid35_fpSqrtTest_b_3(DELAY,99)
    redist2_yAddr_uid35_fpSqrtTest_b_3_clkproc_0: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            redist2_yAddr_uid35_fpSqrtTest_b_3_delay_0 <= (others => '0');
            redist2_yAddr_uid35_fpSqrtTest_b_3_delay_1 <= (others => '0');
            redist2_yAddr_uid35_fpSqrtTest_b_3_q <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            redist2_yAddr_uid35_fpSqrtTest_b_3_delay_0 <= STD_LOGIC_VECTOR(yAddr_uid35_fpSqrtTest_b);
            redist2_yAddr_uid35_fpSqrtTest_b_3_delay_1 <= redist2_yAddr_uid35_fpSqrtTest_b_3_delay_0;
            redist2_yAddr_uid35_fpSqrtTest_b_3_q <= redist2_yAddr_uid35_fpSqrtTest_b_3_delay_1;
        END IF;
    END PROCESS;

    -- memoryC1_uid65_sqrtTables_lutmem(DUALMEM,93)@3 + 2
    memoryC1_uid65_sqrtTables_lutmem_aa <= redist2_yAddr_uid35_fpSqrtTest_b_3_q;
    memoryC1_uid65_sqrtTables_lutmem_ena_NotRstA <= not (areset);
    memoryC1_uid65_sqrtTables_lutmem_reset0 <= areset;
    memoryC1_uid65_sqrtTables_lutmem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "M20K",
        operation_mode => "ROM",
        width_a => 21,
        widthad_a => 8,
        numwords_a => 256,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        outdata_reg_a => "CLOCK0",
        outdata_aclr_a => "CLEAR0",
        clock_enable_input_a => "NORMAL",
        power_up_uninitialized => "FALSE",
        init_file => "fp_div_altera_fp_functions_1917_6p4pdty_memoryC1_uid65_sqrtTables_lutmem.hex",
        init_file_layout => "PORT_A",
        intended_device_family => "Cyclone 10 GX"
    )
    PORT MAP (
        clocken0 => memoryC1_uid65_sqrtTables_lutmem_ena_NotRstA,
        aclr0 => memoryC1_uid65_sqrtTables_lutmem_reset0,
        clock0 => clk,
        address_a => memoryC1_uid65_sqrtTables_lutmem_aa,
        q_a => memoryC1_uid65_sqrtTables_lutmem_ir
    );
    memoryC1_uid65_sqrtTables_lutmem_r <= memoryC1_uid65_sqrtTables_lutmem_ir(20 downto 0);

    -- s1sumAHighB_uid78_invPolyEval(ADD,77)@5
    s1sumAHighB_uid78_invPolyEval_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((21 downto 21 => memoryC1_uid65_sqrtTables_lutmem_r(20)) & memoryC1_uid65_sqrtTables_lutmem_r));
    s1sumAHighB_uid78_invPolyEval_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((21 downto 12 => highBBits_uid77_invPolyEval_b(11)) & highBBits_uid77_invPolyEval_b));
    s1sumAHighB_uid78_invPolyEval_o <= STD_LOGIC_VECTOR(SIGNED(s1sumAHighB_uid78_invPolyEval_a) + SIGNED(s1sumAHighB_uid78_invPolyEval_b));
    s1sumAHighB_uid78_invPolyEval_q <= s1sumAHighB_uid78_invPolyEval_o(21 downto 0);

    -- lowRangeB_uid76_invPolyEval(BITSELECT,75)@5
    lowRangeB_uid76_invPolyEval_in <= osig_uid88_pT1_uid75_invPolyEval_b(0 downto 0);
    lowRangeB_uid76_invPolyEval_b <= lowRangeB_uid76_invPolyEval_in(0 downto 0);

    -- s1_uid79_invPolyEval(BITJOIN,78)@5
    s1_uid79_invPolyEval_q <= s1sumAHighB_uid78_invPolyEval_q & lowRangeB_uid76_invPolyEval_b;

    -- redist1_yForPe_uid36_fpSqrtTest_b_5_notEnable(LOGICAL,109)
    redist1_yForPe_uid36_fpSqrtTest_b_5_notEnable_q <= STD_LOGIC_VECTOR(not (VCC_q));

    -- redist1_yForPe_uid36_fpSqrtTest_b_5_nor(LOGICAL,110)
    redist1_yForPe_uid36_fpSqrtTest_b_5_nor_q <= not (redist1_yForPe_uid36_fpSqrtTest_b_5_notEnable_q or redist1_yForPe_uid36_fpSqrtTest_b_5_sticky_ena_q);

    -- redist1_yForPe_uid36_fpSqrtTest_b_5_cmpReg(REG,108)
    redist1_yForPe_uid36_fpSqrtTest_b_5_cmpReg_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            redist1_yForPe_uid36_fpSqrtTest_b_5_cmpReg_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            redist1_yForPe_uid36_fpSqrtTest_b_5_cmpReg_q <= STD_LOGIC_VECTOR(VCC_q);
        END IF;
    END PROCESS;

    -- redist1_yForPe_uid36_fpSqrtTest_b_5_sticky_ena(REG,111)
    redist1_yForPe_uid36_fpSqrtTest_b_5_sticky_ena_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            redist1_yForPe_uid36_fpSqrtTest_b_5_sticky_ena_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (redist1_yForPe_uid36_fpSqrtTest_b_5_nor_q = "1") THEN
                redist1_yForPe_uid36_fpSqrtTest_b_5_sticky_ena_q <= STD_LOGIC_VECTOR(redist1_yForPe_uid36_fpSqrtTest_b_5_cmpReg_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist1_yForPe_uid36_fpSqrtTest_b_5_enaAnd(LOGICAL,112)
    redist1_yForPe_uid36_fpSqrtTest_b_5_enaAnd_q <= redist1_yForPe_uid36_fpSqrtTest_b_5_sticky_ena_q and VCC_q;

    -- redist1_yForPe_uid36_fpSqrtTest_b_5_rdcnt(COUNTER,106)
    -- low=0, high=1, step=1, init=0
    redist1_yForPe_uid36_fpSqrtTest_b_5_rdcnt_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            redist1_yForPe_uid36_fpSqrtTest_b_5_rdcnt_i <= TO_UNSIGNED(0, 1);
        ELSIF (clk'EVENT AND clk = '1') THEN
            redist1_yForPe_uid36_fpSqrtTest_b_5_rdcnt_i <= redist1_yForPe_uid36_fpSqrtTest_b_5_rdcnt_i + 1;
        END IF;
    END PROCESS;
    redist1_yForPe_uid36_fpSqrtTest_b_5_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist1_yForPe_uid36_fpSqrtTest_b_5_rdcnt_i, 1)));

    -- redist1_yForPe_uid36_fpSqrtTest_b_5_wraddr(REG,107)
    redist1_yForPe_uid36_fpSqrtTest_b_5_wraddr_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            redist1_yForPe_uid36_fpSqrtTest_b_5_wraddr_q <= "1";
        ELSIF (clk'EVENT AND clk = '1') THEN
            redist1_yForPe_uid36_fpSqrtTest_b_5_wraddr_q <= STD_LOGIC_VECTOR(redist1_yForPe_uid36_fpSqrtTest_b_5_rdcnt_q);
        END IF;
    END PROCESS;

    -- redist1_yForPe_uid36_fpSqrtTest_b_5_mem(DUALMEM,105)
    redist1_yForPe_uid36_fpSqrtTest_b_5_mem_ia <= STD_LOGIC_VECTOR(redist0_yForPe_uid36_fpSqrtTest_b_2_q);
    redist1_yForPe_uid36_fpSqrtTest_b_5_mem_aa <= redist1_yForPe_uid36_fpSqrtTest_b_5_wraddr_q;
    redist1_yForPe_uid36_fpSqrtTest_b_5_mem_ab <= redist1_yForPe_uid36_fpSqrtTest_b_5_rdcnt_q;
    redist1_yForPe_uid36_fpSqrtTest_b_5_mem_reset0 <= areset;
    redist1_yForPe_uid36_fpSqrtTest_b_5_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 16,
        widthad_a => 1,
        numwords_a => 2,
        width_b => 16,
        widthad_b => 1,
        numwords_b => 2,
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
        clocken1 => redist1_yForPe_uid36_fpSqrtTest_b_5_enaAnd_q(0),
        clocken0 => '1',
        clock0 => clk,
        aclr1 => redist1_yForPe_uid36_fpSqrtTest_b_5_mem_reset0,
        clock1 => clk,
        address_a => redist1_yForPe_uid36_fpSqrtTest_b_5_mem_aa,
        data_a => redist1_yForPe_uid36_fpSqrtTest_b_5_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist1_yForPe_uid36_fpSqrtTest_b_5_mem_ab,
        q_b => redist1_yForPe_uid36_fpSqrtTest_b_5_mem_iq
    );
    redist1_yForPe_uid36_fpSqrtTest_b_5_mem_q <= redist1_yForPe_uid36_fpSqrtTest_b_5_mem_iq(15 downto 0);

    -- GND(CONSTANT,0)
    GND_q <= "0";

    -- prodXY_uid90_pT2_uid81_invPolyEval_cma(CHAINMULTADD,96)@5 + 3
    prodXY_uid90_pT2_uid81_invPolyEval_cma_reset <= areset;
    prodXY_uid90_pT2_uid81_invPolyEval_cma_ena0 <= '1';
    prodXY_uid90_pT2_uid81_invPolyEval_cma_ena1 <= prodXY_uid90_pT2_uid81_invPolyEval_cma_ena0;
    prodXY_uid90_pT2_uid81_invPolyEval_cma_ena2 <= prodXY_uid90_pT2_uid81_invPolyEval_cma_ena0;

    prodXY_uid90_pT2_uid81_invPolyEval_cma_a0 <= STD_LOGIC_VECTOR(RESIZE(UNSIGNED(redist1_yForPe_uid36_fpSqrtTest_b_5_mem_q),16));
    prodXY_uid90_pT2_uid81_invPolyEval_cma_c0 <= STD_LOGIC_VECTOR(RESIZE(SIGNED(s1_uid79_invPolyEval_q),23));
    prodXY_uid90_pT2_uid81_invPolyEval_cma_DSP0 : cyclone10gx_mac
    GENERIC MAP (
        operation_mode => "m27x27",
        use_chainadder => "false",
        ay_scan_in_clock => "0",
        ay_scan_in_width => 16,
        ax_clock => "0",
        ax_width => 23,
        signed_may => "false",
        signed_max => "true",
        input_pipeline_clock => "2",
        output_clock => "1",
        result_a_width => 39
    )
    PORT MAP (
        clk(0) => clk,
        clk(1) => clk,
        clk(2) => clk,
        ena(0) => prodXY_uid90_pT2_uid81_invPolyEval_cma_ena0,
        ena(1) => prodXY_uid90_pT2_uid81_invPolyEval_cma_ena1,
        ena(2) => prodXY_uid90_pT2_uid81_invPolyEval_cma_ena2,
        aclr(0) => prodXY_uid90_pT2_uid81_invPolyEval_cma_reset,
        aclr(1) => prodXY_uid90_pT2_uid81_invPolyEval_cma_reset,
        ay => prodXY_uid90_pT2_uid81_invPolyEval_cma_a0,
        ax => prodXY_uid90_pT2_uid81_invPolyEval_cma_c0,
        resulta => prodXY_uid90_pT2_uid81_invPolyEval_cma_s0
    );
    prodXY_uid90_pT2_uid81_invPolyEval_cma_delay0 : dspba_delay
    GENERIC MAP ( width => 39, depth => 0, reset_kind => "ASYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => prodXY_uid90_pT2_uid81_invPolyEval_cma_s0, xout => prodXY_uid90_pT2_uid81_invPolyEval_cma_qq0, clk => clk, aclr => areset, ena => '1' );
    prodXY_uid90_pT2_uid81_invPolyEval_cma_q <= STD_LOGIC_VECTOR(prodXY_uid90_pT2_uid81_invPolyEval_cma_qq0(38 downto 0));

    -- osig_uid91_pT2_uid81_invPolyEval(BITSELECT,90)@8
    osig_uid91_pT2_uid81_invPolyEval_b <= STD_LOGIC_VECTOR(prodXY_uid90_pT2_uid81_invPolyEval_cma_q(38 downto 15));

    -- highBBits_uid83_invPolyEval(BITSELECT,82)@8
    highBBits_uid83_invPolyEval_b <= STD_LOGIC_VECTOR(osig_uid91_pT2_uid81_invPolyEval_b(23 downto 2));

    -- redist3_yAddr_uid35_fpSqrtTest_b_6(DELAY,100)
    redist3_yAddr_uid35_fpSqrtTest_b_6_clkproc_0: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            redist3_yAddr_uid35_fpSqrtTest_b_6_delay_0 <= (others => '0');
            redist3_yAddr_uid35_fpSqrtTest_b_6_delay_1 <= (others => '0');
            redist3_yAddr_uid35_fpSqrtTest_b_6_q <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            redist3_yAddr_uid35_fpSqrtTest_b_6_delay_0 <= STD_LOGIC_VECTOR(redist2_yAddr_uid35_fpSqrtTest_b_3_q);
            redist3_yAddr_uid35_fpSqrtTest_b_6_delay_1 <= redist3_yAddr_uid35_fpSqrtTest_b_6_delay_0;
            redist3_yAddr_uid35_fpSqrtTest_b_6_q <= redist3_yAddr_uid35_fpSqrtTest_b_6_delay_1;
        END IF;
    END PROCESS;

    -- memoryC0_uid62_sqrtTables_lutmem(DUALMEM,92)@6 + 2
    memoryC0_uid62_sqrtTables_lutmem_aa <= redist3_yAddr_uid35_fpSqrtTest_b_6_q;
    memoryC0_uid62_sqrtTables_lutmem_ena_NotRstA <= not (areset);
    memoryC0_uid62_sqrtTables_lutmem_reset0 <= areset;
    memoryC0_uid62_sqrtTables_lutmem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "M20K",
        operation_mode => "ROM",
        width_a => 29,
        widthad_a => 8,
        numwords_a => 256,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        outdata_reg_a => "CLOCK0",
        outdata_aclr_a => "CLEAR0",
        clock_enable_input_a => "NORMAL",
        power_up_uninitialized => "FALSE",
        init_file => "fp_div_altera_fp_functions_1917_6p4pdty_memoryC0_uid62_sqrtTables_lutmem.hex",
        init_file_layout => "PORT_A",
        intended_device_family => "Cyclone 10 GX"
    )
    PORT MAP (
        clocken0 => memoryC0_uid62_sqrtTables_lutmem_ena_NotRstA,
        aclr0 => memoryC0_uid62_sqrtTables_lutmem_reset0,
        clock0 => clk,
        address_a => memoryC0_uid62_sqrtTables_lutmem_aa,
        q_a => memoryC0_uid62_sqrtTables_lutmem_ir
    );
    memoryC0_uid62_sqrtTables_lutmem_r <= memoryC0_uid62_sqrtTables_lutmem_ir(28 downto 0);

    -- s2sumAHighB_uid84_invPolyEval(ADD,83)@8
    s2sumAHighB_uid84_invPolyEval_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((29 downto 29 => memoryC0_uid62_sqrtTables_lutmem_r(28)) & memoryC0_uid62_sqrtTables_lutmem_r));
    s2sumAHighB_uid84_invPolyEval_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((29 downto 22 => highBBits_uid83_invPolyEval_b(21)) & highBBits_uid83_invPolyEval_b));
    s2sumAHighB_uid84_invPolyEval_o <= STD_LOGIC_VECTOR(SIGNED(s2sumAHighB_uid84_invPolyEval_a) + SIGNED(s2sumAHighB_uid84_invPolyEval_b));
    s2sumAHighB_uid84_invPolyEval_q <= s2sumAHighB_uid84_invPolyEval_o(29 downto 0);

    -- lowRangeB_uid82_invPolyEval(BITSELECT,81)@8
    lowRangeB_uid82_invPolyEval_in <= osig_uid91_pT2_uid81_invPolyEval_b(1 downto 0);
    lowRangeB_uid82_invPolyEval_b <= lowRangeB_uid82_invPolyEval_in(1 downto 0);

    -- s2_uid85_invPolyEval(BITJOIN,84)@8
    s2_uid85_invPolyEval_q <= s2sumAHighB_uid84_invPolyEval_q & lowRangeB_uid82_invPolyEval_b;

    -- expInc_uid38_fpSqrtTest(BITSELECT,37)@8
    expInc_uid38_fpSqrtTest_in <= STD_LOGIC_VECTOR(s2_uid85_invPolyEval_q(30 downto 0));
    expInc_uid38_fpSqrtTest_b <= STD_LOGIC_VECTOR(expInc_uid38_fpSqrtTest_in(30 downto 30));

    -- sBiasM1_uid26_fpSqrtTest(CONSTANT,25)
    sBiasM1_uid26_fpSqrtTest_q <= "01111110";

    -- expOddSig_uid27_fpSqrtTest(ADD,26)@7
    expOddSig_uid27_fpSqrtTest_a <= STD_LOGIC_VECTOR("0" & redist7_expX_uid6_fpSqrtTest_b_7_mem_q);
    expOddSig_uid27_fpSqrtTest_b <= STD_LOGIC_VECTOR("0" & sBiasM1_uid26_fpSqrtTest_q);
    expOddSig_uid27_fpSqrtTest_o <= STD_LOGIC_VECTOR(UNSIGNED(expOddSig_uid27_fpSqrtTest_a) + UNSIGNED(expOddSig_uid27_fpSqrtTest_b));
    expOddSig_uid27_fpSqrtTest_q <= expOddSig_uid27_fpSqrtTest_o(8 downto 0);

    -- expROdd_uid28_fpSqrtTest(BITSELECT,27)@7
    expROdd_uid28_fpSqrtTest_b <= expOddSig_uid27_fpSqrtTest_q(8 downto 1);

    -- sBias_uid22_fpSqrtTest(CONSTANT,21)
    sBias_uid22_fpSqrtTest_q <= "01111111";

    -- expEvenSig_uid24_fpSqrtTest(ADD,23)@7
    expEvenSig_uid24_fpSqrtTest_a <= STD_LOGIC_VECTOR("0" & redist7_expX_uid6_fpSqrtTest_b_7_mem_q);
    expEvenSig_uid24_fpSqrtTest_b <= STD_LOGIC_VECTOR("0" & sBias_uid22_fpSqrtTest_q);
    expEvenSig_uid24_fpSqrtTest_o <= STD_LOGIC_VECTOR(UNSIGNED(expEvenSig_uid24_fpSqrtTest_a) + UNSIGNED(expEvenSig_uid24_fpSqrtTest_b));
    expEvenSig_uid24_fpSqrtTest_q <= expEvenSig_uid24_fpSqrtTest_o(8 downto 0);

    -- expREven_uid25_fpSqrtTest(BITSELECT,24)@7
    expREven_uid25_fpSqrtTest_b <= expEvenSig_uid24_fpSqrtTest_q(8 downto 1);

    -- redist4_expOddSelect_uid30_fpSqrtTest_q_7(DELAY,101)
    redist4_expOddSelect_uid30_fpSqrtTest_q_7 : dspba_delay
    GENERIC MAP ( width => 1, depth => 7, reset_kind => "ASYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => expOddSelect_uid30_fpSqrtTest_q, xout => redist4_expOddSelect_uid30_fpSqrtTest_q_7_q, clk => clk, aclr => areset, ena => '1' );

    -- expRMux_uid31_fpSqrtTest(MUX,30)@7 + 1
    expRMux_uid31_fpSqrtTest_s <= redist4_expOddSelect_uid30_fpSqrtTest_q_7_q;
    expRMux_uid31_fpSqrtTest_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            expRMux_uid31_fpSqrtTest_q <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            CASE (expRMux_uid31_fpSqrtTest_s) IS
                WHEN "0" => expRMux_uid31_fpSqrtTest_q <= expREven_uid25_fpSqrtTest_b;
                WHEN "1" => expRMux_uid31_fpSqrtTest_q <= expROdd_uid28_fpSqrtTest_b;
                WHEN OTHERS => expRMux_uid31_fpSqrtTest_q <= (others => '0');
            END CASE;
        END IF;
    END PROCESS;

    -- expR_uid40_fpSqrtTest(ADD,39)@8
    expR_uid40_fpSqrtTest_a <= STD_LOGIC_VECTOR("0" & expRMux_uid31_fpSqrtTest_q);
    expR_uid40_fpSqrtTest_b <= STD_LOGIC_VECTOR("00000000" & expInc_uid38_fpSqrtTest_b);
    expR_uid40_fpSqrtTest_o <= STD_LOGIC_VECTOR(UNSIGNED(expR_uid40_fpSqrtTest_a) + UNSIGNED(expR_uid40_fpSqrtTest_b));
    expR_uid40_fpSqrtTest_q <= expR_uid40_fpSqrtTest_o(8 downto 0);

    -- expRR_uid51_fpSqrtTest(BITSELECT,50)@8
    expRR_uid51_fpSqrtTest_in <= expR_uid40_fpSqrtTest_q(7 downto 0);
    expRR_uid51_fpSqrtTest_b <= expRR_uid51_fpSqrtTest_in(7 downto 0);

    -- expXIsMax_uid14_fpSqrtTest(LOGICAL,13)@7
    expXIsMax_uid14_fpSqrtTest_q <= "1" WHEN redist7_expX_uid6_fpSqrtTest_b_7_mem_q = cstAllOWE_uid8_fpSqrtTest_q ELSE "0";

    -- invExpXIsMax_uid19_fpSqrtTest(LOGICAL,18)@7
    invExpXIsMax_uid19_fpSqrtTest_q <= not (expXIsMax_uid14_fpSqrtTest_q);

    -- InvExpXIsZero_uid20_fpSqrtTest(LOGICAL,19)@7
    InvExpXIsZero_uid20_fpSqrtTest_q <= not (excZ_x_uid13_fpSqrtTest_q);

    -- excR_x_uid21_fpSqrtTest(LOGICAL,20)@7
    excR_x_uid21_fpSqrtTest_q <= InvExpXIsZero_uid20_fpSqrtTest_q and invExpXIsMax_uid19_fpSqrtTest_q;

    -- minReg_uid43_fpSqrtTest(LOGICAL,42)@7
    minReg_uid43_fpSqrtTest_q <= excR_x_uid21_fpSqrtTest_q and redist6_signX_uid7_fpSqrtTest_b_7_q;

    -- cstZeroWF_uid9_fpSqrtTest(CONSTANT,8)
    cstZeroWF_uid9_fpSqrtTest_q <= "00000000000000000000000";

    -- fracXIsZero_uid15_fpSqrtTest(LOGICAL,14)@0 + 1
    fracXIsZero_uid15_fpSqrtTest_qi <= "1" WHEN cstZeroWF_uid9_fpSqrtTest_q = frac_x_uid12_fpSqrtTest_b ELSE "0";
    fracXIsZero_uid15_fpSqrtTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => fracXIsZero_uid15_fpSqrtTest_qi, xout => fracXIsZero_uid15_fpSqrtTest_q, clk => clk, aclr => areset, ena => '1' );

    -- redist5_fracXIsZero_uid15_fpSqrtTest_q_7(DELAY,102)
    redist5_fracXIsZero_uid15_fpSqrtTest_q_7 : dspba_delay
    GENERIC MAP ( width => 1, depth => 6, reset_kind => "ASYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => fracXIsZero_uid15_fpSqrtTest_q, xout => redist5_fracXIsZero_uid15_fpSqrtTest_q_7_q, clk => clk, aclr => areset, ena => '1' );

    -- excI_x_uid17_fpSqrtTest(LOGICAL,16)@7
    excI_x_uid17_fpSqrtTest_q <= expXIsMax_uid14_fpSqrtTest_q and redist5_fracXIsZero_uid15_fpSqrtTest_q_7_q;

    -- minInf_uid44_fpSqrtTest(LOGICAL,43)@7
    minInf_uid44_fpSqrtTest_q <= excI_x_uid17_fpSqrtTest_q and redist6_signX_uid7_fpSqrtTest_b_7_q;

    -- fracXIsNotZero_uid16_fpSqrtTest(LOGICAL,15)@7
    fracXIsNotZero_uid16_fpSqrtTest_q <= not (redist5_fracXIsZero_uid15_fpSqrtTest_q_7_q);

    -- excN_x_uid18_fpSqrtTest(LOGICAL,17)@7
    excN_x_uid18_fpSqrtTest_q <= expXIsMax_uid14_fpSqrtTest_q and fracXIsNotZero_uid16_fpSqrtTest_q;

    -- excRNaN_uid45_fpSqrtTest(LOGICAL,44)@7
    excRNaN_uid45_fpSqrtTest_q <= excN_x_uid18_fpSqrtTest_q or minInf_uid44_fpSqrtTest_q or minReg_uid43_fpSqrtTest_q;

    -- invSignX_uid41_fpSqrtTest(LOGICAL,40)@7
    invSignX_uid41_fpSqrtTest_q <= not (redist6_signX_uid7_fpSqrtTest_b_7_q);

    -- inInfAndNotNeg_uid42_fpSqrtTest(LOGICAL,41)@7
    inInfAndNotNeg_uid42_fpSqrtTest_q <= excI_x_uid17_fpSqrtTest_q and invSignX_uid41_fpSqrtTest_q;

    -- excConc_uid46_fpSqrtTest(BITJOIN,45)@7
    excConc_uid46_fpSqrtTest_q <= excRNaN_uid45_fpSqrtTest_q & inInfAndNotNeg_uid42_fpSqrtTest_q & excZ_x_uid13_fpSqrtTest_q;

    -- fracSelIn_uid47_fpSqrtTest(BITJOIN,46)@7
    fracSelIn_uid47_fpSqrtTest_q <= redist6_signX_uid7_fpSqrtTest_b_7_q & excConc_uid46_fpSqrtTest_q;

    -- fracSel_uid48_fpSqrtTest(LOOKUP,47)@7 + 1
    fracSel_uid48_fpSqrtTest_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            fracSel_uid48_fpSqrtTest_q <= "01";
        ELSIF (clk'EVENT AND clk = '1') THEN
            CASE (fracSelIn_uid47_fpSqrtTest_q) IS
                WHEN "0000" => fracSel_uid48_fpSqrtTest_q <= "01";
                WHEN "0001" => fracSel_uid48_fpSqrtTest_q <= "00";
                WHEN "0010" => fracSel_uid48_fpSqrtTest_q <= "10";
                WHEN "0011" => fracSel_uid48_fpSqrtTest_q <= "00";
                WHEN "0100" => fracSel_uid48_fpSqrtTest_q <= "11";
                WHEN "0101" => fracSel_uid48_fpSqrtTest_q <= "00";
                WHEN "0110" => fracSel_uid48_fpSqrtTest_q <= "10";
                WHEN "0111" => fracSel_uid48_fpSqrtTest_q <= "00";
                WHEN "1000" => fracSel_uid48_fpSqrtTest_q <= "11";
                WHEN "1001" => fracSel_uid48_fpSqrtTest_q <= "00";
                WHEN "1010" => fracSel_uid48_fpSqrtTest_q <= "11";
                WHEN "1011" => fracSel_uid48_fpSqrtTest_q <= "11";
                WHEN "1100" => fracSel_uid48_fpSqrtTest_q <= "11";
                WHEN "1101" => fracSel_uid48_fpSqrtTest_q <= "11";
                WHEN "1110" => fracSel_uid48_fpSqrtTest_q <= "11";
                WHEN "1111" => fracSel_uid48_fpSqrtTest_q <= "11";
                WHEN OTHERS => -- unreachable
                               fracSel_uid48_fpSqrtTest_q <= (others => '-');
            END CASE;
        END IF;
    END PROCESS;

    -- expRPostExc_uid53_fpSqrtTest(MUX,52)@8
    expRPostExc_uid53_fpSqrtTest_s <= fracSel_uid48_fpSqrtTest_q;
    expRPostExc_uid53_fpSqrtTest_combproc: PROCESS (expRPostExc_uid53_fpSqrtTest_s, cstAllZWE_uid10_fpSqrtTest_q, expRR_uid51_fpSqrtTest_b, cstAllOWE_uid8_fpSqrtTest_q)
    BEGIN
        CASE (expRPostExc_uid53_fpSqrtTest_s) IS
            WHEN "00" => expRPostExc_uid53_fpSqrtTest_q <= cstAllZWE_uid10_fpSqrtTest_q;
            WHEN "01" => expRPostExc_uid53_fpSqrtTest_q <= expRR_uid51_fpSqrtTest_b;
            WHEN "10" => expRPostExc_uid53_fpSqrtTest_q <= cstAllOWE_uid8_fpSqrtTest_q;
            WHEN "11" => expRPostExc_uid53_fpSqrtTest_q <= cstAllOWE_uid8_fpSqrtTest_q;
            WHEN OTHERS => expRPostExc_uid53_fpSqrtTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- fracNaN_uid54_fpSqrtTest(CONSTANT,53)
    fracNaN_uid54_fpSqrtTest_q <= "00000000000000000000001";

    -- fracRPostProcessings_uid39_fpSqrtTest(BITSELECT,38)@8
    fracRPostProcessings_uid39_fpSqrtTest_in <= s2_uid85_invPolyEval_q(28 downto 0);
    fracRPostProcessings_uid39_fpSqrtTest_b <= fracRPostProcessings_uid39_fpSqrtTest_in(28 downto 6);

    -- fracRPostExc_uid58_fpSqrtTest(MUX,57)@8
    fracRPostExc_uid58_fpSqrtTest_s <= fracSel_uid48_fpSqrtTest_q;
    fracRPostExc_uid58_fpSqrtTest_combproc: PROCESS (fracRPostExc_uid58_fpSqrtTest_s, cstZeroWF_uid9_fpSqrtTest_q, fracRPostProcessings_uid39_fpSqrtTest_b, fracNaN_uid54_fpSqrtTest_q)
    BEGIN
        CASE (fracRPostExc_uid58_fpSqrtTest_s) IS
            WHEN "00" => fracRPostExc_uid58_fpSqrtTest_q <= cstZeroWF_uid9_fpSqrtTest_q;
            WHEN "01" => fracRPostExc_uid58_fpSqrtTest_q <= fracRPostProcessings_uid39_fpSqrtTest_b;
            WHEN "10" => fracRPostExc_uid58_fpSqrtTest_q <= cstZeroWF_uid9_fpSqrtTest_q;
            WHEN "11" => fracRPostExc_uid58_fpSqrtTest_q <= fracNaN_uid54_fpSqrtTest_q;
            WHEN OTHERS => fracRPostExc_uid58_fpSqrtTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- RSqrt_uid60_fpSqrtTest(BITJOIN,59)@8
    RSqrt_uid60_fpSqrtTest_q <= negZero_uid59_fpSqrtTest_q & expRPostExc_uid53_fpSqrtTest_q & fracRPostExc_uid58_fpSqrtTest_q;

    -- xOut(GPOUT,4)@8
    q <= RSqrt_uid60_fpSqrtTest_q;

END normal;
