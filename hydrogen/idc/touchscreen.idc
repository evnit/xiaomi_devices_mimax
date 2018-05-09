# Copyright 2017 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#
# Input Device Calibration File for the taimen touch screen.
#

device.internal = 1

touch.deviceType = touchScreen
touch.orientationAware = 1
touch.filter.level = 0
touch.size.calibration = diameter
touch.size.scale = 5
touch.size.bias = 5
touch.size.isSummed = 0
touch.gestureMode = pointer
touch.pressure.calibration = physical
touch.pressure.scale = 0.00000125
touch.distance.calibration = none 
touch.distance.scale = 0 
touch.gestureMode = spots 
MultitouchSettleInterval = 0.1ms 
MultitouchMinDistance = 0.5 px 
TapInterval = 0.5 ms 
TapSlop = 0.5 px
touch.orientation.calibration = none
touch.coverage.calibration = box