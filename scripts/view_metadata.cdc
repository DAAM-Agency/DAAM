// view_metadata.cdc

import DAAM_V1 from 0x7db4d10c78bad30a

pub fun main(creator: Address, mid: UInt64): DAAM_V1.MetadataHolder? {
    let metadataRef = getAccount(creator)
        .getCapability<&DAAMDAAM_V1.MetadataGenerator{DAAM.MetadataGeneratorPublic}>(DAAM.metadataPublicPath)
        .borrow()!
        
    return metadataRef.viewMetadata(mid: mid)
}