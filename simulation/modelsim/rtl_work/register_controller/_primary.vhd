library verilog;
use verilog.vl_types.all;
entity register_controller is
    port(
        chip_enable     : in     vl_logic;
        write_enable    : in     vl_logic;
        clock           : in     vl_logic;
        address         : in     vl_logic_vector(3 downto 0);
        valueIn         : in     vl_logic_vector(15 downto 0);
        valueOut        : out    vl_logic_vector(15 downto 0)
    );
end register_controller;
