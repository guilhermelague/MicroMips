----------------------------------------------------------------------------------
-- Company: UERGS
-- Engineer: Guilherme Lague
-- 
-- Create Date: 17.10.2019 01:21:08
-- Design Name: 
-- Module Name: DataMemory - Behavioral
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
use IEEE.numeric_std.ALL;
library work;
use work.MicroMipsPkg.all;
 
entity DataMemory is
    Port ( clk        : in std_logic;
           rst        : in std_logic;
           mem_read   : in std_logic;
           mem_write  : in std_logic;
           address    : in STD_LOGIC_VECTOR (7 downto 0);
           data_in    : in STD_LOGIC_VECTOR (15 downto 0);
           data_out   : out STD_LOGIC_VECTOR (15 downto 0)
         );
end DataMemory;

architecture Behavioral of DataMemory is
    type memory is array (0 to 255) of std_logic_vector(15 downto 0);
    signal data : memory;
    
begin

process(clk)
begin
    if(rst = '0')then
        if(mem_read = '1' and mem_write = '0')then
            data_out <= data(to_integer(unsigned(address))); -- leitura
        elsif(mem_read = '0' and mem_write = '1')then
            data(to_integer(unsigned(address))) <= data_in; -- escrita
        end if;
    else
        data(0) <= "0000000010101011"; --171   --"0000000010011001" --153
        data(1) <= "0000000010101011"; --171
        data(2) <= "0000000000000000";
        data(3) <= "0000000000000000";
        data(4) <= "0000000000000010"; -- 2
        data(5) <= "0000000000000000";
        data(6) <= "0000000000000000";
        data(7) <= "0000000000000000";
        data(8) <= "0000000000000000";
        data(9) <= "0000000000000000";
        data(10) <= "0000000000000000";
        data(11) <= "0000000000000000";
        data(12) <= "0000000000000000";
        data(13) <= "0000000000000000";
        data(14) <= "0000000000000000";
        data(15) <= "0000000000000000";
        data(16) <= "0000000000000000";
        data(17) <= "0000000000000000";
        data(18) <= "0000000000000000";
        data(19) <= "0000000000000000";
        data(20) <= "0000000000000000";
        data(21) <= "0000000000000000";
        data(22) <= "0000000000000000";
        data(23) <= "0000000000000000";
        data(24) <= "0000000000000000";
        data(25) <= "0000000000000000";
        data(26) <= "0000000000000000";
        data(27) <= "0000000000000000";
        data(28) <= "0000000000000000";
        data(29) <= "0000000000000000";
        data(30) <= "0000000000000000";
        data(31) <= "0000000000000000";
        data(32) <= "0000000000000000";
        data(33) <= "0000000000000000";
        data(34) <= "0000000000000000";
        data(35) <= "0000000000000000";
        data(36) <= "0000000000000000";
        data(37) <= "0000000000000000";
        data(38) <= "0000000000000000";
        data(39) <= "0000000000000000";
        data(40) <= "0000000000000000";
        data(41) <= "0000000000000000";
        data(42) <= "0000000000000000";
        data(43) <= "0000000000000000";
        data(44) <= "0000000000000000";
        data(45) <= "0000000000000000";
        data(46) <= "0000000000000000";
        data(47) <= "0000000000000000";
        data(48) <= "0000000000000000";
        data(49) <= "0000000000000000";
        data(50) <= "0000000000000000";
        data(51) <= "0000000000000000";
        data(52) <= "0000000000000000";
        data(53) <= "0000000000000000";
        data(54) <= "0000000000000000";
        data(55) <= "0000000000000000";
        data(56) <= "0000000000000000";
        data(57) <= "0000000000000000";
        data(58) <= "0000000000000000";
        data(59) <= "0000000000000000";
        data(60) <= "0000000000000000";
        data(61) <= "0000000000000000";
        data(62) <= "0000000000000000";
        data(63) <= "0000000000000000";
        data(64) <= "0000000000000000";
        data(65) <= "0000000000000000";
        data(66) <= "0000000000000000";
        data(67) <= "0000000000000000";
        data(68) <= "0000000000000000";
        data(69) <= "0000000000000000";
        data(70) <= "0000000000000000";
        data(71) <= "0000000000000000";
        data(72) <= "0000000000000000";
        data(73) <= "0000000000000000";
        data(74) <= "0000000000000000";
        data(75) <= "0000000000000000";
        data(76) <= "0000000000000000";
        data(77) <= "0000000000000000";
        data(78) <= "0000000000000000";
        data(79) <= "0000000000000000";
        data(80) <= "0000000000000000";
        data(81) <= "0000000000000000";
        data(82) <= "0000000000000000";
        data(83) <= "0000000000000000";
        data(84) <= "0000000000000000";
        data(85) <= "0000000000000000";
        data(86) <= "0000000000000000";
        data(87) <= "0000000000000000";
        data(88) <= "0000000000000000";
        data(89) <= "0000000000000000";
        data(90) <= "0000000000000000";
        data(91) <= "0000000000000000";
        data(92) <= "0000000000000000";
        data(93) <= "0000000000000000";
        data(94) <= "0000000000000000";
        data(95) <= "0000000000000000";
        data(96) <= "0000000000000000";
        data(97) <= "0000000000000000";
        data(98) <= "0000000000000000";
        data(99) <= "0000000000000000";
        data(100) <= "0000000000000000";
        data(101) <= "0000000000000000";
        data(102) <= "0000000000000000";
        data(103) <= "0000000000000000";
        data(104) <= "0000000000000000";
        data(105) <= "0000000000000000";
        data(106) <= "0000000000000000";
        data(107) <= "0000000000000000";
        data(108) <= "0000000000000000";
        data(109) <= "0000000000000000";
        data(110) <= "0000000000000000";
        data(111) <= "0000000000000000";
        data(112) <= "0000000000000000";
        data(113) <= "0000000000000000";
        data(114) <= "0000000000000000";
        data(115) <= "0000000000000000";
        data(116) <= "0000000000000000";
        data(117) <= "0000000000000000";
        data(118) <= "0000000000000000";
        data(119) <= "0000000000000000";
        data(120) <= "0000000000000000";
        data(121) <= "0000000000000000";
        data(122) <= "0000000000000000";
        data(123) <= "0000000000000000";
        data(124) <= "0000000000000000";
        data(125) <= "0000000000000000";
        data(126) <= "0000000000000000";
        data(127) <= "0000000000000000";
        data(128) <= "0000000000000000";
        data(129) <= "0000000000000000";
        data(130) <= "0000000000000000";
        data(131) <= "0000000000000000";
        data(132) <= "0000000000000000";
        data(133) <= "0000000000000000";
        data(134) <= "0000000000000000";
        data(135) <= "0000000000000000";
        data(136) <= "0000000000000000";
        data(137) <= "0000000000000000";
        data(138) <= "0000000000000000";
        data(139) <= "0000000000000000";
        data(140) <= "0000000000000000";
        data(141) <= "0000000000000000";
        data(142) <= "0000000000000000";
        data(143) <= "0000000000000000";
        data(144) <= "0000000000000000";
        data(145) <= "0000000000000000";
        data(146) <= "0000000000000000";
        data(147) <= "0000000000000000";
        data(148) <= "0000000000000000";
        data(149) <= "0000000000000000";
        data(150) <= "0000000000000000";
        data(151) <= "0000000000000000";
        data(152) <= "0000000000000000";
        data(153) <= "0000000000000000";
        data(154) <= "0000000000000000";
        data(155) <= "0000000000000000";
        data(156) <= "0000000000000000";
        data(157) <= "0000000000000000";
        data(158) <= "0000000000000000";
        data(159) <= "0000000000000000";
        data(160) <= "0000000000000000";
        data(161) <= "0000000000000000";
        data(162) <= "0000000000000000";
        data(163) <= "0000000000000000";
        data(164) <= "0000000000000000";
        data(165) <= "0000000000000000";
        data(166) <= "0000000000000000";
        data(167) <= "0000000000000000";
        data(168) <= "0000000000000000";
        data(169) <= "0000000000000000";
        data(170) <= "0000000000000000";
        data(171) <= "0000000000000000";
        data(172) <= "0000000000000000";
        data(173) <= "0000000000000000";
        data(174) <= "0000000000000000";
        data(175) <= "0000000000000000";
        data(176) <= "0000000000000000";
        data(177) <= "0000000000000000";
        data(178) <= "0000000000000000";
        data(179) <= "0000000000000000";
        data(180) <= "0000000000000000";
        data(181) <= "0000000000000000";
        data(182) <= "0000000000000000";
        data(183) <= "0000000000000000";
        data(184) <= "0000000000000000";
        data(185) <= "0000000000000000";
        data(186) <= "0000000000000000";
        data(187) <= "0000000000000000";
        data(188) <= "0000000000000000";
        data(189) <= "0000000000000000";
        data(190) <= "0000000000000000";
        data(191) <= "0000000000000000";
        data(192) <= "0000000000000000";
        data(193) <= "0000000000000000";
        data(194) <= "0000000000000000";
        data(195) <= "0000000000000000";
        data(196) <= "0000000000000000";
        data(197) <= "0000000000000000";
        data(198) <= "0000000000000000";
        data(199) <= "0000000000000000";
        data(200) <= "0000000000000000";
        data(201) <= "0000000000000000";
        data(202) <= "0000000000000000";
        data(203) <= "0000000000000000";
        data(204) <= "0000000000000000";
        data(205) <= "0000000000000000";
        data(206) <= "0000000000000000";
        data(207) <= "0000000000000000";
        data(208) <= "0000000000000000";
        data(209) <= "0000000000000000";
        data(210) <= "0000000000000000";
        data(211) <= "0000000000000000";
        data(212) <= "0000000000000000";
        data(213) <= "0000000000000000";
        data(214) <= "0000000000000000";
        data(215) <= "0000000000000000";
        data(216) <= "0000000000000000";
        data(217) <= "0000000000000000";
        data(218) <= "0000000000000000";
        data(219) <= "0000000000000000";
        data(220) <= "0000000000000000";
        data(221) <= "0000000000000000";
        data(222) <= "0000000000000000";
        data(223) <= "0000000000000000";
        data(224) <= "0000000000000000";
        data(225) <= "0000000000000000";
        data(226) <= "0000000000000000";
        data(227) <= "0000000000000000";
        data(228) <= "0000000000000000";
        data(229) <= "0000000000000000";
        data(230) <= "0000000000000000";
        data(231) <= "0000000000000000";
        data(232) <= "0000000000000000";
        data(233) <= "0000000000000000";
        data(234) <= "0000000000000000";
        data(235) <= "0000000000000000";
        data(236) <= "0000000000000000";
        data(237) <= "0000000000000000";
        data(238) <= "0000000000000000";
        data(239) <= "0000000000000000";
        data(240) <= "0000000000000000";
        data(241) <= "0000000000000000";
        data(242) <= "0000000000000000";
        data(243) <= "0000000000000000";
        data(244) <= "0000000000000000";
        data(245) <= "0000000000000000";
        data(246) <= "0000000000000000";
        data(247) <= "0000000000000000";
        data(248) <= "0000000000000000";
        data(249) <= "0000000000000000";
        data(250) <= "0000000000000000";
        data(251) <= "0000000000000000";
        data(252) <= "0000000000000000";
        data(253) <= "0000000000000000";
        data(254) <= "0000000000000000";
        data(255) <= "0000000000000000";
    end if;
end process;

end Behavioral;
