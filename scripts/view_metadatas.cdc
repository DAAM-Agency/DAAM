// view_metadatas.cdc

import DAAM_V1 from 0x7db4d10c78bad30a

pub fun main(creator: Address): [DAAM.MetadataHolder] {
    let metadataRef = getAccount(creator)
        .getCapability<&DAAMDAAM_V1.MetadataGenerator{DAAM.MetadataGeneratorPublic}>(DAAM.metadataPublicPath)
        .borrow()!
        
    return metadataRef.viewMetadatas()
}