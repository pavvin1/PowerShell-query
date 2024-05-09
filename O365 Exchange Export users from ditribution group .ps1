Install-Module -Name ExchangeOnlineManagement -AllowClobber -Force -Verbose
Import-Module ExchangeOnlineManagement
Get-InstalledModule -Name ExchangeOnlineManagement
Update-Module -Name ExchangeOnlineManagement -Verbose
Get-DistributionGroup -ResultSize Unlimited > C:\INST\groups.csv
Get-DistributionGroupMember -Identity "tooryhm@example.ee" -ResultSize Unlimited | Select Name, PrimarySMTPAddress, RecipientType > C:\INST\tooryhm.txt