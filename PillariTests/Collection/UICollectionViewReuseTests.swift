import Quickimport Nimble
@testable import Pillari

// swiftlint:disable cyclomatic_complexity
// swiftlint:disable function_body_length

class UICollectionViewReuseTests: QuickSpec {
    override func spec() {
        let customReuseId = "TestReuseId"
        let supplementaryKind = "TestSupplementary"
        let indexPath = IndexPath(row: 3, section: 5)

        var collectionView: UICollectionViewMock!

        beforeEach {
            collectionView = UICollectionViewMock(frame: .zero, collectionViewLayout: UICollectionViewLayout())
            collectionView.resetEvents()
        }

        describe(".registerCell") {
            it("should register cell class with default reuse identifier") {
                collectionView.registerCell(CollectionCellMock.self)
                let event = expectOnlyOneEvent(collectionView.events)
                guard case .registerCell(let cellType, let identifier)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(cellType).to(beIdenticalTo(CollectionCellMock.self))
                expect(identifier).to(equal(UICollectionView.defaultReuseId(for: CollectionCellMock.self)))
            }

            it("should register cell class with custom reuse identifier") {
                collectionView.registerCell(CollectionCellMock.self, reuseId: customReuseId)
                let event = expectOnlyOneEvent(collectionView.events)
                guard case .registerCell(let cellType, let identifier)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(cellType).to(beIdenticalTo(CollectionCellMock.self))
                expect(identifier).to(equal(customReuseId))
            }

            it("should register cell nib with default reuse identifier") {
                collectionView.registerCell(CollectionNibCellMock.self)
                let event = expectOnlyOneEvent(collectionView.events)
                guard case .registerCellNib(let nib, let identifier)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(nib).to(equal(CollectionNibCellMock.nib))
                expect(identifier).to(equal(UICollectionView.defaultReuseId(for: CollectionNibCellMock.self)))
            }

            it("should register cell nib with custom reuse identifier") {
                collectionView.registerCell(CollectionNibCellMock.self, reuseId: customReuseId)
                let event = expectOnlyOneEvent(collectionView.events)
                guard case .registerCellNib(let nib, let identifier)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(nib).to(equal(CollectionNibCellMock.nib))
                expect(identifier).to(equal(customReuseId))
            }
        }

        describe(".registerSupplementary") {
            it("should register supplementary class with default reuse identifier") {
                collectionView.registerSupplementaryView(CollectionSupplementaryViewMock.self, kind: supplementaryKind)
                let event = expectOnlyOneEvent(collectionView.events)
                guard case .registerSupplementary(let supplementaryType, let kind, let identifier)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(supplementaryType).to(beIdenticalTo(CollectionSupplementaryViewMock.self))
                expect(kind).to(equal(supplementaryKind))
                expect(identifier).to(equal(UICollectionView.defaultReuseId(for: CollectionSupplementaryViewMock.self)))
            }

            it("should register supplementary class with custom reuse identifier") {
                collectionView.registerSupplementaryView(CollectionSupplementaryViewMock.self,
                                                         kind: supplementaryKind, reuseId: customReuseId)
                let event = expectOnlyOneEvent(collectionView.events)
                guard case .registerSupplementary(let supplementaryType, let kind, let identifier)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(supplementaryType).to(beIdenticalTo(CollectionSupplementaryViewMock.self))
                expect(kind).to(equal(supplementaryKind))
                expect(identifier).to(equal(customReuseId))
            }

            it("should register supplementary nib with default reuse identifier") {
                collectionView.registerSupplementaryView(CollectionNibSupplementaryViewMock.self, kind: supplementaryKind)
                let event = expectOnlyOneEvent(collectionView.events)
                guard case .registerSupplementaryNib(let nib, let kind, let identifier)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(nib).to(equal(CollectionNibSupplementaryViewMock.nib))
                expect(kind).to(equal(supplementaryKind))
                expect(identifier).to(equal(UICollectionView.defaultReuseId(for: CollectionNibSupplementaryViewMock.self)))
            }

            it("should register supplementary nib with custom reuse identifier") {
                collectionView.registerSupplementaryView(CollectionNibSupplementaryViewMock.self,
                                                         kind: supplementaryKind, reuseId: customReuseId)
                let event = expectOnlyOneEvent(collectionView.events)
                guard case .registerSupplementaryNib(let nib, let kind, let identifier)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(nib).to(equal(CollectionNibSupplementaryViewMock.nib))
                expect(kind).to(equal(supplementaryKind))
                expect(identifier).to(equal(customReuseId))
            }
        }

        describe(".dequeueReusableCell") {
            it("should try to dequeue cell with default reuse identifier") {
                let cell = collectionView.dequeueReusableCell(CollectionCellMock.self, indexPath: indexPath)
                let event = expectOnlyOneEvent(collectionView.events)
                guard case .dequeueReusableCell(let identifier, let index)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(cell).to(beNil())
                expect(identifier).to(equal(UICollectionView.defaultReuseId(for: CollectionCellMock.self)))
                expect(index).to(equal(indexPath))
            }

            it("should try to dequeue cell with custom reuse identifier") {
                let cell = collectionView.dequeueReusableCell(CollectionCellMock.self,
                                                              indexPath: indexPath, reuseId: customReuseId)
                let event = expectOnlyOneEvent(collectionView.events)
                guard case .dequeueReusableCell(let identifier, let index)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(cell).to(beNil())
                expect(identifier).to(equal(customReuseId))
                expect(index).to(equal(indexPath))
            }

            it("should dequeue cell with default reuse identifier") {
                collectionView.register(CollectionCellMock.self,
                                        forCellWithReuseIdentifier: UICollectionView.defaultReuseId(for: CollectionCellMock.self))
                let cell = collectionView.dequeueReusableCell(CollectionCellMock.self, indexPath: indexPath)
                expect(cell).notTo(beNil())
            }

            it("should dequeue cell with custom reuse identifier") {
                collectionView.register(CollectionCellMock.self, forCellWithReuseIdentifier: customReuseId)
                let cell = collectionView.dequeueReusableCell(CollectionCellMock.self, indexPath: indexPath, reuseId: customReuseId)
                expect(cell).notTo(beNil())
            }
        }

        describe(".dequeueReusableSupplementaryView") {
            it("should try to dequeue supplementary with default reuse identifier") {
                let supplementary = collectionView.dequeueReusableSupplementaryView(
                    CollectionSupplementaryViewMock.self,
                    kind: supplementaryKind,
                    indexPath: indexPath
                )
                let event = expectOnlyOneEvent(collectionView.events)
                guard case .dequeueReusableSupplementary(let kind, let identifier, let index)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(supplementary).to(beNil())
                expect(identifier).to(equal(UICollectionView.defaultReuseId(for: CollectionSupplementaryViewMock.self)))
                expect(kind).to(equal(supplementaryKind))
                expect(index).to(equal(indexPath))
            }

            it("should try to dequeue supplementary with custom reuse identifier") {
                let supplementary = collectionView.dequeueReusableSupplementaryView(
                    CollectionSupplementaryViewMock.self,
                    kind: supplementaryKind,
                    indexPath: indexPath,
                    reuseId: customReuseId
                )
                let event = expectOnlyOneEvent(collectionView.events)
                guard case .dequeueReusableSupplementary(let kind, let identifier, let index)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(supplementary).to(beNil())
                expect(identifier).to(equal(customReuseId))
                expect(kind).to(equal(supplementaryKind))
                expect(index).to(equal(indexPath))
            }

            it("should dequeue supplementary with default reuse identifier") {
                collectionView.register(
                    CollectionSupplementaryViewMock.self,
                    forSupplementaryViewOfKind: supplementaryKind,
                    withReuseIdentifier: UICollectionView.defaultReuseId(for: CollectionSupplementaryViewMock.self)
                )

                let supplementary = collectionView.dequeueReusableSupplementaryView(
                    CollectionSupplementaryViewMock.self,
                    kind: supplementaryKind,
                    indexPath: indexPath
                )

                expect(supplementary).notTo(beNil())
            }

            it("should dequeue supplementary with custom reuse identifier") {
                collectionView.register(
                    CollectionSupplementaryViewMock.self,
                    forSupplementaryViewOfKind: supplementaryKind,
                    withReuseIdentifier: customReuseId
                )

                let supplementary = collectionView.dequeueReusableSupplementaryView(
                    CollectionSupplementaryViewMock.self,
                    kind: supplementaryKind,
                    indexPath: indexPath,
                    reuseId: customReuseId
                )

                expect(supplementary).notTo(beNil())
            }
        }

        describe(".dequeueReusableCellWithAutoregistration") {
            it("should dequeue cell with default reuse identifier") {
                let cell = collectionView.dequeueReusableCellWithAutoregistration(CollectionCellMock.self, indexPath: indexPath)
                expect(cell).notTo(beNil())
            }

            it("should dequeue cell with custom reuse identifier") {
                let cell = collectionView.dequeueReusableCellWithAutoregistration(
                    CollectionCellMock.self,
                    indexPath: indexPath,
                    reuseId: customReuseId
                )
                expect(cell).notTo(beNil())
            }

            it("should throw assertion") {
                collectionView.shouldRegisterCellsAndSupplementaries = false
                expect {
                    _ = collectionView.dequeueReusableCellWithAutoregistration(CollectionCellMock.self, indexPath: indexPath)
                    }
                    .to(throwAssertion())
            }
        }

        describe(".dequeueReusableSupplementaryViewWithAutoregistration") {
            it("should dequeue supplementary with default reuse identifier") {
                let supplementary = collectionView.dequeueReusableSupplementaryViewWithAutoregistration(
                    CollectionSupplementaryViewMock.self,
                    kind: supplementaryKind,
                    indexPath: indexPath
                )
                expect(supplementary).notTo(beNil())
            }

            it("should dequeue supplementary with custom reuse identifier") {
                let supplementary = collectionView.dequeueReusableSupplementaryViewWithAutoregistration(
                    CollectionSupplementaryViewMock.self,
                    kind: supplementaryKind,
                    indexPath: indexPath,
                    reuseId: customReuseId
                )
                expect(supplementary).notTo(beNil())
            }

            it("should throw assertion") {
                collectionView.shouldRegisterCellsAndSupplementaries = false
                expect {
                    _ = collectionView.dequeueReusableSupplementaryViewWithAutoregistration(
                        CollectionSupplementaryViewMock.self,
                        kind: supplementaryKind,
                        indexPath: indexPath
                    )
                }
                .to(throwAssertion())
            }
        }
    }
}

// swiftlint:enable cyclomatic_complexity
// swiftlint:enable function_body_length
