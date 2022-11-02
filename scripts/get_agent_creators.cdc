// get_agent_creators.cdc
// Get List of Creators and their Agent

import DAAM_V1 from 0x7db4d10c78bad30a

pub fun main(agent: Address): [Address]? {
    return DAAM_V1.getAgentCreators(agent: agent)
}
