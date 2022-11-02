// get_creators.cdc
// Get List of Creators and their Agent

import DAAM_V1 from 0x7db4d10c78bad30a

pub fun main(): {Address: DAAM_V1.CreatorInfo} { return DAAM_V1.getCreators() }