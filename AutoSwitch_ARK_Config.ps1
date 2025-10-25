# ------------------------------------------------------------
# ARK DynamicConfig 自动切换脚本（Windows）
# 每周五 18:00 切换为活动倍率
# 每周一 00:00 切回普通倍率
# ------------------------------------------------------------

$repoPath   = "C:\Users\Administrator\ark-configs"   # ← 改成你的实际路径
$normalFile = "$repoPath\DynamicConfig_Normal.ini"
$eventFile  = "$repoPath\DynamicConfig_Event.ini"
$targetFile = "$repoPath\DynamicConfig.ini"

# 获取当前日期时间
$day  = (Get-Date).DayOfWeek.value__
$hour = (Get-Date).Hour

# 判断时间范围
if (($day -eq 5 -and $hour -ge 18) -or ($day -eq 6) -or ($day -eq 0 -and $hour -lt 24)) {
    Copy-Item $eventFile $targetFile -Force
    Write-Host "? 已切换至活动倍率配置 (Event)"
} else {
    Copy-Item $normalFile $targetFile -Force
    Write-Host "? 已切换至普通倍率配置 (Normal)"
}

# 推送到 GitHub
Set-Location $repoPath
git add DynamicConfig.ini
$time = Get-Date -Format "yyyy-MM-dd HH:mm"
git commit -m "Auto update DynamicConfig $time"
git push origin main

Pause