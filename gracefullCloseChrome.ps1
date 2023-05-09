# Create an empty array to hold the results
$results = @()

# For each team, get the owners
foreach ($team in $teams) {
    $owners = Get-TeamUser -GroupId $team.GroupId -Role Owner
    foreach ($owner in $owners) {
        # Create a custom object and add it to the results
        $results += New-Object PSObject -Property @{
            'Team'  = $team.DisplayName
            'Owner' = $owner.Name
        }
    }
}

# Export the results to a CSV file
$results | Export-Csv -Path 'TeamsOwners.csv' -NoTypeInformation
