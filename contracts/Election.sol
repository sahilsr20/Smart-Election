//SPDX-License-Identifier: MIT
pragma solidity >=0.5.0 <0.9.0;

contract Election{
    address administrator;

    struct candidate{
        bool exists;
        uint votes;
    }

    mapping (address =>bool) voterVoted;
    mapping (address=>candidate) candidateMapping;
    mapping (address=>bool) candidateExists;
    

    function _addCandidate()private pure returns( candidate memory) {
        return  candidate(true,0);
    }
    function AddCandidate(address candidateAddr)public {
        require(!candidateExists[candidateAddr]);
         candidateMapping[candidateAddr]=_addCandidate();
         candidateExists[candidateAddr]=true;
    }
    function Vote(address from , address to) public{
        require(!voterVoted[from]);
        require(candidateExists[to]);
        voterVoted[from]=true;
        candidateMapping[to].votes++;
    }

}