// add_mid_to_collection.cdc

import DAAM from 0x7db4d10c78bad30a

transaction(mid: UInt64, feature: Bool, name: String) {
    let collectionRef : &DAAMDAAM_V1.Collection
    let creatorRef    : &DAAMDAAM_V1.Creator
    let mid           : UInt64
    let feature       : Bool
    var name          : String

    prepare(acct: AuthAccount) {
        self.creatorRef = acct.borrow<&DAAMDAAM_V1.Creator>(from: DAAM.creatorStoragePath)!
        let metadataGen = acct.borrow<&DAAMDAAM_V1.MetadataGenerator>(from: DAAM.metadataStoragePath)!
        // Borrow a reference from the stored collection
        self.collectionRef = acct.borrow<&DAAMDAAM_V1.Collection>(from: DAAM.collectionStoragePath)
            ?? panic("Could not borrow a reference to the owner's collection")
        self.mid     = mid
        self.feature = feature
        self.name    = name
    }

    execute {
        self.collectionRef.collections[self.name]!.addMID(creator: self.creatorRef, mid: self.mid, feature: self.feature)
        log("MID: ".concat(self.mid.toString()).concat(" added to Collection."))
    }
}
