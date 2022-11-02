// mint.cdc
// Used for Admin / Agent to mint on behalf in their Creator

import NonFungibleToken from 0x1d7e57aa55817448
import MetadataViews    from 0x1d7e57aa55817448
import DAAM_V1             from 0x7db4d10c78bad30a

transaction(creator: Address, mid: UInt64)
{
    let minterRef : &DAAMDAAM_V1.Minter
    let mid       : UInt64
    let metadataRef : &{DAAM.MetadataGeneratorMint}
    let receiverRef : &{NonFungibleToken.CollectionPublic}

    prepare(minter: AuthAccount) {
        self.minterRef = minter.borrow<&DAAMDAAM_V1.Minter>(from: DAAM_V1.minterStoragePath)!
        self.mid       = mid

        self.receiverRef  = getAccount(creator)
            .getCapability(DAAM.collectionPublicPath)
            .borrow<&{NonFungibleToken.CollectionPublic}>()!


        self.metadataRef = getAccount(creator)
            .getCapability(DAAM.metadataPublicPath)
            .borrow<&{DAAM.MetadataGeneratorMint}>()!
    }

    execute {
        let minterAccess <- self.minterRef.createMinterAccess(mid: self.mid)
        let metadata <- self.metadataRef.generateMetadata(minter: <-minterAccess)
        let nft <- self.minterRef.mintNFT(metadata: <-metadata)
        self.receiverRef.deposit(token: <-nft )
        
        log("Minted & Transfered")
    }
}
