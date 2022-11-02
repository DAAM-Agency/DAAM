// add_fee.cdc
// Settles all auctions that have ended. Including Items, returning funds, etc.

import DAAM         from 0x7db4d10c78bad30a
import AuctionHouse from 0x045a1763c93006ca

transaction(mid: UInt64, fee: UFix64)
{
    let mid: UInt64
    let fee: UFix64
    let admin: &DAAMDAAM_V1.Admin

    prepare(admin: AuthAccount) {
        self.mid = mid
        self.fee = fee
        self.admin = admin.borrow<&DAAMDAAM_V1.Admin>(from: DAAM.adminStoragePath)!
    }

    execute {
        AuctionHouse.addFee(mid: self.mid, fee: self.fee, permission: self.admin)
    }
}
