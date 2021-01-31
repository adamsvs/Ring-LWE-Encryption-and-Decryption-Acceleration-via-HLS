-- ==============================================================
-- File generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC
-- Version: 2017.4
-- Copyright (C) 1986-2017 Xilinx, Inc. All Rights Reserved.
-- 
-- ==============================================================

library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;

entity knuth_yao_single_0iy_rom is 
    generic(
             dwidth     : integer := 1; 
             awidth     : integer := 7; 
             mem_size    : integer := 109
    ); 
    port (
          addr0      : in std_logic_vector(awidth-1 downto 0); 
          ce0       : in std_logic; 
          q0         : out std_logic_vector(dwidth-1 downto 0);
          clk       : in std_logic
    ); 
end entity; 


architecture rtl of knuth_yao_single_0iy_rom is 

signal addr0_tmp : std_logic_vector(awidth-1 downto 0); 
type mem_array is array (0 to mem_size-1) of std_logic_vector (dwidth-1 downto 0); 
signal mem : mem_array := (
    0 to 2=> "0", 3 to 4=> "1", 5 to 7=> "0", 8 => "1", 9 to 14=> "0", 15 => "1", 16 to 18=> "0", 
    19 => "1", 20 to 23=> "0", 24 to 27=> "1", 28 to 29=> "0", 30 to 33=> "1", 34 => "0", 35 => "1", 
    36 to 37=> "0", 38 to 39=> "1", 40 to 43=> "0", 44 to 49=> "1", 50 to 51=> "0", 52 to 55=> "1", 56 to 57=> "0", 
    58 => "1", 59 to 60=> "0", 61 to 62=> "1", 63 => "0", 64 => "1", 65 => "0", 66 to 67=> "1", 
    68 => "0", 69 => "1", 70 to 75=> "0", 76 => "1", 77 => "0", 78 to 79=> "1", 80 to 81=> "0", 
    82 to 83=> "1", 84 => "0", 85 to 87=> "1", 88 to 89=> "0", 90 to 91=> "1", 92 to 94=> "0", 95 => "1", 
    96 => "0", 97 to 98=> "1", 99 to 100=> "0", 101 => "1", 102 => "0", 103 to 106=> "1", 107 => "0", 
    108 => "1" );

attribute syn_rom_style : string;
attribute syn_rom_style of mem : signal is "select_rom";
attribute ROM_STYLE : string;
attribute ROM_STYLE of mem : signal is "distributed";

begin 


memory_access_guard_0: process (addr0) 
begin
      addr0_tmp <= addr0;
--synthesis translate_off
      if (CONV_INTEGER(addr0) > mem_size-1) then
           addr0_tmp <= (others => '0');
      else 
           addr0_tmp <= addr0;
      end if;
--synthesis translate_on
end process;

p_rom_access: process (clk)  
begin 
    if (clk'event and clk = '1') then
        if (ce0 = '1') then 
            q0 <= mem(CONV_INTEGER(addr0_tmp)); 
        end if;
    end if;
end process;

end rtl;


Library IEEE;
use IEEE.std_logic_1164.all;

entity knuth_yao_single_0iy is
    generic (
        DataWidth : INTEGER := 1;
        AddressRange : INTEGER := 109;
        AddressWidth : INTEGER := 7);
    port (
        reset : IN STD_LOGIC;
        clk : IN STD_LOGIC;
        address0 : IN STD_LOGIC_VECTOR(AddressWidth - 1 DOWNTO 0);
        ce0 : IN STD_LOGIC;
        q0 : OUT STD_LOGIC_VECTOR(DataWidth - 1 DOWNTO 0));
end entity;

architecture arch of knuth_yao_single_0iy is
    component knuth_yao_single_0iy_rom is
        port (
            clk : IN STD_LOGIC;
            addr0 : IN STD_LOGIC_VECTOR;
            ce0 : IN STD_LOGIC;
            q0 : OUT STD_LOGIC_VECTOR);
    end component;



begin
    knuth_yao_single_0iy_rom_U :  component knuth_yao_single_0iy_rom
    port map (
        clk => clk,
        addr0 => address0,
        ce0 => ce0,
        q0 => q0);

end architecture;


