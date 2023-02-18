// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract MultiSend {
    struct Employeeinfo {
        string name;
        address payable empaddress;
    }
    address  public CEO;
    mapping(address => Employeeinfo) employess;
    address payable []ad;

    constructor() {
        CEO = msg.sender;
    }
    receive() external  payable {
         require(msg.value==1 ether);
     }

    function registerEmployee(
        string memory name_,
        address payable payableemp_ad
    ) public {
        require(CEO == msg.sender);
        require(bytes(name_).length != 0, "Name cannot be empty");
        require(payableemp_ad != address(0), "Address cannot be empty");
        Employeeinfo memory st = Employeeinfo(name_, payableemp_ad);
        employess[payableemp_ad] = st;
        ad.push(payableemp_ad);
    }

    function getemployedata(address payable empaddress)
        public
        view
        returns (Employeeinfo memory)
    {
        require(CEO == msg.sender);
        require(empaddress != address(0), "Address cannot be empty");
        return employess[empaddress];
    }

    function sendsalary() public  returns (string memory) {
        require(CEO == msg.sender);
        for (uint256 i=0; i<ad.length; i++) 
        {
            address payable  ad1=ad[i];
            ad1.transfer(1 ether);
        }
                
        return "transfered";
    }
    function gettotalemploye() public view  returns (uint256) {
        return ad.length;
    }

}
