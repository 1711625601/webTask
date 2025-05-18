// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract Hello3Dot0 {
    string hello = "hello 3.0!";
    struct Info {
        string phrase;
        uint256 id;
        address addr;
    }
    Info[] infos;
    mapping (uint256 id => Info info) idToInfo;

    function sayHellow(uint256 _id) public view returns (string memory) {
      //   for (uint256 i = 0; i < infos.length; i++) {
      //       if (infos[i].id == _id) {
      //           return addStr(infos[i].phrase);
      //       }
      //   }
      //   return addStr(hello);
      if(idToInfo[_id].addr == address(0x0)){
         return addStr("no one");
      }else {
         return addStr(idToInfo[_id].phrase);
      }
    }

    function setHellow(uint256 _id,string memory newStr ) public {
        Info memory info = Info(newStr, _id, msg.sender);
        idToInfo[_id] = info;
      //   infos.push(info);
    }

    function addStr(string memory str) internal pure returns (string memory) {
        return string.concat(str, "---- my fun");
    }
}
