// get_creators.cdc
// Get List of Agents

import DAAM_V1 from 0x7db4d10c78bad30a

pub fun main(): {Address: [DAAM.CreatorInfo] } {
    return DAAM_V1.getAgents()
}