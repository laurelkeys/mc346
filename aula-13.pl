% arv(7,arv(3,arv(2,vazia,vazia),arv(5,vazia,vazia)),arv(11,arv(9,vazia,vazia),arv(13,vazia,vazia)))
% arv(11,arv(9,arv(7,arv(3,arv(2,vazia,vazia),arv(5,vazia,vazia)),vazia),vazia),arv(13,vazia,vazia))

% acha um item em uma arvore de busca binaria
% existe(+,+).
existe(X, arv(X,_,_)).
existe(X, arv(Y,AE,AD)) :- X < Y -> existe(X, AE) ; existe(X, AD).

% verifica se uma arvore é um abb
% abb(+).
abb(vazia).
abb(arv(X,AE,AD)) :- abbEsq(X,AE), abbDir(X,AD), !.
% abbEsq(+,+).
abbEsq(_, vazia).
abbEsq(X, arv(Y,AE,AD)) :- Y < X, abbEsq(Y, AE), abbDir(Y, AD), !.
% abbDir(+,+).
abbDir(_, vazia).
abbDir(X, arv(Y,AE,AD)) :- X < Y, abbEsq(Y, AE), abbDir(Y, AD), !.

% insere um item numa abb
% insere(+,+,-).
insere(X, vazia, arv(X,vazia,vazia)).
insere(X, arv(X,AE,AD), arv(X,AE,AD)).
insere(X, arv(Y,AE,AD), arv(Y,AAE,AD)) :- X < Y, !, insere(X, AE, AAE).
insere(X, arv(Y,AE,AD), arv(Y,AE,AAD)) :- Y < X, !, insere(X, AD, AAD).

% remove um item de uma abb
% remove(+,+,-).
remove(_, vazia, vazia).
remove(X, arv(X,AE,AD), A) :- removeRaiz(arv(X,AE,AD),A), !.
remove(X, arv(Y,AE,AD), arv(Y,AAE,AD)) :- X < Y, !, remove(X, AE, AAE).
remove(X, arv(Y,AE,AD), arv(Y,AE,AAD)) :- Y < X, !, remove(X, AD, AAD).
% removeRaiz(+,-).
removeRaiz(vazia, vazia).
removeRaiz(arv(_,vazia,AD), AD).
removeRaiz(arv(_,AE,vazia), AE).
removeRaiz(arv(_,AE,AD), arv(X,AAE,AD)) :- maior(arv(_,AE,AD), X), remove(X, AE, AAE), !.
% maior(+,-).
maior(arv(X,_,vazia), X).
maior(arv(_,_,AD), maior(AD)).

% calcula a profundidade maxima de uma abb
% profundidade(+,-).
profundidade(vazia, 0).
profundidade(arv(_,AE,AD), X) :- profundidade(AE, XE), profundidade(AD, XD), (XE > XD -> X is XE+1 ; X is XD+1), !.

% converte uma abb numa lista em ordem infixa (arvore-esquerda, no, arvore-direita)


% converte uma abb numa lista em ordem prefixa (no, ae, ad)


% converte uma lista em uma abb

