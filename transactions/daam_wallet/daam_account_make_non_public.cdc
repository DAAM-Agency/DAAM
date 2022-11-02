// daam_account_make_non_public.cdc
// Make DAAM_V1 Wallet Non-Public

import DAAM_V1 from 0x7db4d10c78bad30a

transaction()
{
    prepare(acct: AuthAccount) {
        if acct.borrow<&DAAMDAAM_V1.Collection>(from: DAAM_V1.collectionStoragePath) != nil {
            acct.unlink(DAAM.collectionPublicPath)
            log("DAAM Account Created, you now have a Non-Public DAAM_V1 .Collection to store NFTs'")
        } else {
            log("You do not have an Account. Make one first.")
        }
    }
}
