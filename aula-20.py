import time
import functools

# decorator para imprimir o tempo de execucao
def duration(func):
    @functools.wraps(func)
    def wrapper(*args):
        start = time.time()
        result = func(*args)
        end = time.time()
        print(f'Duration: {end-start} seconds')
        return result
    return wrapper

# decorator para construir um string com linhas para a hora e argumentos e saida de cada chamada da funcao. O string sera acessado via atributo
def timedIO(func):
    @functools.wraps(func)
    def wrapper(*args):
        start = time.time()
        result = func(*args)
        wrapper.timedIO += f'hour: {time.strftime("%H")}h | args: {args} | output: {result}\n'
        return result
    wrapper.timedIO = ""
    return wrapper

# decorator para memoizar a funcao. Memoizacao é criar um dicionario que se lembra dos valores de entrada e de saida da funcao ja executado. Se um desses valores de entrada for re-executado, a funcao nao sera re-executada - ela apenas retorna o valor de saida memoizado
def memo(func):
    @functools.wraps(func)
    def wrapper(*args):
        try:
            return wrapper.cache[args]
        except:
            result = func(*args)
            wrapper.cache[args] = result
            return result
    wrapper.cache = dict()
    return wrapper

# decorator para log argumentos e horario num arquivo (append no arquivo) dado como argumento do decorator (ver o primer on decorators)
def log(arq):
    def log_decorator(func):
        @functools.wraps(func)
        def wrapper(*args):
            f = open(arq, 'a')
            f.write(f'hour: {time.strftime("%H")}h | args: {args}\n')
            f.close()
            return func(*args)
        return wrapper
    return log_decorator
