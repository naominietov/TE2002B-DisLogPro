----------------------------------------------------------------------------------
-- Company: 		 Tecnológico de Monterrey Campus Querétaro
-- ID:				 A01706095
-- Engineer: 		 Naomi Estefania Nieto Vega
--
-- Create Date:    02/25/2021 
-- Design Name: 	 FSM Control Unit 
-- Module Name:    FSMControlUnit_A01706095 - Behavioral 
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

Entity FSMControlUnit_A01706095 is 
  Port (
	  Clk_A01706095   	: in  STD_LOGIC;
	  Rst_A01706095   	: in  STD_LOGIC;
	  ClkEn_A01706095 	: in  STD_LOGIC;
	  DataId_A01706095   : in  STD_LOGIC; -- Input data identifier
	  Output_A01706095   : out STD_LOGIC_VECTOR (5 downto 0)); -- This vector stores the output variables
	  
End FSMControlUnit_A01706095;

Architecture rtl of FSMControlUnit_A01706095 is

  -- State name declaration as binary state
  -- User defined type as an enumeration list giving the State names
  -- InitialState, Memory, InstructionRegister, DataRegister, TemporalAC
  -- PermanentAC, ProgramCounter
  
  Type state_values is (InitialState_A01706095, Memory_A01706095, IRegister_A01706095, 
								MemoryAux_A01706095, DRegister_A01706095, TempAC_A01706095, 
								PermAC_A01706095, PCounter_A01706095);
								
  Signal pres_state : state_values;
  Signal next_state : state_values;

Begin
	-- State Register Definition Process
	
	Statereg_A01706095 : Process(Clk_A01706095, Rst_A01706095)
	Begin
		If (Rst_A01706095 = '0') then
				pres_state <= InitialState_A01706095;
				
		Elsif (rising_edge(Clk_A01706095)) then
				If (ClkEn_A01706095 = '1') then
					pres_state <= next_state;
				End If;
		End if;
	End Process Statereg_A01706095;
	
	-- Next State Logic Definition.
	
	FSM_A01706095: Process(pres_state) -- 0 instruccion sin dato // 1 instruccion con dato
	Begin
		 If (DataId_A01706095 = '1') then
				Case (pres_state) is
				
					When InitialState_A01706095 => next_state <= Memory_A01706095;
					
					When Memory_A01706095 		 => next_state <= IRegister_A01706095;
					
					When IRegister_A01706095 	 => next_state <= MemoryAux_A01706095;
					
					When MemoryAux_A01706095 	 => next_state <= DRegister_A01706095;
					
					When DRegister_A01706095	 => next_state <= TempAC_A01706095;
					
					When TempAC_A01706095 		 => next_state <= PermAC_A01706095;
					
					When PermAC_A01706095 		 => next_state <= Memory_A01706095;
					
					When others 		          => next_state <= InitialState_A01706095;
				End Case;
		 
		 Else
				Case (pres_state) is
				
					When InitialState_A01706095 => next_state <= Memory_A01706095;
					
					When Memory_A01706095 		 => next_state <= IRegister_A01706095;
					
					When IRegister_A01706095 	 => next_state <= TempAC_A01706095;
					
					When TempAC_A01706095 		 => next_state <= PermAC_A01706095;
					
					When others 		          => next_state <= InitialState_A01706095;

				End Case;
		End If;
	End Process FSM_A01706095;
	
	
	-- Output Logic Definitions of the Control Unit
	-- Outputs depends only on the current state
	
	Outputs_A01706095: Process(pres_state)
	Begin
		Case pres_state is 
		
			When InitialState_A01706095  => Output_A01706095 <= "000000";
			When Memory_A01706095  		  => Output_A01706095 <= "100000";
			When IRegister_A01706095  	  => Output_A01706095 <= "010001"; -- Con PCounter
			When MemoryAux_A01706095  	  => Output_A01706095 <= "100000";
			When DRegister_A01706095  	  => Output_A01706095 <= "001001"; -- Con PCounter
			When TempAC_A01706095		  => Output_A01706095 <= "000100";
			When PermAC_A01706095		  => Output_A01706095 <= "000010";
			
			When others 		           => Output_A01706095 <= "000000";
		End Case;
	End Process Outputs_A01706095;
End rtl;

