// add_fee.cdc
// Settles all auctions that have ended. Including Items, returning funds, etc.

import FungibleToken from 0xf233dcee88fe0abe
import FUSD          from 0x3c5959b568896393
import DAAM_V1          from 0x7db4d10c78bad30a
import AuctionHouse  from 0x045a1763c93006ca


transaction()
{
    //let crypto: &FungibleToken.Vault
    let path  : PublicPath
    let admin : &DAAMDAAM_V1.Admin

    prepare(admin: AuthAccount) {
       
        //self.crypto = crypto
        self.path   = /public/fusdReceiver
        self.admin  = admin.borrow<&DAAMDAAM_V1.Admin>(from: DAAM_V1.adminStoragePath)!
    }

    execute {
        let vault <-FUSD.createEmptyVault()
        AuctionHouse_V14.addCrypto(crypto: &vault as &FungibleToken.Vault, path: self.path, permission: self.admin)
        destroy vault
    }
}
