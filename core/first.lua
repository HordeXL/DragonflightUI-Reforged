setfenv(1, DFRL:GetEnv())

local Setup = {
    welcomeConfig = {
        width = 450,
        height = 400,
        timerDuration = 10,
        barWidth = 200,
        barHeight = 3,
        fadeTime = 0.4,
    },

    patchConfig = {
        width = 400,
        height = 210,
        timerDuration = 10,
        barWidth = 200,
        barHeight = 3,
        title = "|cFFFF0000重要补丁警告|r",
        text = "补丁 2.0.11 已原生实现了 PVP 图标。\n\n请勿再将 'TargetingFrame' 文件夹放入\n您的 WoW/Interface/ 目录中。\n请停用暴雪默认模块。",
        additionalText = "",
        version = "2.0.11",
    },

    welcomeFrame = nil,
}

function Setup:TempDBForSwitching(isDarkMode)
    DFRL.tempDB = {}

    local src = isDarkMode and DFRL.profiles.darkMode or DFRL.profiles.lightMode
    if not src then return end

    for moduleName, moduleTable in pairs(src) do
        if moduleTable then
            DFRL.tempDB[moduleName] = {}
            for key, value in pairs(moduleTable) do
                if value then
                    DFRL.tempDB[moduleName][key] = value
                end
            end
        end
    end

    DFRL:TriggerAllCallbacks()
    DFRL.gui.Base:UpdateHandler()
end

function Setup:WelcomePage()
    if not self.welcomeFrame then
        self.welcomeFrame = CreateFrame("Frame", "DFRL_WelcomeFrame", UIParent)
    end
    self.welcomeFrame:SetWidth(self.welcomeConfig.width)
    self.welcomeFrame:SetHeight(self.welcomeConfig.height)
    self.welcomeFrame:SetPoint("CENTER", 0, 0)
    self.welcomeFrame:SetFrameStrata("TOOLTIP")
    self.welcomeFrame:SetToplevel(true)
    self.welcomeFrame:SetBackdrop{
        bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
    }
    self.welcomeFrame:EnableMouse(true)

    T.GradientLine(self.welcomeFrame, "TOP", 1)
    T.GradientLine(self.welcomeFrame, "TOP", -60, nil, 200)
    T.GradientLine(self.welcomeFrame, "TOP", -290, nil, 200)
    T.GradientLine(self.welcomeFrame, "BOTTOM", -1, 3)

    local title = self.welcomeFrame:CreateFontString(nil, "OVERLAY")
    title:SetFont("Fonts\\FRIZQT__.TTF", 18, "OUTLINE")
    title:SetText("|cFFFFFFFF欢迎使用|r |cFFFFD700Dragonflight|r: |cFFFFFFFFReforged|r |cFFFFD7002.0")
    title:SetPoint("TOP", 0, -25)

    local text = self.welcomeFrame:CreateFontString(nil, "OVERLAY")
    text:SetFont("Fonts\\FRIZQT__.TTF", 15, "OUTLINE")
    text:SetText("提示：\n按住 CTRL + SHIFT + ALT 来移动框架。\n\n\n在报告错误之前：\n|cffff6060请禁用除 Dragonflight: Reforged 之外|n的所有其他插件。|r\n\n90% 的错误报告都是由与其他插件的冲突引起的。\n感谢您帮助我们保持错误报告的准确性。\n\n享受 |cFFFFD700Dragonflight|r 的乐趣，别忘了更新。 ")
    text:SetPoint("TOP", title, "BOTTOM", 0, -40)
    text:SetWidth(380)

    local okBtn = CreateFrame("Button", nil, self.welcomeFrame)
    okBtn:SetWidth(65)
    okBtn:SetHeight(27)
    okBtn:SetPoint("BOTTOM", 0, 60)
    okBtn:Disable()
    local okBtnTxt = okBtn:CreateFontString(nil, "OVERLAY")
    okBtnTxt:SetFont("Fonts\\FRIZQT__.TTF", 12, "OUTLINE")
    okBtnTxt:SetPoint("CENTER", okBtn, "CENTER", 0, 0)
    okBtnTxt:SetText("确定")
    okBtn:SetFontString(okBtnTxt)

    local menuBtn = CreateFrame("Button", nil, self.welcomeFrame)
    menuBtn:SetWidth(65)
    menuBtn:SetHeight(27)
    menuBtn:SetPoint("TOP", okBtn, "BOTTOM", 0, -10)
    menuBtn:Disable()
    local menuBtnTxt = menuBtn:CreateFontString(nil, "OVERLAY")
    menuBtnTxt:SetFont("Fonts\\FRIZQT__.TTF", 12, "OUTLINE")
    menuBtnTxt:SetPoint("CENTER", menuBtn, "CENTER", 0, 0)
    menuBtnTxt:SetText("菜单")
    menuBtn:SetFontString(menuBtnTxt)

    local lightBtn = CreateFrame("Button", nil, self.welcomeFrame)
    lightBtn:SetWidth(50)
    lightBtn:SetHeight(24)
    lightBtn:SetPoint("RIGHT", okBtn, "LEFT", -15, -13)
    local lightBtnTxt = lightBtn:CreateFontString(nil, "OVERLAY")
    lightBtnTxt:SetFont("Fonts\\FRIZQT__.TTF", 10, "OUTLINE")
    lightBtnTxt:SetPoint("CENTER", lightBtn, "CENTER", 0, 0)
    lightBtnTxt:SetText("浅色模式")
    lightBtn:SetFontString(lightBtnTxt)
    lightBtn:SetScript("OnClick", function()
        Setup:TempDBForSwitching(false)
    end)

    local darkBtn = CreateFrame("Button", nil, self.welcomeFrame)
    darkBtn:SetWidth(50)
    darkBtn:SetHeight(24)
    darkBtn:SetPoint("LEFT", okBtn, "RIGHT", 15, -13)
    local darkBtnTxt = darkBtn:CreateFontString(nil, "OVERLAY")
    darkBtnTxt:SetFont("Fonts\\FRIZQT__.TTF", 10, "OUTLINE")
    darkBtnTxt:SetPoint("CENTER", darkBtn, "CENTER", 0, 0)
    darkBtnTxt:SetText("深色模式")
    darkBtn:SetFontString(darkBtnTxt)
    darkBtn:SetScript("OnClick", function()
        Setup:TempDBForSwitching(true)
    end)

    menuBtn:SetScript("OnClick", function()
        UIFrameFadeOut(self.welcomeFrame, self.welcomeConfig.fadeTime, 1, 0)
        local hideTimer = 0
        self.welcomeFrame:SetScript("OnUpdate", function()
            hideTimer = hideTimer + arg1
            if hideTimer >= self.welcomeConfig.fadeTime then
                self.welcomeFrame:Hide()
                self.welcomeFrame:SetScript("OnUpdate", nil)
                _G.SlashCmdList["DFRL"]()
            end
        end)
        local char = UnitName("player")
        DFRL_CUR_PROFILE[char .. "_firstRun"] = true
    end)

    okBtn:SetScript("OnClick", function()
        UIFrameFadeOut(self.welcomeFrame, self.welcomeConfig.fadeTime, 1, 0)
        local hideTimer = 0
        self.welcomeFrame:SetScript("OnUpdate", function()
            hideTimer = hideTimer + arg1
            if hideTimer >= self.welcomeConfig.fadeTime then
                self.welcomeFrame:Hide()
                self.welcomeFrame:SetScript("OnUpdate", nil)
            end
        end)
        local char = UnitName("player")
        DFRL_CUR_PROFILE[char .. "_firstRun"] = true
    end)

    local barWidth = self.welcomeConfig.barWidth
    local barHeight = self.welcomeConfig.barHeight
    local timerBar = self.welcomeFrame:CreateTexture(nil, "OVERLAY")
    timerBar:SetTexture("Interface\\Buttons\\WHITE8x8")
    timerBar:SetVertexColor(1, 0.82, 0)
    timerBar:SetPoint("BOTTOM", self.welcomeFrame, "BOTTOM", 0, 5)
    timerBar:SetWidth(barWidth)
    timerBar:SetHeight(barHeight)

    local elapsed = 0
    self.welcomeFrame:SetScript("OnUpdate", function()
        elapsed = elapsed + arg1
        if elapsed >= self.welcomeConfig.timerDuration then
            okBtn:Enable()
            menuBtn:Enable()
            timerBar:Hide()
            self.welcomeFrame:SetScript("OnUpdate", nil)
            DFRL.activeScripts["WelcomePageScript"] = false
        else
            timerBar:SetWidth(barWidth * (1 - elapsed / self.welcomeConfig.timerDuration))
            DFRL.activeScripts["WelcomePageScript"] = true
        end
    end)
end

function Setup:PatchWarning()
    local patchFrame = CreateFrame("Frame", "DFRL_WelcomeFrame", UIParent)
    patchFrame:SetWidth(self.patchConfig.width)
    patchFrame:SetHeight(self.patchConfig.height)
    patchFrame:SetPoint("TOP", 0, -5)
    patchFrame:SetBackdrop{ bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background"}
    patchFrame:EnableMouse(true)

    T.GradientLine(patchFrame, "TOP", -0)
    T.GradientLine(patchFrame, "BOTTOM", 0)

    local title = patchFrame:CreateFontString(nil, "OVERLAY")
    title:SetFont("Fonts\\FRIZQT__.TTF", 18, "OUTLINE")
    title:SetText(self.patchConfig.title)
    title:SetPoint("TOP", 0, -20)

    local fullText = self.patchConfig.text
    if self.patchConfig.additionalText ~= "" then
        fullText = fullText .. "\n\n|cFFFF0000" .. self.patchConfig.additionalText .. "|r"
    end

    local text = patchFrame:CreateFontString(nil, "OVERLAY")
    text:SetFont("Fonts\\FRIZQT__.TTF", 15, "OUTLINE")
    text:SetText(fullText)
    text:SetPoint("TOP", title, "BOTTOM", 0, -16)
    text:SetWidth(380)

    local okBtn = DFRL.tools.CreateButton(patchFrame, "确定", 120, 24)
    okBtn:SetPoint("BOTTOM", 0, 20)
    okBtn:Disable()

    okBtn:SetScript("OnClick", function()
        patchFrame:Hide()
        DFRL:SetTempDBNoCallback("Generic", "patchWarnVersion", self.patchConfig.version)
    end)

    local barWidth = self.patchConfig.barWidth
    local barHeight = self.patchConfig.barHeight
    local timerBar = patchFrame:CreateTexture(nil, "OVERLAY")
    timerBar:SetTexture("Interface\\Buttons\\WHITE8x8")
    timerBar:SetVertexColor(1, 0.82, 0)
    timerBar:SetPoint("BOTTOM", okBtn, "TOP", 0, 10)
    timerBar:SetWidth(barWidth)
    timerBar:SetHeight(barHeight)

    local elapsed = 0
    patchFrame:SetScript("OnUpdate", function()
        elapsed = elapsed + arg1
        if elapsed >= self.patchConfig.timerDuration then
            okBtn:Enable()
            timerBar:Hide()
            patchFrame:SetScript("OnUpdate", nil)
            DFRL.activeScripts["PatchWarningScript"] = false
        else
            timerBar:SetWidth(barWidth * (1 - elapsed / self.patchConfig.timerDuration))
            DFRL.activeScripts["PatchWarningScript"] = true
        end
    end)
end

DFRL.activeScripts["WelcomePageScript"] = false
DFRL.activeScripts["PatchWarningScript"] = false

-- init
local f = CreateFrame("Frame")
f:RegisterEvent("VARIABLES_LOADED")
f:SetScript("OnEvent", function()
    local char = UnitName("player")
    if not DFRL_CUR_PROFILE[char .. "_firstRun"] then
        Setup:WelcomePage()
    end

    -- local seenVersion = DFRL:GetTempValue("Generic", "patchWarnVersion")
    -- if seenVersion ~= Setup.patchConfig.version then
    --     -- Setup:PatchWarning()
    -- end
end)
