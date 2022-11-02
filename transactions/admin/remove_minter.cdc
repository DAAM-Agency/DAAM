// remove_admin.cdc
// Two Admins can remove another Admin. Must be run by two Admins.

import DAAM_V1 from 0x7db4d10c78bad30a

transaction(exMinter: Address)
{
    let admin    : &DAAMDAAM_V1.Admin
    let exMinter : Address

    prepare(admin: AuthAccount) {
        self.admin = admin.borrow<&DAAMDAAM_V1.Admin>(from: DAAM_V1.adminStoragePath) ?? panic(exMinter.toString().concat(" is not a Minter."))
	    self.exMinter = exMinter
    }

    // Verify exMinter is an Admin
    pre { DAAM_V1.isMinter(exMinter) != nil : admin.address.toString().concat(" does not have Minter Key.") }

    execute {
        self.admin.removeMinter(minter: self.exMinter)
        log("Removed Minter")
    }
}
