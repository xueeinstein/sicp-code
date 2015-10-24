<TeXmacs|1.99.2>

<style|generic>

<\body>
  <doc-data|<doc-title|Chapter 3 - Drawing
  Exercise>|<doc-author|<\author-data|<author-name|Bill Xue>>
    \;
  <|author-data>
    \;
  </author-data>>>

  <with|font-series|bold|Exercise 3.9>

  <em|factorial> recursive version:

  <\session|scheme|default>
    <\input>
      Scheme]\ 
    <|input>
      (define (factorial n)

      \ \ (if (= n 1)

      \ \ \ \ \ \ 1

      \ \ \ \ \ \ (* n (factorial (- n 1)))))
    </input>
  </session>

  <with|gr-mode|<tuple|edit|text-at>|gr-frame|<tuple|scale|1cm|<tuple|0.579992gw|0.460004gh>>|gr-geometry|<tuple|geometry|1par|0.6par>|gr-grid|<tuple|cartesian|<point|0|0>|1>|gr-grid-old|<tuple|cartesian|<point|0|0>|1>|gr-edit-grid|<tuple|cartesian|<point|0|0>|1>|gr-edit-grid-old|<tuple|cartesian|<point|0|0>|1>|gr-grid-aspect|<tuple|<tuple|axes|#808080>|<tuple|1|#c0c0c0>|<tuple|10|#e0e0ff>>|gr-grid-aspect-props|<tuple|<tuple|axes|#808080>|<tuple|1|#c0c0c0>|<tuple|10|#e0e0ff>>|gr-edit-grid-aspect|<tuple|<tuple|axes|none>|<tuple|1|none>|<tuple|10|none>>|<graphics||<cline|<point|-6|3>|<point|-1.0|3.0>|<point|-1.0|1.0>|<point|-6.0|1.0>>|<line|<point|-8|2>|<point|-6.6|2.0>|<point|-7.0|1.7>>|<line|<point|-7|2.3>|<point|-6.6|2.0>>|<text-at|Global
  Env|<point|-8.2|2.4>>|<carc|<point|-4|-0.2>|<point|-3.7|-0.7>|<point|-4.0|-0.6>>|<point|-3.8|-0.4>|<carc|<point|-3.0|-0.7>|<point|-3.45934851809024|-0.4>|<point|-2.8|-0.4>>|<point|-3.1|-0.383872161121195>|<line|<point|-4.0|2.0>|<point|-3.4|2.0>|<point|-3.4|0.0>>|<text-at|factorial:|<point|-5.4|2.0>>|<line|<point|-3.7|0.2>|<point|-3.4|0.0>|<point|-3.16745786432354|0.2>>|<line|<point|-3.1|-0.383872>|<point|-2.4|-0.4>|<point|-2.4|1.0>>|<line|<point|-2.6|0.7>|<point|-2.4|1.0>|<point|-2.2|0.7>>|<line|<point|-3.8|-1.4>|<point|-3.8|-0.4>>|<line|<point|-4|-1.2>|<point|-3.8|-1.4>|<point|-3.6|-1.3>>|arg:
  n|<text-at|arg: n|<point|-4.7|-1.8>>|<text-at|body: (if (= n
  1)|<point|-4.7|-2.2>>|<text-at|1|<point|-3.2|-2.6>>|<text-at|(* n
  (factorial (- n 1))))|<point|-3.3|-3.0>>>>

  <\session|scheme|default>
    <\input>
      Scheme]\ 
    <|input>
      (factorial 6)
    </input>
  </session>

  Using <em|f> representing <em|factorial>

  <with|gr-mode|<tuple|edit|line>|gr-frame|<tuple|scale|1cm|<tuple|0.5gw|0.5gh>>|gr-geometry|<tuple|geometry|1par|0.6par>|gr-grid|<tuple|cartesian|<point|0|0>|1>|gr-grid-old|<tuple|cartesian|<point|0|0>|1>|gr-edit-grid-aspect|<tuple|<tuple|axes|none>|<tuple|1|none>|<tuple|10|none>>|gr-edit-grid|<tuple|cartesian|<point|0|0>|1>|gr-edit-grid-old|<tuple|cartesian|<point|0|0>|1>|<graphics||<cline|<point|-5|4>|<point|7.0|4.0>|<point|7.0|2.0>|<point|-5.0|2.0>>|<line|<point|-7|3>|<point|-5.5|3.0>>|<line|<point|-5.7|2.8>|<point|-5.5|3.0>|<point|-5.7|3.2>>|<text-at|Global
  Env|<point|-7.0|3.3>>|<cline|<point|-6|1>|<point|-4.6|1.0>|<point|-4.6|-1.0>|<point|-6.0|-1.0>>|<cline|<point|-4|1>|<point|-2.6|1.0>|<point|-2.6|-1.0>|<point|-4.0|-1.0>>|<cline|<point|-2|1>|<point|-0.6|1.0>|<point|-0.6|-1.0>|<point|-2.0|-1.0>>|<text-at|n:
  6|<point|-5.7|0>>|<text-at|n: 5|<point|-3.6|0>>|<text-at|n:
  4|<point|-1.6|0.0>>|<text-at|E1|<point|-6.0|-1.4>>|<text-at|E2|<point|-4.0|-1.4>>|<text-at|E3|<point|-2|-1.4>>|<text-at|(*
  6|<point|-6.0|-2.0>>|<text-at|(f 5))|<point|-5.6|-2.4>>|<text-at|(*
  5|<point|-4|-2>>|<text-at|(f 4))|<point|-3.6|-2.4>>|<text-at|(*
  4|<point|-2|-2>>|<text-at|(f 3))|<point|-1.6|-2.4>>|<cline|<point|0|1>|<point|1.3|1.0>|<point|1.3|-1.0>|<point|0.0|-1.0>>|<cline|<point|2|1>|<point|3.4|1.0>|<point|3.4|-1.0>|<point|2.0|-1.0>>|<cline|<point|4|1>|<point|5.3|1.0>|<point|5.3|-1.0>|<point|4.0|-1.0>>|<text-at|n:
  3|<point|0.3|0>>|<text-at|n: 2|<point|2.4|0>>|<text-at|n:
  1|<point|4.4|0>>|<text-at|E4|<point|0|-1.4>>|<text-at|E5|<point|2|-1.4>>|<text-at|E6|<point|4|-1.4>>|<text-at|(*
  3|<point|0|-2>>|<text-at|(f 2))|<point|0.4|-2.4>>|<text-at|(*
  2|<point|2|-2>>|<text-at|(f 1))|<point|2.4|-2.4>>|<text-at|1|<point|4|-2>>|<line|<point|-5|1>|<point|-5.0|2.0>>|<line|<point|-5.24677|1.8>|<point|-5.0|2.0>|<point|-4.8|1.8>>|<line|<point|-3.3|1>|<point|-3.3|2.0>>|<line|<point|-3.5|1.8>|<point|-3.3|2.0>|<point|-3.0|1.8>>|<line|<point|-1.3|1>|<point|-1.3|2.0>>|<line|<point|-1.5|1.8>|<point|-1.3|2.0>|<point|-1.0|1.8>>|<line|<point|0.7|1>|<point|0.7|2.0>>|<line|<point|0.5|1.8>|<point|0.7|2.0>|<point|1.0|1.8>>|<line|<point|2.6|1>|<point|2.6|2.0>>|<line|<point|2.4|1.7>|<point|2.6|2.0>|<point|2.8|1.7>>|<line|<point|4.7|1>|<point|4.7|2.0>>|<line|<point|4.5|1.8>|<point|4.7|2.0>|<point|5.0|1.8>>>>

  \;

  <em|factorial> iteration version

  <\session|scheme|default>
    <\input>
      Scheme]\ 
    <|input>
      (define (factorial n)

      \ \ (fact-iter 1 1 n))

      (define (fact-iter product counter max-count)

      \ \ (if (\<gtr\> counter max-count)

      \ \ \ \ \ \ product

      \ \ \ \ \ \ (fact-iter (* counter product)

      \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ (+ counter 1)

      \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ max-count)))
    </input>
  </session>

  <with|gr-mode|<tuple|edit|text-at>|gr-frame|<tuple|scale|1cm|<tuple|0.490001gw|0.589991gh>>|gr-geometry|<tuple|geometry|1par|0.6par>|gr-grid|<tuple|cartesian|<point|0|0>|1>|gr-grid-old|<tuple|cartesian|<point|0|0>|1>|gr-edit-grid-aspect|<tuple|<tuple|axes|none>|<tuple|1|none>|<tuple|10|none>>|gr-edit-grid|<tuple|cartesian|<point|0|0>|1>|gr-edit-grid-old|<tuple|cartesian|<point|0|0>|1>|<graphics||<line|<point|-7.1|2.0>|<point|-5.6|2.0>>|<line|<point|-5.7|2.2>|<point|-5.5|2.0>|<point|-5.7|1.8>>|<cline|<point|-5.0|3.0>|<point|6.00000645852626|3.0>|<point|6.00000645852626|1.0>|<point|-4.99999354147374|1.0>>|<text-at|factorial:|<point|-4.6|2.0>>|<text-at|Global
  Env|<point|-7.3|2.3>>|<carc|<point|-3|-1>|<point|-3.0|-0.7>|<point|-2.6|-1.0>>|<carc|<point|-2|-0.8>|<point|-2.0|-1.0>|<point|-2.55505102572168|-0.9>>|<point|-2.8|-0.836423549131765>|<point|-2.2|-0.90166125273312>|<line|<point|-2.7|-0.3>|<point|-2.5|-0.5>|<point|-2.3|-0.3>>|<line|<point|-3.11979097764255|2.12147770869163>|<point|-2.5|2.0>|<point|-2.5|-0.5>>|<line|<point|-2.8|-0.836424>|<point|-2.8|-2.0>>|<line|<point|-3.07058|-1.8>|<point|-2.8|-2.0>|<point|-2.6|-1.7>>|<line|<point|-2.2|-0.901661>|<point|-1.7|-0.8>|<point|-1.7|1.0>>|<line|<point|-2|0.7>|<point|-1.7|1.0>|<point|-1.4|0.7>>|<text-at|arg:
  n|<point|-3.6|-2.4>>|<text-at|body: (fact-iter 1 1
  n)|<point|-3.6|-2.8>>|<text-at|fact-iter:|<point|0.6|2.0>>|<carc|<point|2.5|-1>|<point|2.0|-0.7>|<point|2.0|-1.0>>|<carc|<point|3|-1>|<point|2.6|-1.0>|<point|3.0|-0.6>>|<point|2.2|-0.8>|<point|2.7|-0.8>|<line|<point|2.04106|2.12148>|<point|2.5|2.0>|<point|2.5|-0.4>>|<line|<point|2.3|-0.2>|<point|2.5|-0.4>|<point|2.7|-0.2>>|<line|<point|2.2|-0.8>|<point|2.2|-2.0>>|<line|<point|2|-1.7>|<point|2.2|-2.0>|<point|2.4|-1.7>>|<line|<point|2.7|-0.8>|<point|3.6|-0.8>|<point|3.6|1.0>>|<line|<point|3.4|0.7>|<point|3.6|1.0>|<point|4.0|0.7>>|<text-at|arg:
  product, counter, max-count|<point|1.5|-2.4>>|<text-at|body: (if (\<gtr\>
  counter max-count)|<point|1.5|-2.8>>|<text-at|proudct|<point|2.88244146051065|-3.31793226617277>>|<text-at|(fact-iter
  (* counter product)|<point|3.0|-3.7>>|<text-at|(+ counter
  1)|<point|4.48243815319487|-4.11793888080434>>|<text-at|max-count))|<point|4.5|-4.6>>>>

  <\session|scheme|default>
    <\input>
      Scheme]\ 
    <|input>
      (factorial 6)
    </input>
  </session>

  Using <em|f> representing <em|factorial>, <em|i> for <em|fact-iter> <em|p>
  for <em|product>, <em|c> for <em|counter>, <em|m> for <em|max-count>

  <with|gr-mode|<tuple|edit|line>|gr-frame|<tuple|scale|1cm|<tuple|0.5gw|0.410009gh>>|gr-geometry|<tuple|geometry|1par|0.6par>|gr-grid|<tuple|cartesian|<point|0|0>|1>|gr-grid-old|<tuple|cartesian|<point|0|0>|1>|gr-edit-grid-aspect|<tuple|<tuple|axes|none>|<tuple|1|none>|<tuple|10|none>>|gr-edit-grid|<tuple|cartesian|<point|0|0>|1>|gr-edit-grid-old|<tuple|cartesian|<point|0|0>|1>|<graphics||<cline|<point|-5|4>|<point|7.0|4.0>|<point|7.0|2.0>|<point|-5.0|2.0>>|<line|<point|-7|3>|<point|-5.5|3.0>>|<line|<point|-5.8|3.2>|<point|-5.4|3.0>|<point|-5.7|2.8>>|<text-at|Global
  Env|<point|-7.0|3.3>>|<cline|<point|-6|1>|<point|-4.6|1.0>|<point|-4.6|-1.0>|<point|-6.0|-1.0>>|<cline|<point|-4|1>|<point|-2.6|1.0>|<point|-2.6|-1.0>|<point|-4.0|-1.0>>|<cline|<point|-2|1>|<point|-0.6|1.0>|<point|-0.6|-1.0>|<point|-2.0|-1.0>>|<text-at|n:
  6|<point|-5.7|0.0>>|<text-at|E1|<point|-6|-1.5>>|<text-at|(i 1 1
  6)|<point|-6|-2>>|<text-at|E2|<point|-4|-1.5>>|<text-at|p:
  1|<point|-3.7|0.5>>|<text-at|c: 1|<point|-3.7|0>>|<text-at|m:
  6|<point|-3.7|-0.5>>|<text-at|(i 1 2 6)|<point|-4|-2>>|<text-at|p:
  1|<point|-1.7|0.4>>|<text-at|c: 2|<point|-1.7|0>>|<text-at|m:
  6|<point|-1.7|-0.5>>|<text-at|E3|<point|-2|-1.5>>|<text-at|(i 2 3
  6)|<point|-2|-2>>|<cline|<point|0|1>|<point|1.4|1.0>|<point|1.4|-1.0>|<point|0.0|-1.0>>|<cline|<point|2|1>|<point|3.4|1.0>|<point|3.4|-1.0>|<point|2.0|-1.0>>|<cline|<point|5|1>|<point|6.4|1.0>|<point|6.4|-1.0>|<point|5.0|-1.0>>|<text-at|p:
  2|<point|0.4|0.4>>|<text-at|c: 3|<point|0.4|0>>|<text-at|m:
  6|<point|0.4|-0.5>>|<text-at|E4|<point|0|-1.5>>|<text-at|(i 6 4
  6)|<point|0|-2>>|<text-at|p: 6|<point|2.3|0.4>>|<text-at|c:
  4|<point|2.3|0>>|<text-at|m: 6|<point|2.3|-0.5>>|<text-at|E5|<point|2|-1.5>>|<text-at|(i
  24 5 6)|<point|2|-2>>|<text-at|p: 720|<point|5.3|0.4>>|<text-at|c:
  7|<point|5.3|0>>|<text-at|m: 6|<point|5.3|-0.4>>|<text-at|E8|<point|5|-1.5>>|<text-at|720|<point|5|-2>>|<text-at|........|<point|3.8|0>>|<line|<point|-5|1>|<point|-5.0|2.0>>|<line|<point|-5.2|1.8>|<point|-5.0|2.0>|<point|-4.8|1.8>>|<line|<point|-3.3|1.0>|<point|-3.3|2.0>>|<line|<point|-3.4|1.8>|<point|-3.3|2.0>|<point|-3.0|1.7>>|<line|<point|-1.2|1>|<point|-1.2|2.0>>|<line|<point|-1.4|1.7>|<point|-1.2|2.0>|<point|-1.0|1.7>>|<line|<point|0.7|1>|<point|0.7|2.0>>|<line|<point|0.5|1.7>|<point|0.7|2.0>|<point|1.0|1.7>>|<line|<point|2.6|1>|<point|2.6|2.0>>|<line|<point|2.3|1.7>|<point|2.6|2.0>|<point|3.0|1.7>>|<line|<point|5.7|1>|<point|5.7|2.0>>|<line|<point|5.5|1.7>|<point|5.7|2.0>|<point|6.0|1.8>>>>

  \;

  <with|font-series|bold|Exercise 3.10>

  After translating <em|let> into <em|lambda>

  <\session|scheme|default>
    <\input|Scheme] >
      (define make-withdraw

      \ \ (lambda (initial-amount)

      \ \ \ \ ((lambda (balance)

      \ \ \ \ \ \ \ (lambda (amount)

      \ \ \ \ \ \ \ \ \ (if (\<gtr\>= balace amount)

      \ \ \ \ \ \ \ \ \ \ \ \ \ (begin (set! balance (- balance amount))

      \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ balance)

      \ \ \ \ \ \ \ \ \ \ \ \ \ "Insufficient funds")))

      \ \ \ \ \ initial-amount)))
    </input>

    \;
  </session>

  <with|gr-mode|<tuple|edit|text-at>|gr-frame|<tuple|scale|1cm|<tuple|0.5gw|0.5gh>>|gr-geometry|<tuple|geometry|1par|0.6par>|gr-grid|<tuple|cartesian|<point|0|0>|1>|gr-grid-old|<tuple|cartesian|<point|0|0>|1>|gr-edit-grid-aspect|<tuple|<tuple|axes|none>|<tuple|1|none>|<tuple|10|none>>|gr-edit-grid|<tuple|cartesian|<point|0|0>|1>|gr-edit-grid-old|<tuple|cartesian|<point|0|0>|1>|<graphics||<cline|<point|-5|4>|<point|5.0|4.0>|<point|5.0|2.0>|<point|-5.0|2.0>>|<line|<point|-7|3>|<point|-5.7|3.0>>|<line|<point|-6|3.2>|<point|-5.7|3.0>|<point|-6.0|2.8>>|<text-at|Global
  Env|<point|-7.3|3.4>>|<carc|<point|-1.62478960365837|-0.056155281280885>|<point|-1.12478960365837|-0.056155281280885>|<point|-1.32478960365837|0.243844718719115>>|<carc|<point|-0.6|-0.1>|<point|-1.1|-0.1>|<point|-0.9|0.2>>|<point|-1.4|0.0>|<point|-0.9|0.0>|<line|<point|-1.1|0.6>|<point|-1.0|0.4>|<point|-0.8|0.6>>|<line|<point|-1.92254266437359|3.12147770869163>|<point|-1.0|3.0>|<point|-1.0|0.4>>|<text-at|make-withdraw:|<point|-4.7|3.0>>|<line|<point|-0.9|0>|<point|-0.2|-0.0229722300960959>|<point|-0.2|2.0>>|<line|<point|-0.4|1.7>|<point|-0.2|2.0>|<point|0.0|1.7>>|<line|<point|-1.4|0>|<point|-1.4|-1.0>>|<line|<point|-1.6|-0.8>|<point|-1.4|-1.0>|<point|-1.2|-0.8>>|<text-at|arg:
  initial-amount|<point|-2.4|-1.4>>|<text-at|body: ((lambda
  (balance)|<point|-2.4|-2>>|<text-at|....|<point|-1.3|-2.5>>|<text-at|initial-amount)|<point|-1.2|-3>>>>

  <\session|scheme|default>
    <\input>
      Scheme]\ 
    <|input>
      (define W1 (make-withdraw 100))
    </input>
  </session>

  <with|gr-mode|<tuple|edit|text-at>|gr-frame|<tuple|scale|1cm|<tuple|0.5gw|0.539996gh>>|gr-geometry|<tuple|geometry|1par|0.6par>|gr-grid|<tuple|cartesian|<point|0|0>|1>|gr-grid-old|<tuple|cartesian|<point|0|0>|1>|gr-edit-grid-aspect|<tuple|<tuple|axes|none>|<tuple|1|none>|<tuple|10|none>>|gr-edit-grid|<tuple|cartesian|<point|0|0>|1>|gr-edit-grid-old|<tuple|cartesian|<point|0|0>|1>|<graphics||<cline|<point|-5|4>|<point|6.0|4.0>|<point|6.0|2.0>|<point|-5.0|2.0>>|<line|<point|-6.9|3.0>|<point|-5.4|3.0>>|<line|<point|-5.6|3.2>|<point|-5.4|3.0>|<point|-5.6|2.8>>|<text-at|Global
  Env|<point|-7.0|3.3>>|<text-at|make-withdraw:|<point|-4.4|3.4>>|<text-at|W1:|<point|-4.3|2.5>>|<cline|<point|0|1>|<point|3.0|1.0>|<point|3.0|0.0>|<point|0.0|0.0>>|<line|<point|1.5|1>|<point|1.5|2.0>>|<line|<point|1.3|1.8>|<point|1.5|2.0>|<point|1.7|1.8>>|<text-at|initial-amount:
  100|<point|0.0|0.4>>|<text-at|E1|<point|3.5|0.7>>|<text-at|(make-withdraw
  100)|<point|3.5|0.0>>|<cline|<point|0|-1>|<point|3.0|-1.0>|<point|3.0|-2.0>|<point|0.0|-2.0>>|<line|<point|1.5|-1>|<point|1.5|0.0>>|<line|<point|1.3|-0.2>|<point|1.5|0.0>|<point|1.7|-0.2>>|<text-at|balance:
  100|<point|0.4|-1.6>>|<text-at|E2|<point|3.6|-1.4>>|<text-at|((lambda
  (balance) ..) 100)|<point|3.2|-2.0>>|<carc|<point|-3|-1.7>|<point|-3.5|-1.7>|<point|-3.2|-2.0>>|<carc|<point|-3|-1.7>|<point|-2.5|-1.7>|<point|-2.7|-2.0>>|<point|-3.2|-1.8>|<point|-2.8|-1.8>|<line|<point|0|-1.8>|<point|-2.8|-1.8>>|<line|<point|-0.2|-1.6>|<point|0.0|-1.8>|<point|-0.3|-2.0>>|<line|<point|-3.2|-1.8>|<point|-3.2|-2.4>>|<line|<point|-3.4|-2.3>|<point|-3.2|-2.4>|<point|-3.0|-2.3>>|<line|<point|-3.54567|2.62148>|<point|-3.0|2.6>|<point|-3.0|-1.3>>|<line|<point|-3.3|-1>|<point|-3.0|-1.3>|<point|-2.7|-1.0>>|<text-at|arg:
  amount|<point|-4.08305|-2.8>>|<text-at|(begin (set! balance (- balance
  amount))|<point|-2.5|-3.8>>|<text-at|body: (if (\<gtr\>= balance
  amount)|<point|-4.0|-3.3>>|<text-at|balance)|<point|-1.3|-4.3>>|<text-at|``Insufficient
  funds'')|<point|-2.4|-4.7>>>>

  <\session|scheme|default>
    <\input>
      Scheme]\ 
    <|input>
      (W1 50)
    </input>
  </session>

  <with|gr-mode|<tuple|edit|text-at>|gr-frame|<tuple|scale|1cm|<tuple|0.5gw|0.539996gh>>|gr-geometry|<tuple|geometry|1par|0.6par>|gr-grid|<tuple|cartesian|<point|0|0>|1>|gr-grid-old|<tuple|cartesian|<point|0|0>|1>|gr-edit-grid-aspect|<tuple|<tuple|axes|none>|<tuple|1|none>|<tuple|10|none>>|gr-edit-grid|<tuple|cartesian|<point|0|0>|1>|gr-edit-grid-old|<tuple|cartesian|<point|0|0>|1>|<graphics||<cline|<point|-5|4>|<point|6.0|4.0>|<point|6.0|2.0>|<point|-5.0|2.0>>|<line|<point|-6.9|3.0>|<point|-5.4|3.0>>|<line|<point|-5.6|3.2>|<point|-5.4|3.0>|<point|-5.6|2.8>>|<text-at|Global
  Env|<point|-7.0|3.3>>|<text-at|make-withdraw:|<point|-4.4|3.4>>|<text-at|W1:|<point|-4.3|2.5>>|<cline|<point|0|1>|<point|3.0|1.0>|<point|3.0|0.0>|<point|0.0|0.0>>|<line|<point|1.5|1>|<point|1.5|2.0>>|<line|<point|1.3|1.8>|<point|1.5|2.0>|<point|1.7|1.8>>|<text-at|initial-amount:
  100|<point|0.0|0.4>>|<text-at|E1|<point|3.5|0.7>>|<text-at|(make-withdraw
  100)|<point|3.5|0.0>>|<cline|<point|0|-1>|<point|3.0|-1.0>|<point|3.0|-2.0>|<point|0.0|-2.0>>|<line|<point|1.5|-1>|<point|1.5|0.0>>|<line|<point|1.3|-0.2>|<point|1.5|0.0>|<point|1.7|-0.2>>|<text-at|balance:
  100|<point|0.4|-1.6>>|<text-at|E2|<point|3.6|-1.4>>|<text-at|((lambda
  (balance) ..) 100)|<point|3.2|-2.0>>|<carc|<point|-3|-1.7>|<point|-3.5|-1.7>|<point|-3.2|-2.0>>|<carc|<point|-3|-1.7>|<point|-2.5|-1.7>|<point|-2.7|-2.0>>|<point|-3.2|-1.8>|<point|-2.8|-1.8>|<line|<point|0|-1.8>|<point|-2.8|-1.8>>|<line|<point|-0.2|-1.6>|<point|0.0|-1.8>|<point|-0.3|-2.0>>|<line|<point|-3.2|-1.8>|<point|-3.2|-2.4>>|<line|<point|-3.4|-2.3>|<point|-3.2|-2.4>|<point|-3.0|-2.3>>|<line|<point|-3.54567|2.62148>|<point|-3.0|2.6>|<point|-3.0|-1.3>>|<line|<point|-3.3|-1>|<point|-3.0|-1.3>|<point|-2.7|-1.0>>|<text-at|body:
  (if (\<gtr\>= balance amount)|<point|-7.0|-3.0>>|<text-at|arg:
  amount|<point|-7.0|-2.4>>|<text-at|(begin (set! balance (- balance
  amount))|<point|-5.6|-3.5>>|<text-at|balance)|<point|-4.4|-4.0>>|<text-at|``Insufficient
  funds'')|<point|-6.0|-4.4>>|<cline|<point|2|-3>|<point|4.0|-3.0>|<point|4.0|-4.0>|<point|2.0|-4.0>>|<line|<point|2.7|-3>|<point|2.7|-2.0>>|<text-at|amount:
  50|<point|2.2|-3.6>>|<text-at|E3|<point|4.3|-3.3>>|<line|<point|2.5|-2.2>|<point|2.7|-2.0>|<point|3.0|-2.2>>|<text-at|(if
  ....|<point|4.4|-3.8>>>>

  <\session|scheme|default>
    <\input>
      Scheme]\ 
    <|input>
      (define W2 (make-withdraw 100))
    </input>
  </session>

  It makes almost a copy of <em|W1>, which has its own <em|E1>, <em|E2>

  \;

  <with|font-series|bold|Exercise 3.11>

  <\input|Scheme] >
    (define (make-account balance)

    \ \ (define (withdraw amount)

    \ \ \ \ (if (\<gtr\>= balance amount)

    \ \ \ \ \ \ \ \ (begin (set! balance (- balance amount))

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ balance)

    \ \ \ \ \ \ \ \ "Insufficient funds"))

    \ \ (define (deposit amount)

    \ \ \ \ (set! balance (+ balance amount))

    \ \ \ \ balance)

    \ \ (define (dispatch m)

    \ \ \ \ (cond ((eq? m 'withdraw) withdraw)

    \ \ \ \ \ \ \ \ \ \ ((eq? m 'deposit) deposit)

    \ \ \ \ \ \ \ \ \ \ (else (error "Unknown request -- MAKE-ACCOUNT"

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ m))))

    \ \ dispatch)
  </input>

  <\input|Scheme] >
    (define acc (make-account 50))
  </input>

  Currently, the environment model is (procedure binded to <em|deposit> is
  omitted in <em|E1>):

  <with|gr-mode|<tuple|edit|line>|gr-frame|<tuple|scale|1cm|<tuple|0.5gw|0.450005gh>>|gr-geometry|<tuple|geometry|1par|0.6par>|gr-grid|<tuple|cartesian|<point|0|0>|1>|gr-grid-old|<tuple|cartesian|<point|0|0>|1>|gr-edit-grid-aspect|<tuple|<tuple|axes|none>|<tuple|1|none>|<tuple|10|none>>|gr-edit-grid|<tuple|cartesian|<point|0|0>|1>|gr-edit-grid-old|<tuple|cartesian|<point|0|0>|1>|<graphics||<cline|<point|-6|4>|<point|6.0|4.0>|<point|6.0|3.0>|<point|-6.0|3.0>>|<text-at|make-account:|<point|-5.8|3.4>>|<text-at|acc:|<point|-1|3.4>>|<carc|<point|-4|1>|<point|-3.5|1.0>|<point|-3.7|1.3>>|<carc|<point|-3|1>|<point|-3.5|1.0>|<point|-3.3|1.3>>|<point|-3.7|1>|<point|-3.2|1>|<line|<point|-3.47824|3.52146>|<point|-3.5|1.4>>|<line|<point|-3.7|1.6>|<point|-3.5|1.3>|<point|-3.4|1.6>>|<line|<point|-3.2|1>|<point|-2.8|1.0>|<point|-2.8|3.0>>|<line|<point|-3|2.8>|<point|-2.8|3.0>|<point|-2.6|2.8>>|<line|<point|-3.7|1>|<point|-4.6|1.0>>|<line|<point|-4.4|1.2>|<point|-4.6|1.0>|<point|-4.4|0.8>>|<text-at|arg:
  balance|<point|-6.7|1>>|<text-at|body: (define
  withdraw...)|<point|-7.0|0.5>>|<text-at|(define
  deposit...)|<point|-6|0>>|<text-at|(define
  dispatch...)|<point|-6|-0.5>>|<text-at|dispatch|<point|-6|-1>>|<line|<point|3|2>|<point|3.0|3.0>>|<line|<point|2.8|2.8>|<point|3.0|3.0>|<point|3.2|2.8>>|<text-at|E1|<point|2.03105633298997|2.2>>|<text-at|balance:
  50|<point|2.2|1.5>>|<text-at|withdraw:|<point|2.2|1.0>>|<text-at|deposit:|<point|2.2|0.5>>|<text-at|dispatch:|<point|2.2|0.0>>|<cline|<point|2|2>|<point|4.0|2.0>|<point|4.0|-0.3>|<point|2.0|-0.3>>|<carc|<point|5.5|-1>|<point|5.0|-1.0>|<point|5.3|-0.7>>|<carc|<point|5.5|-1>|<point|6.0|-1.0>|<point|5.7|-0.7>>|<point|5.2|-1>|<point|5.7|-1>|<line|<point|3.72637|1.06671>|<point|5.5|1.0>|<point|5.5|-0.6>>|<line|<point|5.3|-0.4>|<point|5.5|-0.7>|<point|5.6|-0.4>>|<line|<point|5.7|-1>|<point|6.5|-1.0>|<point|6.5|2.0>|<point|4.0|2.0>>|<line|<point|4.3|1.8>|<point|4.0|2.0>|<point|4.2|2.2>>|<line|<point|5.2|-1>|<point|5.2|-2.0>>|<line|<point|5|-1.8>|<point|5.2|-2.0>|<point|5.4|-1.8>>|<text-at|arg:
  amount|<point|4.5|-2.4>>|<text-at|body: (if (\<gtr\>= balance
  ...|<point|3.5|-2.8>>||<carc|<point|0.5|-1>|<point|0.2|-0.7>|<point|0.0|-1.0>>|<carc|<point|1|-1>|<point|0.5|-1.0>|<point|0.8|-0.7>>|<point|0.3|-1>|<point|0.7|-1>|<line|<point|-0.294649|3.47591>|<point|0.4|3.5>|<point|0.4|-0.6>>|<line|<point|0.2|-0.5>|<point|0.4|-0.6>|<point|0.6|-0.4>>|<line|<point|2.08243|0.0871808>|<point|1.0|0.0>|<point|0.6|-0.6>>|<line|<point|0.5|-0.4>|<point|0.6|-0.6>|<point|1.0|-0.5>>|<line|<point|0.7|-1>|<point|2.7|-1.0>|<point|2.7|-0.3>>|<line|<point|2.5|-0.5>|<point|2.7|-0.3>|<point|3.0|-0.5>>|<line|<point|0.3|-1>|<point|0.3|-1.7>>|<line|<point|0.0|-1.5>|<point|0.3|-1.7>|<point|0.5|-1.5>>|<text-at|Global
  Env|<point|-7.0|4.4>>|<text-at|arg: m|<point|-0.7|-2.0>>|<text-at|body:
  (cond ((eq? m ....|<point|-1.0|-2.5>>|<text-at|(make-account
  50)|<point|3.4|2.2>>|<text-at||<point|7.3|-4>>>>

  <\unfolded-io|Scheme] >
    ((acc 'deposit) 40)
  <|unfolded-io>
    90
  </unfolded-io>

  <with|gr-grid|<tuple|cartesian|<point|0|0>|1>|gr-grid-old|<tuple|cartesian|<point|0|0>|1>|gr-edit-grid-aspect|<tuple|<tuple|axes|none>|<tuple|1|none>|<tuple|10|none>>|gr-edit-grid|<tuple|cartesian|<point|0|0>|1>|gr-edit-grid-old|<tuple|cartesian|<point|0|0>|1>|gr-mode|<tuple|edit|text-at>|gr-frame|<tuple|scale|1cm|<tuple|0.490001gw|0.5gh>>|<graphics||<text-at|make-account|<point|-6.8|3.3>>|<text-at|Global
  Env|<point|-4.4|4.0>>|<with|magnify|1.17469496333334|<cline|<point|-6.97469496333334|4.00000322926313>|<point|-4.62530503666666|4.00000322926313>|<point|-4.6|2.0>|<point|-7.0|2.0>>>|<text-at|acc:|<point|-6.0|2.5>>|<cline|<point|-1|4>|<point|6.0|4.0>|<point|6.0|2.0>|<point|-1.0|2.0>>|<text-at|E1|<point|-1.6|3.3>>|<text-at|(make-account
  50)|<point|-4.0|2.7>>|<text-at|balance:
  50|<point|-0.6|3.5>>|<text-at|dispatch:|<point|-0.6|2.7>>|<carc|<point|-5.4|0>|<point|-5.0|0.0>|<point|-5.2|-0.2>>|<carc|<point|-5|0>|<point|-4.6|0.0>|<point|-4.8|-0.181314565260031>>|<point|-5.2|0>|<point|-4.8|0>|<line|<point|-5.29465|2.57592>|<point|-5.0|2.6>|<point|-5.0|0.3>>|<line|<point|-5.2|0.5>|<point|-5.0|0.3>|<point|-4.8|0.5>>|<line|<point|-4.8|0>|<point|0.0|0.0>|<point|0.0|2.0>>|<line|<point|-0.3|1.8>|<point|0.0|2.0>|<point|0.2|1.7>>|<line|<point|-0.3|2.6>|<point|-0.7|1.7>|<point|-4.6|1.7>|<point|-5.0|0.3>>|<line|<point|-5.2|0>|<point|-5.2|-1.0>>|<line|<point|-5|-0.8>|<point|-5.2|-1.0>|<point|-5.4|-0.8>>|<text-at|arg:
  m|<point|-6|-1.4>>|<text-at|body: ((eq? m
  ...|<point|-6.3|-2.0>>|<cline|<point|0|-1>|<point|2.0|-1.0>|<point|2.0|-3.0>|<point|0.0|-3.0>>|<cline|<point|3|-1>|<point|5.0|-1.0>|<point|5.0|-3.0>|<point|3.0|-3.0>>|<text-at|m:
  'deposit|<point|0.2|-2.0>>|<text-at|E2|<point|0|-3.5>>|<text-at|(dispatch
  'deposit)|<point|-0.7|-4.0>>|<text-at|E3|<point|3.0|-3.5>>|<text-at|(deposit
  40)|<point|3|-4>>|<text-at|amount: 40|<point|3.2|-2.0>>|<text-at|withdraw:|<point|1.4|2.7>>|<text-at|deposit:|<point|3.6|2.7>>|<line|<point|1|-1>|<point|1.0|2.0>>|<line|<point|0.8|1.7>|<point|1.0|2.0>|<point|1.2|1.7>>|<line|<point|3.5|-1>|<point|3.5|2.0>>|<line|<point|3.3|1.7>|<point|3.5|2.0>|<point|3.7|1.7>>|<carc|<point|5.5|0>|<point|5.0|0.0>|<point|5.3|0.3>>|<carc|<point|5.5|0>|<point|6.0|0.0>|<point|5.7|0.3>>|<point|5.3|0>|<point|5.7|0>|<line|<point|4.92448|2.78717>|<point|5.5|2.8>|<point|5.5|0.4>>|<line|<point|5.3|0.6>|<point|5.5|0.4>|<point|5.7|0.6>>|<line|<point|5.7|0>|<point|6.6|0.0>|<point|6.6|2.3>|<point|6.0|2.3>>|<line|<point|6.2|2.5>|<point|6.0|2.3>|<point|6.2|2.0>>|<line|<point|5.3|0>|<point|5.7|-1.0>>|<line|<point|5.4|-1>|<point|5.7|-1.0>|<point|5.8|-0.7>>|<text-at|arg:
  amount|<point|5.4|-1.4>>|<text-at|body: (set!
  ...|<point|5.3|-2.0>>|<text-at||<point|7.3|-4.2>>>>

  <\unfolded-io|Scheme] >
    ((acc 'withdraw) 60)
  <|unfolded-io>
    30
  </unfolded-io>

  Currently, the <em|balance> in <em|E1> has been updated to 90.

  When given the parameter <em|m> to <em|acc>, it generates a new environment
  <em|E4>, not to update <em|E2>.

  <with|gr-grid|<tuple|cartesian|<point|0|0>|1>|gr-grid-old|<tuple|cartesian|<point|0|0>|1>|gr-edit-grid-aspect|<tuple|<tuple|axes|none>|<tuple|1|none>|<tuple|10|none>>|gr-edit-grid|<tuple|cartesian|<point|0|0>|1>|gr-edit-grid-old|<tuple|cartesian|<point|0|0>|1>|gr-mode|<tuple|edit|text-at>|gr-frame|<tuple|scale|1cm|<tuple|0.490001gw|0.5gh>>|<graphics||<text-at|make-account|<point|-6.8|3.3>>|<text-at|Global
  Env|<point|-4.4|4.0>>|<with|magnify|1.17469496333334|<cline|<point|-6.97469496333334|4.00000322926313>|<point|-4.62530503666666|4.00000322926313>|<point|-4.6|2.0>|<point|-7.0|2.0>>>|<text-at|acc:|<point|-6.0|2.5>>|<cline|<point|-1|4>|<point|6.0|4.0>|<point|6.0|2.0>|<point|-1.0|2.0>>|<text-at|E1|<point|-1.6|3.3>>|<text-at|(make-account
  50)|<point|-4.0|2.7>>|<text-at|balance:
  90|<point|-0.6|3.5>>|<text-at|dispatch:|<point|-0.6|2.7>>|<carc|<point|-5.4|0>|<point|-5.0|0.0>|<point|-5.2|-0.2>>|<carc|<point|-5|0>|<point|-4.6|0.0>|<point|-4.8|-0.181314565260031>>|<point|-5.2|0>|<point|-4.8|0>|<line|<point|-5.29465|2.57592>|<point|-5.0|2.6>|<point|-5.0|0.3>>|<line|<point|-5.2|0.5>|<point|-5.0|0.3>|<point|-4.8|0.5>>|<line|<point|-4.8|0>|<point|0.0|0.0>|<point|0.0|2.0>>|<line|<point|-0.3|1.8>|<point|0.0|2.0>|<point|0.2|1.7>>|<line|<point|-0.3|2.6>|<point|-0.7|1.7>|<point|-4.6|1.7>|<point|-5.0|0.3>>|<line|<point|-5.2|0>|<point|-5.2|-1.0>>|<line|<point|-5|-0.8>|<point|-5.2|-1.0>|<point|-5.4|-0.8>>|<text-at|arg:
  m|<point|-6|-1.4>>|<text-at|body: ((eq? m
  ...|<point|-6.3|-2.0>>|<cline|<point|3|-1>|<point|5.0|-1.0>|<point|5.0|-3.0>|<point|3.0|-3.0>>|<text-at|(dispatch
  'withdraw)|<point|-0.7|-4.0>>|<text-at|E5|<point|3.0|-3.5>>|<text-at|(withdraw
  60)|<point|3|-4>>|<text-at|amount: 60|<point|3.2|-2.0>>|<line|<point|1|-1>|<point|1.0|2.0>>|<line|<point|0.8|1.7>|<point|1.0|2.0>|<point|1.2|1.7>>|<line|<point|3.5|-1>|<point|3.5|2.0>>|<line|<point|3.3|1.7>|<point|3.5|2.0>|<point|3.7|1.7>>|<carc|<point|5.5|0>|<point|5.0|0.0>|<point|5.3|0.3>>|<carc|<point|5.5|0>|<point|6.0|0.0>|<point|5.7|0.3>>|<point|5.3|0>|<point|5.7|0>|<line|<point|4.92448|2.78717>|<point|5.5|2.8>|<point|5.5|0.4>>|<line|<point|5.3|0.6>|<point|5.5|0.4>|<point|5.7|0.6>>|<line|<point|5.7|0>|<point|6.6|0.0>|<point|6.6|2.3>|<point|6.0|2.3>>|<line|<point|6.2|2.5>|<point|6.0|2.3>|<point|6.2|2.0>>|<line|<point|5.3|0>|<point|5.7|-1.0>>|<line|<point|5.4|-1>|<point|5.7|-1.0>|<point|5.8|-0.7>>|<text-at|arg:
  amount|<point|5.4|-1.4>>|<text-at|body: (if
  ...|<point|5.3|-2.0>>|<text-at|deposit:|<point|1.4|2.7>>|<text-at|withdraw:|<point|3.4|2.7>>|<cline|<point|-0.60001322926313|-1.0>|<point|2.0|-1.0>|<point|2.0|-3.0>|<point|-0.6|-3.0>>|<text-at|m:
  'withdraw|<point|-0.3|-2.0>>|<text-at|E4|<point|-0.6|-3.5>>>>

  \;

  As we can see, the local state of <em|acc> is stored in <em|balance> of
  <em|E1>

  <\session|scheme|default>
    <\input>
      Scheme]\ 
    <|input>
      (define acc2 (make-account 100))
    </input>
  </session>

  The <em|acc2> doesn't share any procedures and variables with <em|acc>

  \;

  <with|font-series|bold|Exercise 3.20>

  <\session|scheme|default>
    <\input|Scheme] >
      (define (cons x y)

      \ \ (define (set-x! v) (set! x v))

      \ \ (define (set-y! v) (set! y v))

      \ \ (define (dispatch m)

      \ \ \ \ (cond ((eq? m 'car) x)

      \ \ \ \ \ \ \ \ \ \ ((eq? m 'cdr) y)

      \ \ \ \ \ \ \ \ \ \ ((eq? m 'set-car!) set-x!)

      \ \ \ \ \ \ \ \ \ \ ((eq? m 'set-cdr!) set-y!)

      \ \ \ \ \ \ \ \ \ \ (else

      \ \ \ \ \ \ \ \ \ \ \ \ (error "Undefined operation -- CONS" m))))

      \ \ dispatch)
    </input>

    <\input|Scheme] >
      (define (car z) (z 'car))
    </input>

    <\input|Scheme] >
      (define (cdr z) (z 'cdr))
    </input>

    <\input|Scheme] >
      (define (set-car! z new-value)

      \ \ ((z 'set-car!) new-value)

      \ \ z)
    </input>

    <\input|Scheme] >
      (define (set-cdr! z new-value)

      \ \ ((z 'set-cdr!) new-value)

      \ \ z)
    </input>

    \;

    Currently, the environment model is:

    <with|gr-mode|<tuple|edit|text-at>|gr-frame|<tuple|scale|1cm|<tuple|0.5gw|0.430007gh>>|gr-geometry|<tuple|geometry|1par|0.6par>|gr-grid|<tuple|cartesian|<point|0|0>|1>|gr-grid-old|<tuple|cartesian|<point|0|0>|1>|gr-edit-grid-aspect|<tuple|<tuple|axes|none>|<tuple|1|none>|<tuple|10|none>>|gr-edit-grid|<tuple|cartesian|<point|0|0>|1>|gr-edit-grid-old|<tuple|cartesian|<point|0|0>|1>|<graphics||<cline|<point|-5|4>|<point|6.0|4.0>|<point|6.0|2.0>|<point|-5.0|2.0>>|<line|<point|-5.6|3>|<point|-7.0|3.0>>|<line|<point|-5.8|3.2>|<point|-5.6|3.0>|<point|-5.8|2.8>>|<text-at|Global
    Env|<point|-7.3|3.3>>|<text-at|cons:|<point|-4.6|3>>|<text-at|car:|<point|-2.5|3>>|<text-at|cdr:|<point|-0.6|3>>|<text-at|set-car!:|<point|1.5|3>>|<text-at|set-cdr!:|<point|4|3>>|<carc|<point|-3.5|0>|<point|-4.0|0.0>|<point|-3.8|0.2>>|<carc|<point|-3|0>|<point|-3.5|0.0>|<point|-3.3|0.3>>|<point|-3.7|0>|<point|-3.2|0>|<line|<point|-3.71638|3.07592>|<point|-3.5|3.0>|<point|-3.5|0.3>>|<line|<point|-3.7|0.5>|<point|-3.5|0.3>|<point|-3.3|0.5>>|<line|<point|-3.2|0>|<point|-2.8|0.0>|<point|-2.8|2.0>>|<line|<point|-3|1.8>|<point|-2.8|2.0>|<point|-2.6|1.8>>|<line|<point|-3.7|0>|<point|-3.7|-1.0>>|<line|<point|-4|-0.8>|<point|-3.7|-1.0>|<point|-3.5|-0.7>>|<text-at|body:
    (define (set-x!...|<point|-6.8|-1.7>>|<text-at|(define
    (set-y!..|<point|-5.8193504728554|-2.2>>|<text-at|(define
    (dispatch...|<point|-5.8|-2.7>>|<text-at|dispatch|<point|-5.7|-3.2>>|<text-at|arg:
    x y|<point|-4.8|-1.31793226617277>>|<carc|<point|-1.5|0>|<point|-2.0|0.0>|<point|-1.73671953108274|0.2>>|<carc|<point|-1.5|0>|<point|-1.0|0.0>|<point|-1.2|0.3>>|<point|-1.8|0>|<point|-1.3|0>|<line|<point|-1.81327|3.07592>|<point|-1.5|3.0>|<point|-1.5|0.4>>|<line|<point|-1.7|0.5>|<point|-1.5|0.4>|<point|-1.4|0.5>>|<line|<point|-1.3|0>|<point|-0.8|0.0>|<point|-0.8|2.0>>|<line|<point|-1|1.8>|<point|-0.8|2.0>|<point|-0.6|1.8>>|<line|<point|-1.8|0>|<point|-1.8|-1.0>>|<line|<point|-2|-0.8>|<point|-1.8|-1.0>|<point|-1.5|-0.8>>|<text-at|arg:
    z|<point|-2|-1.5>>|<text-at|body: (z 'car)|<point|-2.8|-2.0>>|<carc|<point|0.5|0>|<point|0.0|0.0>|<point|0.3|-0.3>>|<carc|<point|0.5|0>|<point|1.0|0.0>|<point|0.7|-0.3>>|<point|0.3|0>|<point|0.8|0>|<line|<point|0.106314|3.12148>|<point|0.5|3.0>|<point|0.5|0.3>>|<line|<point|0.3|0.5>|<point|0.5|0.3>|<point|0.7|0.5>>|<line|<point|0.8|0>|<point|1.2|0.0>|<point|1.2|2.0>>|<line|<point|1|1.8>|<point|1.2|2.0>|<point|1.4|1.8>>|<line|<point|0.3|0>|<point|0.3|-1.0>>|<line|<point|0.086357|-0.8>|<point|0.3|-1.0>|<point|0.4|-0.8>>|<text-at|body:
    (z 'cdr)|<point|-0.3|-2.0>>|<text-at|arg:
    z|<point|0.0|-1.5>>||<carc|<point|2.6|0>|<point|3.0|0.0>|<point|2.7|0.2>>|<carc|<point|3.4|0>|<point|3.0|0.0>|<point|3.2|0.3>>|<point|2.8|0>|<point|3.2|0>|<line|<point|2.83526|3.12148>|<point|3.0|3.0>|<point|3.0|0.4>>|<line|<point|2.8|0.6>|<point|3.0|0.4>|<point|3.2|0.5>>|<line|<point|3.2|0>|<point|3.6|0.0>|<point|3.6|2.0>>|<line|<point|3.4|1.8>|<point|3.6|2.0>>|<line|<point|3.7|1.8>|<point|3.6|2.0>>|<line|<point|2.8|0>|<point|2.8|-1.0>>|<line|<point|2.6|-0.8>|<point|2.8|-1.0>|<point|3.0|-0.7>>|<text-at|arg:
    z v|<point|2.1824315385633|-1.41792895885699>>|<text-at|body: ((z
    'set-car!) v)|<point|1.94438748511708|-1.91182696123826>>|<text-at|z|<point|3|-2.4>>|<carc|<point|5.5|0>|<point|5.0|0.0>|<point|5.3|0.3>>|<carc|<point|6|0>|<point|5.5|0.0>|<point|5.7|0.3>>|<point|5.8|0>|<line|<point|5.35486|3.12148>|<point|5.5|3.0>|<point|5.5|0.4>>|<line|<point|5.3|0.6>|<point|5.5|0.4>|<point|5.7|0.6>>|<line|<point|5.8|0>|<point|5.8|2.0>>|<line|<point|5.7|1.8>|<point|5.8|2.0>|<point|6.0|1.7>>|<point|5.3|0.0>|<line|<point|5.3|0>|<point|5.3|-1.0>>|<line|<point|5.0|-0.8>|<point|5.3|-1.0>|<point|5.5|-0.7>>|<text-at|arg:
    z v|<point|5.5|-1.3>>|<text-at|body: ((z
    ...|<point|5.39572033337743|-1.82365392247652>>|>>

    \;

    <\input|Scheme] >
      (define x (cons 1 2))
    </input>

    <\input|Scheme] >
      (define z (cons x x))
    </input>

    <\unfolded-io|Scheme] >
      (set-car! (cdr z) 17)
    <|unfolded-io>
      #\<less\>procedure x (m)\<gtr\>
    </unfolded-io>

    <\unfolded-io|Scheme] >
      (car x)
    <|unfolded-io>
      17
    </unfolded-io>
  </session>

  <with|gr-mode|<tuple|edit|text-at>|gr-frame|<tuple|scale|1cm|<tuple|0.5gw|0.5gh>>|gr-geometry|<tuple|geometry|1par|0.6par>|gr-grid|<tuple|cartesian|<point|0|0>|1>|gr-grid-old|<tuple|cartesian|<point|0|0>|1>|gr-edit-grid-aspect|<tuple|<tuple|axes|none>|<tuple|1|none>|<tuple|10|none>>|gr-edit-grid|<tuple|cartesian|<point|0|0>|1>|gr-edit-grid-old|<tuple|cartesian|<point|0|0>|1>|<graphics||<cline|<point|-5.5|4>|<point|6.0|4.0>|<point|6.0|3.0>|<point|-5.5|3.0>>|<text-at|Global
  Env|<point|-7.4|4.0>>|<text-at|x: 17|<point|-3.6|1.6>>|<text-at|y:
  2|<point|-3.6|1>>|<text-at|set-x!|<point|-3.7|0.4>>|<cline|<point|-4|2>|<point|-2.0|2.0>|<point|-2.0|-1.0>|<point|-4.0|-1.0>>|<text-at|set-y!|<point|-3.6|0>>|<text-at|dispatch|<point|-3.7|-0.5>>|<text-at|E1|<point|-4|2.2>>|<line|<point|-3|3>|<point|-3.0|2.0>>|<line|<point|-3.2|2.8>|<point|-3.0|3.0>|<point|-2.71757176875248|2.68205119724831>>|<text-at|(cons
  1 2)|<point|-2.8|2.2>>|<carc|<point|-5.5|1>|<point|-6.0|1.0>|<point|-5.7|1.3>>|<carc|<point|-5|1>|<point|-5.5|1.0>|<point|-5.18707463652328|1.2>>|<point|-5.7|1>|<point|-5.3|1>|<line|<point|-5.3|1>|<point|-4.0|1.0>>|<line|<point|-4.2|1.3>|<point|-4.0|1.0>|<point|-4.3|0.7>>|<text-at|x|<point|-5.2|3.4>>|<line|<point|-5.6|1.5>|<point|-5.5|1.3>|<point|-5.2|1.5>>|<line|<point|-5.10694205582749|3.28242823124752>|<point|-5.5|1.3>>|<line|<point|-5.7|1>|<point|-5.7|0.0>>|<line|<point|-5.5|0.3>|<point|-5.7|0.0>|<point|-6.0|0.2>>|<text-at|arg:
  m|<point|-6.6|-0.5>>|<text-at|body: (cond
  ...|<point|-7.0|-1.0>>|<text-at|cons:|<point|-4.0|3.4>>|<text-at|car:|<point|-2.3|3.4>>|<text-at|cdr:|<point|-0.8|3.4>>|<text-at|set-car!|<point|0.6|3.4>>|<text-at|set-cdr!|<point|2.4|3.4>>|<text-at|z|<point|4|3.4>>|<cline|<point|5|2>|<point|7.0|2.0>|<point|7.0|-1.0>|<point|5.0|-1.0>>|<text-at|x:
  x|<point|5.3|1.4>>|<text-at|y: x|<point|5.3|1>>|<text-at|set-x!|<point|5.3|0.5>>|<text-at|set-y!|<point|5.4|0>>|<text-at|dispatch|<point|5.4|-0.6>>|<text-at|E2|<point|4.7|2.3>>|<text-at|(cons
  x x)|<point|5.8|2.3>>|<line|<point|5.3|2>|<point|5.3|3.0>>|<line|<point|5.4|2.8>|<point|5.3|3.0>|<point|5.23389337213917|2.66050403492525>>|<carc|<point|3.5|1>|<point|3.0|1.0>|<point|3.2|1.3>>|<carc|<point|3.5|1>|<point|4.0|1.0>|<point|3.7|1.3>>|<point|3.7|1.0>|<line|<point|3.7|1>|<point|5.0|1.0>>|<line|<point|4.7|0.8>|<point|5.0|1.0>|<point|4.7|1.2>>|<line|<point|3.88244|3.28243>|<point|3.5|1.4>>|<line|<point|3.3|1.6>|<point|3.5|1.4>|<point|3.7|1.5>>|<point|3.2|1.0>|<line|<point|3.2|1>|<point|3.2|0.0>>|<line|<point|3|0.3>|<point|3.2|0.0>|<point|3.4|0.3>>|<text-at|arg:
  m|<point|2.5|-0.4>>|<text-at|body: (cond
  ...|<point|2.4|-1>>|<cline|<point|0|-1>|<point|2.0|-1.0>|<point|2.0|-2.0>|<point|0.0|-2.0>>|<text-at|z:
  z|<point|0.4|-1.5>>|<line|<point|0.6|-1>|<point|0.6|3.0>>|<line|<point|0.4|2.8>|<point|0.6|3.0>|<point|0.8|2.8>>|<text-at|(cdr
  z)|<point|0.8|-0.7>>|<text-at|E3|<point|0.0|-0.7>>|<line|<point|-2|-3>|<point|0.0|-3.0>|<point|0.0|-4.0>|<point|-2.0|-4.0>|<point|-2.0|-3.0>>|<text-at|v:
  17|<point|-1.6|-3.5>>|<line|<point|-1|-3>|<point|-1.0|3.0>>|<line|<point|-0.8|2.8>|<point|-1.0|3.0>|<point|-1.15225228204789|2.5820545045641>>|<text-at|E4|<point|-2|-2.7>>>>

  \;

  How to handle the relationship between <em|E3> and <em|E4>? How to
  represent temp var <em|(cdr z)>?

  \;

  \;
</body>

<\references>
  <\collection>
    <associate|auto-1|<tuple|1|?>>
  </collection>
</references>