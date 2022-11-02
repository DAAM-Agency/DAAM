// invite_admin_minter.cdc
// Used for Admin to invite another Admin.
// Used for Admin to give Minter access.
// The invitee Must have a Profile before receiving or accepting this Invitation

import DAAM_V1 from 0x7db4d10c78bad30a

transaction(newAgent: Address, minterAccess: Bool)
{
    let admin    : &DAAMDAAM_V1.Admin
    let newAgent : Address 

    prepare(admin: AuthAccount) {
        self.admin    = admin.borrow<&DAAMDAAM_V1.Admin>(from: DAAM_V1.adminStoragePath)!
        self.newAgent = newAgent
    }

    pre {
        DAAM_V1.isAdmin(newAgent)   == nil : newAgent.toString().concat(" is already an Admin.")
        DAAM_V1.isAgent(newAgent)   == nil : newAgent.toString().concat(" is already an Agent.")
        DAAM_V1.isCreator(newAgent) == nil : newAgent.toString().concat(" is already a Creator.")
        DAAM_V1.isMinter(newAgent)  == nil : newAgent.toString().concat(" is already a Minter.")
    }
    
    execute {
        self.admin.inviteAgent(self.newAgent)
        log("Agent Invited")

        if(minterAccess) {
            self.admin.inviteMinter(self.newAgent)
            log("Minter Invited")
        }
    }
}
