// mint_to_collection.cdc
// Used for Admin / Agent to mint on behalf in their Creator

//import NonFungibleToken from 0x1d7e57aa55817448
import MetadataViews    from 0x1d7e57aa55817448
import DAAM             from 0x7db4d10c78bad30a

pub fun compareArray(_ mids: [UInt64], _ features: [UInt64]) {
    for f in features {
        if !mids.contains(f) { panic("MID: ".concat(f.toString().concat(" can not be Featured."))) }
    }
}

transaction(creator: Address, mid: [UInt64], name: String, feature: [UInt64])
{
    let minterRef : &DAAMDAAM_V1.Minter
    let mid       : [UInt64]
    let feature   : [UInt64]
    let name      : String
    let metadataRef  : &{DAAM.MetadataGeneratorMint}
    let collectionRef: &DAAMDAAM_V1.Collection{DAAM.CollectionPublic}
    let agentRef     : &DAAMDAAM_V1.Admin{DAAM.Agent}

    prepare(minter: AuthAccount) {
        compareArray(mid, feature)
        self.minterRef = minter.borrow<&DAAMDAAM_V1.Minter>(from: DAAM.minterStoragePath)!
        self.mid       = mid
        self.feature   = feature

        self.collectionRef  = getAccount(creator)
            .getCapability(DAAM.collectionPublicPath)
            .borrow<&DAAMDAAM_V1.Collection{DAAM.CollectionPublic}>()!

        self.metadataRef = getAccount(creator)
            .getCapability(DAAM.metadataPublicPath)
            .borrow<&{DAAM.MetadataGeneratorMint}>()!
        
        self.agentRef = minter.borrow<&DAAMDAAM_V1.Admin{DAAM.Agent}>(from: DAAM.adminStoragePath)!

        self.name = name
    }

    execute
    {
        for m in self.mid {
            let minterAccess <- self.minterRef.createMinterAccess(mid: m)
            let metadata <- self.metadataRef.generateMetadata(minter: <-minterAccess)
            let nft <- self.minterRef.mintNFT(metadata: <-metadata)
            self.collectionRef.depositByAgent(token: <-nft, name: self.name, feature: self.feature.contains(m), permission: self.agentRef)
            
            log("Minted & Transfered")
        }
    }
}
 