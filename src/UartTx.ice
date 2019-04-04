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
    "board": "TinyFPGA-BX",
    "graph": {
      "blocks": [
        {
          "id": "a58fbc82-167c-4030-b17e-04588abb70eb",
          "type": "basic.output",
          "data": {
            "name": "Rstn",
            "pins": [
              {
                "index": "0",
                "name": "",
                "value": ""
              }
            ],
            "virtual": true
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
            "pins": [
              {
                "index": "0",
                "name": "",
                "value": ""
              }
            ],
            "virtual": true,
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
            "name": "TX",
            "pins": [
              {
                "index": "0",
                "name": "PIN_4",
                "value": "C2"
              }
            ],
            "virtual": true
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
            "pins": [
              {
                "index": "0",
                "name": "",
                "value": ""
              }
            ],
            "virtual": true,
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
            "name": "Ready",
            "pins": [
              {
                "index": "0",
                "name": "",
                "value": ""
              }
            ],
            "virtual": true
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
            "pins": [
              {
                "index": "7",
                "name": "",
                "value": ""
              },
              {
                "index": "6",
                "name": "",
                "value": ""
              },
              {
                "index": "5",
                "name": "",
                "value": ""
              },
              {
                "index": "4",
                "name": "",
                "value": ""
              },
              {
                "index": "3",
                "name": "",
                "value": ""
              },
              {
                "index": "2",
                "name": "",
                "value": ""
              },
              {
                "index": "1",
                "name": "",
                "value": ""
              },
              {
                "index": "0",
                "name": "",
                "value": ""
              }
            ],
            "virtual": true,
            "clock": false
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
            "pins": [
              {
                "index": "0",
                "name": "",
                "value": ""
              }
            ],
            "virtual": true,
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
  },
  "dependencies": {
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