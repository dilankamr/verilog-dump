/**********************************************************************
 * Assigning structures a default value and values to named members
 *
 * Author: Stuart Sutherland
 *
 * (c) Copyright 2003, Sutherland HDL, Inc. *** ALL RIGHTS RESERVED ***
 * www.sutherland-hdl.com
 *
 * Used with permission in the book, "SystemVerilog for Design"
 *  By Stuart Sutherland, Simon Davidmann, and Peter Flake.
 *  Book copyright: 2003, Kluwer Academic Publishers, Norwell, MA, USA
 *  www.wkap.il, ISBN: 0-4020-7530-8
 *
 * Revision History:
 *   1.00 15 Dec 2003 -- original code, as included in book
 *   1.01 10 Jul 2004 -- cleaned up comments, added expected results
 *                       to output messages
 *
 * Caveat: Expected results displayed for this code example are based
 * on an interpretation of the SystemVerilog 3.1 standard by the code
 * author or authors.  At the time of writing, official SystemVerilog
 * validation suites were not available to validate the example.
 *
 * RIGHT TO USE: This code example, or any portion thereof, may be
 * used and distributed without restriction, provided that this entire
 * comment block is included with the example.
 *
 * DISCLAIMER: THIS CODE EXAMPLE IS PROVIDED "AS IS" WITHOUT WARRANTY
 * OF ANY KIND, EITHER EXPRESS OR IMPLIED, INCLUDING, BUT NOT LIMITED
 * TO WARRANTIES OF MERCHANTABILITY, FITNESS OR CORRECTNESS. IN NO
 * EVENT SHALL THE AUTHOR OR AUTHORS BE LIABLE FOR ANY DAMAGES,
 * INCLUDING INCIDENTAL OR CONSEQUENTIAL DAMAGES, ARISING OUT OF THE
 * USE OF THIS CODE.
 *********************************************************************/

module test;
  bit clock, resetN = 1;

  typedef struct {
    real r0, r1;
    int  i0, i1;
    bit  [15:0] opcode;
  } instruction_word_t;

  instruction_word_t IW;

  always @(posedge clock, negedge resetN)
    if (!resetN)
      IW = { real:1.0, default:0, r1:3.1415 };
      // assign all real members a default of 1.0
      // and all other members a default of 0
      // and member r1 a value of 3.1415
    else begin
      //...
    end

  always #5 clock = ~clock;

  initial begin
    @(negedge clock) resetN = 0;
    @(negedge clock) resetN = 1;
    @(negedge clock) $display("\nIW.i0=%0d, IW.r0=%1.1f, IW.r1=%1.4f (expect 0, 1.0, 3.1415)\n",
                              IW.i0, IW.r0, IW.r1);
    @(negedge clock) $finish;
  end
endmodule
