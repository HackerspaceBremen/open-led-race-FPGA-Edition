----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/07/2020 09:59:46 AM
-- Design Name: 
-- Module Name: WS2812 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.WS2812lib.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity WS2812 is
    Port ( 
	clk_i : in  std_logic;				-- Clock-Eingang; mein Board l?uft mit 100MHz
	led_o : out  std_logic;					-- Serielle Daten die an den RGB-Controller WS2812B geschickt werden
	reset_i : in std_logic;
	ledbuf_i : in strip
	);
end WS2812;

architecture Behavioral of WS2812 is
    signal sendBuffer: std_logic_vector(0 to 23) := "000000000000000000000000";
    signal index : integer range 0 to 23 := 23;
begin
    
    streamdata: process (clk_i) is 
	
	variable prescaler : integer range 0 to 125 := 0;
	variable reset_time : integer := 0;
	variable pos : integer range 0 to (NUM_PIXELS - 1) := 0;
	begin
	
	if(rising_edge(clk_i)) then
	   if(reset_i = '1') then
	       pos := 0;
	       reset_time := 0;
	       sendBuffer(0 to 7) <= ledbuf_i(pos).blue;
	       sendBuffer(8 to 15) <= ledbuf_i(pos).green;
	       sendBuffer(16 to 23) <= ledbuf_i(pos).red;
	   elsif(reset_time = 0) then
	       prescaler := prescaler + 1;
	       if(prescaler < 40) then
	           led_o <= '1';
	       elsif(prescaler < 80) then
	           led_o <= sendBuffer(index);
	       elsif(prescaler < 125) then
	           led_o <= '0';
	       else
	           prescaler := 0;
	           if(index = 0) then
	               index <= 23;
	               --prepare next sendbuffer
	               
	               if(pos + 1 = NUM_PIXELS) then
	                   reset_time := 10000;
	                   pos := 0;
	               else
	                   pos := pos + 1;
	               end if;
	               sendBuffer(0 to 7) <= ledbuf_i(pos).blue;
	               sendBuffer(8 to 15) <= ledbuf_i(pos).green;
	               sendBuffer(16 to 23) <= ledbuf_i(pos).red;
	           else
	               index <= index - 1;
	           end if;
	           
	       end if;
	   else
	       reset_time := reset_time - 1;
	   end if;
	   
	end if;
	end process;

end Behavioral;
