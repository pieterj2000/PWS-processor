library verilog;
use verilog.vl_types.all;
entity instructie_decoder is
    port(
        instructie      : in     vl_logic_vector(7 downto 0);
        clock           : in     vl_logic;
        argument1       : in     vl_logic_vector(15 downto 0);
        argument2       : in     vl_logic_vector(15 downto 0);
        outputArgument  : out    vl_logic_vector(15 downto 0)
    );
end instructie_decoder;
