VerilogImage
============

Implementation in Verilog of a sequential circuit that processes grayscale images and applies filter on images as well as transformation to them (e.g, mirroring and rotation )



In starea 2 am considerat ca doar linia 0 nu are vecini superiori.La fel am procedat si pentru starile 3,4,5 numai ca am considerat si cealalta linie (63), respectiv coloanele (0 si 63) ca nu au vecini la dreapta,inferiori si la stanga. Starea 6 nu face altceva decat sa incrementeze i si j. Una din dificultati a fost ca nu am stiut ca initializarea lui in_row si in_col trebuiau facute cu un ciclu de ceas inaintea extragerii pixelul din in_pix.
