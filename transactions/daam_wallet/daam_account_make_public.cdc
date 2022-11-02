// daam_account_make_public.cdc
// Make DAAM_V1 Wallet Public

import NonFungibleToken from 0x1d7e57aa55817448
import MetadataViews    from 0x1d7e57aa55817448
import DAAM_V1             from 0x7db4d10c78bad30a
transaction()
{
    let acct: AuthAccount

    prepare(acct: AuthAccount) {
        self.acct = acct
    }

    execute {
        self.acct.link<&DAAMDAAM_V1.Collection{DAAM.CollectionPublic, NonFungibleToken.CollectionPublic, MetadataViews.ResolverCollection, MetadataViews.Resolver}>(DAAM.collectionPublicPath, target: DAAM_V1.collectionStoragePath)
        log("DAAM Account Created, you now have a Public DAAM_V1 Collection to store NFTs'")
    }
}
