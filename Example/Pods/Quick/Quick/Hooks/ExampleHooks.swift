/**
    A container for closures to be executed before and after each example.
*/
final internal class ExampleHooks {

    internal var befores: [BeforeExampleWithMetadataClosure] = []
    internal var afters: [AfterExampleWithMetadataClosure] = []

    internal func appendBefore(_ closure: BeforeExampleWithMetadataClosure) {
        befores.append(closure)
    }

    internal func appendBefore(_ closure: BeforeExampleClosure) {
        befores.append { (exampleMetadata: ExampleMetadata) in closure() }
    }

    internal func appendAfter(_ closure: AfterExampleWithMetadataClosure) {
        afters.append(closure)
    }

    internal func appendAfter(_ closure: AfterExampleClosure) {
        afters.append { (exampleMetadata: ExampleMetadata) in closure() }
    }

    internal func executeBefores(_ exampleMetadata: ExampleMetadata) {
        for before in befores {
            before(exampleMetadata)
        }
    }

    internal func executeAfters(_ exampleMetadata: ExampleMetadata) {
        for after in afters {
            after(exampleMetadata)
        }
    }
}
