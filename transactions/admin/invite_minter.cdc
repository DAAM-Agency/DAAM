// invite_minter.cdc
// Used for Admin to give Minter access.

import DAAM_V1 from 0x7db4d10c78bad30a

transaction(newMinter: Address) {
    let admin     : &DAAMDAAM_V1.Admin
    let newMinter : Address

    prepare(admin: AuthAccount) {
        self.admin     = admin.borrow<&DAAMDAAM_V1.Admin>(from: DAAM_V1.adminStoragePath)!
        self.newMinter = newMinter
    }

    pre { DAAM_V1.isMinter(newMinter) == nil : newMinter.toString().concat(" is already a Minter.") }

    execute {
        self.admin.inviteMinter(self.newMinter)
        log("Minter Invited")
    }
}
