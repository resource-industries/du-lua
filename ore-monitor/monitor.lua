unit.hide()

oreName = "Acanthite" --export: (Default: Coal) Ore Name
fullAmount = 10 --export: (Default: 100) Full Amount (kL)

template = [[
<style type="text/css">
  body {
    background-color: black;
    color: white;
  }

  table {
    width: 60%;
    margin-left: 20%;
    margin-top: 15vh;
  }

  img {
    width: 80%;
  }
  
  .left {
    width: 50%;
    text-align: center;
  }

  .right {
    text-align: center;
  }
  
  .oreName {
    font-size: 5vw;
  }

  .volume {
    font-size: 8vw;
  }

  .units {
    color: #666666;
  }

  .bar {
    width: 80%;
    margin-left: 10%;
    margin-top: 5vh;
    border: 1vh solid #666666;
    height: 20vh;
  }

  .progress {
    width: ${percent}%;
    height: 100%;
    background-color: #${color};
  }
</style>
<div style="width: 100%; height: 100%; background-color: black">
  <table>
    <tr>
      <td class="left">
        <img src="../../../../../../../resources_generated/iconsLib/materialslib/${pureName}Ore.png" class="image" />
      </td>
      <td class="right">
        <div class="oreName">${oreName}</div>
        <div class="volume">${volume} <span class="units">kL</span></div>
      </td>
    </tr>
  </table>
  <div class="bar"><div class="progress"></div></div>
</div>
]]

local ores = {
   Coal="Carbon",
   Hematite="Iron",
   Quartz="Sodium",
   Bauxite="Aluminium",
   Malachite="Copper",
   Limestone="Calcium",
   Chromite="Chromium",
   Natron="Sodium",
   Petalite="Lithium",
   Acanthite="Silver",
   Pyrite="Sulfur",
   Garnierite="Nickel"
}

local config = {}

function configure()
   if checkSlots(slot1, slot2) then
      config.screen = slot1
      config.container = slot2
      return true
   end

   if checkSlots(slot2, slot1) then
      config.screen = slot2
      config.container = slot1
      return true
   end

   system.print("Can't config")
   return false
end

function checkSlots(a, b)
   return (a ~= nil and b ~= nil and
              string.match(a.getElementClass(), "Screen") and
              string.match(b.getElementClass(), "Container"))
end

function render()
   local pureName = ores[oreName]
   if pureName == nil then
      system.print("Invalid ore name")
      return
   end
   local volume = math.floor(config.container.getItemsVolume() / 1000)
   local percent = math.min(100, math.floor((volume / fullAmount) * 100))

   local color
   if percent > 50 then
      color = "00aa00"
   elseif percent > 20 then
      color = "aaaa00"
   else
      color = "aa0000"
   end
   local params = {
      pureName=pureName,
      oreName=oreName,
      volume=volume,
      percent=percent,
      color=color
   }
   config.screen.setHTML(interp(template, params))
end

function interp(s, tab)
  return (s:gsub('($%b{})', function(w) return tab[w:sub(3, -2)] or w end))
end

if configure() then
   render()
end

