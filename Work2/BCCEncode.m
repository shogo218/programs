%%畳み込み符号を行う関数
%%入力データ
%%data: 送信データ
%%rate: 符号化率
%%出力データ
%%BCCcode: 符号化データ
%%trellis: トレリス構造体
%%puncpat: パンクチャパターン
function[BCCcode,trellis,puncpat]=BCCEncode(data,rate)

trellis=poly2trellis(7,[133 171]);

if strcmp(rate,'1/2') || isequal(rate,1/2)
    puncpat=ones(log2(trellis.numOutputSymbols),1);
elseif strcmp(rate,'2/3') || isequal(rate,2/3)
    puncpat=[1 1 1 0].';
elseif strcmp(rate,'3/4') || isequal(rate,3/4)
    puncpat = [1 1 1 0 0 1].';
elseif strcmp(rate,'5/6') || isequal(rate,5/6)
    puncpat = [1 1 1 0 0 1 1 0 0 1].';
end

BCCcode=convenc(data,trellis,puncpat);
return