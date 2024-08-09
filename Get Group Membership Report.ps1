# VARIABLES
$SearchBase = "DC=pavel,DC=ee"
$Path = "c:\Data\groups.csv"



# DO NOT TOUCH THE CODE BELOW

Get-ADGroup -Filter * -SearchBase $SearchBase -Properties Name, Description |
    ForEach-Object {
        $members = Get-ADGroupMember -Identity $_.Name -Recursive

        $membersString = ''
        # Check if there are any members
        if ($members) {
            $memberNames = $members |
                Where-Object { $_.objectClass -eq 'user' } |
                Select-Object -ExpandProperty Name
            $membersString = $memberNames -join ','
        }

        [pscustomobject]@{
            Group       = $_.Name
            Description = $_.Description
            Members     = $membersString
        }
    } |
    ConvertTo-Csv -NoTypeInformation -Delimiter ';' |
    ForEach-Object { $_ -replace '"', '' } |
    Out-File $Path # we want to get rid of quotation marks for a cleaner view