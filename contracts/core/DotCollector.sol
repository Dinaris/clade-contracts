// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/utils/Context.sol";
import "./Dao.sol";

//todo add events
contract DotCollector is Context {

    struct Dot {
        address from;
        address to;
        uint256 value;
    }

    //dao => session => dot
    mapping(address => mapping(uint256 => Dot[])) public dots;

    event DotAdded(address dao, uint256 session, address from, address to, uint256 value);

    function addDot(
        address _dao,
        uint256 _session,
        address _from,
        address _to,
        uint256 _value
    ) public returns (bool) {
        Dot memory dot = Dot({
            from: _from,
            to: _to,
            value: _value
        });
        dots[_dao][_session].push(dot);
        return true;
    }

    function addDots(
        address _dao,
        uint256 _session,
        address[] memory _from,
        address[] memory _to,
        uint256[] memory _value
    ) public returns (bool) {
        require(
            _from.length == _to.length && _to.length == _value.length,
            "DotCollector: addDots: arrays length mismatch"
        );
        for (uint256 i = 0; i < _from.length; i++) {
            addDot(_dao, _session, _from[i], _to[i], _value[i]);
        }
        return true;
    }

    function addDot(
        uint256 _session,
        address _from,
        address _to,
        uint256 _value
    ) public returns (bool) {
        return addDot(msg.sender, _session, _from, _to, _value);
    }

}