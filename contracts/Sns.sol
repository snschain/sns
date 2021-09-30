// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

contract Sns {
  address public owner;
  uint public totalCnt;
  uint public getOnceCnt;

  mapping (uint => Content) public _contents;
  struct Content {
    address writer;
    string text;
    uint timestamp;
  }

  constructor() {
    owner = msg.sender;
    totalCnt = 0;
    getOnceCnt = 10;
  }

  /// write a text
  /// @dev stored text data
  /// @return true
  function write(string memory text) public returns (bool) {
    Content memory content;
    content.writer = msg.sender;
    content.text = text;
    content.timestamp = block.timestamp;
    _contents[totalCnt] = content;

    totalCnt += 1;

    return true;
  }

  /// get a text
  /// @dev get a text data
  /// @param index the number of index
  /// @return a text data
  function getText(uint index) public view returns (Content memory) {
    return _contents[index];
  }

  function getTexts(uint page) public view returns (Content[] memory) {
    require(page > 0, 'Wrong page.');

    uint startTextIndex = (page - 1) * getOnceCnt;
    uint endTextIndex = page * getOnceCnt;
    uint onceCnt = getOnceCnt;

    require(startTextIndex < totalCnt, 'page is null.');

    if(endTextIndex > totalCnt) {
      endTextIndex = totalCnt;
      onceCnt = totalCnt;
    }

    Content[] memory content = new Content[](onceCnt);
    uint index = 0;

    for (uint i=startTextIndex; i<endTextIndex; i++) {
      content[index++] = _contents[i];
    }

    return content;
  }

  function getTotalCnt() public view returns (uint) {
    return totalCnt;
  }
}