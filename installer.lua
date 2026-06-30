local shell = require("shell")
local term = require("term")
local filesystem = require("filesystem")
local internet = require("internet")
local serialization = require("serialization")
local component = require("component")

---@class ProgramDescription
---@field name string
---@field description string
---@field lastSupportedGtnhVersion string?
---@field repository string
---@field archiveName string
---@field versions ProgramVersion[]

---@class ProgramVersion
---@field gtnhVersion string
---@field tag string?
---@field configDescriptorUrl string

local programsUrl = "https://raw.githubusercontent.com/Navatusein/GTNH-OC-Installer/main/programs.lua"

local tarManUrl = "https://raw.githubusercontent.com/Navatusein/GTNH-OC-Installer/refs/heads/main/tar/tar.man"
local tarBinUrl = "https://raw.githubusercontent.com/Navatusein/GTNH-OC-Installer/refs/heads/main/tar/tar.lua"

---Check if Open OS installed
local function checkIsOsInstall()
  local file = io.open("/home/test.txt", "w")

  if file == nil then
    error("Open OS is not installed")
  end

  file:close()

  shell.execute("rm /home/test.txt")
end

---Check connection to github
local function checkGithub()
  local success, request = pcall(internet.request, programsUrl)


	if not success then
		if request then
      local success, result = pcall(request)

			if success and result ~= nil and result:match("PKIX") then
				error("Download server SSL certificates was rejected by Java. Update your Java version or install certificates for github.com manually")
			else
				error("Download server is unavailable: "..tostring(result))
			end
		else
			error("Download server is unavailable for unknown reasons")
		end
	end
end

---Download and install tar utility
local function downloadTarUtility()
  if filesystem.exists("/bin/tar.lua") then
    return
  end

  shell.setWorkingDirectory("/usr/man")
  shell.execute("wget -fq "..tarManUrl)
  shell.setWorkingDirectory("/bin")
  shell.execute("wget -fq "..tarBinUrl)
end

---Get program list from url
---@param programListUrl string
---@return ProgramDescription[]
local function getProgramList(programListUrl)
  local request = internet.request(programListUrl)
  local result = ""

  for chunk in request do
    result = result..chunk
  end

  return load(result)()
end

---Choose program
---@param programs ProgramDescription[]
---@return ProgramDescription
local function chooseProgram(programs)
  for key, value in pairs(programs) do
    local header = "["..key.."] "
    local headerIndent = string.rep(" ", #header)

    term.write(header..value.name.."\n")
    term.write(headerIndent .. value.description.."\n")

    if value.lastSupportedGtnhVersion then
      component.gpu.setForeground(0xFFA500)
      term.write(headerIndent .. "Last supported GTNH version: " .. value.lastSupportedGtnhVersion .. "\n")
      component.gpu.setForeground(0xFFFFFF)
    end

    term.write("\n")
  end

  term.write("\nSelect program to install [1-"..tostring(#programs).."]\n")

  local _, startRow = term.getCursor()

  while true do
    term.write("===>")

    local parsedInput = tonumber(io.read())

    if parsedInput and parsedInput >= 1 and parsedInput <= #programs then
      return programs[parsedInput]
    end

    term.setCursor(1, startRow)
    term.clearLine()
  end
end

---Build url for program download
---@param program ProgramDescription
---@param tag string
local function buildDownloadUrl(program, tag)
  local url = "https://github.com/" .. program.repository

  if tag then
    return url .. "/releases/download/" .. tag .. "/" .. program.archiveName .. ".tar"
  end

  return url .. "/releases/latest/download/" .. program.archiveName .. ".tar"
end

---Choose program
---@param program ProgramDescription
---@return string, string
local function chooseVersion(program)
  if #program.versions == 1 then
    local version = program.versions[1]
    return program.name, buildDownloadUrl(program, version.tag)
  end

  term.write("\n")

  for key, value in pairs(program.versions) do
    term.write("["..key.."] version for GTNH: " .. value.gtnhVersion .. "\n")
  end

  term.write("\nSelect version to install [1-"..tostring(#program.versions).."] or enter tag\n")

  local _, startRow = term.getCursor()

  while true do
    term.write("===>")

    local userInput = io.read()
    local parsedInput = tonumber(userInput)

    if parsedInput and parsedInput >= 1 and parsedInput <= #program.versions then
      local version = program.versions[parsedInput]
      return program.name, buildDownloadUrl(program, version.tag)
    else
      return program.name, buildDownloadUrl(program, userInput)
    end

    term.setCursor(1, startRow)
    term.clearLine()
  end
end

---Make auto run
local function makeAutoRun()
  term.write("\nCreate auto run [y/n]\n")
  term.write("===>")

  local userInput = io.read()

  term.clear()

  if string.lower(userInput) == "y" then
    local file = assert(io.open("/home/.shrc", "w"))
    file:write("main")
    file:close()

    term.write("Auto run created\n")
  else
    term.write("Auto run ignored\n")
  end
end

---Download and install program
---@param programName string
---@param programUrl string
local function downloadProgram(programName, programUrl)
  term.write("Installing "..programName.."\n")

  if filesystem.exists("/home/config.lua") then
    shell.execute("mv config.lua config.perv.lua")
  end

  shell.execute("wget -fq "..programUrl.." program.tar")
  shell.execute("tar -xf program.tar")
  shell.execute("rm program.tar")

  term.write("Installation complete\n")
end

---Main
local function main()
  checkIsOsInstall()
  checkGithub()

  term.clear()
  term.write("Welcome to Navatusein's programs installer\n\n")

  downloadTarUtility()
  local programs = getProgramList(programsUrl)
  local program = chooseProgram(programs)
  local programName, programUrl = chooseVersion(program)

  shell.setWorkingDirectory("/home")

  makeAutoRun()
  downloadProgram(programName, programUrl)
end

main()