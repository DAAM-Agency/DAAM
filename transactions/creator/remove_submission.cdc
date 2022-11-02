// remove_submission.cdc
// Creator can remove Metadata submission

import NonFungibleToken from 0x1d7e57aa55817448
import DAAM_V1             from 0x7db4d10c78bad30a

transaction(mid: UInt64)
{    
    let creator     : AuthAccount
    let mid         : UInt64
    let metadataGen : &DAAMDAAM_V1.MetadataGenerator

    prepare(creator: AuthAccount) {
        self.creator = creator
        self.metadataGen = self.creator.borrow<&DAAMDAAM_V1.MetadataGenerator>(from: DAAM_V1.metadataStoragePath)!
        self.mid = mid
    }

    execute {
        self.metadataGen.removeMetadata(mid: self.mid)        
        log("Metadata Submitted")
    }
}
