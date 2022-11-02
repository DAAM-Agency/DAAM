// answer_admin_invite.cdc
// Answer the invitation to be an Admin.

import DAAM_V1 from 0x7db4d10c78bad30a

transaction(submit: Bool) {
    let signer: AuthAccount
    let submit: Bool

    prepare(signer: AuthAccount) {
        self.signer = signer
        self.submit = submit     
    }

    execute {
        let admin <- DAAM_V1.answerAdminInvite(newAdmin: self.signer, submit: self.submit)
        if admin != nil {
            let old_admin <- self.signer.load<@AnyResource>(from: DAAM_V1.adminStoragePath)
            self.signer.save<@DAAM.Admin>(<- admin!, to: DAAM_V1.adminStoragePath)
            let adminRef = self.signer.borrow<&DAAMDAAM_V1.Admin>(from: DAAM_V1.adminStoragePath)!
            destroy old_admin

            let old_request <- self.signer.load<@AnyResource>(from: DAAM_V1.requestStoragePath)
            let requestGen <-! adminRef.newRequestGenerator()
            self.signer.save<@DAAM.RequestGenerator>(<- requestGen, to: DAAM_V1.requestStoragePath)
            destroy old_request
            
            log("You are now a DAAM_V1.Admin: ".concat(self.signer.address.toString()) )
        } else {
            destroy admin
            log("Thank You for your consoderation.")
        }
    }
}
