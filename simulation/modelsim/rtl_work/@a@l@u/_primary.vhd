library verilog;
use verilog.vl_types.all;
entity ALU is
    port(
        a1              : in     vl_logic_vector(7 downto 0);
        a2              : in     vl_logic_vector(7 downto 0);
        \out\           : out    vl_logic_vector(7 downto 0);
        opFlag          : in     vl_logic_vector(5 downto 0);
        eFlag           : in     vl_logic;
        cin             : in     vl_logic;
        cout            : out    vl_logic
    );
end ALU;
