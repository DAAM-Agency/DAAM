// remove_creator.cdc
// Used for Admin / Agents to remove Creator

import DAAM_V1 from 0x7db4d10c78bad30a

transaction(exCreator: Address)
{
    let admin   : &DAAMDAAM_V1.Admin{DAAM.Agent}
    let creator : Address

    prepare(agent: AuthAccount) {
        self.admin   = agent.borrow<&DAAMDAAM_V1.Admin{DAAM.Agent}>(from: DAAM_V1.adminStoragePath) ?? panic(exCreator.toString().concat(" is not a Creator."))
        self.creator = exCreator
    }

    // Verify is Creator
    pre { DAAM_V1.isCreator(exCreator) != nil : exCreator.toString().concat(" is not a Creator. Can not remove.") }
    
    execute {
        self.admin.removeCreator(creator: self.creator)
        log("Remove Creator")
    }

    post { DAAM_V1.isCreator(self.creator) == nil : self.creator.toString().concat(" has Not been removed.") } // Verify is not a Creator
}
