// change_creator_status.cdc
// Used for Admin / Agents to change Creator status. True = active, False = frozen

import DAAM_V1 from 0x7db4d10c78bad30a

transaction(creator: Address, status: Bool) {
    let admin  : &DAAMDAAM_V1.Admin{DAAM.Agent}
    let creator : Address
    let status  : Bool

    prepare(agent: AuthAccount) {
        self.creator = creator  
        self.status  = status
        self.admin = agent.borrow<&DAAMDAAM_V1.Admin{DAAM.Agent}>(from: DAAM_V1.adminStoragePath)!
    }

    pre { DAAM_V1.isCreator(creator) != nil : creator.toString().concat(" is not a Creator.") }

    execute {
        self.admin.changeCreatorStatus(creator: self.creator, status: self.status)
        log("Change Creator Status")   
    }
}
