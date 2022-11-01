// init_DAAM_Agency.cdc

import MultiFungibleToken from 0x229e7617283d5085

pub fun main(): {Address: UFix64} {
        let name          = "DAAM"
        let founders:{Address: UFix64} = {0x41f376b241b0820c:0.23, 0x7ce76ffc2a9505b8:0.19, 0x035fb003685d0574:0.19, 0xbf47964278b5bd91:0.17,  0xb21107af4683c91c:0.11,  0xaa74bf519dbdcd42:0.11}
        let company:Address       = 0xc159639950ae05d8
        let defaultAdmins:[Address] = [0x11f6b019f78b2e5d, 0x6073cfd28f77c2c2, 0x76e351cd58c3ae77, 0xcc0eb5bbcf93da4d, 0x2bfae456ed3599ec, 0x5fea6d38683d8cf6]
        // Order: J.Y, A.K, A.R, M.H, M.R, G.P

        let list = founders.keys
        for f in list {
            let collectionRef = getAccount(f)
                .getCapability<&MultiFungibleToken.MultiFungibleTokenManager{MultiFungibleToken.MultiFungibleTokenBalance}>
                (MultiFungibleToken.MultiFungibleTokenBalancePath)
                .borrow()

            if (collectionRef == nil) { panic("Founder has no MFT Wallet") }
        }
        let collectionRef = getAccount(company)
                .getCapability<&MultiFungibleToken.MultiFungibleTokenManager{MultiFungibleToken.MultiFungibleTokenBalance}>
                (MultiFungibleToken.MultiFungibleTokenBalancePath)
                .borrow()

        if (collectionRef == nil) { panic("Company has no MFT Wallet") }

        return founders
}
 