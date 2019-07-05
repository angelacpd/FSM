LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

entity testbench is
	-- empty
end entity;

architecture tb of testbench is
	component fsm is
		port(
			CLOCK_50 : in std_logic;
			KEY : in std_logic_vector(3 downto 0);
			LEDR : out std_logic_vector(9 downto 0)
		);
	end component;
	
  signal clock_in, reset : std_logic := '0';

	signal key_in : std_logic_vector(3 downto 0);
	signal ledr_out : std_logic_vector(9 downto 0);

begin
  	
	process
	begin
		clock_in <= not clock_in;
		wait for 10 ns;
		clock_in <= not clock_in;
		wait for 10 ns;
        
	end process;
    
	DUT: fsm port map (CLOCK_50 => clock_in, 
						KEY => key_in, 
						LEDR => ledr_out);

	process
	begin
		key_in <= "0001";
		wait for 1 ns;
    	assert(ledr_out(0)='0') report "Reset Fail 0/0" severity error;
       
		key_in <= "0000";
		wait for 19 ns;
    	assert(ledr_out(0)='0') report "Fail S0, x = 0" severity error;

		key_in <= "0010";
		wait for 20 ns;
    	assert(ledr_out(0)='0') report "Fail S0, x = 1" severity error;
        
    key_in <= "0000";
		wait for 20 ns;
    	assert(ledr_out(0)='1') report "Fail S2, x = 0" severity error;
        
    key_in <= "0010";
		wait for 20 ns;
    	assert(ledr_out(0)='1') report "Fail S2, x = 1" severity error;
        
    key_in <= "0000";
		wait for 20 ns;
    	assert(ledr_out(0)='0') report "Fail S3, x = 0" severity error;
        
    key_in <= "0010";
		wait for 20 ns;
    	assert(ledr_out(0)='0') report "Fail S3, x = 1" severity error;

		key_in <= "0000";
		wait for 20 ns;
    	assert(ledr_out(0)='1') report "Fail S1  x = 0" severity error;
        
    key_in <= "0000";
		wait for 20 ns;
    	assert(ledr_out(0)='0') report "Fail S0  x = 0" severity error;
        
        -- 

		key_in <= "0010";
		wait for 20 ns;
    	assert(ledr_out(0)='0') report "Fail S0, x = 1" severity error;
        
    key_in <= "0010";
		wait for 20 ns;
    	assert(ledr_out(0)='1') report "Fail S2, x = 1" severity error;
        
    key_in <= "0010";
		wait for 20 ns;
    	assert(ledr_out(0)='0') report "Fail S3, x = 1" severity error;

		key_in <= "0010";
		wait for 20 ns;
    	assert(ledr_out(0)='1') report "Fail S1  x = 0" severity error;
        
    key_in <= "0000";
		wait for 4 ns;
    	assert(ledr_out(0)='1') report "Fail S2  x = 0" severity error;
		
        
      ASSERT false REPORT "Finished" SEVERITY failure;
        
	end process;

end architecture;
