// change_copyright.cdc
// Used for Admin / Agents to change Copyright status of MID
/*
0 as int 8 = DAAM_V1.CopyrightStatus.FRAUD
1 as int 8 = DAAM_V1.CopyrightStatus.CLAIM
2 as int 8 = DAAM_V1.CopyrightStatus.UNVERIFIED
3 as int 8 = DAAM_V1.CopyrightStatus.VERIFIED
4 as int 8 = DAAM_V1.CopyrightStatus.INCLUDED
*/

import DAAM_V1 from 0x7db4d10c78bad30a
    
transaction(creator: Address, mid: UInt64, copyright: UInt8) {
    let cr     : DAAM_V1.CopyrightStatus
    let admin  : &DAAMDAAM_V1.Admin{DAAM.Agent}
    let mid    : UInt64
    let creator: Address

    prepare(agent: AuthAccount) {
        self.cr      = DAAM_V1.CopyrightStatus(rawValue: copyright)!                             // init copyright
        self.admin   = agent.borrow<&DAAMDAAM_V1.Admin{DAAM.Agent}>(from: DAAM_V1.adminStoragePath)! // init admin
        self.mid     = mid 
        self.creator = creator                                                        // init mid
    }

    pre { copyright < 5 : "Copyright: Invalid Entry" } // Verify copyright is within DAAM_V1.CopyrightStatus length

    execute {
        self.admin.changeCopyright(creator: self.creator, mid: self.mid, copyright: self.cr)  // Change Copyright status
        log("Copyright Changed")
    }
}