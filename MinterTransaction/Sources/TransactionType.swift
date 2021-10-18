//
// Created by Daniil Dulin on 07.10.2021.
//

public enum TransactionType: Int {
    case Send                         = 0x01
    case SellCoin                     = 0x02
    case SellAllCoin                  = 0x03
    case BuyCoin                      = 0x04
    case CreateCoin                   = 0x05
    case DeclareCandidacy             = 0x06
    case Delegate                     = 0x07
    case Unbond                       = 0x08
    case RedeemCheck                  = 0x09
    case SetCandidateOnline           = 0x0A
    case SetCandidateOffline          = 0x0B
    case CreateMultisig               = 0x0C
    case Multisend                    = 0x0D
    case EditCandidate                = 0x0E
    case SetHaltBlock                 = 0x0F
    case RecreateCoin                 = 0x10
    case EditCoinOwner                = 0x11
    case EditMultisig                 = 0x12
    case PriceVote                    = 0x13
    case EditCandidatePublicKey       = 0x14
    case AddLiquidity                 = 0x15
    case RemoveLiquidity              = 0x16
    case SellSwapPool                 = 0x17
    case BuySwapPool                  = 0x18
    case SellAllSwapPool              = 0x19
    case EditCommissionCandidate      = 0x1A
    case MoveStake                    = 0x1B
    case MintToken                    = 0x1C
    case BurnToken                    = 0x1D
    case CreateToken                  = 0x1E
    case RecreateToken                = 0x1F
    case VoteCommission               = 0x20
    case VoteUpdate                   = 0x21
    case CreateSwapPool               = 0x22
    case AddLimitOrder                = 0x23
    case RemoveLimitOrder             = 0x24
}
