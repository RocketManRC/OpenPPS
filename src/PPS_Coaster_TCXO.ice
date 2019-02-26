{
  "version": "1.2",
  "package": {
    "name": "",
    "version": "",
    "description": "",
    "author": "",
    "image": ""
  },
  "design": {
    "board": "icestick",
    "graph": {
      "blocks": [
        {
          "id": "86d68a11-bf59-4f97-8290-ac5419f696cc",
          "type": "basic.input",
          "data": {
            "name": "CLK",
            "pins": [
              {
                "index": "0",
                "name": "CLK",
                "value": "21"
              }
            ],
            "virtual": false,
            "clock": false
          },
          "position": {
            "x": -768,
            "y": -1280
          }
        },
        {
          "id": "87688521-0573-4373-aced-490d214d4ea2",
          "type": "basic.input",
          "data": {
            "name": "PPS",
            "pins": [
              {
                "index": "0",
                "name": "PMOD8",
                "value": "88"
              }
            ],
            "virtual": false,
            "clock": false
          },
          "position": {
            "x": -768,
            "y": -1136
          }
        },
        {
          "id": "98bd87ad-fcd5-4329-93f3-fcc61f3e56fe",
          "type": "basic.output",
          "data": {
            "name": "SynchedPPS",
            "pins": [
              {
                "index": "0",
                "name": "PMOD10",
                "value": "91"
              }
            ],
            "virtual": false
          },
          "position": {
            "x": 368,
            "y": -1128
          }
        },
        {
          "id": "cb20f055-515d-438b-b596-1b1d31b74337",
          "type": "basic.output",
          "data": {
            "name": "tx",
            "pins": [
              {
                "index": "0",
                "name": "PMOD9",
                "value": "90"
              }
            ],
            "virtual": false
          },
          "position": {
            "x": 1088,
            "y": -1072
          }
        },
        {
          "id": "831e4593-f825-43e7-ae31-773ac4471d98",
          "type": "basic.output",
          "data": {
            "name": "LED",
            "pins": [
              {
                "index": "0",
                "name": "D5",
                "value": "95"
              }
            ],
            "virtual": false
          },
          "position": {
            "x": 408,
            "y": -728
          }
        },
        {
          "id": "f66a8e5b-bc11-4ad4-a4a3-3bb98aac9269",
          "type": "basic.output",
          "data": {
            "name": "ppscoaster",
            "pins": [
              {
                "index": "0",
                "name": "PMOD7",
                "value": "87"
              }
            ],
            "virtual": false
          },
          "position": {
            "x": 408,
            "y": -608
          }
        },
        {
          "id": "289f9014-2ca1-474b-82bc-084bfabe82ad",
          "type": "basic.constant",
          "data": {
            "name": "Timer Count",
            "value": "11999999",
            "local": false
          },
          "position": {
            "x": -80,
            "y": -968
          }
        },
        {
          "id": "3f09bf0c-70df-45f3-85ee-1a2ea54e0ad0",
          "type": "basic.constant",
          "data": {
            "name": "f",
            "value": "15",
            "local": false
          },
          "position": {
            "x": 64,
            "y": -968
          }
        },
        {
          "id": "2b0a5a73-22e2-4de1-b61c-5823437ff14b",
          "type": "basic.constant",
          "data": {
            "name": "Baud",
            "value": "104",
            "local": false
          },
          "position": {
            "x": 848,
            "y": -1192
          }
        },
        {
          "id": "ddb7d1e5-dc57-4163-965a-d2099a0e617d",
          "type": "basic.info",
          "data": {
            "info": "Timer Count and f (fraction) have to\nbe calibrated by hand for now.",
            "readonly": false
          },
          "position": {
            "x": 192,
            "y": -976
          },
          "size": {
            "width": 280,
            "height": 80
          }
        },
        {
          "id": "86e18b09-ba26-44d2-88a0-784d222fdec7",
          "type": "basic.code",
          "data": {
            "code": "// sync PPS to clk\n\nreg meta;\nreg SyncedPPS;\n\nalways @(posedge clk)\nbegin\n  // See: https://daffy1108.wordpress.com/2014/06/08/synchronizers-for-asynchronous-signals/\n  meta <= PPS; // sync pulse to clock\n  SyncedPPS <= meta;\nend\n",
            "params": [],
            "ports": {
              "in": [
                {
                  "name": "clk"
                },
                {
                  "name": "PPS"
                }
              ],
              "out": [
                {
                  "name": "SyncedPPS"
                }
              ]
            }
          },
          "position": {
            "x": -432,
            "y": -1104
          },
          "size": {
            "width": 288,
            "height": 176
          }
        },
        {
          "id": "9763aa1f-09da-478f-93ef-0177e9bebc11",
          "type": "3d3aa2413ff5779c17ca5951782c61ceafaff0be",
          "position": {
            "x": 848,
            "y": -1088
          },
          "size": {
            "width": 96,
            "height": 96
          }
        },
        {
          "id": "cf0f32c0-bc52-47b5-852a-f2606e48f426",
          "type": "basic.info",
          "data": {
            "info": "I/O Summary on IceStick\n\nPMOD1  - Clock (in)\nPMOD7  - PPScoaster (out)\nPMOD8  - PPS (in)\nPMOD9  - TX (out)\nPMOD10 - Synched PPS (out)",
            "readonly": false
          },
          "position": {
            "x": 80,
            "y": -1416
          },
          "size": {
            "width": 216,
            "height": 136
          }
        },
        {
          "id": "eb5a46c6-8a8c-42f5-9e16-5e41a3075169",
          "type": "basic.code",
          "data": {
            "code": "reg [31:0] counter = 0;\nreg lastPulse = 0;\nreg [7:0]pulseCount = 0;\nreg [63:0]debugOut = 0;\nreg [3:0]fraction = 0;\nreg [4:0]fraction2 = 0;\n\n//-- 32 bit counter\n\nalways @(posedge clk)\nbegin\n    if( counter != 0 )\n        counter <= counter - 1;\n    else\n    begin\n        fraction <= fraction + 1;\n        fraction2 <= fraction2 + 1;\n        \n        if( fraction > f )\n            counter <= timercount; // (15 - f) times\n        else\n        begin\n            // this whole part happens \n            if( fraction2 > 0 )\n                counter <= timercount - 1; // (f + 1) times except when fraction2 == 0\n            else\n                counter <= timercount - 1; // every 32 times (width of fraction2)\n        end\n    end\n        \n        if( pulse == 1 && lastPulse == 0 )\n    begin\n        lastPulse <= 1;\n        \n        if(  pulseCount < 100 ) // sync counter for 10 pulses\n        begin\n            counter <= timercount; // sync counter to PPS\n            pulseCount <= pulseCount + 1;\n            debugOut <= pulseCount;\n        end\n        else\n        begin\n            // Here we are going to see how far we have drifted\n            // by sending out the counter to show on the micro\n            debugOut <= counter;\n        end\n    end\n    else if( pulse == 0 && lastPulse == 1 )\n        lastPulse<= 0;\nend\n\nassign ppscoaster = counter[23]; \n\n",
            "params": [
              {
                "name": "timercount"
              },
              {
                "name": "f"
              }
            ],
            "ports": {
              "in": [
                {
                  "name": "clk"
                },
                {
                  "name": "pulse"
                }
              ],
              "out": [
                {
                  "name": "ppscoaster"
                },
                {
                  "name": "debugOut",
                  "range": "[63:0]",
                  "size": 64
                }
              ]
            }
          },
          "position": {
            "x": -360,
            "y": -856
          },
          "size": {
            "width": 624,
            "height": 552
          }
        },
        {
          "id": "d69122ab-8626-4205-8fe8-d0534792d6c0",
          "type": "basic.info",
          "data": {
            "info": "I use PMOD1 for an\nexternal clock or\npick CLK for clock\non the board (12MHz for\nIceStick)",
            "readonly": false
          },
          "position": {
            "x": -648,
            "y": -1376
          },
          "size": {
            "width": 200,
            "height": 104
          }
        },
        {
          "id": "a6956711-a0e9-4f6f-9ce6-f4a21cf68ccb",
          "type": "basic.info",
          "data": {
            "info": "I use PMOD8 for PPS\ninput",
            "readonly": false
          },
          "position": {
            "x": -776,
            "y": -1032
          },
          "size": {
            "width": 176,
            "height": 56
          }
        },
        {
          "id": "8165580b-63d6-453e-a108-2f497f11833b",
          "type": "basic.info",
          "data": {
            "info": "I use PMOD7 for the \n\"coasting\" PPS output.",
            "readonly": false
          },
          "position": {
            "x": 472,
            "y": -528
          },
          "size": {
            "width": 184,
            "height": 56
          }
        },
        {
          "id": "019c5b76-fe7b-480b-8c1c-b3e33d2db209",
          "type": "basic.info",
          "data": {
            "info": "We want 115200 baud which is\nBaud = 86 for 10 MHz clock,\nBaud = 104 for 12 MHz clock and\nBaud = 139 for 16 MHz clock.",
            "readonly": false
          },
          "position": {
            "x": 880,
            "y": -1296
          },
          "size": {
            "width": 272,
            "height": 88
          }
        }
      ],
      "wires": [
        {
          "source": {
            "block": "87688521-0573-4373-aced-490d214d4ea2",
            "port": "out"
          },
          "target": {
            "block": "86e18b09-ba26-44d2-88a0-784d222fdec7",
            "port": "PPS"
          },
          "vertices": [
            {
              "x": -536,
              "y": -1096
            }
          ]
        },
        {
          "source": {
            "block": "86e18b09-ba26-44d2-88a0-784d222fdec7",
            "port": "SyncedPPS"
          },
          "target": {
            "block": "eb5a46c6-8a8c-42f5-9e16-5e41a3075169",
            "port": "pulse"
          },
          "vertices": [
            {
              "x": -424,
              "y": -832
            }
          ]
        },
        {
          "source": {
            "block": "289f9014-2ca1-474b-82bc-084bfabe82ad",
            "port": "constant-out"
          },
          "target": {
            "block": "eb5a46c6-8a8c-42f5-9e16-5e41a3075169",
            "port": "timercount"
          }
        },
        {
          "source": {
            "block": "eb5a46c6-8a8c-42f5-9e16-5e41a3075169",
            "port": "ppscoaster"
          },
          "target": {
            "block": "831e4593-f825-43e7-ae31-773ac4471d98",
            "port": "in"
          }
        },
        {
          "source": {
            "block": "2b0a5a73-22e2-4de1-b61c-5823437ff14b",
            "port": "constant-out"
          },
          "target": {
            "block": "9763aa1f-09da-478f-93ef-0177e9bebc11",
            "port": "b795bc81-0914-4ac3-9b97-05150ea98ccf"
          }
        },
        {
          "source": {
            "block": "9763aa1f-09da-478f-93ef-0177e9bebc11",
            "port": "d5975d7e-4231-4538-bf89-f762a63cb10a"
          },
          "target": {
            "block": "cb20f055-515d-438b-b596-1b1d31b74337",
            "port": "in"
          }
        },
        {
          "source": {
            "block": "86e18b09-ba26-44d2-88a0-784d222fdec7",
            "port": "SyncedPPS"
          },
          "target": {
            "block": "9763aa1f-09da-478f-93ef-0177e9bebc11",
            "port": "e614f8ce-28ab-49ed-baa1-d3529f039db2"
          },
          "vertices": [
            {
              "x": 584,
              "y": -1048
            }
          ]
        },
        {
          "source": {
            "block": "eb5a46c6-8a8c-42f5-9e16-5e41a3075169",
            "port": "debugOut"
          },
          "target": {
            "block": "9763aa1f-09da-478f-93ef-0177e9bebc11",
            "port": "60a362a0-ac00-497a-96b3-5dce16d7d442"
          },
          "vertices": [
            {
              "x": 704,
              "y": -840
            }
          ],
          "size": 64
        },
        {
          "source": {
            "block": "86d68a11-bf59-4f97-8290-ac5419f696cc",
            "port": "out"
          },
          "target": {
            "block": "86e18b09-ba26-44d2-88a0-784d222fdec7",
            "port": "clk"
          }
        },
        {
          "source": {
            "block": "86d68a11-bf59-4f97-8290-ac5419f696cc",
            "port": "out"
          },
          "target": {
            "block": "eb5a46c6-8a8c-42f5-9e16-5e41a3075169",
            "port": "clk"
          }
        },
        {
          "source": {
            "block": "86d68a11-bf59-4f97-8290-ac5419f696cc",
            "port": "out"
          },
          "target": {
            "block": "9763aa1f-09da-478f-93ef-0177e9bebc11",
            "port": "15b744df-6884-4851-b97e-8f279dd2c039"
          }
        },
        {
          "source": {
            "block": "eb5a46c6-8a8c-42f5-9e16-5e41a3075169",
            "port": "ppscoaster"
          },
          "target": {
            "block": "f66a8e5b-bc11-4ad4-a4a3-3bb98aac9269",
            "port": "in"
          }
        },
        {
          "source": {
            "block": "3f09bf0c-70df-45f3-85ee-1a2ea54e0ad0",
            "port": "constant-out"
          },
          "target": {
            "block": "eb5a46c6-8a8c-42f5-9e16-5e41a3075169",
            "port": "f"
          }
        },
        {
          "source": {
            "block": "86e18b09-ba26-44d2-88a0-784d222fdec7",
            "port": "SyncedPPS"
          },
          "target": {
            "block": "98bd87ad-fcd5-4329-93f3-fcc61f3e56fe",
            "port": "in"
          }
        }
      ]
    }
  },
  "dependencies": {
    "3d3aa2413ff5779c17ca5951782c61ceafaff0be": {
      "package": {
        "name": "",
        "version": "",
        "description": "",
        "author": "",
        "image": ""
      },
      "design": {
        "graph": {
          "blocks": [
            {
              "id": "e614f8ce-28ab-49ed-baa1-d3529f039db2",
              "type": "basic.input",
              "data": {
                "name": "pulse",
                "clock": false
              },
              "position": {
                "x": -320,
                "y": -968
              }
            },
            {
              "id": "60a362a0-ac00-497a-96b3-5dce16d7d442",
              "type": "basic.input",
              "data": {
                "name": "data",
                "range": "[63:0]",
                "clock": false,
                "size": 64
              },
              "position": {
                "x": -320,
                "y": -832
              }
            },
            {
              "id": "15b744df-6884-4851-b97e-8f279dd2c039",
              "type": "basic.input",
              "data": {
                "name": "clock",
                "clock": true
              },
              "position": {
                "x": -320,
                "y": -680
              }
            },
            {
              "id": "d5975d7e-4231-4538-bf89-f762a63cb10a",
              "type": "basic.output",
              "data": {
                "name": "TX"
              },
              "position": {
                "x": 1032,
                "y": -352
              }
            },
            {
              "id": "b795bc81-0914-4ac3-9b97-05150ea98ccf",
              "type": "basic.constant",
              "data": {
                "name": "B",
                "value": "139",
                "local": false
              },
              "position": {
                "x": 480,
                "y": -560
              }
            },
            {
              "id": "33b01d6f-f69a-41d8-80fb-1c6e601982e4",
              "type": "basic.code",
              "data": {
                "code": "// From here: https://github.com/shuckc/verilog-utils/blob/master/bcd/bin2bcd_serial.v\n\nparameter BINARY_BITS = 64;\nparameter BCD_DIGITS = 20;\n\n// binary input shift register and counter\nreg [BINARY_BITS-1:0] binary_shift = 0;\nreg [$clog2(BINARY_BITS):0] binary_count = 0;\nassign o_DV = binary_count == 0;\n\nalways @(posedge clk) begin\n  if(i_Start) begin\n      binary_shift <= data;\n      binary_count <= BINARY_BITS;\n  end else if (binary_count != 0) begin\n      binary_shift <= { binary_shift[BINARY_BITS-2:0], 1'b0 };\n      binary_count <= binary_count - 1'b1;\n  end\nend\n\nwire [BCD_DIGITS:0] bcd_carry;\nassign bcd_carry[0] = binary_shift[BINARY_BITS-1]; // MSB\nwire clock_enable   = i_Start | ~o_DV;\n\ngenvar j;\ngenerate\nfor (j = 0; j < BCD_DIGITS; j=j+1) begin: DIGITS\n  bcd_digit digit (\n      .clock(   clk ),\n      .init(    i_Start ),\n      .mod_in(  bcd_carry[j] ),\n      .mod_out( bcd_carry[j+1] ),\n      .digit(   o_BCD[4*j +: 4] ),\n      .ce( clock_enable )\n  );\nend\nendgenerate\nendmodule\n\n// Regarding the init signal: At first it seems that digit[0] should have an explicit clear (\"& ~init\")\n// like the rest. However digit[0] loads mod_in unconditionaly, and since mod_out is masked\n// by & ~init this ensures digit[0] of higher digits is cleared during the init cycle whilst not loosing\n// a cycle in the conversion for synchronous clearing.\nmodule bcd_digit (\n  input wire clock,\n  input wire ce,\n  input wire init,\n  input wire mod_in,\n  output wire mod_out,\n  output reg [3:0] digit\n  );\n\n  wire fiveOrMore = digit >= 5;\n  assign mod_out  = fiveOrMore & ~init;\n\n  always @(posedge clock) begin\n    if (ce) begin\n      digit[0] <= mod_in;\n      digit[1] <= ~init & (~mod_out ? digit[0] : ~digit[0]);\n      digit[2] <= ~init & (~mod_out ? digit[1] : digit[1] == digit[0]);\n      digit[3] <= ~init & (~mod_out ? digit[2] : digit[0] & digit[3]);\n    end\n  end\n\n",
                "params": [],
                "ports": {
                  "in": [
                    {
                      "name": "clk"
                    },
                    {
                      "name": "i_Start"
                    },
                    {
                      "name": "data",
                      "range": "[63:0]",
                      "size": 64
                    }
                  ],
                  "out": [
                    {
                      "name": "o_BCD",
                      "range": "[79:0]",
                      "size": 80
                    },
                    {
                      "name": "o_DV"
                    }
                  ]
                }
              },
              "position": {
                "x": 112,
                "y": -1136
              },
              "size": {
                "width": 552,
                "height": 400
              }
            },
            {
              "id": "2c8c7df4-2579-4f20-8e6b-5aa4e2d4caa1",
              "type": "basic.code",
              "data": {
                "code": "// NOTE: I changed the input mux to use = instead of <=\n// and the first sync block to do the opposite. Not sure.\n\nreg start;\nreg [7:0]data;\nparameter CR = 13;\n\n//-- Multiplexer with the 8-character string to transmit\nalways @*\n  case (char_count)\n    8'd0: data = indata[79:76] + \"0\";\n    8'd1: data = indata[75:72] + \"0\";\n    8'd2: data = indata[71:68] + \"0\";\n    8'd3: data = indata[67:64] + \"0\";\n    8'd4: data = indata[63:60] + \"0\";\n    8'd5: data = indata[59:56] + \"0\";\n    8'd6: data = indata[55:52] + \"0\";\n    8'd7: data = indata[51:48] + \"0\";\n    8'd8: data = indata[47:44] + \"0\";\n    8'd9: data = indata[43:40] + \"0\";\n    8'd10: data = indata[39:36] + \"0\";\n    8'd11: data = indata[35:32] + \"0\";\n    8'd12: data = indata[31:28] + \"0\";\n    8'd13: data = indata[27:24] + \"0\";\n    8'd14: data = indata[23:20] + \"0\";\n    8'd15: data = indata[19:16] + \"0\";\n    8'd16: data = indata[15:12] + \"0\";\n    8'd17: data = indata[11:8] + \"0\";\n    8'd18: data = indata[7:4] + \"0\";\n    8'd19: data = indata[3:0] + \"0\";\n    8'd20: data = CR;\n    default: data = \".\";\n  endcase\n\n//-- Characters counter\n//-- It only counts when the cena control signal is enabled\nreg [7:0] char_count;\nreg cena;                //-- Counter enable\n\nalways @(posedge clk)\n  if (!rstn)\n    char_count <= 0;\n  else if (cena)\n    char_count <= char_count + 1;\n\n\n//--------------------- CONTROLLER\n\nlocalparam INI = 0;\nlocalparam TXCAR = 1;\nlocalparam NEXTCAR = 2;\nlocalparam STOP = 3;\n\n//-- fsm state\nreg [1:0] state;\nreg [1:0] next_state;\n\n//-- Transition between states\nalways @(posedge clk) begin\n  if (!rstn)\n    state <= INI;\n  else\n    state <= next_state;\nend\n\n//-- Control signal generation and next states\nalways @(*) begin\n  next_state = state;\n  start = 0;\n  cena = 0;\n\n  case (state)\n    //-- Initial state. Start the trasmission\n    INI: begin\n      start = 1;\n      next_state = TXCAR;\n    end\n\n    //-- Wait until one car is transmitted\n    TXCAR: begin\n      if (ready)\n        next_state = NEXTCAR;\n    end\n\n    //-- Increment the character counter\n    //-- Finish when it is the last character\n    NEXTCAR: begin\n      cena = 1;\n      if (char_count > 19)\n        next_state = STOP;\n      else\n        next_state = INI;\n    end\n\n  endcase\nend\n",
                "params": [],
                "ports": {
                  "in": [
                    {
                      "name": "indata",
                      "range": "[79:0]",
                      "size": 80
                    },
                    {
                      "name": "clk"
                    },
                    {
                      "name": "ready"
                    },
                    {
                      "name": "rstn"
                    }
                  ],
                  "out": [
                    {
                      "name": "data",
                      "range": "[7:0]",
                      "size": 8
                    },
                    {
                      "name": "start"
                    }
                  ]
                }
              },
              "position": {
                "x": 880,
                "y": -984
              },
              "size": {
                "width": 456,
                "height": 352
              }
            },
            {
              "id": "48271f7a-6858-432b-967f-687e286f0227",
              "type": "5db2ec058b2d2cda189708baf7d22f10c9673c01",
              "position": {
                "x": 480,
                "y": -384
              },
              "size": {
                "width": 96,
                "height": 128
              }
            },
            {
              "id": "8b6a380b-c90b-44e8-acbb-001b44a91e3a",
              "type": "basic.info",
              "data": {
                "info": "UartTX.v\n\nNOTE: can\nremove\nrstn pin",
                "readonly": false
              },
              "position": {
                "x": 472,
                "y": -240
              },
              "size": {
                "width": 104,
                "height": 112
              }
            },
            {
              "id": "671c6092-2b85-4a19-b51b-cde8f8232f4f",
              "type": "basic.info",
              "data": {
                "info": "64 bit Binary to BCD",
                "readonly": false
              },
              "position": {
                "x": 280,
                "y": -1192
              },
              "size": {
                "width": 168,
                "height": 32
              }
            },
            {
              "id": "0d5b8da3-171e-4c78-b2ae-196e1781771b",
              "type": "basic.info",
              "data": {
                "info": "Sends the BCD data to\nthe UART TX. There are \n20 digits for 64 bits.",
                "readonly": false
              },
              "position": {
                "x": 992,
                "y": -1088
              },
              "size": {
                "width": 216,
                "height": 72
              }
            }
          ],
          "wires": [
            {
              "source": {
                "block": "33b01d6f-f69a-41d8-80fb-1c6e601982e4",
                "port": "o_BCD"
              },
              "target": {
                "block": "2c8c7df4-2579-4f20-8e6b-5aa4e2d4caa1",
                "port": "indata"
              },
              "size": 80
            },
            {
              "source": {
                "block": "2c8c7df4-2579-4f20-8e6b-5aa4e2d4caa1",
                "port": "start"
              },
              "target": {
                "block": "48271f7a-6858-432b-967f-687e286f0227",
                "port": "49f01d2f-de96-4bd8-a7b9-db7a61164b52"
              },
              "vertices": [
                {
                  "x": 432,
                  "y": -472
                }
              ]
            },
            {
              "source": {
                "block": "48271f7a-6858-432b-967f-687e286f0227",
                "port": "5e217d73-d86f-4023-9528-9139bad29182"
              },
              "target": {
                "block": "2c8c7df4-2579-4f20-8e6b-5aa4e2d4caa1",
                "port": "ready"
              }
            },
            {
              "source": {
                "block": "b795bc81-0914-4ac3-9b97-05150ea98ccf",
                "port": "constant-out"
              },
              "target": {
                "block": "48271f7a-6858-432b-967f-687e286f0227",
                "port": "e34ddd63-e149-4e8a-b1e9-235b674c0d3d"
              }
            },
            {
              "source": {
                "block": "48271f7a-6858-432b-967f-687e286f0227",
                "port": "d5975d7e-4231-4538-bf89-f762a63cb10a"
              },
              "target": {
                "block": "d5975d7e-4231-4538-bf89-f762a63cb10a",
                "port": "in"
              }
            },
            {
              "source": {
                "block": "2c8c7df4-2579-4f20-8e6b-5aa4e2d4caa1",
                "port": "data"
              },
              "target": {
                "block": "48271f7a-6858-432b-967f-687e286f0227",
                "port": "e58b4da6-f71f-48c0-b493-c104a96ecae0"
              },
              "vertices": [
                {
                  "x": 672,
                  "y": -592
                }
              ],
              "size": 8
            },
            {
              "source": {
                "block": "33b01d6f-f69a-41d8-80fb-1c6e601982e4",
                "port": "o_DV"
              },
              "target": {
                "block": "2c8c7df4-2579-4f20-8e6b-5aa4e2d4caa1",
                "port": "rstn"
              }
            },
            {
              "source": {
                "block": "e614f8ce-28ab-49ed-baa1-d3529f039db2",
                "port": "out"
              },
              "target": {
                "block": "33b01d6f-f69a-41d8-80fb-1c6e601982e4",
                "port": "i_Start"
              }
            },
            {
              "source": {
                "block": "60a362a0-ac00-497a-96b3-5dce16d7d442",
                "port": "out"
              },
              "target": {
                "block": "33b01d6f-f69a-41d8-80fb-1c6e601982e4",
                "port": "data"
              },
              "size": 64
            },
            {
              "source": {
                "block": "e614f8ce-28ab-49ed-baa1-d3529f039db2",
                "port": "out"
              },
              "target": {
                "block": "48271f7a-6858-432b-967f-687e286f0227",
                "port": "88e33f02-4f8a-4b2e-8a04-4745b445b4f6"
              },
              "vertices": [
                {
                  "x": 24,
                  "y": -640
                }
              ]
            },
            {
              "source": {
                "block": "15b744df-6884-4851-b97e-8f279dd2c039",
                "port": "out"
              },
              "target": {
                "block": "33b01d6f-f69a-41d8-80fb-1c6e601982e4",
                "port": "clk"
              },
              "vertices": [
                {
                  "x": -72,
                  "y": -1024
                }
              ]
            },
            {
              "source": {
                "block": "15b744df-6884-4851-b97e-8f279dd2c039",
                "port": "out"
              },
              "target": {
                "block": "2c8c7df4-2579-4f20-8e6b-5aa4e2d4caa1",
                "port": "clk"
              },
              "vertices": [
                {
                  "x": 760,
                  "y": -728
                }
              ]
            },
            {
              "source": {
                "block": "15b744df-6884-4851-b97e-8f279dd2c039",
                "port": "out"
              },
              "target": {
                "block": "48271f7a-6858-432b-967f-687e286f0227",
                "port": "96f4ec8e-ad6a-49b2-966d-aef72f1f2c76"
              },
              "vertices": [
                {
                  "x": 144,
                  "y": -616
                },
                {
                  "x": 144,
                  "y": -544
                }
              ]
            }
          ]
        }
      }
    },
    "5db2ec058b2d2cda189708baf7d22f10c9673c01": {
      "package": {
        "name": "",
        "version": "",
        "description": "",
        "author": "",
        "image": ""
      },
      "design": {
        "graph": {
          "blocks": [
            {
              "id": "a58fbc82-167c-4030-b17e-04588abb70eb",
              "type": "basic.output",
              "data": {
                "name": "Rstn"
              },
              "position": {
                "x": -40,
                "y": -712
              }
            },
            {
              "id": "88e33f02-4f8a-4b2e-8a04-4745b445b4f6",
              "type": "basic.input",
              "data": {
                "name": "Pulse",
                "clock": false
              },
              "position": {
                "x": -592,
                "y": -616
              }
            },
            {
              "id": "d5975d7e-4231-4538-bf89-f762a63cb10a",
              "type": "basic.output",
              "data": {
                "name": "TX"
              },
              "position": {
                "x": 1560,
                "y": -496
              }
            },
            {
              "id": "49f01d2f-de96-4bd8-a7b9-db7a61164b52",
              "type": "basic.input",
              "data": {
                "name": "Start",
                "clock": false
              },
              "position": {
                "x": 488,
                "y": -352
              }
            },
            {
              "id": "5e217d73-d86f-4023-9528-9139bad29182",
              "type": "basic.output",
              "data": {
                "name": "Ready"
              },
              "position": {
                "x": 1560,
                "y": -352
              }
            },
            {
              "id": "e58b4da6-f71f-48c0-b493-c104a96ecae0",
              "type": "basic.input",
              "data": {
                "name": "Data",
                "range": "[7:0]",
                "clock": false,
                "size": 8
              },
              "position": {
                "x": 488,
                "y": -272
              }
            },
            {
              "id": "96f4ec8e-ad6a-49b2-966d-aef72f1f2c76",
              "type": "basic.input",
              "data": {
                "name": "",
                "clock": true
              },
              "position": {
                "x": -592,
                "y": -184
              }
            },
            {
              "id": "e34ddd63-e149-4e8a-b1e9-235b674c0d3d",
              "type": "basic.constant",
              "data": {
                "name": "B",
                "value": "139",
                "local": false
              },
              "position": {
                "x": -40,
                "y": -552
              }
            },
            {
              "id": "f5a3e0b9-ce83-4038-90c8-dee3e8dd62ab",
              "type": "basic.code",
              "data": {
                "code": "//-- Constants for obtaining standard BAUDRATES:\n`define B115200 104\n`define B57600  208\n`define B38400  313\n\n`define B19200  625\n`define B9600   1250\n`define B4800   2500\n`define B2400   5000\n`define B1200   10000\n`define B600    20000\n`define B300    40000\n\n//-- Number of bits needed for storing the baudrate divisor\nlocalparam N = $clog2(BAUDRATE);\n\n//-- Counter for implementing the divisor (it is a BAUDRATE module counter)\n//-- (when BAUDRATE is reached, it start again from 0)\nreg [N-1:0] divcounter = 0;\n\nalways @(posedge clk)\n\n  if (!rstn)\n    divcounter <= 0;\n\n  else if (clk_ena)\n    //-- Normal working: counting. When the maximum count is reached, it starts from 0\n    divcounter <= (divcounter == BAUDRATE - 1) ? 0 : divcounter + 1;\n  else\n    //-- Counter fixed to its maximum value\n    //-- When it is resumed it start from 0\n    divcounter <= BAUDRATE - 1;\n\n//-- The output is 1 when the counter is 0, if clk_ena is active\n//-- It is 1 only for one system clock cycle\nassign clk_out = (divcounter == 0) ? clk_ena : 0;\n",
                "params": [
                  {
                    "name": "BAUDRATE"
                  }
                ],
                "ports": {
                  "in": [
                    {
                      "name": "rstn"
                    },
                    {
                      "name": "clk"
                    },
                    {
                      "name": "clk_ena"
                    }
                  ],
                  "out": [
                    {
                      "name": "clk_out"
                    }
                  ]
                }
              },
              "position": {
                "x": -360,
                "y": -368
              },
              "size": {
                "width": 728,
                "height": 432
              }
            },
            {
              "id": "58481774-a213-47a1-86cc-af8cea49db88",
              "type": "basic.code",
              "data": {
                "code": "//-----------------------------------------------------------------------------\n//-- Constants for the serial asinchronous communication modules\n//------------------------------------------------------------------------------\n//-- (C) BQ. December 2015. Written by Juan Gonzalez (Obijuan)\n//------------------------------------------------------------------------------\n// These constans have been calculated for the ICESTICK board which have\n// a 12MHz clock\n//\n//-- The calculation for the icestick board is:\n//-- Divisor = 12000000 / BAUDRATE  (and the result is rounded to an integer number)\n//--------------------------------------------------------------------------------\n//-- The python3 script: baudgen.py contains the function for generating this table\n//-----------------------------------------------------------------------------------\n\n// Outputs default to wire, need reg\nreg tx;\nreg ready;\n\n//-- Transmission clock\n//wire clk_baud;\n\n//-- Bitcounter\nreg [3:0] bitc;\n\n//-- Registered data\nreg [7:0] data_r;\n\n//--------- control signals\nreg load;    //-- Load the shifter register / reset\nreg baud_en; //-- Enable the baud generator\n\n//-------------------------------------\n//-- DATAPATH\n//-------------------------------------\n\n//-- Register the input data\nalways @(posedge clk)\n  if (start == 1 && state == IDLE)\n    data_r <= data;\n\n//-- 1 bit start + 8 bits datos + 1 bit stop\n//-- Shifter register. It stored the frame to transmit:\n//-- 1 start bit + 8 data bits + 1 stop bit\nreg [9:0] shifter;\n\n//-- When the control signal load is 1, the frame is loaded\n//-- when load = 0, the frame is shifted right to send 1 bit,\n//--   at the baudrate determined by clk_baud\n//--  1s are introduced by the left\nalways @(posedge clk)\n  //-- Reset\n  if (rstn == 0)\n    shifter <= 10'b11_1111_1111;\n\n  //-- Load mode\n  else if (load == 1)\n    shifter <= {data_r,2'b01};\n\n  //-- Shift mode\n  else if (load == 0 && clk_baud == 1)\n    shifter <= {1'b1, shifter[9:1]};\n\n//-- Sent bit counter\n//-- When load (=1) the counter is reset\n//-- When load = 0, the sent bits are counted (with the raising edge of clk_baud)\nalways @(posedge clk)\n  if (!rstn)\n    bitc <= 0;\n\n  else if (load == 1)\n    bitc <= 0;\n  else if (load == 0 && clk_baud == 1)\n    bitc <= bitc + 1;\n\n//-- The less significant bit is transmited through tx\n//-- It is a registed output, because tx is connected to an Asynchronous bus\n//--  and the glitches should be avoided\nreg txx;\n\nalways @(posedge clk)\n  tx <= shifter[0];\n  //assign tx = txx;\n\n//-- Baud generator\n//baudgen_tx #( .BAUDRATE(BAUDRATE))\n//BAUD0 (\n//    .rstn(rstn),\n//    .clk(clk),\n//    .clk_ena(baud_en),\n//    .clk_out(clk_baud)\n//  );\n\n//------------------------------\n//-- CONTROLLER\n//------------------------------\n\n//-- fsm states\nlocalparam IDLE  = 0;  //-- Idle state\nlocalparam START = 1;  //-- Start transmission\nlocalparam TRANS = 2;  //-- Transmitting data\n\n//-- Registers for storing the states\nreg [1:0] state;\nreg [1:0] next_state;\n//reg rdy = 0;\n\n//-- Transition between states\nalways @(posedge clk)\n  if (!rstn)\n    state <= IDLE;\n  else\n    state <= next_state;\n\n//-- Control signal generation and next states\nalways @(*) begin\n\n  //-- Default values\n  next_state = state;      //-- Stay in the same state by default\n  load = 0;\n  baud_en = 0;\n  \n  case (state)\n\n    //-- Idle state\n    //-- Remain in this state until start is 1\n    IDLE: begin\n      ready = 1;\n      if (start == 1)\n        next_state = START;\n    end\n\n    //-- 1 cycle long\n    //-- turn on the baudrate generator and the load the shift register\n    START: begin\n      load = 1;\n      baud_en = 1;\n      ready = 0;\n      next_state = TRANS;\n    end\n\n    //-- Stay here until all the bits have been sent\n    TRANS: begin\n      baud_en = 1;\n      ready = 0;\n      if (bitc == 11)\n        next_state = IDLE;\n    end\n\n    default:\n      ready = 0;\n\n  endcase\n  \nend\n\n//assign ready = rdy;\n\n",
                "params": [],
                "ports": {
                  "in": [
                    {
                      "name": "clk"
                    },
                    {
                      "name": "rstn"
                    },
                    {
                      "name": "start"
                    },
                    {
                      "name": "data",
                      "range": "[7:0]",
                      "size": 8
                    },
                    {
                      "name": "clk_baud"
                    }
                  ],
                  "out": [
                    {
                      "name": "tx"
                    },
                    {
                      "name": "ready"
                    },
                    {
                      "name": "baud_en"
                    }
                  ]
                }
              },
              "position": {
                "x": 712,
                "y": -536
              },
              "size": {
                "width": 696,
                "height": 424
              }
            },
            {
              "id": "0c62d2a8-659b-4f00-82a6-f0efb4d3dcf9",
              "type": "96f0988f8164f7c1b216c8ee122d6ce3cf6bc139",
              "position": {
                "x": -312,
                "y": -616
              },
              "size": {
                "width": 96,
                "height": 64
              }
            }
          ],
          "wires": [
            {
              "source": {
                "block": "e34ddd63-e149-4e8a-b1e9-235b674c0d3d",
                "port": "constant-out"
              },
              "target": {
                "block": "f5a3e0b9-ce83-4038-90c8-dee3e8dd62ab",
                "port": "BAUDRATE"
              }
            },
            {
              "source": {
                "block": "58481774-a213-47a1-86cc-af8cea49db88",
                "port": "tx"
              },
              "target": {
                "block": "d5975d7e-4231-4538-bf89-f762a63cb10a",
                "port": "in"
              }
            },
            {
              "source": {
                "block": "f5a3e0b9-ce83-4038-90c8-dee3e8dd62ab",
                "port": "clk_out"
              },
              "target": {
                "block": "58481774-a213-47a1-86cc-af8cea49db88",
                "port": "clk_baud"
              }
            },
            {
              "source": {
                "block": "58481774-a213-47a1-86cc-af8cea49db88",
                "port": "baud_en"
              },
              "target": {
                "block": "f5a3e0b9-ce83-4038-90c8-dee3e8dd62ab",
                "port": "clk_ena"
              },
              "vertices": [
                {
                  "x": 560,
                  "y": 96
                }
              ]
            },
            {
              "source": {
                "block": "0c62d2a8-659b-4f00-82a6-f0efb4d3dcf9",
                "port": "664caf9e-5f40-4df4-800a-b626af702e62"
              },
              "target": {
                "block": "f5a3e0b9-ce83-4038-90c8-dee3e8dd62ab",
                "port": "rstn"
              },
              "vertices": [
                {
                  "x": -256,
                  "y": -400
                }
              ]
            },
            {
              "source": {
                "block": "0c62d2a8-659b-4f00-82a6-f0efb4d3dcf9",
                "port": "664caf9e-5f40-4df4-800a-b626af702e62"
              },
              "target": {
                "block": "58481774-a213-47a1-86cc-af8cea49db88",
                "port": "rstn"
              },
              "vertices": [
                {
                  "x": 336,
                  "y": -544
                }
              ]
            },
            {
              "source": {
                "block": "88e33f02-4f8a-4b2e-8a04-4745b445b4f6",
                "port": "out"
              },
              "target": {
                "block": "0c62d2a8-659b-4f00-82a6-f0efb4d3dcf9",
                "port": "18c2ebc7-5152-439c-9b3f-851c59bac834"
              }
            },
            {
              "source": {
                "block": "96f4ec8e-ad6a-49b2-966d-aef72f1f2c76",
                "port": "out"
              },
              "target": {
                "block": "f5a3e0b9-ce83-4038-90c8-dee3e8dd62ab",
                "port": "clk"
              }
            },
            {
              "source": {
                "block": "96f4ec8e-ad6a-49b2-966d-aef72f1f2c76",
                "port": "out"
              },
              "target": {
                "block": "58481774-a213-47a1-86cc-af8cea49db88",
                "port": "clk"
              },
              "vertices": [
                {
                  "x": -440,
                  "y": -448
                }
              ]
            },
            {
              "source": {
                "block": "49f01d2f-de96-4bd8-a7b9-db7a61164b52",
                "port": "out"
              },
              "target": {
                "block": "58481774-a213-47a1-86cc-af8cea49db88",
                "port": "start"
              }
            },
            {
              "source": {
                "block": "58481774-a213-47a1-86cc-af8cea49db88",
                "port": "ready"
              },
              "target": {
                "block": "5e217d73-d86f-4023-9528-9139bad29182",
                "port": "in"
              }
            },
            {
              "source": {
                "block": "e58b4da6-f71f-48c0-b493-c104a96ecae0",
                "port": "out"
              },
              "target": {
                "block": "58481774-a213-47a1-86cc-af8cea49db88",
                "port": "data"
              },
              "size": 8
            },
            {
              "source": {
                "block": "0c62d2a8-659b-4f00-82a6-f0efb4d3dcf9",
                "port": "664caf9e-5f40-4df4-800a-b626af702e62"
              },
              "target": {
                "block": "a58fbc82-167c-4030-b17e-04588abb70eb",
                "port": "in"
              }
            }
          ]
        }
      }
    },
    "96f0988f8164f7c1b216c8ee122d6ce3cf6bc139": {
      "package": {
        "name": "NOT",
        "version": "1.0.0",
        "description": "NOT logic gate",
        "author": "Jesús Arroyo",
        "image": "%3Csvg%20xmlns=%22http://www.w3.org/2000/svg%22%20width=%2291.33%22%20height=%2245.752%22%20version=%221%22%3E%3Cpath%20d=%22M0%2020.446h27v2H0zM70.322%2020.447h15.3v2h-15.3z%22/%3E%3Cpath%20d=%22M66.05%2026.746c-2.9%200-5.3-2.4-5.3-5.3s2.4-5.3%205.3-5.3%205.3%202.4%205.3%205.3-2.4%205.3-5.3%205.3zm0-8.6c-1.8%200-3.3%201.5-3.3%203.3%200%201.8%201.5%203.3%203.3%203.3%201.8%200%203.3-1.5%203.3-3.3%200-1.8-1.5-3.3-3.3-3.3z%22/%3E%3Cpath%20d=%22M25.962%202.563l33.624%2018.883L25.962%2040.33V2.563z%22%20fill=%22none%22%20stroke=%22#000%22%20stroke-width=%223%22/%3E%3C/svg%3E"
      },
      "design": {
        "graph": {
          "blocks": [
            {
              "id": "18c2ebc7-5152-439c-9b3f-851c59bac834",
              "type": "basic.input",
              "data": {
                "name": ""
              },
              "position": {
                "x": 64,
                "y": 144
              }
            },
            {
              "id": "664caf9e-5f40-4df4-800a-b626af702e62",
              "type": "basic.output",
              "data": {
                "name": ""
              },
              "position": {
                "x": 752,
                "y": 144
              }
            },
            {
              "id": "5365ed8c-e5db-4445-938f-8d689830ea5c",
              "type": "basic.code",
              "data": {
                "code": "// NOT logic gate\n\nassign c = ~ a;",
                "params": [],
                "ports": {
                  "in": [
                    {
                      "name": "a"
                    }
                  ],
                  "out": [
                    {
                      "name": "c"
                    }
                  ]
                }
              },
              "position": {
                "x": 256,
                "y": 48
              },
              "size": {
                "width": 384,
                "height": 256
              }
            }
          ],
          "wires": [
            {
              "source": {
                "block": "18c2ebc7-5152-439c-9b3f-851c59bac834",
                "port": "out"
              },
              "target": {
                "block": "5365ed8c-e5db-4445-938f-8d689830ea5c",
                "port": "a"
              }
            },
            {
              "source": {
                "block": "5365ed8c-e5db-4445-938f-8d689830ea5c",
                "port": "c"
              },
              "target": {
                "block": "664caf9e-5f40-4df4-800a-b626af702e62",
                "port": "in"
              }
            }
          ]
        }
      }
    }
  }
}