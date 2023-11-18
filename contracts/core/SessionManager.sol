// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/utils/Context.sol";
import "./Dao.sol";

//todo add events
contract SessionManager is Context {

    Dao private manager;

    constructor(Dao manager) {
        manager = manager;
    }
}
