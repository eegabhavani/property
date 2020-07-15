pragma solidity ^0.4.11;
contract PropertyTransfer{
    address raa;
    uint public totalNoOfProperty;
    
    function PropertyTransfer(){
        raa=msg.sender;
        
    }
    modifier onlyowner(){
        require(msg.sender==raa);
        _;
    }
    struct Property{
        string name;
        bool isSold;
    }
    mapping (address=>mapping(uint256=>Property)) public propertiesOwner;
    mapping (address=>uint256) individualCountOfPropertyPerOwner;
    
    event propertyAlloted(address indexed _verifiedOwner,uint256 indexed _totalNoOfPropertyCurrently,string _PropertyName,string msg);
    event PropertyTransfered(address indexed _from,address indexed _to,string _PropertyName,string _msg);
    
    function getPropertyCountOfAnyAddress(address _ownerAddress)constant returns(uint256){
        uint count=0;
         for(uint i=0;i<individualCountOfPropertyPerOwner[_ownerAddress];i++){
          if(propertiesOwner[_ownerAddress][i].isSold!=true){ 
              count++;
          }
        }
       return count;
    }
    function AllotProperty(address _verifiedOwner,string _PropertyName) onlyowner{
        propertiesOwner[_verifiedOwner][individualCountOfPropertyPerOwner[_verifiedOwner]++].name=_PropertyName;
        totalNoOfProperty++;
        propertyAlloted(_verifiedOwner,individualCountOfPropertyPerOwner[_verifiedOwner],_PropertyName,"property alloted successfully");
    }
  function isOwner(address _checkOwnerAddress,string _PropertyName)constant returns(uint){
        uint i;
        bool flag;
        for(i=0;i<individualCountOfPropertyPerOwner[_checkOwnerAddress];i++){
         if(flag==true){
             break;
           }
       }
    if(flag==true){
        return i;
    }
    else{
        return 99999;
    }
    
  }
function stringsEAqual(string s1,string s2)returns(bool){
    return sha3(s1)==sha3(s2)?true:false;
}
function transferProperty(address _to,string _PropertyName)returns(bool,uint){
    uint256 checkOwner =isOwner(msg.sender,_PropertyName);
    bool flag;
    if(checkOwner!=99999&&propertiesOwner[msg.sender][checkOwner].isSold==false){
        propertiesOwner[msg.sender][checkOwner].isSold=true;
        propertiesOwner[msg.sender][checkOwner].name="sold";
        propertiesOwner[_to][individualCountOfPropertyPerOwner[_to]++].name=_PropertyName;
        flag==true;
        PropertyTransfered(msg.sender,_to,_PropertyName,"owner has been changed");
    }
    else{
        flag=false;
        PropertyTransfered(msg.sender,_to,_PropertyName,"owner doesn't own the property");
    }
    return(flag,checkOwner);
        
    }
}
