# Token Standards Matrix & This Prototype's Classification

> From **Ethereum-Token-v2026.pdf** §"Architectural Selection". Even though this prototype is a
> *registry* (not a token), the lesson requires understanding where each standard fits.

## The matrix
| Standard | Spectrum | Core data structure | Optimal use case |
|----------|----------|---------------------|------------------|
| **ERC-20** (fungible) | identical, divisible units | `mapping(address => uint256) balances` | governance, stablecoins, utility/credit tokens |
| **ERC-721** (non-fungible) | unique, indivisible | `mapping(uint256 => address) owners` | digital real estate, **unique credentials**, deeds |
| **ERC-1155** (multi-token) | hybrid batches (FT + NFT) | `mapping(uint256 => mapping(address => uint256))` | gaming inventories, complex multi-asset ledgers |

Specs: ERC-20 https://ethereum.org/en/developers/docs/standards/tokens/erc-20/ ·
ERC-721 https://ethereum.org/en/developers/docs/standards/tokens/erc-721/ ·
ERC-1155 https://ethereum.org/en/developers/docs/standards/tokens/erc-1155/ ·
EIP-20 is the formal proposal that *defines* ERC-20.

## Native implementation via OpenZeppelin (the lesson's central pattern)
`Your Contract (custom logic)  ⇐ secure inheritance ⇐  OpenZeppelin (reviewed ERC/Access modules)`
- `ERC20.sol` → transfer logic, balances, allowances.
- `Ownable.sol` / `AccessControl.sol` → RBAC; this prototype inherits **`Ownable`** (owner = Regulator).
- `ReentrancyGuard.sol`, `Pausable.sol` → external-call + emergency-stop safety (both used here).

## How this prototype maps
- **Classification:** *small decentralized registry / attestation log* (SemesterProject-v3 scenario #1/#8) — **not** an ERC token. State is a `mapping(bytes32 => Attestation)`, not a balance ledger.
- **If it were tokenized:** each `EmissionCert` is unique → a natural **ERC-721** (one NFT per certificate, `tokenId = id`), with the Regulator as minter and `Status` as on-chain metadata. The current design keeps it as a lean registry to avoid NFT transfer-market surface that the use case doesn't need.
- **Sibling token prototype:** `Enigma-Decentralized-Student-Marketplace` demonstrates **ERC-20** (EnigCredit) + escrow — see its docs.

## Advanced standards to know (lesson "Advanced reading")
ERC-2612 (permit) · ERC-4626 (vaults) · ERC-5679 (mint/burn interfaces) · OZ Governance.
