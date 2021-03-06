import XCTest
import LogicKit
@testable import heidi

class heidiTests: XCTestCase {

    func testExample() {
    }


    //Je ne fais pas de tests pour les autres ordres, étant donné que les fonctions sont des copier/coller de la première.
    //La structure du test est classique: une variable libre, une fonction.
    func testDeponer(){
      let v = Variable(named: "v")
      let goal = reconnaisDeponer(SeqSifl: v, reste: List.cons(long, List.empty) )
      let expected = List.cons(court, List.cons(court, List.cons(pause, List.cons(long, List.empty))))
      var trouve: Bool = false
      for sub in solve(goal) {
        trouve = true //vérifie qu'au moins une solution est trouvée (sans, si solve ne trouve rien, le test passe)
        let r = sub.reified()
        XCTAssert(r[v].equals(expected), "reconnaisDeponer is incorrect")
      }
      XCTAssert(trouve, "reconnaisDeponer found nothing")
    }


    func testTraducteur(){
      let v = Variable(named: "v")
      let aTraduire = List.cons(davent, List.cons(davos, List.cons(sa_fermar, List.cons(plaun, List.empty))))
      let goal = traducteur(OrdreHeidi: aTraduire, OrdreTita: v)
      let expected = List.cons(wheet, List.cons(wheeo, List.cons(wheet, List.cons(wheet, List.cons(pause, List.cons(who, List.cons(hee, List.cons(who, List.cons(pause, List.cons(long, List.cons(pause, List.cons(hee, List.cons(hee, List.cons(hee, List.cons(hee, List.cons(pause, List.empty))))))))))))))))

      var trouve : Bool = false
      for sub in solve(goal) {
        let r = sub.reified()
        //print(r[v]) //À décomenter pour voir la traduction
        trouve = true
        XCTAssert(r[v].equals(expected), "traducteur is incorrect")
      }
      XCTAssert(trouve, "traducteur found nothing")
    }


    //Double traduction, on solve deux fois deux expressions différentes pour traduire dans les deux sens, on espère retrouver la même solution.
    func testTraducteurDouble() {
      let v = Variable(named: "v")

      let aTraduire = List.cons(dretg, List.cons(dretg, List.cons(sa_fermar, List.cons(returnar, List.empty))))
      let goal = traducteur(OrdreHeidi: aTraduire, OrdreTita: v)
      let expected = aTraduire
      var trouve : Bool = false
      for sub in solve(goal) {
        let r = sub.reified()
        let w = Variable(named: "w")
        let aTraduire2 = r[v]
        let goal2 = traducteur(OrdreHeidi: w, OrdreTita: aTraduire2)
        for sub in solve(goal2){
          let s = sub.reified()
          trouve = true
          XCTAssert(s[w].equals(expected), "traducteur is incorrect")
        }

      }
      XCTAssert(trouve, "traducteur found nothing")

    }


    //Plus ou moins les même tests qu'à la première partie
    func testDretg2(){
      let v = Variable(named: "v")
      let goal = reconnaisDretg2(SeqSifl: v, reste: List.cons(long, List.empty) )
      let expected = List.cons(hee, List.cons(wheet, List.cons(long, List.empty)))
      var trouve: Bool = false
      for sub in solve(goal) {
        trouve = true
        let r = sub.reified()
        XCTAssert(r[v].equals(expected), "reconnaisDeponer is incorrect")
      }
      XCTAssert(trouve, "reconnaisDeponer found nothing")
    }

    func testPause(){
      let v = Variable(named: "v")
      let goal = reconnaisPause(SeqSifl: List.cons(pause, List.cons(pause, List.cons(whee, List.empty ))), reste: v)
      let expected = List.cons(pause, List.cons(whee,  List.empty))
      var trouve: Bool = false
      for sub in solve(goal) {
        trouve = true
        let r = sub.reified()
        XCTAssert(r[v].equals(expected), "reconnaisDeponer is incorrect")
      }
      XCTAssert(trouve, "reconnaisDeponer found nothing")
    }

    func testCorrespondance(){
      let v = Variable(named: "v")
      let goal = correspondance(premierOrdreHeidi: returnar, OrdreTita: v, resteTitaAvecPause: List.cons(wheet, List.cons(pause, List.empty)))
      let expected = List.cons(wheeo, List.cons(wheet,  List.cons(wheet, List.cons(pause, List.empty))))
      var trouve: Bool = false
      for sub in solve(goal) {
        trouve = true
        let r = sub.reified()
        XCTAssert(r[v].equals(expected), "testCorrespondance is incorrect")
      }
      XCTAssert(trouve, "testCorrespondance found nothing")

    }


    func testTraducteur2(){
      let v = Variable(named: "v")
      let aTraduire = List.cons(deponer, List.cons(sanester,  List.cons(davos, List.empty)))
      let goal = traducteur2(OrdreHeidi: aTraduire, OrdreTita: v)
      let expected = List.cons(wheeo, List.cons(hee, List.cons(wheet, List.cons(pause, List.cons(wheet, List.cons(wheeo, List.cons(pause, List.cons(wheet, List.cons(wheeo, List.cons(wheet, List.cons(pause, List.empty)))))))))))
      var trouve : Bool = false
      for sub in solve(goal) {
        let r = sub.reified()
        //print(r[v]) //À décomenter pour voir la traduction
        trouve = true
        XCTAssert(r[v].equals(expected), "traducteur2 is incorrect")
      }
      XCTAssert(trouve, "traducteur2 found nothing")
    }


    func testTraducteurDouble2() {
      let v = Variable(named: "v")

      let aTraduire = List.cons(dretg, List.cons(dretg, List.cons(sa_fermar, List.cons(returnar, List.cons(deponer, List.empty)))))
      let goal = traducteur2(OrdreHeidi: aTraduire, OrdreTita: v)
      let expected = aTraduire
      var trouve : Bool = false
      for sub in solve(goal) {
        let r = sub.reified()
        let w = Variable(named: "w")
        let aTraduire2 = r[v]
        let goal2 = traducteur2(OrdreHeidi: w, OrdreTita: aTraduire2)
        for sub in solve(goal2){
          let s = sub.reified()
          trouve = true
          XCTAssert(s[w].equals(expected), "traducteur is incorrect")
        }

      }
      XCTAssert(trouve, "traducteur found nothing")

    }


    //La fonction demandée
    func testTraducteurDoubleSansPause() {
      let v = Variable(named: "v")

      let aTraduire = List.cons(plaun, List.cons(dretg, List.cons(plaun, List.cons(deponer, List.cons(sa_fermar, List.empty)))))
      let goal = traducteurSansPause(OrdreHeidi: aTraduire, OrdreTita: v)
      let expected = aTraduire
      var trouveLeBon : Bool = false
      var trouve : Int = 0
      for sub in solve(goal) {
        let r = sub.reified()
        let w = Variable(named: "w")
        let aTraduire2 = r[v]
        let goal2 = traducteurSansPause(OrdreHeidi: w, OrdreTita: aTraduire2)
        for sub in solve(goal2){
          let s = sub.reified()
          trouve = trouve + 1
          //print(s[w]) À décomenter pour voir les possibilités.
          trouveLeBon = trouveLeBon || s[w].equals(expected)
        }

      }
      XCTAssert(trouveLeBon,  "traducteur sans pause is incorrect") //On vérifie quand même qu'il a trouvé au moins une fois le bon résultat.
      XCTAssert(trouve == 4, "traducteur sans pause found not enough or too much")//Vérifie que ce qui est sensé être trouvé est trouvé.

    }












    static var allTests = [
        ("testExample", testExample),
        ("testDeponer", testDeponer),
        ("testTraducteur", testTraducteur),
        ("testTraducteurDouble", testTraducteurDouble),
        ("testDretg2", testDretg2),
        ("testPause", testPause),
        ("testTraducteur2", testTraducteur2),
        ("testTraducteurDouble2", testTraducteurDouble2),
        ("testCorrespondance", testCorrespondance),
        ("testTraducteurDoubleSansPause", testTraducteurDoubleSansPause),
    ]
}
