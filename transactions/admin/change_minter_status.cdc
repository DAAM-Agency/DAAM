// change_minter_status.cdc
// Used for Admin to change Minter status. True = active, False = frozen

import DAAM from 0x7db4d10c78bad30a

transaction(minter: Address, status: Bool) {
    let admin   : &DAAMDAAM_V1.Admin
    let minter : Address
    let status  : Bool

    prepare(agent: AuthAccount) {
        self.minter = minter  
        self.status  = status
        self.admin = agent.borrow<&DAAMDAAM_V1.Admin>(from: DAAM.adminStoragePath)!
    }

    pre { DAAM.isMinter(minter) != nil : minter.toString().concat(" is not a Minter.") }

    execute {
        self.admin.changeMinterStatus(minter: self.minter, status: self.status)
        log("Change Minter Status")   
    }
}
