Library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

Entity Register_file is
	port(
	clk:          in std_logic;
	ReadRegister1:in std_logic_vector(2 downto 0);
	ReadRegister2:in std_logic_vector(2 downto 0);
	WriteRegister:in std_logic_vector(2 downto 0);
	Writedata:    in std_logic_vector(15 downto 0);
	Readdata1:   out std_logic_vector(15 downto 0);
	Readdata2:   out std_logic_vector(15 downto 0);
	RegWrite :    in std_logic 
	);
end Register_file;


Architecture Behavioral of Register_file is

type reg_file_type is array (0 to 7) of std_logic_vector(15 downto 0);
signal array_reg : reg_file_type;

Begin
	process(clk)
	Begin
		if (rising_edge(clk)) then
			if (RegWrite = '1') then
				array_reg(to_integer(unsigned(WriteRegister))) <= Writedata;
			end if;
		end if;	
	end process;
	
	Readdata1 <= array_reg(to_integer(unsigned(ReadRegister1)));
	Readdata2 <= array_reg(to_integer(unsigned(ReadRegister2)));

end Behavioral;