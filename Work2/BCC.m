%%畳み込み符号のシミュレーション
%%ディジタル変調方式：BPSK, QPSK, 16QAM, 64QAM
%%符号化率 1/2, 2/3, 3/4, 5/6それぞれのBERを算出しグラフを出力

Ndata=180000;   %送るデータのサイズ(bit)
SNR=-2:2:30;    %SN比の範囲
data=MYrandData(Ndata); %データの生成

%それぞれの場合のBER結果を確保
BER_1_2_bpsk=zeros(1,length(SNR));
BER_1_2_qpsk=zeros(1,length(SNR));
BER_1_2_qam_16=zeros(1,length(SNR));
BER_1_2_qam_64=zeros(1,length(SNR));

BER_2_3_bpsk=zeros(1,length(SNR));
BER_2_3_qpsk=zeros(1,length(SNR));
BER_2_3_qam_16=zeros(1,length(SNR));
BER_2_3_qam_64=zeros(1,length(SNR));

BER_3_4_bpsk=zeros(1,length(SNR));
BER_3_4_qpsk=zeros(1,length(SNR));
BER_3_4_qam_16=zeros(1,length(SNR));
BER_3_4_qam_64=zeros(1,length(SNR));

BER_5_6_bpsk=zeros(1,length(SNR));
BER_5_6_qpsk=zeros(1,length(SNR));
BER_5_6_qam_16=zeros(1,length(SNR));
BER_5_6_qam_64=zeros(1,length(SNR));

%QPSK変調器の生成
qpskmod=comm.QPSKModulator('BitInput',true);
qpskdemod=comm.QPSKDemodulator('BitOutput',true,...
    'OutputDataType','double');

%データの畳み込み符号化
[code1,trellis1,puncpat1]=BCCEncode(data,1/2);

[code2,trellis2,puncpat2]=BCCEncode(data,2/3);

[code3,trellis3,puncpat3]=BCCEncode(data,3/4);

[code4,trellis4,puncpat4]=BCCEncode(data,5/6);

for ii=1:length(SNR)
    %符号化率1/2の時の送受信
    %ディジタル変調
    bpskSymbol_1_2=MYbpskMod(code1);
    qpskSymbol_1_2=qpskmod(code1);
    qamSymbol_16_1_2=qammod(code1,16,'InputType','bit');
    qamSymbol_64_1_2=qammod(code1,64,'InputType','bit');

    %ノイズの付加
    noise1_1_2=awgn(bpskSymbol_1_2,SNR(ii),'measured');
    noise2_1_2=awgn(qpskSymbol_1_2,SNR(ii),'measured');
    noise3_1_2=awgn(qamSymbol_16_1_2,SNR(ii),'measured');
    noise4_1_2=awgn(qamSymbol_64_1_2,SNR(ii),'measured');

    %ディジタル復調
    demod_qpsk_1_2=qpskdemod(noise2_1_2);
    demod_qam_16_1_2=qamdemod(noise3_1_2,16,'OutputType','bit');
    demod_qam_64_1_2=qamdemod(noise4_1_2,64,'OutputType','bit');

    %畳み込み復号化
    decodeData1_1_2=BCCDecode(noise1_1_2,trellis1,1/2,puncpat1);
    decodeData2_1_2=BCCDecode(demod_qpsk_1_2,trellis1,1/2,puncpat1);
    decodeData3_1_2=BCCDecode(demod_qam_16_1_2,trellis1,1/2,puncpat1);
    decodeData4_1_2=BCCDecode(demod_qam_64_1_2,trellis1,1/2,puncpat1);

    %BERの計算
    BER_1_2_bpsk(ii)=MYber(decodeData1_1_2,data);
    BER_1_2_qpsk(ii)=MYber(decodeData2_1_2,data);
    BER_1_2_qam_16(ii)=MYber(decodeData3_1_2,data);
    BER_1_2_qam_64(ii)=MYber(decodeData4_1_2,data);
    disp(['符号化率:1/2 BPSK BER:', num2str(BER_1_2_bpsk(ii))])
    disp(['符号化率:1/2 QPSK BER:', num2str(BER_1_2_qpsk(ii))])
    disp(['符号化率:1/2 16QAM BER:', num2str(BER_1_2_qam_16(ii))])
    disp(['符号化率:1/2 64QAM BER:', num2str(BER_1_2_qam_64(ii))])
    disp(newline)
    
    %符号化率2/3の時の送受信
    %ディジタル変調
    bpskSymbol_2_3=MYbpskMod(code2);
    qpskSymbol_2_3=qpskmod(code2);
    qamSymbol_16_2_3=qammod(code2,16,'InputType','bit');
    qamSymbol_64_2_3=qammod(code2,64,'InputType','bit');

    %ノイズの付加
    noise1_2_3=awgn(bpskSymbol_2_3,SNR(ii),'measured');
    noise2_2_3=awgn(qpskSymbol_2_3,SNR(ii),'measured');
    noise3_2_3=awgn(qamSymbol_16_2_3,SNR(ii),'measured');
    noise4_2_3=awgn(qamSymbol_64_2_3,SNR(ii),'measured');

    %ディジタル復調
    demod_qpsk_2_3=qpskdemod(noise2_2_3);
    demod_qam_16_2_3=qamdemod(noise3_2_3,16,'OutputType','bit');
    demod_qam_64_2_3=qamdemod(noise4_2_3,64,'OutputType','bit');

    %畳み込み復号化
    decodeData1_2_3=BCCDecode(noise1_2_3,trellis2,2/3,puncpat2);
    decodeData2_2_3=BCCDecode(demod_qpsk_2_3,trellis2,2/3,puncpat2);
    decodeData3_2_3=BCCDecode(demod_qam_16_2_3,trellis2,2/3,puncpat2);
    decodeData4_2_3=BCCDecode(demod_qam_64_2_3,trellis2,2/3,puncpat2);

    %BERの計算
    BER_2_3_bpsk(ii)=MYber(decodeData1_2_3,data);
    BER_2_3_qpsk(ii)=MYber(decodeData2_2_3,data);
    BER_2_3_qam_16(ii)=MYber(decodeData3_2_3,data);
    BER_2_3_qam_64(ii)=MYber(decodeData4_2_3,data);
    disp(['符号化率:2/3 BPSK BER:', num2str(BER_2_3_bpsk(ii))])
    disp(['符号化率:2/3 QPSK BER:', num2str(BER_2_3_qpsk(ii))])
    disp(['符号化率:2/3 16QAM BER:', num2str(BER_2_2_qam_16(ii))])
    disp(['符号化率:2/3 64QAM BER:', num2str(BER_2_3_qam_64(ii))])
    disp(newline)
    
    %符号化率3/4の時の送受信
    %ディジタル変調
    bpskSymbol_3_4=MYbpskMod(code3);
    qpskSymbol_3_4=qpskmod(code3);
    qamSymbol_16_3_4=qammod(code3,16,'InputType','bit');
    qamSymbol_64_3_4=qammod(code3,64,'InputType','bit');

    %ノイズの付加
    noise1_3_4=awgn(bpskSymbol_3_4,SNR(ii),'measured');
    noise2_3_4=awgn(qpskSymbol_3_4,SNR(ii),'measured');
    noise3_3_4=awgn(qamSymbol_16_3_4,SNR(ii),'measured');
    noise4_3_4=awgn(qamSymbol_64_3_4,SNR(ii),'measured');

    %ディジタル復調
    demod_qpsk_3_4=qpskdemod(noise2_3_4);
    demod_qam_16_3_4=qamdemod(noise3_3_4,16,'OutputType','bit');
    demod_qam_64_3_4=qamdemod(noise4_3_4,64,'OutputType','bit');

    %畳み込み復号化
    decodeData1_3_4=BCCDecode(noise1_3_4,trellis3,3/4,puncpat3);
    decodeData2_3_4=BCCDecode(demod_qpsk_3_4,trellis3,3/4,puncpat3);
    decodeData3_3_4=BCCDecode(demod_qam_16_3_4,trellis3,3/4,puncpat3);
    decodeData4_3_4=BCCDecode(demod_qam_64_3_4,trellis3,3/4,puncpat3);

    %BERの計算
    BER_3_4_bpsk(ii)=MYber(decodeData1_3_4,data);
    BER_3_4_qpsk(ii)=MYber(decodeData2_3_4,data);
    BER_3_4_qam_16(ii)=MYber(decodeData3_3_4,data);
    BER_3_4_qam_64(ii)=MYber(decodeData4_3_4,data);
    disp(['符号化率:3/4 BPSK BER:', num2str(BER_3_4_bpsk(ii))])
    disp(['符号化率:3/4 QPSK BER:', num2str(BER_3_4_qpsk(ii))])
    disp(['符号化率:3/4 16QAM BER:', num2str(BER_3_4_qam_16(ii))])
    disp(['符号化率:3/4 64QAM BER:', num2str(BER_3_4_qam_64(ii))])
    disp(newline)
    
    %符号化率5/6の時の送受信
    %ディジタル変調
    bpskSymbol_5_6=MYbpskMod(code4);
    qpskSymbol_5_6=qpskmod(code4);
    qamSymbol_16_5_6=qammod(code4,16,'InputType','bit');
    qamSymbol_64_5_6=qammod(code4,64,'InputType','bit');

    %ノイズの付加
    noise1_5_6=awgn(bpskSymbol_5_6,SNR(ii),'measured');
    noise2_5_6=awgn(qpskSymbol_5_6,SNR(ii),'measured');
    noise3_5_6=awgn(qamSymbol_16_5_6,SNR(ii),'measured');
    noise4_5_6=awgn(qamSymbol_64_5_6,SNR(ii),'measured');

    %ディジタル復調
    demod_qpsk_5_6=qpskdemod(noise2_5_6);
    demod_qam_16_5_6=qamdemod(noise3_5_6,16,'OutputType','bit');
    demod_qam_64_5_6=qamdemod(noise4_5_6,64,'OutputType','bit');

    %畳み込み復号化
    decodeData1_5_6=BCCDecode(noise1_5_6,trellis4,5/6,puncpat4);
    decodeData2_5_6=BCCDecode(demod_qpsk_5_6,trellis4,5/6,puncpat4);
    decodeData3_5_6=BCCDecode(demod_qam_16_5_6,trellis4,5/6,puncpat4);
    decodeData4_5_6=BCCDecode(demod_qam_64_5_6,trellis4,5/6,puncpat4);

    %BERの計算
    BER_5_6_bpsk(ii)=MYber(decodeData1_5_6,data);
    BER_5_6_qpsk(ii)=MYber(decodeData2_5_6,data);
    BER_5_6_qam_16(ii)=MYber(decodeData3_5_6,data);
    BER_5_6_qam_64(ii)=MYber(decodeData4_5_6,data);
    disp(['符号化率:5/6 BPSK BER:', num2str(BER_5_6_bpsk(ii))])
    disp(['符号化率:5/6 QPSK BER:', num2str(BER_5_6_qpsk(ii))])
    disp(['符号化率:5/6 16QAM BER:', num2str(BER_5_6_qam_16(ii))])
    disp(['符号化率:5/6 64QAM BER:', num2str(BER_5_6_qam_64(ii))])
    disp(newline)
    
end

%実行結果の出力
figure(1);
semilogy(SNR,BER_1_2_bpsk,'-o',SNR,BER_2_3_bpsk,'-s',SNR,BER_3_4_bpsk,...
    '-^',SNR,BER_5_6_bpsk,'-d')
legend('BPSK-1/2','BPSK-2/3','BPSK-3/4','BPSK-5/6')
xlabel('SNR [dB]')
ylabel('BER (Bit Error Rate)')
xlim([-5 30])
ylim([1.e-05 1.e+00])
grid on

figure(2);
semilogy(SNR,BER_1_2_qpsk,'-o',SNR,BER_2_3_qpsk,'-s',SNR,BER_3_4_qpsk,...
    '-^',SNR,BER_5_6_qpsk,'-d')
legend('QPSK-1/2','QPSK-2/3','QPSK-3/4','QPSK-5/6')
xlabel('SNR [dB]')
ylabel('BER (Bit Error Rate)')
xlim([-5 30])
ylim([1.e-05 1.e+00])
grid on

figure(3);
semilogy(SNR,BER_1_2_qam_16,'-o',SNR,BER_2_3_qam_16,'-s',SNR,BER_3_4_qam_16,...
    '-^',SNR,BER_5_6_qam_16,'-d')
legend('16QAM-1/2','16QAM-2/3','16QAM-3/4','16QAM-5/6')
xlabel('SNR [dB]')
ylabel('BER (Bit Error Rate)')
xlim([-5 30])
ylim([1.e-05 1.e+00])
grid on

figure(4);
semilogy(SNR,BER_1_2_qam_64,'-o',SNR,BER_2_3_qam_64,'-s',SNR,BER_3_4_qam_64,...
    '-^',SNR,BER_5_6_qam_64,'-d')
legend('64QAM-1/2','64QAM-2/3','64QAM-3/4','64QAM-5/6')
xlabel('SNR [dB]')
ylabel('BER (Bit Error Rate)')
xlim([-5 30])
ylim([1.e-05 1.e+00])
grid on
