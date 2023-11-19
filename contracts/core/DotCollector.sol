// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/utils/Context.sol";

contract DotCollector is Context {

    struct Dot {
        address from;
        address to;
        uint256 value;
    }

    //dao => session => dot
    mapping(address => mapping(uint256 => Dot[])) public dots;

    event DotAdded(address dao,
        uint256 session,
        address from,
        address to,
        uint256 value);

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

    function getDots(address _dao, uint256 _session) public view returns (Dot[] memory) {
        return dots[_dao][_session];
    }

    function getDot(address _dao, uint256 _session, uint256 _index) public view returns (Dot memory) {
        return dots[_dao][_session][_index];
    }

    function getDotsPaginated(address _dao, uint256 _session, uint256 _page, uint256 _perPage) public view returns (Dot[] memory) {
        Dot[] memory _dots = dots[_dao][_session];
        Dot[] memory _result = new Dot[](_perPage);
        uint256 _index = 0;
        for (uint256 i = _page * _perPage; i < (_page + 1) * _perPage; i++) {
            _result[_index] = _dots[i];
            _index++;
        }
        return _result;
    }

}