// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/utils/Context.sol";

contract Dao is Context {

    string public name;
    string public symbol;
    string public logo;
    string public description;

    //Members
    struct MemberInfo {
        address user;
        uint256 userType; //0 - member, 1 - moderator
        uint256 level;
        uint256 status; //active, inactive, banned
        uint256 createTime;
        uint256 updateTime;
    }

    struct SessionBlock {
        uint256  proposalId;
        uint256  createTime;
        uint256  startTime;
        uint256  endTime;
        uint256  status;

        address[]  members;
        address[]  voices;
        address[]  moderators;
    }

    struct ProposalBlock {
        uint256  id;
        string  name;
        string  description;
        string  document;
        uint256  createTime;
        uint256  startTime;
        uint256  endTime;
        uint256  status;
        address  requester;
        address  dao;

        address[]  speakers;
        mapping(address => bool)  sessionSpeakers;

        address[]  moderators;
        mapping(address => bool)  sessionModerators;
    }

    uint256 public sessionCount;
    uint256 public proposalCount;

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

    function createNewProposal(
        string memory _name,
        string memory _description,
        string memory _document,
        uint256 _startTime,
        uint256 _endTime,
        address[] memory _speakers,
        address[] memory _moderators
    ) public returns (bool) {
        proposalCount++;
        ProposalBlock storage proposal = proposals[proposalCount];
        proposal.id = proposalCount;
        proposal.name = _name;
        proposal.description = _description;
        proposal.document = _document;
        proposal.createTime = block.timestamp;
        proposal.startTime = _startTime;
        proposal.endTime = _endTime;
        proposal.status = 0;
        proposal.requester = msg.sender;
        proposal.dao = address(this);
        proposal.speakers = _speakers;
        proposal.moderators = _moderators;
        for (uint256 i = 0; i < _speakers.length; i++) {
            proposal.sessionSpeakers[_speakers[i]] = true;
        }
        for (uint256 i = 0; i < _moderators.length; i++) {
            proposal.sessionModerators[_moderators[i]] = true;
        }
        return true;
    }

    function addSpeakerToProposal(
        uint256 _proposalId,
        address _speaker
    ) public returns (bool) {
        ProposalBlock storage proposal = proposals[_proposalId];
        proposal.speakers.push(_speaker);
        proposal.sessionSpeakers[_speaker] = true;
        return true;
    }

    function addSpeakersToProposal(
        uint256 _proposalId,
        address[] memory _speakers
    ) public returns (bool) {
        ProposalBlock storage proposal = proposals[_proposalId];
        for (uint256 i = 0; i < _speakers.length; i++) {
            proposal.speakers.push(_speakers[i]);
            proposal.sessionSpeakers[_speakers[i]] = true;
        }
        return true;
    }

    function createNewSession(
        uint256 _proposalId,
        uint256 _startTime,
        uint256 _endTime,
        address[] memory _members,
        address[] memory _voices,
        address[] memory _moderators
    ) public returns (bool) {
        SessionBlock storage session = sessions[_proposalId];
        session.proposalId = _proposalId;
        session.createTime = block.timestamp;
        session.startTime = _startTime;
        session.endTime = _endTime;
        session.status = 0;
        session.members = _members;
        session.voices = _voices;
        session.moderators = _moderators;
        return true;
    }

    function updateSession(
        uint256 _proposalId,
        uint256 _startTime,
        uint256 _endTime,
        address[] memory _members,
        address[] memory _voices,
        address[] memory _moderators
    ) public returns (bool) {
        SessionBlock storage session = sessions[_proposalId];
        session.startTime = _startTime;
        session.endTime = _endTime;
        session.members = _members;
        session.voices = _voices;
        session.moderators = _moderators;
        return true;
    }

}