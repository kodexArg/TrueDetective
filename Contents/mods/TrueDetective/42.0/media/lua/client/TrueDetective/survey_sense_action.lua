require "TimedActions/ISBaseTimedAction"

survey_sense_action = ISBaseTimedAction:derive("survey_sense_action")

survey_sense_action.CHANNEL_TIME = 300

function survey_sense_action:isValid()
    local player = self.character
    if not player or player:isDead() then
        return false
    end
    if not TrueDetective_SurveySense.has_magnifier(player) then
        return false
    end
    local building = TrueDetective_SurveySense.aim_residential(player)
    return building ~= nil
end

function survey_sense_action:waitToStart()
    return false
end

function survey_sense_action:start()
    TrueDetective_SurveySense.set_busy(true)
    self:setActionAnim("Loot")
    self.action:setUseProgressBar(true)
end

function survey_sense_action:update()
    self.character:setMetabolicTarget(Metabolics.LightDomestic)
end

function survey_sense_action:stop()
    TrueDetective_SurveySense.set_busy(false)
    ISBaseTimedAction.stop(self)
end

function survey_sense_action:perform()
    TrueDetective_SurveySense.set_busy(false)
    TrueDetective_SurveySense.report(self.character)
    ISBaseTimedAction.perform(self)
end

function survey_sense_action:complete()
    return true
end

function survey_sense_action:forceCancel()
    TrueDetective_SurveySense.set_busy(false)
end

function survey_sense_action:getDuration()
    if self.character:isTimedActionInstant() then
        return 1
    end
    return survey_sense_action.CHANNEL_TIME
end

function survey_sense_action:new(character, target_x, target_y)
    local o = ISBaseTimedAction.new(self, character)
    o.target_x = target_x
    o.target_y = target_y
    o.maxTime = o:getDuration()
    o.stopOnWalk = true
    o.stopOnRun = true
    o.stopOnAim = false
    return o
end
