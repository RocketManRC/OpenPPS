# OpenPPS
*How to put time in an electronic bottle...*

See my initial notes in Google Docs here:

https://docs.google.com/document/d/1pgH2th--3oKmDTbd7h-_LfCK9mh3-_iBnJRLkP1W2Xk/edit

The first addition to this repo is an IceStudio project for the IceStick FPGA evaluation board that can synchronize to a GPS timing pulse (PPS) and then continue to provide the timing pulses after the GPS is disconnected ("coasting"). This project is called PPS_Coaster_TCXO.ice. In initial testing using an external TCXO oscillator the system appears to drift about 500 us per day.

This has been designed for and tested with u-blox M8N receivers and device management code running on an ESP32. 

The code for the ESP32 uses the following library:

https://github.com/RocketManRC/u-blox-m8
