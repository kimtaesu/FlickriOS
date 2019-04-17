
## Photo Size
s    작은 사각형 75x75
q    large square 150x150
t    썸네일, 가장 긴 면이 100
m    소형, 가장 긴 면이 240
n    small, 320 on longest side
-    중형, 가장 긴 면이 500
z    중형(가장 긴 면이 640)
c    중형 800(가장 긴 면이 800)†
b    대형(가장 긴 면이 1024)*
h    대형 1600, 가장 긴 면이 1600†
k    대형 2048, 가장 긴 면이 2048†
o    원본 이미지, 소스 형식에 따라 jpg, gif 또는png

## Usage
"""
pod install --repo-update
carthage update --platform iOS --no-use-binaries 2>/dev/null

carthage update ReactorKit --platform iOS --no-use-binaries 2>/dev/null
(cd Carthage/Checkouts/ReactorKit && swift package generate-xcodeproj)
carthage build ReactorKit  --platform iOS
"""
