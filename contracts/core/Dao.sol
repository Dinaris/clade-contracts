// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/utils/Context.sol";

contract Dao is Context {

    string public name;
    string public symbol;
    string public logo;
    string public description;

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

    struct MemberInfo {
        address user;
        uint256 userType;
        uint256 level;
        uint256 status;
        uint256 createTime;
        uint256 updateTime;
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