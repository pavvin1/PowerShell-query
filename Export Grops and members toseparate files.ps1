$outputFolder = "C:\Data"
If (!(Test-Path $outputFolder)) {
    New-Item -ItemType Directory -Path $outputFolder | Out-Null
}

$groups = Get-ADGroup -Filter * -SearchBase "DC=pavel,DC=ee"

ForEach ($g in $groups) {

    $path = "$outputFolder\$($g.Name).csv"

    # Get group info + members into a single collection
    $rows = @()

    # Add group header info
    $groupInfo = Get-ADGroup -Identity $g.Name -Properties Description | 
                 Select-Object @{N="Type";E={"GROUP"}}, Name, Description,
                               @{N="DisplayName";E={""}}
    $rows += $groupInfo

    # Add members
    $members = Get-ADGroupMember -Identity $g.Name -Recursive | 
               Get-ADUser -Properties DisplayName, Name |
               Select-Object @{N="Type";E={"MEMBER"}}, Name, 
                             @{N="Description";E={""}}, DisplayName

    $rows += $members

    $rows | Export-Csv -Path $path -NoTypeInformation -Encoding UTF8
}
