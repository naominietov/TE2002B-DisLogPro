------------------------------------------------------------------
------------------------------------------------------------------
-- TE2002B. Diseño con lógica programable 
-- Autor(a): A01706095 Naomi Estefanía Nieto Vega
-- Fecha: 17 de febrero 2021
-- Evidencia 1. Implementación y diseño de una ALU de 4-bits
-- Instrucciones: Add, Addc, Sub, Subc, And, Or, Xor, Mask
------------------------------------------------------------------
------------------------------------------------------------------

Library IEEE;
Use IEEE.std_logic_1164.all;
Use IEEE.std_logic_arith.all;
Use IEEE.numeric_std.all;
Use IEEE.std_logic_signed.all;

Entity Evidencia1_1706095 is
Port (	
			Rs_1706095, Op2_1706095		: in std_logic_vector(3 downto 0);
			Opc1706095						: in std_logic_vector(2 downto 0);
			Cin_1706095						: in std_logic;
			Sal1706095						: out std_logic_vector(3 downto 0); 
			Carry1706095 					: out std_logic;
			Zero1706095 					: out std_logic);
End Evidencia1_1706095;

Architecture a of Evidencia1_1706095 is
	Signal Rd_1706095						:	std_logic_vector(3 downto 0); -- Guarda el resultado, nose manda a salida para guadrlo y manipularlo
	Signal senal1_1706095 				:	std_logic_vector(3 downto 0); -- sirve para ; resultado cuando es suma de positivos
	Signal senal2_1706095				:	std_logic_vector(4 downto 0); -- guarda el resultado cuando es suma de negativos
	
Begin
	ALU_1706095 : Process(Rs_1706095, Op2_1706095, Opc1706095)
	Begin
		Case (Opc1706095) is
		
			When "000" => -- Add rd, rs, op2 	// Add source register and op2, result in destination register 
			
					Rd_1706095 <= Rs_1706095 + Op2_1706095;
					
					senal1_1706095 <= ('0' & Rs_1706095 (2 downto 0)) + ('0' & Op2_1706095(2 downto 0)); --suma positiva/solo importan primeros 3bit
					senal2_1706095 <= ('0' & Rs_1706095(3 downto 0)) + ('0' & Op2_1706095(3 downto 0));
			
			
					If (Rs_1706095(3) = '0' and Op2_1706095(3) = '0') then --positivo y ´positivo
							carry1706095 <= senal1_1706095(3);
			
					Elsif (Rs_1706095(3) = '1' and Op2_1706095(3) = '1' ) then --neg y neg
							If (senal2_1706095(4) = '1' and senal2_1706095(3) = '1') then 
								Carry1706095 <= '0';
							Else Carry1706095 <= '1';
							
							End If;
							
					Else Carry1706095 <= '0'; --numeros 7 a -8
					End If;
		

			When "001" => -- Addc rd, rs, op2 	// Add rs and op2 with carry, result in rd
			
					Rd_1706095 <= Rs_1706095 + Op2_1706095 + Cin_1706095;
					
					senal1_1706095 <= ('0' & Rs_1706095 (2 downto 0)) + ('0' & Op2_1706095(2 downto 0)) + Cin_1706095; 
					senal2_1706095 <= ('0' & Rs_1706095(3 downto 0)) + ('0' & Op2_1706095(3 downto 0)) + Cin_1706095;
			
			
					If (Rs_1706095(3) = '0' and Op2_1706095(3) = '0') then --positivo y ´positivo
							Carry1706095 <= senal1_1706095(3);
			
					Elsif (Rs_1706095(3) = '1' and Op2_1706095(3) = '1' ) then --neg y neg
							If (senal2_1706095(4) = '1' and senal2_1706095(3) = '1') then 
								Carry1706095 <= '0';
							Else Carry1706095 <= '1';
							
							End if;
					Else Carry1706095 <= '0'; --numeros 7 a -8
					End if;
			
			When "010" => -- Sub rd, rs, op2 	// Subtract op2 from rs, result in rd
			
					Rd_1706095 <= Rs_1706095 - Op2_1706095;
					
					senal1_1706095 <= ('0' & Rs_1706095 (2 downto 0)) + ('0' & NOT(Op2_1706095(2 downto 0))+1); --a la segunda parte afcta un menos: SE PASA A COMPL A 2
					senal2_1706095 <= ('0' & Rs_1706095(3 downto 0)) + ('0' & NOT(Op2_1706095(3 downto 0))+1);
			
			
					If (Rs_1706095(3) = '0' and Op2_1706095(3) = '0') then --positivo y neg
							carry1706095 <= '0';
			
					Elsif (Rs_1706095(3) = '1' and Op2_1706095(3) = '1' ) then --neg y positivo
							carry1706095 <= '0';
							
					Elsif (Rs_1706095(3) = '1' and Op2_1706095(3) = '0' ) then
							If (senal2_1706095(4) = '1' and senal2_1706095(3) = '1') then 
								Carry1706095 <= '0';
							Else Carry1706095 <= '1';
							
							End if;
							
					Else Carry1706095 <= senal1_1706095(3); --numeros 7 a -8
					End if;
				
		
			When "011" => -- Subc rd, rs, op2 	// Substract op2 from rs with carryin(Cin), result in rd
			
					Rd_1706095 <= Rs_1706095 - Op2_1706095 - Cin_1706095;
					
					senal1_1706095 <= ('0' & Rs_1706095 (2 downto 0)) + ('0' & NOT(Op2_1706095(2 downto 0))+1) - Cin_1706095; --a la segunda parte afcta un menos: SE PASA A COMPL A 2
					senal2_1706095 <= ('0' & Rs_1706095(3 downto 0)) + ('0' & NOT(Op2_1706095(3 downto 0))+1) - Cin_1706095;
			
			
					If (Rs_1706095(3) = '0' and Op2_1706095(3) = '0') then --positivo y neg
							carry1706095 <= '0';
			
					Elsif (Rs_1706095(3) = '1' and Op2_1706095(3) = '1' ) then --neg y positivo
							carry1706095 <= '0';
							
					Elsif (Rs_1706095(3) = '1' and Op2_1706095(3) = '0' ) then
							If (senal2_1706095(4) = '1' and senal2_1706095(3) = '1') then 
								Carry1706095 <= '0';
							Else Carry1706095 <= '1';
							
							End if;
							
					Else Carry1706095 <= senal1_1706095(3); --numeros 7 a -8
					End if;
					
		
			When "100" => -- AND rd, rs, op2 	// Logical AND of rs and op2, result in rd
			
					Rd_1706095 <= Rs_1706095 AND Op2_1706095; -- Rd = destination register / Rs = source register 
		
			When "101" => -- OR rd, rs, op2 	// Logical OR of rs and op2, result in rd
			
					Rd_1706095 <= Rs_1706095 OR Op2_1706095;
		
			When "110" => -- XOR rd, rs, op2	// Logical XOR of rs and op2, result in rd
			
					Rd_1706095 <= Rs_1706095 XOR Op2_1706095;
		
			When "111" => -- MASK rd, rs, op2	// Logical AND of rs and NOT op2, result in rd
			
					Rd_1706095 <= Rs_1706095 AND (NOT Op2_1706095);
			
			When others => Rd_1706095 <= "0000";
					Zero1706095 <= '0';
			
		End Case;
		
		If Rd_1706095 = "0000" then 
			Zero1706095 <= '1';
		Else 
			Zero1706095 <= '0';
		End If;
					
		Sal1706095 <= Rd_1706095;
		
		
	End Process ALU_1706095;
End a;
