----------------------------------------------------------------------------------
-- Company: 		 Tecnológico de Monterrey Campus Querétaro
-- ID:				 A01706095
-- Engineer: 		 Naomi Estefania Nieto Vega
--
-- Create Date:    02/25/2021 
-- Design Name: 	 FSM Control Unit 
-- Module Name:    Top_A01706095 - Behavioral 
-- Project Name: 	 Evidencia2_A01706095
--
-- Target Devices: MAX LITE-10 FPGA Board
-- Tool versions:  Quartus Prime Lite 18.1
-- Description:  	 Desing and Implementation of a Control Unit
--						 in Quartus Prime. 
--
-- Dependencies: 	 None
--
-- Revision: 		V1.0
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
Library IEEE;
Use IEEE.std_logic_1164.all;
Use IEEE.numeric_std.all;
Use IEEE.std_logic_unsigned.all;

Entity Top_A01706095 is

	Port ( Clk_A01706095			: in STD_LOGIC;
			 Rst_A01706095 		: in STD_LOGIC;
			 DataId_A01706095		: in STD_LOGIC; -- Input data identifier
			 Output_A01706095		: out STD_LOGIC_VECTOR (5 downto 0); -- Vector that stores the variables
			 offLEDs_A01706095	: out STD_LOGIC_VECTOR (3 downto 0));
End Top_A01706095;

Architecture rtl of Top_A01706095 is
	-- Component declaration
	
Component FreqDiv_A01706095
	Port (
		Clk_A01706095   : in  STD_LOGIC;
		Rst_A01706095   : in  STD_LOGIC;
		ClkEn_A01706095 : out  STD_LOGIC);
	End Component;
	
	Component FSMControlUnit_A01706095
	Port (
		Clk_A01706095    : in  STD_LOGIC;
		Rst_A01706095    : in  STD_LOGIC;
		ClkEn_A01706095  : in  STD_LOGIC;
		DataId_A01706095 : in  STD_LOGIC;
		Output_A01706095 : out STD_LOGIC_VECTOR (5 downto 0));
	End Component;
	
	-- Embedded signal declaration
	Signal ClkEn_emb_A01706095	:	STD_LOGIC;
	
Begin 
	-- Intantiate Components
	   IC1 : FreqDiv_A01706095
		Port map (
			Clk_A01706095 	 => Clk_A01706095,
			Rst_A01706095 	 => Rst_A01706095,
			ClkEn_A01706095 => ClkEn_emb_A01706095);
			
		IC2 : FSMControlUnit_A01706095
		Port map (
			Clk_A01706095    => Clk_A01706095,
			Rst_A01706095    => Rst_A01706095,
			ClkEn_A01706095  => ClkEn_emb_A01706095,
			DataId_A01706095 => DataId_A01706095,
			Output_A01706095 => Output_A01706095);  
			
	-- Turn off unused LEDs
	offLEDs_A01706095 <= (others => '0');
End rtl;