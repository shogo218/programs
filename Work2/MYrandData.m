%%ランダムな送信データを生成
%%入力データ
%%Ndata: データのサイズ(bit)
%%出力データ
%%data: 送信データ
function[data]=MYrandData(Ndata)

data=randi([0 1],Ndata,1);

return