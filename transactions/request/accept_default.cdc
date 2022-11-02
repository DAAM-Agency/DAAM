// accept_default.cdc
// Creator selects Royalty between 10% to 30%

import FungibleToken from 0xf233dcee88fe0abe 
import MetadataViews from 0x1d7e57aa55817448
import DAAM_V1          from 0x7db4d10c78bad30a

transaction(mid: UInt64, percentage: UFix64) {
    let mid         : UInt64
    let percentage  : UFix64
    let requestGen  : &DAAMDAAM_V1.RequestGenerator
    let metadataGen : &DAAMDAAM_V1.MetadataGenerator
    let royalties   : MetadataViews.Royalties

    prepare(creator: AuthAccount) {
        self.mid     = mid
        self.percentage  = percentage
        self.requestGen  = creator.borrow<&DAAMDAAM_V1.RequestGenerator>( from: DAAM_V1.requestStoragePath)!
        self.metadataGen = creator.borrow<&DAAMDAAM_V1.MetadataGenerator>(from: DAAM_V1.metadataStoragePath)!

        let royalties    = [ MetadataViews.Royalty(
            receiver: creator.getCapability<&AnyResource{FungibleToken.Receiver}>(MetadataViews.getRoyaltyReceiverPublicPath()),
            cut: percentage,
            description: "Creator Royalty" )
        ]
        self.royalties = MetadataViews.Royalties(royalties)
    }

    pre { percentage >= 0.01 || percentage <= 0.3 }

    execute {
        self.requestGen.acceptDefault(mid: self.mid, metadataGen: self.metadataGen, royalties: self.royalties)
        log("Request Made")
    }
}
