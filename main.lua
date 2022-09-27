local sleep = require("sleep");
local json = require("json");

local function GetNumber(Str)
    local t = {}
    for i in Str:gmatch("%d+") do
        t[#t + 1] = i
    end
    return t;
end
 
local function CheckDuplicateNumber(t)
    for _, Value_1 in pairs(t) do
        local Count = 0;
        for _, Value_2 in pairs(t) do
            if Value_1 == Value_2 then
                Count = Count + 1;
            end
        end

        if Count >= 3 or (Value_1 == "0" and Count >= 2) then return true end;
    end

    return false;
end
 
local function GenerateNumber(Start, End)
    sleep(0.5);
    math.randomseed((os.time() + os.clock() + 32)^2);
    return math.random(Start, End);
end

local Config = json.decode(io.open("./Config.json", "r"):read("a"));

 
 
local Content = {
    ["Question"] = "",
    ["Answer"] = 0
};
 
local function Main()
    os.execute("cls");
    
    Content = {
        ["Question"] = "",
        ["Answer"] = 0
    };

    local function GenQuestion()
        while true do
            Content.Question = "[";
            for _ = 1, Config.CountQuestion do
                Content.Question = Content.Question .. GenerateNumber(0, 9) .. " ";
            end
            Content.Question = Content.Question .. "]";
            if not CheckDuplicateNumber(GetNumber(Content.Question)) then
                break
            end
        end
    end

    GenQuestion();
    Content.Answer = GenerateNumber(0, tonumber(string.rep("9", Config.CountAnswer)));
    
    print("Question : " .. Content.Question);
    print("Answer : " .. Content.Answer);
    print("------------------------------");
    
    print("Starting Timer 20s⌛");
    sleep(14);
    for n = 5, 1, -1 do
        sleep(1);
        print(n);
    end
    
    os.execute("echo \7");
    print("TimeOut⌛!");
    print("------------------------------");
    return true;
end

while true do
    Main();
    io.write("Can the problem be solved? : ");
    local Response = io.read();
    if string.lower(Response) == "y" then
        Response = true;
    else
        Response = false;
    end
    local File = io.open("./Data.txt", "a");
    File:write(string.format("%s : %s -> | %s\n", Content.Question, Content.Answer, Response));
    File:close();
end