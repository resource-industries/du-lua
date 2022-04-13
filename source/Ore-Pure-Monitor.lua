unit.hide()

Material = "Bauxite" --export: (Default: Coal) Ore Name
Volume_Available_KL = "1920" --export: (Default: 1920) Available Volume (KL) in Hub or Container

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
        <img src="http://assets.prod.novaquark.com/${pureName}.png" class="image" />
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
  
  Bauxite="70186/2a660dc9-9af6-4f4b-87d3-bba4defb1964",
  Aluminium="70186/cfdec659-f969-415e-865b-2f45732c0721",
  Coal="70186/edc9f97e-7359-454e-8ba9-8f960037ae9b",
  Carbon="70186/1bbb1cd2-c592-4e73-a21f-459feafea9f1",
  Hematite="70186/4ff8e9b7-5ed8-4b62-9b02-219219081efa",
  Iron="70186/e4a55054-e4e4-4d31-b476-5a5be639cdfe",
  Quartz="70186/a8d1c39e-d3d3-4a75-bce1-348036588108",
  Silicon="33603/f278b764-df68-43c4-a927-5b95d13129f7",
  Chromite="70186/b7357f8d-43ce-4279-a7d3-75fb6fda4fcd",
  Chromium="70186/30f8a263-b1c5-4183-851a-ef2bdedcbd0c",
  Limestone="70186/dc16bf83-bc00-42b3-8f71-1683e8350efb",
  Calcium="33603/f1088f6b-2a8f-4014-9668-841a0e553b6c",
  Malachite="45824/36e5a9ca-c9f6-4e66-b2f4-fe64c9289224",
  Copper="33603/94c19b9e-c692-4517-9213-e903fdf2bf1a",
  Natron="70186/cec7c516-9f70-4b2b-9d60-6f9527ae36a8",
  Sodium="70186/20bdcf7a-57a1-4c7c-9448-d8bfeaa25807",
  Acanthite="70186/e5246f30-14b3-4bf8-bfc1-9bf20a40ed6e",
  Silver="70186/b8e973ac-7b9b-4d67-907d-569f7ea607a7",
  Garnierite="70186/b8a8443d-374d-4df2-b289-bfe69105a962",
  Nickel="70186/0fc41ba8-947c-49ad-925c-fe08802fd189";
  Petalite="70186/3ce3c407-4cfc-4c90-9258-c7af0a5bcf97",
  Lithium="70186/d3ff1b6d-8e4e-4d9a-92ba-471eb41748b3",
  Pyrite="70186/0423117d-8754-470c-873c-9b56bf3b9ae2",
  Sulfur="70186/f7b48d69-05dc-4ab9-8dcd-98db49ea1c4d",
  Cobaltite="70186/a1e3cbd0-c1c1-423d-abea-bf89fbbeb936",
  Cobalt="70186/d19ba950-6d03-4d48-8ccd-53cca2e75670",
  Cryolite="70186/54c5acf2-7c0c-4154-b38c-ffe22d349b80",
  Fluorine="70186/de954433-be17-41d1-bbc6-e869f299af27",
  GoldNuggets="70186/335baaee-7651-4b90-9e5a-290950ed0f5a",
  Gold="70186/93d6fc8a-b279-4888-b771-d8c6c1e5537b",
  Kolbeckite="70186/c4d32953-9bfb-4586-974d-de0a2ea0f954",
  Scandium="70186/cabbf832-0cd8-4c36-b2fd-447b4d59b255",
  Columbite="70186/891cbe02-e34c-4473-9cac-65ba67075e47",
  Niobium="70186/5f88a651-62ad-4a28-985f-b1f8ad8bded4",
  Ilmenite="70186/13f64ee1-4c8d-40bb-9eff-605e6e6e681f",
  Titanium="70186/b59240cd-f161-4939-a634-a8ba5f55e5a6",
  Rhodonite="70186/a2f5af65-de9e-4b49-a752-a47a42eca4e9",
  Manganese="70186/2f1b6ad3-b034-46d4-862d-c5d3fc8281eb",
  Thoramine="70186/d31d5c49-80d1-4d4e-aa87-9e15d161992b",
  --Trithorium="iconsLib/materialslib/trithorium_pure",
  Vanadinite="70186/34804219-fcbb-4900-9358-77688ef535fe",
  Vanadium="70186/6bab2dbf-b46a-4ecd-b931-fa9709f721f8",
  Hydrogen="70186/88781b09-fd68-4f5b-a128-376ca6a7457e",
  Oxygen="70186/828ca6c1-2ef0-4845-b5a6-b1a02d206b69"
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
  local percent = volume / Volume_Available_KL * 100
  
  system.print("Volume: " ..volume.. " (volume)")
  system.print("Percent: " ..percent.. " (Volume / Volume Available KL * 100)")
  local color
  if percent > 75 then
      color = "00aa00"
  elseif percent > 50 then
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
