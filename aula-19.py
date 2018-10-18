# pares: dado um iterator, retorna um iterator com os elementos nas posicoes pares (0,2)
def pares(iterator):
    return (nxt for i, nxt in enumerate(iterator) if i % 2 == 0)

# reverte: dado um iterator, reverte ele *
def reverte(iterator):
    return (nxt for nxt in list(iterator)[-1::-1])

# zip: dado 2 iterators, retorna um iterator que retorna os elementos intercalados
def zip2(iterator1, iterator2):
    while True:
        nxt = [next(it) for it in [iterator1, iterator2]]
        yield tuple(nxt)

# cart: dado 2 iterators, retorna um iterator com o produto cartesiano dos elementos *
def cart(iterator1, iterator2):
    iterable2 = list(iterator2)
    for i1 in iterator1:
        for i2 in iter(iterable2):
            yield (i1, i2)

# ciclo: dado um iterator, retorna os elementos num ciclo infinito
def ciclo(iterator):
    iterable = list(iterator)
    while True:
      for it in iterable:
        yield it

# rangeinf(init,passo=1): retorna um iterator que gera numeros de init ate infinito, com passo
def rangeinf(init, passo=1):
    nxt = init
    while True:
        yield nxt
        nxt += passo

# take: como o take do haskell
def take(n, lst):
    return (lst[i] for i in range(min(n, len(lst))))

# drop: como o drop do haskell
def drop(n, lst):
    return (lst[i] for i in range(n, len(lst)))
