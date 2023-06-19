%%BPSKによるディジタル変調
%%入力データ
%%data: 変調元データ
%%出力データ
%%BPSKsymbol: BPSK変調データ
function[BPSKsymbol]=MYbpskMod(data)

BPSKsymbol=ones(size(data));
BPSKsymbol(data == 0)=-1;

return