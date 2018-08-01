import Quickimport Nimble
@testable import Pillari

// swiftlint:disable type_name

class CollectionFlowLayoutSectionConfigurationTests: QuickSpec {
    override func spec() {
        let inset = UIEdgeInsets(top: 10, left: 20, bottom: 30, right: 40)
        let minimumLineSpacing: CGFloat = 44
        let minimumInteritemSpacing: CGFloat = 144
        let configuration = CollectionFlowLayoutSectionConfiguration(
            inset: inset,
            minimumLineSpacing: minimumLineSpacing,
            minimumInteritemSpacing: minimumInteritemSpacing
        )

        describe(".init") {
            it("should return valid configuration") {
                expect(configuration.inset).to(equal(inset))
                expect(configuration.minimumLineSpacing).to(equal(minimumLineSpacing))
                expect(configuration.minimumInteritemSpacing).to(equal(minimumInteritemSpacing))
            }
        }
    }
}

// swiftlint:enable type_name
