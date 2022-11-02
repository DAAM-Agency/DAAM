// get_NFTs_metadata.cdc

import NonFungibleToken from 0x1d7e57aa55817448
import DAAM_V1 from 0x7db4d10c78bad30a

pub fun main(account: Address): [&DAAMDAAM_V1.NFT] {
     let collectionRef = getAccount(account).getCapability<&{NonFungibleToken.CollectionPublic}>(DAAM.collectionPublicPath).borrow()
     ?? panic("Could not borrow capability from public collection")
     
     let daamRef = getAccount(account).getCapability<&{DAAM.CollectionPublic}>(DAAM.collectionPublicPath).borrow()
     ?? panic("Could not borrow capability from public collection")

     let ids = collectionRef.getIDs()
     var nfts: [&DAAMDAAM_V1.NFT] = []

     for id in ids { nfts.append(daamRef.borrowDAAM(id: id)) }
     return nfts
}
