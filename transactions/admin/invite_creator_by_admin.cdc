// invite_creator.cdc
// Used for Admin / Agent to invite a Creator.
// The invitee Must have a Profile before receiving or accepting this Invitation

import DAAM from 0x7db4d10c78bad30a

transaction(creator: Address)
{
    let admin   : &{DAAM.Agent}
    let creator : Address

    prepare(agent: AuthAccount) {
        self.admin   = agent.borrow<&DAAMDAAM_V1.Admin{DAAM.Agent}>(from: DAAM.adminStoragePath)!
        self.creator = creator
    }

    pre {
        DAAM.isAdmin(creator)   == nil : creator.toString().concat(" is already an Admin.")
        DAAM.isAgent(creator)   == nil : creator.toString().concat(" is already an Agent.")
        DAAM.isCreator(creator) == nil : creator.toString().concat(" is already an Creator.")
    }
    
    execute {
        self.admin.inviteCreator(self.creator, agentCut: nil)
        log("Creator Invited")
    }

    post { DAAM.isCreator(self.creator) != nil : self.creator.toString().concat(" invitation has not been sent.") }
}
