// view_all_metadatas.cdc

import DAAM_V1 from 0x7db4d10c78bad30a

pub fun main(): {Address: [DAAM.MetadataHolder]}
{
    let creators = DAAM_V1.getCreators()
    var list: {Address: [DAAM.MetadataHolder]} = {}

    for creator in creators.keys {
        let metadataRef = getAccount(creator)
        .getCapability<&DAAMDAAM_V1.MetadataGenerator{DAAM.MetadataGeneratorPublic}>(DAAM.metadataPublicPath)
        .borrow()!

        list.insert(key: creator, metadataRef.viewMetadatas())
    }
    return list
}