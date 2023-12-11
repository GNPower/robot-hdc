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

-- VHDL created from fp_accum_altera_fp_functions_1917_oskqeyy
-- VHDL created on Sun Dec 10 21:43:32 2023


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

entity fp_accum_altera_fp_functions_1917_oskqeyy is
    port (
        acc : in std_logic_vector(0 downto 0);  -- ufix1
        a : in std_logic_vector(31 downto 0);  -- float32_m23
        q : out std_logic_vector(31 downto 0);  -- float32_m23
        clk : in std_logic;
        areset : in std_logic
    );
end fp_accum_altera_fp_functions_1917_oskqeyy;

architecture normal of fp_accum_altera_fp_functions_1917_oskqeyy is

    attribute altera_attribute : string;
    attribute altera_attribute of normal : architecture is "-name AUTO_SHIFT_REGISTER_RECOGNITION OFF; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 10037; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 15400; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 12020; -name MESSAGE_DISABLE 12030; -name MESSAGE_DISABLE 12010; -name MESSAGE_DISABLE 12110; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 13410; -name MESSAGE_DISABLE 113007";
    
    signal VCC_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fpAccTest_impl_reset0 : std_logic;
    signal fpAccTest_impl_ena0 : std_logic;
    signal fpAccTest_impl_acc0 : STD_LOGIC_VECTOR (0 downto 0);
    signal fpAccTest_impl_ay0 : STD_LOGIC_VECTOR (31 downto 0);
    signal fpAccTest_impl_az0 : STD_LOGIC_VECTOR (31 downto 0);
    signal fpAccTest_impl_q0 : STD_LOGIC_VECTOR (31 downto 0);
    signal fpAccTest_yin_q_const_q : STD_LOGIC_VECTOR (31 downto 0);

begin


    -- fpAccTest_yin_q_const(CONSTANT,11)
    fpAccTest_yin_q_const_q <= "00111111100000000000000000000000";

    -- VCC(CONSTANT,1)
    VCC_q <= "1";

    -- fpAccTest_impl(FPCOLUMN,5)@0
    -- out q0@4
    fpAccTest_impl_acc0 <= acc;
    fpAccTest_impl_ay0 <= fpAccTest_yin_q_const_q;
    fpAccTest_impl_az0 <= a;
    fpAccTest_impl_reset0 <= areset;
    fpAccTest_impl_ena0 <= '1';
    fpAccTest_impl_DSP0 : cyclone10gx_fp_mac
    GENERIC MAP (
        operation_mode => "sp_mult_acc",
        accumulate_clock => "0",
        ay_clock => "0",
        az_clock => "0",
        accum_pipeline_clock => "0",
        mult_pipeline_clock => "0",
        accum_adder_clock => "0",
        adder_input_clock => "0",
        output_clock => "0"
    )
    PORT MAP (
        clk(0) => clk,
        clk(1) => '0',
        clk(2) => '0',
        ena(0) => fpAccTest_impl_ena0,
        ena(1) => '0',
        ena(2) => '0',
        aclr(0) => fpAccTest_impl_reset0,
        aclr(1) => fpAccTest_impl_reset0,
        accumulate => fpAccTest_impl_acc0(0),
        ay => fpAccTest_impl_ay0,
        az => fpAccTest_impl_az0,
        resulta => fpAccTest_impl_q0
    );

    -- xOut(GPOUT,4)@4
    q <= fpAccTest_impl_q0;

END normal;
