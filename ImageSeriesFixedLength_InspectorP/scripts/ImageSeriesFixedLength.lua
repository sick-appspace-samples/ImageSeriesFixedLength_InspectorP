--[[----------------------------------------------------------------------------

  Application Name:
  ImageSeriesFixedLength_InspectorP

  Description:
  Setting up camera and taking image series of fixed length started by external trigger.

  How to Run:
  A connected InpspectorP6 device with a connected trigger source is necessary to run
  this sample. Starting this sample is possible either by running the app (F5) or
  debugging (F7+F10).
  Set a breakpoint on the first row inside the main or processImage function to
  debug step-by-step. See the acquired images in the image viewer on the DevicePage.

  More Information:
  See the tutorial "Devices - InspectorP - TriggeringAndAcquisition".

------------------------------------------------------------------------------]]
--Start of Global Scope---------------------------------------------------------

-- Create and configure camera
local camera = Image.Provider.Camera.create()

local config = Image.Provider.Camera.V2DConfig.create()
config:setBurstLength(15) -- Acquire series of 15 images
config:setFrameRate(10) -- Hz
config:setShutterTime(700) -- us
config:setStartSource('DI1', 'ON_ACTIVE') -- Trigger start
camera:setConfig(config)

-- Create viewer
local viewer = View.create()

--End of Global Scope-----------------------------------------------------------

--Start of Function and Event Scope---------------------------------------------

local function main()
  camera:enable()
end
Script.register('Engine.OnStarted', main)

local function processImage(im, sensorData)
  viewer:clear()
  viewer:addImage(im)
  viewer:present()
  print(sensorData:toString())
end
camera:register('OnNewImage', processImage)

--End of Function and Event Scope--------------------------------------------------
