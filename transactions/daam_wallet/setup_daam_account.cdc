// setup_daam_account.cdc
// Create A DAAM_V1 Wallet to store DAAM_V1 NFTs
// Includes: /multitoken/setup_mft_receiver.cdc

import NonFungibleToken   from 0x1d7e57aa55817448
import FungibleToken      from 0xf233dcee88fe0abe
import MetadataViews      from 0x1d7e57aa55817448
import MultiFungibleToken from 0xfa1c6cfe182ee46b
import DAAM_V1               from 0x7db4d10c78bad30a

transaction(public: Bool)
{
    let public: Bool
    let acct: AuthAccount
    let have_collection: Bool
    let have_mft: Bool

    prepare(acct: AuthAccount) {
        if acct.borrow<&DAAMDAAM_V1.Collection>(from: DAAM_V1.collectionStoragePath) != nil {
            self.have_collection = true
            panic("You already have a DAAM_V1 Collection.")
        } else {
            self.have_collection = false
        }

        if acct.borrow<&MultiFungibleToken.MultiFungibleTokenManager{MultiFungibleToken.MultiFungibleTokenBalance}>(from: MultiFungibleToken.MultiFungibleTokenStoragePath) != nil {
            self.have_mft = true
            panic("You already have a Multi-FungibleToken-Manager.")
        } else {
            self.have_mft = false
        }

        self.public = public
        self.acct   = acct
    }

    execute {
        if !self.have_collection {
            let collection <- DAAM_V1.createEmptyCollection()    // Create a new empty collection
            self.acct.save<@NonFungibleToken.Collection>(<-collection, to: DAAM_V1.collectionStoragePath) // save the new account
            
            if self.public {
                self.acct.link<&DAAMDAAM_V1.Collection{DAAM.CollectionPublic, NonFungibleToken.CollectionPublic, MetadataViews.ResolverCollection, MetadataViews.Resolver}>(DAAM.collectionPublicPath, target: DAAM_V1.collectionStoragePath)
                log("DAAM Account Created. You have a DAAM_V1 Collection (Public) to store NFTs'")
            } else {
                log("DAAM Account Created. You have a DAAM_V1 Collection (Non-Public) to store NFTs'")
            }
        }

        if !self.have_mft {
            // MultiFungibleToken
            let mft <- MultiFungibleToken.createEmptyMultiFungibleTokenReceiver()    // Create a new empty collection
            self.acct.save<@MultiFungibleToken.MultiFungibleTokenManager>(<-mft, to: MultiFungibleToken.MultiFungibleTokenStoragePath) // save the new account
            
            self.acct.link<&MultiFungibleToken.MultiFungibleTokenManager{FungibleToken.Receiver}>
                (MultiFungibleToken.MultiFungibleTokenReceiverPath, target: MultiFungibleToken.MultiFungibleTokenStoragePath)
            
            self.acct.link<&MultiFungibleToken.MultiFungibleTokenManager{MultiFungibleToken.MultiFungibleTokenBalance}>
                (MultiFungibleToken.MultiFungibleTokenBalancePath, target: MultiFungibleToken.MultiFungibleTokenStoragePath)
            
            log("MultiFungibleToken Receiver Created")
        }
    }
}
