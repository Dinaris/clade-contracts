// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/utils/Context.sol";

contract SessionManager is Context {

    struct SessionBlock {
        uint256 id;
        SessionInfo info;
        SessionTimeline timeline;
        SessionMembers members;
    }

    struct SessionInfo {
        address governance;
        uint256 id;
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

    struct SessionTimeline {
        string dotsIpfs;
        string actionsIpfs;
    }

    mapping(uint256 => SessionBlock) public sessions;

    function createSession(
        uint256 _id,
        address _governance,
        uint256 _startTime,
        uint256 _endTime
    ) public returns (bool) {
        SessionInfo memory info = SessionInfo({
            governance: _governance,
            id: _id,
            createTime: block.timestamp,
            startTime: _startTime,
            endTime: _endTime,
            status: 0
        });
        SessionTimeline memory timeline = SessionTimeline({
            dotsIpfs: "",
            actionsIpfs: ""
        });
        SessionMembers memory members = SessionMembers({
            members: new address[](0),
            voices: new address[](0),
            moderators: new address[](0)
        });
        SessionBlock memory session = SessionBlock({
            id: _id,
            info: info,
            timeline: timeline,
            members: members
        });
        sessions[_id] = session;
        return true;
    }

    function getTimeline(uint256 _id) public view returns (SessionTimeline memory) {
        return sessionBlocks[_id].timeline;
    }

    function setTimeline(
        uint256 _id,
        string memory _dotsIpfs,
        string memory _actionsIpfs
    ) public returns (bool) {
        SessionTimeline memory timeline = SessionTimeline({
            dotsIpfs: _dotsIpfs,
            actionsIpfs: _actionsIpfs
        });
        sessionBlocks[_id].timeline = timeline;
        return true;
    }

    function getSessionInfo(uint256 _id) public view returns (SessionInfo memory) {
        return sessionBlocks[_id].info;
    }

}
