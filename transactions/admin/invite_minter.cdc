// invite_minter.cdc
// Used for Admin to give Minter access.

import DAAM from 0x7db4d10c78bad30a

transaction(newMinter: Address) {
    let admin     : &DAAM.Admin
    let newMinter : Address

    prepare(admin: AuthAccount) {
        self.admin     = admin.borrow<&DAAM.Admin>(from: DAAM.adminStoragePath)!
        self.newMinter = newMinter
    }

    pre { DAAM.isMinter(newMinter) == nil : newMinter.toString().concat(" is already a Minter.") }

    execute {
        self.admin.inviteMinter(self.newMinter)
        log("Minter Invited")
    }
}
