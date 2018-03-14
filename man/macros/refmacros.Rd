% insert reference #1 - key, #2 - package
\newcommand{\insertRef}{\Sexpr[results=rd,stage=build]{Rdpack::insert_ref(key="#1",package="#2")}}
\newcommand{\insertCiteOnly}{\Sexpr[results=rd,stage=build]{Rdpack::insert_citeOnly(key="#1",package="#2")}}
\newcommand{\insertCiteSav}{\Sexpr[results=hide,stage=build]{{if(!exists(".Rdpack.currefs")) .Rdpack.currefs <- matrix(character(0), nrow = 0, ncol = 2);.Rdpack.currefs <- rbind(.Rdpack.currefs, c("#1","#2"))}}\Sexpr[results=rd,stage=build]{Rdpack::insert_citeOnly(key="#1",package="#2")}}
\newcommand{\insertCite}{\Sexpr[results=Rd,stage=build]{if(!exists(".Rdpack.currefs")) .Rdpack.currefs <- matrix(character(0), nrow = 0, ncol = 2);.Rdpack.currefs <- rbind(.Rdpack.currefs, c("#1","#2"));Rdpack::insert_citeOnly(key="#1",package="#2")}}
\newcommand{\insertNoCite}{\Sexpr[results=hide,stage=build]{{if(!exists(".Rdpack.currefs")) .Rdpack.currefs <- matrix(character(0), nrow = 0, ncol = 2);.Rdpack.currefs <- rbind(.Rdpack.currefs, c("#1","#2"))}}}
\newcommand{\insertAllCited}{\Sexpr[results=rd,stage=build]{Rdpack::insert_all_ref(if(exists(".Rdpack.currefs")) .Rdpack.currefs else NULL)}}
      
