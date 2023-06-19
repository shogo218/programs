%%BER(Bit Error Rate)の計算をする関数
%%入力データ
%%demodData: 受信データ
%%correctdata: 送信データ
%%出力データ
%%BER: BER(Bit Error Rate)の値
function[BER] = MYber(demodData,correctdata)

BER = sum(abs(demodData-correctdata))/(length(demodData));

return