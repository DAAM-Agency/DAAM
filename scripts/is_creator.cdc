// is_creator.cdc

import DAAM_V1 from 0x7db4d10c78bad30a

pub fun main(creator: Address): Bool? {
    return DAAM_V1.isCreator(creator)
}
// nil = not a creator, false = invited to be a creator, true = is a creator