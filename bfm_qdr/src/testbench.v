`timescale 1ns / 10ps

module testbench;

//AXI4 signals width definition
`define D_AXI4_DATA_SIZE     64
`define D_AXI4_ADDRESS_WIDTH 48
`define D_AXI4_ID_WIDTH      8
`define D_AXI4_BURST_LENGHT  1

//Master BFM context established via hierarchical substitution
`define mst_bfm testbench.DUT.TOP_Module_i.Ax_Axi4MasterBFM_0.inst

//generated clocks and resets timing declaration
parameter AXIclockLow  = 5;
parameter AXIclockHigh = 5;
parameter QDRclockLow  = 2.5;
parameter QDRclockHigh = 2.5;
parameter NUM_OF_EDGES_RESETn = 100;
parameter NUM_OF_EDGES_RESET = 50;

reg ACLK;
reg ARESETn;
reg clk_n;
reg clk_p;
reg rst;
reg JTAG_tck;
reg JTAG_tdi;
reg JTAG_tdo;
reg JTAG_tms;
reg ODT;
reg ZQ;
reg calib_done;

integer                          i, iterations;
//-------------------MASTER0-------------------//
reg [7:0]                        alen       = `D_AXI4_BURST_LENGHT-1;
reg [`D_AXI4_DATA_SIZE-1:0]      wdata;
reg [`D_AXI4_DATA_SIZE-1:0]      rdata;
reg [`D_AXI4_ADDRESS_WIDTH-1:0]	 awaddr = 'h0;
reg [`D_AXI4_ADDRESS_WIDTH-1:0]	 araddr = 'h0;
reg [(`D_AXI4_DATA_SIZE/8)-1:0]  strb;
reg[`D_AXI4_ID_WIDTH-1:0]        id         = 'b1;
reg[2:0]                         asize      = $clog2(`D_AXI4_DATA_SIZE>>2)-1;
reg[3:0]                         rresp      = 'b0;
reg                              rlast      = 'b0; 
reg[1:0]                         bresp      = 'b0;
reg                              user     	 = 'b0;
reg                              mst_status = 'b0;

reg res;

//Function checking data matching after every write/read operation
function reg check_data;
	reg res;
	begin
		res=0;
        if (wdata !== rdata)
        begin
            $display("AXI4 wdata=%h rdata=%h",wdata, rdata);
            res = 1'b1;
        end
		check_data = res;
	end
endfunction

TOP_Module_wrapper DUT(
	.ACLK_0(ACLK),
    .ARESETn_0(ARESETn),
    .JTAG_0_tck(JTAG_tck),
    .JTAG_0_tdi(JTAG_tdi),
    .JTAG_0_tdo(JTAG_tdo),
    .JTAG_0_tms(JTAG_tms),
    .ODT_0(ODT),
    .QVLD_0(QVLD),
    .ZQ_0(ZQ),
    .clk_n_0(clk_n),
    .clk_p_0(clk_p),
    .init_calib_complete_0(calib_done),
    .reset_0(rst)
);

//other unused signals initalization
initial begin
    JTAG_tck <= 0;
    JTAG_tdi <= 0;
    JTAG_tms <= 0;
    ODT <= 0;
    ZQ <= 0;
end

// axi reset
initial begin
    ARESETn = 0;
    repeat (NUM_OF_EDGES_RESETn) @(posedge ACLK);
    ARESETn = 1;
end

// axi clock generation
initial begin
    ACLK <= 0;
    #AXIclockHigh;
    forever begin
        #AXIclockLow ACLK <= 1;
        #AXIclockHigh ACLK <= 0;
    end
end

//controller reset
initial begin
    rst = 1;
    repeat (NUM_OF_EDGES_RESET) @(posedge clk_p);
    rst = 0;
end

//controller differential clock generation
initial begin
    clk_p <= 0;
    clk_n <= 1;
    #QDRclockHigh;
    forever begin
        #QDRclockLow 
        clk_p <= 1;
        clk_n <= 0;
        #QDRclockHigh 
        clk_p <= 0;
        clk_n <= 1;
    end
end

//main testbench routine
initial begin
    @(calib_done === 1); //waiting for memory initialization
    
    iterations = 'd10;
    wdata = 'h0;
    rdata = 'd0;
    strb = 'hFF;
    
    for (i=0; i<iterations; i=i+1)
	begin
		wdata = 'h0 + i + 'hDEADBEEF - iterations + 1;
		
		awaddr = 'h0 + i; //incremental r/w address selection
		araddr = 'h0 + i;
		
		//Below are the functions responsible for a single BFM AXI4 transaction.
		//Those functions come from Aldec's AXI4 BFM API and are refferring
		//to a specific BFM module instantion via hierarchical substitution.
		
		//A write transaction address is being established
		`mst_bfm.BfmWriteAddress(id, awaddr, 'h0, alen, asize, 'd1, 'd0, 'd0, 'd0, 'd0, 'd0);
		//Write data is being transferred.
		`mst_bfm.BfmWriteData( wdata, strb, alen, user);
		//The BFM module is waiting for slave response.
		`mst_bfm.BfmWaitForWriteResponse(id, bresp, user);
		//A read transaction address is being established.
		`mst_bfm.BfmReadAddress(id, araddr, 'h0, alen, asize, 'd1, 'd0, 'd0, 'd0, 'd0, 'd0);
		//The BFM module is waiting for slave response. Read data is transferred.
		`mst_bfm.BfmWaitForReadResponse(id, rresp, rdata, rlast, user);
		
		//after transaction a pair of read/write data is being checked for compatibility
		res=check_data();
		
		if (res)
		begin
			$display("ERROR on data checking - bfm_master0 to slave0; iteration=%d", i + 1);
			mst_status = 1;
		end
		
		//result of transaction is being displayed on a console
		if (!mst_status)
		    $display("test passed iteration: %02d wdata: 0x%h, rdata: 0x%h", i+1, wdata, rdata);
		else
		    $display("test failed");	
	end
	//end of stimulus after every iteration passed
	$finish;

end


endmodule
