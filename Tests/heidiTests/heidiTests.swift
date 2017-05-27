import XCTest
import LogicKit
@testable import heidi

class heidiTests: XCTestCase {

    func testExample() {
    }


    //Je ne fais pas de tests pour les autres ordres, étant donné que les fonctions sont des copier/coller de la première.
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
      let expected = List.cons(wheet, LogicKit.List.cons(wheeo, LogicKit.List.cons(wheet, LogicKit.List.cons(wheet, LogicKit.List.cons(pause, LogicKit.List.cons(who, LogicKit.List.cons(hee, LogicKit.List.cons(who, LogicKit.List.cons(pause, LogicKit.List.cons(long, LogicKit.List.cons(pause, LogicKit.List.cons(hee, LogicKit.List.cons(hee, LogicKit.List.cons(hee, LogicKit.List.cons(hee, LogicKit.List.cons(pause, LogicKit.List.empty))))))))))))))))

      var trouve : Bool = false
      for sub in solve(goal) {
        let r = sub.reified()
        print(r[v]) 
        trouve = true
        XCTAssert(r[v].equals(expected), "traducteur is incorrect")
      }
      XCTAssert(trouve, "traducteur found nothing")
    }



















    static var allTests = [
        ("testExample", testExample),
        ("testDeponer", testDeponer),
        ("testTraducteur", testTraducteur),
    ]
}
