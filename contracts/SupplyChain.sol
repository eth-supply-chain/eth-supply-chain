pragma solidity ^0.5.0;


contract SupplyChain{
    
    struct Farmer {
        string name;
        string location;
        string password;
        string email;
    }
    
    struct Asset{
        string kind;
        uint price;
        uint quantity;
        string status;
        Farmer farmer;
    }
    
    //structure for warehouse
    struct Warehouse {
        string name;
        string location;
        string password;
        string email;
        Farmer farmer;
    }
    
    //structure for Shipping
    struct Shipping{
        string name;
        string password;
        string email;
        Warehouse warehouse;
    }

    
    uint assetCount = 1;
    uint farmCount = 1;
    uint wareCount = 1;
    uint shipCount = 1;
    
    mapping(uint => Farmer) farmers;
    mapping(uint => Asset) asset;
    mapping(uint => Warehouse) warehouse;
    mapping(uint => Shipping) shipping;
    
    
   /* function deafault_values() public {
        Farmer memory tempFarmer = Farmer("null", "null", "null", "null");
        farmers[0] = tempFarmer;
        
        Warehouse memory tempWarehouse = Warehouse("null", "null", "null", "null", farmers[0]);
        warehouse[0] = tempWarehouse;

        
        Shipping memory tempShipping = Shipping("null", "null", "null", warehouse[0]);
        shipping[0] = tempShipping;

    }*/
    
    
    
     function compareStrings (string memory a, string memory b) public pure returns (bool) {
        return (keccak256(abi.encodePacked((a))) == keccak256(abi.encodePacked((b))) );
   }
    
    
    function create_asset(string memory kind, uint price, uint quantity, uint farmAdd) public returns (string memory title ){
        Asset memory newAsset = Asset(kind, price, quantity, "Farmer", farmers[farmAdd]);
        asset[assetCount] = newAsset;
        return (asset[assetCount].farmer.name);
    }
    
    
    function create_farmer(string memory name, string memory location, string memory password, string memory email) public returns(uint index){
        Farmer memory newFarmer = Farmer(name, location, password, email);
        farmers[farmCount] = newFarmer;
        farmCount += 1;
        return (farmCount - 1);
    }
    
    
    //Function to cerate warehouses
    function create_warehouse(string memory name, string memory location, string memory password, string memory email, uint fid) public returns(uint index){
        Warehouse memory newWarehouse = Warehouse(name, location, password, email, farmers[fid]);
        warehouse[wareCount] = newWarehouse;
        wareCount += 1;
        return (wareCount - 1);
    }
    
    //Function for warehouse login_farmer
    function login_warehouse(string memory email, string memory password) public returns(uint index){
        for(uint i = 0; i<wareCount; i++){
            if(compareStrings(email, warehouse[i].email)){
                if(compareStrings(password, warehouse[i].password)){
                    return i;
                }
            }
        }
    }
    
    function login_farmer(string memory email, string memory password) public returns(uint index){
        for(uint i=0; i<farmCount; i++){
            if(compareStrings(email, farmers[i].email)){
                if(compareStrings(password, farmers[i].password)){
                    return i;
                }
            }
        }
    }
    
    //Function for create shipment
    function create_shipment(string memory name, string memory password, string memory email, uint wid) public returns(uint index){
        Shipping memory newShipping = Shipping(name, password, email, warehouse[wid]);
        shipping[shipCount] = newShipping;
        shipCount += 1;
        return (shipCount - 1);
    }
    
    //Function for shipment login
    function login_shipment(string memory email, string memory password) public returns(uint index){
        for(uint i = 0; i<shipCount; i++){
            if(compareStrings(email, shipping[i].email)){
                if(compareStrings(password, shipping[i].password)){
                    return i;
                }
            }
        }
    }

//Ethereum and Block chain    

    
} 
