-- ==============================================================
-- File generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC
-- Version: 2017.4
-- Copyright (C) 1986-2017 Xilinx, Inc. All Rights Reserved.
-- 
-- ==============================================================

library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;

entity knuth_yao_single_Lf8_rom is 
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


architecture rtl of knuth_yao_single_Lf8_rom is 

signal addr0_tmp : std_logic_vector(awidth-1 downto 0); 
type mem_array is array (0 to mem_size-1) of std_logic_vector (dwidth-1 downto 0); 
signal mem : mem_array := (
    0 to 15=> "0", 16 => "1", 17 => "0", 18 => "1", 19 to 21=> "0", 22 to 23=> "1", 24 => "0", 
    25 => "1", 26 to 27=> "0", 28 => "1", 29 => "0", 30 => "1", 31 => "0", 32 to 33=> "1", 
    34 to 35=> "0", 36 to 37=> "1", 38 => "0", 39 => "1", 40 => "0", 41 => "1", 42 to 43=> "0", 
    44 to 46=> "1", 47 => "0", 48 => "1", 49 to 50=> "0", 51 => "1", 52 to 53=> "0", 54 to 55=> "1", 
    56 to 57=> "0", 58 => "1", 59 => "0", 60 to 62=> "1", 63 to 67=> "0", 68 to 70=> "1", 71 to 76=> "0", 
    77 => "1", 78 to 80=> "0", 81 to 82=> "1", 83 => "0", 84 => "1", 85 => "0", 86 to 88=> "1", 
    89 => "0", 90 to 91=> "1", 92 => "0", 93 => "1", 94 => "0", 95 to 96=> "1", 97 to 101=> "0", 
    102 to 103=> "1", 104 to 106=> "0", 107 to 108=> "1" );

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

entity knuth_yao_single_Lf8 is
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

architecture arch of knuth_yao_single_Lf8 is
    component knuth_yao_single_Lf8_rom is
        port (
            clk : IN STD_LOGIC;
            addr0 : IN STD_LOGIC_VECTOR;
            ce0 : IN STD_LOGIC;
            q0 : OUT STD_LOGIC_VECTOR);
    end component;



begin
    knuth_yao_single_Lf8_rom_U :  component knuth_yao_single_Lf8_rom
    port map (
        clk => clk,
        addr0 => address0,
        ce0 => ce0,
        q0 => q0);

end architecture;


