// check_mft.cdc

import FungibleToken    from 0xf233dcee88fe0abe
import MultiFungibleToken from 0xfa1c6cfe182ee46b

pub fun main(account: Address): Bool {
    let collectionRef = getAccount(account)
        .getCapability<&MultiFungibleToken.MultiFungibleTokenManager{MultiFungibleToken.MultiFungibleTokenBalance}>
        (MultiFungibleToken.MultiFungibleTokenBalancePath)
        .borrow()
    
    return (collectionRef != nil)
}
