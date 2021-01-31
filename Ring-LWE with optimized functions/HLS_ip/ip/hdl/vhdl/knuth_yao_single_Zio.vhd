-- ==============================================================
-- File generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC
-- Version: 2017.4
-- Copyright (C) 1986-2017 Xilinx, Inc. All Rights Reserved.
-- 
-- ==============================================================

library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;

entity knuth_yao_single_Zio_rom is 
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


architecture rtl of knuth_yao_single_Zio_rom is 

signal addr0_tmp : std_logic_vector(awidth-1 downto 0); 
type mem_array is array (0 to mem_size-1) of std_logic_vector (dwidth-1 downto 0); 
signal mem : mem_array := (
    0 to 2=> "0", 3 => "1", 4 to 5=> "0", 6 => "1", 7 => "0", 8 => "1", 9 => "0", 
    10 to 11=> "1", 12 => "0", 13 to 14=> "1", 15 to 16=> "0", 17 => "1", 18 to 21=> "0", 22 => "1", 
    23 => "0", 24 => "1", 25 to 27=> "0", 28 => "1", 29 to 34=> "0", 35 => "1", 36 to 37=> "0", 
    38 => "1", 39 to 40=> "0", 41 to 43=> "1", 44 to 46=> "0", 47 => "1", 48 => "0", 49 to 51=> "1", 
    52 => "0", 53 => "1", 54 to 56=> "0", 57 to 59=> "1", 60 to 61=> "0", 62 => "1", 63 to 64=> "0", 
    65 to 67=> "1", 68 => "0", 69 to 71=> "1", 72 => "0", 73 to 76=> "1", 77 => "0", 78 => "1", 
    79 => "0", 80 => "1", 81 => "0", 82 to 83=> "1", 84 => "0", 85 to 87=> "1", 88 to 91=> "0", 
    92 => "1", 93 to 94=> "0", 95 to 98=> "1", 99 => "0", 100 to 102=> "1", 103 => "0", 104 => "1", 
    105 to 108=> "0" );

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

entity knuth_yao_single_Zio is
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

architecture arch of knuth_yao_single_Zio is
    component knuth_yao_single_Zio_rom is
        port (
            clk : IN STD_LOGIC;
            addr0 : IN STD_LOGIC_VECTOR;
            ce0 : IN STD_LOGIC;
            q0 : OUT STD_LOGIC_VECTOR);
    end component;



begin
    knuth_yao_single_Zio_rom_U :  component knuth_yao_single_Zio_rom
    port map (
        clk => clk,
        addr0 => address0,
        ce0 => ce0,
        q0 => q0);

end architecture;

