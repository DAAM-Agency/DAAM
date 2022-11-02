// creator_bargin.cdc
// Used for Creator to respond to a bargin neogation

import DAAM_V1 from 0x7db4d10c78bad30a

transaction(mid: UInt64, percentage: UFix64)
{
    let creator    : &DAAMDAAM_V1.Creator
    let mid        : UInt64
    let percentage : UFix64

    prepare(creator: AuthAccount) {
        self.creator    = creator.borrow<&DAAMDAAM_V1.Creator>(from: DAAM_V1.creatorStoragePath)!
        self.mid        = mid
        self.percentage = percentage
    }

    execute {
        self.creator.bargin(mid: self.mid, percentage: self.percentage)
    }
}
