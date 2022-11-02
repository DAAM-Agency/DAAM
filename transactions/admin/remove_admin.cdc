// remove_admin.cdc
// Two Admins can remove another Admin. Must be run by two Admins.

import DAAM_V1 from 0x7db4d10c78bad30a

transaction(exAdmin: Address)
{
    let admin   : &DAAMDAAM_V1.Admin
    let exAdmin : Address

    prepare(admin: AuthAccount) {
        self.admin = admin.borrow<&DAAMDAAM_V1.Admin>(from: DAAM_V1.adminStoragePath) ?? panic(exAdmin.toString().concat(" is not an Admin."))
	    self.exAdmin = exAdmin
    }

    // Verify exAdmin is an Admin
    pre { DAAM_V1.isAdmin(exAdmin) != nil : exAdmin.toString().concat(" is not an Admin.") }

    execute {
        self.admin.removeAdmin(admin: self.exAdmin)
        log("Remove Admin Requested")
    }
}
