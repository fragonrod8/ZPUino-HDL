library IEEE;
use IEEE.std_logic_1164.all; 
use IEEE.std_logic_unsigned.all; 
use ieee.numeric_std.all;

entity bootloader_dp_32 is
  port (
    CLK:              in std_logic;
    WEA:  in std_logic;
    ENA:  in std_logic;
    MASKA:    in std_logic_vector(3 downto 0);
    ADDRA:         in std_logic_vector(11 downto 2);
    DIA:        in std_logic_vector(31 downto 0);
    DOA:         out std_logic_vector(31 downto 0);
    WEB:  in std_logic;
    ENB:  in std_logic;
    ADDRB:         in std_logic_vector(11 downto 2);
    DIB:        in std_logic_vector(31 downto 0);
    MASKB:    in std_logic_vector(3 downto 0);
    DOB:         out std_logic_vector(31 downto 0)
  );
end entity bootloader_dp_32;

architecture behave of bootloader_dp_32 is

  subtype RAM_WORD is STD_LOGIC_VECTOR (31 downto 0);
  type RAM_TABLE is array (0 to 1023) of RAM_WORD;
 shared variable RAM: RAM_TABLE := RAM_TABLE'(
x"0b0b0b97",x"ff040000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"0b0b0b98",x"9b040000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"71fd0608",x"72830609",x"81058205",x"832b2a83",x"ffff0652",x"04000000",x"00000000",x"00000000",x"71fd0608",x"83ffff73",x"83060981",x"05820583",x"2b2b0906",x"7383ffff",x"0b0b0b0b",x"83a70400",x"72098105",x"72057373",x"09060906",x"73097306",x"070a8106",x"53510400",x"00000000",x"00000000",x"72722473",x"732e0753",x"51040000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"71737109",x"71068106",x"30720a10",x"0a720a10",x"0a31050a",x"81065151",x"53510400",x"00000000",x"72722673",x"732e0753",x"51040000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"0b0b0b88",x"c3040000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"720a722b",x"0a535104",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"72729f06",x"0981050b",x"0b0b88a6",x"05040000",x"00000000",x"00000000",x"00000000",x"00000000",x"72722aff",x"739f062a",x"0974090a",x"8106ff05",x"06075351",x"04000000",x"00000000",x"00000000",x"71715351",x"020d0406",x"73830609",x"81058205",x"832b0b2b",x"0772fc06",x"0c515104",x"00000000",x"72098105",x"72050970",x"81050906",x"0a810653",x"51040000",x"00000000",x"00000000",x"00000000",x"72098105",x"72050970",x"81050906",x"0a098106",x"53510400",x"00000000",x"00000000",x"00000000",x"71098105",x"52040000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"72720981",x"05055351",x"04000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"72097206",x"73730906",x"07535104",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"71fc0608",x"72830609",x"81058305",x"1010102a",x"81ff0652",x"04000000",x"00000000",x"00000000",x"71fc0608",x"0b0b0b9a",x"b4738306",x"10100508",x"060b0b0b",x"88a90400",x"00000000",x"00000000",x"0b0b0b88",x"f7040000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"0b0b0b88",x"df040000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"72097081",x"0509060a",x"8106ff05",x"70547106",x"73097274",x"05ff0506",x"07515151",x"04000000",x"72097081",x"0509060a",x"098106ff",x"05705471",x"06730972",x"7405ff05",x"06075151",x"51040000",x"05ff0504",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"810b0b0b",x"0b9bac0c",x"51040000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"71810552",x"04000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"02840572",x"10100552",x"04000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"717105ff",x"05715351",x"020d0400",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"81d43f92",x"843f0410",x"10101010",x"10101010",x"10101010",x"10101010",x"10101010",x"10101010",x"10101010",x"10105351",x"047381ff",x"06738306",x"09810583",x"05101010",x"2b0772fc",x"060c5151",x"043c0472",x"72807281",x"06ff0509",x"72060571",x"1052720a",x"100a5372",x"ed385151",x"53510488",x"088c0890",x"08757598",x"f42d5050",x"88085690",x"0c8c0c88",x"0c510488",x"088c0890",x"08757598",x"b02d5050",x"88085690",x"0c8c0c88",x"0c510488",x"088c0890",x"088eb22d",x"900c8c0c",x"880c04ff",x"3d0d0b0b",x"0b9bbc33",x"5170a638",x"9bb80870",x"08525270",x"802e9238",x"84129bb8",x"0c702d9b",x"b8087008",x"525270f0",x"38810b0b",x"0b0b9bbc",x"34833d0d",x"0404803d",x"0d0b0b0b",x"9be80880",x"2e8e380b",x"0b0b0b80",x"0b802e09",x"81068538",x"823d0d04",x"0b0b0b9b",x"e8510b0b",x"0bf6813f",x"823d0d04",x"04ff3d0d",x"80c48080",x"84527108",x"70822a70",x"81065151",x"5170f338",x"833d0d04",x"ff3d0d80",x"c4808084",x"52710870",x"812a7081",x"06515151",x"70f33873",x"82900a0c",x"833d0d04",x"fd3d0d75",x"54733370",x"81ff0653",x"5371802e",x"8e387281",x"ff06518a",x"a02d8114",x"54e73985",x"3d0d04fe",x"3d0d7470",x"80dc8080",x"880c7081",x"ff06ff83",x"11545153",x"7181268d",x"3880fd51",x"8aa02d72",x"a0325183",x"3972518a",x"a02d843d",x"0d04803d",x"0d83ffff",x"0b83d00a",x"0c80fe51",x"8aa02d82",x"3d0d04ff",x"3d0d83d0",x"0a087088",x"2a52528a",x"e32d7181",x"ff06518a",x"e32d80fe",x"518aa02d",x"833d0d04",x"82e7af0b",x"80cc8080",x"880c800b",x"80cc8080",x"840c9f0b",x"83900a0c",x"04ff3d0d",x"73700851",x"5180c880",x"80847008",x"70848080",x"07720c52",x"52833d0d",x"04ff3d0d",x"80c88080",x"84700870",x"fbffff06",x"720c5252",x"833d0d04",x"a0900ba0",x"800c9bc0",x"0ba0840c",x"98942dff",x"3d0d7351",x"8b710c90",x"115291c0",x"80720c80",x"720c7008",x"83ffff06",x"880c833d",x"0d04fa3d",x"0d787a7d",x"ff1e5757",x"585373ff",x"2ea73880",x"56845275",x"730c7208",x"88180cff",x"125271f3",x"38748416",x"7408720c",x"ff165656",x"5273ff2e",x"098106dd",x"38883d0d",x"04f83d0d",x"80d08080",x"845783d0",x"0a0b9afc",x"52598ac0",x"2d8bfd2d",x"76518ca3",x"2d9bc070",x"88081010",x"91c08405",x"71708405",x"530c5656",x"fb8084a1",x"ad750c9a",x"ec0b8817",x"0c807078",x"0c770c76",x"0883ffff",x"065680df",x"800b8808",x"278f389b",x"84518ac0",x"2d9ba851",x"8ac02dff",x"3983ffff",x"790ca080",x"54880853",x"78527651",x"8cc22d76",x"518be12d",x"78085574",x"762e8938",x"80c3518a",x"a02dff39",x"a0840855",x"74fba084",x"9e802e89",x"3880c251",x"8aa02dff",x"399b8851",x"8ac02d80",x"d00a7008",x"70ffbf06",x"720c5656",x"8a852d8c",x"942dff3d",x"0d9bcc08",x"81119bcc",x"0c518390",x"0a700870",x"feff0672",x"0c525283",x"3d0d0480",x"3d0d8b92",x"2d728180",x"07518ae3",x"2d8ba72d",x"823d0d04",x"fe3d0d80",x"d0808084",x"538bfd2d",x"85730c80",x"730c7208",x"7081ff06",x"74535152",x"8be12d71",x"880c843d",x"0d04fc3d",x"0d768111",x"33821233",x"7181800a",x"29718480",x"80290583",x"14337082",x"80291284",x"16335271",x"05a08005",x"86168517",x"33575253",x"53555755",x"53ff1353",x"72ff2e91",x"38737081",x"05553352",x"71757081",x"055734e9",x"3989518e",x"cf2d863d",x"0d04f93d",x"0d795780",x"d0808084",x"568bfd2d",x"81173382",x"18337182",x"80290553",x"5371802e",x"94388517",x"72555372",x"70810554",x"33760cff",x"145473f3",x"38831733",x"84183371",x"82802905",x"56528054",x"73752797",x"38735877",x"760c7614",x"76085353",x"71733481",x"14547474",x"26ed3875",x"518be12d",x"8b922d81",x"84518ae3",x"2d74882a",x"518ae32d",x"74518ae3",x"2d805473",x"75278f38",x"76147033",x"52528ae3",x"2d811454",x"ee398ba7",x"2d893d0d",x"04f93d0d",x"795680d0",x"80808455",x"8bfd2d86",x"750c7451",x"8be12d8b",x"fd2d81ad",x"70760c81",x"17338218",x"33718280",x"29058319",x"33780c84",x"1933780c",x"85193378",x"0c595353",x"80547377",x"27b33872",x"5873802e",x"87388bfd",x"2d77750c",x"73168611",x"33760c87",x"1133760c",x"5274518b",x"e12d8ee4",x"2d880881",x"065271f6",x"38821454",x"767426d1",x"388bfd2d",x"84750c74",x"518be12d",x"8b922d81",x"87518ae3",x"2d8ba72d",x"893d0d04",x"fc3d0d76",x"81113382",x"12337190",x"2b71882b",x"07831433",x"70720788",x"2b841633",x"71075152",x"53575754",x"5288518e",x"cf2d81ff",x"518aa02d",x"80c48080",x"84537208",x"70812a70",x"81065151",x"5271f338",x"73848080",x"0780c480",x"80840c86",x"3d0d04fe",x"3d0d8ee4",x"2d880888",x"08810653",x"5371f338",x"8b922d81",x"83518ae3",x"2d72518a",x"e32d8ba7",x"2d843d0d",x"04fe3d0d",x"800b9bcc",x"0c8b922d",x"8181518a",x"e32d9aec",x"538f5272",x"70810554",x"33518ae3",x"2dff1252",x"71ff2e09",x"8106ec38",x"8ba72d84",x"3d0d04fe",x"3d0d800b",x"9bcc0c8b",x"922d8182",x"518ae32d",x"80d08080",x"84528bfd",x"2d81f90a",x"0b80d080",x"809c0c71",x"08725253",x"8be12d72",x"9bd40c72",x"902a518a",x"e32d9bd4",x"08882a51",x"8ae32d9b",x"d408518a",x"e32d8ee4",x"2d880851",x"8ae32d8b",x"a72d843d",x"0d04803d",x"0d810b9b",x"d00c800b",x"83900a0c",x"85518ecf",x"2d823d0d",x"04803d0d",x"800b9bd0",x"0c8bc82d",x"86518ecf",x"2d823d0d",x"04fd3d0d",x"80d08080",x"84548a51",x"8ecf2d8b",x"fd2d9bc0",x"7452538c",x"a32d7288",x"08101091",x"c0840571",x"70840553",x"0c52fb80",x"84a1ad72",x"0c9aec0b",x"88140c73",x"518be12d",x"8a852d8c",x"942dffab",x"3d0d800b",x"9bd00c80",x"0b9bcc0c",x"800b8eb2",x"0ba0800c",x"5780c480",x"80845584",x"80b0750c",x"80c88080",x"a453fbff",x"ff730870",x"7206750c",x"535480c8",x"80809470",x"08707606",x"720c5353",x"880b80c0",x"8080840c",x"900a5381",x"730c9ba0",x"518ac02d",x"8bc82dfe",x"88880b80",x"dc808084",x"0c81f20b",x"80d00a0c",x"80d08080",x"84705252",x"8be12d8b",x"fd2d7151",x"8be12d8b",x"fd2d8472",x"0c71518b",x"e12d7677",x"7675933d",x"41415b5b",x"5b83d00a",x"5c780870",x"81065152",x"719d389b",x"d0085372",x"f0389bcc",x"085287e8",x"7227e638",x"727e0c72",x"83900a0c",x"988d2d82",x"900a0853",x"79802e81",x"b4387280",x"fe2e0981",x"0680f438",x"76802ec1",x"38807d78",x"58565a82",x"7727ffb5",x"3883ffff",x"7c0c79fe",x"18535379",x"72279838",x"80dc8080",x"88725558",x"74137033",x"790c5281",x"13537373",x"26f238ff",x"16701654",x"7505ff05",x"70337433",x"7072882b",x"077f0853",x"51555152",x"71732e09",x"8106feed",x"38743353",x"728a26fe",x"e4387210",x"109ac005",x"75527008",x"5152712d",x"fed33972",x"80fd2e09",x"81068638",x"815bfec5",x"3976829f",x"269e387a",x"802e8738",x"8073a032",x"545b80d7",x"3d7705fd",x"e0055272",x"72348117",x"57fea239",x"805afe9d",x"397280fe",x"2e098106",x"fe933879",x"57ff7c0c",x"81775c5a",x"fe8739ff",x"3d0d8052",x"805194ee",x"2d833d0d",x"0480fff8",x"0d8cfd04",x"80fff80d",x"a0880488",x"0880c080",x"808808a0",x"80082d50",x"880c810b",x"900a0c04",x"fb3d0d77",x"79555580",x"56757524",x"ab388074",x"249d3880",x"53735274",x"5180e13f",x"88085475",x"802e8538",x"88083054",x"73880c87",x"3d0d0473",x"30768132",x"5754dc39",x"74305581",x"56738025",x"d238ec39",x"fa3d0d78",x"7a575580",x"57767524",x"a438759f",x"2c548153",x"75743274",x"31527451",x"9b3f8808",x"5476802e",x"85388808",x"30547388",x"0c883d0d",x"04743055",x"8157d739",x"fc3d0d76",x"78535481",x"53807473",x"26525572",x"802e9838",x"70802ea9",x"38807224",x"a4387110",x"73107572",x"26535452",x"72ea3873",x"51788338",x"74517088",x"0c863d0d",x"0472812a",x"72812a53",x"5372802e",x"e6387174",x"26ef3873",x"72317574",x"0774812a",x"74812a55",x"555654e5",x"39ff3d0d",x"9bdc0bfc",x"05700852",x"5270ff2e",x"9138702d",x"fc127008",x"525270ff",x"2e098106",x"f138833d",x"0d0404ee",x"ee3f0400",x"00ffffff",x"ff00ffff",x"ffff00ff",x"ffffff00",x"00000979",x"000009ab",x"00000953",x"000007de",x"00000a02",x"00000a19",x"00000871",x"00000900",x"0000078a",x"00000a2d",x"01090460",x"00002f80",x"057bcf00",x"b4010f00",x"43500d0a",x"00000000",x"534c4b00",x"4c6f6164",x"65642c20",x"73746172",x"74696e67",x"2e2e2e0d",x"0a000000",x"0d0a5a50",x"55494e4f",x"0d0a0000",x"00000000",x"00000000",x"00000000",x"00000de4",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"ffffffff",x"00000000",x"ffffffff",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000");

begin

  process (clk)
  begin
    if rising_edge(clk) then
      if ENA='1' then
        if WEA='1' then
          RAM(conv_integer(ADDRA) ) := DIA;
        end if;
        DOA <= RAM(conv_integer(ADDRA)) ;
      end if;
    end if;
  end process;  

  process (clk)
  begin
    if rising_edge(clk) then
      if ENB='1' then
        if WEB='1' then
          RAM( conv_integer(ADDRB) ) := DIB;
        end if;
        DOB <= RAM(conv_integer(ADDRB)) ;
      end if;
    end if;
  end process;  
end behave;