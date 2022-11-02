// answer_minter_invite.cdc
// Answer the invitation to be a Minter. Typically only for Auctions & Marketplaces

import DAAM_V1 from 0x7db4d10c78bad30a

transaction(submit: Bool) {
    let signer: AuthAccount
    let submit: Bool

    prepare(signer: AuthAccount) {
        self.signer = signer
        self.submit = submit
    }

    execute {
        let minter <- DAAM_V1.answerMinterInvite(newMinter: self.signer, submit: self.submit)
        if minter != nil {
            let old_minter <- self.signer.load<@AnyResource>(from: DAAM_V1.minterStoragePath)
            self.signer.save<@DAAM.Minter>(<- minter!, to: DAAM_V1.minterStoragePath)
            destroy old_minter
            log("You are now a DAAM_V1.Minter")
        } else {
            destroy minter
            log("Thank You for your consoderation.")
        }
    }
}
