 $groups = Get-ADGroup -filter * -SearchBase "DC=pavel,DC=ee"

ForEach ($g in $groups) 

{

$path = "c:\Data\" + $g.Name + ".csv"

Get-ADGroup -Identity $g.Name -Properties * | select name,description | Out-File $path -Append

$results = Get-ADGroupMember -Identity $g.Name -Recursive | Get-ADUser -Properties displayname, name  

ForEach ($r in $results){

New-Object PSObject -Property @{       

    DisplayName = $r.displayname | Out-File $path -Append

  }

}   

} 
