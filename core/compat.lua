setfenv(1, DFRL:GetEnv())

local Setup = {
    fixed = {
        shaguCore = false,
        shaguExtras = false,
    },

    addons = {
        ["ShaguTweaks"] = "shagu",
        ["ShaguTweaks-extras"] = "shagu",
    },

    processed = {}
}

--=================
-- SHAGU
--=================
function Setup:ShaguCore()
    local T = ShaguTweaks.T
    ShaguTweaks.mods[T["Hide Errors"]].enable = function() end
    ShaguTweaks.mods[T["Darkened UI"]].enable = function() end
    ShaguTweaks.mods[T["Hide Gryphons"]].enable = function() end
    ShaguTweaks.mods[T["MiniMap Clock"]].enable = function() end
    ShaguTweaks.mods[T["MiniMap Tweaks"]].enable = function() end
    ShaguTweaks.mods[T["MiniMap Square"]].enable = function() end
    ShaguTweaks.mods[T["Movable Unit Frames"]].enable = function() end
    ShaguTweaks.mods[T["Real Health Numbers"]].enable = function() end
    ShaguTweaks.mods[T["Unit Frame Big Health"]].enable = function() end
    ShaguTweaks.mods[T["Reduced Actionbar Size"]].enable = function() end
    ShaguTweaks.mods[T["Unit Frame Class Colors"]].enable = function() end
    ShaguTweaks.mods[T["Unit Frame Health Colors"]].enable = function() end
    ShaguTweaks.mods[T["Unit Frame Class Portraits"]].enable = function() end
end

function Setup:ShaguExtras()
    local T = ShaguTweaks.T
    ShaguTweaks.mods[T["Show Bags"]].enable = function() end
    ShaguTweaks.mods[T["Show Micro Menu"]].enable = function() end
    ShaguTweaks.mods[T["Reagent Counter"]].enable = function() end
    ShaguTweaks.mods[T["Show Energy Ticks"]].enable = function() end
    ShaguTweaks.mods[T["Floating Actionbar"]].enable = function() end
    ShaguTweaks.mods[T["Dragonflight Gryphons"]].enable = function() end
    ShaguTweaks.mods[T["Center Vertical Actionbar"]].enable = function() end
end

function Setup:ShaguBagBorders()
    local mod = ShaguTweaks.mods[ShaguTweaks.T["Item Rarity Borders"]]
    if not mod then return end

    local orig = mod.enable
    mod.enable = function(self)
        orig(self)
        local skip = {
            "CharacterBag0Slot","CharacterBag1Slot",
            "CharacterBag2Slot","CharacterBag3Slot",
            "KeyRingButton"
        }
        for _, name in pairs(skip) do
            local btn = _G[name]
            if btn and btn.ShaguTweaks_border then
                btn.ShaguTweaks_border:Hide()
            end
        end
    end
end

function Setup:ShaguGUI()
    GameMenuButtonAdvancedOptions:Hide()
    GameMenuButtonAdvancedOptions:SetScript("OnClick", nil)
    AdvancedSettingsGUI:Hide()
    AdvancedSettingsGUI.Show = function() end
end

function Setup:ShaguMetaData()
    return {
        core = {
            ["Auto Dismount"]            = {true, "checkbox", nil, nil, "自动化", 1, "施放坐骑时自动下马", nil, nil},
            ["Auto Stance"]              = {true, "checkbox", nil, nil, "自动化", 2, "战斗中需要时自动切换姿态", nil, nil},
            ["Enemy Castbars"]           = {true, "checkbox", nil, nil, "施法条和姓名板", 3, "显示敌方单位框体施法条", nil, nil},
            ["Nameplate Castbar"]        = {true, "checkbox", nil, nil, "施法条和姓名板", 4, "在敌方姓名板上显示施法条", nil, nil},
            ["Nameplate Scale"]          = {true, "checkbox", nil, nil, "施法条和姓名板", 5, "放大或缩小姓名板", nil, nil},
            ["Chat Hyperlinks"]          = {true, "checkbox", nil, nil, "聊天", 6, "启用聊天中可点击的物品链接", nil, nil},
            ["Chat Tweaks"]              = {true, "checkbox", nil, nil, "聊天", 7, "改善聊天窗口行为和可用性", nil, nil},
            ["Social Colors"]            = {true, "checkbox", nil, nil, "聊天", 8, "根据社交状态等级为名称着色", nil, nil},
            ["Blue Shaman Class Colors"] = {true, "checkbox", nil, nil, "颜色", 9, "使用蓝色作为萨满默认职业颜色", nil, nil},
            ["Nameplate Class Colors"]   = {true, "checkbox", nil, nil, "颜色", 10, "在姓名板文字上使用职业颜色", nil, nil},
            ["WorldMap Class Colors"]    = {true, "checkbox", nil, nil, "颜色", 11, "将职业颜色应用到地图图标", nil, nil},
            ["Cooldown Numbers"]         = {true, "checkbox", nil, nil, "战斗", 12, "始终将冷却时间显示为数字", nil, nil},
            ["Debuff Timer"]             = {true, "checkbox", nil, nil, "战斗", 13, "显示活跃减益效果的持续时间", nil, nil},
            ["Super WoW Compatibility"]  = {true, "checkbox", nil, nil, "兼容性", 14, "支持为Super WoW制作的插件", nil, nil},
            ["Turtle WoW Compatibility"] = {true, "checkbox", nil, nil, "兼容性", 15, "支持乌龟魔兽自定义服务器", nil, nil},
            ["Equip Compare"]            = {true, "checkbox", nil, nil, "鼠标提示", 16, "在鼠标提示中直接比较物品", nil, nil},
            ["Item Rarity Borders"]      = {true, "checkbox", nil, nil, "鼠标提示", 17, "根据物品稀有度为鼠标提示添加边框", nil, nil},
            ["Tooltip Details"]          = {true, "checkbox", nil, nil, "鼠标提示", 18, "为物品鼠标提示添加额外详细信息", nil, nil},
            ["Sell Junk"]                = {true, "checkbox", nil, nil, "商人", 19, "自动出售所有灰色品质垃圾", nil, nil},
            ["Vendor Values"]            = {true, "checkbox", nil, nil, "商人", 20, "在所有鼠标提示中显示商人价格", nil, nil},
            ["WorldMap Coordinates"]     = {true, "checkbox", nil, nil, "世界地图", 21, "实时显示光标/玩家坐标", nil, nil},
            ["WorldMap Window"]          = {true, "checkbox", nil, nil, "世界地图", 22, "可移动和窗口化的世界地图界面", nil, nil},
        },
        extras = {
            ["Bag Item Click"]           = {true, "checkbox", nil, nil, "背包", 1, "在背包中使用右键操作", nil, nil},
            ["Bag Search Bar"]           = {true, "checkbox", nil, nil, "背包", 2, "为所有背包添加搜索栏", nil, nil},
            ["Center Text Input Box"]    = {true, "checkbox", nil, nil, "聊天", 3, "将聊天输入框居中", nil, nil},
            ["Chat History"]             = {true, "checkbox", nil, nil, "聊天", 4, "本地保存最近的聊天消息", nil, nil},
            ["Chat Timestamps"]          = {true, "checkbox", nil, nil, "聊天", 5, "为每条聊天消息显示时间", nil, nil},
            ["Enable Text Shadow"]       = {true, "checkbox", nil, nil, "聊天", 6, "为聊天文字添加微妙阴影", nil, nil},
            ["Macro Icons"]              = {true, "checkbox", nil, nil, "宏", 7, "在宏列表显示中使用图标", nil, nil},
            ["Macro Tweaks"]             = {true, "checkbox", nil, nil, "宏", 8, "添加宏可用性的小改进", nil, nil},
            ["Enable Raid Frames"]       = {true, "checkbox", nil, nil, "团队", 9, "启用完全自定义的团队框体界面", nil, nil},
            ["Hide Party Frames"]        = {true, "checkbox", nil, nil, "团队", 10, "始终隐藏默认队伍框体", nil, nil},
            ["Show Dispel Indicators"]   = {true, "checkbox", nil, nil, "团队", 11, "视觉上标记可驱散的减益效果", nil, nil},
            ["Use As Party Frames"]      = {true, "checkbox", nil, nil, "团队", 12, "在团队布局中显示队伍成员", nil, nil},
            ["Show Group Headers"]       = {true, "checkbox", nil, nil, "团队", 13, "显示每个团队队伍的标题", nil, nil},
            ["Show Healing Predictions"] = {true, "checkbox", nil, nil, "团队", 14, "显示即将到来的治疗预测", nil, nil},
            ["Show Combat Feedback"]     = {true, "checkbox", nil, nil, "团队", 15, "在条上显示伤害/治疗反馈", nil, nil},
            ["Show Aggro Indicators"]    = {true, "checkbox", nil, nil, "团队", 16, "显示谁在团队框体上有仇恨", nil, nil},
            ["Use Compact Layout"]       = {true, "checkbox", nil, nil, "团队", 17, "使用更紧凑的框体布局", nil, nil},
            -- ["Show Energy Ticks"]        = {true, "checkbox", nil, nil, "调整", 18, "为盗贼或德鲁伊显示能量刻度", nil, nil},
            ["Reveal World Map"]         = {true, "checkbox", nil, nil, "世界地图", 19, "移除世界地图上的战争迷雾", nil, nil},
        }
    }
end

function Setup:ApplyShagu()
    if not DFRL.addon1 then return end

    if not self.fixed.shaguCore then
        self:ShaguCore()
        self:ShaguBagBorders()
        self:ShaguGUI()
        self.fixed.shaguCore = true
    end

    if DFRL.addon2 and not self.fixed.shaguExtras then
        self:ShaguExtras()
        self.fixed.shaguExtras = true
    end

    if ShaguTweaks_config then
        if not DFRL.gui.shaguCore then
            DFRL.gui.shaguCoreData = self:ShaguMetaData().core
            DFRL.gui.shaguCore = true
        end

        if DFRL.addon2 and not DFRL.gui.shaguExtras then
            DFRL.gui.shaguExtrasData = self:ShaguMetaData().extras
            DFRL.gui.shaguExtras = true
        end
    else
        local waitFrame = CreateFrame("Frame")
        waitFrame.elapsed = 0
        waitFrame:SetScript("OnUpdate", function()
            this.elapsed = this.elapsed + arg1
            if ShaguTweaks_config or this.elapsed > 2 then
                this:SetScript("OnUpdate", nil)
                if ShaguTweaks_config then
                    if not DFRL.gui.shaguCore then
                        DFRL.gui.shaguCoreData = Setup:ShaguMetaData().core
                        DFRL.gui.shaguCore = true
                    end

                    if DFRL.addon2 and not DFRL.gui.shaguExtras then
                        DFRL.gui.shaguExtrasData = Setup:ShaguMetaData().extras
                        DFRL.gui.shaguExtras = true
                    end
                end
            end
        end)
    end
end

--=================
-- MORE LATER
--=================

--=================
-- INIT
--=================

function Setup:HandleAddon(name)
    if name == "ShaguTweaks" and not (ShaguTweaks and ShaguTweaks.T and ShaguTweaks.mods) then
        return
    end

    local addonType = self.addons[name]
    if addonType == "shagu" then
        self:ApplyShagu()
    end

    self.processed[name] = true
end

function Setup:CheckComplete(f)
    for name, _ in pairs(self.addons) do
        if not self.processed[name] then
            return false
        end
    end
    f:UnregisterEvent("ADDON_LOADED")
    return true
end

function Setup:Init()

    local f = CreateFrame("Frame")
    f:RegisterEvent("ADDON_LOADED")
    f:SetScript("OnEvent", function()
        if event == "ADDON_LOADED" and self.addons[arg1] then
            self:HandleAddon(arg1)
            self:CheckComplete(f)
        end
    end)

    if DFRL.addon1 and ShaguTweaks then
        self:ApplyShagu()
        self.processed["ShaguTweaks"] = true
        self:CheckComplete(f)
    end
end

Setup:Init()
