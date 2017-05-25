import LogicKit

//definition des coups de siflets


let court = Value("Court")
let whee  = Value("Whee")
let who   = Value("Who")
let wheet = Value("Wheet")
let wheeo = Value("Wheeo")
let hee   = Value("Hee")
let long  = Value("Long")
let pause = Value("Pause")

//definition des ordres de Heidi
//Syntaxe de Heidi:
/*

----------------
deponer € Ordre

---------------
dretg € Ordre

et ainsi de suite.

---------------------
vide € SequenceOrdres


o € Ordre, s € SequenceOrdres
-----------------------------
o::s € SequenceOrdres

le '€' est le symbole appartient à, vide est une liste vide, a::b est la concaténation d'un élément a avec une liste b*/

let deponer   = Value("Deponer")
let dretg     = Value("Dretg")
let sanester  = Value("Sanester")
let davent    = Value("Davent")
let davos     = Value("Davos")
let plaun     = Value("Plaun")
let returnar  = Value("Retournar")
let sa_fermar = Value("Sa fermar")



//reconnais qu'on a deponer au début de la liste.

/*Sytaxe de Tita:

------------------------
court::court € OrdreTita

-----------------------
whee::who € OrdreTita

etc.


--------------------
vide € SeqOrdreTita

o € OrdreTita, s €  SeqOrdreTita
--------------------------------
o::pause::s € SeqOrdreTita

ici, les :: sont la concaténation soit de deux listes entre elles, soit d'un élément et d'une liste.


*/

func reconnaisDeponer(SeqSifl: Term, reste: Term) -> Goal{
  return
    freshn {g in
      let reste1 = g["reste1"]
      let reste2 = g["reste2"]

      return
        SeqSifl === List.cons(court, reste1) &&
        reste1 === List.cons(court, reste2) &&
        reste2 === List.cons(pause, reste)

    }
}

func reconnaisDretg(SeqSifl: Term, reste: Term) -> Goal{
  return
    freshn {g in
      let reste1 = g["reste1"]
      let reste2 = g["reste2"]

      return
        SeqSifl === List.cons(whee, reste1) &&
        reste1 === List.cons(who, reste2) &&
        reste2 === List.cons(pause, reste)

    }
}

func reconnaisSanester(SeqSifl: Term, reste: Term) -> Goal{
  return
    freshn {g in
      let reste1 = g["reste1"]
      let reste2 = g["reste2"]

      return
        SeqSifl === List.cons(wheet, reste1) &&
        reste1 === List.cons(wheeo, reste2) &&
        reste2 === List.cons(pause, reste)

    }
}

func reconnaisDavent(SeqSifl: Term, reste: Term) -> Goal{
  return
    freshn {g in
      let reste1 = g["reste1"]
      let reste2 = g["reste2"]
      let reste3 = g["reste3"]
      let reste4 = g["reste4"]

      return
        SeqSifl === List.cons(wheet, reste1) &&
        reste1 === List.cons(wheeo, reste2) &&
        reste2 === List.cons(wheet, reste3) &&
        reste3 === List.cons(wheet, reste4) &&
        reste4 === List.cons(pause, reste)&&


    }
}

func reconnaisDavos(SeqSifl: Term, reste: Term) -> Goal{
  return
    freshn {g in
      let reste1 = g["reste1"]
      let reste2 = g["reste2"]
      let reste3 = g["reste3"]

      return
        SeqSifl === List.cons(who, reste1) &&
        reste1 === List.cons(hee, reste2) &&
        reste2 === List.cons(who, reste3) &&
        reste3 === List.cons(pause, reste)&&
    }
}


func reconnaisPlaun(SeqSifl: Term, reste: Term) -> Goal{
  return
    freshn {g in
      let reste1 = g["reste1"]
      let reste2 = g["reste2"]
      let reste3 = g["reste3"]
      let reste4 = g["reste4"]

      return
        SeqSifl === List.cons(hee, reste1) &&
        reste1 === List.cons(hee, reste2) &&
        reste2 === List.cons(hee, reste3) &&
        reste3 === List.cons(hee, reste4) &&
        reste4 === List.cons(pause, reste)&&


    }
}

func reconnaisReturnar(SeqSifl: Term, reste: Term) -> Goal{
  return
    freshn {g in
      let reste1 = g["reste1"]
      let reste2 = g["reste2"]
      let reste3 = g["reste3"]

      return
        SeqSifl === List.cons(whee, reste1) &&
        reste1 === List.cons(whee, reste2) &&
        reste2 === List.cons(wheet, reste3) &&
        reste3 === List.cons(pause, reste)&&

    }
}


func reconnaisSaFermar(SeqSifl: Term, reste: Term) -> Goal{
  return
    freshn {g in
      let reste1 = g["reste1"]

      return
        SeqSifl === List.cons(long, reste1) &&
        reste4 === List.cons(pause, reste)&&

    }
}
























//fin (pour avoir de la place sous mon curseur dans atom)
