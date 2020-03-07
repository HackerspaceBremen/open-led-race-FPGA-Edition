----------------------------------------------------------------------------------
-- Company: None
-- Engineer: Mia Eleonore Metzler and Arthur Palmer
-- 
-- Create Date: 03/6/2020 07:18:42 PM
-- Design Name: WS2812b driver
-- Module Name: taschenrechner - Behavioral
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

----------------------------------------------------------------------------------
-- Company: 	keine
-- Engineer:	Arthur Palmer
-- 
-- Create Date:		12:40:32 10/25/2015 
-- Design Name: 		WS2812B
-- Module Name:		WS2812B - Behavioral 
-- Project Name:		WS2812B Test
-- Target Devices:	Xilinx Spartan 6 LX 45
-- Tool versions: 	ISE WebPack 14.5
-- Description:		
--		Ansteuern EINER RGB-LED mit eingebautem WS2812B-Controller;
--		Die Farben werden mit 8bit pro Farbe, also 24bit eingelesen;
--		In meinem Fall w?hle ich die Farbe ?ber Schalter/Taster;
--		Verwendetes Board: Digilent Atlys Spartan-6 FPGA Development Board;
-- Dependencies: 
--
-- Revision: 
-- Revision 1.0
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.WS2812lib.ALL;
entity Core is
    Port ( 
	clk_i : in  std_logic;				-- Clock-Eingang; mein Board l?uft mit 100MHz
	led_o : out  std_logic;					-- Serielle Daten die an den RGB-Controller WS2812B geschickt werden
	reset_i : in std_logic
	);
end Core;

architecture Behavioral of Core is	
    signal ledstrip: strip := (0 => red, 1 => green, 2 => blue, others => black);
    component WS2812 Port(
        clk_i : in  std_logic;				-- Clock-Eingang; mein Board l?uft mit 100MHz
	   led_o : out  std_logic;					-- Serielle Daten die an den RGB-Controller WS2812B geschickt werden
	   reset_i : in std_logic;
	   ledbuf_i : in strip
    );
    end component;


begin
    leddriver: WS2812 port map(
        clk_i => clk_i,
        reset_i => reset_i,
        ledbuf_i => ledstrip,
        led_o => led_o
    );
end Behavioral;

