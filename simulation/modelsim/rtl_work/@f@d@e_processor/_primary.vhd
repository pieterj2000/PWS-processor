library verilog;
use verilog.vl_types.all;
entity FDE_processor is
    port(
        clock           : in     vl_logic;
        led_pin         : out    vl_logic;
        led_register    : out    vl_logic_vector(7 downto 0);
        schakelaar_register: in     vl_logic_vector(7 downto 0);
        knoppen_register: in     vl_logic_vector(3 downto 0)
    );
end FDE_processor;
