// @format
pragma solidity ^0.8.6;

import "indexed-sparse-merkle-tree/StateTree.sol";

contract Harbergerd {
    enum Slots { Owner, Price }
    uint256 blockTax;
    bytes32 public root;


    constructor(uint256 _blockTax) {
        root = StateTree.empty();
        blockTax = _blockTax;
    }

    function buy(
        bytes32[] memory _proofs,
        bytes32 _newPrice,
        bytes32 _oldPrice,
        bytes32 _oldOwner
    ) public {
        bytes32 tempRoot = StateTree.write(
            _proofs,
            uint8(Slots.Price),
            _newPrice,
            _oldPrice,
            root
        );
        _proofs[0] = _newPrice;
        root = StateTree.write(
            _proofs,
            uint8(Slots.Owner),
            keccak256(abi.encode(msg.sender)),
            _oldOwner,
            tempRoot
        );
    }
}
