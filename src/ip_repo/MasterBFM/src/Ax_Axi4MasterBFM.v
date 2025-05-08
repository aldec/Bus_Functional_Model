/* 
* ******************************************************************************
* Copyright (C) Aldec, Inc.
* This document, and all data and information contained therein, is
* confidential and proprietary information of Aldec, Inc. In acceptance of
* this material, recipient agrees all data and disclosures will be held in
* confidence and will not be copied, reproduced, or transmitted in whole or
* in part, nor its contents revealed in any manner to others without the
* express written permission of Aldec, Inc.
* 
* This technology was exported from the United States in accordance with
* the Export Administration Regulations.
* ******************************************************************************
* 
* @file Ax_Axi4MasterBfm.v
* @brief 
* @author Wojtek Lewandowski
* @version 2.0.0
* @date 2016-08-01
* 
* ******************************************************************************
*/

`timescale 1ns/1ps 

module Ax_Axi4MasterBFM
#(
    parameter DATA_BUS_WIDTH = 32,
    parameter ADDRESS_WIDTH=32,
    parameter ID_WIDTH=4,
    parameter AWUSER_BUS_WIDTH=1,
    parameter ARUSER_BUS_WIDTH=1,
    parameter RUSER_BUS_WIDTH=1,
    parameter WUSER_BUS_WIDTH=1,
    parameter BUSER_BUS_WIDTH=1
)
(
    input                             ACLK,
    input                             ARESETn,
    output reg [ID_WIDTH-1:0]         AWID,
    output reg [ADDRESS_WIDTH-1:0]    AWADDR,
    output reg [3:0]                  AWREGION,
    output reg [7:0]                  AWLEN,
    output reg [2:0]                  AWSIZE,
    output reg [1:0]                  AWBURST,
    output reg                        AWLOCK,
    output reg [3:0]                  AWCACHE,
    output reg [2:0]                  AWPROT,
    output reg [3:0]                  AWQOS,
    output reg [AWUSER_BUS_WIDTH-1:0] AWUSER,
    output reg                        AWVALID,
    input                             AWREADY,
    output reg [DATA_BUS_WIDTH-1:0]   WDATA,
    output reg [DATA_BUS_WIDTH/8-1:0] WSTRB,
    output reg                        WLAST,
    output reg [WUSER_BUS_WIDTH-1:0]  WUSER,
    output reg                        WVALID,
    input                             WREADY,
    input  [ID_WIDTH-1:0]             BID,
    input  [1:0]                      BRESP,
    input  [BUSER_BUS_WIDTH-1:0]      BUSER,
    input                             BVALID,
    output reg                        BREADY,
    output reg [ID_WIDTH-1:0]         ARID,
    output reg [ADDRESS_WIDTH-1:0]    ARADDR,
    output reg [3:0]                  ARREGION,
    output reg [7:0]                  ARLEN,
    output reg [2:0]                  ARSIZE,
    output reg [1:0]                  ARBURST,
    output reg                        ARLOCK,
    output reg [3:0]                  ARCACHE,
    output reg [2:0]                  ARPROT,
    output reg [3:0]                  ARQOS,
    output reg [ARUSER_BUS_WIDTH-1:0] ARUSER,
    output reg                        ARVALID,
    input                              ARREADY,
    input  [ID_WIDTH-1:0]              RID,
    input  [DATA_BUS_WIDTH-1:0]        RDATA,
    input  [1:0]                       RRESP,
    input  [RUSER_BUS_WIDTH-1:0]       RUSER,
    input                              RLAST,
    input                              RVALID,
    output reg                        RREADY
);
`ifdef ALDEC_DPI
  `include "dpiwrap_master.v"
`endif
localparam MAX_BURST_SIZE = (((4*1024*8)/DATA_BUS_WIDTH)>256) ? 256 : ((4*1024*8)/DATA_BUS_WIDTH);

/**
* @brief Disable warning reporting
*
* @param disabled - 1/0 - disabled/enabled
*
* @return
*/
function BfmSetWarningDisabled;
input disabled;
begin
    BfmSetWarningDisabled = axi_mst_bfm_core.SetWarningDisabled(disabled);
end
endfunction
/**
* @brief BfmWriteAddress
*
* @param awid    - axi signal 
* @param awaddr  - axi signal 
* @param awregion- axi signal
* @param awlen   - axi signal  
* @param awsize  - axi signal  
* @param awburst - axi signal  
* @param awlock  - axi signal  
* @param awcache - axi signal  
* @param awprot  - axi signal  
* @param awqos   - axi signal
*
*/
task automatic BfmWriteAddress( input [ID_WIDTH-1:0] awid, 
                   input [ADDRESS_WIDTH-1:0] awaddr, 
                   input [3:0] awregion,
                   input [7:0] awlen, 
                   input [2:0] awsize, 
                   input [1:0] awburst, 
                   input       awlock, 
                   input [3:0] awcache,
                   input [2:0] awprot,
                   input [3:0] awqos,
                   input [AWUSER_BUS_WIDTH-1:0] awuser);

    axi_mst_bfm_core.WriteAddress(awid,awaddr,awregion,awlen,awsize,awburst,awlock,awcache,awprot,awqos,awuser);

endtask

/**
* @brief BfmReadAddress
*
* @param arid    - axi signal 
* @param araddr  - axi signal  
* @param arregion- axi signal 
* @param arlen   - axi signal  
* @param arsize  - axi signal  
* @param arburst - axi signal  
* @param arlock  - axi signal  
* @param arcache - axi signal  
* @param arprot  - axi signal  
* @param arqos   - axi signal
*
*/
task automatic BfmReadAddress( input [ID_WIDTH-1:0] arid, 
                   input [ADDRESS_WIDTH-1:0] araddr, 
                   input [3:0] arregion,
                   input [7:0] arlen, 
                   input [2:0] arsize, 
                   input [1:0] arburst, 
                   input       arlock, 
                   input [3:0] arcache, 
                   input [2:0] arprot,
                   input [3:0] arqos,
                   input [ARUSER_BUS_WIDTH-1:0] aruser);
				   
    axi_mst_bfm_core.ReadAddress(arid,araddr,arregion,arlen,arsize,arburst,arlock,arcache,arprot,arqos, aruser);

endtask

/**
* @brief BfmWriteData
*
* @param wdata  - axi signal 
* @param wstrb  - axi signal 
* @param wlast  - axi signal   
*
*/
task automatic BfmWriteData( input reg [DATA_BUS_WIDTH-1:0] wdata, 
                   input reg [(DATA_BUS_WIDTH/8)-1:0] wstrb, 
                   input wlast,
                   input [WUSER_BUS_WIDTH-1:0] wuser);

    axi_mst_bfm_core.WriteData(wdata, wstrb, wlast,wuser);

endtask

task automatic BfmWriteDataBurst(input reg [256*DATA_BUS_WIDTH-1:0] wdata, 
                   input reg [256*(DATA_BUS_WIDTH/8)-1:0] wstrb, 
                   input integer burst_length,
                   input [WUSER_BUS_WIDTH-1:0] wuser);

    axi_mst_bfm_core.WriteDataBurst(wdata, wstrb, burst_length,wuser);

endtask

/**
* @brief BfmWaitForWriteResponse
*
* @param bid    - axi signal 
* @param bresp  - axi signal 
*
*/
task automatic BfmWaitForWriteResponse(output [ID_WIDTH-1:0] bid, 
                             output [1:0] bresp,
                             output [BUSER_BUS_WIDTH-1:0] buser);

    axi_mst_bfm_core.WaitForWriteResponse(bid, bresp, buser);

endtask

/**
* @brief BfmWaitForReadResponse
*
* @param rid    - axi signal 
* @param rresp  - axi signal 
* @param rdata  - axi signal 
* @param rlast  - axi signal 
*
*/
task automatic BfmWaitForReadResponse(output [ID_WIDTH-1:0] rid, 
                            output [1:0] rresp, 
                            output [DATA_BUS_WIDTH-1:0] rdata, 
                            output rlast,
                            output [RUSER_BUS_WIDTH-1:0] ruser);

    axi_mst_bfm_core.WaitForReadResponse(rid, rresp, rdata, rlast, ruser);

endtask

/**
* @brief BfmWaitForReadBurst
*
* @param rid    - axi signal 
* @param rresp  - axi signal 
* @param rdata  - axi signal 
* @param rlast  - axi signal 
*
*/
task automatic BfmWaitForReadBurst(output [ID_WIDTH-1:0] rid, 
                         output [1:0] rresp, 
                         output [MAX_BURST_SIZE*DATA_BUS_WIDTH-1:0] rdata, 
                         output rlast,
                         input integer burst_length,
                         output [RUSER_BUS_WIDTH-1:0] ruser);

    axi_mst_bfm_core.WaitForReadBurst(rid, rresp, rdata, rlast, burst_length, ruser);

endtask

/**************************************************************************************/
/*********************************** XILINX WRAPPER ***********************************/
/**************************************************************************************/
reg [MAX_BURST_SIZE*(DATA_BUS_WIDTH/8)-1:0] STROBE_VEC;
initial
begin : ini
	integer a;
	for (a=0; a<(MAX_BURST_SIZE*(DATA_BUS_WIDTH/8)); a=a+1)
	begin
		STROBE_VEC[a]= 'b1;
	end
end

task automatic SEND_WRITE_ADDRESS(input [ID_WIDTH-1:0] ID, 
                        input [ADDRESS_WIDTH-1:0] ADDR, 
                        input [7:0] LEN, 
                        input [2:0] SIZE, 
                        input [1:0] BURST, 
                        input       LOCK, 
                        input [3:0] CACHE, 
                        input [2:0] PROT, 
                        input [3:0] REGION, 
                        input [3:0] QOS, 
                        input [AWUSER_BUS_WIDTH-1:0] AWUSER);
    BfmWriteAddress(ID,ADDR,REGION,LEN,SIZE,BURST,LOCK,CACHE,PROT,QOS,AWUSER);
endtask

task automatic SEND_WRITE_DATA(input reg [(DATA_BUS_WIDTH/8)-1:0] STROBE,
                     input reg [DATA_BUS_WIDTH-1:0] DATA,
                     input LAST,
                     input [WUSER_BUS_WIDTH-1:0] WUSER);
    BfmWriteData(DATA, STROBE, LAST, WUSER);
endtask

task automatic SEND_READ_ADDRESS(input [ID_WIDTH-1:0] ID, 
                       input [ADDRESS_WIDTH-1:0] ADDR, 
                       input [7:0] LEN, 
                       input [2:0] SIZE, 
                       input [1:0] BURST, 
                       input       LOCK, 
                       input [3:0] CACHE, 
                       input [2:0] PROT, 
                       input [3:0] REGION, 
                       input [3:0] QOS, 
                       input [ARUSER_BUS_WIDTH-1:0] ARUSER);
    BfmReadAddress(ID,ADDR,REGION,LEN,SIZE,BURST,LOCK,CACHE,PROT,QOS,ARUSER);
endtask

task automatic RECEIVE_READ_DATA(input  [ID_WIDTH-1:0] ID,
                       output [DATA_BUS_WIDTH-1:0] DATA,
                       output [1:0] RESPONSE,
                       output LAST, 
                       output [RUSER_BUS_WIDTH-1:0] RUSER);
    axi_mst_bfm_core.ReceiveReadData(ID, RESPONSE, DATA, LAST, RUSER);
endtask

task automatic RECEIVE_WRITE_RESPONSE(input  [ID_WIDTH-1:0] ID,
                            output [1:0] RESPONSE,
                            output [BUSER_BUS_WIDTH-1:0] BUSER);
    axi_mst_bfm_core.ReceiveWriteResponse(ID, RESPONSE, BUSER);
endtask

task automatic RECEIVE_READ_BURST(input [ID_WIDTH-1:0] ID, 
                        input [ADDRESS_WIDTH-1:0] ADDR, 
                        input [7:0] LEN, 
                        input [2:0] SIZE, 
                        input [1:0] BURST, 
                        input       LOCK,
                        output [MAX_BURST_SIZE*DATA_BUS_WIDTH-1:0] DATA,
                        output [(MAX_BURST_SIZE*2)-1:0] RESPONSE,
                        output [RUSER_BUS_WIDTH-1:0] RUSER);
begin:rcv_rd_brst
    reg [MAX_BURST_SIZE*DATA_BUS_WIDTH-1:0] DATA_realigned;
    reg [15:0] DATASIZE;
    SEND_READ_ADDRESS(ID,ADDR,LEN,SIZE,BURST,LOCK,4'b0,3'b0, 4'b0,4'b0,1'b0);
    axi_mst_bfm_core.ReceiveReadBurst(ID, RESPONSE, DATA, LEN+1, RUSER);
	axi_mst_bfm_core.prepare_wstrb( STROBE_VEC,ADDR[31:0],BURST,SIZE,LEN,DATA_BUS_WIDTH);
    axi_mst_bfm_core.realign_data ( STROBE_VEC, 0, LEN, DATA, DATA_realigned, DATASIZE);
    DATA=DATA_realigned;
end
endtask

task automatic SEND_WRITE_BURST(input [ID_WIDTH-1:0] ID, 
                      input [ADDRESS_WIDTH-1:0] ADDR, 
                      input [7:0] LEN, 
                      input [2:0] SIZE, 
                      input [1:0] BURST, 
                      input       LOCK,
                      input [MAX_BURST_SIZE*DATA_BUS_WIDTH-1:0] DATA,
                      input [15:0] DATASIZE,
                      input [WUSER_BUS_WIDTH-1:0] WUSER);
begin:sndwrbrst
    reg [MAX_BURST_SIZE*DATA_BUS_WIDTH-1:0] DATA_realigned;
	axi_mst_bfm_core.prepare_wstrb( STROBE_VEC,ADDR[31:0],BURST,SIZE,LEN,DATA_BUS_WIDTH);
    axi_mst_bfm_core.realign_data ( STROBE_VEC, 1, LEN, DATA, DATA_realigned, DATASIZE);
    axi_mst_bfm_core.WriteDataBurst(DATA_realigned,STROBE_VEC,LEN+1,WUSER);
end
endtask

task automatic READ_BURST(input [ID_WIDTH-1:0] ID, 
                input [ADDRESS_WIDTH-1:0] ADDR, 
                input [7:0] LEN, 
                input [2:0] SIZE, 
                input [1:0] BURST, 
                input       LOCK,
                input [3:0] CACHE,
                input [2:0] PROT, 
                input [3:0] REGION, 
                input [3:0] QOS, 
                input [ARUSER_BUS_WIDTH-1:0] ARUSER,
                output [MAX_BURST_SIZE*DATA_BUS_WIDTH-1:0] DATA,
                output [(MAX_BURST_SIZE*2)-1:0] RESPONSE,
                output [RUSER_BUS_WIDTH-1:0] RUSER);
begin:rdbrst
    reg [MAX_BURST_SIZE*DATA_BUS_WIDTH-1:0] DATA_realigned;
    reg [15:0] DATASIZE;
    SEND_READ_ADDRESS(ID,ADDR,LEN,SIZE,BURST,LOCK,CACHE,PROT, REGION, QOS, ARUSER);
    axi_mst_bfm_core.ReceiveReadBurst(ID, RESPONSE, DATA, LEN+1, RUSER);
	axi_mst_bfm_core.prepare_wstrb( STROBE_VEC,ADDR[31:0],BURST,SIZE,LEN,DATA_BUS_WIDTH);
    axi_mst_bfm_core.realign_data ( STROBE_VEC, 0, LEN, DATA, DATA_realigned, DATASIZE);
    DATA=DATA_realigned;
end
endtask

task automatic WRITE_BURST(input [ID_WIDTH-1:0] ID, 
                 input [ADDRESS_WIDTH-1:0] ADDR, 
                 input [7:0] LEN, 
                 input [2:0] SIZE, 
                 input [1:0] BURST, 
                 input       LOCK,
                 input [3:0] CACHE,
                 input [2:0] PROT,
                 input [MAX_BURST_SIZE*DATA_BUS_WIDTH-1:0] DATA,
                 input [15:0] DATASIZE,
                 input [3:0] REGION, 
                 input [3:0] QOS, 
                 input [AWUSER_BUS_WIDTH-1:0] AWUSER,
                 input [WUSER_BUS_WIDTH-1:0] WUSER,
                 output [1:0] RESPONSE, 
                 output [BUSER_BUS_WIDTH-1:0] BUSER);
begin:wrbrst
    reg [MAX_BURST_SIZE*DATA_BUS_WIDTH-1:0] DATA_realigned;
	axi_mst_bfm_core.prepare_wstrb( STROBE_VEC,ADDR[31:0],BURST,SIZE,LEN,DATA_BUS_WIDTH);
    axi_mst_bfm_core.realign_data ( STROBE_VEC, 1, LEN, DATA, DATA_realigned, DATASIZE);
    BfmWriteAddress(ID,ADDR,REGION,LEN,SIZE,BURST,LOCK,CACHE,PROT,QOS,AWUSER);
    axi_mst_bfm_core.WriteDataBurst(DATA_realigned,STROBE_VEC,LEN+1,WUSER);
    axi_mst_bfm_core.ReceiveWriteResponse(ID, RESPONSE,BUSER);
end
endtask

`ifdef ALDEC_TLM_DPI
export "DPI-C" task WRITE_BURST_CONCURRENT;
task automatic WRITE_BURST_CONCURRENT(input bit [ID_WIDTH-1:0] ID, 
                 input bit [ADDRESS_WIDTH-1:0] ADDR, 
                 input bit [7:0] LEN, 
                 input bit [2:0] SIZE, 
                 input bit [1:0] BURST, 
                 input bit       LOCK,
                 input bit [3:0] CACHE,
                 input bit [2:0] PROT,
                 input bit [MAX_BURST_SIZE*DATA_BUS_WIDTH-1:0] DATA,
                 input bit [MAX_BURST_SIZE*(DATA_BUS_WIDTH/8)-1:0] STROBE_VEC,
                 input bit [15:0] DATASIZE,
                 input bit [3:0] REGION, 
                 input bit [3:0] QOS, 
                 input bit [AWUSER_BUS_WIDTH-1:0] AWUSER,
                 input bit [WUSER_BUS_WIDTH-1:0] WUSER,
                 output bit [1:0] RESPONSE, 
                 output bit [BUSER_BUS_WIDTH-1:0] BUSER);
begin:wrbrstc
    fork
        begin
            BfmWriteAddress(ID,ADDR,REGION,LEN,SIZE,BURST,LOCK,CACHE,PROT,QOS,AWUSER);
        end
        begin
            axi_mst_bfm_core.WriteDataBurst(DATA,STROBE_VEC,LEN+1,WUSER);
        end
    join
end
endtask
`else
task automatic WRITE_BURST_CONCURRENT(input [ID_WIDTH-1:0] ID, 
                 input [ADDRESS_WIDTH-1:0] ADDR, 
                 input [7:0] LEN, 
                 input [2:0] SIZE, 
                 input [1:0] BURST, 
                 input       LOCK,
                 input [3:0] CACHE,
                 input [2:0] PROT,
                 input [MAX_BURST_SIZE*DATA_BUS_WIDTH-1:0] DATA,
                 input [15:0] DATASIZE,
                 input [3:0] REGION, 
                 input [3:0] QOS, 
                 input [AWUSER_BUS_WIDTH-1:0] AWUSER,
                 input [WUSER_BUS_WIDTH-1:0] WUSER,
                 output [1:0] RESPONSE, 
                 output [BUSER_BUS_WIDTH-1:0] BUSER);
begin:wrbrstc
    reg [MAX_BURST_SIZE*DATA_BUS_WIDTH-1:0] DATA_realigned;
	axi_mst_bfm_core.prepare_wstrb( STROBE_VEC,ADDR[31:0],BURST,SIZE,LEN,DATA_BUS_WIDTH);
    axi_mst_bfm_core.realign_data ( STROBE_VEC, 1, LEN, DATA, DATA_realigned, DATASIZE);
    fork
        begin
            BfmWriteAddress(ID,ADDR,REGION,LEN,SIZE,BURST,LOCK,CACHE,PROT,QOS,AWUSER);
        end
        begin
			axi_mst_bfm_core.WriteDataBurst(DATA_realigned,STROBE_VEC,LEN+1,WUSER);
        end
    join
    RECEIVE_WRITE_RESPONSE(ID,RESPONSE,BUSER);
end
endtask
`endif
/**************************************************************************************/
/****************************** END OF XILINX WRAPPER *********************************/
/**************************************************************************************/
defparam axi_mst_bfm_core.BFM_HIERARCHY = $sformatf("%m");

Ax_Axi4MasterBFMcore #(
    .DATA_BUS_WIDTH(DATA_BUS_WIDTH),
    .ADDRESS_WIDTH(ADDRESS_WIDTH),
    .ID_WIDTH(ID_WIDTH),
    .AWUSER_BUS_WIDTH(AWUSER_BUS_WIDTH),
    .ARUSER_BUS_WIDTH(ARUSER_BUS_WIDTH),
    .RUSER_BUS_WIDTH(RUSER_BUS_WIDTH),
    .WUSER_BUS_WIDTH(WUSER_BUS_WIDTH),
    .BUSER_BUS_WIDTH(BUSER_BUS_WIDTH),
    .MAX_BURST_SIZE(MAX_BURST_SIZE)
)
axi_mst_bfm_core (
    .ACLK(ACLK), 
    .ARESETn(ARESETn), 
    .AWID(AWID), 
    .AWADDR(AWADDR), 
    .AWREGION(AWREGION),
    .AWLEN(AWLEN), 
    .AWSIZE(AWSIZE), 
    .AWBURST(AWBURST), 
    .AWLOCK(AWLOCK), 
    .AWCACHE(AWCACHE), 
    .AWPROT(AWPROT), 
    .AWQOS(AWQOS),
    .AWUSER(AWUSER),
    .AWVALID(AWVALID), 
    .AWREADY(AWREADY), 
    .WDATA(WDATA), 
    .WSTRB(WSTRB), 
    .WLAST(WLAST), 
    .WUSER(WUSER),
    .WVALID(WVALID), 
    .WREADY(WREADY), 
    .BID(BID), 
    .BRESP(BRESP), 
    .BUSER(BUSER),
    .BVALID(BVALID), 
    .BREADY(BREADY), 
    .ARID(ARID), 
    .ARADDR(ARADDR), 
    .ARREGION(ARREGION),
    .ARLEN(ARLEN), 
    .ARSIZE(ARSIZE), 
    .ARBURST(ARBURST), 
    .ARLOCK(ARLOCK), 
    .ARCACHE(ARCACHE), 
    .ARPROT(ARPROT), 
    .ARQOS(ARQOS),
    .ARUSER(ARUSER),
    .ARVALID(ARVALID), 
    .ARREADY(ARREADY), 
    .RID(RID), 
    .RDATA(RDATA), 
    .RRESP(RRESP), 
    .RLAST(RLAST), 
    .RUSER(RUSER),
    .RVALID(RVALID), 
    .RREADY(RREADY)
);

`ifdef Ax_AlteraWrappers
//////////////////////////////// BFM ALTERA WRAPPER - SystemVerilog ///////////////////////////////////
import Ax_AlteraBFMWrapperPkg::*; 


function axi_transaction#(DATA_BUS_WIDTH, ADDRESS_WIDTH, ID_WIDTH) create_write_transaction( bit [ADDRESS_WIDTH-1:0] address, int length=0 );
    create_write_transaction = axi_mst_bfm_core.create_write_transaction(address, length);
endfunction

function axi_transaction#(DATA_BUS_WIDTH, ADDRESS_WIDTH, ID_WIDTH) create_read_transaction( bit [ADDRESS_WIDTH-1:0] address, int length=0 );
    create_read_transaction = axi_mst_bfm_core.create_read_transaction(address, length);
endfunction

task automatic execute_transaction(axi_transaction#(DATA_BUS_WIDTH, ADDRESS_WIDTH, ID_WIDTH) trans);
    axi_mst_bfm_core.execute_transaction(trans);
endtask

task automatic execute_write_addr_phase(axi_transaction#(DATA_BUS_WIDTH, ADDRESS_WIDTH, ID_WIDTH) trans);
    axi_mst_bfm_core.execute_write_addr_phase(trans);
endtask 

task automatic execute_read_addr_phase(axi_transaction#(DATA_BUS_WIDTH, ADDRESS_WIDTH, ID_WIDTH) trans);
    axi_mst_bfm_core.execute_read_addr_phase(trans);
endtask 

task automatic execute_write_data_burst(axi_transaction#(DATA_BUS_WIDTH, ADDRESS_WIDTH, ID_WIDTH) trans);
    axi_mst_bfm_core.execute_write_data_burst(trans);
endtask

task automatic execute_write_data_phase(axi_transaction#(DATA_BUS_WIDTH, ADDRESS_WIDTH, ID_WIDTH) trans,
                              int index=0,
                              input bit last);
    axi_mst_bfm_core.execute_write_data_phase(trans, index, last);
endtask

task automatic get_read_data_burst(axi_transaction#(DATA_BUS_WIDTH, ADDRESS_WIDTH, ID_WIDTH) trans);
    axi_mst_bfm_core.get_read_data_burst(trans);
endtask

task automatic get_read_data_phase(axi_transaction#(DATA_BUS_WIDTH, ADDRESS_WIDTH, ID_WIDTH) trans,
                         int index=0);
    axi_mst_bfm_core.get_read_data_phase(trans, index);
endtask

task automatic get_write_response_phase(axi_transaction#(DATA_BUS_WIDTH, ADDRESS_WIDTH, ID_WIDTH) trans);
    axi_mst_bfm_core.get_write_response_phase(trans);
endtask

task automatic get_read_addr_ready(output bit ready);
    axi_mst_bfm_core.get_read_addr_ready(ready);
endtask

task automatic get_read_data_cycle();
    axi_mst_bfm_core.get_read_data_cycle(); 
endtask

task automatic get_write_addr_ready(output bit ready);
    axi_mst_bfm_core.get_write_addr_ready(ready);
endtask

task automatic get_write_data_ready(output bit ready);
    axi_mst_bfm_core.get_write_data_ready(ready);
endtask

task automatic get_write_response_cycle();
    axi_mst_bfm_core.get_write_response_cycle(); 
endtask

task automatic execute_read_data_ready(bit ready);
    axi_mst_bfm_core.execute_read_data_ready(ready);
endtask

task automatic execute_write_resp_ready(bit ready);
    axi_mst_bfm_core.execute_write_resp_ready(ready);
endtask

task automatic wait_on(axi_wait_e phase, input int count=1);
    axi_mst_bfm_core.wait_on(phase, count);
endtask

//////////////////////////////// BFM ALTERA WRAPPER - SystemVerilog ///////////////////////////////////
`endif

`ifdef ALDEC_USE_TRANSACTIONS

	TransactionRecorderAxi4 #(
		.DATA_BUS_WIDTH(DATA_BUS_WIDTH),
		.ADDRESS_WIDTH(ADDRESS_WIDTH),
		.ID_WIDTH(ID_WIDTH),
		.AWUSER_BUS_WIDTH(AWUSER_BUS_WIDTH),
		.ARUSER_BUS_WIDTH(ARUSER_BUS_WIDTH),
		.RUSER_BUS_WIDTH(RUSER_BUS_WIDTH),
		.WUSER_BUS_WIDTH(WUSER_BUS_WIDTH),
		.BUSER_BUS_WIDTH(BUSER_BUS_WIDTH),
		.INSTANCE($sformatf("%m")))
	TransRecorder (
		.ACLK(ACLK), 
		.ARESETn(ARESETn), 
		.AWID(AWID), 
		.AWADDR(AWADDR), 
		.AWREGION(AWREGION), 
		.AWLEN(AWLEN), 
		.AWSIZE(AWSIZE), 
		.AWBURST(AWBURST), 
		.AWLOCK(AWLOCK), 
		.AWCACHE(AWCACHE), 
		.AWPROT(AWPROT), 
		.AWQOS(AWQOS), 
		.AWUSER(AWUSER), 
		.AWVALID(AWVALID), 
		.AWREADY(AWREADY), 
		.WDATA(WDATA), 
		.WSTRB(WSTRB), 
		.WLAST(WLAST), 
		.WUSER(WUSER), 
		.WVALID(WVALID), 
		.WREADY(WREADY), 
		.BID(BID), 
		.BRESP(BRESP), 
		.BUSER(BUSER), 
		.BVALID(BVALID), 
		.BREADY(BREADY), 
		.ARID(ARID), 
		.ARADDR(ARADDR), 
		.ARREGION(ARREGION), 
		.ARLEN(ARLEN), 
		.ARSIZE(ARSIZE), 
		.ARBURST(ARBURST), 
		.ARLOCK(ARLOCK), 
		.ARCACHE(ARCACHE), 
		.ARPROT(ARPROT), 
		.ARQOS(ARQOS), 
		.ARUSER(ARUSER), 
		.ARVALID(ARVALID), 
		.ARREADY(ARREADY), 
		.RID(RID), 
		.RDATA(RDATA), 
		.RRESP(RRESP), 
		.RUSER(RUSER), 
		.RLAST(RLAST), 
		.RVALID(RVALID), 
		.RREADY(RREADY)
	);

`endif //ALDEC_USE_TRANSACTIONS

endmodule
