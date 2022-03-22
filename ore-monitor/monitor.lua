unit.hide()

Material = "Bauxite" --export: (Default: Coal) Ore Name
Volume_Available_L = "192000" --export: (Default: 192000) Available Volume in Hub or Container

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
  
  .material {
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
        <img src="../../../../../../../resources_generated/${pureName}.png" class="image" />
      </td>
      <td class="right">
        <div class="material">${Material}</div>
        <div class="volume">${volume} <span class="units">kL</span></div>
      </td>
    </tr>
  </table>
  <div class="bar"><div class="progress"></div></div>
</div>
]]

local ores = {
  
  Bauxite="iconsLib/materialslib/aluminium_ore",
  Aluminium="iconsLib/materialslib/aluminium_ingot",
  Coal="iconsLib/materialslib/carbonore",
  Carbon="iconsLib/materialslib/carbon_ingot",
  Hematite="iconsLib/materialslib/iron_ore",
  Iron="iconsLib/materialslib/iron_ingot",
  Quartz="iconsLib/materialslib/silicon_ore",
  Silicon="iconsLib/materialslib/silicon_ingot",
  Chromite="iconsLib/materialslib/chromium_ore",
  Chromium="iconsLib/materialslib/chromium_ingot",
  Limestone="iconsLib/materialslib/calcium_ore",
  Calcium="iconsLib/materialslib/calcium_ingot",
  Malachite="iconsLib/materialslib/copper_ore",
  Copper="iconsLib/materialslib/copper_ingot",
  Natron="iconsLib/materialslib/sodium_ore",
  Sodium="iconsLib/materialslib/sodium_ingot",
  Acanthite="iconsLib/materialslib/silver_ore",
  Silver="iconsLib/materialslib/silver_ingot",
  Garnierite="iconsLib/materialslib/nickel_ore",
  Nickel="iconsLib/materialslib/nickel_ingot";
  Petalite="iconsLib/materialslib/lithium_ore",
  Lithium="iconsLib/materialslib/lithium_ingot",
  Pyrite="iconsLib/materialslib/sulfur_ore",
  Sulfur="iconsLib/materialslib/sulfur_ingot",
  Cobaltite="iconsLib/materialslib/cobalt_ore",
  Cobalt="iconsLib/materialslib/cobalt_ingot",
  Cryolite="iconsLib/materialslib/fluorine_ore",
  Fluorine="iconsLib/materialslib/fluorine_ingot",
  GoldNuggets="iconsLib/materialslib/gold_ore",
  Gold="iconsLib/materialslib/gold_ingot",
  Kolbeckite="iconsLib/materialslib/scandium_ore",
  Scandium="iconsLib/materialslib/scandium_ingot",
  Columbite="iconsLib/materialslib/niobium_ore",
  Niobium="iconsLib/materialslib/niobioum_ingot",
  Ilmenite="iconsLib/materialslib/titanium_ore",
  Titanium="iconsLib/materialslib/titanium_ingot",
  Rhodonite="iconsLib/materialslib/manganese_ore",
  Manganese="iconsLib/materialslib/manganese_ingot",
  Thoramine="iconsLib/materialslib/env_thoramine-ore_001_icon",
  Trithorium="iconsLib/materialslib/trithorium_pure",
  Vanadinite="iconsLib/materialslib/vanadium_ore",
  Vanadium="iconsLib/materialslib/vanadium_ingot",
  Hydrogen="elementsLib/pures/pure-gazs/pure-gaz-hydrogen_001/icons/env_pure-gaz-hydrogen_001_icon",
  Oxygen="elementsLib/pures/pure-gazs/pure-gaz-hydrogen_001/icons/env_pure-gaz-oxygen_001_icon"
}

local config = {}

function configure()
  if checkSlots(slot1, slot2) then
      config.screen = slot1
      config.container = slot2
      maxVolume = math.floor(slot2.getMaxVolume())
      currentVolume = math.floor(slot2.getItemsVolume())
      
      return true
  end

  if checkSlots(slot2, slot1) then
      config.screen = slot2
      config.container = slot1
      maxVolume = math.floor(slot1.getMaxVolume())
      currentVolume = math.floor(slot1.getItemsVolume())
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
  local pureName = ores[Material]
  if pureName == nil then
      system.print("Invalid ore name")
      return
  end
  local volume = math.floor(currentVolume / 1000)
  local percent = math.floor(currentVolume / Volume_Available_L)*100
  
  system.print("Volume: " ..volume.. " (Current Volume / 1000)")
  system.print("Percent: " ..percent.. " (Current Volume / Volume Available L)")
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
      Material=Material,
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
