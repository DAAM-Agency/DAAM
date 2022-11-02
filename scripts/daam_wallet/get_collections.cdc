// get_collections.cdc

//import MetadataViews from 0x1d7e57aa55817448
import DAAM_V1 from 0x7db4d10c78bad30a

pub fun main(account: Address): {String: DAAM_V1.NFTCollectionDisplay} {
    let collectionRef = getAccount(account)
        .getCapability<&{DAAM.CollectionPublic}>(DAAM.collectionPublicPath)
        .borrow()
        ?? panic("Could not borrow capability from public collection")
    
    let list = collectionRef.getCollection()
    //var value: {String: DAAM_V1.NFTCollectionDisplay} = {}
    //for col in list { value.insert(key: col.display.name, col) }
    //return value
    return list
}
