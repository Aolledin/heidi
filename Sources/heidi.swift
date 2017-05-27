import LogicKit

//definition des coups de siflets


let court = Value("court")
let whee  = Value("whee")
let who   = Value("who")
let wheet = Value("wheet")
let wheeo = Value("wheeo")
let hee   = Value("hee")
let long  = Value("long")
let pause = Value("pause")

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

let deponer   = Value("deponer")
let dretg     = Value("dretg")
let sanester  = Value("sanester")
let davent    = Value("davent")
let davos     = Value("davos")
let plaun     = Value("plaun")
let returnar  = Value("returnar")
let sa_fermar = Value("sa_fermar")




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
J'ai choisi d'ajouter une pause à la fin de la séquence pour simplifier l'implémentation, et ceci ne poserait pas de problème à Heidi.


*/

/*Sémantique d'évaluation

Tita vers Heidi:

on définit ici la flèche =evalSiflet=> qui prend une séquence de coup de siflets et rends un ordres

----------------------------------
court::court =evalSiflet=> deponer


-----------------------------
whee::who =evalSiflet=> dretg

et ainsi de suite pour les autres ordres


Heidi vers Tita:

on définit la flèche =evalOrdre=> qui prend un ordre et rend une séquence de coups de siflets.

---------------------------------
deponer =evalOrdre=> court::court


---------------------------------
dretg =evalOrdre=> whee::who

etc.

*/


//reconnais qu'on a deponer au début de la liste.

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
        reste4 === List.cons(pause, reste)


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
        reste3 === List.cons(pause, reste)
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
        reste4 === List.cons(pause, reste)


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
        reste3 === List.cons(pause, reste)

    }
}


func reconnaisSaFermar(SeqSifl: Term, reste: Term) -> Goal{
  return
    freshn {g in
      let reste1 = g["reste1"]

      return
        SeqSifl === List.cons(long, reste1) &&
        reste1 === List.cons(pause, reste)

    }
}

/* Sémantique:


Tita vers Heidi:

On définit la flèche =evalSeqSifl=> qui prends une séquence de coups de siflets et rend une séquence d'ordres.


------------------------
vide =evalSeqSifl=> vide



Sifl =evalSiflet=> ordre, resteSifl =evalSeqSifl=> resteOrdre
-------------------------------------------------------------
Sifl::pause::resteSifl =evalSeqSifl=> ordre :: resteOrdre


*/


//Le traducteur est bidirectionnel (vive les langages logiques \o/!)

func traducteur(OrdreHeidi: Term, OrdreTita: Term) -> Goal {
  return (OrdreHeidi === List.empty && OrdreTita === List.empty) || //cas terminal
    freshn{g in
      let resteHeidi = g["resteHeidi"]
      let resteTita = g["resteTita"]
      let premierOrdreHeidi = g["premierOrdreHeidi"]

      return //On parcourt tout les ordres possibles, on aurait pu en faire une fonction à part, mais ça n'aurait pas simplifier le code
        OrdreHeidi === List.cons(premierOrdreHeidi, resteHeidi) && (
          (premierOrdreHeidi === deponer && reconnaisDeponer(SeqSifl: OrdreTita, reste: resteTita)) ||
          (premierOrdreHeidi === dretg && reconnaisDretg(SeqSifl: OrdreTita, reste: resteTita)) ||
          (premierOrdreHeidi === sanester && reconnaisSanester(SeqSifl: OrdreTita, reste: resteTita)) ||
          (premierOrdreHeidi === davent && reconnaisDavent(SeqSifl: OrdreTita, reste: resteTita)) ||
          (premierOrdreHeidi === davos && reconnaisDavos(SeqSifl: OrdreTita, reste: resteTita)) ||
          (premierOrdreHeidi === plaun && reconnaisPlaun(SeqSifl: OrdreTita, reste: resteTita)) ||
          (premierOrdreHeidi === returnar && reconnaisReturnar(SeqSifl: OrdreTita, reste: resteTita)) ||
          (premierOrdreHeidi === sa_fermar && reconnaisSaFermar(SeqSifl: OrdreTita, reste: resteTita))
        ) &&
        traducteur(OrdreHeidi: resteHeidi, OrdreTita: resteTita)
    }
}


//Optimisation

/*
Syntaxe/Sémantique
Je ne vais pas réécrire la syntaxe/sémantique car elle est exactement la même que celle faite plus haut.
*/


//Niveau implémentation, pour cette partie, on ne reconnaitra pas les pauses dans les fonctions reconnaissant les séquences de siflements,
//mais plutôt dans une fonction à part, pour faciliter l'implémentation de l'enlevage de pause.
//On garde par contre toujours une pause à la fin.

func reconnaisPause(SeqSifl: Term, reste: Term) -> Goal{
    return
      SeqSifl === List.cons(pause, reste)

}


func reconnaisDeponer2(SeqSifl: Term, reste: Term) -> Goal{
  return
    freshn {g in
      let reste1 = g["reste1"]
      let reste2 = g["reste2"]


      return
        SeqSifl === List.cons(wheeo, reste1) &&
        reste1 === List.cons(hee, reste2) &&
        reste2 === List.cons(wheet, reste)
    }
}


func reconnaisDretg2(SeqSifl: Term, reste: Term) -> Goal{
  return
    freshn {g in
      let reste1 = g["reste1"]


      return
        SeqSifl === List.cons(hee, reste1) &&
        reste1 === List.cons(wheet, reste)

    }
}


func reconnaisSanester2(SeqSifl: Term, reste: Term) -> Goal{
  return
    freshn {g in
      let reste1 = g["reste1"]


      return
        SeqSifl === List.cons(wheet, reste1) &&
        reste1 === List.cons(wheeo, reste)
    }
}


func reconnaisDavent2(SeqSifl: Term, reste: Term) -> Goal{
  return
    freshn {g in
      let reste1 = g["reste1"]
      let reste2 = g["reste2"]


      return
        SeqSifl === List.cons(wheet, reste1) &&
        reste1 === List.cons(hee, reste2) &&
        reste2 === List.cons(wheet, reste)
    }
}



func reconnaisDavos2(SeqSifl: Term, reste: Term) -> Goal{
  return
    freshn {g in
      let reste1 = g["reste1"]
      let reste2 = g["reste2"]

      return
        SeqSifl === List.cons(wheet, reste1) &&
        reste1 === List.cons(wheeo, reste2) &&
        reste2 === List.cons(wheet, reste)

    }
}


func reconnaisPlaun2(SeqSifl: Term, reste: Term) -> Goal{
  return
    freshn {g in
      let reste1 = g["reste1"]
      let reste2 = g["reste2"]

      return
        SeqSifl === List.cons(wheet, reste1) &&
        reste1 === List.cons(wheeo, reste2) &&
        reste2 === List.cons(wheeo, reste)


    }
}


func reconnaisReturnar2(SeqSifl: Term, reste: Term) -> Goal{
  return
    freshn {g in
      let reste1 = g["reste1"]

      return
        SeqSifl === List.cons(wheeo, reste1) &&
        reste1 === List.cons(wheet, reste)
    }
}


func reconnaisSaFermar2(SeqSifl: Term, reste: Term) -> Goal{
  return
    freshn {g in
      let reste1 = g["reste1"]

      return
        SeqSifl === List.cons(wheeo, reste1) &&
        reste1 === List.cons(wheeo, reste)
    }
}



func traducteur2(OrdreHeidi: Term, OrdreTita: Term) -> Goal {
  return (OrdreHeidi === List.empty && OrdreTita === List.empty) || //cas terminal
    freshn{g in
      let resteHeidi = g["resteHeidi"]
      let resteTitaSansPause = g["resteTitaSansPause"]
      let resteTitaAvecPause = g["resteTitaAvecPause"]
      let premierOrdreHeidi = g["premierOrdreHeidi"]

      return //idem qu'avant, on ajoute juste la pause à la fin.
        OrdreHeidi === List.cons(premierOrdreHeidi, resteHeidi) && (
          (premierOrdreHeidi === deponer && reconnaisDeponer2(SeqSifl: OrdreTita, reste: resteTitaAvecPause)) ||
          (premierOrdreHeidi === dretg && reconnaisDretg2(SeqSifl: OrdreTita, reste: resteTitaAvecPause)) ||
          (premierOrdreHeidi === sanester && reconnaisSanester2(SeqSifl: OrdreTita, reste: resteTitaAvecPause)) ||
          (premierOrdreHeidi === davent && reconnaisDavent2(SeqSifl: OrdreTita, reste: resteTitaAvecPause)) ||
          (premierOrdreHeidi === davos && reconnaisDavos2(SeqSifl: OrdreTita, reste: resteTitaAvecPause)) ||
          (premierOrdreHeidi === plaun && reconnaisPlaun2(SeqSifl: OrdreTita, reste: resteTitaAvecPause)) ||
          (premierOrdreHeidi === returnar && reconnaisReturnar2(SeqSifl: OrdreTita, reste: resteTitaAvecPause)) ||
          (premierOrdreHeidi === sa_fermar && reconnaisSaFermar2(SeqSifl: OrdreTita, reste: resteTitaAvecPause))
        ) &&
        reconnaisPause(SeqSifl: resteTitaAvecPause, reste: resteTitaSansPause) &&
        traducteur(OrdreHeidi: resteHeidi, OrdreTita: resteTitaSansPause)
    }
}


















































//fin (pour avoir de la place sous mon curseur dans atom)
