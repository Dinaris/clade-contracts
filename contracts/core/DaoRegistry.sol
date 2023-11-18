// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/utils/Context.sol";
import "./Dao.sol";

contract DaoRegistry is Context {

    mapping(address => Dao) public registry;

    function registerDao(
        string memory _name,
        string memory _symbol,
        string memory _logo,
        string memory _description
    ) public returns (bool) {
        Dao dao = new Dao(_name, _symbol, _logo, _description);
        registry[address(dao)] = dao;
        return true;
    }

    function getDao(address _dao) public view returns (Dao) {
        return registry[_dao];
    }

}
