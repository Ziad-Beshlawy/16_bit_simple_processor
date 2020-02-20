-- only zero flag.
-- "std_logic" inputs have to be cast to "signed".

Library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu is
	port(
		a, b    : in  signed(15 downto 0); -- inputs
		c       : out signed(15 downto 0); -- result
		control : in  std_logic_vector(2 downto 0); -- from "FUNC" segment of R type instructions or a decoder for other instructions.
		zf      : out std_logic                      -- flags
		);
end alu;


architecture behavior of alu is
constant add    : std_logic_vector(2 downto 0):= "000";  
constant sub    : std_logic_vector(2 downto 0):= "001";
constant and_op : std_logic_vector(2 downto 0):= "010";
constant or_op  : std_logic_vector(2 downto 0):= "011";
constant nor_op : std_logic_vector(2 downto 0):= "100";
constant xor_op : std_logic_vector(2 downto 0):= "101";
constant sl     : std_logic_vector(2 downto 0):= "110";
constant sr     : std_logic_vector(2 downto 0):= "111";

signal result : signed(15 downto 0); -- used to get flags 

begin
	with control select
	result <= a + b   when "000",
		      a - b   when "001",
		      a and b when "010",
		      a or b  when "011",
		      a nor b when "100",
		      a xor b when "101",
		      a sll 1 when "110",
		      a srl 1 when "111",
			  (others => '0') when others;
	c <= result;		  
			  
	zf <= '1' when (result = x"0000") else
		  '0';
	
end behavior;