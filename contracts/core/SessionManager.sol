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

    struct SessionBlock {
        uint256 id;
        SessionInfo info;
        SessionMembers members;
    }

    struct SessionInfo {
        uint256 createTime;
        uint256 startTime;
        uint256 endTime;
        uint256 status;
    }

    struct SessionMembers {
        address[] members;
        address[] voices;
        address[] moderators;
    }

    mapping(address => mapping(uint256 => SessionBlock)) public sessions;
}
