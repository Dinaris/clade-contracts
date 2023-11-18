// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/utils/Context.sol";

contract SessionBlock is Context {
    uint256 public proposalId;
    uint256 public createTime;
    uint256 public startTime;
    uint256 public endTime;
    uint256 public status;

    address[] public members;
    address[] public voices;
    address[] public moderators;
}

contract ProposalBlock is Context {

    uint256 public id;
    string public name;
    string public description;
    string public document; //ipfs
    uint256 public createTime;
    uint256 public startTime;
    uint256 public endTime;
    uint256 public status;
    address public requester;
    address public dao;

    //Votes
    address[] public votes;
    mapping(address => bool) public sessionVotes;

    //Speakers
    address[] public speakers;
    mapping(address => bool) public sessionSpeakers;

    //Moderators
    address[] public moderators;
    mapping(address => bool) public sessionModerators;
}

contract Dao is Context {

    string public name;
    string public symbol;
    string public logo;
    string public description;

    //Members
    struct MemberInfo {
        address user;
        uint256 userType;
        uint256 level;
        uint256 status;
        uint256 createTime;
        uint256 updateTime;
    }

    mapping(uint256 => SessionBlock) public sessions;
    mapping(uint256 => ProposalBlock) public proposals;

    constructor(
        string memory _name,
        string memory _symbol,
        string memory _logo,
        string memory _description
    ) {
        name = _name;
        symbol = _symbol;
        logo = _logo;
        description = _description;
    }

    mapping(address => MemberInfo) public members;

    modifier isMember(address _user) {
        require(members[_user].user == _user, "CladeDao: user is not member");
        _;
    }

    modifier isNotMember(address _user) {
        require(members[_user].user != _user, "CladeDao: user is member");
        _;
    }

    modifier isModerator(address _user) {
        require(members[_user].user == _user, "CladeDao: user is not member");
        require(members[_user].userType == 1, "CladeDao: user is not moderator");
        _;
    }

}