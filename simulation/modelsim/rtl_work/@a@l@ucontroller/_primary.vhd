library verilog;
use verilog.vl_types.all;
entity ALUcontroller is
    port(
        val1            : in     vl_logic_vector(15 downto 0);
        val2            : in     vl_logic_vector(15 downto 0);
        output3         : out    vl_logic_vector(15 downto 0);
        opFlag          : in     vl_logic_vector(8 downto 0);
        flags           : out    vl_logic_vector(5 downto 0)
    );
end ALUcontroller;
