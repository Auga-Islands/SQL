CREATE EXTENSION IF NOT EXISTS “uuid-ossp”;

CREATE TABLE Phone_Number(
    UUID UUID NOT NULL PRIMARY KEY ,
    Person_UUID UUID NOT NULL,
    Prefix varchar(8) NOT NULL ,
    Number varchar(16) NOT NULL UNIQUE ,
    Confirmed bool NOT NULL
);


CREATE TABLE Person(
    UUID UUID NOT NULL PRIMARY KEY ,
    Username varchar(40) NOT NULL UNIQUE , --
    Password varchar(64) NOT NULL , --
    Email varchar(256) UNIQUE CHECK ( Email LIKE '%@%'), --
    Confirmed_email bool ,
    Phone_UUID UUID REFERENCES Phone_Number(UUID) UNIQUE ,
    Google_ID text UNIQUE,
    Apple_ID text UNIQUE,
    Languages text[] NOT NULL CHECK (
        Languages <@ ARRAY['IS','EN','PL','DA','NO','SV','FR','GE','ES']),
        --'Icelandic','English','Polish','Danish','Norwegian','Swedish','French','German','Spanish'
    Profile_photo_path text,
    Cover_photo_path text,
    Bio varchar(255),
    Website_url varchar(2083),
    Birth_date date,
    Gender varchar(13) CHECK ( Gender IN ('Male','Female','Other','Not specified') ),
    Live_motto varchar(64),
    Transaction_counter int,
    First_response_times text[],
    Restarts int,
    Active bool
);


ALTER TABLE Phone_Number ADD CONSTRAINT FK_Person FOREIGN KEY (Person_UUID) REFERENCES Person(UUID);
-- Relation Phone_Number to User

CREATE TABLE Search(
    UUID UUID PRIMARY KEY NOT NULL ,
    Person_UUID UUID REFERENCES Person(UUID) NOT NULL ,
    Search_time timestamp NOT NULL ,
    Contents varchar(80) NOT NULL --We must establish max len of search
    );

CREATE TABLE Chat(
    UUID UUID PRIMARY KEY NOT NULL ,
    Sender_UUID UUID REFERENCES Person(UUID) NOT NULL ,
    Receiver_UUID UUID REFERENCES Person(UUID) NOT NULL ,
    Send_time timestamp NOT NULL ,
    Contents varchar(640) NOT NULL ,
--     Item_UUID UUID REFERENCES Item(UUID), -- uptade when create Item
    Attachment_path text
    );

CREATE TABLE Social(
    UUID UUID PRIMARY KEY NOT NULL ,
    Follower_UUID UUID REFERENCES Person(UUID) NOT NULL ,
    Following_UUID UUID REFERENCES Person(UUID) NOT NULL
    );