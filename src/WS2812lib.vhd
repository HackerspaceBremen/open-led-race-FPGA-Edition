----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/07/2020 10:36:33 AM
-- Design Name: 
-- Module Name: WS2812lib - Behavioral
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
use IEEE.NUMERIC_STD.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

package WS2812lib is
    	type color is
    record
       red : std_logic_vector(7 downto 0);
       green : std_logic_vector(7 downto 0);
       blue : std_logic_vector(7 downto 0);
    end record;
    
    constant NUM_PIXELS : integer := 50; -- min. >= 500steps
    
    
    constant red: color := (red => (others => '1'), others => (others => '0'));
    constant green: color := (green => (others => '1'), others => (others => '0'));
    constant blue: color := (blue => (others => '1'), others => (others => '0'));
    constant black: color := (others => (others => '0'));
    
    type strip is array (0 to (NUM_PIXELS - 1)) of color;
    function RGB_to_Vector(r,g,b : integer range 0 to 255) return color;
end WS2812lib;

package body WS2812lib is
    function RGB_to_Vector(r,g,b : integer range 0 to 255) return color is
    variable tmp: color := red;
    begin
        tmp.red := std_logic_vector(to_unsigned(r,8));
        tmp.green := std_logic_vector(to_unsigned(g,8));
        tmp.blue := std_logic_vector(to_unsigned(b,8));
        return tmp;
    end RGB_to_Vector;
end WS2812lib;


