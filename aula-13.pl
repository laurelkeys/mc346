%% ÁRVORE vazia | arv(no, arvEsq, arvDir) %%%%%%%%%%%%%%%%%%%%%

%% acha um item em uma arvore de busca binaria
% existe(+,+).
existe(X, arv(X,_,_)).
existe(X, arv(Y,AE,AD)) :- X < Y -> existe(X, AE) ; existe(X, AD).

%% verifica se uma arvore é um abb
% abb(+).
abb(vazia).
abb(arv(X,AE,AD)) :- abbEsq(X,AE), abbDir(X,AD), !.
% abbEsq(+,+).
abbEsq(_, vazia).
abbEsq(X, arv(Y,AE,AD)) :- Y < X, abbEsq(Y, AE), abbDir(Y, AD), !.
% abbDir(+,+).
abbDir(_, vazia).
abbDir(X, arv(Y,AE,AD)) :- X < Y, abbEsq(Y, AE), abbDir(Y, AD), !.

%% insere um item numa abb
% insere(+,+,-).
insere(X, vazia, arv(X,vazia,vazia)).
insere(X, arv(X,AE,AD), arv(X,AE,AD)).
insere(X, arv(Y,AE,AD), arv(Y,AAE,AD)) :- X < Y, !, insere(X, AE, AAE).
insere(X, arv(Y,AE,AD), arv(Y,AE,AAD)) :- Y < X, !, insere(X, AD, AAD).

%% remove um item de uma abb
% remove(+,+,-).
remove(_, vazia, vazia).
remove(X, arv(X,AE,AD), A) :- removeRaiz(arv(X,AE,AD),A).
remove(X, arv(Y,AE,AD), arv(Y,AAE,AD)) :- X < Y, !, remove(X, AE, AAE).
remove(X, arv(Y,AE,AD), arv(Y,AE,AAD)) :- Y < X, !, remove(X, AD, AAD).
% removeRaiz(+,-).
removeRaiz(vazia, vazia).
removeRaiz(arv(_,vazia,AD), AD).
removeRaiz(arv(_,AE,vazia), AE).
removeRaiz(arv(_,AE,AD), arv(X,AAE,AD)) :- maior(arv(_,AE,AD), X), remove(X, AE, AAE).
% maior(+,-).
maior(arv(X,_,vazia), X).
maior(arv(_,_,AD), maior(AD)).

%% calcula a profundidade maxima de uma abb
% profundidade(+,-).
profundidade(vazia, 0).
profundidade(arv(_,AE,AD), X) :- profundidade(AE, XE), profundidade(AD, XD), (XE > XD -> X is XE+1 ; X is XD+1).

%% converte uma abb numa lista em ordem infixa (arvore-esquerda, no, arvore-direita)
% infixa(+,-).
infixa(vazia, []).
infixa(arv(X,AE,AD), LEXLD) :- infixa(AE, LE), infixa(AD, LD), append(LE, [X], LEX), append(LEX, LD, LEXLD).

%% converte uma abb numa lista em ordem prefixa (no, ae, ad)
% prefixa(+,-).
prefixa(vazia, []).
prefixa(arv(X,AE,AD), XLELD) :- prefixa(AE, LE), prefixa(AD, LD), append([X], LE, XLE), append(XLE, LD, XLELD).

%% converte uma lista em uma abb
% converte(+,-).
converte([X], arv(X,vazia,vazia)).
converte([X|XS], A) :- converte(XS, AA), insere(X, AA, A).

%% DICIONARIO [map(key, value), ...] %%%%%%%%%%%%%%%%%%%%%%%%%%

%% dado um dicionário acesse o valor associado a uma chave, falha se a chave não esta no dicionário
% get(+,+,-).
get(X, [map(X,V)|_], V).
get(X, [_|MS], V) :- get(X, MS, V).

%% insere um par chave valor no dicionário (ou troca o valor associado a chave se ela ja esta no dicionário)
% put(+,+,+,-).
put(X, Y, [], [map(X,Y)]).
put(X, Y, [map(X,_)|MS], [map(X,Y)|MS]).
put(X, Y, [M|MS], [M|MMS]) :- put(X, Y, MS, MMS).

%% remove uma chave (e seu valor) do dicionário.
% remove(+,+,-).
remove(_, [], []).
remove(X, [map(X,_)|MS], MS).
remove(X, [M|MS], [M|MMS]) :- remove(X, MS, MMS).

%% contador: dicionario onde valor associado é um inteiro. 
%% Implemente o soma1 que dado um contador soma um ao valor associado a uma 
%% chave, ou se ela nao estiver no dicionario, acrescenta a chave com valor 1.
% soma1(+,+,-).
soma1(X, [], [map(X,1)]).
soma1(X, [map(X,V)|MS], [map(X,VV)|MS]) :- VV is V+1.
soma1(X, [M|MS], [M|MMS]) :- soma1(X, MS, MMS).
