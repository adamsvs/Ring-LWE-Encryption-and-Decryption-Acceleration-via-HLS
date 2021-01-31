-- ==============================================================
-- File generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC
-- Version: 2017.4
-- Copyright (C) 1986-2017 Xilinx, Inc. All Rights Reserved.
-- 
-- ==============================================================

library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;

entity knuth_yao_single_3i2_rom is 
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


architecture rtl of knuth_yao_single_3i2_rom is 

signal addr0_tmp : std_logic_vector(awidth-1 downto 0); 
type mem_array is array (0 to mem_size-1) of std_logic_vector (dwidth-1 downto 0); 
signal mem : mem_array := (
    0 to 1=> "0", 2 => "1", 3 => "0", 4 => "1", 5 to 6=> "0", 7 => "1", 8 to 14=> "0", 
    15 => "1", 16 to 17=> "0", 18 to 19=> "1", 20 => "0", 21 to 23=> "1", 24 to 25=> "0", 26 to 27=> "1", 
    28 => "0", 29 => "1", 30 to 31=> "0", 32 => "1", 33 to 35=> "0", 36 to 38=> "1", 39 to 40=> "0", 
    41 to 43=> "1", 44 to 45=> "0", 46 => "1", 47 => "0", 48 to 49=> "1", 50 => "0", 51 => "1", 
    52 => "0", 53 to 57=> "1", 58 to 60=> "0", 61 => "1", 62 to 65=> "0", 66 => "1", 67 to 69=> "0", 
    70 to 76=> "1", 77 => "0", 78 => "1", 79 => "0", 80 to 82=> "1", 83 to 85=> "0", 86 to 87=> "1", 
    88 => "0", 89 to 91=> "1", 92 to 93=> "0", 94 to 96=> "1", 97 to 98=> "0", 99 => "1", 100 => "0", 
    101 => "1", 102 => "0", 103 to 108=> "1" );

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

entity knuth_yao_single_3i2 is
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

architecture arch of knuth_yao_single_3i2 is
    component knuth_yao_single_3i2_rom is
        port (
            clk : IN STD_LOGIC;
            addr0 : IN STD_LOGIC_VECTOR;
            ce0 : IN STD_LOGIC;
            q0 : OUT STD_LOGIC_VECTOR);
    end component;



begin
    knuth_yao_single_3i2_rom_U :  component knuth_yao_single_3i2_rom
    port map (
        clk => clk,
        addr0 => address0,
        ce0 => ce0,
        q0 => q0);

end architecture;

