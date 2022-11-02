// remove_tokenID_from_collection.cdc

import DAAM_V1 from 0x7db4d10c78bad30a

transaction(id: UInt64, name: String) {
    let collectionRef : &DAAMDAAM_V1.Collection
    let id            : UInt64
    let name          : String

    prepare(acct: AuthAccount) {
        // Borrow a reference from the stored collection
        self.collectionRef = acct.borrow<&DAAMDAAM_V1.Collection>(from: DAAM_V1.collectionStoragePath)
            ?? panic("Could not borrow a reference to the owner's collection")
        self.id   = id
        self.name = name
    }

    execute {
        self.collectionRef.collections[self.name]!.removeTokenID(id: self.id) 
        log("ID: ".concat(self.id.toString()).concat(" removed from Collection."))
    }
}
