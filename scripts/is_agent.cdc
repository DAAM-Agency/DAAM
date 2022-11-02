// is_agent.cdc

import DAAM_V1 from 0x7db4d10c78bad30a

pub fun main(agent: Address): Bool? {
    return DAAM_V1.isAgent(agent)
}
// nil = not an agent, false = invited to be an agent, true = is an agent