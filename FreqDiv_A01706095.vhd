----------------------------------------------------------------------------------
-- Company: 		 Tecnológico de Monterrey Campus Querétaro
-- ID:				 A01706095
-- Engineer: 		 Naomi Estefania Nieto Vega
--
-- Create Date:    02/25/2021 
-- Design Name: 	 FSM Control Unit 
-- Module Name:    FreqDiv_A1706095 - Behavioral 
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

Entity FreqDiv_A01706095 is
	Port (
		Clk_A01706095   	: in  STD_LOGIC;
		Rst_A01706095   	: in  STD_LOGIC;
		ClkEn_A01706095	: out STD_LOGIC);
End FreqDiv_A01706095;

Architecture rtl of FreqDiv_A01706095 is
  -- Signal and constants used by Frequency divider
  
  -- Define a value that contains the desired Frequency
  Constant DesiredFreq_A01706095 : natural := 1;  -- One per second changes in the FSM
  
  -- Frequency for a DE2-Lite board is 50MHz
  Constant BoardFreq_A01706095   : natural := 50_000_000; -- El guion bajo solo funciona con num naturales y enteros
  
  -- Calculate the value the counter should reach to obtain desired Freq.
  Constant MaxOscCount_A01706095 : natural := BoardFreq_A01706095 / DesiredFreq_A01706095;
  
  -- Pulse counter for the oscillator
  Signal OscCount_A01706095      : natural range 0 to MaxOscCount_A01706095;
  
 Begin
	Freq_Div_A01706095: Process(Rst_A01706095, Clk_A01706095)
	Begin
		If (Rst_A01706095 = '0') then
			OscCount_A01706095 <= 0;
		
		Elsif (rising_edge(clk_A01706095)) then 
			If (OscCount_A01706095 = MaxOscCount_A01706095) then
				ClkEn_A01706095 		<= '1';
				OscCount_A01706095 	<=  0;
			Else
				ClkEn_A01706095 		<= '0';
				OscCount_A01706095	<= OscCount_A01706095 + 1;
			End if;
			
		End if;
	
	End Process Freq_Div_A01706095;
 
 End rtl;