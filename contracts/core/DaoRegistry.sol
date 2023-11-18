// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/utils/Context.sol";
import "./Dao.sol";

//todo***
contract DaoRegistry is Context {

    mapping(address => Dao) public registry;


}
