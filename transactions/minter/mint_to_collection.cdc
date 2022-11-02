// mint_to_collection.cdc
// Used for Admin / Agent to mint on behalf in their Creator

//import NonFungibleToken from 0x1d7e57aa55817448
import MetadataViews    from 0x1d7e57aa55817448
import DAAM_V1             from 0x7db4d10c78bad30a

transaction(creator: Address, mid: UInt64, name: String, feature: Bool)
{
    let minterRef : &DAAMDAAM_V1.Minter
    let mid       : UInt64
    let name      : String
    let feature   : Bool
    let metadataRef  : &{DAAM.MetadataGeneratorMint}
    let collectionRef: &DAAMDAAM_V1.Collection{DAAM.CollectionPublic}
    let agentRef     : &DAAMDAAM_V1.Admin{DAAM.Agent}

    prepare(minter: AuthAccount) {
        self.minterRef = minter.borrow<&DAAMDAAM_V1.Minter>(from: DAAM_V1.minterStoragePath)!
        self.mid       = mid
        self.name      = name
        self.feature   = feature

        self.collectionRef = getAccount(creator)
            .getCapability(DAAM.collectionPublicPath)
            .borrow<&DAAMDAAM_V1.Collection{DAAM.CollectionPublic}>()!

        self.metadataRef = getAccount(creator)
            .getCapability(DAAM.metadataPublicPath)
            .borrow<&{DAAM.MetadataGeneratorMint}>()!
        
        self.agentRef = minter.borrow<&DAAMDAAM_V1.Admin{DAAM.Agent}>(from: DAAM_V1.adminStoragePath)!
    }

    execute
    {
        let minterAccess <- self.minterRef.createMinterAccess(mid: self.mid)
        let metadata <- self.metadataRef.generateMetadata(minter: <-minterAccess)
        let nft <- self.minterRef.mintNFT(metadata: <-metadata)
        self.collectionRef.depositByAgent(token: <-nft, name: self.name, feature: self.feature, permission: self.agentRef)
        
        log("Minted & Transfered")
    }
}
