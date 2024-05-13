$Usr = ‘USER NAME’
$Pdc = (Get-AdDomain).PDCEmulator
$ParamsEvn = @{
‘FilterXPath’ = "*[System[EventID=4740] and EventData[Data[@Name='TargetUserName']='$Usr']]"
}
$Evnts | foreach {$_.Properties[1].value + ' ' + $_.TimeCreated}