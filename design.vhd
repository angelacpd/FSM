LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

entity fsm is
	port(
			CLOCK_50 : in std_logic;
			KEY : in std_logic_vector(3 downto 0);
			LEDR : out std_logic_vector(9 downto 0)
	);
end entity;

architecture arch_fsm of fsm is 
	type states is (s0, s1, s2, s3);
	signal ea, pe : states;
    -- ea: estado atual
    -- pe: próximo estado
	
	signal clk, reset, x : std_logic;
	signal z : std_logic;
begin

	clk <= CLOCK_50;
	reset <= KEY(0);
	x <= KEY(1);
	LEDR(0) <= z;
    LEDR(1) <= '0';
    LEDR(2) <= '0';
    LEDR(3) <= '0';
    LEDR(4) <= '0';
    LEDR(5) <= '0';
    LEDR(6) <= '0';
    LEDR(7) <= '0';
    LEDR(8) <= '0';
    LEDR(9) <= '0';
	
	process(clk, reset)
	begin 
		if reset = '1' then
			ea <= s0;
		elsif clk'event and clk = '1' then
			ea <= pe;
		end if;
	end process;
	
	process(ea, x)
	begin 
		case ea is
			when s0 => 
				z <= '0';
				if x = '0' then 
					pe <= s0;
				else
					pe <= s2;
				end if;
			when s1 => 
				z <= '1';
				if x = '0' then 
					pe <= s0;
				else
					pe <= s2;
				end if;
			when s2 => 
				z <= '1';
				if x = '0' then 
					pe <= s2;
				else
					pe <= s3;
				end if;
			when s3 => 
				z <= '0';
				if x = '0' then 
					pe <= s3;
				else
					pe <= s1;
				end if;	
		end case;
	end process;
end architecture;
