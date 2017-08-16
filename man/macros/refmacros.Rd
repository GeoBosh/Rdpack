% insert reference #1 - key, #2 - package
\newcommand{\insertRef}{\Sexpr[results=rd,stage=build]{Rdpack::insert_ref(key="#1",package="#2")}}
