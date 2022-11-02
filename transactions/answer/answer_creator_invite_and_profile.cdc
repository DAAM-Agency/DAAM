// answer_creator_invite.cdc
// Answer the invitation to be a Creator.

import DAAM_Profile from 0x509abbf4f85f3d73
import DAAM_V1         from 0x7db4d10c78bad30a

transaction(submit: Bool) {
    let signer: AuthAccount
    let submit: Bool

    prepare(signer: AuthAccount) {
        self.signer = signer
        self.submit = submit     
    }

    execute {
        if !DAAM_Profile.check(self.signer.address) {
            let daamProfile = DAAM_Profile.createProfile()
            self.signer.save(<- daamProfile, to: DAAM_Profile.storagePath)
            self.signer.link<&DAAMDAAM_Profile.User{DAAM_Profile.Public}>(DAAM_Profile.publicPath, target: DAAM_Profile.storagePath)
        }

        let creator <- DAAM_V1.answerCreatorInvite(newCreator: self.signer, submit: self.submit)
        if creator != nil {
            let old_creator <- self.signer.load<@AnyResource>(from: DAAM_V1.creatorStoragePath)
            self.signer.save<@DAAM.Creator>(<- creator!, to: DAAM_V1.creatorStoragePath)
            let creatorRef = self.signer.borrow<&DAAMDAAM_V1.Creator>(from: DAAM_V1.creatorStoragePath)!
            destroy old_creator

            let old_mg <- self.signer.load<@AnyResource>(from: DAAM_V1.metadataStoragePath)
            let metadataGen <- creatorRef.newMetadataGenerator()
            self.signer.link<&DAAMDAAM_V1.MetadataGenerator{DAAM.MetadataGeneratorMint, DAAM_V1.MetadataGeneratorPublic}>(DAAM.metadataPublicPath, target: DAAM_V1.metadataStoragePath)
            self.signer.save<@DAAM.MetadataGenerator>(<- metadataGen, to: DAAM_V1.metadataStoragePath)
            destroy old_mg

            let old_request <- self.signer.load<@AnyResource>(from: DAAM_V1.requestStoragePath)
            let requestGen  <- creatorRef.newRequestGenerator()
            self.signer.save<@DAAM.RequestGenerator>(<- requestGen, to: DAAM_V1.requestStoragePath)
            destroy old_request

            log("You are now a DAAM_V1.Creator." )        
        } else {
            destroy creator
            log("Thank You for your Consoderation.")
        }
    }

    post { DAAM_Profile.check(self.signer.address): "Account was not initialized" }
}