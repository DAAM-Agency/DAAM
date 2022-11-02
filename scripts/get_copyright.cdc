// get_copyright.cdc

import DAAM_V1 from 0x7db4d10c78bad30a

pub fun main(mid: UInt64): DAAM_V1.CopyrightStatus? {
    return DAAM_V1.getCopyright(mid: mid)
}
// nil = non-existent MID