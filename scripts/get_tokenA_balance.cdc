// get_TokenA_balance.cdc

import FungibleToken from 0xf233dcee88fe0abe
import FlowToken     from 0x1654653399040a619
import TokenA          from 0xec4809cd812aee0a

pub fun main(address: Address): UFix64?
{
  let vaultRef = getAccount(address)
    .getCapability<&TokenA.Vault{FungibleToken.Balance}>(/public/TokenABalance)
    .borrow<>()
    //?? panic("Could not borrow Balance capability")

  return vaultRef?.balance
}