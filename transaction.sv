`ifndef TRANSACTION_SV
`define TRANSACTION_SV

typedef enum bit [1:0] {readd = 0, writed = 1, rstdut = 2} oper_mode;

class transaction extends uvm_sequence_item;

  // Fields
  randc logic [7:0] addr;
  rand  logic [7:0] din;
        logic [7:0] dout;
  rand  oper_mode   op;
        logic       rst;
  rand  logic       miso;
        logic       cs;     
        logic       done;
        logic       err;
        logic       ready;
        logic       mosi;

  // Constraints
  constraint addr_c     { addr <= 31; }
  constraint data_c     { din < 100; }
  constraint addr_c_err { addr > 31; }

  // Factory
  `uvm_object_utils_begin(transaction)
    `uvm_field_int (addr, UVM_ALL_ON)
    `uvm_field_int (din, UVM_ALL_ON)
    `uvm_field_int (dout, UVM_ALL_ON)
    `uvm_field_int (ready, UVM_ALL_ON)
    `uvm_field_int (rst, UVM_ALL_ON)
    `uvm_field_int (done, UVM_ALL_ON)
    `uvm_field_int (miso, UVM_ALL_ON)
    `uvm_field_int (mosi, UVM_ALL_ON)
    `uvm_field_int (cs, UVM_ALL_ON)
    `uvm_field_int (err, UVM_ALL_ON)
    `uvm_field_enum(oper_mode, op, UVM_DEFAULT)
  `uvm_object_utils_end

  // Constructor
  function new(string name = "transaction");
    super.new(name);
  endfunction

  // do_copy: نسخ القيم من transaction أخرى
  virtual function void do_copy(uvm_object rhs);
    transaction tx;
    if (!$cast(tx, rhs)) begin
      `uvm_fatal("DO_COPY", "Casting failed in do_copy")
    end
    super.do_copy(rhs);
    this.addr  = tx.addr;
    this.din   = tx.din;
    this.dout  = tx.dout;
    this.op    = tx.op;
    this.rst   = tx.rst;
    this.miso  = tx.miso;
    this.cs    = tx.cs;
    this.done  = tx.done;
    this.err   = tx.err;
    this.ready = tx.ready;
    this.mosi  = tx.mosi;
  endfunction

  // convert2string: طباعة محتوى الترانزاكشن
  virtual function string convert2string();
    return $sformatf("addr=%0d, din=%0d, dout=%0d, op=%s, rst=%0b, miso=%0b, cs=%0b, done=%0b, err=%0b, ready=%0b, mosi=%0b",
                     addr, din, dout, op.name(), rst, miso, cs, done, err, ready, mosi);
  endfunction

endclass

`endif
