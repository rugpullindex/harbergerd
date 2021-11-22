// @format
pragma solidity ^0.8.6;
import "ds-test/test.sol";

import "./Harbergerd.sol";
import "indexed-sparse-merkle-tree/StateTree.sol";

contract HarbergerdTest is DSTest {
    Harbergerd h;

    function setUp() public {
        uint256 tax = 1;
        h = new Harbergerd(tax);
    }

    function testBuying() public {
        uint8 DEPTH = 8;
        bytes32[] memory proofs = new bytes32[](DEPTH);
        for (uint8 i = 0; i < proofs.length; i++) {
            proofs[i] = StateTree.get(i);
        }
        bytes32 newPrice = keccak256(abi.encode(1337));
        bytes32 oldPrice = keccak256(abi.encode(0));
        bytes32 oldOwner = keccak256(abi.encode(address(0)));
        uint start = gasleft();
        h.buy(proofs, newPrice, oldPrice, oldOwner);
        uint end = gasleft();
        emit log_named_uint("gas usage", start - end);
    }
}
