% insert reference #1 - key, #2 - package
\newcommand{\insertRef}{\Sexpr[results=rd,stage=build]{Rdpack::insert_ref(key="#1",package="#2")}}

% insert reference #1 - key, #2 - package
\newcommand{\insertCiteOnly}{\Sexpr[results=Rd,stage=build]{if(!exists(".Rdpack.currefs")) .Rdpack.currefs <- new.env();Rdpack::insert_citeOnly(key="#1",package="#2", cached_env=.Rdpack.currefs,cite_only=TRUE)}}
\newcommand{\insertCite}{\Sexpr[results=Rd,stage=build]{if(!exists(".Rdpack.currefs")) .Rdpack.currefs <- new.env();Rdpack::insert_citeOnly(key="#1",package="#2", cached_env=.Rdpack.currefs)}}
\newcommand{\insertNoCite}{\Sexpr[results=hide,stage=build]{if(!exists(".Rdpack.currefs")) .Rdpack.currefs <- new.env();Rdpack::insert_citeOnly(key="#1",package="#2", cached_env=.Rdpack.currefs,dont_cite=TRUE)}}

\newcommand{\insertAllCited}{\Sexpr[results=rd,stage=build]{if(!exists(".Rdpack.currefs")) .Rdpack.currefs <- new.env();Rdpack::insert_all_ref(.Rdpack.currefs)}}

% insert reference #1 - key, #2 - package
%\newcommand{\runExamples}{\Sexpr[results=rd,stage=build]{deparse({#1})}}
\newcommand{\runExamples}{\Sexpr[results=rd,stage=build]{Rdpack:::run_examples(quote({#1}))}}
%\newcommand{\printExample}{\Sexpr[results=rd,stage=build]{Rdpack:::run_examples(quote({#1}), Rdsection = "\\\\\\\\preformatted")}}
\newcommand{\printExample}{\Sexpr[results=rd,stage=build]{Rdpack:::run_examples(quote({#1}), Rdsection = "preformatted")}}
