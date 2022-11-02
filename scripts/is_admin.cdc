// is_admin.cdc

import DAAM_V1 from 0x7db4d10c78bad30a

pub fun main(admin: Address): Bool? {
    return DAAM_V1.isAdmin(admin)
}
// nil = not an admin, false = invited to be an admin, true = is an admin