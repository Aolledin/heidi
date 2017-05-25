import XCTest
import LogicKit
@testable import heidi

class heidiTests: XCTestCase {

    func testExample() {
    }

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

    static var allTests = [
        ("testExample", testExample),
        ("testDeponer", testDeponer)
    ]
}
