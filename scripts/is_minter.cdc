// is_minter.cdc

import DAAM_V1 from 0x7db4d10c78bad30a

pub fun main(minter: Address): Bool? {
    return DAAM_V1.isMinter(minter)
}
// nil = not an minter, false = invited to be an minter, true = is an minter