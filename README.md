
# programming-paradigms
Exercises and examples developed while taking Programming Paradigms (MC346) at Unicamp.

It's main focus was the familiarization with the [functional](https://en.wikipedia.org/wiki/Functional_programming) and [logic](https://en.wikipedia.org/wiki/Logic_programming) paradigms, by using Haskell and Prolog. Some neat Python 3 features were also mentioned towards the end of the semester (e.g. iterators, decorators, numpy, etc).

See below a summary of the interesting features/topics covered, linked to their reference files, and the description of the Haskell and Prolog final projects.

## Haskell
### Topics
- Basic syntax, list manipulation and recursion: [#1](https://github.com/laurelkeys/programming-paradigms/blob/master/aula-01.hs) (improved in [#2](https://github.com/laurelkeys/programming-paradigms/blob/master/aula-02.hs))
- [Tail recursion](https://en.wikipedia.org/wiki/Tail_call): [#2](https://github.com/laurelkeys/programming-paradigms/blob/master/aula-02.hs)
- List comprehension: [#3](https://github.com/laurelkeys/programming-paradigms/blob/master/aula-03.hs)
- String splitting: [#4](https://github.com/laurelkeys/programming-paradigms/blob/master/aula-04.hs)
- Binary search tree: [#5](https://github.com/laurelkeys/programming-paradigms/blob/master/aula-05.hs)
- [Currying](https://en.wikipedia.org/wiki/Currying) and higher order functions: [#6](https://github.com/laurelkeys/programming-paradigms/blob/master/aula-06.hs)
- Piping (`$`), function composition (`.`) and matrices: [#7](https://github.com/laurelkeys/programming-paradigms/blob/master/aula-07.hs)
- Finding the most common vowel in a string: [#8](https://github.com/laurelkeys/programming-paradigms/blob/master/aula-08.hs)
- Types, `Maybe` and monads: [#9](https://github.com/laurelkeys/programming-paradigms/blob/master/aula-09.hs)
- Weighted mean calculation from IO input: [#10](https://github.com/laurelkeys/programming-paradigms/blob/master/aula-10.hs)
### [Project](https://github.com/laurelkeys/programming-paradigms/blob/master/projeto-01.hs)
A Google Maps/Waze-ish algorithm to calculate the shortest (quickest) path between two points mixing public transportation and walking, implementing [Dijkstra](https://youtu.be/AKiq3JxCVi4?t=10)'s [SPF algorithm](https://en.wikipedia.org/wiki/Dijkstra%27s_algorithm).
#### Input
**Paths** in the form `origin destination mode time` (walking is defined as `a-pe`); followed by a new line and:
**Transports** in the form `mode wait`, where `wait` is the average wait time untill the public transport (walking wait time is 0 and shouldn't be included here); followed by a newline and:
**Route** in the form `start end`, where these were used as an `origin`/`destination` in the paths.

The above should be added to a file, e.g.:
```
a b a-pe 0.4
b a a-pe 0.6
b c a-pe 0.5 
c b a-pe 0.5
c d a-pe 0.3
d c a-pe 0.3
a d linha-370 0.1
d f a-pe 3
f h linha-567 1.2
f h a-pe 12.3

linha-370 15.0
linha-567 12.0

a h
```
#### Output
The output shows the `origin`/`destination`'s used in the **Paths** intercalated with the modes of transports used to travel between them, such that the given  trajectory is the quickest one from `start` to `end`. 
Following that, the total time is also outputted, e.g.:
```
a a-pe b a-pe c linha-370 f a-pe h a-pe i
17.5
```
#### Usage
Save the input to a file, for example `test-entry.in` and run:
```
>>> runhaskell projeto-01.hs < test-entry.in
```

## Prolog
### Topics
- Binary search tree and dictionary: [#13](https://github.com/laurelkeys/programming-paradigms/blob/master/aula-13.pl)
### [Project](https://github.com/laurelkeys/programming-paradigms/blob/master/projeto-02.pl)
Search for intersections (of at least 4 characters) between endings and beginnings of strings in a list, and assembly of new strings joining the given ones on it's intersections, inspired by DNA recombination.
#### Input
A list of strings added to a file, e.g.:
```
xxxxxababababyyyyyy
yyaaaaaaaaaaa
yyyyyyeeeeeeeeeeeeee
cccccccccccccccxxxxx
fffffffffffffffwwwwww
wwwwwwgggggggggggxx
```
#### Output
The combined strings, e.g.:
```
cccccccccccccccxxxxxababababyyyyyyeeeeeeeeeeeeee
fffffffffffffffwwwwwwgggggggggggxx
yyaaaaaaaaaaa
```
#### Usage
Save the input to a file, for example `test-entry.in`, and run:
```
>>> swipl -q -g main projeto-02.pl < test-entry.in
```

## Python 3
### Topics
- Iterators: [#19](https://github.com/laurelkeys/programming-paradigms/blob/master/aula-19.py)
- Decorators: [#20](https://github.com/laurelkeys/programming-paradigms/blob/master/aula-20.py)
