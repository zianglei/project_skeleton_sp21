`timescale 1ns / 1ns
`include "Opcode.vh"
module control_testbench;

  reg [6:0] opcode;
  wire ctrl_reg_write, ctrl_mem_write, ctrl_mem_read, ctrl_mem_to_reg, ctrl_pc_src;
  wire [1:0] ctrl_alu_src;
  CONTROL uut (
    .opcode(opcode),
    .reg_write(ctrl_reg_write),
    .alu_src(ctrl_alu_src),
    .mem_write(ctrl_mem_write),
    .mem_read(ctrl_mem_read),
    .mem_to_reg(ctrl_mem_to_reg),
    .pc_src(ctrl_pc_src)
  );

  task check_ctrl_signal;
    input [6:0] opcode;
    input expected, got;
    begin
      if (expected !== got) begin
        $display("opcode: %b, expected: %d, got: %d", opcode, expected, got);
        $finish;
      end else begin
        $display("opcode: %b, got: %d", opcode, got);
      end
    end
  endtask

  task check_ctrl_reg_write;
    begin
      $display("====Check RegWrite signal====");
      opcode = `OPC_ARI_ITYPE;
      #1 check_ctrl_signal(opcode, 1'b1, ctrl_reg_write);
      opcode = `OPC_ARI_RTYPE;
      #1 check_ctrl_signal(opcode, 1'b1, ctrl_reg_write);
      opcode = `OPC_LOAD;
      #1 check_ctrl_signal(opcode, 1'b1, ctrl_reg_write);
      opcode = `OPC_STORE;
      #1 check_ctrl_signal(opcode, 1'b0, ctrl_reg_write);
      opcode = `OPC_BRANCH;
      #1 check_ctrl_signal(opcode, 1'b0, ctrl_reg_write);
      opcode = `OPC_LUI;
      #1 check_ctrl_signal(opcode, 1'b1, ctrl_reg_write);
      opcode = `OPC_AUIPC;
      #1 check_ctrl_signal(opcode, 1'b1, ctrl_reg_write);
      opcode = `OPC_JAL;
      #1 check_ctrl_signal(opcode, 1'b1, ctrl_reg_write);
      opcode = `OPC_JALR;
      #1 check_ctrl_signal(opcode, 1'b1, ctrl_reg_write);
    end
  endtask

  task check_ctrl_alu_src;
    begin
      $display("====Check AluSrc signal====");
      opcode = `OPC_ARI_ITYPE;
      #1 check_ctrl_signal(opcode, 2'b01, ctrl_alu_src);
      opcode = `OPC_ARI_RTYPE;
      #1 check_ctrl_signal(opcode, 2'b00, ctrl_alu_src);
      opcode = `OPC_LOAD;
      #1 check_ctrl_signal(opcode, 2'b01, ctrl_alu_src);
      opcode = `OPC_STORE;
      #1 check_ctrl_signal(opcode, 2'b01, ctrl_alu_src);
      opcode = `OPC_BRANCH;
      #1 check_ctrl_signal(opcode, 2'b00, ctrl_alu_src);
      opcode = `OPC_LUI;
      #1 check_ctrl_signal(opcode, 2'b00, ctrl_alu_src);
      opcode = `OPC_AUIPC;
      #1 check_ctrl_signal(opcode, 2'b00, ctrl_alu_src);
      opcode = `OPC_JAL;
      #1 check_ctrl_signal(opcode, 2'b00, ctrl_alu_src);
      opcode = `OPC_JALR;
      #1 check_ctrl_signal(opcode, 2'b00, ctrl_alu_src); 
    end
  endtask

  task check_ctrl_mem_write;
    begin
      $display("====Check MemWrite signal====");
      opcode = `OPC_ARI_ITYPE;
      #1 check_ctrl_signal(opcode, 1'b0, ctrl_mem_write);
      opcode = `OPC_ARI_RTYPE;
      #1 check_ctrl_signal(opcode, 1'b0, ctrl_mem_write);
      opcode = `OPC_LOAD;
      #1 check_ctrl_signal(opcode, 1'b0, ctrl_mem_write);
      opcode = `OPC_STORE;
      #1 check_ctrl_signal(opcode, 1'b1, ctrl_mem_write);
      opcode = `OPC_BRANCH;
      #1 check_ctrl_signal(opcode, 1'b0, ctrl_mem_write);
      opcode = `OPC_LUI;
      #1 check_ctrl_signal(opcode, 1'b0, ctrl_mem_write);
      opcode = `OPC_AUIPC;
      #1 check_ctrl_signal(opcode, 1'b0, ctrl_mem_write);
      opcode = `OPC_JAL;
      #1 check_ctrl_signal(opcode, 1'b0, ctrl_mem_write);
      opcode = `OPC_JALR;
      #1 check_ctrl_signal(opcode, 1'b0, ctrl_mem_write); 
    end
  endtask

  task check_ctrl_mem_read;
    begin
      $display("====Check MemRead signal====");
      opcode = `OPC_ARI_ITYPE;
      #1 check_ctrl_signal(opcode, 1'b0, ctrl_mem_read);
      opcode = `OPC_ARI_RTYPE;
      #1 check_ctrl_signal(opcode, 1'b0, ctrl_mem_read);
      opcode = `OPC_LOAD;
      #1 check_ctrl_signal(opcode, 1'b1, ctrl_mem_read);
      opcode = `OPC_STORE;
      #1 check_ctrl_signal(opcode, 1'b0, ctrl_mem_read);
      opcode = `OPC_BRANCH;
      #1 check_ctrl_signal(opcode, 1'b0, ctrl_mem_read);
      opcode = `OPC_LUI;
      #1 check_ctrl_signal(opcode, 1'b0, ctrl_mem_read);
      opcode = `OPC_AUIPC;
      #1 check_ctrl_signal(opcode, 1'b0, ctrl_mem_read);
      opcode = `OPC_JAL;
      #1 check_ctrl_signal(opcode, 1'b0, ctrl_mem_read);
      opcode = `OPC_JALR;
      #1 check_ctrl_signal(opcode, 1'b0, ctrl_mem_read);  
    end
  endtask

  task check_ctrl_mem_to_reg;
    begin
      $display("====Check MemToReg signal====");
      opcode = `OPC_ARI_ITYPE;
      #1 check_ctrl_signal(opcode, 1'b0, ctrl_mem_to_reg);
      opcode = `OPC_ARI_RTYPE;
      #1 check_ctrl_signal(opcode, 1'b0, ctrl_mem_to_reg);
      opcode = `OPC_LOAD;
      #1 check_ctrl_signal(opcode, 1'b1, ctrl_mem_to_reg);
      opcode = `OPC_STORE;
      #1 check_ctrl_signal(opcode, 1'b0, ctrl_mem_to_reg);
      opcode = `OPC_BRANCH;
      #1 check_ctrl_signal(opcode, 1'b0, ctrl_mem_to_reg);
      opcode = `OPC_LUI;
      #1 check_ctrl_signal(opcode, 1'b0, ctrl_mem_to_reg);
      opcode = `OPC_AUIPC;
      #1 check_ctrl_signal(opcode, 1'b0, ctrl_mem_to_reg);
      opcode = `OPC_JAL;
      #1 check_ctrl_signal(opcode, 1'b0, ctrl_mem_to_reg);
      opcode = `OPC_JALR;
      #1 check_ctrl_signal(opcode, 1'b0, ctrl_mem_to_reg);   
    end
  endtask

  task check_ctrl_pc_src;
    begin
      $display("====Check PcSrc signal====");
      opcode = `OPC_ARI_ITYPE;
      #1 check_ctrl_signal(opcode, 1'b0, ctrl_pc_src);
      opcode = `OPC_ARI_RTYPE;
      #1 check_ctrl_signal(opcode, 1'b0, ctrl_pc_src);
      opcode = `OPC_LOAD;
      #1 check_ctrl_signal(opcode, 1'b0, ctrl_pc_src);
      opcode = `OPC_STORE;
      #1 check_ctrl_signal(opcode, 1'b0, ctrl_pc_src);
      opcode = `OPC_BRANCH;
      #1 check_ctrl_signal(opcode, 1'b1, ctrl_pc_src);
      opcode = `OPC_LUI;
      #1 check_ctrl_signal(opcode, 1'b0, ctrl_pc_src);
      opcode = `OPC_AUIPC;
      #1 check_ctrl_signal(opcode, 1'b0, ctrl_pc_src);
      opcode = `OPC_JAL;
      #1 check_ctrl_signal(opcode, 1'b0, ctrl_pc_src);
      opcode = `OPC_JALR;
      #1 check_ctrl_signal(opcode, 1'b0, ctrl_pc_src);   
    end
  endtask


  initial begin
    check_ctrl_reg_write();
    check_ctrl_alu_src();
    check_ctrl_mem_read();
    check_ctrl_mem_write();
    check_ctrl_mem_to_reg();
    check_ctrl_pc_src();
    $display("ALL CONTROL TESTS PASSED!");
    $finish;
  end

endmodule
