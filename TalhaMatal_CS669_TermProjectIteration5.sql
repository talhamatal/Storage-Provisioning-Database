--- DROP TABLE STATEMENTS

DROP TABLE Cost_Change;
DROP TABLE Invoice;
DROP TABLE Request;
DROP TABLE SAN_storage;
DROP TABLE NAS_storge;
DROP TABLE Type_of_storage;
DROP TABLE Replication_type;
DROP TABLE Person;
DROP TABLE Request_Type;
DROP TABLE App_Server_Association;
DROP TABLE Server;
DROP TABLE Location;
DROP TABLE State;
DROP TABLE City;
DROP TABLE Environment;
DROP TABLE Application;
DROP TABLE IT_owner;

--- DROP SEQUECE STATEMENTS

DROP SEQUENCE IT_owner_seq;
DROP SEQUENCE Application_seq;
DROP SEQUENCE Environment_seq;
DROP SEQUENCE State_seq;
DROP SEQUENCE City_seq;
DROP SEQUENCE Location_seq;
DROP SEQUENCE Server_seq;
DROP SEQUENCE App_Server_Association_seq;
DROP SEQUENCE Replication_type_seq;
DROP SEQUENCE Person_seq;
DROP SEQUENCE Request_type_seq;
DROP SEQUENCE Type_of_storage_seq;
DROP SEQUENCE Request_seq;
DROP SEQUENCE Invoice_seq;
DROP SEQUENCE Cost_Change_seq;

--TABLES
---This creates the IT_owner table with the appropriate columns
CREATE TABLE IT_owner (
owner_ID DECIMAL(12) NOT NULL PRIMARY KEY,
first_name VARCHAR(64) NOT NULL,
last_name VARCHAR(64) NOT NULL,
email VARCHAR(255)NOT NULL);

---This creates the Application table with the appropriate columns
CREATE TABLE Application(
app_ID DECIMAL(12) NOT NULL PRIMARY KEY,
owner_ID DECIMAL(12) NOT NULL,
app_name VARCHAR(255) NOT NULL,
FOREIGN KEY (owner_ID) REFERENCES IT_owner(owner_ID));

---This creates the Environment table with the appropriate columns
CREATE TABLE Environment(
environment_ID DECIMAL(12) NOT NULL PRIMARY KEY,
environment_type VARCHAR(16));

---This creates the State table with the appropriate columns
CREATE TABLE State(
state_ID DECIMAL(12) NOT NULL PRIMARY KEY,
State_name VARCHAR(16));

---This creates the City table with the appropriate columns
CREATE TABLE City(
city_ID DECIMAL(12) NOT NULL PRIMARY KEY,
City_name VARCHAR(64));


---This creates the Location table with the appropriate columns
CREATE TABLE Location(
location_ID DECIMAL(12) NOT NULL PRIMARY KEY,
location_name VARCHAR(64) NOT NULL,
Street VARCHAR(255) NOT NULL,
ZipCode DECIMAL(12) NOT NULL,
city_ID DECIMAL(12) NOT NULL,
state_ID DECIMAL(12) NOT NULL,
FOREIGN KEY (city_ID) REFERENCES City(city_ID),
FOREIGN KEY (state_ID) REFERENCES State(state_ID));

---This creates the Server table with the appropriate columns
CREATE TABLE Server(
server_ID DECIMAL(12) NOT NULL PRIMARY KEY,
server_name VARCHAR(64) NOT NULL,
server_IP VARCHAR(20) NOT NULL,
environment_ID DECIMAL(12) NOT NULL,
location_ID DECIMAL(12) NOT NULL,
FOREIGN KEY (environment_ID) REFERENCES Environment(environment_ID),
FOREIGN KEY (location_ID) REFERENCES Location(location_ID));

---This creates the Application server association table with the appropriate columns
CREATE TABLE App_Server_Association(
app_server_ID DECIMAL(12) NOT NULL PRIMARY KEY,
app_ID DECIMAL(12) NOT NULL,
server_ID DECIMAL(12) NOT NULL,
FOREIGN KEY (app_ID) REFERENCES Application(app_ID),
FOREIGN KEY (server_ID) REFERENCES Server(server_ID));

---This creates the replication type table with the appropriate columns
CREATE TABLE Replication_type(
replication_ID DECIMAL(12) NOT NULL PRIMARY KEY,
type VARCHAR(64) NOT NULL);

---This creates the Person table with the appropriate columns
CREATE TABLE Person(
person_ID DECIMAL(12) NOT NULL PRIMARY KEY,
first_name VARCHAR(64) NOT NULL,
last_name VARCHAR(64) NOT NULL);

---This creates the Request type table with the appropriate columns
CREATE TABLE Request_Type(
request_type_ID DECIMAL(12) NOT NULL PRIMARY KEY,
type VARCHAR(64) NOT NULL);

---This creates the Type of storage table with the appropriate columns
CREATE TABLE Type_of_storage(
storage_type_ID DECIMAL(12) NOT NULL PRIMARY KEY,
storage_type CHAR(1) NOT NULL);

---This creates the SAN_storage table with the appropriate columns
CREATE TABLE SAN_storage(
storage_type_ID DECIMAL(12) NOT NULL PRIMARY KEY,
Device_size DECIMAL(8) NOT NULL,
FOREIGN KEY (storage_type_ID) REFERENCES Type_of_storage(storage_type_ID));

---This creates the NAS_storage table with the appropriate columns
CREATE TABLE NAS_storage(
storage_type_ID DECIMAL(12) NOT NULL PRIMARY KEY,
share_type VARCHAR(5) NOT NULL,
FOREIGN KEY (storage_type_ID) REFERENCES Type_of_storage(storage_type_ID));

---This creates the Request table with the appropriate columns
CREATE TABLE Request (
Request_No DECIMAL(12) NOT NULL PRIMARY KEY,
Amount_of_storage DECIMAL(8,2) NOT NULL,
Request_date DATE NOT NULL,
storage_type_ID DECIMAL(12) NOT NULL,
replication_ID DECIMAL(12) NOT NULL,
app_ID DECIMAL(12) NOT NULL,
server_ID DECIMAL(12) NOT NULL,
request_type_ID DECIMAL(12) NOT NULL,
person_ID DECIMAL(12) NOT NULL,
FOREIGN KEY (storage_type_ID) REFERENCES Type_of_storage(storage_type_ID),
FOREIGN KEY (replication_ID) REFERENCES Replication_type(replication_ID),
FOREIGN KEY (app_ID) REFERENCES Application(app_ID),
FOREIGN KEY (server_ID) REFERENCES Server(server_ID),
FOREIGN KEY (request_type_ID) REFERENCES Request_type(request_type_ID),
FOREIGN KEY (person_ID) REFERENCES Person(person_ID)
);

---This creates the Invoice table with the appropriate columns
CREATE TABLE Invoice(
Invoice_ID DECIMAL(12) NOT NULL PRIMARY KEY,
Request_No DECIMAL(12) NOT NULL,
Cost DECIMAL(8,2) NOT NULL,
FOREIGN KEY (Request_No) REFERENCES Request(Request_No));


---This creates the Cost_Change table which is also the history table for Invoice
CREATE TABLE Cost_Change(
Cost_Change_ID DECIMAL(12) NOT NULL PRIMARY KEY,
Invoice_ID DECIMAL(12) NOT NULL,
Old_Cost DECIMAL(8,2) NOT NULL,
New_Cost DECIMAL(8,2) NOT NULL,
Change_date DATE NOT NULL,
FOREIGN KEY (Invoice_ID) REFERENCES Invoice(Invoice_ID));

--SEQUENCES
--Sequence for all the primary keys are being created as below
CREATE SEQUENCE IT_owner_seq START WITH 1;
CREATE SEQUENCE Application_seq START WITH 1;
CREATE SEQUENCE Environment_seq START WITH 1;
CREATE SEQUENCE State_seq START WITH 1;
CREATE SEQUENCE City_seq START WITH 1;
CREATE SEQUENCE Location_seq START WITH 1;
CREATE SEQUENCE Server_seq START WITH 1;
CREATE SEQUENCE App_Server_Association_seq START WITH 1;
CREATE SEQUENCE Replication_type_seq START WITH 1;
CREATE SEQUENCE Person_seq START WITH 1;
CREATE SEQUENCE Request_type_seq START WITH 1;
CREATE SEQUENCE Type_of_storage_seq START WITH 1;
CREATE SEQUENCE Request_seq START WITH 1;
CREATE SEQUENCE Invoice_seq START WITH 1;
CREATE SEQUENCE Cost_Change_seq START WITH 1;

--INDEXES
-- The indexes for all the foreign keys and any other query driven columns is created below
CREATE INDEX AppOwner_IDX
ON Application(owner_ID);

CREATE INDEX App_Server_serverID_IDX
ON App_Server_Association(server_ID);

CREATE INDEX App_Server_appID_IDX
ON App_Server_Association(app_ID);

CREATE INDEX Server_environmentID_IDX
ON Server(environment_ID);

CREATE INDEX Server_locationID_IDX
ON Server(location_ID);

CREATE INDEX Location_cityID_IDX
ON Location(city_ID);

CREATE INDEX Location_stateID_IDX
ON Location(state_ID);

CREATE INDEX Request_stortypeID_IDX
ON Request(storage_type_ID);

CREATE INDEX Request_repID_IDX
ON Request(replication_ID);

CREATE INDEX Request_appID_IDX
ON Request(app_ID);

CREATE INDEX Request_serverID_IDX
ON Request(server_ID);

CREATE INDEX Request_reqtypeID_IDX
ON Request(request_type_ID);

CREATE INDEX Request_personID_IDX
ON Request(person_ID);

CREATE UNIQUE INDEX Invoice_requestnum_IDX
ON Invoice(Request_No);

CREATE INDEX Cost_Change_InvoiceID_IDX
ON Cost_Change(Invoice_ID);

CREATE INDEX Request_amountofstorage_IDX
ON Request(Amount_of_Storage);

CREATE INDEX Request_requestdate_IDX
ON Request(Request_date);

CREATE INDEX Invoice_cost_IDX
ON Invoice(Cost);

--HISTORY TRIGGER
-- The below is the trigger that will insert the data into the history table
CREATE OR REPLACE TRIGGER cost_change_trigger
BEFORE UPDATE OF Cost ON Invoice
FOR EACH ROW 
BEGIN
    IF :NEW.Cost = :OLD.Cost THEN
    RAISE_APPLICATION_ERROR(-200001,'The new cost value needs to be different');
    END IF;
    
    INSERT INTO Cost_Change(Cost_Change_ID,Invoice_ID,
                            Old_Cost,New_Cost,Change_Date)
    VALUES (Cost_Change_seq.nextval,
            :NEW.Invoice_ID,
            :OLD.Cost,
            :NEW.Cost,
            SYSDATE);
END;    


--- INSERT STATEMENT TO ADD DATA TO THE ENVIRONMENT TABLE
INSERT INTO Environment (environment_ID,environment_type)
VALUES (Environment_seq.nextval,'PROD');
INSERT INTO Environment (environment_ID,environment_type)
VALUES (Environment_seq.nextval,'UAT');
INSERT INTO Environment (environment_ID,environment_type)
VALUES(Environment_seq.nextval,'DEV');
 
--- INSERT STATEMENT TO ADD DATA TO THE STATE TABLE       
INSERT INTO State (state_ID,State_name)
VALUES (State_seq.nextval,'California');
INSERT INTO State (state_ID,State_name)
VALUES (State_seq.nextval,'Texas');
INSERT INTO State (state_ID,State_name)
VALUES (State_seq.nextval,'Florida');
INSERT INTO State (state_ID,State_name)
VALUES (State_seq.nextval,'NewYork');
INSERT INTO State (state_ID,State_name)       
VALUES (State_seq.nextval,'Pennsylvania');
INSERT INTO State (state_ID,State_name)
VALUES (State_seq.nextval,'Illinois');
INSERT INTO State (state_ID,State_name)       
VALUES (State_seq.nextval,'Ohio');
INSERT INTO State (state_ID,State_name)
VALUES (State_seq.nextval,'Georgia');
INSERT INTO State (state_ID,State_name)
VALUES (State_seq.nextval,'North Carolina');
INSERT INTO State (state_ID,State_name)
VALUES (State_seq.nextval,'Michigan');
INSERT INTO State (state_ID,State_name)
VALUES (State_seq.nextval,'New Jersey');
INSERT INTO State (state_ID,State_name)
VALUES (State_seq.nextval,'Virgina');
INSERT INTO State (state_ID,State_name)
VALUES (State_seq.nextval,'Washington');
INSERT INTO State (state_ID,State_name)
VALUES (State_seq.nextval,'Arizona');
INSERT INTO State (state_ID,State_name)       
VALUES (State_seq.nextval,'Tennessee');
INSERT INTO State (state_ID,State_name)
VALUES (State_seq.nextval,'Massachusetts');
INSERT INTO State (state_ID,State_name)
VALUES (State_seq.nextval,'Indiana');       
INSERT INTO State (state_ID,State_name)       
VALUES (State_seq.nextval,'Missouri');
INSERT INTO State (state_ID,State_name)       
VALUES (State_seq.nextval,'Maryland');
INSERT INTO State (state_ID,State_name)           
VALUES (State_seq.nextval,'Wisconsin');
INSERT INTO State (state_ID,State_name) 
VALUES (State_seq.nextval,'Colorado');
INSERT INTO State (state_ID,State_name) 
VALUES (State_seq.nextval,'Minnesota');
INSERT INTO State (state_ID,State_name) 
VALUES (State_seq.nextval,'South Carolina');
INSERT INTO State (state_ID,State_name) 
VALUES (State_seq.nextval,'Alabama');
INSERT INTO State (state_ID,State_name)        
VALUES (State_seq.nextval,'Louisiana');
INSERT INTO State (state_ID,State_name) 
VALUES (State_seq.nextval,'Kentucky');
INSERT INTO State (state_ID,State_name) 
VALUES (State_seq.nextval,'Oregon');
INSERT INTO State (state_ID,State_name) 
VALUES (State_seq.nextval,'Oklahoma');
INSERT INTO State (state_ID,State_name) 
VALUES (State_seq.nextval,'Connecticut');
INSERT INTO State (state_ID,State_name) 
VALUES (State_seq.nextval,'Utah');
INSERT INTO State (state_ID,State_name) 
VALUES (State_seq.nextval,'Iowa');
INSERT INTO State (state_ID,State_name) 
VALUES (State_seq.nextval,'Nevada');
INSERT INTO State (state_ID,State_name) 
VALUES (State_seq.nextval,'Arkansas');
INSERT INTO State (state_ID,State_name) 
VALUES (State_seq.nextval,'Mississipi');
INSERT INTO State (state_ID,State_name) 
VALUES (State_seq.nextval,'Kansas');
INSERT INTO State (state_ID,State_name) 
VALUES (State_seq.nextval,'New Mexico');
INSERT INTO State (state_ID,State_name) 
VALUES (State_seq.nextval,'Nebraska');
INSERT INTO State (state_ID,State_name) 
VALUES (State_seq.nextval,'Idaho');
INSERT INTO State (state_ID,State_name) 
VALUES (State_seq.nextval,'West Virgina');
INSERT INTO State (state_ID,State_name) 
VALUES (State_seq.nextval,'Hawaii');
INSERT INTO State (state_ID,State_name) 
VALUES (State_seq.nextval,'New Hampshire');
INSERT INTO State (state_ID,State_name) 
VALUES (State_seq.nextval,'Maine');
INSERT INTO State (state_ID,State_name) 
VALUES (State_seq.nextval,'Montana');
INSERT INTO State (state_ID,State_name) 
VALUES (State_seq.nextval,'Rhode Island');
INSERT INTO State (state_ID,State_name) 
VALUES (State_seq.nextval,'Delware');
INSERT INTO State (state_ID,State_name) 
VALUES (State_seq.nextval,'South Dakota');
INSERT INTO State (state_ID,State_name) 
VALUES (State_seq.nextval,'North Dakota');
INSERT INTO State (state_ID,State_name) 
VALUES (State_seq.nextval,'Alaska');
INSERT INTO State (state_ID,State_name) 
VALUES (State_seq.nextval,'Vermont');
INSERT INTO State (state_ID,State_name) 
VALUES (State_seq.nextval,'Wyoming');

--- INSERT STATEMENT TO ADD DATA TO THE CITY TABLE   
INSERT INTO City (city_ID,City_name)
VALUES (City_seq.nextval,'Los Angeles');
INSERT INTO City (city_ID,City_name)
VALUES (City_seq.nextval,'Houston');
INSERT INTO City (city_ID,City_name)
VALUES (City_seq.nextval,'Jacksonville');
INSERT INTO City (city_ID,City_name)
VALUES (City_seq.nextval,'NewYork City');
INSERT INTO City (city_ID,City_name)       
VALUES (City_seq.nextval,'Philadelphia');
INSERT INTO City (city_ID,City_name) 
VALUES (City_seq.nextval,'Chicago');
INSERT INTO City (city_ID,City_name)
VALUES (City_seq.nextval,'Columbus');
INSERT INTO City (city_ID,City_name) 
VALUES (City_seq.nextval,'Atlanta');
INSERT INTO City (city_ID,City_name)
VALUES (City_seq.nextval,'Charlotte');
INSERT INTO City (city_ID,City_name)
VALUES (City_seq.nextval,'Detroit');
INSERT INTO City (city_ID,City_name)
VALUES (City_seq.nextval,'Newark');
INSERT INTO City (city_ID,City_name)
VALUES (City_seq.nextval,'Virginia Beach');
INSERT INTO City (city_ID,City_name)
VALUES (City_seq.nextval,'Seattle');
INSERT INTO City (city_ID,City_name)
VALUES (City_seq.nextval,'Phoenix');
INSERT INTO City (city_ID,City_name)
VALUES (City_seq.nextval,'Nashville');
INSERT INTO City (city_ID,City_name)
VALUES (City_seq.nextval,'Boston');
INSERT INTO City (city_ID,City_name)
VALUES (City_seq.nextval,'Indianapolis');
INSERT INTO City (city_ID,City_name)
VALUES (City_seq.nextval,'Kansas City');
INSERT INTO City (city_ID,City_name)
VALUES (City_seq.nextval,'Baltimore');
INSERT INTO City (city_ID,City_name)
VALUES (City_seq.nextval,'Milwaukee');
INSERT INTO City (city_ID,City_name)
VALUES (City_seq.nextval,'Denver');
INSERT INTO City (city_ID,City_name)
VALUES (City_seq.nextval,'Minneapolis');
INSERT INTO City (city_ID,City_name)
VALUES (City_seq.nextval,'Charleston');
INSERT INTO City (city_ID,City_name)
VALUES (City_seq.nextval,'Birmingham');
INSERT INTO City (city_ID,City_name)
VALUES (City_seq.nextval,'New Orleans');
INSERT INTO City (city_ID,City_name)
VALUES (City_seq.nextval,'Louiseville');
INSERT INTO City (city_ID,City_name)
VALUES (City_seq.nextval,'Portland');
INSERT INTO City (city_ID,City_name)
VALUES (City_seq.nextval,'Oklahoma City');
INSERT INTO City (city_ID,City_name)
VALUES (City_seq.nextval,'Bridgeport');
INSERT INTO City (city_ID,City_name)
VALUES (City_seq.nextval,'Salt Lake City');
INSERT INTO City (city_ID,City_name)
VALUES (City_seq.nextval,'Des Moines');
INSERT INTO City (city_ID,City_name)
VALUES (City_seq.nextval,'Las Vegas');
INSERT INTO City (city_ID,City_name)
VALUES (City_seq.nextval,'Little Rock');
INSERT INTO City (city_ID,City_name)
VALUES (City_seq.nextval,'Jackson');
INSERT INTO City (city_ID,City_name)
VALUES (City_seq.nextval,'Wichita');
INSERT INTO City (city_ID,City_name)
VALUES (City_seq.nextval,'Albuquerque');
INSERT INTO City (city_ID,City_name)
VALUES (City_seq.nextval,'Omaha');
INSERT INTO City (city_ID,City_name)
VALUES (City_seq.nextval,'Boise');
INSERT INTO City (city_ID,City_name)
VALUES (City_seq.nextval,'Hungtington');
INSERT INTO City (city_ID,City_name)
VALUES (City_seq.nextval,'Honolulu');
INSERT INTO City (city_ID,City_name)
VALUES (City_seq.nextval,'Manchester');
INSERT INTO City (city_ID,City_name)
VALUES (City_seq.nextval,'Lewiston');
INSERT INTO City (city_ID,City_name)
VALUES (City_seq.nextval,'Billings');
INSERT INTO City (city_ID,City_name)
VALUES (City_seq.nextval,'Providence');
INSERT INTO City (city_ID,City_name)
VALUES (City_seq.nextval,'Wilmington');
INSERT INTO City (city_ID,City_name)
VALUES (City_seq.nextval,'Sioux Falls');
INSERT INTO City (city_ID,City_name)
VALUES (City_seq.nextval,'Fargo');
INSERT INTO City (city_ID,City_name)
VALUES (City_seq.nextval,'Anchorage');
INSERT INTO City (city_ID,City_name)
VALUES (City_seq.nextval,'Burlington');
INSERT INTO City (city_ID,City_name)
VALUES (City_seq.nextval,'Cheyenne');

--- INSERT STATEMENT TO ADD DATA TO THE LOCATION TABLE          
INSERT INTO Location (location_ID,location_name,Street,ZipCode,city_ID,state_ID)
VALUES (Location_seq.nextval,'Site A', '450 Dark Hollow Dr', 77001, 
        (SELECT city_ID FROM City WHERE City_name = 'Houston'),
        (SELECT state_ID FROM State WHERE State_name = 'Texas'));
INSERT INTO Location (location_ID,location_name,Street,ZipCode,city_ID,state_ID)        
VALUES (Location_seq.nextval,'Site B', '19 Hackett Creek Dr', 32034, 
        (SELECT city_ID FROM City WHERE City_name = 'Jacksonville'),
        (SELECT state_ID FROM State WHERE State_name = 'Florida'));
INSERT INTO Location (location_ID,location_name,Street,ZipCode,city_ID,state_ID)        
VALUES (Location_seq.nextval,'Site C', '1801 Golden Horseshoe Circle', 98101, 
        (SELECT city_ID FROM City WHERE City_name = 'Seattle'),
        (SELECT state_ID FROM State WHERE State_name = 'Washington'));
INSERT INTO Location (location_ID,location_name,Street,ZipCode,city_ID,state_ID)       
VALUES (Location_seq.nextval,'Site D', '1400 Stonebrook Drive', 19019, 
        (SELECT city_ID FROM City WHERE City_name = 'Philadelphia'),
        (SELECT state_ID FROM State WHERE State_name = 'Pennsylvania'));
INSERT INTO Location (location_ID,location_name,Street,ZipCode,city_ID,state_ID)
VALUES (Location_seq.nextval,'Site E', '7424 Vermillion Dr', 90001, 
        (SELECT city_ID FROM City WHERE City_name = 'Los Angeles'),
        (SELECT state_ID FROM State WHERE State_name = 'California'));
INSERT INTO Location (location_ID,location_name,Street,ZipCode,city_ID,state_ID)
VALUES (Location_seq.nextval,'Site F', '9712 Boulder Creek Dr', 28105, 
        (SELECT city_ID FROM City WHERE City_name = 'Charlotte'),
        (SELECT state_ID FROM State WHERE State_name = 'North Carolina'));

--- INSERT STATEMENT TO ADD DATA TO THE SERVER TABLE   
INSERT INTO Server (server_ID,environment_ID,location_ID,server_name,server_IP)
VALUES(Server_seq.nextval,
        (SELECT environment_ID FROM Environment WHERE environment_type = 'PROD'),
        (SELECT location_ID FROM Location WHERE location_name = 'Site A'),
        'aml20056789','192.168.1.1');
INSERT INTO Server (server_ID,environment_ID,location_ID,server_name,server_IP)
VALUES (Server_seq.nextval,
        (SELECT environment_ID FROM Environment WHERE environment_type = 'PROD'),
        (SELECT location_ID FROM Location WHERE location_name = 'Site A'),
        'aml20056790','192.168.1.2');
INSERT INTO Server (server_ID,environment_ID,location_ID,server_name,server_IP)
VALUES (Server_seq.nextval,
        (SELECT environment_ID FROM Environment WHERE environment_type = 'UAT'),
        (SELECT location_ID FROM Location WHERE location_name = 'Site A'),
        'aml20056791','192.168.1.3');
INSERT INTO Server (server_ID,environment_ID,location_ID,server_name,server_IP)
VALUES (Server_seq.nextval,
        (SELECT environment_ID FROM Environment WHERE environment_type = 'UAT'),
        (SELECT location_ID FROM Location WHERE location_name = 'Site A'),
        'aml20056792','192.168.1.4');
INSERT INTO Server (server_ID,environment_ID,location_ID,server_name,server_IP)      
VALUES (Server_seq.nextval,
        (SELECT environment_ID FROM Environment WHERE environment_type = 'DEV'),
        (SELECT location_ID FROM Location WHERE location_name = 'Site A'),
        'aml20056793','192.168.1.5');
INSERT INTO Server (server_ID,environment_ID,location_ID,server_name,server_IP)
VALUES (Server_seq.nextval,
        (SELECT environment_ID FROM Environment WHERE environment_type = 'DEV'),
        (SELECT location_ID FROM Location WHERE location_name = 'Site A'),
        'aml20056794','192.168.1.6');
INSERT INTO Server (server_ID,environment_ID,location_ID,server_name,server_IP)        
VALUES (Server_seq.nextval,
        (SELECT environment_ID FROM Environment WHERE environment_type = 'PROD'),
        (SELECT location_ID FROM Location WHERE location_name = 'Site B'),
        'amw20056789','192.168.2.1');
INSERT INTO Server (server_ID,environment_ID,location_ID,server_name,server_IP)
VALUES (Server_seq.nextval,
        (SELECT environment_ID FROM Environment WHERE environment_type = 'PROD'),
        (SELECT location_ID FROM Location WHERE location_name = 'Site B'),
        'amw20056790','192.168.2.2');
INSERT INTO Server (server_ID,environment_ID,location_ID,server_name,server_IP)        
VALUES (Server_seq.nextval,
        (SELECT environment_ID FROM Environment WHERE environment_type = 'UAT'),
        (SELECT location_ID FROM Location WHERE location_name = 'Site B'),
        'amw20056791','192.168.2.3');
INSERT INTO Server (server_ID,environment_ID,location_ID,server_name,server_IP)
VALUES (Server_seq.nextval,
        (SELECT environment_ID FROM Environment WHERE environment_type = 'UAT'),
        (SELECT location_ID FROM Location WHERE location_name = 'Site B'),
        'amw20056792','192.168.2.4');
INSERT INTO Server (server_ID,environment_ID,location_ID,server_name,server_IP)        
VALUES (Server_seq.nextval,
        (SELECT environment_ID FROM Environment WHERE environment_type = 'DEV'),
        (SELECT location_ID FROM Location WHERE location_name = 'Site B'),
        'amw20056793','192.168.2.5');
INSERT INTO Server (server_ID,environment_ID,location_ID,server_name,server_IP)        
VALUES(Server_seq.nextval,
        (SELECT environment_ID FROM Environment WHERE environment_type = 'DEV'),
        (SELECT location_ID FROM Location WHERE location_name = 'Site B'),
        'amw20056794','192.168.2.6');
INSERT INTO Server (server_ID,environment_ID,location_ID,server_name,server_IP)        
VALUES (Server_seq.nextval,
        (SELECT environment_ID FROM Environment WHERE environment_type = 'PROD'),
        (SELECT location_ID FROM Location WHERE location_name = 'Site C'),
        'aml20045678','192.168.3.1');        
INSERT INTO Server (server_ID,environment_ID,location_ID,server_name,server_IP)
VALUES (Server_seq.nextval,
        (SELECT environment_ID FROM Environment WHERE environment_type = 'PROD'),
        (SELECT location_ID FROM Location WHERE location_name = 'Site C'),
        'aml20045679','192.168.3.2');
INSERT INTO Server (server_ID,environment_ID,location_ID,server_name,server_IP)
VALUES (Server_seq.nextval,
        (SELECT environment_ID FROM Environment WHERE environment_type = 'UAT'),
        (SELECT location_ID FROM Location WHERE location_name = 'Site C'),
        'aml20045680','192.168.3.3');        
INSERT INTO Server (server_ID,environment_ID,location_ID,server_name,server_IP)
VALUES (Server_seq.nextval,
        (SELECT environment_ID FROM Environment WHERE environment_type = 'UAT'),
        (SELECT location_ID FROM Location WHERE location_name = 'Site C'),
        'aml20045681','192.168.3.4');
INSERT INTO Server (server_ID,environment_ID,location_ID,server_name,server_IP)
VALUES (Server_seq.nextval,
        (SELECT environment_ID FROM Environment WHERE environment_type = 'DEV'),
        (SELECT location_ID FROM Location WHERE location_name = 'Site C'),
        'aml20045682','192.168.3.5');
INSERT INTO Server (server_ID,environment_ID,location_ID,server_name,server_IP)
VALUES (Server_seq.nextval,
        (SELECT environment_ID FROM Environment WHERE environment_type = 'DEV'),
        (SELECT location_ID FROM Location WHERE location_name = 'Site C'),
        'aml20045683','192.168.3.6');
INSERT INTO Server (server_ID,environment_ID,location_ID,server_name,server_IP)
VALUES (Server_seq.nextval,
        (SELECT environment_ID FROM Environment WHERE environment_type = 'PROD'),
        (SELECT location_ID FROM Location WHERE location_name = 'Site D'),
        'amw20045678','192.168.4.1');
INSERT INTO Server (server_ID,environment_ID,location_ID,server_name,server_IP)
VALUES (Server_seq.nextval,
        (SELECT environment_ID FROM Environment WHERE environment_type = 'PROD'),
        (SELECT location_ID FROM Location WHERE location_name = 'Site D'),
        'amw20045679','192.168.4.2');
INSERT INTO Server (server_ID,environment_ID,location_ID,server_name,server_IP)
VALUES (Server_seq.nextval,
        (SELECT environment_ID FROM Environment WHERE environment_type = 'UAT'),
        (SELECT location_ID FROM Location WHERE location_name = 'Site D'),
        'amw20045680','192.168.4.3');
INSERT INTO Server (server_ID,environment_ID,location_ID,server_name,server_IP)        
VALUES (Server_seq.nextval,
        (SELECT environment_ID FROM Environment WHERE environment_type = 'UAT'),
        (SELECT location_ID FROM Location WHERE location_name = 'Site D'),
        'amw20045681','192.168.4.4');
INSERT INTO Server (server_ID,environment_ID,location_ID,server_name,server_IP)
VALUES (Server_seq.nextval,
        (SELECT environment_ID FROM Environment WHERE environment_type = 'DEV'),
        (SELECT location_ID FROM Location WHERE location_name = 'Site D'),
        'amw20045682','192.168.4.5');
INSERT INTO Server (server_ID,environment_ID,location_ID,server_name,server_IP)        
VALUES (Server_seq.nextval,
        (SELECT environment_ID FROM Environment WHERE environment_type = 'DEV'),
        (SELECT location_ID FROM Location WHERE location_name = 'Site D'),
        'amw20045683','192.168.4.6');
INSERT INTO Server (server_ID,environment_ID,location_ID,server_name,server_IP)
VALUES (Server_seq.nextval,
        (SELECT environment_ID FROM Environment WHERE environment_type = 'PROD'),
        (SELECT location_ID FROM Location WHERE location_name = 'Site E'),
        'aml20034567','192.168.5.1');
INSERT INTO Server (server_ID,environment_ID,location_ID,server_name,server_IP)        
VALUES (Server_seq.nextval,
        (SELECT environment_ID FROM Environment WHERE environment_type = 'PROD'),
        (SELECT location_ID FROM Location WHERE location_name = 'Site E'),
        'aml20034568','192.168.5.2');
INSERT INTO Server (server_ID,environment_ID,location_ID,server_name,server_IP)
VALUES (Server_seq.nextval,
        (SELECT environment_ID FROM Environment WHERE environment_type = 'UAT'),
        (SELECT location_ID FROM Location WHERE location_name = 'Site E'),
        'aml20034569','192.168.5.3');
INSERT INTO Server (server_ID,environment_ID,location_ID,server_name,server_IP)
VALUES (Server_seq.nextval,
        (SELECT environment_ID FROM Environment WHERE environment_type = 'UAT'),
        (SELECT location_ID FROM Location WHERE location_name = 'Site E'),
        'aml20034570','192.168.5.4');
INSERT INTO Server (server_ID,environment_ID,location_ID,server_name,server_IP)        
VALUES (Server_seq.nextval,
        (SELECT environment_ID FROM Environment WHERE environment_type = 'DEV'),
        (SELECT location_ID FROM Location WHERE location_name = 'Site E'),
        'aml20034571','192.168.5.5');
INSERT INTO Server (server_ID,environment_ID,location_ID,server_name,server_IP)
VALUES (Server_seq.nextval,
        (SELECT environment_ID FROM Environment WHERE environment_type = 'DEV'),
        (SELECT location_ID FROM Location WHERE location_name = 'Site E'),
        'aml20034572','192.168.5.6');
INSERT INTO Server (server_ID,environment_ID,location_ID,server_name,server_IP)
VALUES (Server_seq.nextval,
        (SELECT environment_ID FROM Environment WHERE environment_type = 'PROD'),
        (SELECT location_ID FROM Location WHERE location_name = 'Site F'),
        'amw20034567','192.168.6.1');
INSERT INTO Server (server_ID,environment_ID,location_ID,server_name,server_IP)
VALUES (Server_seq.nextval,
        (SELECT environment_ID FROM Environment WHERE environment_type = 'PROD'),
        (SELECT location_ID FROM Location WHERE location_name = 'Site F'),
        'amw20034568','192.168.6.2');
INSERT INTO Server (server_ID,environment_ID,location_ID,server_name,server_IP)
VALUES (Server_seq.nextval,
        (SELECT environment_ID FROM Environment WHERE environment_type = 'UAT'),
        (SELECT location_ID FROM Location WHERE location_name = 'Site F'),
        'amw20034569','192.168.6.3');
INSERT INTO Server (server_ID,environment_ID,location_ID,server_name,server_IP)
VALUES (Server_seq.nextval,
        (SELECT environment_ID FROM Environment WHERE environment_type = 'UAT'),
        (SELECT location_ID FROM Location WHERE location_name = 'Site F'),
        'amw20034570','192.168.6.4');
INSERT INTO Server (server_ID,environment_ID,location_ID,server_name,server_IP)
VALUES (Server_seq.nextval,
        (SELECT environment_ID FROM Environment WHERE environment_type = 'DEV'),
        (SELECT location_ID FROM Location WHERE location_name = 'Site F'),
        'amw20034571','192.168.6.5');        
INSERT INTO Server (server_ID,environment_ID,location_ID,server_name,server_IP)
VALUES (Server_seq.nextval,
        (SELECT environment_ID FROM Environment WHERE environment_type = 'DEV'),
        (SELECT location_ID FROM Location WHERE location_name = 'Site F'),
        'amw20034572','192.168.6.6');

--- INSERT STATEMENT TO ADD DATA TO THE REPLICATION_TYPE TABLE           
INSERT INTO Replication_Type (replication_ID,type)
VALUES (Replication_type_seq.nextval,'Synchronous');
INSERT INTO Replication_Type (replication_ID,type)
VALUES (Replication_type_seq.nextval,'Asynchronous');


--- INSERT STATEMENT TO ADD DATA TO THE REQUEST_TYPE TABLE   
INSERT INTO Request_Type (request_type_ID,type)
VALUES (Request_type_seq.nextval,'Addition');
INSERT INTO Request_Type (request_type_ID,type)
VALUES (Request_type_seq.nextval,'Removal');


--- INSERT STATEMENT TO ADD DATA TO THE STORAGE_TYPE/ SAN_storage and NAS storage TABLE   
INSERT INTO Type_of_storage (storage_type_ID, storage_type)
VALUES (Type_of_storage_seq.nextval, 'A');
INSERT INTO NAS_Storage(storage_type_ID,share_type)
VALUES(Type_of_storage_seq.currval,'NFS');
INSERT INTO Type_of_storage (storage_type_ID, storage_type)
VALUES (Type_of_storage_seq.nextval, 'B');
INSERT INTO NAS_Storage(storage_type_ID,share_type)
VALUES(Type_of_storage_seq.currval,'SMB');
INSERT INTO Type_of_storage (storage_type_ID, storage_type)
VALUES (Type_of_storage_seq.nextval, 'C');
INSERT INTO NAS_Storage(storage_type_ID,share_type)
VALUES(Type_of_storage_seq.currval,'HTTP');
INSERT INTO Type_of_storage (storage_type_ID, storage_type)
VALUES (Type_of_storage_seq.nextval, 'D');
INSERT INTO NAS_Storage(storage_type_ID,share_type)
VALUES(Type_of_storage_seq.currval,'FTP');
INSERT INTO Type_of_storage (storage_type_ID, storage_type)
VALUES (Type_of_storage_seq.nextval, 'E');
INSERT INTO NAS_Storage(storage_type_ID,share_type)
VALUES(Type_of_storage_seq.currval,'SFTP');

INSERT INTO Type_of_storage (storage_type_ID, storage_type)
VALUES (Type_of_storage_seq.nextval, 'F');
INSERT INTO SAN_Storage(storage_type_ID,Device_size)
VALUES(Type_of_storage_seq.currval,64);
INSERT INTO Type_of_storage (storage_type_ID, storage_type)
VALUES (Type_of_storage_seq.nextval, 'G');
INSERT INTO SAN_Storage(storage_type_ID,Device_size)
VALUES(Type_of_storage_seq.currval,128);
INSERT INTO Type_of_storage (storage_type_ID, storage_type)
VALUES (Type_of_storage_seq.nextval, 'H');
INSERT INTO SAN_Storage(storage_type_ID,Device_size)
VALUES(Type_of_storage_seq.currval,256);
INSERT INTO Type_of_storage (storage_type_ID, storage_type)
VALUES (Type_of_storage_seq.nextval, 'I');
INSERT INTO SAN_Storage(storage_type_ID,Device_size)
VALUES(Type_of_storage_seq.currval,512);
INSERT INTO Type_of_storage (storage_type_ID, storage_type)
VALUES (Type_of_storage_seq.nextval, 'J');
INSERT INTO SAN_Storage(storage_type_ID,Device_size)
VALUES(Type_of_storage_seq.currval,1024);
INSERT INTO Type_of_storage (storage_type_ID, storage_type)
VALUES (Type_of_storage_seq.nextval, 'K');
INSERT INTO SAN_Storage(storage_type_ID,Device_size)
VALUES(Type_of_storage_seq.currval,2048);
INSERT INTO Type_of_storage (storage_type_ID, storage_type)
VALUES (Type_of_storage_seq.nextval, 'L');
INSERT INTO SAN_Storage(storage_type_ID,Device_size)
VALUES(Type_of_storage_seq.currval,4096);

SELECT * FROM State;
SELECT * FROM City;
SELECT * FROM Location;
SELECT * FROM Server;
SELECT * FROM Replication_Type;
SELECT * FROM Request_Type;
SELECT * FROM Type_of_storage;
SELECT * FROM NAS_Storage;
SELECT * FROM SAN_Storage;


-- This is my first stored procedure that adds server to the server table
CREATE OR REPLACE PROCEDURE AddServer (
    servername IN VARCHAR,
    serverIP IN VARCHAR,
    environment IN VARCHAR,
    loc IN VARCHAR)
IS
    environment_ID_var DECIMAL(12);
    location_ID_var DECIMAL(12);
    num DECIMAL (12);
BEGIN
    SELECT environment_ID INTO environment_ID_var 
    FROM Environment WHERE environment_type = environment;

    SELECT location_ID INTO location_ID_var 
    FROM Location WHERE location_name = loc;
    
    SELECT COUNT(1)
    INTO num
    FROM Server 
    WHERE server_name = servername;
       
    IF num = 0 THEN   
        INSERT INTO Server (server_ID,environment_ID,location_ID,
                            server_name,server_IP)
        VALUES (Server_seq.nextval,environment_ID_var,location_ID_var,
                servername,serverIP);
    ELSE 
    RAISE_APPLICATION_ERROR(-20001,'Server name already exists');
  
    
    END IF;

END;    

-- This is my second stored procedure that adds application to the application table and owner to the IT owner table
CREATE OR REPLACE PROCEDURE add_application (
    appname IN VARCHAR, owner_first_name IN VARCHAR, owner_last_name IN VARCHAR, 
    owner_email in VARCHAR, servername IN VARCHAR,serverIP IN VARCHAR, 
    environment IN VARCHAR, loc IN VARCHAR)
IS
    owner_ID_var DECIMAL(12); ownernum DECIMAL(12); appnum DECIMAL(12);
    server_ID_var DECIMAL(12); servernum DECIMAL(12);
BEGIN   
    SELECT COUNT(1) INTO ownernum FROM IT_owner 
    WHERE first_name = owner_first_name AND last_name = owner_last_name
            AND email = owner_email;
    IF ownernum = 0 THEN
        INSERT INTO IT_owner (owner_ID,first_name,last_name,email)
        VALUES (IT_owner_seq.nextval,owner_first_name,owner_last_name,
                owner_email);           
    END IF;
    SELECT owner_ID INTO owner_ID_var FROM IT_owner 
    WHERE first_name = owner_first_name AND last_name = owner_last_name AND 
                        email = owner_email;
    SELECT COUNT(1) INTO appnum FROM  Application WHERE app_name = appname ;
    IF appnum = 0 THEN
        INSERT INTO Application (app_ID,owner_ID,app_name)
        VALUES (Application_seq.nextval,owner_ID_var,appname);
        SELECT COUNT (1)INTO servernum FROM Server WHERE server_name = servername;
        IF servernum = 0 THEN
            BEGIN 
                AddServer(servername,serverIP,environment,loc);
            END;
            SELECT server_ID INTO server_ID_var FROM Server 
            WHERE server_name = servername;
        ELSE        
            SELECT server_ID INTO server_ID_var FROM Server 
            WHERE server_name = servername;
        END IF;    
        INSERT INTO App_Server_Association(app_server_ID,server_ID,app_ID)
        VALUES (App_Server_Association_seq.nextval,server_ID_var,
                Application_seq.currval);
    ELSE 
        RAISE_APPLICATION_ERROR(-20003,'Application name already exists');
    END IF;               
END;


-- This is my third stored procedure that adds request to the request table and updats the Invoice table

CREATE OR REPLACE PROCEDURE add_request (
    storagetype IN VARCHAR,replicationtype IN VARCHAR,appname IN VARCHAR,
    servername in VARCHAR,requesttype IN VARCHAR,requestor_first_name IN VARCHAR,
    requestor_last_name IN VARCHAR,amountofstorage IN DECIMAL)
IS
    storage_type_ID_var DECIMAL(12); replication_ID_var DECIMAL(12);
    app_ID_var DECIMAL(12); server_ID_var DECIMAL(12);
    request_type_ID_var DECIMAL(12); person_ID_var DECIMAL(12);
    personnum DECIMAL(12); costperGB DECIMAL(8,2);
    
BEGIN
       
    SELECT storage_type_ID INTO storage_type_ID_var 
    FROM Type_of_storage WHERE storage_type = storagetype;
    
    SELECT replication_ID INTO replication_ID_var
    FROM Replication_Type WHERE type = replicationtype;
    
    SELECT app_ID INTO app_ID_var FROM Application WHERE app_name = appname;

    SELECT server_ID INTO server_ID_var FROM Server 
    WHERE server_name = servername;

    SELECT request_type_ID INTO request_type_ID_var 
    FROM Request_Type WHERE type = requesttype;
    
    SELECT COUNT(1) INTO personnum FROM Person 
    WHERE first_name = requestor_first_name AND last_name = requestor_last_name;
    IF personnum = 0 THEN
        INSERT INTO Person (person_ID,first_name,last_name)
        VALUES (Person_seq.nextval,requestor_first_name,requestor_last_name);
    END IF;
    SELECT person_ID INTO person_ID_var FROM Person 
    WHERE first_name = requestor_first_name AND last_name = requestor_last_name; 
    
    INSERT INTO Request (Request_No,storage_type_ID,replication_ID,app_ID,server_ID,
                        Amount_of_storage,request_type_ID,person_ID,Request_date)
    VALUES (Request_seq.nextval,storage_type_ID_var,replication_ID_var,app_ID_var,
            server_ID_var,amountofstorage,request_type_ID_var,person_ID_var,SYSDATE);
    
    costperGB := 0.67;
    INSERT INTO Invoice(Invoice_ID,Request_No,Cost)
    VALUES (Invoice_seq.nextval,Request_seq.currval,costperGB*amountofstorage);

END;

-- stored procedure to add the data to the tables
BEGIN 
    AddServer('aml20056796','192.168.1.8','PROD','Site A');
END;
/

SELECT * FROM Server WHERE server_name = 'aml20056796';

BEGIN 
    add_application ('STAR','Talha','Matal','t.matal@gmail.com',
                'aml20056789','192.168.1.1','PROD','Site A');
    add_application ('BASEL','Talha','Matal','t.matal@gmail.com',
                'aml20056790','192.168.1.2','PROD','Site A');
    add_application ('PCDW','Ted','James','t.james@gmail.com',
                'amw20056789','192.168.2.1','PROD','Site B');
    add_application ('Bingo','Hanna','Harper','h.harper@gmail.com',
                'amw20056790','192.168.2.2','PROD','Site B');           
    add_application ('SRM','Fenny','Packer','f.packer@gmail.com',
                'aml20045678','192.168.3.1','PROD','Site C');
    add_application ('Viper','Julia','Binder','j.binder@gmail.com',
                'aml20045679','192.168.3.2','PROD','Site C');
    add_application ('Python','Maria','Sanders','m.sanders@gmail.com',
                'amw20045678','192.168.4.1','PROD','Site D');                
    add_application ('Zanga','Connie','Easter','c.easter@gmail.com',
                'amw20045679','192.168.4.2','PROD','Site D');                
    add_application ('Dataware','Jane','Martin','j.martin@gmail.com',
                'aml20034567','192.168.5.1','PROD','Site E');
    add_application ('Tarsan','Allison','Binga','a.binga@gmail.com',
                'aml20034568','192.168.5.2','PROD','Site E');
    add_application ('DAL','Bill','Conner','b.conner@gmail.com',
                'amw20034567','192.168.6.1','PROD','Site F');
    add_application ('Opera','Sam','Binga','s.binga@gmail.com',
                'amw20034568','192.168.6.2','PROD','Site F');                
END;
/



SELECT * FROM Application;
SELECT * FROM IT_owner;
SELECT * FROM App_Server_Association;

BEGIN 
    add_request ('G','Synchronous','BASEL',
                'aml20056790','Addition','Talha','Matal',1024);
    add_request ('A','Asynchronous','STAR',
                'aml20056789','Addition','Talha','Matal',1024); 
    add_request ('H','Synchronous','BASEL',
                'aml20056790','Addition','Talha','Matal',2048);
    add_request ('A','Asynchronous','STAR',
                'aml20056789','Addition','Talha','Matal',4096);
    add_request ('G','Synchronous','BASEL',
                'aml20056790','Removal','Talha','Matal',1024);
    add_request ('A','Asynchronous','STAR',
                'aml20056789','Addition','Talha','Matal',5120); 
    add_request ('B','Asynchronous','PCDW',
                'amw20056789','Addition','Ted','James',5120);               
    add_request ('G','Synchronous','Bingo',
                'amw20056790','Addition','Hanna','Harper',5120);
    add_request ('B','Asynchronous','PCDW',
                'amw20056789','Addition','Ted','James',1024);               
    add_request ('G','Synchronous','Bingo',
                'amw20056790','Addition','Hanna','Harper',5120);
    add_request ('B','Asynchronous','PCDW',
                'amw20056789','Removal','Ted','James',2048);               
    add_request ('G','Synchronous','Bingo',
                'amw20056790','Removal','Hanna','Harper',3072);
    add_request ('A','Asynchronous','SRM',
                'aml20045678','Addition','Fenny','Packer',8192);               
    add_request ('H','Synchronous','Viper',
                'aml20045679','Addition','Julia','Binder',8192);
    add_request ('A','Asynchronous','SRM',
                'aml20045678','Addition','Fenny','Packer',1024);               
    add_request ('H','Synchronous','Viper',
                'aml20045679','Addition','Julia','Binder',5120);
    add_request ('A','Asynchronous','SRM',
                'aml20045678','Removal','Fenny','Packer',2048);               
    add_request ('H','Synchronous','Viper',
                'aml20045679','Removal','Julia','Binder',3072);
    add_request ('B','Asynchronous','Python',
                'amw20045678','Addition','Maria','Sanders',4096);               
    add_request ('I','Synchronous','Zanga',
                'amw20045679','Addition','Connie','Easter',3072);
    add_request ('B','Asynchronous','Python',
                'amw20045678','Addition','Maria','Sanders',2048);               
    add_request ('I','Synchronous','Zanga',
                'amw20045679','Addition','Connie','Easter',5120);
    add_request ('B','Asynchronous','Python',
                'amw20045678','Removal','Maria','Sanders',2048);               
    add_request ('I','Synchronous','Zanga',
                'amw20045679','Removal','Connie','Easter',1024);
    add_request ('A','Asynchronous','Dataware',
                'aml20034567','Addition','Jane','Martin',10240);               
    add_request ('H','Synchronous','Tarsan',
                'aml20034568','Addition','Allison','Binga',4096);
    add_request ('A','Asynchronous','Dataware',
                'aml20034567','Addition','Jane','Martin',10240);               
    add_request ('H','Synchronous','Tarsan',
                'aml20034568','Addition','Allison','Binga',5120);                
END;
/



SELECT * FROM Request;
SELECT * FROM Person;
SELECT * FROM Invoice;

UPDATE Invoice
SET Cost = 700
WHERE Invoice_ID = 2;

UPDATE Invoice
SET Cost = 1400
WHERE Invoice_ID = 4;

UPDATE Invoice
SET Cost = 2700
WHERE Invoice_ID = 5;

UPDATE Invoice
SET Cost = 3500
WHERE Invoice_ID = 7;

--- This is the query for the first question
--- 1.	What is the change in the cost of storage for an application over a 
---      specific period like past six months or so?

SELECT Application.app_name, 
       SUM(Cost_Change.NEW_cost)- SUM(Cost_Change.OLD_Cost)AS Change_in_cost  
FROM Cost_Change 
JOIN Invoice ON Invoice.Invoice_ID = Cost_Change.Invoice_ID
JOIN Request ON Invoice.Request_No = Request.Request_No
JOIN Application ON Request.app_ID = Application.app_ID
WHERE Cost_Change.Change_date >= ADD_MONTHS(Cost_Change.Change_date,-6)
GROUP BY Application.app_name;


--- This is the query for the second question
--- 2. How many requests are raised for a particular type of storage 
---    and what is the total amount of storage requested for each storage type?

SELECT storage_type, COUNT(Request_No) AS No_of_requests, 
       SUM(Amount_of_storage)AS Total_Amount
FROM Request
JOIN Type_of_storage 
ON Request.storage_type_ID = Type_of_storage.storage_type_ID
GROUP BY Type_of_storage.storage_type
ORDER BY COUNT(Request_No);

--This is the query for the third question
---3.	What is the amount of storage that is there allocated for each of the server?

SELECT Server.server_name, SUM(amount_of_storage) AS sum_of_storage,
       Replication_type.type AS Replication_Method,SUM(Invoice.Cost) AS Total_cost,
       Type_of_storage.storage_type
FROM Server
JOIN Request ON Server.server_ID = Request.server_ID
JOIN Replication_type ON Request.replication_ID = Replication_type.replication_ID
JOIN Type_of_storage ON Request.storage_type_ID = Type_of_storage.storage_type_ID
JOIN Invoice ON Request.Request_No = Invoice.Request_No
GROUP BY server_name, Replication_type.type,Type_of_storage.storage_type;


--- This is the view for the fourth question
--- 4.	What are the requests that have been raised for an application 
---    and provide details for each of the requests like amount of storage, 
----   replication type, request type, requestor info, server name etc? 

CREATE OR REPLACE VIEW Request_details AS
SELECT Request.Request_No,Application.app_name,Type_of_storage.storage_type,
       Request_type.type,Replication_type.type AS replication, Person.first_name,
       Person.last_name,Request.Request_date,Request.Amount_of_storage,Invoice.Cost,
       Server.server_name
FROM Request
JOIN Application ON Request.app_ID = Application.app_ID
JOIN Request_Type ON Request.request_type_ID = Request_Type.request_type_ID
JOIN Replication_type ON Request.replication_ID = Replication_type.replication_ID
JOIN Person ON Request.person_ID = Person.person_ID
JOIN Type_of_storage ON Request.storage_type_ID = Type_of_storage.storage_type_ID
JOIN Invoice ON Invoice.Request_No = Request.Request_No
JOIN Server ON Request.server_ID = Server.server_ID;



--- Data Visualization queries 
SELECT Application.app_name,SUM(Invoice.Cost) AS Total_cost_storage
FROM Invoice 
JOIN Request ON Invoice.Request_No = Request.Request_No
JOIN Application ON Request.app_ID = Application.app_ID
GROUP BY Application.app_name;

SELECT Application.app_name,SUM( Request.Amount_of_storage) AS Total_storage, 
      SAN_storage.device_size
FROM SAN_Storage
JOIN Type_of_storage ON SAN_storage.storage_type_ID = Type_of_storage.storage_type_ID
JOIN Request ON Type_of_storage.storage_type_ID = Request.storage_type_ID
JOIN Application ON Request.app_ID = Application.app_ID
GROUP BY Application.app_name, SAN_storage.device_size
ORDER BY SUM( Request.Amount_of_storage)