<<<<<<< HEAD
// Generated on 2013-04-22 01:34:21 -0400
=======
// Generated on 2013-04-22 16:21:17 -0400
>>>>>>> 3e2eecf96141f05d050c53dc33d73aad570faa6e
reset: begin
    ACCld = 1'b0;
    ACCclr = 1'b0;
    ACCin = 2'b00;
    PCin = 2'b00;
    PCctrl = 2'b11;
    SPctrl = 2'b01;
    IRld = 1'b0;
    IRclr = 1'b0;
    IRin = 1'b0;
    MARld = 1'b0;
    MARclr = 1'b0;
    MARin = 1'b0;
    CCld = 1'b0;
    CCclr = 1'b0;
    CCin = 1'b0;
    writeSrc = 3'b000;
    indirect = 1'b0;
    addrSrc = 1'b0;
    dataCacheCtrl = 2'b00;
    ldMask = 1'b0;
    clrMask = 1'b0;
    ldIntReg = 1'b0;
    clrIntReg = 1'b0;
    intDisable = 1'b0;
    clrPend = 1'b0;
    ALUctrl = ir[4:2];
    ALUsrc = 1'b0;
    DRAMclr = 1'b1;
    IRAMclr = 1'b1;
    instCacheCtrl = 2'b00;
    devACK = 1'b0;
    outDataReady = 1'b0;
end
intLoad: begin
    ACCld = 1'b0;
    ACCclr = 1'b1;
    ACCin = 2'b00;
    PCin = 2'b00;
    PCctrl = 2'b00;
    SPctrl = 2'b00;
    IRld = 1'b0;
    IRclr = 1'b1;
    IRin = 1'b0;
    MARld = 1'b0;
    MARclr = 1'b1;
    MARin = 1'b0;
    CCld = 1'b0;
    CCclr = 1'b1;
    CCin = 1'b0;
    writeSrc = 3'b000;
    indirect = 1'b0;
    addrSrc = 1'b0;
    dataCacheCtrl = 2'b01;
    ldMask = 1'b0;
    clrMask = 1'b1;
    ldIntReg = 1'b1;
    clrIntReg = 1'b1;
    intDisable = intDisable;
    clrPend = 1'b1;
    ALUctrl = ir[4:2];
    ALUsrc = 1'b0;
    DRAMclr = 1'b1;
    IRAMclr = 1'b1;
    instCacheCtrl = 2'b01;
    devACK = 1'b0;
    outDataReady = 1'b0;
end
intCheck: begin
    ACCld = 1'b0;
    ACCclr = 1'b1;
    ACCin = 2'b00;
    PCin = 2'b00;
    PCctrl = 2'b00;
    SPctrl = 2'b00;
    IRld = 1'b0;
    IRclr = 1'b1;
    IRin = 1'b0;
    MARld = 1'b0;
    MARclr = 1'b1;
    MARin = 1'b0;
    CCld = 1'b0;
    CCclr = 1'b1;
    CCin = 1'b0;
    writeSrc = 3'b000;
    indirect = 1'b0;
    addrSrc = 1'b0;
    dataCacheCtrl = 2'b01;
    ldMask = 1'b0;
    clrMask = 1'b1;
    ldIntReg = 1'b0;
    clrIntReg = 1'b1;
    intDisable = intDisable;
    clrPend = 1'b1;
    ALUctrl = ir[4:2];
    ALUsrc = 1'b0;
    DRAMclr = 1'b1;
    IRAMclr = 1'b1;
    instCacheCtrl = 2'b01;
    devACK = 1'b0;
    outDataReady = 1'b0;
end
intCheck: begin
    ACCld = 1'b0;
    ACCclr = 1'b1;
    ACCin = 2'b00;
    PCin = 2'b00;
    PCctrl = 2'b00;
    SPctrl = 2'b00;
    IRld = 1'b0;
    IRclr = 1'b1;
    IRin = 1'b0;
    MARld = 1'b0;
    MARclr = 1'b1;
    MARin = 1'b0;
    CCld = 1'b0;
    CCclr = 1'b1;
    CCin = 1'b0;
    writeSrc = 3'b000;
    indirect = 1'b0;
    addrSrc = 1'b0;
    dataCacheCtrl = 2'b01;
    ldMask = 1'b0;
    clrMask = 1'b1;
    ldIntReg = 1'b0;
    clrIntReg = 1'b1;
    intDisable = 1'b0;
    clrPend = 1'b1;
    ALUctrl = ir[4:2];
    ALUsrc = 1'b0;
    DRAMclr = 1'b1;
    IRAMclr = 1'b1;
    instCacheCtrl = 2'b01;
    devACK = 1'b0;
    outDataReady = 1'b0;
end
fetch0: begin
    ACCld = 1'b0;
    ACCclr = 1'b1;
    ACCin = 2'b00;
    PCin = 2'b00;
    PCctrl = 2'b00;
    SPctrl = 2'b00;
    IRld = 1'b0;
    IRclr = 1'b1;
    IRin = 1'b0;
    MARld = 1'b0;
    MARclr = 1'b1;
    MARin = 1'b0;
    CCld = 1'b0;
    CCclr = 1'b1;
    CCin = 1'b0;
    writeSrc = 3'b000;
    indirect = 1'b0;
    addrSrc = 1'b0;
    dataCacheCtrl = 2'b01;
    ldMask = 1'b0;
    clrMask = 1'b1;
    ldIntReg = 1'b0;
    clrIntReg = 1'b1;
    intDisable = intDisable;
    clrPend = 1'b1;
    ALUctrl = ir[4:2];
    ALUsrc = 1'b0;
    DRAMclr = 1'b1;
    IRAMclr = 1'b1;
    instCacheCtrl = 2'b10;
    devACK = 1'b0;
    outDataReady = 1'b0;
end
fetch1: begin
    ACCld = 1'b0;
    ACCclr = 1'b1;
    ACCin = 2'b00;
    PCin = 2'b00;
    PCctrl = 2'b00;
    SPctrl = 2'b00;
    IRld = 1'b0;
    IRclr = 1'b1;
    IRin = 1'b0;
    MARld = 1'b0;
    MARclr = 1'b1;
    MARin = 1'b0;
    CCld = 1'b0;
    CCclr = 1'b1;
    CCin = 1'b0;
    writeSrc = 3'b000;
    indirect = 1'b0;
    addrSrc = 1'b0;
    dataCacheCtrl = 2'b01;
    ldMask = 1'b0;
    clrMask = 1'b1;
    ldIntReg = 1'b0;
    clrIntReg = 1'b1;
    intDisable = intDisable;
    clrPend = 1'b1;
    ALUctrl = ir[4:2];
    ALUsrc = 1'b0;
    DRAMclr = 1'b1;
    IRAMclr = 1'b1;
    instCacheCtrl = 2'b01;
    devACK = 1'b0;
    outDataReady = 1'b0;
end
fetch2: begin
    ACCld = 1'b0;
    ACCclr = 1'b1;
    ACCin = 2'b00;
    PCin = 2'b00;
    PCctrl = 2'b10;
    SPctrl = 2'b00;
    IRld = 1'b1;
    IRclr = 1'b1;
    IRin = 1'b1;
    MARld = 1'b1;
    MARclr = 1'b1;
    MARin = 1'b0;
    CCld = 1'b0;
    CCclr = 1'b1;
    CCin = 1'b0;
    writeSrc = 3'b000;
    indirect = 1'b0;
    addrSrc = 1'b0;
    dataCacheCtrl = 2'b01;
    ldMask = 1'b0;
    clrMask = 1'b1;
    ldIntReg = 1'b0;
    clrIntReg = 1'b1;
    intDisable = intDisable;
    clrPend = 1'b1;
    ALUctrl = ir[4:2];
    ALUsrc = 1'b0;
    DRAMclr = 1'b1;
    IRAMclr = 1'b1;
    instCacheCtrl = 2'b01;
    devACK = 1'b0;
    outDataReady = 1'b0;
end
sub0: begin
    ACCld = 1'b0;
    ACCclr = 1'b1;
    ACCin = 2'b00;
    PCin = 2'b00;
    PCctrl = 2'b00;
    SPctrl = 2'b10;
    IRld = 1'b0;
    IRclr = 1'b1;
    IRin = 1'b0;
    MARld = 1'b0;
    MARclr = 1'b1;
    MARin = 1'b0;
    CCld = 1'b0;
    CCclr = 1'b1;
    CCin = 1'b0;
    writeSrc = 3'b000;
    indirect = 1'b0;
    addrSrc = 1'b0;
    dataCacheCtrl = 2'b01;
    ldMask = 1'b0;
    clrMask = 1'b1;
    ldIntReg = 1'b0;
    clrIntReg = 1'b1;
<<<<<<< HEAD
    intDisable = 1'b0;
=======
    intDisable = intDisable;
>>>>>>> 3e2eecf96141f05d050c53dc33d73aad570faa6e
    clrPend = 1'b1;
    ALUctrl = ir[4:2];
    ALUsrc = 1'b0;
    DRAMclr = 1'b1;
    IRAMclr = 1'b1;
    instCacheCtrl = 2'b01;
    devACK = 1'b0;
    outDataReady = 1'b0;
end
sub1: begin
    ACCld = 1'b0;
    ACCclr = 1'b1;
    ACCin = 2'b00;
    PCin = 2'b00;
    PCctrl = 2'b00;
    SPctrl = 2'b00;
    IRld = 1'b0;
    IRclr = 1'b1;
    IRin = 1'b0;
    MARld = 1'b0;
    MARclr = 1'b1;
    MARin = 1'b0;
    CCld = 1'b0;
    CCclr = 1'b1;
    CCin = 1'b0;
    writeSrc = 3'b000;
    indirect = 1'b0;
    addrSrc = 1'b1;
    dataCacheCtrl = 2'b11;
    ldMask = 1'b0;
    clrMask = 1'b1;
    ldIntReg = 1'b0;
    clrIntReg = 1'b1;
<<<<<<< HEAD
    intDisable = 1'b0;
=======
    intDisable = intDisable;
>>>>>>> 3e2eecf96141f05d050c53dc33d73aad570faa6e
    clrPend = 1'b1;
    ALUctrl = ir[4:2];
    ALUsrc = 1'b0;
    DRAMclr = 1'b1;
    IRAMclr = 1'b1;
    instCacheCtrl = 2'b01;
    devACK = 1'b0;
    outDataReady = 1'b0;
end
sub2: begin
    ACCld = 1'b0;
    ACCclr = 1'b1;
    ACCin = 2'b00;
    PCin = 2'b00;
    PCctrl = 2'b00;
    SPctrl = 2'b10;
    IRld = 1'b0;
    IRclr = 1'b1;
    IRin = 1'b0;
    MARld = 1'b0;
    MARclr = 1'b1;
    MARin = 1'b0;
    CCld = 1'b0;
    CCclr = 1'b1;
    CCin = 1'b0;
    writeSrc = 3'b000;
    indirect = 1'b0;
    addrSrc = 1'b0;
    dataCacheCtrl = 2'b01;
    ldMask = 1'b0;
    clrMask = 1'b1;
    ldIntReg = 1'b0;
    clrIntReg = 1'b1;
<<<<<<< HEAD
    intDisable = 1'b0;
=======
    intDisable = intDisable;
>>>>>>> 3e2eecf96141f05d050c53dc33d73aad570faa6e
    clrPend = 1'b1;
    ALUctrl = ir[4:2];
    ALUsrc = 1'b0;
    DRAMclr = 1'b1;
    IRAMclr = 1'b1;
    instCacheCtrl = 2'b01;
    devACK = 1'b0;
    outDataReady = 1'b0;
end
sub3: begin
    ACCld = 1'b0;
    ACCclr = 1'b1;
    ACCin = 2'b00;
    PCin = 2'b00;
    PCctrl = 2'b00;
    SPctrl = 2'b00;
    IRld = 1'b0;
    IRclr = 1'b1;
    IRin = 1'b0;
    MARld = 1'b0;
    MARclr = 1'b1;
    MARin = 1'b0;
    CCld = 1'b0;
    CCclr = 1'b1;
    CCin = 1'b0;
    writeSrc = 3'b001;
    indirect = 1'b0;
    addrSrc = 1'b1;
    dataCacheCtrl = 2'b11;
    ldMask = 1'b0;
    clrMask = 1'b1;
    ldIntReg = 1'b0;
    clrIntReg = 1'b1;
<<<<<<< HEAD
    intDisable = 1'b0;
=======
    intDisable = intDisable;
>>>>>>> 3e2eecf96141f05d050c53dc33d73aad570faa6e
    clrPend = 1'b1;
    ALUctrl = ir[4:2];
    ALUsrc = 1'b0;
    DRAMclr = 1'b1;
    IRAMclr = 1'b1;
    instCacheCtrl = 2'b01;
    devACK = 1'b0;
    outDataReady = 1'b0;
end
sub4: begin
    ACCld = 1'b0;
    ACCclr = 1'b1;
    ACCin = 2'b00;
    PCin = 2'b00;
    PCctrl = 2'b00;
    SPctrl = 2'b10;
    IRld = 1'b0;
    IRclr = 1'b1;
    IRin = 1'b0;
    MARld = 1'b0;
    MARclr = 1'b1;
    MARin = 1'b0;
    CCld = 1'b0;
    CCclr = 1'b1;
    CCin = 1'b0;
    writeSrc = 3'b000;
    indirect = 1'b0;
    addrSrc = 1'b0;
    dataCacheCtrl = 2'b01;
    ldMask = 1'b0;
    clrMask = 1'b1;
    ldIntReg = 1'b0;
    clrIntReg = 1'b1;
<<<<<<< HEAD
    intDisable = 1'b0;
=======
    intDisable = intDisable;
>>>>>>> 3e2eecf96141f05d050c53dc33d73aad570faa6e
    clrPend = 1'b1;
    ALUctrl = ir[4:2];
    ALUsrc = 1'b0;
    DRAMclr = 1'b1;
    IRAMclr = 1'b1;
    instCacheCtrl = 2'b01;
    devACK = 1'b0;
    outDataReady = 1'b0;
end
sub5: begin
    ACCld = 1'b0;
    ACCclr = 1'b1;
    ACCin = 2'b00;
    PCin = 2'b00;
    PCctrl = 2'b00;
    SPctrl = 2'b00;
    IRld = 1'b0;
    IRclr = 1'b1;
    IRin = 1'b0;
    MARld = 1'b0;
    MARclr = 1'b1;
    MARin = 1'b0;
    CCld = 1'b0;
    CCclr = 1'b1;
    CCin = 1'b0;
    writeSrc = 3'b011;
    indirect = 1'b0;
    addrSrc = 1'b1;
    dataCacheCtrl = 2'b11;
    ldMask = 1'b0;
    clrMask = 1'b1;
    ldIntReg = 1'b0;
    clrIntReg = 1'b1;
<<<<<<< HEAD
    intDisable = 1'b0;
=======
    intDisable = intDisable;
>>>>>>> 3e2eecf96141f05d050c53dc33d73aad570faa6e
    clrPend = 1'b1;
    ALUctrl = ir[4:2];
    ALUsrc = 1'b0;
    DRAMclr = 1'b1;
    IRAMclr = 1'b1;
    instCacheCtrl = 2'b01;
    devACK = 1'b0;
    outDataReady = 1'b0;
end
sub6: begin
    ACCld = 1'b0;
    ACCclr = 1'b1;
    ACCin = 2'b00;
    PCin = 2'b00;
    PCctrl = 2'b00;
    SPctrl = 2'b10;
    IRld = 1'b0;
    IRclr = 1'b1;
    IRin = 1'b0;
    MARld = 1'b0;
    MARclr = 1'b1;
    MARin = 1'b0;
    CCld = 1'b0;
    CCclr = 1'b1;
    CCin = 1'b0;
    writeSrc = 3'b000;
    indirect = 1'b0;
    addrSrc = 1'b0;
    dataCacheCtrl = 2'b01;
    ldMask = 1'b0;
    clrMask = 1'b1;
    ldIntReg = 1'b0;
    clrIntReg = 1'b1;
<<<<<<< HEAD
    intDisable = 1'b0;
=======
    intDisable = intDisable;
>>>>>>> 3e2eecf96141f05d050c53dc33d73aad570faa6e
    clrPend = 1'b1;
    ALUctrl = ir[4:2];
    ALUsrc = 1'b0;
    DRAMclr = 1'b1;
    IRAMclr = 1'b1;
    instCacheCtrl = 2'b01;
    devACK = 1'b0;
    outDataReady = 1'b0;
end
sub7: begin
    ACCld = 1'b0;
    ACCclr = 1'b1;
    ACCin = 2'b00;
    PCin = 2'b00;
    PCctrl = 2'b00;
    SPctrl = 2'b00;
    IRld = 1'b0;
    IRclr = 1'b1;
    IRin = 1'b0;
    MARld = 1'b0;
    MARclr = 1'b1;
    MARin = 1'b0;
    CCld = 1'b0;
    CCclr = 1'b1;
    CCin = 1'b0;
    writeSrc = 3'b100;
    indirect = 1'b0;
    addrSrc = 1'b1;
    dataCacheCtrl = 2'b11;
    ldMask = 1'b0;
    clrMask = 1'b1;
    ldIntReg = 1'b0;
    clrIntReg = 1'b1;
<<<<<<< HEAD
    intDisable = 1'b0;
=======
    intDisable = intDisable;
>>>>>>> 3e2eecf96141f05d050c53dc33d73aad570faa6e
    clrPend = 1'b1;
    ALUctrl = ir[4:2];
    ALUsrc = 1'b0;
    DRAMclr = 1'b1;
    IRAMclr = 1'b1;
    instCacheCtrl = 2'b01;
    devACK = 1'b0;
    outDataReady = 1'b0;
end
sub8: begin
    ACCld = 1'b0;
    ACCclr = 1'b1;
    ACCin = 2'b00;
    PCin = 2'b10;
    PCctrl = 2'b01;
    SPctrl = 2'b00;
    IRld = 1'b0;
    IRclr = 1'b1;
    IRin = 1'b0;
    MARld = 1'b0;
    MARclr = 1'b1;
    MARin = 1'b0;
    CCld = 1'b0;
    CCclr = 1'b1;
    CCin = 1'b0;
    writeSrc = 3'b100;
    indirect = 1'b0;
    addrSrc = 1'b0;
    dataCacheCtrl = 2'b01;
    ldMask = 1'b0;
    clrMask = 1'b1;
    ldIntReg = 1'b0;
    clrIntReg = 1'b1;
<<<<<<< HEAD
    intDisable = 1'b0;
=======
    intDisable = intDisable;
>>>>>>> 3e2eecf96141f05d050c53dc33d73aad570faa6e
    clrPend = 1'b1;
    ALUctrl = ir[4:2];
    ALUsrc = 1'b0;
    DRAMclr = 1'b1;
    IRAMclr = 1'b1;
    instCacheCtrl = 2'b01;
    devACK = 1'b0;
    outDataReady = 1'b0;
end
isr: begin
    ACCld = 1'b0;
    ACCclr = 1'b1;
    ACCin = 2'b00;
    PCin = 2'b01;
    PCctrl = 2'b01;
    SPctrl = 2'b00;
    IRld = 1'b0;
    IRclr = 1'b1;
    IRin = 1'b0;
    MARld = 1'b0;
    MARclr = 1'b1;
    MARin = 1'b0;
    CCld = 1'b0;
    CCclr = 1'b0;
    CCin = 1'b0;
    writeSrc = 3'b000;
    indirect = 1'b0;
    addrSrc = 1'b0;
    dataCacheCtrl = 2'b01;
    ldMask = 1'b0;
    clrMask = 1'b1;
    ldIntReg = 1'b0;
    clrIntReg = 1'b1;
    intDisable = 1'b1;
    clrPend = 1'b1;
    ALUctrl = ir[4:2];
    ALUsrc = 1'b0;
    DRAMclr = 1'b1;
    IRAMclr = 1'b1;
    instCacheCtrl = 2'b01;
    devACK = 1'b0;
    outDataReady = 1'b0;
end
alu0: begin
    ACCld = 1'b0;
    ACCclr = 1'b1;
    ACCin = 2'b00;
    PCin = 2'b00;
    PCctrl = 2'b00;
    SPctrl = 2'b00;
    IRld = 1'b0;
    IRclr = 1'b1;
    IRin = 1'b0;
    MARld = 1'b0;
    MARclr = 1'b1;
    MARin = 1'b0;
    CCld = 1'b0;
    CCclr = 1'b1;
    CCin = 1'b0;
    writeSrc = 3'b000;
    indirect = 1'b0;
    addrSrc = 1'b0;
    dataCacheCtrl = 2'b01;
    ldMask = 1'b0;
    clrMask = 1'b1;
    ldIntReg = 1'b0;
    clrIntReg = 1'b1;
    intDisable = intDisable;
    clrPend = 1'b1;
    ALUctrl = ir[4:2];
    ALUsrc = 1'b0;
    DRAMclr = 1'b1;
    IRAMclr = 1'b1;
    instCacheCtrl = 2'b01;
    devACK = 1'b0;
    outDataReady = 1'b0;
end
aluImmed: begin
    ACCld = 1'b1;
    ACCclr = 1'b1;
    ACCin = 2'b10;
    PCin = 2'b00;
    PCctrl = 2'b00;
    SPctrl = 2'b00;
    IRld = 1'b0;
    IRclr = 1'b1;
    IRin = 1'b0;
    MARld = 1'b0;
    MARclr = 1'b1;
    MARin = 1'b0;
    CCld = 1'b1;
    CCclr = 1'b1;
    CCin = 1'b0;
    writeSrc = 3'b000;
    indirect = 1'b0;
    addrSrc = 1'b0;
    dataCacheCtrl = 2'b01;
    ldMask = 1'b0;
    clrMask = 1'b1;
    ldIntReg = 1'b0;
    clrIntReg = 1'b1;
    intDisable = intDisable;
    clrPend = 1'b1;
    ALUctrl = ir[4:2];
    ALUsrc = 1'b0;
    DRAMclr = 1'b1;
    IRAMclr = 1'b1;
    instCacheCtrl = 2'b01;
    devACK = 1'b0;
    outDataReady = 1'b0;
end
alu1: begin
    ACCld = 1'b0;
    ACCclr = 1'b1;
    ACCin = 2'b00;
    PCin = 2'b00;
    PCctrl = 2'b00;
    SPctrl = 2'b00;
    IRld = 1'b0;
    IRclr = 1'b1;
    IRin = 1'b0;
    MARld = 1'b0;
    MARclr = 1'b1;
    MARin = 1'b0;
    CCld = 1'b0;
    CCclr = 1'b1;
    CCin = 1'b0;
    writeSrc = 3'b000;
    indirect = ir[0];
    addrSrc = 1'b0;
    dataCacheCtrl = 2'b10;
    ldMask = 1'b0;
    clrMask = 1'b1;
    ldIntReg = 1'b0;
    clrIntReg = 1'b1;
    intDisable = intDisable;
    clrPend = 1'b1;
    ALUctrl = ir[4:2];
    ALUsrc = 1'b0;
    DRAMclr = 1'b1;
    IRAMclr = 1'b1;
    instCacheCtrl = 2'b01;
    devACK = 1'b0;
    outDataReady = 1'b0;
end
alu2: begin
    ACCld = 1'b1;
    ACCclr = 1'b1;
    ACCin = 2'b10;
    PCin = 2'b00;
    PCctrl = 2'b00;
    SPctrl = 2'b00;
    IRld = 1'b0;
    IRclr = 1'b1;
    IRin = 1'b0;
    MARld = 1'b0;
    MARclr = 1'b1;
    MARin = 1'b0;
    CCld = 1'b1;
    CCclr = 1'b1;
    CCin = 1'b0;
    writeSrc = 3'b000;
    indirect = 1'b0;
    addrSrc = 1'b0;
    dataCacheCtrl = 2'b01;
    ldMask = 1'b0;
    clrMask = 1'b1;
    ldIntReg = 1'b0;
    clrIntReg = 1'b1;
    intDisable = intDisable;
    clrPend = 1'b1;
    ALUctrl = ir[4:2];
    ALUsrc = 1'b1;
    DRAMclr = 1'b1;
    IRAMclr = 1'b1;
    instCacheCtrl = 2'b01;
    devACK = 1'b0;
    outDataReady = 1'b0;
end
load0: begin
    ACCld = 1'b0;
    ACCclr = 1'b1;
    ACCin = 2'b00;
    PCin = 2'b00;
    PCctrl = 2'b00;
    SPctrl = 2'b00;
    IRld = 1'b0;
    IRclr = 1'b1;
    IRin = 1'b0;
    MARld = 1'b0;
    MARclr = 1'b1;
    MARin = 1'b0;
    CCld = 1'b0;
    CCclr = 1'b1;
    CCin = 1'b0;
    writeSrc = 3'b000;
    indirect = 1'b0;
    addrSrc = 1'b0;
    dataCacheCtrl = 2'b01;
    ldMask = 1'b0;
    clrMask = 1'b1;
    ldIntReg = 1'b0;
    clrIntReg = 1'b1;
    intDisable = intDisable;
    clrPend = 1'b1;
    ALUctrl = ir[4:2];
    ALUsrc = 1'b0;
    DRAMclr = 1'b1;
    IRAMclr = 1'b1;
    instCacheCtrl = 2'b01;
    devACK = 1'b0;
    outDataReady = 1'b0;
end
loadImmed: begin
    ACCld = 1'b1;
    ACCclr = 1'b1;
    ACCin = 2'b11;
    PCin = 2'b00;
    PCctrl = 2'b00;
    SPctrl = 2'b00;
    IRld = 1'b0;
    IRclr = 1'b1;
    IRin = 1'b0;
    MARld = 1'b0;
    MARclr = 1'b1;
    MARin = 1'b0;
    CCld = 1'b0;
    CCclr = 1'b1;
    CCin = 1'b0;
    writeSrc = 3'b000;
    indirect = 1'b0;
    addrSrc = 1'b0;
    dataCacheCtrl = 2'b01;
    ldMask = 1'b0;
    clrMask = 1'b1;
    ldIntReg = 1'b0;
    clrIntReg = 1'b1;
    intDisable = intDisable;
    clrPend = 1'b1;
    ALUctrl = ir[4:2];
    ALUsrc = 1'b0;
    DRAMclr = 1'b1;
    IRAMclr = 1'b1;
    instCacheCtrl = 2'b01;
    devACK = 1'b0;
    outDataReady = 1'b0;
end
load1: begin
    ACCld = 1'b0;
    ACCclr = 1'b1;
    ACCin = 2'b00;
    PCin = 2'b00;
    PCctrl = 2'b00;
    SPctrl = 2'b00;
    IRld = 1'b0;
    IRclr = 1'b1;
    IRin = 1'b0;
    MARld = 1'b0;
    MARclr = 1'b1;
    MARin = 1'b0;
    CCld = 1'b0;
    CCclr = 1'b1;
    CCin = 1'b0;
    writeSrc = 3'b000;
    indirect = ir[0];
    addrSrc = 1'b0;
    dataCacheCtrl = 2'b10;
    ldMask = 1'b0;
    clrMask = 1'b1;
    ldIntReg = 1'b0;
    clrIntReg = 1'b1;
    intDisable = intDisable;
    clrPend = 1'b1;
    ALUctrl = ir[4:2];
    ALUsrc = 1'b0;
    DRAMclr = 1'b1;
    IRAMclr = 1'b1;
    instCacheCtrl = 2'b01;
    devACK = 1'b0;
    outDataReady = 1'b0;
end
load2: begin
    ACCld = 1'b1;
    ACCclr = 1'b1;
    ACCin = 2'b01;
    PCin = 2'b00;
    PCctrl = 2'b00;
    SPctrl = 2'b00;
    IRld = 1'b0;
    IRclr = 1'b1;
    IRin = 1'b0;
    MARld = 1'b0;
    MARclr = 1'b1;
    MARin = 1'b0;
    CCld = 1'b0;
    CCclr = 1'b1;
    CCin = 1'b0;
    writeSrc = 3'b000;
    indirect = 1'b0;
    addrSrc = 1'b0;
    dataCacheCtrl = 2'b01;
    ldMask = 1'b0;
    clrMask = 1'b1;
    ldIntReg = 1'b0;
    clrIntReg = 1'b1;
    intDisable = intDisable;
    clrPend = 1'b1;
    ALUctrl = ir[4:2];
    ALUsrc = 1'b0;
    DRAMclr = 1'b1;
    IRAMclr = 1'b1;
    instCacheCtrl = 2'b01;
    devACK = 1'b0;
    outDataReady = 1'b0;
end
store0: begin
    ACCld = 1'b0;
    ACCclr = 1'b1;
    ACCin = 2'b00;
    PCin = 2'b00;
    PCctrl = 2'b00;
    SPctrl = 2'b00;
    IRld = 1'b0;
    IRclr = 1'b1;
    IRin = 1'b0;
    MARld = 1'b0;
    MARclr = 1'b1;
    MARin = 1'b0;
    CCld = 1'b0;
    CCclr = 1'b1;
    CCin = 1'b0;
    writeSrc = 3'b000;
    indirect = ir[0];
    addrSrc = 1'b0;
    dataCacheCtrl = 2'b11;
    ldMask = 1'b0;
    clrMask = 1'b1;
    ldIntReg = 1'b0;
    clrIntReg = 1'b1;
    intDisable = intDisable;
    clrPend = 1'b1;
    ALUctrl = ir[4:2];
    ALUsrc = 1'b0;
    DRAMclr = 1'b1;
    IRAMclr = 1'b1;
    instCacheCtrl = 2'b01;
    devACK = 1'b0;
    outDataReady = 1'b0;
end
lmask: begin
    ACCld = 1'b0;
    ACCclr = 1'b1;
    ACCin = 2'b00;
    PCin = 2'b00;
    PCctrl = 2'b00;
    SPctrl = 2'b00;
    IRld = 1'b0;
    IRclr = 1'b1;
    IRin = 1'b0;
    MARld = 1'b0;
    MARclr = 1'b1;
    MARin = 1'b0;
    CCld = 1'b0;
    CCclr = 1'b1;
    CCin = 1'b0;
    writeSrc = 3'b000;
    indirect = 1'b0;
    addrSrc = 1'b0;
    dataCacheCtrl = 2'b01;
    ldMask = 1'b1;
    clrMask = 1'b1;
    ldIntReg = 1'b0;
    clrIntReg = 1'b1;
    intDisable = intDisable;
    clrPend = 1'b1;
    ALUctrl = ir[4:2];
    ALUsrc = 1'b0;
    DRAMclr = 1'b1;
    IRAMclr = 1'b1;
    instCacheCtrl = 2'b01;
    devACK = 1'b0;
    outDataReady = 1'b0;
end
branch0: begin
    ACCld = 1'b0;
    ACCclr = 1'b1;
    ACCin = 2'b00;
    PCin = 2'b00;
    PCctrl = 2'b00;
    SPctrl = 2'b00;
    IRld = 1'b0;
    IRclr = 1'b1;
    IRin = 1'b0;
    MARld = 1'b0;
    MARclr = 1'b1;
    MARin = 1'b0;
    CCld = 1'b0;
    CCclr = 1'b1;
    CCin = 1'b0;
    writeSrc = 3'b000;
    indirect = 1'b0;
    addrSrc = 1'b0;
    dataCacheCtrl = 2'b01;
    ldMask = 1'b0;
    clrMask = 1'b1;
    ldIntReg = 1'b0;
    clrIntReg = 1'b1;
    intDisable = intDisable;
    clrPend = 1'b1;
    ALUctrl = ir[4:2];
    ALUsrc = 1'b0;
    DRAMclr = 1'b1;
    IRAMclr = 1'b1;
    instCacheCtrl = 2'b01;
    devACK = 1'b0;
    outDataReady = 1'b0;
end
branchImmed: begin
    ACCld = 1'b0;
    ACCclr = 1'b1;
    ACCin = 2'b00;
    PCin = 2'b10;
    PCctrl = 2'b01;
    SPctrl = 2'b00;
    IRld = 1'b0;
    IRclr = 1'b1;
    IRin = 1'b0;
    MARld = 1'b0;
    MARclr = 1'b1;
    MARin = 1'b0;
    CCld = 1'b0;
    CCclr = 1'b1;
    CCin = 1'b0;
    writeSrc = 3'b000;
    indirect = 1'b0;
    addrSrc = 1'b0;
    dataCacheCtrl = 2'b01;
    ldMask = 1'b0;
    clrMask = 1'b1;
    ldIntReg = 1'b0;
    clrIntReg = 1'b1;
    intDisable = intDisable;
    clrPend = 1'b1;
    ALUctrl = ir[4:2];
    ALUsrc = 1'b0;
    DRAMclr = 1'b1;
    IRAMclr = 1'b1;
    instCacheCtrl = 2'b01;
    devACK = 1'b0;
    outDataReady = 1'b0;
end
branch1: begin
    ACCld = 1'b0;
    ACCclr = 1'b1;
    ACCin = 2'b00;
    PCin = 2'b00;
    PCctrl = 2'b00;
    SPctrl = 2'b00;
    IRld = 1'b0;
    IRclr = 1'b1;
    IRin = 1'b0;
    MARld = 1'b0;
    MARclr = 1'b1;
    MARin = 1'b0;
    CCld = 1'b0;
    CCclr = 1'b1;
    CCin = 1'b0;
    writeSrc = 3'b000;
    indirect = ir[0];
    addrSrc = 1'b0;
    dataCacheCtrl = 2'b10;
    ldMask = 1'b0;
    clrMask = 1'b1;
    ldIntReg = 1'b0;
    clrIntReg = 1'b1;
    intDisable = intDisable;
    clrPend = 1'b1;
    ALUctrl = ir[4:2];
    ALUsrc = 1'b0;
    DRAMclr = 1'b1;
    IRAMclr = 1'b1;
    instCacheCtrl = 2'b01;
    devACK = 1'b0;
    outDataReady = 1'b0;
end
branch2: begin
    ACCld = 1'b0;
    ACCclr = 1'b1;
    ACCin = 2'b00;
    PCin = 2'b00;
    PCctrl = 2'b01;
    SPctrl = 2'b00;
    IRld = 1'b0;
    IRclr = 1'b1;
    IRin = 1'b0;
    MARld = 1'b0;
    MARclr = 1'b1;
    MARin = 1'b0;
    CCld = 1'b0;
    CCclr = 1'b1;
    CCin = 1'b0;
    writeSrc = 3'b000;
    indirect = 1'b0;
    addrSrc = 1'b0;
    dataCacheCtrl = 2'b01;
    ldMask = 1'b0;
    clrMask = 1'b1;
    ldIntReg = 1'b0;
    clrIntReg = 1'b1;
    intDisable = intDisable;
    clrPend = 1'b1;
    ALUctrl = ir[4:2];
    ALUsrc = 1'b0;
    DRAMclr = 1'b1;
    IRAMclr = 1'b1;
    instCacheCtrl = 2'b01;
    devACK = 1'b0;
    outDataReady = 1'b0;
end
jump0: begin
    ACCld = 1'b0;
    ACCclr = 1'b1;
    ACCin = 2'b00;
    PCin = 2'b00;
    PCctrl = 2'b00;
    SPctrl = 2'b00;
    IRld = 1'b0;
    IRclr = 1'b1;
    IRin = 1'b0;
    MARld = 1'b0;
    MARclr = 1'b1;
    MARin = 1'b0;
    CCld = 1'b0;
    CCclr = 1'b1;
    CCin = 1'b0;
    writeSrc = 3'b000;
    indirect = 1'b0;
    addrSrc = 1'b0;
    dataCacheCtrl = 2'b01;
    ldMask = 1'b0;
    clrMask = 1'b1;
    ldIntReg = 1'b0;
    clrIntReg = 1'b1;
    intDisable = intDisable;
    clrPend = 1'b1;
    ALUctrl = ir[4:2];
    ALUsrc = 1'b0;
    DRAMclr = 1'b1;
    IRAMclr = 1'b1;
    instCacheCtrl = 2'b01;
    devACK = 1'b0;
    outDataReady = 1'b0;
end
jumpImmed: begin
    ACCld = 1'b0;
    ACCclr = 1'b1;
    ACCin = 2'b00;
    PCin = 2'b10;
    PCctrl = 2'b01;
    SPctrl = 2'b00;
    IRld = 1'b0;
    IRclr = 1'b1;
    IRin = 1'b0;
    MARld = 1'b0;
    MARclr = 1'b1;
    MARin = 1'b0;
    CCld = 1'b0;
    CCclr = 1'b1;
    CCin = 1'b0;
    writeSrc = 3'b000;
    indirect = 1'b0;
    addrSrc = 1'b0;
    dataCacheCtrl = 2'b01;
    ldMask = 1'b0;
    clrMask = 1'b1;
    ldIntReg = 1'b0;
    clrIntReg = 1'b1;
    intDisable = intDisable;
    clrPend = 1'b1;
    ALUctrl = ir[4:2];
    ALUsrc = 1'b0;
    DRAMclr = 1'b1;
    IRAMclr = 1'b1;
    instCacheCtrl = 2'b01;
    devACK = 1'b0;
    outDataReady = 1'b0;
end
jump1: begin
    ACCld = 1'b0;
    ACCclr = 1'b1;
    ACCin = 2'b00;
    PCin = 2'b00;
    PCctrl = 2'b00;
    SPctrl = 2'b00;
    IRld = 1'b0;
    IRclr = 1'b1;
    IRin = 1'b0;
    MARld = 1'b0;
    MARclr = 1'b1;
    MARin = 1'b0;
    CCld = 1'b0;
    CCclr = 1'b1;
    CCin = 1'b0;
    writeSrc = 3'b000;
    indirect = ir[0];
    addrSrc = 1'b0;
    dataCacheCtrl = 2'b10;
    ldMask = 1'b0;
    clrMask = 1'b1;
    ldIntReg = 1'b0;
    clrIntReg = 1'b1;
    intDisable = intDisable;
    clrPend = 1'b1;
    ALUctrl = ir[4:2];
    ALUsrc = 1'b0;
    DRAMclr = 1'b1;
    IRAMclr = 1'b1;
    instCacheCtrl = 2'b01;
    devACK = 1'b0;
    outDataReady = 1'b0;
end
jump2: begin
    ACCld = 1'b0;
    ACCclr = 1'b1;
    ACCin = 2'b00;
    PCin = 2'b00;
    PCctrl = 2'b01;
    SPctrl = 2'b00;
    IRld = 1'b0;
    IRclr = 1'b1;
    IRin = 1'b0;
    MARld = 1'b0;
    MARclr = 1'b1;
    MARin = 1'b0;
    CCld = 1'b0;
    CCclr = 1'b1;
    CCin = 1'b0;
    writeSrc = 3'b000;
    indirect = 1'b0;
    addrSrc = 1'b0;
    dataCacheCtrl = 2'b01;
    ldMask = 1'b0;
    clrMask = 1'b1;
    ldIntReg = 1'b0;
    clrIntReg = 1'b1;
    intDisable = intDisable;
    clrPend = 1'b1;
    ALUctrl = ir[4:2];
    ALUsrc = 1'b0;
    DRAMclr = 1'b1;
    IRAMclr = 1'b1;
    instCacheCtrl = 2'b01;
    devACK = 1'b0;
    outDataReady = 1'b0;
end
in0: begin
    ACCld = 1'b0;
    ACCclr = 1'b1;
    ACCin = 2'b00;
    PCin = 2'b00;
    PCctrl = 2'b00;
    SPctrl = 2'b00;
    IRld = 1'b0;
    IRclr = 1'b1;
    IRin = 1'b0;
    MARld = 1'b0;
    MARclr = 1'b1;
    MARin = 1'b0;
    CCld = 1'b0;
    CCclr = 1'b1;
    CCin = 1'b0;
    writeSrc = 3'b000;
    indirect = 1'b0;
    addrSrc = 1'b0;
    dataCacheCtrl = 2'b01;
    ldMask = 1'b0;
    clrMask = 1'b1;
    ldIntReg = 1'b0;
    clrIntReg = 1'b1;
    intDisable = intDisable;
    clrPend = 1'b1;
    ALUctrl = ir[4:2];
    ALUsrc = 1'b0;
    DRAMclr = 1'b1;
    IRAMclr = 1'b1;
    instCacheCtrl = 2'b01;
    devACK = 1'b0;
    outDataReady = 1'b0;
end
in1: begin
    ACCld = 1'b1;
    ACCclr = 1'b1;
    ACCin = 2'b00;
    PCin = 2'b00;
    PCctrl = 2'b00;
    SPctrl = 2'b00;
    IRld = 1'b0;
    IRclr = 1'b1;
    IRin = 1'b0;
    MARld = 1'b0;
    MARclr = 1'b1;
    MARin = 1'b0;
    CCld = 1'b0;
    CCclr = 1'b1;
    CCin = 1'b0;
    writeSrc = 3'b000;
    indirect = 1'b0;
    addrSrc = 1'b0;
    dataCacheCtrl = 2'b01;
    ldMask = 1'b0;
    clrMask = 1'b1;
    ldIntReg = 1'b0;
    clrIntReg = 1'b1;
    intDisable = intDisable;
    clrPend = 1'b1;
    ALUctrl = ir[4:2];
    ALUsrc = 1'b0;
    DRAMclr = 1'b1;
    IRAMclr = 1'b1;
    instCacheCtrl = 2'b01;
    devACK = 1'b0;
    outDataReady = 1'b0;
end
in2: begin
    ACCld = 1'b0;
    ACCclr = 1'b1;
    ACCin = 2'b00;
    PCin = 2'b00;
    PCctrl = 2'b00;
    SPctrl = 2'b00;
    IRld = 1'b0;
    IRclr = 1'b1;
    IRin = 1'b0;
    MARld = 1'b0;
    MARclr = 1'b1;
    MARin = 1'b0;
    CCld = 1'b0;
    CCclr = 1'b1;
    CCin = 1'b0;
    writeSrc = 3'b000;
    indirect = 1'b0;
    addrSrc = 1'b0;
    dataCacheCtrl = 2'b01;
    ldMask = 1'b0;
    clrMask = 1'b1;
    ldIntReg = 1'b0;
    clrIntReg = 1'b1;
    intDisable = intDisable;
    clrPend = 1'b1;
    ALUctrl = ir[4:2];
    ALUsrc = 1'b0;
    DRAMclr = 1'b1;
    IRAMclr = 1'b1;
    instCacheCtrl = 2'b01;
    devACK = 1'b1;
    outDataReady = 1'b0;
end
out0: begin
    ACCld = 1'b0;
    ACCclr = 1'b1;
    ACCin = 2'b00;
    PCin = 2'b00;
    PCctrl = 2'b00;
    SPctrl = 2'b00;
    IRld = 1'b0;
    IRclr = 1'b1;
    IRin = 1'b0;
    MARld = 1'b0;
    MARclr = 1'b1;
    MARin = 1'b0;
    CCld = 1'b0;
    CCclr = 1'b1;
    CCin = 1'b0;
    writeSrc = 3'b000;
    indirect = 1'b0;
    addrSrc = 1'b0;
    dataCacheCtrl = 2'b01;
    ldMask = 1'b0;
    clrMask = 1'b1;
    ldIntReg = 1'b0;
    clrIntReg = 1'b1;
    intDisable = intDisable;
    clrPend = 1'b1;
    ALUctrl = ir[4:2];
    ALUsrc = 1'b0;
    DRAMclr = 1'b1;
    IRAMclr = 1'b1;
    instCacheCtrl = 2'b01;
    devACK = 1'b0;
    outDataReady = 1'b1;
end
out1: begin
    ACCld = 1'b0;
    ACCclr = 1'b1;
    ACCin = 2'b00;
    PCin = 2'b00;
    PCctrl = 2'b00;
    SPctrl = 2'b00;
    IRld = 1'b0;
    IRclr = 1'b1;
    IRin = 1'b0;
    MARld = 1'b0;
    MARclr = 1'b1;
    MARin = 1'b0;
    CCld = 1'b0;
    CCclr = 1'b1;
    CCin = 1'b0;
    writeSrc = 3'b000;
    indirect = 1'b0;
    addrSrc = 1'b0;
    dataCacheCtrl = 2'b01;
    ldMask = 1'b0;
    clrMask = 1'b1;
    ldIntReg = 1'b0;
    clrIntReg = 1'b1;
    intDisable = intDisable;
    clrPend = 1'b1;
    ALUctrl = ir[4:2];
    ALUsrc = 1'b0;
    DRAMclr = 1'b1;
    IRAMclr = 1'b1;
    instCacheCtrl = 2'b01;
    devACK = 1'b0;
    outDataReady = 1'b0;
end
out2: begin
    ACCld = 1'b0;
    ACCclr = 1'b1;
    ACCin = 2'b00;
    PCin = 2'b00;
    PCctrl = 2'b00;
    SPctrl = 2'b00;
    IRld = 1'b0;
    IRclr = 1'b1;
    IRin = 1'b0;
    MARld = 1'b0;
    MARclr = 1'b1;
    MARin = 1'b0;
    CCld = 1'b0;
    CCclr = 1'b1;
    CCin = 1'b0;
    writeSrc = 3'b000;
    indirect = 1'b0;
    addrSrc = 1'b0;
    dataCacheCtrl = 2'b01;
    ldMask = 1'b0;
    clrMask = 1'b1;
    ldIntReg = 1'b0;
    clrIntReg = 1'b1;
    intDisable = intDisable;
    clrPend = 1'b1;
    ALUctrl = ir[4:2];
    ALUsrc = 1'b0;
    DRAMclr = 1'b1;
    IRAMclr = 1'b1;
    instCacheCtrl = 2'b01;
    devACK = 1'b0;
    outDataReady = 1'b0;
end
ret0: begin
    ACCld = 1'b0;
    ACCclr = 1'b1;
    ACCin = 2'b00;
    PCin = 2'b00;
    PCctrl = 2'b00;
    SPctrl = 2'b00;
    IRld = 1'b0;
    IRclr = 1'b1;
    IRin = 1'b0;
    MARld = 1'b0;
    MARclr = 1'b1;
    MARin = 1'b0;
    CCld = 1'b0;
    CCclr = 1'b1;
    CCin = 1'b0;
    writeSrc = 3'b000;
    indirect = 1'b0;
    addrSrc = 1'b1;
    dataCacheCtrl = 2'b10;
    ldMask = 1'b0;
    clrMask = 1'b1;
    ldIntReg = 1'b0;
    clrIntReg = 1'b1;
<<<<<<< HEAD
    intDisable = 1'b0;
=======
    intDisable = intDisable;
>>>>>>> 3e2eecf96141f05d050c53dc33d73aad570faa6e
    clrPend = 1'b1;
    ALUctrl = ir[4:2];
    ALUsrc = 1'b0;
    DRAMclr = 1'b1;
    IRAMclr = 1'b1;
    instCacheCtrl = 2'b01;
    devACK = 1'b0;
    outDataReady = 1'b0;
end
ret1: begin
    ACCld = 1'b0;
    ACCclr = 1'b1;
    ACCin = 2'b00;
    PCin = 2'b00;
    PCctrl = 2'b00;
    SPctrl = 2'b00;
    IRld = 1'b0;
    IRclr = 1'b1;
    IRin = 1'b0;
    MARld = 1'b1;
    MARclr = 1'b1;
    MARin = 1'b1;
    CCld = 1'b0;
    CCclr = 1'b1;
    CCin = 1'b0;
    writeSrc = 3'b000;
    indirect = 1'b0;
    addrSrc = 1'b0;
    dataCacheCtrl = 2'b01;
    ldMask = 1'b0;
    clrMask = 1'b1;
    ldIntReg = 1'b0;
    clrIntReg = 1'b1;
<<<<<<< HEAD
    intDisable = 1'b0;
=======
    intDisable = intDisable;
>>>>>>> 3e2eecf96141f05d050c53dc33d73aad570faa6e
    clrPend = 1'b1;
    ALUctrl = ir[4:2];
    ALUsrc = 1'b0;
    DRAMclr = 1'b1;
    IRAMclr = 1'b1;
    instCacheCtrl = 2'b01;
    devACK = 1'b0;
    outDataReady = 1'b0;
end
ret2: begin
    ACCld = 1'b0;
    ACCclr = 1'b1;
    ACCin = 2'b00;
    PCin = 2'b00;
    PCctrl = 2'b00;
    SPctrl = 2'b11;
    IRld = 1'b0;
    IRclr = 1'b1;
    IRin = 1'b0;
    MARld = 1'b0;
    MARclr = 1'b1;
    MARin = 1'b0;
    CCld = 1'b0;
    CCclr = 1'b1;
    CCin = 1'b0;
    writeSrc = 3'b000;
    indirect = 1'b0;
    addrSrc = 1'b0;
    dataCacheCtrl = 2'b01;
    ldMask = 1'b0;
    clrMask = 1'b1;
    ldIntReg = 1'b0;
    clrIntReg = 1'b1;
<<<<<<< HEAD
    intDisable = 1'b0;
=======
    intDisable = intDisable;
>>>>>>> 3e2eecf96141f05d050c53dc33d73aad570faa6e
    clrPend = 1'b1;
    ALUctrl = ir[4:2];
    ALUsrc = 1'b0;
    DRAMclr = 1'b1;
    IRAMclr = 1'b1;
    instCacheCtrl = 2'b01;
    devACK = 1'b0;
    outDataReady = 1'b0;
end
ret3: begin
    ACCld = 1'b0;
    ACCclr = 1'b1;
    ACCin = 2'b00;
    PCin = 2'b00;
    PCctrl = 2'b00;
    SPctrl = 2'b00;
    IRld = 1'b0;
    IRclr = 1'b1;
    IRin = 1'b0;
    MARld = 1'b0;
    MARclr = 1'b1;
    MARin = 1'b0;
    CCld = 1'b0;
    CCclr = 1'b1;
    CCin = 1'b0;
    writeSrc = 3'b000;
    indirect = 1'b0;
    addrSrc = 1'b1;
    dataCacheCtrl = 2'b10;
    ldMask = 1'b0;
    clrMask = 1'b1;
    ldIntReg = 1'b0;
    clrIntReg = 1'b1;
<<<<<<< HEAD
    intDisable = 1'b0;
=======
    intDisable = intDisable;
>>>>>>> 3e2eecf96141f05d050c53dc33d73aad570faa6e
    clrPend = 1'b1;
    ALUctrl = ir[4:2];
    ALUsrc = 1'b0;
    DRAMclr = 1'b1;
    IRAMclr = 1'b1;
    instCacheCtrl = 2'b01;
    devACK = 1'b0;
    outDataReady = 1'b0;
end
ret4: begin
    ACCld = 1'b0;
    ACCclr = 1'b1;
    ACCin = 2'b00;
    PCin = 2'b00;
    PCctrl = 2'b00;
    SPctrl = 2'b00;
    IRld = 1'b1;
    IRclr = 1'b1;
    IRin = 1'b0;
    MARld = 1'b0;
    MARclr = 1'b1;
    MARin = 1'b0;
    CCld = 1'b1;
    CCclr = 1'b1;
    CCin = 1'b1;
    writeSrc = 3'b000;
    indirect = 1'b0;
    addrSrc = 1'b0;
    dataCacheCtrl = 2'b01;
    ldMask = 1'b0;
    clrMask = 1'b1;
    ldIntReg = 1'b0;
    clrIntReg = 1'b1;
<<<<<<< HEAD
    intDisable = 1'b0;
=======
    intDisable = intDisable;
>>>>>>> 3e2eecf96141f05d050c53dc33d73aad570faa6e
    clrPend = 1'b1;
    ALUctrl = ir[4:2];
    ALUsrc = 1'b0;
    DRAMclr = 1'b1;
    IRAMclr = 1'b1;
    instCacheCtrl = 2'b01;
    devACK = 1'b0;
    outDataReady = 1'b0;
end
ret5: begin
    ACCld = 1'b0;
    ACCclr = 1'b1;
    ACCin = 2'b00;
    PCin = 2'b00;
    PCctrl = 2'b00;
    SPctrl = 2'b11;
    IRld = 1'b0;
    IRclr = 1'b1;
    IRin = 1'b0;
    MARld = 1'b0;
    MARclr = 1'b1;
    MARin = 1'b0;
    CCld = 1'b0;
    CCclr = 1'b1;
    CCin = 1'b0;
    writeSrc = 3'b000;
    indirect = 1'b0;
    addrSrc = 1'b0;
    dataCacheCtrl = 2'b01;
    ldMask = 1'b0;
    clrMask = 1'b1;
    ldIntReg = 1'b0;
    clrIntReg = 1'b1;
<<<<<<< HEAD
    intDisable = 1'b0;
=======
    intDisable = intDisable;
>>>>>>> 3e2eecf96141f05d050c53dc33d73aad570faa6e
    clrPend = 1'b1;
    ALUctrl = ir[4:2];
    ALUsrc = 1'b0;
    DRAMclr = 1'b1;
    IRAMclr = 1'b1;
    instCacheCtrl = 2'b01;
    devACK = 1'b0;
    outDataReady = 1'b0;
end
ret6: begin
    ACCld = 1'b0;
    ACCclr = 1'b1;
    ACCin = 2'b00;
    PCin = 2'b00;
    PCctrl = 2'b00;
    SPctrl = 2'b00;
    IRld = 1'b0;
    IRclr = 1'b1;
    IRin = 1'b0;
    MARld = 1'b0;
    MARclr = 1'b1;
    MARin = 1'b0;
    CCld = 1'b0;
    CCclr = 1'b1;
    CCin = 1'b0;
    writeSrc = 3'b000;
    indirect = 1'b0;
    addrSrc = 1'b1;
    dataCacheCtrl = 2'b10;
    ldMask = 1'b0;
    clrMask = 1'b1;
    ldIntReg = 1'b0;
    clrIntReg = 1'b1;
<<<<<<< HEAD
    intDisable = 1'b0;
=======
    intDisable = intDisable;
>>>>>>> 3e2eecf96141f05d050c53dc33d73aad570faa6e
    clrPend = 1'b1;
    ALUctrl = ir[4:2];
    ALUsrc = 1'b0;
    DRAMclr = 1'b1;
    IRAMclr = 1'b1;
    instCacheCtrl = 2'b01;
    devACK = 1'b0;
    outDataReady = 1'b0;
end
ret7: begin
    ACCld = 1'b0;
    ACCclr = 1'b1;
    ACCin = 2'b00;
    PCin = 2'b00;
    PCctrl = 2'b01;
    SPctrl = 2'b00;
    IRld = 1'b0;
    IRclr = 1'b1;
    IRin = 1'b0;
    MARld = 1'b0;
    MARclr = 1'b1;
    MARin = 1'b0;
    CCld = 1'b0;
    CCclr = 1'b1;
    CCin = 1'b0;
    writeSrc = 3'b000;
    indirect = 1'b0;
    addrSrc = 1'b0;
    dataCacheCtrl = 2'b01;
    ldMask = 1'b0;
    clrMask = 1'b1;
    ldIntReg = 1'b0;
    clrIntReg = 1'b1;
<<<<<<< HEAD
    intDisable = 1'b0;
=======
    intDisable = intDisable;
>>>>>>> 3e2eecf96141f05d050c53dc33d73aad570faa6e
    clrPend = 1'b1;
    ALUctrl = ir[4:2];
    ALUsrc = 1'b0;
    DRAMclr = 1'b1;
    IRAMclr = 1'b1;
    instCacheCtrl = 2'b01;
    devACK = 1'b0;
    outDataReady = 1'b0;
end
ret8: begin
    ACCld = 1'b0;
    ACCclr = 1'b1;
    ACCin = 2'b00;
    PCin = 2'b00;
    PCctrl = 2'b00;
    SPctrl = 2'b11;
    IRld = 1'b0;
    IRclr = 1'b1;
    IRin = 1'b0;
    MARld = 1'b0;
    MARclr = 1'b1;
    MARin = 1'b0;
    CCld = 1'b0;
    CCclr = 1'b1;
    CCin = 1'b0;
    writeSrc = 3'b000;
    indirect = 1'b0;
    addrSrc = 1'b0;
    dataCacheCtrl = 2'b01;
    ldMask = 1'b0;
    clrMask = 1'b1;
    ldIntReg = 1'b0;
    clrIntReg = 1'b1;
<<<<<<< HEAD
    intDisable = 1'b0;
=======
    intDisable = intDisable;
>>>>>>> 3e2eecf96141f05d050c53dc33d73aad570faa6e
    clrPend = 1'b1;
    ALUctrl = ir[4:2];
    ALUsrc = 1'b0;
    DRAMclr = 1'b1;
    IRAMclr = 1'b1;
    instCacheCtrl = 2'b01;
    devACK = 1'b0;
    outDataReady = 1'b0;
end
ret9: begin
    ACCld = 1'b0;
    ACCclr = 1'b1;
    ACCin = 2'b00;
    PCin = 2'b00;
    PCctrl = 2'b00;
    SPctrl = 2'b00;
    IRld = 1'b0;
    IRclr = 1'b1;
    IRin = 1'b0;
    MARld = 1'b0;
    MARclr = 1'b1;
    MARin = 1'b0;
    CCld = 1'b0;
    CCclr = 1'b1;
    CCin = 1'b0;
    writeSrc = 3'b000;
    indirect = 1'b0;
    addrSrc = 1'b1;
    dataCacheCtrl = 2'b10;
    ldMask = 1'b0;
    clrMask = 1'b1;
    ldIntReg = 1'b0;
    clrIntReg = 1'b1;
<<<<<<< HEAD
    intDisable = 1'b0;
=======
    intDisable = intDisable;
>>>>>>> 3e2eecf96141f05d050c53dc33d73aad570faa6e
    clrPend = 1'b1;
    ALUctrl = ir[4:2];
    ALUsrc = 1'b0;
    DRAMclr = 1'b1;
    IRAMclr = 1'b1;
    instCacheCtrl = 2'b01;
    devACK = 1'b0;
    outDataReady = 1'b0;
end
ret10: begin
    ACCld = 1'b1;
    ACCclr = 1'b1;
    ACCin = 2'b01;
    PCin = 2'b00;
    PCctrl = 2'b00;
    SPctrl = 2'b00;
    IRld = 1'b0;
    IRclr = 1'b1;
    IRin = 1'b0;
    MARld = 1'b0;
    MARclr = 1'b1;
    MARin = 1'b0;
    CCld = 1'b0;
    CCclr = 1'b1;
    CCin = 1'b0;
    writeSrc = 3'b000;
    indirect = 1'b0;
    addrSrc = 1'b0;
    dataCacheCtrl = 2'b01;
    ldMask = 1'b0;
    clrMask = 1'b1;
    ldIntReg = 1'b0;
    clrIntReg = 1'b1;
    intDisable = intDisable;
    clrPend = 1'b1;
    ALUctrl = ir[4:2];
    ALUsrc = 1'b0;
    DRAMclr = 1'b1;
    IRAMclr = 1'b1;
    instCacheCtrl = 2'b01;
    devACK = 1'b0;
    outDataReady = 1'b0;
end
ret11: begin
    ACCld = 1'b0;
    ACCclr = 1'b1;
    ACCin = 2'b00;
    PCin = 2'b00;
    PCctrl = 2'b00;
    SPctrl = 2'b11;
    IRld = 1'b0;
    IRclr = 1'b1;
    IRin = 1'b0;
    MARld = 1'b0;
    MARclr = 1'b1;
    MARin = 1'b0;
    CCld = 1'b0;
    CCclr = 1'b1;
    CCin = 1'b0;
    writeSrc = 3'b000;
    indirect = 1'b0;
    addrSrc = 1'b0;
    dataCacheCtrl = 2'b01;
    ldMask = 1'b0;
    clrMask = 1'b1;
    ldIntReg = 1'b0;
    clrIntReg = 1'b1;
    intDisable = 1'b0;
<<<<<<< HEAD
    clrPend = 1'b1;
    ALUctrl = ir[4:2];
    ALUsrc = 1'b0;
    DRAMclr = 1'b1;
    IRAMclr = 1'b1;
    instCacheCtrl = 2'b01;
    devACK = 1'b0;
    outDataReady = 1'b0;
end
ret11: begin
    ACCld = 1'b0;
    ACCclr = 1'b1;
    ACCin = 2'b00;
    PCin = 2'b00;
    PCctrl = 2'b00;
    SPctrl = 2'b11;
    IRld = 1'b0;
    IRclr = 1'b1;
    IRin = 1'b0;
    MARld = 1'b0;
    MARclr = 1'b1;
    MARin = 1'b0;
    CCld = 1'b0;
    CCclr = 1'b1;
    CCin = 1'b0;
    writeSrc = 3'b000;
    indirect = 1'b0;
    addrSrc = 1'b0;
    dataCacheCtrl = 2'b01;
    ldMask = 1'b0;
    clrMask = 1'b1;
    ldIntReg = 1'b0;
    clrIntReg = 1'b1;
    intDisable = 1'b0;
=======
>>>>>>> 3e2eecf96141f05d050c53dc33d73aad570faa6e
    clrPend = 1'b1;
    ALUctrl = ir[4:2];
    ALUsrc = 1'b0;
    DRAMclr = 1'b1;
    IRAMclr = 1'b1;
    instCacheCtrl = 2'b01;
    devACK = 1'b0;
    outDataReady = 1'b0;
end
default: begin
    ACCld = 1'b0;
    ACCclr = 1'b1;
    ACCin = 2'b00;
    PCin = 2'b00;
    PCctrl = 2'b00;
    SPctrl = 2'b00;
    IRld = 1'b0;
    IRclr = 1'b1;
    IRin = 1'b0;
    MARld = 1'b0;
    MARclr = 1'b1;
    MARin = 1'b0;
    CCld = 1'b0;
    CCclr = 1'b1;
    CCin = 1'b0;
    writeSrc = 3'b000;
    indirect = 1'b0;
    addrSrc = 1'b0;
    dataCacheCtrl = 2'b01;
    ldMask = 1'b0;
    clrMask = 1'b1;
    ldIntReg = 1'b0;
    clrIntReg = 1'b1;
    intDisable = intDisable;
    clrPend = 1'b1;
    ALUctrl = ir[4:2];
    ALUsrc = 1'b0;
    DRAMclr = 1'b1;
    IRAMclr = 1'b1;
    instCacheCtrl = 2'b01;
    devACK = 1'b0;
    outDataReady = 1'b0;
end
