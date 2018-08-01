import ObjectiveC

protocol AssociatedObjectStore { }

extension AssociatedObjectStore {
    func associatedObject<T>(forKey key: UnsafeRawPointer) -> T? {
        return objc_getAssociatedObject(self, key) as? T
    }

    func setAssociatedObject<T>(_ object: T?, forKey key: UnsafeRawPointer,
                                with policy: objc_AssociationPolicy = .OBJC_ASSOCIATION_RETAIN_NONATOMIC) {
        objc_setAssociatedObject(self, key, object, policy)
    }
}
